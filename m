From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] Sanitize for_each_reflog_ent()
Date: Tue, 9 Jan 2007 10:57:58 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701091056520.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0701080158500.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vr6u6z3x8.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0701081316110.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <enumq8$oa$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 09 10:58:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4Dk5-0001jg-Ab
	for gcvg-git@gmane.org; Tue, 09 Jan 2007 10:58:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751230AbXAIJ6B (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 04:58:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751245AbXAIJ6B
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 04:58:01 -0500
Received: from mail.gmx.net ([213.165.64.20]:54646 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751230AbXAIJ6A (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 04:58:00 -0500
Received: (qmail invoked by alias); 09 Jan 2007 09:57:58 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp046) with SMTP; 09 Jan 2007 10:57:58 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <enumq8$oa$1@sea.gmane.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36336>

Hi,

On Tue, 9 Jan 2007, Jakub Narebski wrote:

> Johannes Schindelin wrote:
> 
> > On Sun, 7 Jan 2007, Junio C Hamano wrote:
> > 
> >> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >> 
> >>> Further, it makes no sense to force the parsing upon the helper
> >>> functions; for_each_reflog_ent() now calls the helper function with
> >>> old and new sha1, the email, the timestamp & timezone, and the message.
> >> 
> >> Perhaps.  I did it that way deliberately because all existing
> >> users did not have to pay overhead of parsing.
> > 
> > My reasoning is that invalid entries should rather be ignored than be 
> > taken into account. So, to verify that you are not walking invalid data, 
> > you have to parse it anyway.
> 
> I think that Junio was talking about the fact, that if you for example
> do need only refname and sha1, there is no need to parse object at all.
> If you don't need to, don't parse.

And it was exactly what _I_ was talking about, too:

if there are invalid entries, you ignore them. So for example, if there is 
no timestamp and message, you don't want the osha1 or nsha1, because it is 
an _invalid_ record.

Ciao,
Dscho
