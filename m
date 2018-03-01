Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 589EC1F404
	for <e@80x24.org>; Thu,  1 Mar 2018 18:08:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033748AbeCASIG (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Mar 2018 13:08:06 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:43309 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033196AbeCASIF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Mar 2018 13:08:05 -0500
Received: by mail-wr0-f195.google.com with SMTP id u49so7515204wrc.10
        for <git@vger.kernel.org>; Thu, 01 Mar 2018 10:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=3k1V7ph/s+Hz/9V/n58C0YEQGg8/n3YUkE2cRVqhqb8=;
        b=JY8OUy8h+3DpFjHK9NjbaswekZjVZN1EvMBk/5NetJZZr30qBFpyiDZ4yEO02xVMOx
         p6wbqg80bwuB6DLW0sOnS4q8EOZeagJuXbSU+Ko6lO70h3Rx7gpWNNfp1oV1mbyAyjuR
         hkrcVv37w5dtyEBq8vRvzfj4o4BZaXk3s5NM6s2biEdsUHo09ohFcSakrj6qT83A6a9L
         btDmJja9e5AZCdl88FIQG9SPXrbLpwc0lUjRqFG5tqq9oCw4d7m5Hz9LEq2rJE/zA936
         XORFEqirdqMQ88v4kT7LIOZmkwQtMMM+YN3oh0VmigV6XYaEPP0DNKd0WkcHyJiGvmC5
         F3EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=3k1V7ph/s+Hz/9V/n58C0YEQGg8/n3YUkE2cRVqhqb8=;
        b=XPyYDgHZSvyL5pGBZGE7TdxDzXoeRVKUUcmoVazPdsF2b50Z0l3NnSh2/Zyv6ctFNW
         YQbkxr6IuPZPuDG74RCPxSzBiw4EsAlU00mxBDBUiPuR9RuV4ZxkLb58EUfVRF7wGH8Q
         jIoXd6d8/geY3gaTfkJscCgIi+PxqbibotpOnlAcycHUnV22PuZl9+u/olUTZSDYbKMl
         blcSjiRIqI9kZxQ3y8ozb148LJ8dITmsOd2kuRD9hgJWo3W/xwvYo8lMR/jHnVE/yUSC
         Z7eEuNExCArLzgC4ZZj/AQpkrfTZ0ld09BwyIt2fLzO0gt8BOP2RtPwVcEqBRJWehi6c
         boRg==
X-Gm-Message-State: APf1xPAzinOPGO3TtFlZmssykIuj/0ezK9QXSwhiPvhsar9wni+oQxS4
        KaASriWJtolLYIuEDO2xrYc=
X-Google-Smtp-Source: AG47ELt0dO1iEHbdnTcvAV6orPRbY9BoAxWmaEDTAgTUbHOikM+rKlEgjCk9L/kbotZ1KgCkEglWxA==
X-Received: by 10.223.185.24 with SMTP id k24mr2861822wrf.83.1519927684294;
        Thu, 01 Mar 2018 10:08:04 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id y8sm4539420wmb.48.2018.03.01.10.08.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Mar 2018 10:08:03 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Eric Wong <e@80x24.org>
Subject: Re: [PATCH 09/11] pack-objects: refer to delta objects by index instead of pointer
References: <20180228092722.GA25627@ash>
        <20180301091052.32267-1-pclouds@gmail.com>
        <20180301091052.32267-10-pclouds@gmail.com>
Date:   Thu, 01 Mar 2018 10:08:03 -0800
In-Reply-To: <20180301091052.32267-10-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Thu, 1 Mar 2018 16:10:50 +0700")
Message-ID: <xmqqvaefhdoc.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> Notice that packing_data::nr_objects is uint32_t, we could only handle
> maximum 4G objects and can address all of them with an uint32_t. If we
> use a pointer here, we waste 4 bytes on 64 bit architecture.
>
> Convert these delta pointers to indexes. Since we need to handle NULL
> pointers as well, the index is shifted by one [1].

Makes perfect sense.

I do not think losing 1 slot out of possible 4G is a regression,
unlike the 256 packfile limit 07/11 imposes.
