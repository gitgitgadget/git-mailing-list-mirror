Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1943207EC
	for <e@80x24.org>; Mon, 26 Sep 2016 21:57:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161692AbcIZV5w (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Sep 2016 17:57:52 -0400
Received: from mail-qk0-f180.google.com ([209.85.220.180]:36745 "EHLO
        mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1034033AbcIZV5v (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2016 17:57:51 -0400
Received: by mail-qk0-f180.google.com with SMTP id z190so184664394qkc.3
        for <git@vger.kernel.org>; Mon, 26 Sep 2016 14:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=Y2u+DjNCfMbQ3wWVZ4PRPU2bWiUALiRGMx76Jw8DndM=;
        b=SQz6a540G/y4RYLjYeTwC/zHSSezfyr5oyrvo4eqaWVLvPkhZUZXa3Rk5Uas/RQru0
         69XGXD1InA6AJ1HzeLysEtaYSHwzW2tAEiKpaU3BnGM8oBTXNOSKgxtTwGAe17rOYOwU
         X75SWZMAkWMu/EOfHgn5GO4SuNiSK+RtoLShL7/brWvApFDM+6L4MMTxoNhmY3Y/Y7rj
         q0br2KHIL8AL8nL9YNVFn1RAthZ+DgBSDxt7OLdxaml08Nrdh0AuMi710gOUm0JtWgbv
         t4qeYTihhy6j6PAzP4slbmbTHHd6ppqBVxrbbUfzbEDIHcV50jJEL6f3u6aH7yHP+6Mk
         AfRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=Y2u+DjNCfMbQ3wWVZ4PRPU2bWiUALiRGMx76Jw8DndM=;
        b=Hg10+exTHOpmPWnOkWKOE3ftiw/d3ZW2IW1Fxojrq7kGbB7W20le3BkMsmXXbV7Ph+
         Q2N8Xw63iVI8Z/BcQyTfHk4wZSy0p6n1Xd2ue6/xXjdsNytq//TM9Q/qy4SZgTLSxWXT
         KwUDOwDjbErjsobpCbXee8b7i/wmyhKCDfeK2+09P0raGQcl8lZjJCSEAM88fmwYffpQ
         0aWEw1V1rFquXVRbfZBSqW8LSGIcxv6WtkUd5dNcmDHeOKUW2oYIbjJ6p7h8H7AiLW9W
         WIGWk7072QpXfp6zegbf+bKZGIdfBAKWJviCQAk0nCr1XLr719HbhQB42RQttEVW2Mja
         jNaA==
X-Gm-Message-State: AA6/9Rlx4wdsO4NBzS+EPmqboksKLNmqMdjqFrSWEii9wu+GUzg0cyC9zLlJystOQt0C03XNZd6f604UenLFWw==
X-Received: by 10.55.186.65 with SMTP id k62mr23508648qkf.204.1474927070131;
 Mon, 26 Sep 2016 14:57:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.55.19.40 with HTTP; Mon, 26 Sep 2016 14:57:29 -0700 (PDT)
In-Reply-To: <1474925524.4270.35.camel@mad-scientist.net>
References: <1474925524.4270.35.camel@mad-scientist.net>
From:   Junio C Hamano <gitster@pobox.com>
Date:   Mon, 26 Sep 2016 14:57:29 -0700
X-Google-Sender-Auth: 04b21w-EtidPYe2JnVBuLJUJP8I
Message-ID: <CAPc5daU_nnHRjtC02bxqRaoU+0Rgi7pS6e912Fqk-Xy=qdKWFA@mail.gmail.com>
Subject: Re: git 2.9.2: is RUNTIME_PREFIX supposed to work?
To:     Paul Smith <paul@mad-scientist.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 26, 2016 at 2:32 PM, Paul Smith <paul@mad-scientist.net> wrote:
> Hi all.  I'm trying to create a relocatable installation of Git 2.9.2,
> so I can copy it anywhere and it continues to run without any problem.
> This is on GNU/Linux systems, FWIW.

I had an impression that the setting was only to support MS Windows.
