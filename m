Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C31B81F859
	for <e@80x24.org>; Fri, 19 Aug 2016 20:34:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754817AbcHSUe1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Aug 2016 16:34:27 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:35049 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754617AbcHSUe0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2016 16:34:26 -0400
Received: by mail-yw0-f194.google.com with SMTP id r9so1246645ywg.2
        for <git@vger.kernel.org>; Fri, 19 Aug 2016 13:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=dWMgbKp6z5ebBr/w85Q6jk/5u0j0PIeR9g+RWjOP0fs=;
        b=P8L5apOPSqNZFy0vE1DX7W1CORv8NjjmK0DlopDzR8I89ou4E34dbfCkT3KwGev5Ub
         GIFqf6usJqR47tjdgXx40yGPWDi7/jUF3dXuvtn3Nrs2thagjGyX0s2/LCMMjSDjp2pB
         D6qHHgP8kFUpWo9PvPBkP0HDotPs1XCu5DYIkMoFFExQtZY7k8VypquDGnVO7570nM96
         L3SVp5On261z3tMOjX6wAP33Og/mODc/p0+aVJPrM6Lea2lwwWW9EY7aYQqz0iHzWYV7
         jMestCuseJbp3r/FWkYZ/dIBKdYQsDov+fONAGQBhZTP8xpSaDsbn5KKmyCpSifyPHZd
         1qwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=dWMgbKp6z5ebBr/w85Q6jk/5u0j0PIeR9g+RWjOP0fs=;
        b=NgkbC7ouZ+1PElYN+z+brYu8Ju0jmGEdS3YRXCiJl0KOTC11Bzo4FiK7YKBmdrR2Vv
         xZETAEIeoyecvZWhy9BblXEh5eCRO2XHRX+MP7tv+fy0yE4lCeV7qA/Lfgi89MWmtcx8
         E10NrIfsbWXYFmzKoDkEdGuJsoVwrJFw6Iw0h3ppF4L+musTIP0hIcJeVARb8dx4gGZa
         Tg202jHxpNd0SNJEC4Ta0VQJwD909umuOEuDmgV6X82wwHwi6R8NdTURnQwGLp1/oDdi
         oo7uHFdNstLalwkbem9U4yk47FY6kr/4YMdwJBDyvm076/rE2wDzKLp9mRZ/Pg40Ndij
         9IzA==
X-Gm-Message-State: AEkoouvlQHNR1NBjfw1shn9FQOr4scRd5noY5yap+us41Rx6ZjWvM8w56t3adfBbqLAuPIaM5b8YPtZhKuvvmw==
X-Received: by 10.129.95.70 with SMTP id t67mr7856117ywb.284.1471638851014;
 Fri, 19 Aug 2016 13:34:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.50.199 with HTTP; Fri, 19 Aug 2016 13:33:50 -0700 (PDT)
In-Reply-To: <xmqqk2fc1p8r.fsf@gitster.mtv.corp.google.com>
References: <20160819000031.24854-1-jacob.e.keller@intel.com>
 <20160819000031.24854-7-jacob.e.keller@intel.com> <xmqqk2fc1p8r.fsf@gitster.mtv.corp.google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Fri, 19 Aug 2016 13:33:50 -0700
Message-ID: <CA+P7+xpkNa6Kj3WFKVWS_dmpn76dGoKYFUMvA4NSO5viFsnWJw@mail.gmail.com>
Subject: Re: [PATCH v8 6/8] submodule: refactor show_submodule_summary with
 helper function
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 19, 2016 at 1:24 PM, Junio C Hamano <gitster@pobox.com> wrote:
> And probably merge_bases also leaks here.
>
> It is not cheap to compute merge bases, but show_submodule_summary()
> makes two calls to get_merge_bases(), one in show_submodule_header()
> and then another inside prepare_submodule_summary() to compute
> exactly the same set of merge bases.  We somehow need to reduce it
> to just one.
>

I can make show_submodule_headers take another parameter which we
pass, and then pass that into prepare_submodule_summary...?

Thanks,
Jake
