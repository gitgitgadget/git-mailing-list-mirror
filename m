Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E92CEECAAA6
	for <git@archiver.kernel.org>; Fri, 26 Aug 2022 17:20:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbiHZRU5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Aug 2022 13:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244877AbiHZRUr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2022 13:20:47 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F7AC832D6
        for <git@vger.kernel.org>; Fri, 26 Aug 2022 10:20:46 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id q63so1926384pga.9
        for <git@vger.kernel.org>; Fri, 26 Aug 2022 10:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc;
        bh=QysIwP//Y/QX1IL6vk9IyVw+2NcqvmF1BIN0jIoeqqU=;
        b=AFLDlV7qpGqx8oq441/p5aqEoFpRtx6vnIscSihLNWFbn0YRgKwqAHPm9YzcFLtP14
         c5ScH6nZU8fRtaQY+zRkfpgB3HYMIK0cN7KgLzzEjZVoEHD3mUgJZkQfhpf/9rE1dLFw
         URujzThYyKof9LPuLr+ifAQYdi+cZZ3BwsZIcV1R9IReSp4rLz1qdyKFmWGJA+Jbqpf8
         y9z0vOkxscf5yExHZLxKqpS2fXaFRNqbzP15RSrh8wS1+r5fjvGHQ0MVmKHUy3BlUDgI
         nj+ThZe8zXl+/JGqhQc/hCmFObKyqu9NkGPuNwmXBw+tQx4mJH6OYicptgEgikZMrpw2
         2l+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc;
        bh=QysIwP//Y/QX1IL6vk9IyVw+2NcqvmF1BIN0jIoeqqU=;
        b=UZUkte45jF5yvGoeyhR8CM3kT94XKTJ2BIvdi0mvoJPl9aFXFMKmBTKusURC25BH1H
         QtEarImHbWbZPVaMnv2JSxnOuhQ3RfnmxB2LLNqXAM8uQLQpSYE4BGS4/DIHL6KOEtZ3
         7LvtJXVIHIzCYBzLBegFwJgOkUP3gj05uJdnS4zsF+bvmBSGqM7p9gAWxixT/mWz1Hc3
         OsDkF2uMWs3yzLpMkN9N+AYDdqfH3sRuaCLOjhdnJ71iPIyI99f2ipU3c+pLYxfXiHH7
         Wj/wb6+MXUFKdyo3+hgbgAVdbQR2DaBdJsxbjeNmcXMMmUq94oIDsHqLlKE6s+0t020m
         i9CQ==
X-Gm-Message-State: ACgBeo2HV9uTGRkdzBiHMB1NbCfZjv+IirmnP+aA2wAbQal0q/4A49s3
        CIsTvXZgb6PlYUlJyoIPUlo=
X-Google-Smtp-Source: AA6agR49HkhzgnWCbrog49jLSuDYkl2+kqKMyznC0LgUjbPpVWtgocfDPpaKtHwK8Hc94Rkyf8zDfA==
X-Received: by 2002:aa7:8055:0:b0:536:df46:c567 with SMTP id y21-20020aa78055000000b00536df46c567mr4887012pfm.1.1661534445806;
        Fri, 26 Aug 2022 10:20:45 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id p63-20020a625b42000000b0052dcbd87ae8sm2031907pfb.25.2022.08.26.10.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 10:20:45 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     Rasmus Villemoes <rv@rasmusvillemoes.dk>,
        Git Mailing List <git@vger.kernel.org>,
        Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: Re: forcing an in-body From header
References: <c403e526-7455-4f26-fcef-97c99f9af539@rasmusvillemoes.dk>
        <20220826164828.cxsveqtjiyimdj7s@meerkat.local>
Date:   Fri, 26 Aug 2022 10:20:45 -0700
In-Reply-To: <20220826164828.cxsveqtjiyimdj7s@meerkat.local> (Konstantin
        Ryabitsev's message of "Fri, 26 Aug 2022 12:48:28 -0400")
Message-ID: <xmqqo7w6yl8y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Konstantin Ryabitsev <konstantin@linuxfoundation.org> writes:

> I agree that it's a nice feature to have, though I would put this into the
> sendemail config instead of using an env variable, something like:
>
>     [sendemail]
>       in-body-headers = From

A change only for send-email does sound quite attractive.

I encourage folks to run format-patch first, make amends as needed
in the output files, proofread the result once again, all before
finally handing it to send-email for sending out.  If a "force
in-body headers" command line option plus a configuration variable
added to "git send-email" would work for them, I would be OK with
such a change.

There may be folks who do not use "git send-email" to send out their
patches, and a change to "git format-patch" may help them, though.

Thanks.
