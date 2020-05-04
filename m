Return-Path: <SRS0=JCNZ=6S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FF8DC3A5A9
	for <git@archiver.kernel.org>; Mon,  4 May 2020 10:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 768E52054F
	for <git@archiver.kernel.org>; Mon,  4 May 2020 10:26:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bNol9YMY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbgEDK0V (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 06:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725928AbgEDK0U (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 4 May 2020 06:26:20 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5790DC061A0E
        for <git@vger.kernel.org>; Mon,  4 May 2020 03:26:20 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id s8so9955618wrt.9
        for <git@vger.kernel.org>; Mon, 04 May 2020 03:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jrK9odMEw2g5eOSi9C2CUfYwnJmnNNIaDfjgn6gmF/A=;
        b=bNol9YMY+46zNowJYqsA0oGw3WEjA3TzUTrS+kz/lFwj8YDM0tnCRiNq0Tw2fhiEEa
         zenWLZQqoDxiBHY6ySvAs8bt7YMWLaSp3gQXX69huH6cx4tJIauvjIQuBUFLRylBxUQm
         73E1SVp8Y0qLFGvvjgKyOr8oE/C/pEr79+IqwkVxvR60MkuuO5o7rDS+A9YYIlrsF04H
         a0+/d3a6O7ELZlH5bvUVofhNmdH3fk4Rw4CaVUT9DVOdL5UQcctfqMQ79XHfVf2fE1sb
         uDG5+YpL4r+xyXJy930awWoLdAabQs6ZKZPOyceoMhJo1JH8P2Dmuu3CCl/NpeAfTM9z
         9Z6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jrK9odMEw2g5eOSi9C2CUfYwnJmnNNIaDfjgn6gmF/A=;
        b=GyjMgRSQnALHpPBWHHfONMSSx5WQjZWI8rDCo37gyLjCQlXOK2lJyF71QT5xOTMahp
         wCKWxkuDA/QqQAX32UHaY1+yyormY1nCxZHaFTKZ+7o9N4ow9/hu63ZGtFyFeS/xOyDh
         rE7/K8DIrUR9Jjt3vaYcaRjoydUxueJOca6k/tFOhsNbTJ5rAGy9MNIKqzQ6UNgcczvv
         qbcYb4bdC/Z4fh9GHT1KZp1SPEmncBR6fGy9EspFe9Cf8/piQDPcHmur/OcM9cfQcJU6
         Kk2piSJym+QbUJ7zpYprKEe03gpueSC+Sh3uB66WlbhGPk37cpfCOEAUxhbRDvG9CGVZ
         F84Q==
X-Gm-Message-State: AGi0PuZYOGjtPIE9Cndq4Svf5d5ps4gdsbnigJgnXXmwj2Qn6LQHMZwg
        bacsFZL4ZQFnSnn+Ez90XNM=
X-Google-Smtp-Source: APiQypLkeihEYQ47H/AlhVPieUSkTWxZSpJ7/UgswnZriw4J/1Le7lgwZgcdtNI1POwD5uvDrDRaWA==
X-Received: by 2002:a5d:4ac9:: with SMTP id y9mr19710922wrs.182.1588587979012;
        Mon, 04 May 2020 03:26:19 -0700 (PDT)
Received: from [192.168.0.104] (atoulouse-654-1-289-61.w86-199.abo.wanadoo.fr. [86.199.72.61])
        by smtp.gmail.com with ESMTPSA id q17sm12376097wmj.45.2020.05.04.03.26.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2020 03:26:18 -0700 (PDT)
Subject: Re: Git Stash brake splitIndex
To:     Son Luong Ngoc <sluongng@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
References: <EED2CFF1-5BEF-429D-AB99-AD148A867614@gmail.com>
From:   Alban Gruin <alban.gruin@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <dcfcdd29-976b-5c8f-190b-ac14dc0abc21@gmail.com>
Date:   Mon, 4 May 2020 12:26:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <EED2CFF1-5BEF-429D-AB99-AD148A867614@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Le 28/04/2020 à 15:19, Son Luong Ngoc a écrit :
> Hi folks,
> 
> I am on git version 2.26.2.526.g744177e7f7 (latest next)
> When you do a git stash while using splitIndex, it seems like the index will get corrupted
> 
> Using configs:
> core.splitindex=true
> splitindex.maxpercentchange=50
> splitindex.sharedindexexpire=now
> 
> Reproduce steps:
> 
> mkdir repo
> cd repo && git init
> echo a > a
> commit -a -m 'add a'
> echo b > b
> git add b
> git stash
> Saved working directory and index state WIP on master: 1955b62 add a
> fatal: .git/sharedindex.8ddd8dad6ccb4858f27d4ff20f4d8bf6654441e0: index file open failed: No such file or directory
> 
> Some traces:
> master ~/test/git/repo> GIT_TRACE2=1 GIT_TRACE2_NESTING=5 git stash
> 15:18:15.442295 common-main.c:48                  version 2.26.2.526.g744177e7f7
> 15:18:15.442914 common-main.c:49                  start git stash
> 15:18:15.443284 repository.c:134                  worktree /Users/sluongngoc/test/git/repo
> 15:18:15.443491 git.c:442                         cmd_name stash (stash)
> 15:18:15.448579 run-command.c:735                 child_start[0] git update-index --ignore-skip-worktree-entries -z --add --remove --stdin
> 15:18:15.455972 common-main.c:48                  version 2.26.2.526.g744177e7f7
> 15:18:15.456514 common-main.c:49                  start /Users/sluongngoc/libexec/git-core/git update-index --ignore-skip-worktree-entries -z --add --remove --stdin
> 15:18:15.456788 repository.c:134                  worktree /Users/sluongngoc/test/git/repo
> 15:18:15.456927 git.c:442                         cmd_name update-index (stash/update-index)
> 15:18:15.458444 git.c:672                         exit elapsed:0.004021 code:0
> 15:18:15.458457 trace2/tr2_tgt_normal.c:123       atexit elapsed:0.004039 code:0
> 15:18:15.458774 run-command.c:990                 child_exit[0] pid:1813 code:0 elapsed:0.010169
> Saved working directory and index state WIP on master: 1955b62 add a
> 15:18:15.461082 run-command.c:735                 child_start[1] git reset --hard -q --no-recurse-submodules
> 15:18:15.467260 common-main.c:48                  version 2.26.2.526.g744177e7f7
> 15:18:15.467553 common-main.c:49                  start /Users/sluongngoc/libexec/git-core/git reset --hard -q --no-recurse-submodules
> 15:18:15.467931 repository.c:134                  worktree /Users/sluongngoc/test/git/repo
> 15:18:15.468071 git.c:442                         cmd_name reset (stash/reset)
> 15:18:15.468555 usage.c:64                        error .git/sharedindex.8ddd8dad6ccb4858f27d4ff20f4d8bf6654441e0: index file open failed: No such file or directory
> fatal: .git/sharedindex.8ddd8dad6ccb4858f27d4ff20f4d8bf6654441e0: index file open failed: No such file or directory
> 15:18:15.468587 usage.c:68                        exit elapsed:0.002714 code:128
> 15:18:15.468595 trace2/tr2_tgt_normal.c:123       atexit elapsed:0.002726 code:128
> 15:18:15.468889 run-command.c:990                 child_exit[1] pid:1814 code:128 elapsed:0.007797
> 15:18:15.468930 git.c:672                         exit elapsed:0.028400 code:1
> 15:18:15.468947 trace2/tr2_tgt_normal.c:123       atexit elapsed:0.028418 code:1
> exit 1
> 

Thank you for the bug report.

Looking at git-stash.c, it uses a second index, which is sometimes a
copy of the first.  At least, it's the case in stash_working_tree(),
used by `git stash': in do_create_stash(), &info->i_tree is created to
save the content of the index, then save_untracked_files() is skipped as
we did not call stash with the `--include-untracked' switch, then
stash_working_tree() is called as we are not in patch mode.  Here, the
index did not change.  stash_working_tree() then unpacks &info->i_tree
in a second index.

After this, `git update-index' is called, which modifies the second
index.  This is not a problem in the non-split-index case, because both
index are stand alone; they can be modified without interfering with the
other.  But not in the split-index case -- as the second is a copy of
the first one, and they both point to the same shared index file.
Modifying the second will delete this file (as the expiration is set to
"now") and create another one.  So, anything using the first index will
try to open a file that no longer exists, and crash.

Here, `git reset' crashes (in do_create_stash(), after
stash_working_tree() returned), but adding a `discard_cache();
read_cache();' after running `update-index' (in stash_working_tree())
makes it crash at `read_cache();'.

Your configuration is a bit extreme, but I worry that it may happen with
`splitindex.sharedindexexpire' set to a higher value, albeit much less
frequently.

This double-index thing came from the shell script, perhaps it's about
time to remove it.  I worked on a series to remove it this week-end, and
it fixes this crash.  I still have to write the commit messages, then I
will send it to the list.

> Cheers,
> Son Luong.
> 

Cheers,
Alban

