Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 712AC1FA7B
	for <e@80x24.org>; Tue, 13 Jun 2017 23:46:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754098AbdFMXqa (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 19:46:30 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:33328 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754096AbdFMXq2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2017 19:46:28 -0400
Received: by mail-pf0-f182.google.com with SMTP id 83so74808132pfr.0
        for <git@vger.kernel.org>; Tue, 13 Jun 2017 16:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7awnDVEsiwd25LQ6t8mEglK2LdDftPWOXRY1qXcxbRg=;
        b=B/7AE8aQeF5/74CTRzs82sDonGSN+XPJeWkdh1t0S7shq28tB0IEPAwiq9hAzi2VaF
         rVGbYU1CbAX3wmJZZq8/vfHFH3L87u030f4F05HO8rJVt5hCR842XpyX2saf5pUm8HLR
         xF/U+igq/en+Bzw/53arUOdN4nwdR6yVHsGnsiG/GHGAdk58ok7Npqzd7YEtCyBiFiHy
         aeJ4KXzColL+5nNI1pG0p3Kw6vbiLzG9bYmPs2q9OrPut/8JFC8P3AWgkj9sIMGp7Gnz
         kMciBaDPPaLABrCSN8VDq+blLa5aHSeiTQA3Xp3WRARwqYYLs+lpAs9O/En4bsjdC6cB
         DE8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7awnDVEsiwd25LQ6t8mEglK2LdDftPWOXRY1qXcxbRg=;
        b=ZvhOS/luApUC6oX1cJ3MQrKKENKP2HaftUqRiNFI+8c1ZNcd/rgJL1q1SS92RoWfLN
         u/Hnmd8MybFGrOOMy2pkUiKoIOYssLUWiiEL2mPE9O4pxYdHJDWVadlAVHTpfUJ9Febh
         tOL4y+5/qkVfHQvCe3lixVQNVOzi5Pjbp83fF8/hbVamNpSIyWzQuk2i0OD7j03rc0Es
         WdDioJUE+ZLG+EGGy2w1pjrCObAvm8HmHO8ZRhaQ+35b1LpBrVWfMb7H2tAxCSJsE7AH
         H9KpOrPCDNHSSORdRrPHR2X2y9L3lESvof6pemwbRMkofkneb5RabzdCvKgYRBr1NO+d
         Hn5Q==
X-Gm-Message-State: AKS2vOxkGIPLzqJbq/tHsU97wkGN3zY35TGGAvThu4QsXXh3k+T1GcF1
        bHApc5BhRKfJHPvk5zBFfg==
X-Received: by 10.84.209.236 with SMTP id y99mr1938190plh.198.1497397582522;
        Tue, 13 Jun 2017 16:46:22 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([2620:0:100e:422:85a0:52c1:8d73:eb63])
        by smtp.gmail.com with ESMTPSA id b86sm28518835pfc.27.2017.06.13.16.46.21
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 13 Jun 2017 16:46:22 -0700 (PDT)
Date:   Tue, 13 Jun 2017 16:46:18 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCHv5 04/17] diff: introduce more flexible emit function
Message-ID: <20170613164618.30804543@twelve2.svl.corp.google.com>
In-Reply-To: <CAGZ79kY9ByaHe_fx+S3neT6+1LcA_Q13bbVha8AKHUUO32FgeA@mail.gmail.com>
References: <20170523024048.16879-1-sbeller@google.com/>
        <20170524214036.29623-1-sbeller@google.com>
        <20170524214036.29623-5-sbeller@google.com>
        <20170613145457.2e888c27@twelve2.svl.corp.google.com>
        <CAGZ79kY9ByaHe_fx+S3neT6+1LcA_Q13bbVha8AKHUUO32FgeA@mail.gmail.com>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 13 Jun 2017 16:41:57 -0700
Stefan Beller <sbeller@google.com> wrote:

> On Tue, Jun 13, 2017 at 2:54 PM, Jonathan Tan <jonathantanmy@google.com> wrote:
> > - could this be called emit() instead?
> 
> Despite having good IDEs available some (including me)
> very much like working with raw text, and then having a function
> named as a common string doesn't help.
> 
> After this patch
> 
>   $ git grep emit_line |wc -l
>   16
>   # not all are this function, there is
>   emit_line_checked as well. But 16 is not too much.
> 
> But if renamed to emit():
> 
>   $ git grep emit -- diff.c |wc -l
>   60
> 
> You could argue I'd just have to grep
> for "emit (" instead, but that then I would have
> rely on correct whitespacing or use a regex already.
> Complexity which I would not like.
> 
> So I am not sure if this is helping a reader. (Not the casual
> reader, but the one grepping for this function)
> 
> Maybe we can settle on a different name though,
> such as emit_string which is not a prefix of a dozen
> different other functions?

emit_string sounds good to me.
