Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70267208DB
	for <e@80x24.org>; Tue, 29 Aug 2017 17:52:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751274AbdH2RwS (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Aug 2017 13:52:18 -0400
Received: from mail-wr0-f182.google.com ([209.85.128.182]:33512 "EHLO
        mail-wr0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751219AbdH2RwQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Aug 2017 13:52:16 -0400
Received: by mail-wr0-f182.google.com with SMTP id k94so12388403wrc.0
        for <git@vger.kernel.org>; Tue, 29 Aug 2017 10:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=OpWM+z3pW+6fTHUQI6hJr08UoPVKTH04R7JF1wsLjmE=;
        b=kOGJFQDWFMcF+OOJoQMyRQvH+OEr0Y9lbjY8WBxagP909Rv3HYYBy0nIlJHX5QwAUl
         TQbFe9KzeDgWYG9a/Qao6Y+Kk21yEmUlhsz7dW0Oqs4HKZvaF5qw9OeiBP4Wc+ywbYKi
         zZPyzbp4t0TgQAT13Xaik5VXH/uGBhhw3ZkCQDIfALOjZuqqSHIUHV/1Dq6hdZBBoxOs
         MtgFkBdETiiajrOi68z6rRuylVTkhYsSXTQHEPYEj3RqsUHC+qjtr07omlCJM1EoiAJk
         +ioYewIPI25YXo8+ulKiwvsIOeuCzv8VAgE0oYn2SlAbWvusCJseWgJoqPHbTr/2SgH6
         N1yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=OpWM+z3pW+6fTHUQI6hJr08UoPVKTH04R7JF1wsLjmE=;
        b=MyObLjnxcAPGGT77tFaH8b6mbvF6H5aPkd8SPcCLKqbg7XTF+3luX88ooTXKAoSSjp
         pp9shgqiOtAZ2ZwRopfmzPnuUGyZTVU6OIT/1oswChcFpBd9zb9sH/wKj+F4u+/nq/l+
         MputhDjYhd3z6NHUxqfcmm0v85tLkDkOSVc/4VAhGOKXnTstPyDK/HT4uR0czpLV/Dlk
         KuJgCHoKL2fm6QHoPpvy3SeC3HOdmoEbupOm9CQ38rn2qKKYUbgdFrTQdVNj548TsJ43
         bQ3yOpfTRAuV0FV852aKHlSjATbQTV14jbE36zv75wCMvZgQIyi1LgH+YF9VyQKvSAyf
         OGUg==
X-Gm-Message-State: AHYfb5jfAOJiAyJv19bDrNxbAygtQhLkGuvs2WLBqkHycBsmwjcT8jgu
        9O7ymPctANkTnw==
X-Received: by 10.223.132.230 with SMTP id 93mr790980wrg.172.1504029135435;
        Tue, 29 Aug 2017 10:52:15 -0700 (PDT)
Received: from [172.20.10.3] (tmo-104-40.customers.d1-online.com. [80.187.104.40])
        by smtp.gmail.com with ESMTPSA id b125sm145408wma.28.2017.08.29.10.52.02
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 29 Aug 2017 10:52:14 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH] pkt-line: re-'static'-ify buffer in packet_write_fmt_1()
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <CAN0heSoUqcOqVspZkbPahWQdtVpSdtSZoCFWu0ZQJfN3F0mD2g@mail.gmail.com>
Date:   Tue, 29 Aug 2017 18:51:52 +0100
Cc:     Jeff King <peff@peff.net>, Git Users <git@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B1E291F2-86FF-4982-A092-92FAED65385C@gmail.com>
References: <20170827073732.546-1-martin.agren@gmail.com> <9E4606AF-8814-42DE-8D3A-3A15C1B1723C@gmail.com> <CAN0heSraJFbbog7FKpAtmob9W6_5-AS1StZFVW6xUwMDWfMYgg@mail.gmail.com> <179AC8FB-5991-4200-9AAC-2F8D0914D5F9@gmail.com> <20170827232338.hm5t7t7c2xaa3zyl@sigill.intra.peff.net> <CAN0heSoUqcOqVspZkbPahWQdtVpSdtSZoCFWu0ZQJfN3F0mD2g@mail.gmail.com>
To:     =?utf-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 28 Aug 2017, at 06:11, Martin =C3=85gren <martin.agren@gmail.com> =
wrote:
>=20
> On 28 August 2017 at 01:23, Jeff King <peff@peff.net> wrote:
>> On Sun, Aug 27, 2017 at 10:04:55PM +0200, Lars Schneider wrote:
>>=20
>>> I did run all tests under valgrind using "make valgrind" and I found
>>> the following files with potential issues:
>>>=20
>>> cat valgrind.out | perl -nE 'say /^=3D=3D.+\((.+)\:.+\)$/' | sort | =
uniq -c
>>> 7102
>>>  2 clone.c
>>> 33 common-main.c
>>>  6 connect.c
>>> 64 git.c
>>>  4 ls-remote.c
>>> 126 run-command.c
>>> 12 transport.c
>>>  7 worktree.c
>>=20
>> I'm not sure where valgrind.out comes from. The individual
>> test-results/*.out files may have valgrind output, but I don't think
>> they usually contain leak output.
>>=20
>> Doing "valgrind ./git-upload-pack . </dev/null >/dev/null" mentions
>> leaked memory but not the locations. Adding --leak-check=3Dfull shows =
that
>> most of it comes from format_packet().
>>=20
>> And applying Martin's patch drops the "definitely lost" category down =
to
>> 0 bytes (there's still 550k in "still reachable", but those are in =
the
>> "exit will free them for us" category).
>>=20
>>> No mention of "pkt-line.c". Did you run Git with valgrind on one of
>>> your repositories to find it?
>>=20
>> I'm curious, too. I don't think the valgrind setup in our test suite =
is
>> great for finding leaks right now.
>=20
> Sorry for being brief. I've patched t/valgrind/valgrind.sh to say
> "--leak-check=3Dyes". Then I run "./t0000 --valgrind", simply because
> running the complete suite gives more reports than I could possibly
> process.

I set $TOOL_OPTIONS in valgrind.sh: to=20
'--leak-check=3Dfull --errors-for-leak-kinds=3Ddefinite'

... but I also had to adjust t/test-lib-functions.sh:test_create_repo
as I ran into the error "cannot run git init -- have you built things =
yet?".

With these changes I was able to see the leak running valgrind with =
t5110.

---

What if we run a few selected tests with valgrind and count all files =
that
valgrind mentions (a single leak has multiple file mentions because of
the stack trace and other leak indicators). We record these counts and =
let=20
TravisCI scream if one of the numbers increases.

I wonder how stable/fragile such a metric would be as a simple =
refactoring=20
could easily change these numbers. Below I ran valgrind on t5510 before =
and
after Martin's patch. The diff below clearly shows the pkt-line leak.

Would it make sense to pursue something like this in TravisCI to avoid=20=

"pkt-line" kind of leaks in the future?=20


## Valgrind run with leak

$ ./t5510-fetch.sh --valgrind | perl -nE 'say /^=3D=3D.+\((.+)\:.+\)$/' =
| sort | uniq -c
15529
  39 abspath.c
  30 add.c
  34 branch.c
  10 bundle.c
 268 clone.c
  13 commit.c
 471 common-main.c
  52 config.c
  50 connect.c
   4 connected.c
   1 diff-lib.c
 102 dir.c
 120 environment.c
   4 fetch-pack.c
  47 fetch.c
  14 files-backend.c
   1 git-compat-util.h
 871 git.c
  96 init-db.c
  26 iterator.c
   1 list-objects.c
   4 log-tree.c
   2 object.c
   1 pack-objects.c
   6 parse-options.c
  10 pathspec.c
  83 pkt-line.c
   6 precompose_utf8.c
   2 push.c
  67 refs.c
  96 remote.c
  90 repository.c
   4 rev-list.c
  10 revision.c
 165 run-command.c
  42 setup.c
 288 strbuf.c
  51 strbuf.h
   2 tag.c
 107 transport.c
  10 tree-diff.c
  85 upload-pack.c
   1 usage.c
 455 wrapper.c


## Valgrind run with Matrin's patch to fix the leak
$ ./t5510-fetch.sh --valgrind | perl -nE 'say /^=3D=3D.+\((.+)\:.+\)$/' =
| sort | uniq -c
14931
  39 abspath.c
  30 add.c
  34 branch.c
  10 bundle.c
 268 clone.c
  13 commit.c
 433 common-main.c
  52 config.c
  50 connect.c
   6 connected.c
   1 diff-lib.c
 102 dir.c
 120 environment.c
   4 fetch-pack.c
  53 fetch.c
  14 files-backend.c
   1 git-compat-util.h
 879 git.c
  96 init-db.c
   1 iterator.c
   1 list-objects.c
   4 log-tree.c
   2 object.c
   1 pack-objects.c
   6 parse-options.c
  10 pathspec.c
   6 precompose_utf8.c
   2 push.c
  26 refs.c
  96 remote.c
  90 repository.c
   6 rev-list.c
  14 revision.c
 171 run-command.c
  42 setup.c
 246 strbuf.c
  50 strbuf.h
   2 tag.c
 107 transport.c
  10 tree-diff.c
   2 upload-pack.c
   1 usage.c
 415 wrapper.c


## Diff

15529                    | 14931=20
  39 abspath.c               39 abspath.c
  30 add.c                   30 add.c
  34 branch.c                34 branch.c
  10 bundle.c                10 bundle.c
 268 clone.c                268 clone.c
  13 commit.c                13 commit.c
 471 common-main.c       |  433 common-main.c
  52 config.c                52 config.c
  50 connect.c               50 connect.c
   4 connected.c         |    6 connected.c
   1 diff-lib.c               1 diff-lib.c
 102 dir.c                  102 dir.c
 120 environment.c          120 environment.c
   4 fetch-pack.c             4 fetch-pack.c
  47 fetch.c             |   53 fetch.c
  14 files-backend.c         14 files-backend.c
   1 git-compat-util.h        1 git-compat-util.h
 871 git.c               |  879 git.c
  96 init-db.c               96 init-db.c
  26 iterator.c          |    1 iterator.c
   1 list-objects.c           1 list-objects.c
   4 log-tree.c               4 log-tree.c
   2 object.c                 2 object.c
   1 pack-objects.c           1 pack-objects.c
   6 parse-options.c          6 parse-options.c
  10 pathspec.c              10 pathspec.c
  83 pkt-line.c          <
   6 precompose_utf8.c        6 precompose_utf8.c
   2 push.c                   2 push.c
  67 refs.c              |   26 refs.c
  96 remote.c                96 remote.c
  90 repository.c            90 repository.c
   4 rev-list.c          |    6 rev-list.c
  10 revision.c          |   14 revision.c
 165 run-command.c       |  171 run-command.c
  42 setup.c                 42 setup.c
 288 strbuf.c            |  246 strbuf.c
  51 strbuf.h            |   50 strbuf.h
   2 tag.c                    2 tag.c
 107 transport.c            107 transport.c
  10 tree-diff.c             10 tree-diff.c
  85 upload-pack.c       |    2 upload-pack.c
   1 usage.c                  1 usage.c
 455 wrapper.c           |  415 wrapp=20


Thanks,
Lars=
