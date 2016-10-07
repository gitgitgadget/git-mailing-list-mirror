Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C542920986
	for <e@80x24.org>; Fri,  7 Oct 2016 18:36:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754890AbcJGSgo (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Oct 2016 14:36:44 -0400
Received: from mail-qk0-f171.google.com ([209.85.220.171]:35699 "EHLO
        mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754771AbcJGSgn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2016 14:36:43 -0400
Received: by mail-qk0-f171.google.com with SMTP id z190so38092850qkc.2
        for <git@vger.kernel.org>; Fri, 07 Oct 2016 11:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=7gQsYokiiLMxgI1a2NVR5IZb5fRJXI7lNSHaBg6H5Cs=;
        b=CKoLSy2ag5KBDZFul0XYCFr1wljSppX+/uZsynI/ZRadu/VhOuAcRRMKdb0QtidsPF
         pDA1capXs8J7cktOh524uuaoEV/CAhd6luFjCmcbakuIVwTnftDtq9Lu9X+LSqIRlyKe
         0q51GT80MfayslZt/5w30VOoCmtOXTTu2exeMXGDDkXP1zTYhxZYz3f9214Em3dHaiHw
         DPjzFikVl2gsfnUTHmXtb3P12AlmG9gT6bpZL9DNDubPRY4//ayQAmgwWITo/3BW61RI
         9PmCIgJByilSpkotaWDGLPbG5g2D9CxG1BQgcJooM+SV5VHetna6ZxPMgD03mFMuyZla
         eo2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=7gQsYokiiLMxgI1a2NVR5IZb5fRJXI7lNSHaBg6H5Cs=;
        b=NAK530st1P1zDbp5C5Z6eZ4vNwQY/ppDuj0GDnGpEgpA/2nf5XHLhElbr0TbGviJpb
         DNNJ+LwBL9IzU4VB17RxPXSJJwkf6xlBKWSrKkhBMZNrGwa3E991DowqNj8749RmMTIM
         r83AXThH0DiaZd6k4xjr6dKdRo2kObqB4Bip0aFlC70M23xX592vYkT0PslIIb34TaKm
         mXoDbyGw6jMXsAd/pMXMSV+CxPHBJUsycx5hVmQnA2fm5e3auMg5BgWhez7twzgtC4Wf
         KAUt/5Bm6OPbzDgAncSCLQtU0EtTEEIfAsNWtojV157F3qLEdf8IChS/IFX3yna5CuEX
         gnRw==
X-Gm-Message-State: AA6/9RkT9UVmog/D3ZVNLvfnZ8dT8PRURLH+UrzI/ygSf/GxPJtYzPy1JUdlfEaPui5U40dW7ozRXoF5+p535ZfO
X-Received: by 10.55.184.2 with SMTP id i2mr21646869qkf.47.1475865356554; Fri,
 07 Oct 2016 11:35:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.135.40 with HTTP; Fri, 7 Oct 2016 11:35:55 -0700 (PDT)
In-Reply-To: <CAGZ79kacgsPg-dzx7JRyhA2bq9JMb2Cyg9PjWbnKi9ZMTPw7RQ@mail.gmail.com>
References: <1475185723-36871-1-git-send-email-bmwill@google.com>
 <20161007181851.15063-1-bmwill@google.com> <CAGZ79kacgsPg-dzx7JRyhA2bq9JMb2Cyg9PjWbnKi9ZMTPw7RQ@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 7 Oct 2016 11:35:55 -0700
Message-ID: <CAGZ79kZo-hL5-rCdw2VA5ce+xpizbGUdkS8ddb6eMC8qQoRSVw@mail.gmail.com>
Subject: Re: [PATCH v7 0/4] recursive support for ls-files
To:     Brandon Williams <bmwill@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 7, 2016 at 11:34 AM, Stefan Beller <sbeller@google.com> wrote:
> On Fri, Oct 7, 2016 at 11:18 AM, Brandon Williams <bmwill@google.com> wrote:
>> Few minor fixes pointed out Stefan
>

The series itself looks good though. :)

Thanks,
Stefan
