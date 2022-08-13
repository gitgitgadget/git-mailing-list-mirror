Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C46F7C19F2D
	for <git@archiver.kernel.org>; Sat, 13 Aug 2022 21:09:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240464AbiHMVJW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Aug 2022 17:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240439AbiHMVJT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Aug 2022 17:09:19 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D6AE12D39
        for <git@vger.kernel.org>; Sat, 13 Aug 2022 14:09:18 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id q39-20020a056830442700b0063889adc0ddso1968209otv.1
        for <git@vger.kernel.org>; Sat, 13 Aug 2022 14:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:from:to:cc;
        bh=P2CNX6z+dkDKnPIf9y/UQ2busK6bQk0lrKqKNZ8l7dM=;
        b=MQjkdYUYKIRStduLHaYwsct1NvOWNai3uSlO0Iibg+IvJMhn8gprF/hJUmM3dRS/eb
         quBI9L6PPMDfcQ938Xo4Sc6UACvdYGceFYweAf54KvWMdTEdjtS0ppzrbxTlMHhajnyp
         HmJM8ULoJO0UjW96OPtlWCyjzRmWd0Hj+FoZ3rft2vJ5d+gyL4uoC5Y9UdVb27iBcizg
         Hcw7D91EyrbJBF+vvwcLYCi1l2qrPhl/7GAgQMZW8BM8TUjosMV3zoXBRkw8XmadX6uE
         PNmG4Qj9LxgIbqzFAarFK3oJhFP/cscNG5A/aD7/ORYfgIdg66+ch5qfDl8af9KR3mlQ
         GRjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:x-gm-message-state:from:to:cc;
        bh=P2CNX6z+dkDKnPIf9y/UQ2busK6bQk0lrKqKNZ8l7dM=;
        b=IkhPpQ/mvSnwzGijKXHisf4BZqooIIjzp1S6KIIZ9KLtyYzrurPdLRDLoBnD+oHuVO
         JkvNMmqKg/ak/zgnaVXyMREIoZDYIylmLE/iwfUrgYWQh3zJwchuT6MCk8+wlnOoxRkc
         wkNvSBKyaW3xYgPApI86f1pkcRtUFS89Xo3zUnQxV+AmnFhzPshPqVC9v+hBxJW0Iz3g
         1PCLQ8vjIv60igvBEr0+d68qENbrL3jbeFqFf0lKoepTmC7J5tOYj44CSO2RF3YWU7Dg
         EPb4gqIUKP5hrySFt3AxyPG+daPK6DOo8tdvRDvd5Q2BpV6wPphbarWqxNUGXaKCSe2d
         goEQ==
X-Gm-Message-State: ACgBeo0bSVIz4+cBn6T84xaM9YItGbvhCB5MaRLm7UNYnNuoieB92YU8
        L2ksCizwO2cclllahlXWcV7NxxYRC/8=
X-Google-Smtp-Source: AA6agR74UxCyXmt+LCG7GsBCKRDRdS4t7lTbfMQEbzZ8I66wWsAoZvJV54ImDdIgl+OD1UdBNOrLxg==
X-Received: by 2002:a9d:53cb:0:b0:637:1ddc:615c with SMTP id i11-20020a9d53cb000000b006371ddc615cmr3890946oth.3.1660424956988;
        Sat, 13 Aug 2022 14:09:16 -0700 (PDT)
Received: from smtpclient.apple ([104.223.97.2])
        by smtp.gmail.com with ESMTPSA id l6-20020a05687014c600b00116861f45cfsm582118oab.23.2022.08.13.14.09.15
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 Aug 2022 14:09:16 -0700 (PDT)
From:   mingli zhang <zmlfoolishfish@gmail.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: [bug]fatal: fetch-pack: invalid index-pack output
Message-Id: <50B3E989-0405-4B05-9940-D3943C62260A@gmail.com>
Date:   Sun, 14 Aug 2022 05:09:13 +0800
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3696.80.82.1.1)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

HI,

At some point, I exec git pull/fetch/clone will got a fatal message:

```

fatal: fetch-pack: invalid index-pack output

```

I use git 2.36.1 on MacOS Monterey 12.3.1

```
git --version
04:51:36.776640 git.c:459 trace: built-in: git version
git version 2.36.1

```

Example:

```

zml@localhashdata postgres % git pull -r
04:53:33.553655 git.c:459 trace: built-in: git pull -r
04:53:33.640927 run-command.c:654 trace: run_command: git merge-base =
--fork-point refs/remotes/origin/REL_14_STABLE REL_14_STABLE
04:53:33.651808 run-command.c:654 trace: run_command: git fetch =
--update-head-ok
04:53:33.658822 git.c:459 trace: built-in: git fetch --update-head-ok
04:53:33.683642 run-command.c:654 trace: run_command: unset GIT_PREFIX; =
GIT_PROTOCOL=3Dversion=3D2 ssh -o SendEnv=3DGIT_PROTOCOL git@github.com =
'git-upload-pack '\''postgres/postgres.git'\'''
remote: Enumerating objects: 16843, done.
remote: Counting objects: 100% (16231/16231), done.
remote: Compressing objects: 100% (4164/4164), done.
04:53:40.822310 run-command.c:654 trace: run_command: git index-pack =
--stdin -v --fix-thin '--keep=3Dfetch-pack 70208 on localhashdata' =
--pack_header=3D2,10035
04:53:40.828465 git.c:459 trace: built-in: git index-pack --stdin -v =
--fix-thin '--keep=3Dfetch-pack 70208 on localhashdata' =
--pack_header=3D2,10035
remote: Total 10035 (delta 8554), reused 7150 (delta 5805), pack-reused =
0
Receiving objects: 100% (10035/10035), 6.93 MiB | 2.42 MiB/s, done.
fatal: fetch-pack: invalid index-pack output

```

I try to config memory or use git pull -r --depth 1, but didn=E2=80=99t =
help.

My git config is

```
[core]
packedGitLimit =3D 512m
packedGitWindowSize =3D 512m
compression =3D 0

[pack]
deltaCacheSize =3D 2047m
packSizeLimit =3D 2047m
windowMemory =3D 2047m
```

And the code dir permission is

```
drwxrwxrwx

```

Any suggestions ?

Regards,
Zhang Mingli=
