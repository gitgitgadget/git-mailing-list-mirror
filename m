Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B80C43460
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 13:37:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 620676128B
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 13:37:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241942AbhDLNhy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 09:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241944AbhDLNhv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 09:37:51 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F78C061574
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 06:37:33 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id s7so12865706wru.6
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 06:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:references:to:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=XsJ8JAKYY3wXORZHKjuwbeeDLYlErMQ7PJ1BlWpv16U=;
        b=HuEGSwHMurHR4YJiTrGfgEuuPfxdup8BPJ1sE8UYyYJzPMNgX6UDTLACmfcTBLwy6u
         +tLrhui/7bxYH7gQLWnq5g/xC8bVZjkIbfARRcVOXMfQwB8tyttolk8AXoBq9bZCwQK7
         cFQf5XCBV5Zi8sgXotsyOJ0/oFnwo31lgVarhYjUVtGNRRKf/yFPOxQ7QHPS7Cpdk38P
         99hMqfU3TSQbQDytjYrBBAY3sLLfT32+g46VrL5FGpXX5qcjidhqgzmmbo4SJUkD1GN2
         dPIo/bjSxkHuK1fV5foZ2O2888TQA6qw0YKdBPCjheSPnD2bHJ1EGIZYgi5cAev9w4Ay
         oNTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:references:to:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=XsJ8JAKYY3wXORZHKjuwbeeDLYlErMQ7PJ1BlWpv16U=;
        b=sj5bGs3HzHrLThpJF9i2WbMfcR4U5ufcUnRniXWrs7mtdwVBZUeKWmlUG2XmEqbNYM
         WcwFWVwsoy2mfjJbJ1sJvyBG3zfNIAXOAqeaiOh1iY1dxZNZGPJ+pp3SJZ1E63IQvPhV
         uYNH+ViWN1DRmvQ2ngIuU/TllZ21s2M8jd6RTirfsWJJHcCxmQ05C5h4I3u4LTWmaoa5
         Tp9l8lbQMnrE91p2PPg8iROHWnszt6HwSu5llgT4Bxd3P31nAGtek/e95wUY+j3KsE3E
         TDfcly4Y02KWkPdtRMnzldla+OiexPcfCQ1QyN5wQkXOG49kp4tCswEj/hgAaNYvpkJw
         bq2Q==
X-Gm-Message-State: AOAM53118EV32G5hML22Jgg+PcxBZtuy4Cq2UI9FA7uIBfBYGysTsyhn
        yuGXi97EhGoGP3VcuEuG4EZc5+hAS/k=
X-Google-Smtp-Source: ABdhPJxvsqRLwLbdXgaJs/vMKkfp+atPtDBp08/YGfRDzIWje46AUPtVFCPVFdSwY3JPmTuZg1Rl2w==
X-Received: by 2002:a5d:4912:: with SMTP id x18mr10768365wrq.198.1618234651706;
        Mon, 12 Apr 2021 06:37:31 -0700 (PDT)
Received: from ?IPv6:2a01:e0a:d1:f360:dcb6:848e:9255:a411? ([2a01:e0a:d1:f360:dcb6:848e:9255:a411])
        by smtp.googlemail.com with ESMTPSA id l4sm14558018wrx.24.2021.04.12.06.37.31
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Apr 2021 06:37:31 -0700 (PDT)
Subject: Re: [RFC PATCH v1 00/13][GSoC] doc: (monospace) apply
 CodingGuidelines on a large-scale
References: <20210409040301.3260358-1-firminmartin24@gmail.com>
To:     git <git@vger.kernel.org>
From:   =?UTF-8?Q?Jean-No=c3=abl_Avila?= <avila.jn@gmail.com>
Message-ID: <d2e78646-6735-2a27-735c-331de6411ca2@gmail.com>
Date:   Mon, 12 Apr 2021 15:37:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210409040301.3260358-1-firminmartin24@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: fr
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Le 09/04/2021 à 06:02, Firmin Martin a écrit :
> This patch series aims to make the documentation fully compliant to the
> CodingGuidelines regarding monospace font. After it, new contributors
> who just want to change a little portion of the documention could just
> look around how it has been done without being confused by the
> inconsistency between the documentation and the CodingGuidelines.


Thank you for tackling the task of formating the docu and directing to
CodingGuidelines for some markup rules. It appears that the last rule
about backticks is wrong with late Asciidoctor, for which backticks are
only a font switcher and no longer hold any semantic meaning. This means
that double-hyphens may need escaping (see:
https://asciidoctor.org/docs/migration/#migration-cheatsheet) when
switching style and tools.

One other rule worth adding would be that tabs are banned from asciidoc
because they cannot always be matched with correct indentation.


