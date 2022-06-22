Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A009C43334
	for <git@archiver.kernel.org>; Wed, 22 Jun 2022 15:46:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359422AbiFVPq2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jun 2022 11:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233719AbiFVPq1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jun 2022 11:46:27 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EBA036B70
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 08:46:26 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id o10so24487673edi.1
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 08:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=ZnpUQUQGEkndZVOV3AqtZ0e987mpyX1B2VnB03UkrAc=;
        b=caJZ8hPyKJLFDLQ1boTN3+QFPdjDate5Oh05wMol7QGI4tINtbQONMUTzwY/ywYqcj
         8WBTD0zlyrSuS8ymvGdsG7xHquvHgVboBWU1TijJaqL9pHyd6Bg6LE7Auzu7zY8zauS4
         4giwuiCm9Z61JjC3WDPpstRCpVe0natICTyzhYjfQsteCQX54EOSxvhAboR4UMQuI4W5
         23ZAGhy7FSYd/zWscGI2k/CJUIoZTZ5xqwcG3LdrUF2jvPrvvdC8LGoyy/l1umNgPUIo
         hdWjLMzh/gXgT4xN5ugbIPF+W305GebV/yHb5jM3xOPoBYFCOySB6UJJTiUXxQxlizCz
         Q0FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=ZnpUQUQGEkndZVOV3AqtZ0e987mpyX1B2VnB03UkrAc=;
        b=lfwf3KUMI+b11WcqLYttB9IERswGZmUZyOCgsbFEO/u7kI5xFZQq1d3Dl1dk0MWpyW
         8whd23J7N0ODucDnSOVGT/ULmjYOxonxgk8vy6Hj42ur4KqradQ6ETYIzdqz5b/HmvnO
         oZjKlLlKTIpWLEQ+XKZvl8Hr9CbJYDNcnLF0H0PMGvtZN2kcTmF7uMpP94HCcuGzsW1j
         AxEsTAokWp+AK1moJv+3l7nmzzEzZc/q6NpDf8kI0GvF6lAitCLbpDxb1888KaLRPgMd
         1I2Bs1y6o9fs0unVpDV7+Eh5kEsG6OaYXQq3lRWxqltN0byMDlfnP+aMOhf0GLaK4eA5
         xYbw==
X-Gm-Message-State: AJIora+awANPhlMab/DEnW+7U8FzYDQrLIm9upk88YXqxUCd56B8Deq+
        X8zTcervLm1NZc4dpDB/wCqQd4hTyUfkfg==
X-Google-Smtp-Source: AGRyM1sZdUqr/6KeAmItghJS9rN6vRyAueuoeawkd3Oj7AE5OYjdvIgxyli6yoDYY1QdgjJC/EKP7w==
X-Received: by 2002:a05:6402:2051:b0:435:71b5:b627 with SMTP id bc17-20020a056402205100b0043571b5b627mr4786687edb.267.1655912784914;
        Wed, 22 Jun 2022 08:46:24 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id g2-20020a170906538200b00722dcee9ea0sm3658748ejo.125.2022.06.22.08.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 08:46:24 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1o42Yh-000o0i-I0;
        Wed, 22 Jun 2022 17:46:23 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Dimitriy Ryazantcev via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Dimitriy Ryazantcev <dimitriy.ryazantcev@gmail.com>
Subject: Re: [PATCH v2] i18n: mark message helpers prefix for translation
Date:   Wed, 22 Jun 2022 17:33:59 +0200
References: <pull.1279.git.git.1655819439775.gitgitgadget@gmail.com>
        <pull.1279.v2.git.git.1655819877758.gitgitgadget@gmail.com>
        <220622.86v8stkt1g.gmgdl@evledraar.gmail.com>
        <xmqqbkuk7mdb.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqqbkuk7mdb.fsf@gitster.g>
Message-ID: <220622.86edzgln00.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jun 22 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> I posted this patch[1] to do the same a while ago, except it also
>> translates the "BUG: " message:
>
> We should take this one, exactly because it does not touch BUG();
> the messages given to BUG() are not marked for translation, and
> translating only the "BUG:" prefix does not make much sense.
>
> When BUG messages are shown, it is better if they are conveyed back
> to us exactly.  It would be cumbersome to near-impossible, depending
> on the language, if a message was given back to me in a script that
> I do not even know how to type---I'd need to map it back via po/*
> files with "grep" to locate where the message came from.
>
> Besides, BUG messages are meant not to be seen.  We could discuss if
> it makes more sense to translate the messages and spend engineering
> resource to mark them with _() while massaging the messages to help
> deduping, but because the messages are meant primarily for identifying
> the locations and not explaining situation to human user, I do not see
> a huge benefit doing so.

I think this smaller change is fine, I was attempting to summarize the
difference in the approaches, and note that it would be useful if the
commit message communicated some of what you're pointing out here.

The change I have didn't translate the *content* of bug messages (which
we'd need to mark for translation, but we shouldn't do that), just the
"BUG: " prefix, and we'd still leave the file/line number in place.

It's probably going overboard, but it seemed harmless enough, and might
help us get reports we otherwise wouldn't see, as someone who doesn't
speak any English would get the hint.

I realize that git's userbase is fairly technical, and if you're finding
a bug in git you're likely to have some *basic* knowledge of English.

But I think it's good translation practice to not assume that, and to
make the software inviting to people who speak about as much English as
I speak Chinese, i.e. none.

If I was using software originally written in Chinese that had *.po
translations in a language I understood I'd be thoroughly confused if
one day it would tell me:

    =E6=98=86=E8=99=AB git.c:123=EF=BC=9A=E6=99=A6=E6=B6=A9=E9=9A=BE=E6=87=
=82=E7=9A=84=E9=97=AE=E9=A2=98

Which I don't even understand one letter of, and I have no idea if it's
grammatically correct. It's just what I get from Google translate if I
ask it to translate "insect: obscure problem".

I'd probably try to copy/paste at least "=E6=98=86=E8=99=AB", and get an ev=
en more
puzzling mention of "insect". Which is what many such users would be
likely to get if they were trying to find out what our "BUG" means, the
idiom of "[a] software bug" is jargon that would translate especially
badly.

So, wouldn't that be more helpful if I'd at least get:

    INTERNAL SOFTWARE ERROR git.c:123=EF=BC=9A=E6=99=A6=E6=B6=A9=E9=9A=BE=
=E6=87=82=E7=9A=84=E9=97=AE=E9=A2=98

So that was the idea.

I know it's an uphill battle sometimes to convince people that there are
a) monolinguals that b) use complex software and c) whose native
language isn't the one we use on this ML. But these people do in fact
exist, and in quite large numbers I might add :)

I think our i18n effort should aim to target that lowest common
denominator, there's other lower hanging fruit, but since we were on the
subject...
