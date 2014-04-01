From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: What's cooking in git.git (Mar 2014, #08; Mon, 31)
Date: Tue, 1 Apr 2014 07:53:37 +0700
Message-ID: <CACsJy8A9b2eccm_BJMjW5RwWLux90xs7HfUQEn0_jrzhHWeajQ@mail.gmail.com>
References: <xmqqppl128q8.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 01 02:54:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WUmxy-0001hZ-Ew
	for gcvg-git-2@plane.gmane.org; Tue, 01 Apr 2014 02:54:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751186AbaDAAyJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Mar 2014 20:54:09 -0400
Received: from mail-qc0-f181.google.com ([209.85.216.181]:45568 "EHLO
	mail-qc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751095AbaDAAyI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Mar 2014 20:54:08 -0400
Received: by mail-qc0-f181.google.com with SMTP id e9so9962002qcy.12
        for <git@vger.kernel.org>; Mon, 31 Mar 2014 17:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=jRRTNMeGTrotkTOqdzL4MCM/u6AP3TmYV/KelKKt1V8=;
        b=gAoeuPTquyOGdhXeQ0BMNE9kXTNycxR4s1wJMVhA8YG1OabuMbbFKNSA9BEXPr/XTD
         s/Tdisc/UQfB/F30hzIN2Gz50bYSwG6/RvaNVkbMCJP9ptn1aS+t+WwJ64tzXoWupi4F
         7bn6UhSoW4H6jsN1N0Wsf5s11Qumejy6xDstd9NLvh1qmuX0Eim2wRZpT+sEDyypDkes
         nsJ1DmWi/w8XwxtFzTLTioz70CBdeCIAralzz3Lew+VYeYaBJkU0pKzpqs7rNbPGY7aw
         m29oVQeGmpkvM1J2Hoj7Bxb4hHJQ9Fp+AStB51kqMsx1eVPnU319fAs/sNdNshmDI4NR
         S7UQ==
X-Received: by 10.224.112.6 with SMTP id u6mr11263719qap.78.1396313647366;
 Mon, 31 Mar 2014 17:54:07 -0700 (PDT)
Received: by 10.96.103.166 with HTTP; Mon, 31 Mar 2014 17:53:37 -0700 (PDT)
In-Reply-To: <xmqqppl128q8.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245570>

On Tue, Apr 1, 2014 at 7:29 AM, Junio C Hamano <gitster@pobox.com> wrote:
> * nd/multiple-work-trees (2014-03-25) 28 commits
>  - count-objects: report unused files in $GIT_DIR/repos/...
>  - gc: support prune --repos
>  - gc: style change -- no SP before closing bracket
>  - prune: strategies for linked checkouts
>  - checkout: detach if the branch is already checked out elsewhere
>  - checkout: clean up half-prepared directories in --to mode
>  - checkout: support checking out into a new working directory
>  - use new wrapper write_file() for simple file writing
>  - wrapper.c: wrapper to open a file, fprintf then close
>  - setup.c: support multi-checkout repo setup
>  - setup.c: detect $GIT_COMMON_DIR check_repository_format_gently()
>  - setup.c: convert check_repository_format_gently to use strbuf
>  - setup.c: detect $GIT_COMMON_DIR in is_git_directory()
>  - setup.c: convert is_git_directory() to use strbuf
>  - git-stash: avoid hardcoding $GIT_DIR/logs/....
>  - *.sh: avoid hardcoding $GIT_DIR/hooks/...
>  - git-sh-setup.sh: use rev-parse --git-path to get $GIT_DIR/objects
>  - $GIT_COMMON_DIR: a new environment variable
>  - commit: use SEQ_DIR instead of hardcoding "sequencer"
>  - fast-import: use git_path() for accessing .git dir instead of get_git_dir()
>  - reflog: avoid constructing .lock path with git_path
>  - *.sh: respect $GIT_INDEX_FILE
>  - git_path(): be aware of file relocation in $GIT_DIR
>  - path.c: group git_path(), git_pathdup() and strbuf_git_path() together
>  - path.c: rename vsnpath() to do_git_path()
>  - git_snpath(): retire and replace with strbuf_git_path()
>  - path.c: make get_pathname() call sites return const char *
>  - path.c: make get_pathname() return strbuf instead of static buffer
>
>  A replacement for contrib/workdir/git-new-workdir that does not
>  rely on symbolic links and make sharing of objects and refs safer
>  by making the borrowee and borrowers aware of each other.
>
>  What is the doneness of this thing?  I remember reading it through
>  once and sent review comments on earlier parts, but have there been
>  a lot of discussions on this topic?

The basic support is there. Some bells and whistles (e.g. listing
checkouts) are not, but we can add them when we see the needs. Eric
and Torsten helped review but no, there hasn't much discussion about
it, which may be because it's already perfect, or people are not
interested. Unfortunately, this multiple checkout thing conflicts with
how I use emacs (--daemon) so I'm not one of its heavy users either. I
only occastionally make new, short-lived checkouts to test things.
-- 
Duy
