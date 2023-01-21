Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A45AEC27C76
	for <git@archiver.kernel.org>; Sat, 21 Jan 2023 10:24:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbjAUKYk (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Jan 2023 05:24:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjAUKYj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Jan 2023 05:24:39 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9660A47EE0
        for <git@vger.kernel.org>; Sat, 21 Jan 2023 02:24:10 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id mp20so19650192ejc.7
        for <git@vger.kernel.org>; Sat, 21 Jan 2023 02:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tTVyQws11fWZge1rgbkBXmSBo5Ys0q1tPZWxTZdTiFk=;
        b=qub3dUF9kvs8dyZVXX3VJSRDWTcSMfKSHRu9xjWNC+4hemJqtVbjI+nuPzbD+9OH5k
         vZDsKcOQodzwLIfVgnDIG4rpIazZN6dGrzYIBkZX5IvpXB36KKKJxg4azhsO1hrsPWBz
         4J93sKaSy3+hJn0lxL4Bf/i9H8WbKVN/B79mW5Nw4E9dw9Xe2M9/PRYHWIZO4W6xqzuk
         HWEMlnjNFpELT5Q4RtEfbJPV1QqnFYZmQrEmx9w1IeMlIiYl+uNDrLbuVvr3pCHNKXVX
         uNQO3zSTt90WGn2GCId9eTH2An3RWy/9aiHXPU5PK/LTNSBASPvNem5kgmklJuo89iCd
         kXPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tTVyQws11fWZge1rgbkBXmSBo5Ys0q1tPZWxTZdTiFk=;
        b=lx2nfoyuS2KehKwRvxV6tZmxDcVJt5okxO5DGahD6Kp17LNm309zmKt3mc2tN1bhzD
         bFEIwAAoetGqvdII0LL2kmY0bjyGWcavgWlqdIn4yI5UTJBXvoOnnlXiSJ55GedhLvBJ
         hnwlG67KX6dqTAWOMGaGUPZYsCbnjAhknV5AvDr52Bi4DCXeO3VGZ6wp5SifjbUcxDYs
         0yikFSaHNGvO+1KFLqJOrWh7qza/kDnWdT50ksXHon+IdlyB3mn7gVNRufz435w1SNAX
         rwev8SsYmhh4pEcyVtNF1bCkqSBfFgS0f2NFCE1lkIlpeJ+fUfDvhcswdl1zY5Y9mTpT
         qAOA==
X-Gm-Message-State: AFqh2kpfqceCtqjrrRWcWdUik5aSFset0v/gLNGvxTHZQtHt7prnR+ap
        +8mFuu7Yrf+XaTzAxW10j2g=
X-Google-Smtp-Source: AMrXdXuVzpYfv4Pj6iRcpdSPpf6/BxcA1JuIwb3bghfx2moiDcCWdmpjj0ecNGgt1tz2Jc7xL845hA==
X-Received: by 2002:a17:907:b68a:b0:86f:724b:726c with SMTP id vm10-20020a170907b68a00b0086f724b726cmr20393137ejc.59.1674296647552;
        Sat, 21 Jan 2023 02:24:07 -0800 (PST)
Received: from localhost (62-165-236-34.pool.digikabel.hu. [62.165.236.34])
        by smtp.gmail.com with ESMTPSA id m20-20020a056402431400b0049ef70a2894sm1183586edc.38.2023.01.21.02.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jan 2023 02:24:06 -0800 (PST)
Date:   Sat, 21 Jan 2023 11:23:55 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff Hostetler <jeffhostetler@github.com>, edecosta@mathworks.com,
        git@vger.kernel.org
Subject: Re: [CI]: Is t7527 known to be flakey?
Message-ID: <20230121102355.GA2155@szeder.dev>
References: <xmqqtu0lzzn2.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqtu0lzzn2.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 19, 2023 at 06:52:01PM -0800, Junio C Hamano wrote:
> The said test failed its linux-musl job in its first attempt, but
> re-running the failed job passed.
> 
>     https://github.com/git/git/actions/runs/3963948890/jobs/6792356234
>     (seen@e096683 attempt #1 linux-musl)
> 
>     https://github.com/git/git/actions/runs/3963948890/jobs/6792850313
>     (seen@e096683 attempt #2 linux-musl)

t7527 is quite slow, even with the right selection of test cases, but
this little tweak makes it much faster:

  diff --git a/t/t7527-builtin-fsmonitor.sh b/t/t7527-builtin-fsmonitor.sh
  index 0e497ba98d..4210ef644c 100755
  --- a/t/t7527-builtin-fsmonitor.sh
  +++ b/t/t7527-builtin-fsmonitor.sh
  @@ -676,7 +676,10 @@ test_expect_success 'cleanup worktrees' '
   # cause incorrect results when the untracked-cache is enabled.
   
   test_lazy_prereq UNTRACKED_CACHE '
  -	git update-index --test-untracked-cache
  +	# This check takes a very long time, but I know it works on
  +	# my system, so let's fake it.
  +	#git update-index --test-untracked-cache
  +	true
   '
   
   test_expect_success 'Matrix: setup for untracked-cache,fsmonitor matrix' '

This with the right selection of test cases makes --stress
practicable, and the test tends to fail after a handful of
repetitions:

  ./t7527-builtin-fsmonitor.sh --stress -r 8,23-58

I saw different failures in multiple test cases, e.g.:

Unexpected output in case 55:

  expecting success of 7527.55 'Matrix[uc:true][fsm:true] move_directory_contents_deeper': 
  		matrix_clean_up_repo &&
  		$fn &&
  		if test $uc = false && test $fsm = false
  		then
  			git status --porcelain=v1 >.git/expect.$fn
  		else
  			git status --porcelain=v1 >.git/actual.$fn &&
  			test_cmp .git/expect.$fn .git/actual.$fn
  		fi
  	
  + matrix_clean_up_repo
  + git reset --hard HEAD
  HEAD is now at 1d1edcb initial
  + git clean -fd
  + move_directory_contents_deeper
  + mkdir T1/_new_
  + mv T1/F1 T1/F2 T1/T2 T1/_new_
  + test true = false
  + git status --porcelain=v1
  error: read error: Connection reset by peer
  error: could not read IPC response
  + test_cmp .git/expect.move_directory_contents_deeper .git/actual.move_directory_contents_deeper
  + test 2 -ne 2
  + eval diff -u "$@"
  + diff -u .git/expect.move_directory_contents_deeper .git/actual.move_directory_contents_deeper
  --- .git/expect.move_directory_contents_deeper	2023-01-21 09:47:12.677410349 +0000
  +++ .git/actual.move_directory_contents_deeper	2023-01-21 09:47:14.045448573 +0000
  @@ -7,3 +7,4 @@
    D T1/T2/T3/T4/F1
    D T1/T2/T3/T4/F2
   ?? T1/_new_/
  +?? dir1
  error: last command exited with $?=1
  not ok 55 - Matrix[uc:true][fsm:true] move_directory_contents_deeper

SIGPIPE in 'git status' cases 42, 43 and 55:

  expecting success of 7527.42 'Matrix[uc:false][fsm:true] move_directory_contents_deeper':
                  matrix_clean_up_repo &&
                  $fn &&
                  if test $uc = false && test $fsm = false
                  then
                          git status --porcelain=v1 >.git/expect.$fn
                  else
                          git status --porcelain=v1 >.git/actual.$fn &&
                          test_cmp .git/expect.$fn .git/actual.$fn
                  fi
  
  + matrix_clean_up_repo
  + git reset --hard HEAD
  HEAD is now at 1d1edcb initial
  + git clean -fd
  + move_directory_contents_deeper
  + mkdir T1/_new_
  + mv T1/F1 T1/F2 T1/T2 T1/_new_
  + test false = false
  + test true = false
  + git status --porcelain=v1
  error: last command exited with $?=141
  not ok 42 - Matrix[uc:false][fsm:true] move_directory_contents_deeper

  expecting success of 7527.43 'Matrix[uc:false][fsm:true] move_directory_up': 
  		matrix_clean_up_repo &&
  		$fn &&
  		if test $uc = false && test $fsm = false
  		then
  			git status --porcelain=v1 >.git/expect.$fn
  		else
  			git status --porcelain=v1 >.git/actual.$fn &&
  			test_cmp .git/expect.$fn .git/actual.$fn
  		fi
  	
  + matrix_clean_up_repo
  + git reset --hard HEAD
  HEAD is now at 1d1edcb initial
  + git clean -fd
  Removing T1/_new_/
  + move_directory_up
  + mv T1/T2/T3 T1
  + test false = false
  + test true = false
  + git status --porcelain=v1
  error: last command exited with $?=141
  not ok 43 - Matrix[uc:false][fsm:true] move_directory_up

  expecting success of 7527.55 'Matrix[uc:true][fsm:true] move_directory_contents_deeper':
                  matrix_clean_up_repo &&
                  $fn &&
                  if test $uc = false && test $fsm = false
                  then
                          git status --porcelain=v1 >.git/expect.$fn
                  else
                          git status --porcelain=v1 >.git/actual.$fn &&
                          test_cmp .git/expect.$fn .git/actual.$fn
                  fi
  
  + matrix_clean_up_repo
  + git reset --hard HEAD
  HEAD is now at 1d1edcb initial
  + git clean -fd
  + move_directory_contents_deeper
  + mkdir T1/_new_
  + mv T1/F1 T1/F2 T1/T2 T1/_new_
  + test true = false
  + git status --porcelain=v1
  error: last command exited with $?=141

I find it interesting that the output of 'git status' is redirected to
a file in all these cases, and yet it gets a SIGPIPE.


I also saw the test hang a couple of times, e.g.:

  $ ./t7527-builtin-fsmonitor.sh --stress -r 8,23-58
  OK    6.1
  OK    7.1
  OK    1.1
  OK    2.1
  OK    3.1
  OK    5.1
  OK    4.1
  OK    0.1
  OK    6.2
  OK    1.2
  OK    2.2
  OK    7.2
  OK    5.2
  OK    0.2
  OK    4.2
  OK    6.3
  OK    7.3
  OK    2.3
  OK    0.3
  OK    4.3
  OK    6.4
  OK    7.4
  OK    2.4
  OK    0.4
  OK    4.4
  OK    6.5
  OK    7.5
  OK    2.5
  OK    0.5
  OK    4.5
  OK    6.6
  OK    7.6
  OK    2.6
  OK    0.6
  OK    4.6
  OK    6.7
  OK    7.7
  OK    2.7
  OK    0.7
  OK    4.7
  OK    6.8
  OK    7.8
  OK    2.8
  OK    0.8
  OK    4.8
  OK    6.9
  OK    7.9
  OK    2.9
  OK    0.9
  OK    4.9
  OK    6.10
  OK    7.10
  OK    2.10
  OK    0.10
  OK    4.10
  OK    6.11
  OK    7.11
  OK    2.11
  OK    0.11
  OK    4.11
  OK    6.12
  OK    7.12
  OK    2.12
  OK    0.12
  OK    4.12
  OK    6.13
  OK    7.13
  OK    2.13
  OK    0.13
  OK    6.14
  OK    4.13
  OK    7.14
  OK    2.14
  OK    0.14
  OK    6.15
  OK    4.14
  OK    2.15
  OK    7.15
  OK    0.15
  FAIL  7.16
  OK    6.16
  OK    2.16
  OK    4.15
  OK    0.16

At this point the test script should print the log of the failed job,
but it hangs instead, as there are a number of stuck fsmonitor--daemon
and status processes (notice how the stress test starts with 8 jobs,
but the last repetition only has 4):

  $ ps aux |grep git
  szeder   1857100  0.0  0.1  72272  4452 pts/2    Sl+  21:40   0:00 /home/szeder/src/git/git fsmonitor--daemon run --detach --ipc-threads=8
  szeder   1857779  0.0  0.1   6560  4152 pts/2    S+   21:40   0:00 /home/szeder/src/git/git status --porcelain=v1
  szeder   1860020  0.0  0.1  88664  4312 pts/2    Sl+  21:40   0:00 /home/szeder/src/git/git fsmonitor--daemon run --detach --ipc-threads=8
  szeder   1860668  0.0  0.1   6560  4040 pts/2    S+   21:40   0:00 /home/szeder/src/git/git status --porcelain=v1
  szeder   1860749  0.0  0.1  96860  4528 pts/2    Sl+  21:40   0:00 /home/szeder/src/git/git fsmonitor--daemon run --detach --ipc-threads=8
  szeder   1861281  0.0  0.1   6560  4272 pts/2    S+   21:40   0:00 /home/szeder/src/git/git status --porcelain=v1

