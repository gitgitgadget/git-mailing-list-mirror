Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B56E2C433F5
	for <git@archiver.kernel.org>; Sun, 27 Mar 2022 11:39:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233663AbiC0Lfl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Mar 2022 07:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233345AbiC0Lfj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Mar 2022 07:35:39 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E9532B197
        for <git@vger.kernel.org>; Sun, 27 Mar 2022 04:34:01 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id c10so4959030ejs.13
        for <git@vger.kernel.org>; Sun, 27 Mar 2022 04:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=5Bzp3S3V05iGy1hP2gIFZ5pH8hLirbfVu4OUzKPccS8=;
        b=NnCBCtsB6imRXzrP3dW8VNwT+o+ZCK/v204jyKp16XwjITp27FM0AlL0pomUnAPqUd
         FG4BYoUuZC8N66HacrXSPVSatLUcDgIxOswm1EoslsSGyTvFdjz2jlw4mdN2+c7cHYNp
         rr4LWeHP26bPuiRjJZx/NyKZAxyEPTQtQSLRhHa9oKIAU/lBQRBMPQryH9yqhsbgbTUY
         0ziHianTayppw1oP2ANQtAPNZp4htoUUiphyrje0d1NSMBrojrXJG8NUCT0auZsGZb91
         BJuBljqAYznNY33YPzOEi2MK6x40kUUo1yjJmzjWNi2qLDA75uI+C5AchalKZoE3Dpeq
         bf2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=5Bzp3S3V05iGy1hP2gIFZ5pH8hLirbfVu4OUzKPccS8=;
        b=6QOqRU9DYkWfnBB9+6HyhjxhZ7rEP8H/RKeduXZSWJ/HKZJokL5XrtOa/Vi/ZoIC5S
         7t/ET30AVpoVdr6TeqAzfXWFdlLNVVpfkDatTKatMShHj9S1aRMDGdCetRvapndd1BAW
         CZkhiwwFN2h8s5DncaUCb8u7EO9wA+rP1weHhyAgYRwEXjXZOexu1JSbXwGEkDKYCLnn
         6BJ+2anfjTL3xU9p9r0u4UhvWoC8vZnt7GdFSPT1WBFeFy0R9RYcnRtCsc1DYqn1z1pR
         ho/wECqE4gny6ojxE7FF8mpGNqtVE2k38+OohanebF+hLPkaXRedEmDhQtw0jTM+U5k+
         DumQ==
X-Gm-Message-State: AOAM530JVquuVbaZaF93VOl80SrM5Wnvb3Dl0hc/4GnJKdYvM7sTbNZC
        JEyeIwA7AQ658FqRtnmvdwY=
X-Google-Smtp-Source: ABdhPJwOZQ+wVhvGdEzOmRK/js3zf3TYD1TdkbmxWoDt/1S6qXDNfrTYJ5RcM3Q7j4fzyNhgeKe6Vw==
X-Received: by 2002:a17:907:6d0b:b0:6df:e54c:ad1d with SMTP id sa11-20020a1709076d0b00b006dfe54cad1dmr22326137ejc.734.1648380839479;
        Sun, 27 Mar 2022 04:33:59 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id c12-20020a05640227cc00b004192114e521sm5699103ede.60.2022.03.27.04.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Mar 2022 04:33:58 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nYR9i-002l5A-8x;
        Sun, 27 Mar 2022 13:33:58 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v3 7/7] git-sh-setup: don't mark trees not used in-tree
 for i18n
Date:   Sun, 27 Mar 2022 13:15:38 +0200
References: <cover-v2-0.5-00000000000-20211119T202455Z-avarab@gmail.com>
 <cover-v3-0.7-00000000000-20220326T171200Z-avarab@gmail.com>
 <patch-v3-7.7-7a82b1fd005-20220326T171200Z-avarab@gmail.com>
 <2e2d20d6-a33d-b223-d364-ab43d92dd220@kdbg.org>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.11
In-reply-to: <2e2d20d6-a33d-b223-d364-ab43d92dd220@kdbg.org>
Message-ID: <220327.8635j3fx3t.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Mar 27 2022, Johannes Sixt wrote:

> Am 26.03.22 um 18:14 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>> Partially revert d323c6b6410 (i18n: git-sh-setup.sh: mark strings for
>> translation, 2016-06-17).
>>=20
>> These strings are no longer used in-tree, and we shouldn't be wasting
>> translator time on them for the benefit of a hypothetical out-of-tree
>> user of git-sh-setup.sh.
>
> There is public documentation for these functions. Hence, you must
> assume that they are used in scripts outside of Git. Castrating their
> functionality like this patch does is unacceptable.

For require_clean_work_tree() the public documentation for this function
states that it will emit a specific error message in English, and you're
expected to Lego-interpolate a string that we'll concatenate with it:

	[...]It emits an error message of the form `Cannot
        <action>: <reason>. <hint>`, and dies.  Example:
	+
	----------------
	require_clean_work_tree rebase "Please commit or stash them."

So I think that marking it for translation like this as d323c6b6410 was
always broken in that it broke that documented promise.

But that's just an argument for keeping the require_clean_work_tree()
part of this patch, not require_work_tree_exists().

For that one and others in git-sh-setup we've never said that we'd
provide these translated (and to the extent we've implied anything about
the rest, have strongly implied the opposite with
require_clean_work_tree()'s docs).

Nothing will break for out-of-tree users as a result of this
change. When we added these functions and their documentation their
output wouldn't be translated, then sometimes it was, now it's not
again.

We need also need to be mindful of translator time, it's a *lot* of
strings to go through, and e.g. I've commented in the past on patches
that marked stuff in t/helper/ for translation.

Some hypothetical out-of-tree user is, I think, a much stronger
candidate for skipping translation than that.

Also keep in mind that we don't even translate in-tree contrib stuff
like contrib/subtree/ (the recent "not-really-contrib" scalar being an
exception).

So I really think this is fine as-is, don't you think that if someone
out-of-tree had such strong expectations about the human-readable
strings these emit that they'd have long since stopped using them and
provided their own replacements?
