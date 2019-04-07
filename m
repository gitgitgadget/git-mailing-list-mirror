Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 732E520248
	for <e@80x24.org>; Sun,  7 Apr 2019 06:00:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725980AbfDGGAW (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 Apr 2019 02:00:22 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44337 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbfDGGAW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Apr 2019 02:00:22 -0400
Received: by mail-ed1-f67.google.com with SMTP id d11so8802007edp.11
        for <git@vger.kernel.org>; Sat, 06 Apr 2019 23:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=c2B5gyHM1p5mhk8tHdbLH4nn0Da7+Zzam0p+LVs/D1o=;
        b=fxPo8BzO6kzUP/AupH7005FpC7GUecJGqjbMJG7JK+4N+pqy+bwzbmVIvAvAYpZEkF
         TfRUlxH9YDgSez1CxNq+DAXWn34dvurU/AydtvjH00pCjEEaROoN/22QzzLPDteELR/J
         E2fX7j3WDGqN5JassVtWbNpJIJIwwWDgPq3685LdrNixpbsFji03ql255rR29MuAlSto
         l2u+jrNyZ1Md9pfwRcJQEBb5WknXdBXeLhsNa/d4Y/N71xGVoZTKVSe58b5LLPhjNf0m
         b7pcMv3UrTM6ieJIQwzMz76mNS+S5r5T9SXC+ScfzOdQz7yWnRroYDOTAR1zBISMZjkV
         8IlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=c2B5gyHM1p5mhk8tHdbLH4nn0Da7+Zzam0p+LVs/D1o=;
        b=HhKHkC/YdnzwB15B0TGyogGEdgER1JQWA1NfuuT6XE3tSlWWsEdF2SeytdUpuCpvrk
         8y5Cc59tGwGbyi4eIDD3xhVeMEIMf04qKtYaoPjhEH/3+zzGh6GjrqUNodzLQNqxERhJ
         ljTM5aHiH4GKeXYQHl8A7belNf94yD0taFhss6CLF4+muF6IS3TONs5mKrk8TGXPtKqf
         iY7fh4iSBQBeiWS9jkmb/qbKOAJ119uCeAjcC2SxuHWuHb4qj4uMJM++hiobuR10pi83
         TGm3aDnhaKErDJw+GkU0l+Y8bG6l9WNY6pIuE8sJ8Dq4j2MyGH/OTBM7rQuKb5HMe8Sy
         ORew==
X-Gm-Message-State: APjAAAV4dcST1Fy5WnPTAhixGyaFP4piS2+5YRgPdaWwlzKGjxCphVth
        pccs30aeGa2nlDjPvkcHGCxIofydYYVqdLbw4ag=
X-Google-Smtp-Source: APXvYqyGCvDLcfeO5w0mkIJj4vSr2bocn0YgMigyapK72xcIqELnD5PiHJZAulnf1z/QOUUSAVUyH9Tamal8mEeXVrY=
X-Received: by 2002:a50:b6d5:: with SMTP id f21mr14251774ede.105.1554616820355;
 Sat, 06 Apr 2019 23:00:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190326220906.111879-1-jonathantanmy@google.com>
 <cover.1553895166.git.jonathantanmy@google.com> <44de02e584f449481e6fb00cf35d74adf0192e9d.1553895166.git.jonathantanmy@google.com>
 <20190404024710.GO32732@szeder.dev> <nycvar.QRO.7.76.6.1904051528130.41@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1904051528130.41@tvgsbejvaqbjf.bet>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 7 Apr 2019 08:00:08 +0200
Message-ID: <CAP8UFD1qK61MtJ-XeMuwY4W2V0CdHeZQC9rQap1M+nEeaLmBJQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] diff: batch fetching of missing blobs
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Fri, Apr 5, 2019 at 3:38 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:

> On Thu, 4 Apr 2019, SZEDER G=C3=A1bor wrote:
>
> > On Fri, Mar 29, 2019 at 02:39:28PM -0700, Jonathan Tan wrote:
> > > diff --git a/t/t4067-diff-partial-clone.sh b/t/t4067-diff-partial-clo=
ne.sh
> > > new file mode 100755
> > > index 0000000000..349851be7d
> > > --- /dev/null
> > > +++ b/t/t4067-diff-partial-clone.sh
> > > @@ -0,0 +1,103 @@
> > > +#!/bin/sh
> > > +
> > > +test_description=3D'behavior of diff when reading objects in a parti=
al clone'
> > > +
> > > +. ./test-lib.sh
> > > +
> > > +test_expect_success 'git show batches blobs' '
> > > +   test_when_finished "rm -rf server client trace" &&
> > > +
> > > +   test_create_repo server &&
> > > +   echo a >server/a &&
> > > +   echo b >server/b &&
> > > +   git -C server add a b &&
> > > +   git -C server commit -m x &&
> > > +
> > > +   test_config -C server uploadpack.allowfilter 1 &&
> > > +   test_config -C server uploadpack.allowanysha1inwant 1 &&
> > > +   git clone --bare --filter=3Dblob:limit=3D0 "file://$(pwd)/server"=
 client &&
> > > +
> > > +   # Ensure that there is exactly 1 negotiation by checking that the=
re is
> > > +   # only 1 "done" line sent. ("done" marks the end of negotiation.)
> > > +   GIT_TRACE_PACKET=3D"$(pwd)/trace" git -C client show HEAD &&
> > > +   grep "git> done" trace >done_lines &&
> > > +   test_line_count =3D 1 done_lines
> >
> > These patches and 'cc/multi-promisor' don't seem to work well
> > together, and all tests checking 'test_line_count =3D 1 done_lines' in
> > this test script fail in current 'pu', because there are two
> > "git> done" lines.
>
> I investigated a little further, and it would seem that it is neither thi=
s
> patch nor the cc/multi-promisor patches that introduce the problem, but
> the merge between the two... The latter tries to get away from using the
> global variable `repository_format_partial_clone` while this patch
> introduces another user.

Thanks for investigating! Yeah, that's part of the problem.

The fix I would suggest is:

diff --git a/diff.c b/diff.c
index f685ab10b5..a2b1241f83 100644
--- a/diff.c
+++ b/diff.c
@@ -26,6 +26,7 @@
 #include "parse-options.h"
 #include "help.h"
 #include "fetch-object.h"
+#include "promisor-remote.h"

 #ifdef NO_FAST_WORKING_DIRECTORY
 #define FAST_WORKING_DIRECTORY 0
@@ -6489,7 +6490,7 @@ static void add_if_missing(struct oid_array *to_fetch=
,

 void diffcore_std(struct diff_options *options)
 {
-    if (repository_format_partial_clone) {
+    if (has_promisor_remote()) {
         /*
          * Prefetch the diff pairs that are about to be flushed.
          */
@@ -6506,8 +6507,7 @@ void diffcore_std(struct diff_options *options)
             /*
              * NEEDSWORK: Consider deduplicating the OIDs sent.
              */
-            fetch_objects(repository_format_partial_clone,
-                      to_fetch.oid, to_fetch.nr);
+            promisor_remote_get_direct(to_fetch.oid, to_fetch.nr);
         oid_array_clear(&to_fetch);
     }

I will send a new version with the above soon based on top of
jt/batch-fetch-blobs-in-diff in pu.
