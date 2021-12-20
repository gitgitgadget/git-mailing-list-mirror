Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB085C433EF
	for <git@archiver.kernel.org>; Mon, 20 Dec 2021 18:33:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240303AbhLTSd5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Dec 2021 13:33:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232319AbhLTSd4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 13:33:56 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3065EC061574
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 10:33:56 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id f5so18993336edq.6
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 10:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=bnKdWeA13gQuQ2EG1n9qCIsGrPK7q1CjownNkD9hf2o=;
        b=IAZcwBormLB25Y9xmRSiPcO/OPkya0Qjb86etll4qu1knfYaY82kCDI5b+bkQGxWqn
         LUcJU9ZH4svqUxWWvt3YoJAfa5VpocicpAhERBMJJfTfnf9p6AmmULfFhUqUceWeS7CL
         4zMOzdvLSm7MTJnDrvXCPuNQ0buD4kWcN44b4sHiIQIxkmUQDEaKAKYMmGOBiSwiqv1W
         VkyBkGcxZxdB69g7pgrZpTMA509/m5KAcBQ1Jy2uzXAGS87ZMfizuLnv8avK/fSCQVfi
         f1ILPQVVopzA5TC/I+LJNn78sasXv7OjdhEuDPhvYEjdKQ+odHAncB5G1syKfyENASc1
         szzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=bnKdWeA13gQuQ2EG1n9qCIsGrPK7q1CjownNkD9hf2o=;
        b=7YNhMKuevtNVIaRh294WuM+ptupavFTI+uuRfZMyaW5kasBIlHIdi88nqD/bw0jyBx
         23302Pyy3fP+2Q32aT8j7dULW37JI+l+Wzy4xC2jvR5Md3Zve4S+YlSmfwzjX1opMkiP
         8dAYOk0oSkLqGo+yU17mV6UiV6892Sgo+Rtlo04m2/lxBHtJskntlQ67PoR8PSz9XHtr
         0BnCwaH+E7f7ArE1DoMDWY88K9tYFgGeVXdjOlGnjeQO5diTqkUR+4SsfLfp69CrMp+A
         4KWmbAQwwtHAlotWs4xemAwJq1pHDYaBdgplDaN85pUcZ+49gLxs6+5tVe+DjGgpRBgW
         Yj+Q==
X-Gm-Message-State: AOAM533CBpMG+RnhQxmd3WZlQYWjtRT9jPcaK8sUz3GgvFMAgZwS3dMz
        aN06vA+NDYQQ/38BprzESGM=
X-Google-Smtp-Source: ABdhPJzgAVPw5gjClrwUznmlOmrDwDoiulyahSp7y3MeUDn/aKXPb03nklkWnhFmH5mpEjGu7nRGWA==
X-Received: by 2002:a17:906:a091:: with SMTP id q17mr13817551ejy.669.1640025234643;
        Mon, 20 Dec 2021 10:33:54 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id r17sm3717843edd.53.2021.12.20.10.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 10:33:54 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mzNTt-000WMO-IB;
        Mon, 20 Dec 2021 19:33:53 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Adam Spiers <git@adamspiers.org>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 03/13] init: unconditionally create the "info" directory
Date:   Mon, 20 Dec 2021 19:16:22 +0100
References: <cover-00.13-00000000000-20211212T201308Z-avarab@gmail.com>
 <patch-03.13-784b7947512-20211212T201308Z-avarab@gmail.com>
 <db6f47a3-0df3-505b-b391-6ca289fd61b5@gmail.com>
 <211220.86tuf3utv9.gmgdl@evledraar.gmail.com>
 <d2399072-ce9d-b654-42b4-d08d973c488e@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <d2399072-ce9d-b654-42b4-d08d973c488e@gmail.com>
Message-ID: <211220.86zgovt9bi.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Dec 20 2021, Derrick Stolee wrote:

> On 12/20/2021 11:13 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>=20
>> On Mon, Dec 20 2021, Derrick Stolee wrote:
>>=20
>>> On 12/12/2021 3:13 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>>> But we've also grown a hard dependency on this directory within git
>>>> itself. Since 94c0956b609 (sparse-checkout: create builtin with 'list'
>>>> subcommand, 2019-11-21) released with v2.25.0 the "git
>>>> sparse-checkout" command has wanted to add exclusions to
>>>> "info/sparse-checkout". It didn't check or create the leading
>>>> directory, so if it's omitted the command will die.
>>>
>>>> Even if that behavior were fixed we'd be left with older versions of
>>>> "git" dying if that was attempted if they used a repository
>>>> initialized without a template.
>>>
>>> This, I don't understand. Why can't we add a
>>> safe_create_leading_directories() to any place where we try to
>>> create a sparse-checkout file?
>>>
>>> This would fix situations where older versions were init'd with a
>>> different template or if the user deleted the info dir. The change
>>> you've made here doesn't fix those cases, which is what you are
>>> claiming is the reason to not do the other fix that seems like it
>>> would.
>>>
>>> What am I misunderstanding here?
>>=20
>> I'll clarify that a bit in any re-roll.
>>=20
>> Pedantically nothing changes, i.e. you can create a repository with an
>> empty template now, and it'll break on both the sparse-checkout on that
>> version, and any previous version that had that un-noticed issue.
>
> You continue after this with more motivations for adding 'init'=20
> unconditionally, which I am not fighting.
>
> What I _am_ saying is important is that if we are trying to write
> a file to a known location and its parent directory doesn't exist,
> then we should create it. Not doing so is a bug and should be
> fixed, no matter how rare such a thing is to occur. As you've
> shown, it is not required to have an info directory until we need
> one (e.g. for sparse-checkout or an excludes file).
>
> If you're not planning to add that to this series, then I'll add it
> to my list. I do think it would fit well into this one, though.

Ah, you mean for the case where "git sparse-checkout" will fail because
.git/info/ doesn't exist now (e.g. because it's an existing repo with
--template=3D).

Yes that bug will not be fixed by this series. I'd welcome a patch to
fix it & could even integrate it with this series.

But I just found it rather "meh" and not that worth fixing. I.e. that it
hasn't been noticed or reported until now shows that this is a very rare
mode of operation. It seems most people just "git init" or "git clone",
or maybe almost nobody uses "sparse-checkout". I don't know.

I did try to fix it in an earlier version of this.

Maybe I went overboard with that, but I didn't just sprinkle
safe_create_leading_directories() to every caller as you suggest, but
rather wanted to change the API so that cases like:

        sparse_filename =3D get_sparse_checkout_filename();
        res =3D add_patterns_from_file_to_list(sparse_filename, "", 0, &pl,=
 NULL, 0);
        free(sparse_filename);

Would just call some function saying "add to sparse excludes", and not
care about the filename. Since having the API at that levels means you
end up with a lot of accounting work of getting the filename, freeing it
etc.

E.g. this as another example from add_patterns_cone_mode() (the function
makes no other use of sparse_filename):

	char *sparse_filename =3D get_sparse_checkout_filename();
        [...]
        if (add_patterns_from_file_to_list(sparse_filename, "", 0,
                                           &existing, NULL, 0))
                die(_("unable to load existing sparse-checkout patterns"));
        free(sparse_filename);

But per the upthread rationale I figured "meh" on that and that just
changing "git init" would fix the problem going forward in practice, so
I didn't pursue it.

Won't unconditionally adding a safe_create_leading_directories() also
close the door to having a core.sparseCheckoutFile similar to
core.excludesFile (but maybe it makes no sense). I.e. we'd be free to
"mkdir -p" the .git/info, but if the user is pointing it to some other
path then blindly creating that possibly nested path might be confusing,
as opposed to just immediately erroring out.

So...

All of which is to say that if you'd like to untangle it I'll review it,
and would be happy to include it in this series. But for the
--no-template change I thought I'd just try to sidestep that particular
aspect.
