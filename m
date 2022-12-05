Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD9FC4708C
	for <git@archiver.kernel.org>; Mon,  5 Dec 2022 23:32:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231863AbiLEXcl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Dec 2022 18:32:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231559AbiLEXci (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2022 18:32:38 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 445D7BAB
        for <git@vger.kernel.org>; Mon,  5 Dec 2022 15:32:37 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id t18so2596985pfq.13
        for <git@vger.kernel.org>; Mon, 05 Dec 2022 15:32:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HxICaAZErDeZecStwlQbAhwh2rpYU5LPGZJu5M3XFJ4=;
        b=i9gVNrbGgMraImrTgYWfQexE5W4cv3JxzaVfIVUwmmk/ezoPa9Tm//YbhDlO6iFesC
         WZoXVDNXEq9WfOVMboqO1Zg7n5wA0n5TqRmXPR4Q5bKhxeF9G4YoRsEH1Frb2oWNhAQG
         CDof19dFSQMFCKC6sM4LpSg8HPByDd5CTHf/xDiHCqsSHBykAriORU/Y23BO0I1lOrKm
         ln1ckHG8yx51U6mded4IpAInbQxj4I5vpI+HDf/lHSy/E1QFo5nHzgwWi1JFMBFQ+Jj1
         cMZct9ndGsBFtGkDwnh1sV9J95jtXUU3S5girJSZse/d1zqmaYvoKZ3l3O/OYrv3EJTo
         QgNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HxICaAZErDeZecStwlQbAhwh2rpYU5LPGZJu5M3XFJ4=;
        b=SwwAxVFdszIJxMg0MAO/7neRv9qWo40JlGE2IO14EUrs9puUcKKc6Pjcy4qB74G/3r
         UOu5ezUwZUdpvWnZYw9lvhbZyuwryyx9bjovrSmDd8SlozN1iG0QrQ5re2ZP+dEP+bDv
         qB4crKIrj2DDEI2qVw/HIxROuXrONsW1hjyR0WGPoVL9oNQ5Y30wYaUAaEmagt9Hq76U
         +kFKEuTcHfNTdCeoZck652QUH0SvAQyKD4bSpYsvROCEqURjqj9inqs9nHffAcT7yD7c
         10kMQiXHY6DbhHj2PNCjXT0pqwzUnGAZEBossd37QhnG85iDARXvC2/OtBq2kv0t79S0
         Ob4g==
X-Gm-Message-State: ANoB5pm8PU1ZRwSV9cAzEoABOJWSUnkiElnio1tus4m/Jh9/i8pUX573
        cMOPX72opF/t48tPyaA69Hg6
X-Google-Smtp-Source: AA0mqf4Iv14o3ERiRd4PyNoIPMsgpgNUjkPz6GhHS/3r9R8jbJDQrryn2MZIhb6sawHzS1Sqf/UzNw==
X-Received: by 2002:a05:6a00:17a2:b0:576:7b11:594d with SMTP id s34-20020a056a0017a200b005767b11594dmr16013675pfg.9.1670283156842;
        Mon, 05 Dec 2022 15:32:36 -0800 (PST)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id l6-20020a170903120600b001893efd3e03sm11203451plh.119.2022.12.05.15.32.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Dec 2022 15:32:36 -0800 (PST)
Message-ID: <c0a0dd7b-3ffa-eff7-8ddd-19e8efd24575@github.com>
Date:   Mon, 5 Dec 2022 15:32:35 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: [PATCH v3 06/11] bundle-uri client: add helper for testing server
Content-Language: en-US
To:     =?UTF-8?Q?=c3=86var_Arnfj=c3=b6r=c3=b0_Bjarmason_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, mjcheetham@outlook.com, steadmon@google.com,
        chooglen@google.com, jonathantanmy@google.com,
        dyroneteng@gmail.com, Derrick Stolee <derrickstolee@github.com>
References: <pull.1400.v2.git.1668628302.gitgitgadget@gmail.com>
 <pull.1400.v3.git.1670262639.gitgitgadget@gmail.com>
 <46a58e83caf6d37e5a62b39d3c2e35e278211297.1670262639.git.gitgitgadget@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <46a58e83caf6d37e5a62b39d3c2e35e278211297.1670262639.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason via GitGitGadget wrote:
> From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=
>  <avarab@gmail.com>
> 
> Add a 'test-tool bundle-uri ls-remote' command. This is a thin wrapper
> for issuing protocol v2 "bundle-uri" commands to a server, and to the
> parsing routines in bundle-uri.c.
> 
> In the "git clone" case we'll have already done the handshake(),
> but not here. Add an extra case to check for this handshake in
> get_bundle_uri() for ease of use for future callers. Rename the existing
> 'got_remote_heads' to 'finished_handshake' to make it more clear what
> that bit represents.

nit: I think this last sentence ("Rename...") is out-of-place, since you
made that change in patch 5 [1].

[1] https://lore.kernel.org/git/b009b4f58ea312e40af385ea5ca7ede5ea07391a.1670262639.git.gitgitgadget@gmail.com/

> diff --git a/transport.c b/transport.c
> index a2281d95262..97d395e10a3 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -371,6 +371,13 @@ static int get_bundle_uri(struct transport *transport)
>  		init_bundle_list(transport->bundles);
>  	}
>  
> +	if (!data->finished_handshake) {
> +		struct ref *refs = handshake(transport, 0, NULL, 0);
> +
> +		if (refs)
> +			free_refs(refs);
> +	}

This makes more sense without the extra assertions. Thanks!

