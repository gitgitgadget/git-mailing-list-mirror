Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEDB3C6FA90
	for <git@archiver.kernel.org>; Mon, 26 Sep 2022 15:31:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234262AbiIZPbA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Sep 2022 11:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236899AbiIZP3f (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2022 11:29:35 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 218EF13F2B
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 07:13:21 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id z191so5288430iof.10
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 07:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=+jB8DkaCseinfETeDn2Ub08AYJ1Ls3n3jh377Y2PUhk=;
        b=WSGTeQ1o490byobhlQjbm9AtWr8m5gLMevpOZEQzQt2DsVB6jfg6oBBl7ZP9NkHpSf
         EFzBmz5VrW5X2cpysSRdzFdifJpfW907P+b98Be1AkM+y557IXuylenlpmVrKj6OfiRX
         tslrTy+AihOYj0hWavVIedlWMr+u5VfKLS13DVIe/o2BVLG4aWu2gl4Es81iNlIFEv87
         ELU9Xig/AREdrArqABfj35rUN5ctOFREM/tVacPsH0icHzQsZIs9GL+hTC7BdKuFvUuL
         69laiNqz4mXqU0hgGvrDLCoO/FFsfGktDy8jZHtXxcZGru3LRKO18Cd6D4mviwYuKB5D
         O8+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=+jB8DkaCseinfETeDn2Ub08AYJ1Ls3n3jh377Y2PUhk=;
        b=ywLrVZ1nSZkKixJln6JIltgEtnyYi6mwpzesiO5eBfxps0ZtSAgziXFkwge99DHSMp
         LIPdaOi0AcPxWm7KG0v0ExLrwBznDuza0yM0FoCYg9RDmGQxvlfrk1tHeG/yWlsCGrv7
         Eef1LURdG/EiqT9ecml7R1CEWZVFY12Y281VDumnMLif3eupCzBWIuBVKyW/6i4iPd2u
         zvpv3W1qKdzIjMib3Uu++e5k7mrDvgaGoC2HX4QFLDGEHINmroK+geTirGk2KYtSJfAb
         gYWTV+rkpMJYBK8r9Fpn/KupREroS5fTj4fXK3QFL1yf3hucDkCViTLaJ4faAZ0oLg/u
         0lgw==
X-Gm-Message-State: ACrzQf2Cq6OKVM6GAtO/15VTNxKfnw/ExebI+Hp7c4N9ca/IBDJVOebK
        8GIQ14GjoZrjS06UZFZkLTeOLBxT0+nS
X-Google-Smtp-Source: AMsMyM43WoXfz+ci/M9XDJwUjS9kdlmGQxcgljLw1ZjYk3MWGEJxtytc6nkQAXmMMothI4j1b2G0pg==
X-Received: by 2002:a02:880b:0:b0:35a:e4be:c408 with SMTP id r11-20020a02880b000000b0035ae4bec408mr11680694jai.113.1664201600492;
        Mon, 26 Sep 2022 07:13:20 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:6c7d:bb49:cfa:a946? ([2600:1700:e72:80a0:6c7d:bb49:cfa:a946])
        by smtp.gmail.com with ESMTPSA id v9-20020a02b089000000b00358322b32a3sm6941690jah.70.2022.09.26.07.13.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Sep 2022 07:13:20 -0700 (PDT)
Message-ID: <de9bd893-a986-20e6-226e-913d0b6930cf@github.com>
Date:   Mon, 26 Sep 2022 10:13:18 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 4/8] http: read HTTP WWW-Authenticate response headers
Content-Language: en-US
To:     Matthew John Cheetham <mjcheetham@outlook.com>,
        Matthew John Cheetham via GitGitGadget 
        <gitgitgadget@gmail.com>, git@vger.kernel.org
References: <pull.1352.git.1663097156.gitgitgadget@gmail.com>
 <78e66d56605cfb1c7000edf329ac16c05a5d69b0.1663097156.git.gitgitgadget@gmail.com>
 <9fded44b-c503-f8e5-c6a6-93e882d50e27@github.com>
 <AS8PR03MB8689A10E534EC69BB71AEA56C04F9@AS8PR03MB8689.eurprd03.prod.outlook.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <AS8PR03MB8689A10E534EC69BB71AEA56C04F9@AS8PR03MB8689.eurprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/21/2022 6:24 PM, Matthew John Cheetham wrote:
> On 2022-09-19 09:21, Derrick Stolee wrote:
>> On 9/13/2022 3:25 PM, Matthew John Cheetham via GitGitGadget wrote:

>>> +
>>> +		strvec_push(values, val);
>>> +		http_auth.header_is_last_match = 1;
>>> +		goto exit;
>>> +	}
>>> +
>>> +	/*
>>> +	 * This line could be a continuation of the previously matched header
>>> +	 * field. If this is the case then we should append this value to the
>>> +	 * end of the previously consumed value.
>>> +	 */
>>> +	if (http_auth.header_is_last_match && isspace(*buf.buf)) {
>>> +		const char **v = values->v + values->nr - 1;
>>
>> I suppose we expect leading spaces as critical to this header, right?
> 
> Leading (and trailing) spaces are not part of the header value.
> 
> From RFC 2616 section 2.2 regarding header field values:
> 
> "All linear white space, including folding, has the same semantics as SP.
> A recipient MAY replace any linear white space with a single SP before
> interpreting the field value or forwarding the message downstream."
> 
>>> +		char *append = xstrfmt("%s%.*s", *v, (int)(size - 1), ptr + 1);
>>
>> We might have better luck using a strbuf, initializing it with the expected
>> size and using strbuf_add() to append the strings. Maybe I'm just prematurely
>> optimizing, though.
> 
> This code path is used to re-join/fold a header value continuation, which is
> pretty rare in the wild (if at all with modern web servers).

I think the point is that I noticed that you removed the leading whitespace
in a header's first line, but additional whitespace after this first space
will be included in the concatenated content of the header value.

As long as that is the intention, then I'm happy here.

Thanks,
-Stolee
