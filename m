From: =?utf-8?q?=E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=81=AA=E3=81=93?= 
	<nanako3@bluebottle.com>
Subject: Re: [PATCH 2/2] git-gc: skip stashes when expiring reflogs
Date: Fri, 13 Jun 2008 12:45:07 +0900
Message-ID: <200806130345.m5D3jjPE011619@mi0.bluebottle.com>
References: <7vhcbyz5pp.fsf@gitster.siamese.dyndns.org>
	<OLvkESB0JjBNs9kF8Q2M5UFNBJqq4FjbgGeQVyWstGwcXqCOq16_oomM0y-utOBbV7BnndyrICE@cipher.nrlssc.navy.mil>
	<5vuJsx6Kidj7e8EABk_d63dLAYuWF-S880RrJKu83cJo_ejU3VN-VA@cipher.nrlssc.navy.mil>
	<20080611213648.GA13362@glandium.org>
	<alpine.DEB.1.00.0806112242370.1783@racer>
	<20080611230344.GD19474@sigill.intra.peff.net>
	<alpine.LFD.1.10.0806111918300.23110@xanadu.home>
	<loom.20080612T042942-698@post.gmane.org>
	<6413041E-A64A-4BF4-9ECF-F7BFA5C1EAEF@wincent.com>
	<7vzlpqza0t.fsf@gitster.siamese.dyndns.org>
	<tTKBrUhaELJElLgsC8Wvr60D-bMFtfyvc87q5ZYW35M@cipher.nrlssc.navy.mil>
	<7vhcbyz5pp.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Brandon Casey <casey@nrlssc.navy.mil>,
	Wincent Colaiuta <win@wincent.com>,
	Eric Raible <raible@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Nicolas Pitre <nico@cam.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 13 05:47:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K70Fq-0005ih-Nd
	for gcvg-git-2@gmane.org; Fri, 13 Jun 2008 05:47:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757518AbYFMDpr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2008 23:45:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757501AbYFMDpr
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jun 2008 23:45:47 -0400
Received: from mi0.bluebottle.com ([206.188.25.15]:57678 "EHLO
	mi0.bluebottle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757491AbYFMDpq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2008 23:45:46 -0400
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by mi0.bluebottle.com (8.13.1/8.13.1) with ESMTP id m5D3jjPE011619
	for <git@vger.kernel.org>; Thu, 12 Jun 2008 20:45:45 -0700
DomainKey-Signature: a=rsa-sha1; s=mail; d=bluebottle.com; c=nofws; q=dns;
	h=received:from:to:cc:subject:date:in-reply-to:references:
	mime-version:content-type:content-transfer-encoding:x-trusted-delivery;
	b=XoTixprx11+tGSdg8k36TJsSGNW8LOt4PJtXO35Ghg/CxEEcCg2otZk7AO1DLIFkY
	pJQJVKGFvsFFkZDZDRQVjgtI0Bucy/zVhPOtH85IuAXPVd3nsorErQK+m9pCQhj
Received: from nanako3.mail.bluebottle.com ([212.62.97.20])
	(authenticated bits=0)
	by fe1.bluebottle.com (8.13.1/8.13.1) with ESMTP id m5D3jK76002072
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 12 Jun 2008 20:45:25 -0700
In-Reply-To: <7vhcbyz5pp.fsf@gitster.siamese.dyndns.org>
X-Trusted-Delivery: <28edde1563ffebcf217b48d62acf6865>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84825>

Quoting Junio C Hamano <gitster@pobox.com>: writes:

> Brandon Casey <casey@nrlssc.navy.mil> writes:
>
>> The fact that this caveat is not mentioned anywhere in the stash
>> documentation or anywhere in the commit log related to git-stash.sh makes
>> me think that this idea of 'a limited amount of time' was possibly not a
>> design decision but merely a side effect of stashes being implemented using the
>> reflog. Of course I didn't pay any attention to the discussions about stash
>> back when it was implemented, so I may definitely be wrong.
>
> I do not deeply care either way, but perhaps
>
>  http://thread.gmane.org/gmane.comp.version-control.git/50737/focus=50863 
>
> and yes use of reflog was more or less conscious thing and the mechanism
> is very much temporary in nature (see the use case stated in the starting
> thread).

After reading the thread, I reread the manual page.

I agree with some people that it would be nicer if the documentation
spelled out the temporary nature of the stashed states better.

-- 8< -- (^_^) -- >8 --

Improved git-stash documentation

The examples in the manual talk temporary operation but it is not a strong
enough hint that the stashed states are temporary in nature and designed
to be automatically pruned away when gc runs.

Signed-off-by: Nanako Shiraishi <nanako3@bluebottle.com>
---

 Documentation/git-stash.txt |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index baa4f55..65f6af7 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -14,10 +14,11 @@ SYNOPSIS
 DESCRIPTION
 -----------
 
-Use 'git-stash' when you want to record the current state of the
-working directory and the index, but want to go back to a clean
-working directory.  The command saves your local modifications away
-and reverts the working directory to match the `HEAD` commit.
+`git-stash` records the current state of the work tree and the index, and
+reverts them to the state after freshly checking out the current commit.
+You can temporarily switch to work on something different, and once you
+finished handling the emergency, you can come back to the state before you
+were interrupted.
 
 The modifications stashed away by this command can be listed with
 `git-stash list`, inspected with `git-stash show`, and restored
@@ -84,6 +85,9 @@ longer apply the changes as they were originally).
 clear::
 	Remove all the stashed states. Note that those states will then
 	be subject to pruning, and may be difficult or impossible to recover.
+	Old stashed states are also pruned automatically when
+	linkgit:git-gc[1] prunes old reflog (see linkgit:git-reflog[1])
+	entries.
 
 drop [<stash>]::
 

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/

----------------------------------------------------------------------
Get a free email address with REAL anti-spam protection.
http://www.bluebottle.com/tag/1
