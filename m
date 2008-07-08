From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v2 2/4] Add git-sequencer prototype documentation
Date: Tue, 8 Jul 2008 12:37:50 +0200
Message-ID: <200807081237.51456.jnareb@gmail.com>
References: <1214879914-17866-3-git-send-email-s-beyer@gmx.net> <1215277204-20926-1-git-send-email-s-beyer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Tue Jul 08 12:39:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGAb7-00027j-5q
	for gcvg-git-2@gmane.org; Tue, 08 Jul 2008 12:39:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754179AbYGHKiC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2008 06:38:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754098AbYGHKiB
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jul 2008 06:38:01 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:60532 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753871AbYGHKiA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2008 06:38:00 -0400
Received: by ug-out-1314.google.com with SMTP id h2so1184780ugf.16
        for <git@vger.kernel.org>; Tue, 08 Jul 2008 03:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=cTTLdyoSSdDqpD/aWNGAZbLish3exx2JyFRYzJHZR6U=;
        b=JYgZapW5eqkL1zKrm9aOj07U1ShwbmGXkbrRMTDRPVBEbGyVtnFhclYWDG5tfL2R+M
         segK8kU/vutQEzIcIyuDVe0292CoEtC2RwJKR9RZw62eS3fGg75Rq7b6br5REl5SFGvf
         9w0REGQ8u5Ri+y7dK+VLTuOZk+WaaTidiYBg8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=OtDPAQgYhqEnyqxzWHNyb9dkOc8LaJrY2gYqwJqSHhXAtkHM9YwGUfaT7ypOHX7/Og
         Hd1UW/CmWLv+NAm31OH36GkgSsY7AUCuXaQzc3H04gruYNOrGY8Vs85siZMcAeFyvOz4
         i4ebYUkbtMvuhrIsqX5AhXT7P5Njg5vcc99+M=
Received: by 10.67.26.7 with SMTP id d7mr5255428ugj.44.1215513477334;
        Tue, 08 Jul 2008 03:37:57 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.205.145])
        by mx.google.com with ESMTPS id m1sm9864291uge.17.2008.07.08.03.37.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 08 Jul 2008 03:37:55 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1215277204-20926-1-git-send-email-s-beyer@gmx.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87743>

On Sat, 5 July 2008, Stephan Beyer wrote:

> +git-sequencer(1)

> +TODO FILE FORMAT

> +edit <commit>::
> +mark <mark>::
> +merge [options] <commit-ish1> <commit-ish2> ... <commit-ishN>::
> +pick [options] <commit>::
> +patch [options] <file>::
> +pause::
> +ref <ref>::
> +reset <commit-ish>::
> +squash [options] <commit>::
> +squash [options] --from <mark>::

A few comments and ideas:

1. Splitting a patch

I cannot comment well on git-sequencer, as I have started using
StGIT patch management interface instead of git-rebase in times when
there were no "git rebase --interactive".  Nevertheless working with
StGIT is a bit similar to working with interactive rebase...

I don't find myself wanting to join two patches into one (to squadh
a commit) perhaps because when I want to add something to a commit
(to a patch) I simply go to this patch, edit files, and refresh the
patch.  From time to time however I find myself SPLITTING a patch,
for example extracting something added "by the way"/"while at it"
into separate commit (like late separate better documenting
project_index file format from adding optional description field
to project_index file format).

Currently I don't see easy way to do this with git-sequencer.


2. Patch based rebase

git-rebase by default, and for speed, uses git-format-patch / git-am
pipeline (utilizing '--rebasing' option to git-am to avoid changing
commit messages, even if they do not follow commit message conventions).
If you want for plain "git rebase" to use git-sequencer, it should be
easy to support this "engine"; therefore perhaps it would be good
to add some equivalent of "git format-patch" to the TODO file format.


3. Checking rebase

Usually when you are interacting with upstream by sending patches by
email, the last part before sending series of patches is git-rebase
on top of current work.  It would be nice if there were some way to
have "git rebase" (via git-sequencer) to check that all commits
(perhaps with some explicitly stated in TODO file exceptions) passes
pre-commit hook (checking for whitespaces and conflict markers), and
if possibly also either test suite, or relevant parts of test suite.

So perhaps extending TODO format by "check <script>" or
"check-all <script>"?


I'm just not sure if it is worth adding to TOD file format...
-- 
Jakub Narebski
Poland
