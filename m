Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8102CC4332F
	for <git@archiver.kernel.org>; Mon, 19 Dec 2022 23:27:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232414AbiLSX1R (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Dec 2022 18:27:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiLSX1Q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2022 18:27:16 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 327A46383
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 15:27:15 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id q71so7228370pgq.8
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 15:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K8lzTF2XN4Tpps5rsjwUQ9Y/fCdKHesAeCZ3r5KK4wM=;
        b=cZHXPPEsChtvXmOawzfJwSW57kSP7qINFrxsBl9guBWe+z0Fh4UOKvXSAqV/8dHfia
         JiVK5bbPpgdGJswBSAf7o/at2zbN/o7AEpbMtqQc5Iy++QqS51tQlRMOe1X8DOIej2Ux
         rCgVzzI6WmFR3vMza1C1Mam2wqbYqkpRQTmZr74ZkjYfWOfDT5iJU+YRt81raVO5ADbl
         m0lDLW/C+Hq1L15+IULJXNRRqExN6+4gKjDH6EnXH06RqL7SnTB95QQLqd4Qn1LV8o2h
         x+LY6FvecqxnSttu/lso8mfx5Ej5T9JX9biCLZGz13nWQmOvUPQy/NsZ+AkW1S5VSc0W
         pDcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=K8lzTF2XN4Tpps5rsjwUQ9Y/fCdKHesAeCZ3r5KK4wM=;
        b=AlaPI5WlWKhNd3YZ+zGGXRQUUqpsSxpXWTbJgNg91zWlxjUzUCLvbNRg/f6zfplaoZ
         2l7tdQav37E4pEnZqS/37y8mWxvwtbj+FitE8dSRB26da7qgjDe5N6A5NseCcyvxSlmx
         +Sr1KadjiLoBSH+i/cflTa1fQuqkF1c79f9m3bNLFoTmLU3CMmHotIwc+TpmEtSRdjKl
         41NlexjzV0ECzluhKlR4g5acxWfSpj6TRDgGl/jg1A/tyVO4Jyf9WFTyVPcxXIfmrdqZ
         QcUzVifR1KYG2vdyoLr3VRm8fn0sHZDSw1KHsm46zmrv6eVIcTXU7bcDBATpkmATfNRx
         86CQ==
X-Gm-Message-State: AFqh2kqAWRvifRXjXmIVwd6eeOvQe6TSau+Yz/M5YeodJlGkTeoAmlxu
        I6nCXvhItt0FgeOoKhPoR5I=
X-Google-Smtp-Source: AMrXdXsXXPeRutFjCTaDCr5izZyqwzXxhrVevEWslnwgyW4KgWqyKHF0k05gbndBiwTkTKyenDVscw==
X-Received: by 2002:a05:6a00:2488:b0:577:adb7:20dc with SMTP id c8-20020a056a00248800b00577adb720dcmr14842056pfv.5.1671492434429;
        Mon, 19 Dec 2022 15:27:14 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id u66-20020a626045000000b005771f5ea2ebsm7150189pfb.135.2022.12.19.15.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 15:27:13 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Nemmaier, Christoph" <christoph.nemmaier@cpp.canon>
Cc:     "rsbecker@nexbridge.com" <rsbecker@nexbridge.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: AW: PROBLEM: "git pull -v" fails with exit code denoting a
 submodule syntax error
References: <AM8P195MB0820A54FEA04231D440F74D780E69@AM8P195MB0820.EURP195.PROD.OUTLOOK.COM>
        <000b01d9112a$541c4de0$fc54e9a0$@nexbridge.com>
        <xmqqcz8jmz4e.fsf@gitster.g>
        <006a01d911b3$57e0d1b0$07a27510$@nexbridge.com>
        <AM8P195MB0820F8606B7B7A2B91442C4A80E59@AM8P195MB0820.EURP195.PROD.OUTLOOK.COM>
Date:   Tue, 20 Dec 2022 08:27:13 +0900
In-Reply-To: <AM8P195MB0820F8606B7B7A2B91442C4A80E59@AM8P195MB0820.EURP195.PROD.OUTLOOK.COM>
        (Christoph Nemmaier's message of "Mon, 19 Dec 2022 08:02:39 +0000")
Message-ID: <xmqqzgbj2cvi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Nemmaier, Christoph" <christoph.nemmaier@cpp.canon> writes:

>> ...
>>>
>>>I suspect it is the same issue as the one that triggered
>>>
>>>
>>https://lore.kernel.org/git/f805f2da-a7e1-9fde-cc0a-04a30f79c9af@cs-ware.de/
>>>
>>>which came out recently?
>>
>>If that is the case, perhaps the -v needs to be documented in the online help if/when this condition is fixed.
>>
>
>
> Good morning,
>
> it pretty sure is. The doc goes like:
>
>> -v
>>--verbose
>>
>>    Pass --verbose to git-fetch and git-merge.
>
> Intentionally or not, git-submodule is not listed.
>
> Anyway, I think the doc is correct, as git submodule doesn't know
> '-v'. So either the internal call should drop '-v', or 'submodule'
> should ignore it.

Yes, <f805f2da-a7e1-9fde-cc0a-04a30f79c9af@cs-ware.de> cited above
is exactly about doing that.

The resulting 6f65f847 (submodule: accept -v for the update command,
2022-12-10) is about to hit 'next'.
