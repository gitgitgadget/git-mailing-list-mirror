From: lists@haller-berlin.de (Stefan Haller)
Subject: rev-list --cherry-pick and context lines
Date: Fri, 2 Sep 2011 12:35:20 +0200
Message-ID: <1k6yux4.x1kexb19bkrqpM%lists@haller-berlin.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 02 13:14:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QzRhi-0001Eb-I2
	for gcvg-git-2@lo.gmane.org; Fri, 02 Sep 2011 13:14:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933447Ab1IBLO3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Sep 2011 07:14:29 -0400
Received: from mail.ableton.net ([62.96.12.117]:41272 "EHLO mail.ableton.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933431Ab1IBLO2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Sep 2011 07:14:28 -0400
X-Greylist: delayed 2348 seconds by postgrey-1.27 at vger.kernel.org; Fri, 02 Sep 2011 07:14:28 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=haller-berlin.de; s=mail_2009081900;
	h=Message-ID:Date:From:Subject:To; bh=+KWrXHQU0c++esYyP4zMuAy3ijUf7fxMRA0WGfbNXc4=;
	b=cRdAKpDaaOIoOTXBjzdLlp8UqePVN5Rwrbn3htJMe2t75j2cO9T+HzzMRLe+hfNwlilFNf+Q3TEl++uLQtcpYfjJIifnhNPiTYS7ZDM9xscBjI0yfurKAYSII/KeYGmmXjjoxzr9Jvssl438bEYJi6hkWL+wPMv1lpVoC7o+mHc=;
Received: from macbook-stk.office.ableton.com ([10.1.12.116])
	by mail.ableton.net with esmtpsa (SSLv3:AES128-SHA:128)
	(Exim 4.76)
	(envelope-from <lists@haller-berlin.de>)
	id 1QzR5i-0003wn-Se
	for git@vger.kernel.org; Fri, 02 Sep 2011 12:35:18 +0200
User-Agent: MacSOUP/2.8.3 (Mac OS X version 10.6.8 (x86))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180606>

Consider two commits on different branches, one with this patch:

    diff --git a/file.txt b/file.txt
    index 704fa27..2f7e74c 100644
    --- a/file.txt
    +++ b/file.txt
    @@ -1,3 +1,3 @@
     old_context
     
    -foo
    +bar

and the other with this patch:

    diff --git a/file.txt b/file.txt
    index f35051b..8c7de32 100644
    --- a/file.txt
    +++ b/file.txt
    @@ -1,3 +1,3 @@
     new_context
     
    -foo
    +bar

If I run "git rev-list --cherry-pick --left-right branch1...branch2", it
reports both commits as being genuine commits on their respective
branch, even though I consider their patches to be the same.

I guess for my purpose I would like to have patch-ids that ignore
context (or that use only one line of context, I'm not sure which).

In fact, if I do "git show <commit> -U1 | git patch-id", both commits
show the same id.

So, would it make sense to have a parameter for git-rev-list (and
git-cherry) that lets you specify how much context to be used for the
patch ids?


-- 
Stefan Haller
Berlin, Germany
http://www.haller-berlin.de/
