Return-Path: <SRS0=FxFb=2J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F688C43603
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 13:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57EC9218AC
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 13:56:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gmvipZQb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbfLSN4q (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Dec 2019 08:56:46 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:39894 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726759AbfLSN4q (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Dec 2019 08:56:46 -0500
Received: by mail-qv1-f67.google.com with SMTP id y8so2236016qvk.6
        for <git@vger.kernel.org>; Thu, 19 Dec 2019 05:56:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EvqmhRlEIpZknho78AsZTSvdKFpdA/QV421KwI4Iyvg=;
        b=gmvipZQbeya4s6svUbZahd38UOnR3N+tF87HWnRAHJzwFqMTKgvLgYotPyPnpbQSxB
         GAnD/urPNmNx4x0Cr99XHhvQdIpkdSLYhVf0EbS2MoTmZY8HMBa09OEa9ZBWRklAepPA
         aC+sM7bx/IpBjnYHUgw3Gxlt+8/0oM5SPz5sMkvaRCjO0jA5VXlHN7nPXnBV5H1GjKuA
         MX3mQCnxAfPQ6XNE26+6XyDkYP6+x60Cysw1yA8jT3COwHdL4xmOth1yFpFAMLNh3Ro+
         vTzkb0gdCcHjEu2rwtdP0Kf7wuLpVP3qTrvAfXWjAqBKZoiad3LIsQBcZol5/gAJUX+y
         WApQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EvqmhRlEIpZknho78AsZTSvdKFpdA/QV421KwI4Iyvg=;
        b=HyUdunMiSUum1Rd9AGwLsIbr+F0WDtPxJCZXX/AgG9BhPbm+kMPU8cDf059eeh+G6Y
         36b5bpNSomAo2sJX0IoGTqfDgCTHPTwWfAYKt5sy1ih80ckj9gyvWNlx3094ssdCKUmM
         nXTNrmJAabrCYCVGnHHH0ExIhBdpMF02s+vLKphTJUCnEesK/RwUTqpJ6DZ6cyCAY53S
         ba/3VPcoT3rgbU6wxuL6C6HHCkDs455GF9IxF2K2KyzutYO1uSUNE0P7SbuHAB9JoWRp
         xWrYizrs6Y9n632IGemiluGsH6eKYGWWVxwYUZwBaChl2H/UIEV6WQmow2mVAHVn69+U
         zuGw==
X-Gm-Message-State: APjAAAX7lbj/pqUGY+5J6PrAh92Vc6GD0yPDvAibEoskMGolQWnIG6+K
        vMpG4PicDG6D9x31iWm8asA=
X-Google-Smtp-Source: APXvYqyEB1B0ZfWHV3bmD6aKDYQ+FqqJxIoN3WOZarlhtlSd7rZvSxpSHJpzsNLXdnDsk66nB5NknA==
X-Received: by 2002:ad4:4dc9:: with SMTP id cw9mr7835571qvb.0.1576763805080;
        Thu, 19 Dec 2019 05:56:45 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:8501:57f5:696:2045? ([2001:4898:a800:1012:3635:57f5:696:2045])
        by smtp.gmail.com with ESMTPSA id k22sm1739994qkg.80.2019.12.19.05.56.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Dec 2019 05:56:44 -0800 (PST)
Subject: Re: [PATCH] sparse-checkout: improve OS ls compatibility
To:     Eric Wong <e@80x24.org>, Ed Maste <emaste@FreeBSD.org>
Cc:     git@vger.kernel.org,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
References: <20191219015833.49314-1-emaste@FreeBSD.org>
 <20191219024518.GA3411@dcvr>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <c4fef89a-2275-b4bc-b5c2-7bc647cd9bf6@gmail.com>
Date:   Thu, 19 Dec 2019 08:56:44 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:72.0) Gecko/20100101
 Thunderbird/72.0
MIME-Version: 1.0
In-Reply-To: <20191219024518.GA3411@dcvr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/18/2019 9:45 PM, Eric Wong wrote:
> This goes on top of your patch:
...
> +	( cd "$1" && for i in *; do echo "$i"; done )

Could we drop the "cd" and "echo" processes with this line instead?

	for i in "$1"/*; do printf "$i\n"; done

Thanks,
-Stolee
