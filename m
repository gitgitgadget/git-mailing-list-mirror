From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: [PATCH] Accept dates before 2000/01/01 when specified as seconds 
 since the epoch
Date: Wed, 06 Jun 2007 12:42:53 +0200
Organization: eudaptics software gmbh
Message-ID: <46668FAD.73D1B73F@eudaptics.com>
References: <11811175153355-git-send-email-johannes.sixt@telecom.at> <7vtztl5vvb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 06 13:18:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvtWh-0003Po-E4
	for gcvg-git@gmane.org; Wed, 06 Jun 2007 13:18:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751610AbXFFLSE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jun 2007 07:18:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758645AbXFFLSE
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jun 2007 07:18:04 -0400
Received: from main.gmane.org ([80.91.229.2]:37454 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751610AbXFFLSB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2007 07:18:01 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HvtE8-0001Rl-Ry
	for git@vger.kernel.org; Wed, 06 Jun 2007 12:58:57 +0200
Received: from cm56-163-160.liwest.at ([86.56.163.160])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 06 Jun 2007 12:58:56 +0200
Received: from J.Sixt by cm56-163-160.liwest.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 06 Jun 2007 12:58:56 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cm56-163-160.liwest.at
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49284>

Junio C Hamano wrote:
> 
> I vaguely recall hitting the same issue soon after date.c was
> done, and sending in a patch in the same spirit but with
> different implementation (I essentially duplicated that "seconds
> since epoch" without any cutoff as the last ditch fallback) long
> time ago (this was before I took git over; the patch was rejected).
> 
> It almost makes me wonder if it is better to introduce a special
> syntax to denote "seconds since epoch plus timezone offset" for
> our Porcelain use, instead of keeping this arbitrary cut-off
> date which nobody can agree on and which forces us to roll back
> from time to time.  For one thing, such a syntax would allow us
> to talk about a timestamp before the epoch.
> 
> Perhaps
> 
>         "epoch" [-+] [0-9]+ " " [-+][0-9][0-9][0-9][0-9]
> 
> ?

OTOH, the previous limit 2000/01/01 was completely arbitrary, while the
new limit 100000000secs has some justification: Numbers with fewer
digits could be mistaken as dates.

-- Hannes
