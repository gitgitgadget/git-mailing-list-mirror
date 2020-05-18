Return-Path: <SRS0=mA98=7A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C52C433E0
	for <git@archiver.kernel.org>; Mon, 18 May 2020 10:55:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C351420709
	for <git@archiver.kernel.org>; Mon, 18 May 2020 10:55:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fdzHNDVA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbgERKzA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 May 2020 06:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbgERKzA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 May 2020 06:55:00 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 113F8C061A0C
        for <git@vger.kernel.org>; Mon, 18 May 2020 03:55:00 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id e1so11287570wrt.5
        for <git@vger.kernel.org>; Mon, 18 May 2020 03:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=ddISawYEWVo8mi3TpGrBjfB/FdbSZs6hW/Im3foTEHY=;
        b=fdzHNDVAD1KaS/SN9gJN9hLe/sL7wkIa4z5fD7oTka207UBOyytB0EU6P8TvvpW+Fu
         mr02FXvKs3AOBbpLuKrdtm1jT5DYP+j7Zbta3nJnSogQdsAgBOy76+Ay4q+6RC5ZS8Kl
         R0Lt7gWgqhZlVYIR5xFDDgCAmuUQxYH63CEtT7fs0PZqCZRXZjnfOghOc8i6ICy5Kwh8
         6dadiEW4m4zINwK4pn5f3rDBh6qsmMkJMKjty0z2bJwxtLY/uwV1m77vTf6U1Rn4WZ6O
         e1Jvgqz95oc+oqxzeBP4Z7YkLyu/fd5K5VaLWSzwua+JaZJRk2d79MBLbRSn9Cm39vts
         nBTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ddISawYEWVo8mi3TpGrBjfB/FdbSZs6hW/Im3foTEHY=;
        b=pNRkROl8dWGIkh4dj5dokp3jxkwqzWpXRIbgI9TV9HY7+ZU1kBAB+WX6zbWRHVX12C
         FvgXrxbGSmYw80mY8FY8VbuLp/VWSEEnmQoXL6bNQXjgZ/HrJtjjFSNx6k23m0bvLdfQ
         Hz/1Vo1pl524Z3ShqicCKZagre1HyvkL1nvnYTkO/Q7klcrzR2oKWpggi2hBaTyq0yxF
         jeUJbRwR9tSAt/PdWgSeqwNTfzq7XawX25LerfRUOAMocW3KQbsoBxk0D5Zf/g7eSf4G
         8dBgELVAasip7zdzv9B4iV+iWpQTSw6BUgU0pQjQjnM2V2c9zAo3RFCyVUzovG4brjaf
         LU3Q==
X-Gm-Message-State: AOAM532jfXYkAuXtDry4w9lvIlJgHBN/X5ZEp7k7FmCVNAMET8MiQQSL
        dhSob0EGTiNtcW69WCzL3srhBaJw7o3lbA==
X-Google-Smtp-Source: ABdhPJzhKGl+dxY6uWfChRk5fMdl5RWjCSqChYYHkfoLLfMmd1P2/yEwe5t9rcOWOKEBRVqiSQx2nw==
X-Received: by 2002:adf:ef48:: with SMTP id c8mr18574472wrp.140.1589799298433;
        Mon, 18 May 2020 03:54:58 -0700 (PDT)
Received: from ?IPv6:2a01:e0a:d1:f360:50d4:b23c:1584:5a1c? ([2a01:e0a:d1:f360:50d4:b23c:1584:5a1c])
        by smtp.googlemail.com with ESMTPSA id v22sm2642019wml.21.2020.05.18.03.54.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2020 03:54:57 -0700 (PDT)
Subject: Re: [PATCH 2/7] git-bugreport.txt: fix reference to strftime(3)
To:     =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
References: <cover.1589739920.git.martin.agren@gmail.com>
 <4753804d23ba7b1b267b6557077c80f3a8891712.1589739920.git.martin.agren@gmail.com>
 <CAPig+cTMrdeBLzUKKpkuZgSbXULhQb4epNC5qMMTUgqfZ1a0bA@mail.gmail.com>
 <CAN0heSqkGnYpOvzym+fv6_2_791j6jRwyWMpG9hG4H2KfY6BRQ@mail.gmail.com>
From:   =?UTF-8?Q?Jean-No=c3=abl_Avila?= <avila.jn@gmail.com>
Message-ID: <96735cc6-35d6-f94d-75d5-d6d4df1aefa0@gmail.com>
Date:   Mon, 18 May 2020 12:54:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAN0heSqkGnYpOvzym+fv6_2_791j6jRwyWMpG9hG4H2KfY6BRQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 18 May 2020, Martin Ågren, Eric Sunshine wrote:
> On Sun, 17 May 2020 at 21:23, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> On Sun, May 17, 2020 at 2:52 PM Martin Ågren <martin.agren@gmail.com> wrote:
>>> When we say "link:strftime[3]", it ends up rendered as "3[1]" and we
>>> produce a footnote referring to the non-existing
>>> file:///.../git-doc/strftime. Make sure we use gitlink, not link, to get
>> s/gitlink/linkgit/
> Oops, thanks! At least the diff is correct.
>
> Martin

Not even sure of that: strftime is not an internal manpage, so for html
target, we will end up with a hyperlink to an non-existing file
strftime.html. So I would keep it as simple text.


JN




