Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCC6CC433DB
	for <git@archiver.kernel.org>; Sun, 27 Dec 2020 17:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9485922513
	for <git@archiver.kernel.org>; Sun, 27 Dec 2020 17:07:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbgL0RHL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Dec 2020 12:07:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbgL0RHK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Dec 2020 12:07:10 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37608C061794
        for <git@vger.kernel.org>; Sun, 27 Dec 2020 09:06:30 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id q25so9363978oij.10
        for <git@vger.kernel.org>; Sun, 27 Dec 2020 09:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=nSNcFt3P2QtdQlaE216n/VkG8kaV1oJ6U/ZtVwlyi3k=;
        b=fAiXp51Ask8KZiRRed81eCWuZyge1hjU8p43zwyAf8OgU1FMfsLWQY49Smy9ka8uCJ
         ImpM/HDI61mzv7SjnvTVSoMJRCr1D+G26I2cT2YmkE1pn4Zor/lbBQeJyFmtHiQDkkEx
         uHnvlkX30onodhQWasC3PZsHisjSD9GD0os3u69h6//yiqA8F7HXVzAXZNXP7d51nke1
         wzAS0PhbaFRwhyHx4fwwyNFsr6FG8sBpsUsbaIz6xZLGZvUhtWFUdhMHlimy53FZcjMZ
         m4HfDfqgtzgLJN/u+8dq1mluUySzyk9fSuZx3HONYcSBAPO/ht6mAwVFv4/AmNvQrtKH
         EORw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=nSNcFt3P2QtdQlaE216n/VkG8kaV1oJ6U/ZtVwlyi3k=;
        b=Iy++6WN48VT1CYkF18xvrj5h6jecPd/UV+rrldcbxJDGtOaNpPHI6UIDmQ5Zp+pCVc
         YquNRf5QubBQGwDAqeF7WEmJXWKtvrN47168JhjCvmkT/b0GTgRWTktF+1JkFsTYSwja
         yQYfeH0sGOiQa8uTdi686Q+ll2etY5W9xQdcpZdWXfyirbXqcMG5rXj/bYX9haqlnHtH
         sPiKme1D9buwg5EpaxDySHP9/bWPOwzYjN+Pd3X96pLeiVj6qZjLqKcCcR0UDuhUFKjU
         mr6yAUhYR+Oqv4XJHlzcLNAuqNffK2npczpAXn6WPghER4BN5XnURboFxXeWUwjsxPpn
         eGbg==
X-Gm-Message-State: AOAM533lqzOEgjOGPBgsNtrJMknMtp7xI70/5pq0SGuZFz7/TaNmncSP
        IrSBd3XVBn8Tc/ZVn2WAt10=
X-Google-Smtp-Source: ABdhPJxfwJCKhOT6CJWMemma59YKTmMJouRMyDDVT6XQyUogbInTmK/2sDnaiuUpLrNoiLwQDxRDJg==
X-Received: by 2002:aca:d484:: with SMTP id l126mr9641948oig.151.1609088788593;
        Sun, 27 Dec 2020 09:06:28 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id 65sm8680445otp.35.2020.12.27.09.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Dec 2020 09:06:27 -0800 (PST)
Date:   Sun, 27 Dec 2020 11:06:26 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?TWljaGFsIFN1Y2jDoW5law==?= <msuchanek@suse.de>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org, git@sfconservancy.org,
        Christian Couder <christian.couder@gmail.com>,
        Jeff King <peff@peff.net>,
        'Junio C Hamano ' <gitster@pobox.com>
Message-ID: <5fe8bf127e45b_e22d2080@natae.notmuch>
In-Reply-To: <20201227150737.GM6564@kitsune.suse.cz>
References: <20201223061718.102779-1-felipe.contreras@gmail.com>
 <87wnx8uirn.fsf@evledraar.gmail.com>
 <5fe40778321c5_7855a20819@natae.notmuch>
 <20201227150737.GM6564@kitsune.suse.cz>
Subject: Re: [PATCH] CODE_OF_CONDUCT: expect tolerance, not respect
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michal Such=C3=A1nek wrote:
> > We would need to see which interpretation you are talking about.
> > =

> > One example to show the difference is that you are supposed to hold i=
n
> > high regard (respect) your parents, or the King, whereas in a Thanksg=
iving dinner
> > you are supposed to endure (tolerate) your uncle talking about conspi=
racy
> > theories.
> > =

> > These are of course culturally-specific examples. But I hope you get =
the
> > point.
> =

> This is rather sensitive issue. I think there are other two things that=

> are often conflated: respect for views and opinions and respect for
> people.

Right, but the code of conduct talks about respecting views.

> It is certainly true that respecting people cannot be enforced as much
> as respecting opinions cannot be. However, it is shown that not behavin=
g
> respectfully to people stifles constructive discussion (eg. speech
> against ad-hominem arguments).

Indeed, but I don't think that has anything to do with freedom of
speech... it's not constructive discussion because the main point is not
being addressed. See Paul Graham's Hierarchy of Disagreement [1].

> On the other hand, showing respect to useless views or ideas stifles
> constructive discussion as well. Useless ideas should be pointed out as=

> such and discarded.

Yes, not all ideas should be tolerated in all forums.

> The reason why respect to ideas is often part of code of conduct is
> likely religion. There are precious few people who hold religious
> beliefs and at the same time encourage scrutiny of religion.

Not just religion, but any dogmatic belief.

When you express you don't believe in an idea that somebody holds very
dear, people take that as a personal attack, even though they shouldn't.

What's more; when you provide arguments against such an idea, and
they are actually good arguments, that creates cognitive dissonance,
which is unconfortable to the person holding the idea.

But that's what being part of an open society entails; your ideas are
going to be challenged. That's actually a good thing.

Ideas should not be protected.

Cheers.

[1] https://upload.wikimedia.org/wikipedia/commons/7/7c/Graham%27s_Hierar=
chy_of_Disagreement.svg

-- =

Felipe Contreras=
