Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF00EC636CC
	for <git@archiver.kernel.org>; Wed,  8 Feb 2023 11:45:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbjBHLp2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Feb 2023 06:45:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjBHLp1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2023 06:45:27 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4376048A27
        for <git@vger.kernel.org>; Wed,  8 Feb 2023 03:45:20 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id lu11so50569107ejb.3
        for <git@vger.kernel.org>; Wed, 08 Feb 2023 03:45:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5yM4nMie2l4DeiUR5A8oajGDPfPzxAE8iwhsRy8yRuE=;
        b=VerrNXAtjEGs2lF5KOMByxLq099fYgTIBRvadIxVj+e1RG2+ZlMRqjLWG2tTUrMoIq
         yudAb4HfbxGiaxU1pSmXH1T/FmCWourDfQ8DMpQLclK5B8xSPYxWBIAzK3LzExrlxu9s
         qdWRf92Tb3aO21ssiTBOodaq8OePyuwykc+PMq/qMMO7q0gZ4R7YQH7RikmG34QKysMk
         NaY7UEW6ZgCgenUiUO2T+POiEK2n4ntunXXMDbS+hkcK8ieD/z31yiVX4QC8ocm/Shun
         JIF+Rv9DV1u4Vup0CudGHEIT/tCYNaPK3piQvuYsjNidTiuIiGNj3OPvhVzFOb9B/g8l
         ewBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5yM4nMie2l4DeiUR5A8oajGDPfPzxAE8iwhsRy8yRuE=;
        b=A0InOsMuYu9mcG6eqfdvtP/ZxTXtkhfamzTHNPw07hetHjaAm6qKi7XDl1PhyBrwal
         kw0VtzJ5Y25sr0yEkY1A1VSuRpT6uw5FGIBZKwkQ2sXtCShQF50Wf1thBL9P/6GK5gIc
         T3qpeTfzotTBZmekNkNH6mbkeLlHaotwjZ4J+2nyqACjYmJww4lmzOJ2Vbh3OFRzcxFx
         nvSAMIgMbAjNpOiQ2jb7wBzUYjAyuzg33VOBdm+MYW/PcQTE5cSHvd7jmxJftig5NWIB
         cEfDrtDA0Ij5cVxd8PIDOxxFCACXga5yjjnBLSg7EaFemjM05Ih80BpaDZWeGn03tEu5
         wluA==
X-Gm-Message-State: AO0yUKVEBUMYhJxJE3EbMBoxD8lUu4bDy5s/J8mps1dK+S/sncJ6zZzN
        YF6JiB3cx/IIsEng+BkitYjNFUIMErHacw==
X-Google-Smtp-Source: AK7set+oBfBOW2F7YmxFdNv52ZqQalrt4KuMUMR5jujNbLmep5bd2SiFVvR8Wgq+Xv5oZ5i//DaPKg==
X-Received: by 2002:a17:907:2bf9:b0:8ae:e82a:3230 with SMTP id gv57-20020a1709072bf900b008aee82a3230mr904466ejc.70.1675856718294;
        Wed, 08 Feb 2023 03:45:18 -0800 (PST)
Received: from smtpclient.apple (132-216-166-62.ftth.glasoperator.nl. [62.166.216.132])
        by smtp.gmail.com with ESMTPSA id v9-20020a1709064e8900b0088e7fe75736sm8167449eju.1.2023.02.08.03.45.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Feb 2023 03:45:17 -0800 (PST)
From:   Ilya Kantor <iliakan@gmail.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.400.51.1.1\))
Subject: CMakeLists.txt from contrib/buildsystems fails to build on Mac
Message-Id: <BFC8139A-0A9A-4E84-BC0B-D6EE5F469F82@gmail.com>
Date:   Wed, 8 Feb 2023 12:45:06 +0100
Cc:     avarab@gmail.com
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3731.400.51.1.1)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I've just tried to build git as described in =
contrib/buildsystems/CMakeLists.txt, and it doesn't work.

Is this route supposed to work at all?

I'm on MacOS Ventura,
first running this:
```
mkdir -p contrib/buildsystems/out
cd contrib/buildsystems/out
cmake ../ -DCMAKE_BUILD_TYPE=3DRelease
```

This works fine (the full output is here: =
https://gist.github.com/11f6786eb195a4bc939e010d4f759a22).

And then I run `make`:

```
make
```

Although it dies with an error.

The full output is here: =
https://gist.github.com/24e2eb21613668c44d81f6f0cc78e1a1

Here's the ending error:

```
/opt/tmp/git/read-cache.c:170:22: error: no member named 'st_ctim' in =
'struct stat'
        sd->sd_ctime.nsec =3D ST_CTIME_NSEC(*st);
                            ^~~~~~~~~~~~~~~~~~
/opt/tmp/git/contrib/buildsystems/../../git-compat-util.h:1380:48: note: =
expanded from macro 'ST_CTIME_NSEC'
#define ST_CTIME_NSEC(st) ((unsigned int)((st).st_ctim.tv_nsec))
                                          ~~~~ ^
/opt/tmp/git/read-cache.c:171:22: error: no member named 'st_mtim' in =
'struct stat'
        sd->sd_mtime.nsec =3D ST_MTIME_NSEC(*st);
                            ^~~~~~~~~~~~~~~~~~
/opt/tmp/git/contrib/buildsystems/../../git-compat-util.h:1381:48: note: =
expanded from macro 'ST_MTIME_NSEC'
#define ST_MTIME_NSEC(st) ((unsigned int)((st).st_mtim.tv_nsec))
                                          ~~~~ ^
/opt/tmp/git/read-cache.c:2410:27: error: no member named 'st_mtim' in =
'struct stat'
        istate->timestamp.nsec =3D ST_MTIME_NSEC(st);
                                 ^~~~~~~~~~~~~~~~~
/opt/tmp/git/contrib/buildsystems/../../git-compat-util.h:1381:48: note: =
expanded from macro 'ST_MTIME_NSEC'
#define ST_MTIME_NSEC(st) ((unsigned int)((st).st_mtim.tv_nsec))
                                          ~~~~ ^
/opt/tmp/git/read-cache.c:3177:27: error: no member named 'st_mtim' in =
'struct stat'
        istate->timestamp.nsec =3D ST_MTIME_NSEC(st);
                                 ^~~~~~~~~~~~~~~~~
/opt/tmp/git/contrib/buildsystems/../../git-compat-util.h:1381:48: note: =
expanded from macro 'ST_MTIME_NSEC'
#define ST_MTIME_NSEC(st) ((unsigned int)((st).st_mtim.tv_nsec))
                                          ~~~~ ^
4 errors generated.
make[2]: *** [CMakeFiles/libgit.dir/opt/tmp/git/read-cache.c.o] Error 1
make[1]: *** [CMakeFiles/libgit.dir/all] Error 2
```

May that be because of some changes in MacOs Ventura?=20
Or is the CMakeLists.txt "dead and forgotten"? ;)

P.S. The regular "make" route works.

Kind regards,
Ilya Kantor=
