Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF03C47092
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 00:48:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97C64613BA
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 00:48:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbhFCAuY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Jun 2021 20:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbhFCAuY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jun 2021 20:50:24 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE256C06174A
        for <git@vger.kernel.org>; Wed,  2 Jun 2021 17:48:33 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id v13-20020a4aa40d0000b02902052145a469so1006062ool.3
        for <git@vger.kernel.org>; Wed, 02 Jun 2021 17:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=ylKb/u5zdD8LC6dLpxJKJESFYUsiKuQ8dRpeBVAD4pI=;
        b=poTTVb5xVgs4SHruvgIHBvfOpT+HCz103HGTbjfJzkCYdRP4OWQX/ggleJzAA4V55P
         +VoWENC6FTrBOrXHdtfU/HYrOArwj76K9zjATRvCNDykQqZSnQoNteWLv98AyakDd2M0
         +h3f6n9a6O3fx21QCepdFvM5Gy2Rn0bHUbQ/2ZoMFx1SghglxP4libdllpXLJHdsiH+G
         6VXYSwaQ5ZCIwGK8iNED5yz8cEpNA2YPpB5kaB6BNxQgAE8oIlnprJIhojA/7+K7iUA7
         nS/bvA/CQeRZ55X9MZK9+xt+ngePYxG/X/8jBv07TEb5thIyQjMoabQDgYbPbsKyqjVJ
         mA1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=ylKb/u5zdD8LC6dLpxJKJESFYUsiKuQ8dRpeBVAD4pI=;
        b=HZfZHb8I1Li7norK4Zx+v0OQVfEN0iADk9cHTpyp65vqA1ROwqtDEco+oKMoBQ/oRX
         sqZMAfAgYfo1/2XPinvLQFz6VbkgygkyPaAxX8FmULlKTP9/h+Wz5Dho6VUlBz0TTE3J
         iJ59l9hhE1z9AovjxLR8/3xjV3Y1E++u1mf/srOg3bgQydk5vHl1KBukxqkvkFIk4rzt
         4wh7h3WpFBTj15ncmBufzZdXY61LMF2/fmxB9WyhTROHPdGvumv+MMN2K87AGdd96zYQ
         VgHN7KfFV5Lmu+VhVoLlzZZ4De6bdkd+YA+TnwGHmXRIlRHuPCi+xOsEi3PoBHuWGKm9
         R5HA==
X-Gm-Message-State: AOAM532unigUdzVNcjTubsFBUc9e1GSdTGHWURExucounOhiNCpNJyyG
        4tzWF/PUojcPJ3rAQcmXV/4=
X-Google-Smtp-Source: ABdhPJzHZJKiflkWnrMOT7m8oF4CjsZMAkbp7xk1SAHVxqICfNoM3S68SAVlC1I/pzz7uxxUwnGJDA==
X-Received: by 2002:a4a:5246:: with SMTP id d67mr1239334oob.33.1622681312372;
        Wed, 02 Jun 2021 17:48:32 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id n13sm323291oop.8.2021.06.02.17.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 17:48:31 -0700 (PDT)
Date:   Wed, 02 Jun 2021 19:48:25 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Sergey Organov <sorganov@gmail.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
Message-ID: <60b826d968743_184d1720876@natae.notmuch>
In-Reply-To: <xmqqeedj7qwl.fsf@gitster.g>
References: <60b5d281552d6_e359f20828@natae.notmuch>
 <87wnrd6wqj.fsf@osv.gnss.ru>
 <60b6c08f75c1c_40442086d@natae.notmuch>
 <87eedktq4x.fsf@osv.gnss.ru>
 <xmqqeedj7qwl.fsf@gitster.g>
Subject: Re: The git spring cleanup challenge
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Sergey Organov <sorganov@gmail.com> writes:
> 
> >>> [push]
> >>> 	default = simple
> >>
> >> This is the default, you don't need it.
> >
> > Yep, a remnant from the past.
> 
> This reminds me of something.
> 
> This particular remnant is there because the user was an early
> adopter from the days before the 'simple' setting was made the
> default, and it is a common pattern in our configuration variable
> settings.  We introduce a knob to allow early adopters to experience
> new settings, and after a while, one of them may become the default,
> and at that point, the setting the user has appears redundant.
> 
> If we had a central registry of configuration variables and their
> default values (there isn't one), one could write a configuration
> linter to point out "you have this set, but it is the default these
> days" to remind you, which sometimes may be useful.
> 
> I say "sometimes" because the reason why the user has a seemingly
> redundant setting may be because the default for the variable in
> question is planned to change, and the user has it set to keep the
> current default---the opposite of the 'early adopter' use case.

Long time ago I proposed a core.mode configuration that would be useful
for this predicament too [1].

When a configuration is planned to change, git_mode = MODE_NEXT would
make the new values the default.

Therefore the linter could do:

  git_mode = MODE_CURRENT;
  git_config_default_get.. &old_default);

  git_mode = MODE_NEXT;
  git_config_default_get.. &new_default);

If the values are the same, that means there's no plans to change the
default, and therefore it's safe to delete the configuration if the user
has the same value.

Cheers.

[1] https://lore.kernel.org/git/1381561485-20252-1-git-send-email-felipe.contreras@gmail.com/

-- 
Felipe Contreras
