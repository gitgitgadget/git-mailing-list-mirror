Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E07D8C74A5B
	for <git@archiver.kernel.org>; Thu, 23 Mar 2023 23:59:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjCWX7T (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Mar 2023 19:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjCWX7R (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2023 19:59:17 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E04562BF25
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 16:59:16 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id r29so132706wra.13
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 16:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679615955;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S1VzF+iFq+1elH6o4DIlRXkn1CgikpMnDou2IVz1LJE=;
        b=aacsNa0KRYJwiIUErf++rfX1s2Vq7WbFc3OTXNseu0QOzzV4jNXCuL5EzJJPARLlg6
         IFV0hYhPvT24cgJWg2OU/Xn55mbxNBqR6UkV2MV0ne1pqMbXZjD89JcivjB3WU9trYAr
         ZlncMKx/HmvezM9zIhB4FOTNacJIH6P3tdfN+mR89vLHDIPUEA/M8xag144188JdS/pU
         dFla1W60WsVlPFXcYNRe8y2TM9jAlnqk/1UqSCjxw7NT4GjQLUOC4ak9+Ks35/N/B0pl
         N3YAjc4LCtrSVZgpcKBwk11o1rCX/5CcqFgltU0xl/NlIF9BDHUNPUoCtHlvR3Eg30al
         kgOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679615955;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S1VzF+iFq+1elH6o4DIlRXkn1CgikpMnDou2IVz1LJE=;
        b=ttlnjclkbMXwKTD5MF3EIYyQ1sltZ4sh9qLed5mYvIDusl0taRv8kQdh0NHSaTpUYK
         Vh3eeE+K96LoDoklKpw5xzhEgmX9Kow8i9QVnn+4p0xvH9VfUvmrUK615FO/x4f60qzR
         dKx3Lt0r9SvZshae8W2zYwQG03mhemcuu+Wi8RlO3EPlY2glDe6iSw1qnIyWUI9XIcli
         U555dHfgP7+vy61Wvw6uR28XKCLgX9D/lkPLtBYd1jpSbZCzTf32x1rpZMj8vU8MBP0P
         7CXTlSiuk8+7fiQC7B5B13mSZaWSRsakomgfT8uampoGVJb0kKxE8Xd/Q2JIVBVeFUp7
         ZVNw==
X-Gm-Message-State: AAQBX9fQ7saUHC16G+MH6cEcelXexBiZ+Hv3W+Kz+bCuih4SJF3gq7v+
        OmKYakdE/eexHHmNOESCAqBE7o+fZ92JFmBeyvQ=
X-Google-Smtp-Source: AKy350ajyQT9ASRtGQCNIJR36WIy9lzVr6peRPglvNdiAI7/YxS3rbSRYGhkllocO9nWze/n/uFyKZSFMQ8BF9j1kLc=
X-Received: by 2002:adf:f782:0:b0:2ce:abd2:13f3 with SMTP id
 q2-20020adff782000000b002ceabd213f3mr188220wrp.5.1679615955007; Thu, 23 Mar
 2023 16:59:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230320205241.105476-1-cheskaqiqi@gmail.com> <20230322161820.3609-1-cheskaqiqi@gmail.com>
 <xmqqilesbbph.fsf@gitster.g> <CAMO4yUFshQ_bP3gXeZhfHQ3OevC+_3qKwa-iy2nNGScvRouu6Q@mail.gmail.com>
 <xmqqlejna20n.fsf@gitster.g>
In-Reply-To: <xmqqlejna20n.fsf@gitster.g>
From:   Shuqi Liang <cheskaqiqi@gmail.com>
Date:   Thu, 23 Mar 2023 19:59:03 -0400
Message-ID: <CAMO4yUFG2EnEPM3AqXbywpZp2rYU_emJgE5h3_tY+u2ZMXqrhA@mail.gmail.com>
Subject: Re: [PATCH v7 0/2] diff-files: integrate with sparse index
To:     Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>,
        git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio

On Thu, Mar 23, 2023 at 12:03=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:

> > When the index file is not up-to-date, git diff-files may show differen=
ces
> > between the working directory and the index that are caused by file cre=
ation
> > time differences, rather than actual changes to the file contents. By u=
sing git
> > diff-files --stat, which ignores file creation time differences.
>
> Use of "diff-files --stat" would mean that the contents of the blob
> registered in the index will be inspected, which can be used to hide
> the "stat dirty" condition.
>
> But doesn't it cut both ways?  Starting from a clean index that has
> up-to-date stat information for paths, we may want to test what
> "stat dirty" changes diff-files reports when we touch paths in the
> working tree, both inside and outside the spase cones.  A test with
> "--stat" will not achieve that, exactly because it does not pay
> attention to and hides the stat dirtiness.

In this case, we can only use 'git diff-files --stat' when files are
present on disk without modifications. Since we know in the
full-checkout case 'diff-files --stat' will give empty output, so
sparse-checkout and sparse-index are also empty. These make
sure that the paths in the working tree are not dirty. So we do not
need to pay attention to 'stat dirty' change.

When 'file present on-disk with modifications'. We use 'git diff-files'
instead of  'git diff-files --stat' so we can get the expected
"modified" status but avoids potential breakages related to
inconsistency in the file creation time.

# file present on-disk without modifications
# use `--stat` to ignore file creation time differences in
# unrefreshed index
test_all_match git diff-files --stat &&
test_all_match git diff-files --stat folder1/a &&
test_all_match git diff-files --stat "folder*/a" &&

# file present on-disk with modifications
run_on_all ../edit-contents folder1/a &&
test_all_match git diff-files &&
test_all_match git diff-files folder1/a &&
test_all_match git diff-files "folder*/a"

> On the other hand, if "update-index --refresh" is used in the test,
> we may discover breakages caused by "update-index" not handling
> the sparse index correctly.  It would be outside the topic of this
> series, so avoiding it would be simpler, but (1) if it is not broken,
> then as you said, it would be a more direct way to test diff-files,
> and (2) if it is broken, it would need to be fixed anyway, before or
> after this series.  So, I dunno...

Thanks
Shuqi
