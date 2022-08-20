Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A98C25B08
	for <git@archiver.kernel.org>; Sat, 20 Aug 2022 10:31:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345323AbiHTKbd (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Aug 2022 06:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345159AbiHTKbc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Aug 2022 06:31:32 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5964EA6C18
        for <git@vger.kernel.org>; Sat, 20 Aug 2022 03:31:31 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id j21so7565295ejs.0
        for <git@vger.kernel.org>; Sat, 20 Aug 2022 03:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc;
        bh=kZkSTkXG2qJXv+F3AWkL6OqpdH42FDpPf6gUHiU3YoU=;
        b=HVoImfx8/TFa9Yl1MfYwGiNPRIq5EVQEpsT4F/AZeXjzms3GvuBP97ReR/Zg387SmY
         /YfiUZnpkPJkDXEWTI67GNBdhuLIMnrvnm2HbbSgMKFDc/fW0x0W3m/0pUmJG1AugUp4
         00ofImgf5PVXYgV1nEWfxYqsUFCoWivicXB5bqlZeI//tWxA82MRN8Q0Q9e5jvP/TQlE
         ooJE9BCjV0je1sq5wL2eN4uo4ocYY7xnnCfLp3CX5IIzeziP/w4nZui+ZHldrIBiyuS9
         2dEcK0t7NHV1w/VrZFtFnKV01903t7dUu24fwNfTyQkLF3e4puVHCpB84qUltY7Orxrh
         vGwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=kZkSTkXG2qJXv+F3AWkL6OqpdH42FDpPf6gUHiU3YoU=;
        b=QEi6kyoo9+VoXFbN1gu/IscOF6aApGWJODK+ca0x2nIG/yHwNTw7aS8OdVbvWH0iqs
         UNAm8xDSrhn5olhyMMwiaul/P3o6lqBXM8T63AhKsxAh1Vhtz19BgF7uT44zzmzzyJIA
         wMDmuLbWWlkXaCIhCQTEDll9N4FdIFPZoKUHIbM6NlfBAnbG2wy4BnkhdXLbtJzNpd+B
         yTQF0aVJBz1+7LFuG5DSDlhGKxSZb2AamvCCd/gRI6y/e+5WL+DOIeg+gsoJ+wu+YJTV
         bSB35qK9f3xIywzJdgFn/gAmmrtaY4P2LSyI9jVqdfvLuU29L0gRAVfkKFpVimIVdQb7
         V/mA==
X-Gm-Message-State: ACgBeo3zR6+ckdGD3c98n0XKFq9jc50PNlHFs9FMs+LkNAPJqbVgFtlv
        z127znbHx95PLHkGXHV7FPg=
X-Google-Smtp-Source: AA6agR5P4AiLA/PdLE4O0C7aJiSjYqMeG6Xqvw4Hla9J2d/U3UjvZtZsIGjiXUPmWNKjvOInraoT/A==
X-Received: by 2002:a17:907:6092:b0:731:59f0:49ac with SMTP id ht18-20020a170907609200b0073159f049acmr7422011ejc.383.1660991489826;
        Sat, 20 Aug 2022 03:31:29 -0700 (PDT)
Received: from localhost (84-236-78-250.pool.digikabel.hu. [84.236.78.250])
        by smtp.gmail.com with ESMTPSA id u22-20020a056402111600b0043bc4b28464sm4461657edv.34.2022.08.20.03.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Aug 2022 03:31:29 -0700 (PDT)
Date:   Sat, 20 Aug 2022 12:31:28 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 04/20] t0040-parse-options: test parse_options() with
 various 'parse_opt_flags'
Message-ID: <20220820103128.GD3373722@szeder.dev>
References: <20220725123857.2773963-1-szeder.dev@gmail.com>
 <20220819160411.1791200-1-szeder.dev@gmail.com>
 <20220819160411.1791200-5-szeder.dev@gmail.com>
 <xmqqczcwksgj.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqczcwksgj.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 19, 2022 at 11:18:20AM -0700, Junio C Hamano wrote:
> SZEDER Gábor <szeder.dev@gmail.com> writes:
> 
> > +static void print_args(int argc, const char **argv)
> > +{
> > +	for (int i = 0; i < argc; i++)
> > +		printf("arg %02d: %s\n", i, argv[i]);
> > +}
> 
> It is not November 2022 yet (cf. Documentation/CodingGuidelines).

Oh, I've misunderstood Ævar's remarks about this in the previous
round, and thought it's fair game.

> Curious why "%02d", not "%d", or autoscale for cases where argc is
> larger than 99, but I'll let it pass (iow no need to reroll only to
> "fix" it).

It doesn't matter for these tests, but 'test-tool parse-options' uses
the same format to print args:

  $ ./t/helper/test-tool parse-options foo bar baz |tail -n3
  arg 00: foo
  arg 01: bar
  arg 02: baz

