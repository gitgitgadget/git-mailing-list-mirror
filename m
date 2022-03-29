Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3386C433EF
	for <git@archiver.kernel.org>; Tue, 29 Mar 2022 12:04:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236211AbiC2MFz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Mar 2022 08:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236213AbiC2MFw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Mar 2022 08:05:52 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE1DC2C65D
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 05:04:08 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id z92so20408118ede.13
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 05:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=yTfEHsOBjrzNiNI9DQA4fAcYOp1UxccuR4Os8y0HSx4=;
        b=ce9V/lEoN2v0O+8HyoBdQ6SlskBCwOK/R9fX2XpIMPS1H4Cr2apqT/tF8zjw8/tnCp
         +HawQ502o2cNFyoxFPKekAQeMIXJnEaGjmzwCKubr9v1vf36SjWZnsZ4uyUPwBI0Fm/y
         MjCryfd/VRdkKVX3DgIE6yRkMUt8j1oHuJGL0qeJogya9sLDUdtO5AXxsecv9mxvF81N
         YCUsIRbcrmmoDPPQnXxjadZZSWc9h8A6uYDBh6O3df3fRYMWBqTb8EdpjPzIZKaOfo+I
         fNIO6uaQuK1PnVdYdciBCcPeDuX2f6gJKyJT0YZTqC5AyvsDedAlJndGLbWcoS7noxhO
         CzaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=yTfEHsOBjrzNiNI9DQA4fAcYOp1UxccuR4Os8y0HSx4=;
        b=FcqurjafkBZDv3lqEdKMekIszxp0f/WO/XqOmbRR63pUpzXmj3tjMLPc3m0iiRat1j
         eWb/3ZYX8lmJt1aOim5WlBvYsDaio8d9LvR+4/OjfzppkTXB1pdDSO/pvsWmSDc8XQPR
         2dea1yUkAWcjYQCul7b9nLPcj+6rcUsdoCKpTtuhZqYPrfAwh3rHD7Tg5U2StoufaGLk
         Yl7KY29Ot1mtAyJcaSX3B6NbOi61qnjWCRasi6qxuMwjbc0PpUVclHXj0NmX45Hhp3he
         hIi63dNAomZsVsoAGqs7BrC3f9MZh+uK1JJuL0UNIwm72B0xdYWFG5090MQyFF0mUSXH
         GlZQ==
X-Gm-Message-State: AOAM532bZKllZD3tfGKpufeD9hUyiXOEw9mAfhhUxIQdjl+2HqNkpAzX
        Ped1dVS6k+HAz4aLMmH/HaKf3D3ODULYwA==
X-Google-Smtp-Source: ABdhPJzSSrae6rXt++eDq+vQb76Bwt8RXrfcFDfTaLdUzracIYAt9bD1PUZHFdJbgqnw5D3K23Y+lg==
X-Received: by 2002:a05:6402:3689:b0:419:d380:ddbc with SMTP id ej9-20020a056402368900b00419d380ddbcmr4106155edb.230.1648555446623;
        Tue, 29 Mar 2022 05:04:06 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id p10-20020a17090664ca00b006df8869d58dsm7018868ejn.100.2022.03.29.05.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 05:04:05 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nZAZx-003cpT-A6;
        Tue, 29 Mar 2022 14:04:05 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "Neeraj K. Singh via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        nksingh85@gmail.com, ps@pks.im, jeffhost@microsoft.com,
        Bagas Sanjaya <bagasdotme@gmail.com>, worldhello.net@gmail.com,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Subject: Re: [PATCH v4 00/13] core.fsyncmethod: add 'batch' mode for faster
 fsyncing of multiple objects
Date:   Tue, 29 Mar 2022 13:45:17 +0200
References: <pull.1134.v3.git.1648097906.gitgitgadget@gmail.com>
 <pull.1134.v4.git.1648514552.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.11
In-reply-to: <pull.1134.v4.git.1648514552.gitgitgadget@gmail.com>
Message-ID: <220329.868rst2cei.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Mar 29 2022, Neeraj K. Singh via GitGitGadget wrote:

> V4 changes:
>
>  * Make ODB transactions nestable.
>  * Add an ODB transaction around writing out the cached tree.
>  * Change update-index to use a more straightforward way of managing ODB
>    transactions.
>  * Fix missing 'local's in lib-unique-files
>  * Add a per-iteration setup mechanism to test_perf.
>  * Fix camelCasing in warning message.

Despite my
https://lore.kernel.org/git/220329.86czi52ekn.gmgdl@evledraar.gmail.com/
I eventually gave up on trying to extract meaningful numbers from
t/perf, I can never quite find out if they're because of its
shellscripts shenanigans or actual code.

(And also; I realize I didn't follow-up on
https://lore.kernel.org/git/CANQDOdcFN5GgOPZ3hqCsjHDTiRfRpqoAKxjF1n9D6S8oD9=
--_A@mail.gmail.com/,
sorry):

But I came up with this (uses my thin
https://gitlab.com/avar/git-hyperfine/ wrapper, and you should be able
to apt get hyperfine):
=09
	#!/bin/sh
	set -xe
=09
	if ! test -d /tmp/scalar.git
	then
		git clone --bare https://github.com/Microsoft/scalar.git /tmp/scalar.git
		mv /tmp/scalar.git/objects/pack/*.pack /tmp/scalar.git/my.pack
	fi
	git hyperfine \
	        --warmup 1 -r 3 \
		-L rev neeraj-v4,avar-RFC \
		-s 'make CFLAGS=3D-O3 && rm -rf repo && git init repo && cp -R t repo/ &&=
 git ls-files -- t >repo/.git/to-add.txt' \
		-p 'rm -rf repo/.git/objects/* repo/.git/index' \
		$@'./git -c core.fsync=3Dloose-object -c core.fsyncMethod=3Dbatch -C repo=
 update-index --add --stdin <repo/.git/to-add.txt'
=09
	git hyperfine \
	        --warmup 1 -r 3 \
		-L rev neeraj-v4,avar-RFC \
		-s 'make CFLAGS=3D-O3 && rm -rf repo && git init repo && cp -R t repo/' \
		-p 'rm -rf repo/.git/objects/* repo/.git/index' \
		$@'./git -c core.fsync=3Dloose-object -c core.fsyncMethod=3Dbatch -C repo=
 add .'
=09
	git hyperfine \
	        --warmup 1 -r 3 \
		-L rev neeraj-v4,avar-RFC \
	        -s 'make CFLAGS=3D-O3' \
	        -p 'git init --bare dest.git' \
	        -c 'rm -rf dest.git' \
	        $@'./git -C dest.git -c core.fsyncMethod=3Dbatch unpack-objects </=
tmp/scalar.git/my.pack'

Those tags are your v4 here & the v2 of the RFC I sent at
https://lore.kernel.org/git/RFC-cover-v2-0.7-00000000000-20220323T140753Z-a=
varab@gmail.com/

Which shows my RFC v2 is ~20% faster with:

    $ PFX=3D'strace' ~/g/git.meta/benchmark.sh "strace "

    1.22 =C2=B1 0.02 times faster than 'strace ./git -c core.fsync=3Dloose-=
object -c core.fsyncMethod=3Dbatch -C repo update-index --add --stdin <repo=
/.git/to-add.txt' in 'neeraj-v4'
    1.22 =C2=B1 0.01 times faster than 'strace ./git -c core.fsync=3Dloose-=
object -c core.fsyncMethod=3Dbatch -C repo add .' in 'neeraj-v4'
    1.00 =C2=B1 0.01 times faster than 'strace ./git -C dest.git -c core.fs=
yncMethod=3Dbatch unpack-objects </tmp/scalar.git/my.pack' in 'neeraj-v4'

But only for add/update-index, is the unpack-objects not using the
tmp-objdir? (presumably yes).

As noted before I've found "strace" to be a handy way to "simulate"
slower FS ops on a ramdisk (I get about the same numbers sometimes on
the actual non-SSD disk, but due to load on the system (that I'm not in
full control of[1]) I can't get hyperfine to be happy with the
non-fuzzyness:

    1.06 =C2=B1 0.02 times faster than './git -c core.fsync=3Dloose-object =
-c core.fsyncMethod=3Dbatch -C repo update-index --add --stdin <repo/.git/t=
o-add.txt' in 'neeraj-v4'
    1.06 =C2=B1 0.03 times faster than './git -c core.fsync=3Dloose-object =
-c core.fsyncMethod=3Dbatch -C repo add .' in 'neeraj-v4'
    1.01 =C2=B1 0.01 times faster than './git -C dest.git -c core.fsyncMeth=
od=3Dbatch unpack-objects </tmp/scalar.git/my.pack' in 'neeraj-v4'

FWIW these are my actual non-fuzzy-with-strace numbers on the
not-ramdisk, as you can see the intervals overlap, but for the first two
the "min" time is never close to the RFC v2:
=09
	$ XDG_RUNTIME_DIR=3D/tmp/ghf ~/g/git.meta/benchmark.sh
	+ test -d /tmp/scalar.git
	+ git hyperfine --warmup 1 -r 3 -L rev neeraj-v4,avar-RFC -s make CFLAGS=
=3D-O3 && rm -rf repo && git init repo && cp -R t repo/ && git ls-files -- =
t >repo/.git/to-add.txt -p rm -rf repo/.git/objects/* repo/.git/index ./git=
 -c core.fsync=3Dloose-object -c core.fsyncMethod=3Dbatch -C repo update-in=
dex --add --stdin <repo/.git/to-add.txt
	Benchmark 1: ./git -c core.fsync=3Dloose-object -c core.fsyncMethod=3Dbatc=
h -C repo update-index --add --stdin <repo/.git/to-add.txt' in 'neeraj-v4
	  Time (mean =C2=B1 =CF=83):      1.043 s =C2=B1  0.143 s    [User: 0.184 =
s, System: 0.193 s]
	  Range (min =E2=80=A6 max):    0.943 s =E2=80=A6  1.207 s    3 runs
=09
	Benchmark 2: ./git -c core.fsync=3Dloose-object -c core.fsyncMethod=3Dbatc=
h -C repo update-index --add --stdin <repo/.git/to-add.txt' in 'avar-RFC
	  Time (mean =C2=B1 =CF=83):     877.6 ms =C2=B1 183.4 ms    [User: 197.9 =
ms, System: 149.4 ms]
	  Range (min =E2=80=A6 max):   697.8 ms =E2=80=A6 1064.4 ms    3 runs
=09
	Summary
	  './git -c core.fsync=3Dloose-object -c core.fsyncMethod=3Dbatch -C repo =
update-index --add --stdin <repo/.git/to-add.txt' in 'avar-RFC' ran
	    1.19 =C2=B1 0.30 times faster than './git -c core.fsync=3Dloose-object=
 -c core.fsyncMethod=3Dbatch -C repo update-index --add --stdin <repo/.git/=
to-add.txt' in 'neeraj-v4'
	+ git hyperfine --warmup 1 -r 3 -L rev neeraj-v4,avar-RFC -s make CFLAGS=
=3D-O3 && rm -rf repo && git init repo && cp -R t repo/ -p rm -rf repo/.git=
/objects/* repo/.git/index ./git -c core.fsync=3Dloose-object -c core.fsync=
Method=3Dbatch -C repo add .
	Benchmark 1: ./git -c core.fsync=3Dloose-object -c core.fsyncMethod=3Dbatc=
h -C repo add .' in 'neeraj-v4
	  Time (mean =C2=B1 =CF=83):      1.019 s =C2=B1  0.057 s    [User: 0.213 =
s, System: 0.194 s]
	  Range (min =E2=80=A6 max):    0.963 s =E2=80=A6  1.076 s    3 runs
=09
	Benchmark 2: ./git -c core.fsync=3Dloose-object -c core.fsyncMethod=3Dbatc=
h -C repo add .' in 'avar-RFC
	  Time (mean =C2=B1 =CF=83):     918.6 ms =C2=B1  34.4 ms    [User: 207.8 =
ms, System: 164.1 ms]
	  Range (min =E2=80=A6 max):   880.6 ms =E2=80=A6 947.5 ms    3 runs
=09
	Summary
	  './git -c core.fsync=3Dloose-object -c core.fsyncMethod=3Dbatch -C repo =
add .' in 'avar-RFC' ran
	    1.11 =C2=B1 0.07 times faster than './git -c core.fsync=3Dloose-object=
 -c core.fsyncMethod=3Dbatch -C repo add .' in 'neeraj-v4'
	+ git hyperfine --warmup 1 -r 3 -L rev neeraj-v4,avar-RFC -s make CFLAGS=
=3D-O3 -p git init --bare dest.git -c rm -rf dest.git ./git -C dest.git -c =
core.fsyncMethod=3Dbatch unpack-objects </tmp/scalar.git/my.pack
	Benchmark 1: ./git -C dest.git -c core.fsyncMethod=3Dbatch unpack-objects =
</tmp/scalar.git/my.pack' in 'neeraj-v4
	  Time (mean =C2=B1 =CF=83):      1.362 s =C2=B1  0.285 s    [User: 1.021 =
s, System: 0.186 s]
	  Range (min =E2=80=A6 max):    1.192 s =E2=80=A6  1.691 s    3 runs
=09
	  Warning: Statistical outliers were detected. Consider re-running this be=
nchmark on a quiet PC without any interferences from other programs. It mig=
ht help to use the '--warmup' or '--prepare' options.
=09
	Benchmark 2: ./git -C dest.git -c core.fsyncMethod=3Dbatch unpack-objects =
</tmp/scalar.git/my.pack' in 'avar-RFC
	 =E2=A0=8F Performing warmup runs         =E2=96=91=E2=96=91=E2=96=91=E2=
=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=
=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=
=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=
=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=
=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=
=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=
=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=
=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=
=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=
=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=
=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=
=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=
=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=
=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=
=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=
=96=91=E2=96=91 =E2=A0=99 Performing warmup runs         =E2=96=91=E2=96=91=
=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=
=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=
=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=
=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=
=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=
=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=
=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=
=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=
=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=
=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=
=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=
=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=
=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=
=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=
=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=
=E2=96=91=E2=96=91=E2=96=91  Time (mean =C2=B1 =CF=83):      1.188 s =C2=B1=
  0.009 s    [User: 1.025 s, System: 0.161 s]
	  Range (min =E2=80=A6 max):    1.180 s =E2=80=A6  1.199 s    3 runs
=09=20
	Summary
	  './git -C dest.git -c core.fsyncMethod=3Dbatch unpack-objects </tmp/scal=
ar.git/my.pack' in 'avar-RFC' ran
	    1.15 =C2=B1 0.24 times faster than './git -C dest.git -c core.fsyncMet=
hod=3Dbatch unpack-objects </tmp/scalar.git/my.pack' in 'neeraj-v4'

1. I do my git hacking on a bare metal box I rent with some friends, and
   one of them is running one those persistent video game daemons
   written in Java. So I think all my non-RAM I/O numbers are
   continually fuzzed by what players are doing in Minecraft or whatever
   that thing is...
