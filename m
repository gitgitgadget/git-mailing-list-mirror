From: Sam Vilain <sam@vilain.net>
Subject: Re: [PATCH] Accept dates before 2000/01/01 when specified as seconds
 since the epoch
Date: Thu, 07 Jun 2007 17:09:52 +1200
Message-ID: <46679320.6000309@vilain.net>
References: <11811175153355-git-send-email-johannes.sixt@telecom.at> <7vtztl5vvb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 07 07:10:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwAGi-0000u4-6g
	for gcvg-git@gmane.org; Thu, 07 Jun 2007 07:10:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756117AbXFGFKN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Jun 2007 01:10:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754801AbXFGFKM
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jun 2007 01:10:12 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:37596 "EHLO
	magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936381AbXFGFKD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2007 01:10:03 -0400
Received: by magnus.utsl.gen.nz (Postfix, from userid 65534)
	id ECB9C1574B8; Thu,  7 Jun 2007 17:10:00 +1200 (NZST)
Received: from [192.168.2.22] (leibniz.catalyst.net.nz [202.78.240.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by magnus.utsl.gen.nz (Postfix) with ESMTP id 89A7513A4EA;
	Thu,  7 Jun 2007 17:09:56 +1200 (NZST)
User-Agent: Thunderbird 1.5.0.10 (X11/20070307)
In-Reply-To: <7vtztl5vvb.fsf@assigned-by-dhcp.cox.net>
X-Enigmail-Version: 0.94.2.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.magnus.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49351>

Junio C Hamano wrote:
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
> 	"epoch" [-+] [0-9]+ " " [-+][0-9][0-9][0-9][0-9]

Probably a good idea, though it would break cg-admin-rewritehist.  I had
to make a similar change when working with the Perl history.  Perhaps
allow both?

There is a 10 digit ISO forms (YYYYMMDDHH) and a 9 digit form
(YYYYDDDHH), but these are very rare :)

Sam.
