Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06D36C0015E
	for <git@archiver.kernel.org>; Thu, 13 Jul 2023 20:33:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233944AbjGMUd2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jul 2023 16:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232120AbjGMUd0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2023 16:33:26 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7532D2117
        for <git@vger.kernel.org>; Thu, 13 Jul 2023 13:33:25 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id E41FA5C016D;
        Thu, 13 Jul 2023 16:33:22 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 13 Jul 2023 16:33:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imap.cc; h=cc:cc
        :content-transfer-encoding:content-type:content-type:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1689280402; x=1689366802; bh=vdQyvLh/62+DapQN2SODXM2h5RsRNlbegJM
        9wsfeEpU=; b=wsEEz0dYYYJHJc4XfytYcdzuhSiXTXG0INB0x/MAdYYhnL/M3qp
        QQKl4wt4xxbSAsggb6bNeqazekVxMDQTnSzWVbf3SMqMxMB0ntXfyP1lqsAcH7Fc
        MUTpdCx992z++EGj1eWOQ8G0+MOMR+Vjp9MHNxUP23FJR/XHlfQpddwnph6++RC/
        6z7LEeqaAWK9lmxmMYNEb96jFl+wP5YKBS3s3TMfgBADnzynGMlpxJmOA6+zxSS7
        +wV80UrEgUjJ7zcbykcxrWdezn5xasb5l1dpvHqRJbfWHDwB6oMRhZO2rZpUHP3l
        LLjfjLnOZYk0+8Ekv6+kdNLlOR3aHObovVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1689280402; x=1689366802; bh=vdQyvLh/62+DapQN2SODXM2h5RsRNlbegJM
        9wsfeEpU=; b=yLYwf8H+J30KRyDjwscdRN/UVeCpNIdzt9N1rc3J1U6I/LjLyQ1
        S/d6hPmj5hZB4VfsWBYxVmQdiBRjptgqQ9gYYYTrH0P9aqUmNJB2aiHdv6dZZxhk
        yPG8Ov3vumNICWH+38Tk7+Haao4MOReVeQDFijJcGa4MA2dT8AvFQv42ydcrO6LV
        6CQoeoRq+kdflAuY6R5Xb8VtTiri36H8khQ6uT0rskbCTva0yS0jipi7oTlmAoq3
        7H334i6Ptd6vYzzIeKUAhEqiUEfS4OH9lTzuUKfDc0pbq1aMjYjvfpKbmBr1JdU4
        UYZKJj+SvRrwNEKrxBFvFCMgBG5ybvYAhOA==
X-ME-Sender: <xms:kl-wZEeDYaZzOKy95-vT_EHoTrUClK0Yw6lDAzmNyv6IpZMqzypoZQ>
    <xme:kl-wZGPL4FJjVshnEjgvnkLVaJzf0BjL-6uk758D3h3hmrVq2CoRqqBA-a0EpiLY-
    VAgLDAPOPibglRF0A>
X-ME-Received: <xmr:kl-wZFjjFZHOJnEXGFXwM-Gbxi6mUkiPpkMeG_l3PBDhCgAGf4sXk-ozky-05UTVTBf-HrHfj6aDJ_9P8kggkAf0PpXla0qiIHL8eggzsw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrfeeggddugeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlfedtmdenucfjughrpefkff
    ggfgfuvfevfhfhjggtgfesthejredttdefjeenucfhrhhomheprfgvthgrrhcugghuthho
    vhcuoehpvhhuthhovhesihhmrghprdgttgeqnecuggftrfgrthhtvghrnhephefgueeftd
    eghfeljeegjeffffdvieevgfduudffjeehkeettdekkeeufeetleeunecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhvuhhtohhvsehimhgrph
    drtggt
X-ME-Proxy: <xmx:kl-wZJ9Ilpoo2X6oZFZhaFpe3EbA2AKpYcpGiCrD5tDrPys5XG3ZhQ>
    <xmx:kl-wZAuKE-it5ylClfbOkLOb2577NmnEdJPJaRouYOc3udUNtAtwTw>
    <xmx:kl-wZAFFYqvuRrkJE-SBCR8vb-5-GpRJMoEADWBEKasFDRQWJRDiwA>
    <xmx:kl-wZG0TC_gXLQBrRAQ2rNbyRrhJjHq8WdzYbMZClwAS8x5wjLmFuw>
Feedback-ID: iccdf4031:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Jul 2023 16:33:22 -0400 (EDT)
Message-ID: <9de918bc-6913-0486-02dd-5b4028a7fe1b@imap.cc>
Date:   Thu, 13 Jul 2023 22:34:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 1/1] docs: highlight that .gitmodules does not support
 !command
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <d775437e-7fa3-189b-a1c3-4fd358dd9768@imap.cc>
 <20230713193342.1053968-1-pvutov@imap.cc>
 <a8bde495-57fc-6a70-e325-6e2a52f40552@imap.cc> <xmqqwmz3oacg.fsf@gitster.g>
From:   Petar Vutov <pvutov@imap.cc>
In-Reply-To: <xmqqwmz3oacg.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/13/23 21:55, Junio C Hamano wrote:
> Petar Vutov <pvutov@imap.cc> writes:
> 
> Don't.  People should be familiar with "configuration variable", but
> may not be with "git-config variable".

Right, on closer inspection this collision with .gitmodules is rather 
niche to start with. Few things in .gitconfig are also legal in .gitmodules.

>   
> -The following 'update' procedures are only available via the
> -`submodule.<name>.update` configuration variable:
> -
> -	custom command;; arbitrary shell command that takes a single
> -	    argument (the sha1 of the commit recorded in the
> -	    superproject) is executed. When `submodule.<name>.update`
> -	    is set to '!command', the remainder after the exclamation mark
> -	    is the custom command.
> -
>   	none;; the submodule is not updated.
>   
> +	custom command;; When the `submodule.<name>.update`
> +	    configuration variable is set to `!custom command`, the
> +	    object name of the commit recorded in the superproject
> +	    for the submodule is appended to the `custom command`
> +	    string and gets executed.  Note that this mechanism
> +	    cannot be used in the `.gitmodules` file.
> +
>   If the submodule is not yet initialized, and you just want to use the
>   setting as stored in `.gitmodules`, you can automatically initialize the
>   submodule with the `--init` option.

I prefer the original description as it uses shorter sentences. I can't 
hold that 5-liner in my head :)

But now I really am bikeshedding, and I've taken enough of your time. I 
will send a v4 with just the .gitmodules disclaimer, no rewrite, in case 
you end up agreeing.
