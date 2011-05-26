From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PULL svn-fe/maint] t0081-*.sh: Fix failure of the 'long read' tests
Date: Wed, 25 May 2011 23:33:35 -0500
Message-ID: <20110526043335.GB17479@elie>
References: <4DB70972.20308@ramsay1.demon.co.uk>
 <20110426234850.GC32491@sigill.intra.peff.net>
 <4DBC45F9.7090804@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Jeff King <peff@peff.net>,
	GIT Mailing-list <git@vger.kernel.org>,
	David Barr <david.barr@cordelta.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 26 06:34:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPSGo-0007pZ-KS
	for gcvg-git-2@lo.gmane.org; Thu, 26 May 2011 06:34:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751234Ab1EZEdu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2011 00:33:50 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:34624 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751206Ab1EZEdr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2011 00:33:47 -0400
Received: by iwn34 with SMTP id 34so266445iwn.19
        for <git@vger.kernel.org>; Wed, 25 May 2011 21:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=dXn7fD6E2uIuTlcQ1E5XsaQ4c5Fi9xIGg4PoYqgFplA=;
        b=JnlPTNe7/eC8f0AvCJcklGaGqOAcLP3Hg1DR+G+KiZRO6UitpvLtXUmnmS6CHbJ/u0
         47Um5OcjZH5KGGboGA/2l4b7Qf+izugfSnG2tBq0fjaiBiOOhKlqVWSBuKrnXCGwX87m
         uo4Q3QLmGhxjdsChQ6+yPULYvMR/6teNA836w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=vy1yirRyTNQXMJStLWcZL/m6jdBPjSIy6hnhYX5vgIzwDqxqIvhl1nsfLEj4CT4JXo
         2el5IyIgsP0Ka4yqKcOLkf+q/1pMxLYmZooZ55opOjmLE1sLGjujn6XqbPGpgXaBF5DV
         C+iSdMwm1HFAeRBE7bPICg1zWUA56vEwPRQ2A=
Received: by 10.42.243.7 with SMTP id lk7mr519658icb.191.1306384424598;
        Wed, 25 May 2011 21:33:44 -0700 (PDT)
Received: from elie (adsl-69-209-65-98.dsl.chcgil.ameritech.net [69.209.65.98])
        by mx.google.com with ESMTPS id w5sm264810icv.4.2011.05.25.21.33.41
        (version=SSLv3 cipher=OTHER);
        Wed, 25 May 2011 21:33:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4DBC45F9.7090804@ramsay1.demon.co.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174493>

Hi,

Ramsay Jones wrote:

> So, the patch is correct, but (apart from the last sentence) the
> commit message is *absolute rubbish*. I won't bore you with the
> details of my lunacy! :-P
>
> However, I much prefer Jonathan's patch which removes this test
> completely!

Junio, please pull

  git://repo.or.cz/git/jrn.git svn-fe-maint

to receive the following fix.  The patch first visited the list two
months ago[1] and was discussed again last month[2] and seems to have
been well liked both times (well, I know I like it).

The tests it removes

 - are missing an EXECKEEPSPID prerequisite on Windows
 - use a : $((i = i + 1)) construct which does not seem to be portable
   to old versions of dash
 - are pointless, an eyesore, and a pain to maintain

What was the author thinking?  Sorry to let this sit for so long.  

Jonathan Nieder (1):
      Revert "t0081 (line-buffer): add buffering tests"

 t/t0081-line-buffer.sh |  106 +-----------------------------------------------
 1 files changed, 2 insertions(+), 104 deletions(-)

[1] http://thread.gmane.org/gmane.comp.version-control.git/170307/focus=170365
[2] http://thread.gmane.org/gmane.comp.version-control.git/172120/focus=172523
