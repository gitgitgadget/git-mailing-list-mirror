Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B28E5C07E99
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 12:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FB38611AE
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 12:09:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbhGEMMQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Jul 2021 08:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbhGEMMQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jul 2021 08:12:16 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB77C061574
        for <git@vger.kernel.org>; Mon,  5 Jul 2021 05:09:38 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id d21-20020a9d72d50000b02904604cda7e66so18088778otk.7
        for <git@vger.kernel.org>; Mon, 05 Jul 2021 05:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=hkbFSYo14GHF1mCQAdnVZoxScm5I90sfw8+fJr8Ilyw=;
        b=dFfiIeMUyc+8u6jSVcml41Cw+FvvG/7iNUS1/P4r0ZFskm8nPlSBLgbxiH8Aeay4Q+
         v1F2ULM2705uuWn1k0YbTXjzd7/JMX1i5FJQADpI3E2on/Id6Sq9Z4m0Csad2SVr8mSO
         Gpv3tuI4/LhVvyqdydL+r/KTZgGSJibSO91nt0qtqW7HtWybI26lvP45DgKd1pKKedR7
         myjqwMltss2s2Fhcm4wGQnKIWLnKv9VME5r1uba8y6MiywUNwcwGIQG6IHyMPfDg9Y6D
         ArxsbKXOxo1gAFnnebXXmk26nivDrfwpEY7dRhJGZvjFJjikFRfvIeEJRZ8BrMZsyt9b
         +KRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=hkbFSYo14GHF1mCQAdnVZoxScm5I90sfw8+fJr8Ilyw=;
        b=lKMvL3gR/BIpE67HBFCnPlXVHb/wbAK7eWHiH7HbUt0hXnXWmIj02LeHPaXm3ibqn3
         pcs4hTHr421FhBigzg3+QYRPsVhmsn2B7FF6obVnW4qK4IiwUX2WqK3ZAZSTO3lY+r5x
         JG/64q40N4ASZlV71YVTGUCriSw5+p+EyV331coEUwmBuFmhu47zw4PC2nWAeKvT/fkO
         2IzCJVkE6mqVQN2tSyLEMKIZdL631Ldqx9Z2c3zca/h0C2Kiqep5pDt5ai8+VQNbnjTo
         10WNkEO76F17rHKELCnvmqWL0P6DkEOCHljIJf5yuzFRtdceSnaKpYuWzRaE7J0lk5fm
         Isqg==
X-Gm-Message-State: AOAM530q0eHw7xT5AeGeLUvDnMQNhLfjDgeM5bjmnz/8kXk3seQl2s6g
        x4EMNPa3yIdws26YCUVZawQ=
X-Google-Smtp-Source: ABdhPJytucM3WKYvSPpGauUqb9jwKPckw8VjUAdrOSZCLinDXzCZfaDeLsaeNDu0v430RtYd6biTRg==
X-Received: by 2002:a9d:4783:: with SMTP id b3mr10663347otf.78.1625486978096;
        Mon, 05 Jul 2021 05:09:38 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id w42sm1647930ott.67.2021.07.05.05.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 05:09:37 -0700 (PDT)
Date:   Mon, 05 Jul 2021 07:09:36 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Cc:     Alex Henrie <alexhenrie24@gmail.com>, git@vger.kernel.org,
        newren@gmail.com
Message-ID: <60e2f68057ebe_1b8e782087d@natae.notmuch>
In-Reply-To: <xmqq8s2lnkta.fsf@gitster.g>
References: <20210705044505.666977-1-alexhenrie24@gmail.com>
 <349748b4-3c48-7ca7-eb0f-e859a15cab0f@gmail.com>
 <xmqq8s2lnkta.fsf@gitster.g>
Subject: Re: [PATCH RFC] rebase: respect --ff-only option
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
> > As I understand it the motivation for this change is to have 'git -c
> > pull.rebase=true pull --ff-only' actually fast forward. Why cant we
> > just change pull not to rebase in that case?
> > ...
> > Is there a use for this outside of 'git pull --ff-only'? I'm far from
> > convinced we want this new option but if we do end up adding it I
> > think it should error out in combination with '-i' or '-x' as '-i'
> > implies the user wants to change the existing commits and '-x' can end
> > up changing them as well.
> >
> > I think this patch addresses a valid problem but it seems to me that
> > the approach taken pushes complexity into rebase to handle a case when
> > pull does not need to invoke rebase in the first place.
> 
> I share the sentiment, but my conclusion would be different.
> 
> Even though we explain that "pull" is _like_ "fetch" followed by
> "merge" (or "rebase"), at the conceptual level, "pull --ff-only"
> should not have to invoke merge or rebase backend.

Indeed. I'm about to send a patch series that adds the
`git fast-forward` command, so `git pull` doesn't even have to call
either of those.

This cleanly separates the logic, except --ff-only remains purely for
`git merge`, and instead there's a new:

  git -c pull.mode=fast-forward pull

Now it's 100% clear what these three do:

  git -c pull.mode=fast-forward pull
  git -c pull.mode=merge pull
  git -c pull.mode=rebase pull

-- 
Felipe Contreras
