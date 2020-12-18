Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB13CC4361B
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 02:35:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B68323A6C
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 02:35:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732201AbgLRCfS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Dec 2020 21:35:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727148AbgLRCfS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Dec 2020 21:35:18 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09BFEC0617A7
        for <git@vger.kernel.org>; Thu, 17 Dec 2020 18:34:38 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id q25so1274325oij.10
        for <git@vger.kernel.org>; Thu, 17 Dec 2020 18:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=nWb+Z5ZwmaiinaITbsRMXwAr0WFMQ8ZWk+YFB4WxYIo=;
        b=QsdSl5medT5z42/xfvcYdK1ivYMLmcqo4W4m+B+XreWa0bOuanDHHls/Grklg3tSwv
         dClbXFlQT8LGc7ksYpv2pupMk6qxj5a+qjoq3daM4XC50z+TJ2PHUKh0sSvRFXI1COPQ
         bR+pJ3LFL2UJpRws7+Ld3SYK6cplYF3rMayFMLxhBK4dON7F8jjPwlDoRG83cIk8ojd3
         OKzS4zJ4jDcY2j2nBxwpw/qFL91PObVXChpbNoaeClAeO9USnkVzY6bRFJdquM1CDU1J
         5IW7VFx409JsvL8TaEqW4VCRZb5lcVzYo4cKxuCgryfBzfEIZyARlTfZEg1t8kmw/k5m
         x+EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=nWb+Z5ZwmaiinaITbsRMXwAr0WFMQ8ZWk+YFB4WxYIo=;
        b=bE4c/p0BvUhH3/uPBIuuVLzC36g33B3FSO2BrmfXdpSxTvsBHOnOCvu1E5hdfz4nJo
         7scWgNgD6UK7oLSaeqMhtS3P76k+oVSrA9O0hviVNzXqRenvbE615cPAC63aQSjk6UPU
         PE+Juf3S+mpew8uwQICkKQ8EEJ5hEpFt0Z9OAaHDJm6OhwdcxCYCGVEO8JC+XBsGsURo
         79a0CdAYaGh5H8XjNo5RRmqPeLhVW4hUZOF1TLl2OzqvaAnhtezbgSyoIQUEHR3l1LT6
         oOdejpYHSgPjhZazx7YIGCjFFCLmpsApPEPzpTvTk/1jNdSOP6dla9vnCRPeXF73gu+b
         gxHw==
X-Gm-Message-State: AOAM532wbR8HaUBCTZjQRKnVZIS313r0P5dnERAtrJB8AweUdmvKhzqS
        i5u+NtpivWTo5OIWc7AxhrI=
X-Google-Smtp-Source: ABdhPJyUH5hCGFjYBFHMVdAEveTBZin/Uq0qUai6fPHtXJQMrBRbugOUJGLbAXruPB9e24pmEpOL1g==
X-Received: by 2002:aca:f48b:: with SMTP id s133mr1440316oih.59.1608258877382;
        Thu, 17 Dec 2020 18:34:37 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id x12sm1506288oic.51.2020.12.17.18.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 18:34:36 -0800 (PST)
Date:   Thu, 17 Dec 2020 20:34:35 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Seth House <seth@eseth.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
        David Aguilar <davvid@gmail.com>
Message-ID: <5fdc153b97837_f2faf208ce@natae.notmuch>
In-Reply-To: <xmqq5z50z0yu.fsf@gitster.c.googlers.com>
References: <20201216174345.28146-1-felipe.contreras@gmail.com>
 <xmqqa6ud2xuw.fsf@gitster.c.googlers.com>
 <105041520.23756286.1608159189934.JavaMail.zimbra@eseth.com>
 <5fdaef83a40ba_d0e26208f6@natae.notmuch>
 <e5c73fed-b87e-2091-794e-19aced4dd25b@kdbg.org>
 <20201217094424.GA75257@ellen>
 <5fdb3471c6bb7_d6d032087@natae.notmuch>
 <20201217175037.GA80608@ellen>
 <xmqq5z50z0yu.fsf@gitster.c.googlers.com>
Subject: Re: [RFC/PATCH] mergetool: use resolved conflicts in all the views
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Seth House <seth@eseth.com> writes:
> 
> > Would you mind switching the autoMerge option to be per-tool rather than
> > under the main mergetool config section?
> >
> > You're right that it will likely not cause any downstream errors; it's
> > just a difference in preference. The tools that perform their own
> > conflict resolution will likely want it off and most of the other tools
> > will likely want it on. I could envision wanting to configure multiple
> > mergetools -- some with and some without.
> 
> Thanks for a concise summary.
> 
> Many people may stick to just a single tool and may find a single
> mergetool.autoMerge knob convenient (and it is OK for them if the
> new behaviour broke a tool they do not use), but for those who use
> more than one, being able to configure them differently would be
> valuable.

On what tool would you turn this on, and what tool would you turn this
off?

-- 
Felipe Contreras
