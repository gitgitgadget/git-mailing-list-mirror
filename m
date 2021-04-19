Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	PDS_TONAME_EQ_TOLOCAL_SHORT,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE6FC433B4
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 09:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A84FE61166
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 09:33:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237771AbhDSJdg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Apr 2021 05:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232440AbhDSJdf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Apr 2021 05:33:35 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9193BC06174A
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 02:33:05 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id w4so29509675wrt.5
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 02:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:references:to:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=THtz4c22fAFjNCcu+h3DqjDC6QcAWy3BCduIw3dwl1Y=;
        b=C0s2F8FSCLvLMXytAgKC6s7zWVv04g3I1wZli79kHiq73gbjCr4O9aErx6h5v/NHDp
         pOgKwzNHh+fkmV/5wFy1Qybc5ImUxWFyUbGmLgaJbq3ByvY9fgeQ8B4Nq4Oq8pQiRIN5
         f7z3hebRX+pduR6gTXjSptCbQB3QoYfNM/JZQwXRpfZD04NDJFAh/Jz1JBcIdaLLsGvy
         QclmD/3X3AntfYudfsV/+emSqqaVtbpQINKbNPFIaDdG33z4VvCMEikSSUnfiG8+gpBX
         XEPbqgKxUhZmwCxEqA8ENcMutRvkxTDFoocWr+22aJ8P1cHdUIuqxU66vdp522wOf0zW
         CH3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:references:to:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=THtz4c22fAFjNCcu+h3DqjDC6QcAWy3BCduIw3dwl1Y=;
        b=VB9EP4T3d5+lCbdGxXQYUAVdGUJ+TGnW3BU/fwLTJ9lNWSJpJQKYuRKjNU1BGWeKbo
         SIwl2jJ+6ewwvAzoWVnJrEaB95p1H6vye8T7VPb/ScIeUSx0lYSLxOE2bQBPArYoi3Q7
         N/XeHu9AYWs6HMtzOKJTeO6+Mbx9SIuyBo3MfsBxtZ88GO22D8A54s9AhvvqNqnRNu5d
         /ilFfYo+YgvwSKJeyN0ufVlQHm4df8LtN2g7ICTwkJKMWr5EKwJLZV+UTd2jK1+38gca
         DjWIQCRluDvCBxLERQZaucWNL0NxiimF1dEDsc/hpuVeEcYKIQvDnOLiHmZbK5y53zwc
         H/Ww==
X-Gm-Message-State: AOAM532wNlPmKfHnnKTSbfams1dP2T+EkrIQsZOaqj4XSv+FhB/eRogG
        Iahuh65LN2CEMrqzXnIekXraZ9aFiZQ=
X-Google-Smtp-Source: ABdhPJzonTBG2nim736PJELnpLhmzxLNLKf1ngKY2ZJRSa6YKEswovcTMI9SwMa2NKzdEFMuAhge/A==
X-Received: by 2002:adf:e607:: with SMTP id p7mr13177660wrm.381.1618824784068;
        Mon, 19 Apr 2021 02:33:04 -0700 (PDT)
Received: from [192.168.3.42] (inv-34.95.247.146.static.fprt.com. [146.247.95.34])
        by smtp.googlemail.com with ESMTPSA id z14sm21106156wrs.96.2021.04.19.02.33.03
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Apr 2021 02:33:03 -0700 (PDT)
Subject: Re: [RFC PATCH v1 00/13][GSoC] doc: (monospace) apply
 CodingGuidelines on a large-scale
References: <20210409040301.3260358-1-firminmartin24@gmail.com>
 <d2e78646-6735-2a27-735c-331de6411ca2@gmail.com>
 <87h7k9hq75.fsf@Inspiron.i-did-not-set--mail-host-address--so-tickle-me>
To:     git <git@vger.kernel.org>
From:   =?UTF-8?Q?Jean-No=c3=abl_Avila?= <avila.jn@gmail.com>
Message-ID: <e5abb24e-9baf-6a61-f084-1ebd3092ce42@gmail.com>
Date:   Mon, 19 Apr 2021 11:33:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87h7k9hq75.fsf@Inspiron.i-did-not-set--mail-host-address--so-tickle-me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: fr
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Le 13/04/2021 à 22:42, Firmin Martin a écrit :

> I'm an absolute novice regarding AsciiDoc vs. Asciidoctor. 


Here are some news:


https://groups.google.com/g/asciidoc/c/kaqYgpmWrJk

