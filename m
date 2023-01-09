Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E7ADC54EBD
	for <git@archiver.kernel.org>; Mon,  9 Jan 2023 04:42:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236397AbjAIEmN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Jan 2023 23:42:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236593AbjAIEl2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Jan 2023 23:41:28 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9430FC9
        for <git@vger.kernel.org>; Sun,  8 Jan 2023 20:40:35 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id c82so239310ybf.6
        for <git@vger.kernel.org>; Sun, 08 Jan 2023 20:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+TAGEZ67LoOf5p1kyE8FyWkGcLSIl7K/ezzx+GYjEBk=;
        b=Nz6l8DdKzvI3xw5S1/OPF+fmcHU39OBug0ZbrJ3OElMd8dpjulVRzENFXBkFB4vdAN
         sUMO2D3yFKimAS6Hm0gQArkrxDZHTh5auIR9lQ+4vj0fVT3x5tbKTsPz0Ws8r9ak+eJQ
         bE+4PYK/DZ5abrbSCBpXeJHcCIELe1EAcX5kbmKBvEa1vO+/XGhRtfPjCB9SqxUSIP2e
         U2gkUhmZoTMhwCyGOiZlBrACYl6ryK0dzFj8xDKn8lKk/KGlrEOkWwlRsQ1T3tO6FcOk
         SnTR9zl2f7Jxgc0/bOslbDDd6AODncu5HDONfvpLz7sopmQgK8Hxx5xnnQ3IS5IfMtsc
         79FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+TAGEZ67LoOf5p1kyE8FyWkGcLSIl7K/ezzx+GYjEBk=;
        b=XqKfCGXAytjXib6Qvfter5U0xzsqCzNnAwM0tCDUuGIV46TFvCLqWSMNbPjmMfDXOR
         9a6uKT/+mllDNPRgFyF3Zia5x91/yeoW400p++SBlSEmMR0psrUnUZxAxor6p5JynJXY
         qNFNexls6/s4KIKrA6BHN6a/uuyneda+ed53kmrBWP0Mya9nzAxTZBftMghW0JEtWIG+
         37+bh7e54FHfXjpOKIbkUlk2Gkl5u5diBNR+MGJaNzaVfMqxiSFLOKpbZCMtRC+Cm4MO
         sW9MKaEhzIQhRde3/eAkWbFqXbMzV2biUAClsnXc7x5+0ZNfeL87Ubmbzt6Ip75aZRN1
         z8Ag==
X-Gm-Message-State: AFqh2kqPwwpyH/kguV+BF3LrTuQlqyX8rEtNwaYtChDTLUoEPOVmxrLy
        J1WY7unhaCkh4YsXJyUhQg2FsgMeV7GI6O+Brs+FUu00ufM=
X-Google-Smtp-Source: AMrXdXuiVYZ6owATJtyEBQHblGBbCv8YQNJDw+6Uc4ome9zCbjXqa6CpXhU5IxYfmdpEVShtRwYS+6y8irAr7MMVgLk=
X-Received: by 2002:a25:8d10:0:b0:7ba:b57:f639 with SMTP id
 n16-20020a258d10000000b007ba0b57f639mr580103ybl.103.1673239234713; Sun, 08
 Jan 2023 20:40:34 -0800 (PST)
MIME-Version: 1.0
References: <CA+PPyiG=+rs_bOQbaNB311_DVdSc2g44SkLzpaqOER7rfxykrQ@mail.gmail.com>
 <CAP8UFD2huFgTjB1hNGyGnMKPONOG6ZV-wvxWkTaz-iZNfxrhJA@mail.gmail.com>
In-Reply-To: <CAP8UFD2huFgTjB1hNGyGnMKPONOG6ZV-wvxWkTaz-iZNfxrhJA@mail.gmail.com>
From:   NSENGIYUMVA WILBERFORCE <nsengiyumvawilberforce@gmail.com>
Date:   Sun, 8 Jan 2023 23:40:07 -0500
Message-ID: <CA+PPyiHOLUm87eHuxyhbqqML33Q6g-he_DKRxTEb2fu-2p3NSQ@mail.gmail.com>
Subject: Re: Github actions failing
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> There is the following in the above log:
>
> > 2293 error: cannot run gpg: No such file or directory
>
> so maybe gpg isn't installed on the test system.
>
> It looks like the test you added doesn't have the "GPG" prerequisite. Compare:
>
> -> test_expect_success 'test bare signature atom'
>
> with:
>
> -> test_expect_success GPG 'show good signature with custom format'
>
> There is a "GPG" prerequisite in the latter but not the former.
>
Thanks, I missed the GPG flag. Now I get the following after forcing
the push. I have been looking for the problem but I can't figure it
out. I will be glad for any help
>
> git checkout -b signed &&
> 1840 echo 1 >file && git add file &&
> 1841 test_tick && git commit -S -m initial &&
> 1842 git verify-commit signed 2>out &&
> 1843 head -3 out >expected &&
> 1844 tail -1 out >>expected &&
> 1845 echo >>expected &&
> 1846 git for-each-ref refs/heads/signed --format="%(signature)" >actual &&
> 1847 test_cmp actual expected
> 1848
> 1849 + git checkout -b signed
> 1850 Switched to a new branch 'signed'
> 1851 + echo 1
> 1852 + git add file
> 1853 + test_tick
> 1854 + test -z set
> 1855 + test_tick=1112912113
> 1856 + GIT_COMMITTER_DATE=1112912113 -0700
> 1857 + GIT_AUTHOR_DATE=1112912113 -0700
> 1858 + export GIT_COMMITTER_DATE GIT_AUTHOR_DATE
> 1859 + git commit -S -m initial
> 1860 [signed 4dc4b90] initial
> 1861 Author: A U Thor <author@example.com>
> 1862 1 file changed, 1 insertion(+)
> 1863 create mode 100644 file
> 1864 + git verify-commit signed
> 1865 + head -3 out
> 1866 + tail -1 out
> 1867 + echo
> 1868 + git for-each-ref refs/heads/signed --format=%(signature)
> 1869 + test_cmp actual expected
> 1870 + test 2 -ne 2
> 1871 + eval diff -u "$@"
> 1872 + diff -u actual expected
> 1873 --- actual 2023-01-08 19:40:42.169214115 +0000
> 1874 +++ expected 2023-01-08 19:40:42.121213837 +0000
> 1875 @@ -1,4 +1,5 @@
> 1876 gpg: Signature made Sun Jan 8 19:40:42 2023 UTC
> 1877 gpg: using DSA key 13B6F51ECDDE430D
> 1878 +gpg: checking the trustdb
> 1879 gpg: Good signature from "C O Mitter <committer@example.com>"
> 1880
> 1881 error: last command exited with $?=1
> 1882 not ok 338 - test bare signature atom




On Sun, Jan 8, 2023 at 1:17 PM Christian Couder
<christian.couder@gmail.com> wrote:
>
> Hi,
>
> On Sun, Jan 8, 2023 at 11:07 AM NSENGIYUMVA WILBERFORCE
> <nsengiyumvawilberforce@gmail.com> wrote:
> >
> > Hi,
> > So I wanted to send the next patch after review.  All the tests pass
> > when I run them on my PC but I get something like the following error
> > when I test from my git branch
> > >
> > > + git checkout -b signed
> > > 2283 Switched to a new branch 'signed'
> > > 2284 + echo 1
> > > 2285 + git add file
> > > 2286 + test_tick
> > > 2287 + test -z set
> > > 2288 + test_tick=1112912113
> > > 2289 + GIT_COMMITTER_DATE='1112912113 -0700'
> > > 2290 + GIT_AUTHOR_DATE='1112912113 -0700'
> > > 2291 + export GIT_COMMITTER_DATE GIT_AUTHOR_DATE
> > > 2292 + git commit -S -m initial
> > > 2293 error: cannot run gpg: No such file or directory
> > > 2294 error: gpg failed to sign the data
> > > 2295 fatal: failed to write commit object
> > > 2296 error: last command exited with $?=128
> > > 2297 not ok 338 - test bare signature atom
> > What could be wrong?
>
> There is the following in the above log:
>
> > 2293 error: cannot run gpg: No such file or directory
>
> so maybe gpg isn't installed on the test system.
>
> It looks like the test you added doesn't have the "GPG" prerequisite. Compare:
>
> -> test_expect_success 'test bare signature atom'
>
> with:
>
> -> test_expect_success GPG 'show good signature with custom format'
>
> There is a "GPG" prerequisite in the latter but not the former.
