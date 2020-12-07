Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C39D9C4361B
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 20:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C89D238A0
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 20:45:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726405AbgLGUot (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Dec 2020 15:44:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbgLGUot (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Dec 2020 15:44:49 -0500
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D0D8C061749
        for <git@vger.kernel.org>; Mon,  7 Dec 2020 12:44:09 -0800 (PST)
Received: by mail-qv1-xf41.google.com with SMTP id p12so7194639qvj.13
        for <git@vger.kernel.org>; Mon, 07 Dec 2020 12:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=wKwEUKPGUzPjNF18tkP6XNsPb/EfkO/PXTLNVR2EMU4=;
        b=Zgo9/Wf57+hp15wpNaQw6a2i3iX+OnGsvR1Mx7xYzf80CBNn4TcrZHQxVk5Kq3EHOE
         vm+A+5FqwjlWF2FCd+JDkIM9BAf1E6qT36e28GVi7CqQuhRPILUxAFUp3aAD7YigSKI3
         3Q0jxNnWfLSFKsqzhNpz7xb8ChHe75s5lYdKUXfWUr6aBBDHxEKz188dshk6zxAgVeUu
         SilyD+4sqMGcYcrxj7srbZZgXXYeyNtGZ1XyaIgHk4vgGBxUL2J8Iaxgjn+c+alEhkYO
         biZiNCjpvsBovZANMLuuHINom/8XvK8/mHqzdu2o4QKsgDoVhoFQQ4sXkd82XHxC5MnO
         BQeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=wKwEUKPGUzPjNF18tkP6XNsPb/EfkO/PXTLNVR2EMU4=;
        b=sahH6jykq5ZEQsT135mCQLU8N/bNOHplFZinSfGf6wRtD8X8sZjMGnYzYeipAxdAzU
         zdxBAMiZd8TqhkiDc+366fLWlTaaMqKK70JgrIt1iwaj0efCZfdVAFv6ZGqyFl4iIvvI
         eYS53wJRoKAYGs+pl3zeaI5HNNQrZX3HU/60j0VH2JcQ9ZFkbfDslACeXflijA0htqJA
         pL7wSvrBhlhk1GKliyBRQrcq1iu/+rQwBpxZVb4YirjMCGE22RrYVsAwnG0Bw2I9f81V
         EwBhkK0AflOSqvVIDsFHJPYmJ5CEXz+I6OgdhSJOvxKm1CGc2+njtumVTcrjk+qz9kP7
         wJVw==
X-Gm-Message-State: AOAM532nvhJCbJYds9QAsvGbkoCzTUnySYczV5f8JSqtzA9PuZZ/3GrR
        IuSRE52dDOzpyCSSJRivLyg=
X-Google-Smtp-Source: ABdhPJxjW9ZevuJJcublD9nm7ftTB0RP8Ppn0ESMQ1dRI388iQfbyE1ZhHoQmco1idS6j7XESUDPIg==
X-Received: by 2002:ad4:4e31:: with SMTP id dm17mr9688230qvb.27.1607373848405;
        Mon, 07 Dec 2020 12:44:08 -0800 (PST)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id v13sm12867701qkb.130.2020.12.07.12.44.07
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Mon, 07 Dec 2020 12:44:07 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v2] submodules: fix of regression on fetching of non-init subsub-repo
From:   Philippe Blain <levraiphilippeblain@gmail.com>
In-Reply-To: <xmqq360hbev1.fsf@gitster.c.googlers.com>
Date:   Mon, 7 Dec 2020 15:44:06 -0500
Cc:     Peter Kaestle <peter.kaestle@nokia.com>,
        Git mailing list <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.us>,
        Ralf Thielow <ralf.thielow@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <BF6B37E9-5AF9-4A81-90D8-0270D1269332@gmail.com>
References: <CAPig+cQ8VC2q4nuzgM9QxmddH4cMezbZdRZDxX1PqfW6XKcC_A@mail.gmail.com> <1607348819-61355-1-git-send-email-peter.kaestle@nokia.com> <xmqq360hbev1.fsf@gitster.c.googlers.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

> Le 7 d=C3=A9c. 2020 =C3=A0 14:22, Junio C Hamano <gitster@pobox.com> a =
=C3=A9crit :
>=20
> Peter Kaestle <peter.kaestle@nokia.com> writes:
>=20
>> +add_commit_push () {
>> +	dir=3D"$1" &&
>> +	msg=3D"$2" &&
>> +	shift 2 &&
>> +	git -C "$dir" add "$@" &&
>> +	git -C "$dir" commit -a -m "$msg" &&
>> +	git -C "$dir" push
>> +}
>> +
>> +compare_refs_in_dir () {
>> +	fail=3D &&
>> +	if test "x$1" =3D 'x!'
>> +	then
>> +		fail=3D'!' &&
>> +		shift
>> +	fi &&
>> +	git -C "$1" rev-parse --verify "$2" >expect &&
>> +	git -C "$3" rev-parse --verify "$4" >actual &&
>> +	eval $fail test_cmp expect actual
>> +}
>=20
>=20
>=20
>> +test_expect_success 'fetching a superproject containing an =
uninitialized sub/sub project' '
>> +	# depends on previous test for setup
>> +
>> +	git -C B/ fetch &&
>> +	compare_refs_in_dir A origin/master B origin/master
>=20
> Can we do this without relying on the name of the default branch?
> Perhaps when outer, middle and inner are prepared, they can be
> forced to be on the 'sample' (not 'master' nor 'main') branch, or
> something like that?

Or, simpler, we could call "git remote set-head -a'=20
in A and B in the setup script, which would make
origin/HEAD in A and B point to the default branch,=20
such that the call here could be :

compare_refs_in_dir A origin/HEAD B origin/HEAD

Philippe.

