Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 537AA20966
	for <e@80x24.org>; Tue,  4 Apr 2017 10:13:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753683AbdDDKNI (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Apr 2017 06:13:08 -0400
Received: from mail-oi0-f41.google.com ([209.85.218.41]:35711 "EHLO
        mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753403AbdDDKMy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Apr 2017 06:12:54 -0400
Received: by mail-oi0-f41.google.com with SMTP id f193so157083881oib.2
        for <git@vger.kernel.org>; Tue, 04 Apr 2017 03:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=U0NiT4H7/i9JIgG1yqvpEJ8lBOieuNQ1PLZAKe699YQ=;
        b=nYjC3+93lqoS71/SXVfjJamm6QrG6Y8kjv5i5cdqx6kNOIKHHueFPyH6aPugRN58Ib
         nv0FIAFOxtDjXKAnxvPpIQzHMDl4iKeez8tSBp+0HGS9sIhSrUl1PHCfzccbFgKQFb6R
         w1gosEinqbwR6940ogwcuW7czdtZni+tJjZcBY8KeEZcVY71I8S/G5w1crgrDnPwATZE
         dkj2xNIpXdgdrttJnabvuKZFvxRwHEJOQ5pDv0T9UwQAdZzVLjwhWG1JwLPMYvStF1Ze
         7/pcb/M3JuCX9Rdrrg0kPmxVEHwjgJee1gi95iDbX2bFP92847IpxE8W4EKKFc6bOAyQ
         sMkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=U0NiT4H7/i9JIgG1yqvpEJ8lBOieuNQ1PLZAKe699YQ=;
        b=rF2VUL/vs+RaZHAni8BrgW5rFu/GMMTUxZrsAnFzBRWR2JfynUum0i7XLZ3h2qBH5G
         +rJxZmhXtRORWRknISRlkI0LUXIE3Gix4JPnRkDCB7UxtYNflfy6CnfY1AY/Qfmqof8n
         TIF7ghZBPl9MQaNkp+vreeoBVa6mmr10prMmvoY8NF6DK5GZXRCmukiCohQmEu9DMNyw
         /Ou9QouoxujKhmA0AMNQShtANJKIA1luk7wGpt6YzuNMmbVUGFJQl/wP3HT/nSBSuEOK
         5Bn7iK7zHR09ItJboi76W2MP3teeHbBBe86ZAe1q1ulHMzKGX/EGfsZPwxu6r7IjwlfE
         UeZw==
X-Gm-Message-State: AFeK/H0a/dkQ/2zafT4AOH9YCMbUIwc2q3fIP8x8y+G9VWuWPlIO/vter7Z8k1/N4Q80V55sTF2hMlwVptXbUQ==
X-Received: by 10.157.46.145 with SMTP id w17mr12253710ota.225.1491300773814;
 Tue, 04 Apr 2017 03:12:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.158.70 with HTTP; Tue, 4 Apr 2017 03:12:23 -0700 (PDT)
In-Reply-To: <xmqqinmq4nkb.fsf@gitster.mtv.corp.google.com>
References: <20170325130549.GA20618@ash> <20170330113723.20474-1-pclouds@gmail.com>
 <20170330113723.20474-2-pclouds@gmail.com> <xmqqinmq4nkb.fsf@gitster.mtv.corp.google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 4 Apr 2017 17:12:23 +0700
Message-ID: <CACsJy8CbOFAviPo9tCJ-4+ritd5WQboGHDyxaCxBK1UMZe0+kQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] config: resolve symlinks in conditional include's patterns
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 31, 2017 at 1:38 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:
>
>> $GIT_DIR returned by get_git_dir() is normalized, with all symlinks
>> resolved (see setup_work_tree function). In order to match paths (or
>> patterns) against $GIT_DIR char-by-char, they have to be normalized
>> too. There is a note in config.txt about this, that the user need to
>> resolve symlinks by themselves if needed.
>>
>> The problem is, we allow certain path expansion, '~/' and './', for
>> convenience and can't ask the user to resolve symlinks in these
>> expansions. Make sure the expanded paths have all symlinks resolved.
>
> That sounds sensible but I fail to see why 1/2 is the right approach
> to do this, and I must be missing something.  Wouldn't you get the
> same result if you run realpath() yourself on expanded, after
> receiving the return value of expand_user_path() in it?

Because at that point I don't know what part is $HOME (i.e. valid path
that real_path can walk through), what part is random wildcards from
the pattern. Note that in this case we pass a wildmatch pattern to
expand_user_path(), like ~/[ab]foo/*bar*/**. After expansion it
becomes /home/pclouds/[ab]foo/*bar*/**. It does not feel right to let
real_path() walk the "[ab]foo..." part. In the tests, I hit
die("Invalid path") in strbuf_realpath(). Even if I set die_on_error()
to avoid that, strbuf_realpath() will not return the resolved path

> Can you add a test to demonstrate the issue (which would need to be
> protected with SYMLINKS prereq)?

Will do. It may look a bit ugly though because I have to force
setup_git_directory() to call real_path() because it doesn't always do
that.
--=20
Duy
