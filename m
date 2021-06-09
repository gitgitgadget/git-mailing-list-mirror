Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46EB5C48BCD
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 17:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B29A613CB
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 17:32:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbhFIRec (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Jun 2021 13:34:32 -0400
Received: from mail-ot1-f41.google.com ([209.85.210.41]:37419 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230527AbhFIRe2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jun 2021 13:34:28 -0400
Received: by mail-ot1-f41.google.com with SMTP id 102-20020a9d0eef0000b02903fccc5b733fso1676157otj.4
        for <git@vger.kernel.org>; Wed, 09 Jun 2021 10:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:message-id:in-reply-to:references:subject:mime-version
         :content-transfer-encoding;
        bh=ZGZ8rFjNIBWXLGmD6+BrUPJ7Dv9qZemjn74f8B2c6pQ=;
        b=hbhdwsaIZfwGED066VBpjclJs6b7/fr3eH2H4D9dC3uLFnXoDTBDdlWqIK1y75vWgM
         sCSy7P63JSgFEm2BHX2VeAE2ZJGCdO05I7WNL++Galou6sGx5dzD2RtGEVlCk3Sm3zZk
         W691x4Bn/OLVSRo7CrnMe9djwyNTzdeJ3OLLWefLqczra+3kHKEBY9fVZZjTaV7a7VCx
         dPANaVXRsb0lPmPxeXaS/aswQFwpKkoDcwqWtRexpFYiH765R7X6TNquYO0X+IiUED0L
         MqDce+KBkZtB38TlOKF7XBdsri1Y/7Acj9LucIgc74gLYGTdAcNeoz1ZGycD+Kd8p9jM
         7Wmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:message-id:in-reply-to:references
         :subject:mime-version:content-transfer-encoding;
        bh=ZGZ8rFjNIBWXLGmD6+BrUPJ7Dv9qZemjn74f8B2c6pQ=;
        b=qItd57zgorMxmjuJ0ydxBxxTI947FDHXeV5ZylaWBYjCo1GrPn//dtkY66YPQxAkiY
         kLZ/oihqTwRwXIBlQ1MegIDNi+yJJ//4Su8Cvu40RPCBcSVhTSoGfu+oN37rPgor3GqN
         Rvp2ZBJWMXjvum1uFuaPwuQIeGkHg0b0HcCSuuJP2YR2wOqUOmGaIrseZvAryEEVLMjC
         yGhvla2S2mDkvoUaxDbSW9IEqHEuzqzcDlU6SmI8SCqc+jzNcTCMTkBbQberimMTbqYI
         noMwIN8xNuKr7FMq9MDS0oneCY31jG2ttqTEUJfg54cmjSmJcM6YtREtMkJ/QPukqbXR
         mFkA==
X-Gm-Message-State: AOAM530PTjntqeDd0ASpv+Dn96YZmJddOTsjlKfpml5+fgHZGmpHih/R
        KOCNugL1/cCKHaqzxnsDROU=
X-Google-Smtp-Source: ABdhPJwCUQLqUBKPGVRzI0D3ckRNqVgh0U/iXP679IGavKngwnJBkac3KyL+1bHtv93mVb3z9kl2zg==
X-Received: by 2002:a05:6830:1386:: with SMTP id d6mr486859otq.122.1623259877057;
        Wed, 09 Jun 2021 10:31:17 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id x2sm67166oog.10.2021.06.09.10.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 10:31:16 -0700 (PDT)
Date:   Wed, 09 Jun 2021 12:31:05 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Andrei Rybak <rybak.a.v@gmail.com>, git@vger.kernel.org
Message-ID: <60c0fad989b58_1074920884@natae.notmuch>
In-Reply-To: <20210609102641.3531183-1-rybak.a.v@gmail.com>
References: <20210609102641.3531183-1-rybak.a.v@gmail.com>
Subject: RE: [PATCH] fix typos which duplicate a word
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andrei Rybak wrote:
> Fix typos in documentation and code comments which repeat various words.
> These typos were found by searching using scripts like this:
> 
> 	for w in $(grep '^....$' /usr/share/dict/words)
> 	do
> 		git grep -P "\b$w $w\b"
> 	done
> 
> Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>

Other than the 'that that' in t6416-recursive-corner-cases.sh everything
looks obviously correct.

Reviewed-by: Felipe Contreras <felipe.contreras@gmail.com>

> ---
> 
> I'm not sure what to put as the "area: " prefix for this patch, as it touches
> both docs and code comments.

Not every patch needs to have an area, but when there's no area you
need to use uppercase.

  Fix typos which duplicate a word

-- 
Felipe Contreras
