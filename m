Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6CB832013A
	for <e@80x24.org>; Wed, 15 Feb 2017 22:42:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752133AbdBOWmm (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Feb 2017 17:42:42 -0500
Received: from mail-it0-f52.google.com ([209.85.214.52]:37811 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751197AbdBOWml (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2017 17:42:41 -0500
Received: by mail-it0-f52.google.com with SMTP id x75so5338026itb.0
        for <git@vger.kernel.org>; Wed, 15 Feb 2017 14:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ylMAYBAnh1LrSPUYFK6IypQUwkuPOyEQCFUf9uvA0gk=;
        b=o00Xuxddh5gAffqpSoYGKpoMTko/SEab8JLZSChlprZFbVPCdEaSR4G5WFjwVlS4BL
         9Shybr4Japs8LahLrvNmNu1DR7t2anHlTaxBTFZ6ZjmNrYt9fziFH4Ax7QkhVTZK3kix
         oLerruLT4/kDlV6L4Ng6X5bP43SA4+l+HMSmnHIooEJCRGf1he0D6hdG7ZTFFqQVKku3
         vPfc0K7Li7iEE2VhAB1p9sNJiH3qp3xExO+1b/4b7QDKHNOUn17cn72P32ZnVpLIv8Id
         kqMFZI/lnxj2svGIBaT+Vo8provbVxgKNBWGE/WYAnY0iL5AqlWwU7+cW72NyKckG3C2
         bbMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ylMAYBAnh1LrSPUYFK6IypQUwkuPOyEQCFUf9uvA0gk=;
        b=qifQgZEsKSmrF6u3gte9JAsjhTVO3Z/PBilwGBD6rgfki1CoVtFMaIj3lvuryjX5XR
         EoXB26fPNGQQYkxXNjdtp5/FfKJQYjCv7XeMLrZOuzfqSgLHjB8RH88Y4wEEIO81aaRS
         edmTAuQxsKwqlC9s1X6SnOL8AQ+4srf2Uvn238fRFlasLESFmbcYZ7hDJRl0+WknAKfc
         GDZOoFUEzQd3yQ0sF5UlKlTRa4Z7NXUHNTp67LR4D6PO6ABw3q/GY3QS4dNDLnumC5+7
         7icz3MasR2y6Fsa3X6Gvb7OIE+ak8QTXKVn2VSinzMvsiRpVi2Q+v/Tb67JlPAJjGNci
         +L4w==
X-Gm-Message-State: AMke39lisTYzuLjZYfHCmj/DKAIBKDFSypGTOGiICvHu/vxwsYg0CQMqcFnM0p4znUnprAmbZ7fC3oyct2Qqbkdo
X-Received: by 10.36.4.2 with SMTP id 2mr10514924itb.116.1487198555313; Wed,
 15 Feb 2017 14:42:35 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.33.148 with HTTP; Wed, 15 Feb 2017 14:42:34 -0800 (PST)
In-Reply-To: <xmqqlgt7495z.fsf@gitster.mtv.corp.google.com>
References: <20170215003423.20245-1-sbeller@google.com> <20170215003423.20245-4-sbeller@google.com>
 <xmqqlgt7495z.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 15 Feb 2017 14:42:34 -0800
Message-ID: <CAGZ79kYb_w62ObACPnrMtzDrsRgqk7HWfhCFvCe=1oeaQTx6RA@mail.gmail.com>
Subject: Re: [PATCH 03/14] make is_submodule_populated gently
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 15, 2017 at 10:10 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> We need the gentle version in a later patch. As we have just one caller,
>> migrate the caller.
>
> Ordinarily, we keep the original helper implemented as a thin
> wrapper that passes NULL as retun_error_code, which causes it to
> die() on error for existing callers.  But because we only have one
> caller (and topics in-flight do not add new ones), we do not bother
> with that.

Right.

>
> The reasoning makes sense, at least to me.
>
> We may want to add a comment about the behaviour upon error for the
> helper function?  I see resolve_gitdir_gently() does not do so and
> the readers have to follow the callflow down to read_gitfile_gently()
> which does have the comment, so perhaps we are OK without any.
>
> Looks good to me.

Will do in a reroll.

Thanks,
Stefan
