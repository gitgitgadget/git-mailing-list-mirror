Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19A911F42D
	for <e@80x24.org>; Fri, 25 May 2018 22:55:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030665AbeEYWy6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 May 2018 18:54:58 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:40973 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030538AbeEYWy5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 May 2018 18:54:57 -0400
Received: by mail-yb0-f193.google.com with SMTP id l2-v6so2344465ybp.8
        for <git@vger.kernel.org>; Fri, 25 May 2018 15:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Yn6u+rfuiEv5os18EluE8yevteEMPmtTVEtSZv+nd30=;
        b=qKUL0PysXAIyFdqhk8Lb1/fQRJl47k++C/4RsqqLB60zSCowqiYtljSGQykkKsabtI
         98ZkbIkk/+mtGA6Yb0KLE0ialp39H05Uk8N/JS+wO8mwfM/ft40WTNQFbsG8QrgGEbIY
         lOgJswVDENluUsvbFvDB4lrwDsXt7xBbehd5KlpnT629xmGQhnajNM7EUBEYyqWMQTAh
         02r7Dlqi92vWMABziHYvrA1NdP1A9G7rp+3FcmNbWj0XUAEyKYLkLq0q5820CMUO4XRw
         vCT6f7ruZy6ItCymVqWiNeh1dMaPzJFV3+5I37EL9vmnPDi5/UBokgq/YO+fuhpAd7tI
         xFIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Yn6u+rfuiEv5os18EluE8yevteEMPmtTVEtSZv+nd30=;
        b=lHnJjeCmBMFb16njNzQ12awIJS26fDFmv1JAV1ij3MHOs1l4OMn5noUagalgkbLxqa
         lmYbSFZYQi7bAwvRHLT1Q9hbE0RNFxHEvj3Pdrey7OEPi6dKj8GCliVOVir5c74EauSE
         IRXD15jokdZlZU1jz5j4chDUzSzM4gSNVTt5BQIzhjs38RlPuZGPZLKIGSGUNO7HwvtO
         iHeqT6xlIOAnFcpj7uRuQZCRGPLXLHWOcUh4Cxyy86ZP0fQ///QRMUzyeGyyzdHqw/zy
         INXIEsntYLLnSzrqanPBwmTj8npbifO8eGxoQ4BSJzaJTUJqeU5Oa4JIF2HvPUGzRoj7
         UbiQ==
X-Gm-Message-State: ALKqPwc3Jj8OAsifs4qdlH+Avq7/raMOa+mbEehZQDKunbfwoD97CIVe
        sCzQV1Cwmas019f8Gy5YF+/+OhAhqw0Z0W+RzWahHw==
X-Google-Smtp-Source: AB8JxZqdiWTw30O+HqPXvPKX9maXtIxSL5VzMlshJ49VrXWMf7NMNvKaFcpmGpK/2K5mbcEY3z+Xov/jVT5skdbuYs0=
X-Received: by 2002:a25:ae42:: with SMTP id g2-v6mr2336188ybe.292.1527288896516;
 Fri, 25 May 2018 15:54:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:e87:0:0:0:0:0 with HTTP; Fri, 25 May 2018 15:54:56 -0700 (PDT)
In-Reply-To: <20180523144637.153551-2-jamill@microsoft.com>
References: <20180417163400.3875-1-jamill@microsoft.com> <20180523144637.153551-1-jamill@microsoft.com>
 <20180523144637.153551-2-jamill@microsoft.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 25 May 2018 15:54:56 -0700
Message-ID: <CAGZ79kYxEVWeCqgVjFXAbnK8RkCfZuUvr1z+LJ1DOx=Ai1DTgg@mail.gmail.com>
Subject: Re: [PATCH v3 1/7] read-cache: teach refresh_cache_entry() to take istate
To:     Jameson Miller <jamill@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "jonathantanmy@google.com" <jonathantanmy@google.com>,
        "peartben@gmail.com" <peartben@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 23, 2018 at 7:47 AM, Jameson Miller <jamill@microsoft.com> wrote:
> Refactor refresh_cache_entry() to work on a specific index, instead of
> implicitly using the_index. This is in preparation for making the
> make_cache_entry function work on a specific index.
>
> Signed-off-by: Jameson Miller <jamill@microsoft.com>

Reviewed-by: Stefan Beller <sbeller@google.com>
