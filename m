Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F151C433DB
	for <git@archiver.kernel.org>; Thu, 24 Dec 2020 00:54:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D49622517
	for <git@archiver.kernel.org>; Thu, 24 Dec 2020 00:54:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbgLXAyB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Dec 2020 19:54:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726288AbgLXAyB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Dec 2020 19:54:01 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A9DC061794
        for <git@vger.kernel.org>; Wed, 23 Dec 2020 16:53:20 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id dk8so873161edb.1
        for <git@vger.kernel.org>; Wed, 23 Dec 2020 16:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=66nWlEd1QDWvUkkLjEujYktd0w0PTDF7QZLAGRDE1kE=;
        b=Hoe7g34tgQ0uHerHkf50lzAHpjQmb8MFxzXzavNxedTE5lpROW86ByWAcYvS1k+9On
         a2pzmx4nNp+IF6zAEbt68+IjlX98o+JHTrU0jrRZmQ1uOvAV40FN+uHfyC4eEI87hMqT
         jDD4LrM3WUWlq3+kvPjjWFx/G5er2UgTXjAr1lcc1jg6kMN7e4anbZ/cdkMPK6gURlU1
         3HVGO3O72YtM24nXE98fpUGFAQAzA1HggEudkan+OmxOha++KQRGT2ZRoMBxEsBKdQ1N
         6eF2wllbpSRPB1fY4F9EEQ4i+YX20taPzk8hrBrjRcz+1bF1UxXTEEbfvo7n4mEnB51Y
         QFCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=66nWlEd1QDWvUkkLjEujYktd0w0PTDF7QZLAGRDE1kE=;
        b=AiT7ch4oxPDg/h98ggvaNqs57oBq6PQbx/7VDR/buxd2QU+UAXvjGMeTIqq0g71oH8
         Pi2KBqTyac67nFoBKm4ljUtAOW449SoJDJ0wMrGJUTSNd7u6QwmXxWBOucqAlPe+fZsA
         0m4rDdY0s6PW8fZ4pEThnn0WRPYIP50xkB0NCLWpIiS2QAqdSNnTH12X/f/IGUdPy+sL
         /Jd1W7nuWcBLSBoKhHkWKWUHObjy0h7Z3yaLqTaMQMuE8dRMeRVmdwm8j/XUirwUt0Sz
         BrQucuhmWMI5hDLmDCkL0wtIWvK+OgC3h5TuWZkHz6bieh6upIJ9GxF8Z1jaEcVjEVVl
         o8ww==
X-Gm-Message-State: AOAM531+ij/9QxrmKn6zGNTGBHC2VazTNZmuQlv0DgK0sSxMPRaG1WBf
        gYmnMDzPJ0U/zbi34oxq54chCCosMwMhRA==
X-Google-Smtp-Source: ABdhPJzqsTsNS6pBj8nVWdI+gqC2SaCOosRuyelry5IFl23wa6PcR3yhiEhcFEI7LxVItn27m5GnwQ==
X-Received: by 2002:a05:6402:17:: with SMTP id d23mr26993557edu.341.1608771198953;
        Wed, 23 Dec 2020 16:53:18 -0800 (PST)
Received: from evledraar (157-157-127-103.dsl.dynamic.simnet.is. [157.157.127.103])
        by smtp.gmail.com with ESMTPSA id r24sm31283572edo.4.2020.12.23.16.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Dec 2020 16:53:18 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, git@sfconservancy.org,
        Christian Couder <christian.couder@gmail.com>,
        Jeff King <peff@peff.net>,
        'Junio C Hamano ' <gitster@pobox.com>
Subject: Re: [PATCH] CODE_OF_CONDUCT: expect tolerance, not respect
References: <20201223061718.102779-1-felipe.contreras@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.13
In-reply-to: <20201223061718.102779-1-felipe.contreras@gmail.com>
Date:   Thu, 24 Dec 2020 01:53:16 +0100
Message-ID: <87wnx8uirn.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Dec 23 2020, Felipe Contreras wrote:

>  * Using welcoming and inclusive language
> -* Being respectful of differing viewpoints and experiences
> +* Being tolerant of differing viewpoints and experiences
>  * Gracefully accepting constructive criticism
>  * Focusing on what is best for the community
>  * Showing empathy towards other community members

[I happen to be on the PLC, and I'm not speaking for the PLC, just
myself]

Generally speaking, and not just commenting on this specific patch: I'm
not in principle against us forking the upstream CoC if we as a project
& community deem that a worthy trade-off for whatever reason.

But in the case of this specific patch, (and I'm focusing on points not
already raised by others):

1. The specific wording you're changing is something that changed in the
   CoC from version 1.4 (which we adopted) to upstream's 2.0.

   My reading of the 2.0 wording is that it contradicts your
   interpretation, it talks about "being respectful of differing
   opinions".

   If the CoC means to enforce something about privately held views as
   you seem to suggest (and not just behavior in public), then it seems
   like a paradox to me that it also asks participants to be respectful
   of differing opinions.

   To be clear I don't agree with your reading of it. I'm just
   suggesting that any proposed updates to the CoC that rely on reading
   specific intent into the wording therein attempt to do the legwork of
   convincing this ML to accept the proposed change in a way that
   provides more context for the change.

   Discussing that upstream has changed the relevant part from A to B,
   but we're proposing a change from A to C seems highly relevant.

2. The CoC has official translations into a bunch of languages:
   https://www.contributor-covenant.org/translations/

   So I think that even if we deem a git.git-specific change to the CoC
   to be worthwhile losing a 1=1 mapping between our version and those
   translations should give us pause since we'd be less inclusive to
   non-native English speaking contributors of the project.

   Furthermore, I think a really basic sanity check on any specific
   reading or interpretation of the CoC is to see if also holds true if
   you read some of the official translations.

   In the language I speak natively this reading of "respect" doesn't
   agree with your interpretation. It's a really tiny language
   (Icelandic) whose translation is likely to have received little to no
   peer review (I didn't look into it), but presumably speakers of other
   languages can chime on this point if needed.
