Return-Path: <SRS0=Vx3J=3N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 094D3C2D0DB
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 14:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0E982077C
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 14:06:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RlcSheTe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388625AbgAXOG6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jan 2020 09:06:58 -0500
Received: from mail-qk1-f178.google.com ([209.85.222.178]:33424 "EHLO
        mail-qk1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387412AbgAXOG6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jan 2020 09:06:58 -0500
Received: by mail-qk1-f178.google.com with SMTP id h23so2136013qkh.0
        for <git@vger.kernel.org>; Fri, 24 Jan 2020 06:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=LffqrB/lm+WAKNeEMzuW1Ch2q18L2RDh8eGnvKUNQY0=;
        b=RlcSheTenqDCzn4KMDMV9KdNdajBZKt46oL49V1MNruOf2HRvG07W4ItSmFcEODedc
         fR80tF3LRKmdlJSiCvUAY3mubJemfqgSHf9AIbU5ZaCx1a4NrReE3onxZCyKOX+riKsv
         Ny9wQkkG/Vvk3vh0+ylHq3gBxyBQjyYqCA6seeeZbouFkithY+uQjEv/5YoFYuo1YG0p
         klXAlNCx9Qfm+GjINUocCYU84O/eomYm/VjRSAw872l8qqgzxd+bv6M1PfBbktzr17cj
         UtghbVComALGyWhoHkS8gmuuYMd06MwiU9hZdWiCifzf0sf+B2x4N3qa1oXgjT1Ahez6
         lRIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LffqrB/lm+WAKNeEMzuW1Ch2q18L2RDh8eGnvKUNQY0=;
        b=lWuVpXnir9chubUh5o9np4mjzLS7tIx4DnbB5ElbMQkujnHEZQQxiAT/ZHFJ3csOT2
         MiLvgD6ZpXDQYoFtcyMF0a9KBMiLzMQsh2JQ+LcHZsH+1f88VQMJKt/3jhFjLPl2wsIO
         hzmY/j1GCEIR5mfeRQ6iIcsXJFT96mFqGlyO8Z2Sdsl1dXBZxQat6cwVpC8FgjNTQ2ck
         IwGms+mVOjMjsEhy3eT27/vo+loufZ9UXQbkf05zGIQypMretMusfvybTH8L2aaaZA0o
         PvrfZ78/9w6/OAWlRZfiNo+L13NXJ7qH2dhFsa50qOKJQbeaUEKhUFlLCbIeI3MiwI3p
         cl1A==
X-Gm-Message-State: APjAAAWleWk2INd5yAMqLqqNKQhGCv7ZvgNHf3aJbMGqRktmKY+M01Tr
        cEi+YpPVBkB13BYmkQSbYQI=
X-Google-Smtp-Source: APXvYqxriMF1mz27kOzLWBrruARb4bqh8hG55Id22C7kBud386xFBpsW+Qp2JsFW0Hxvu8JhuRlTsg==
X-Received: by 2002:a37:a642:: with SMTP id p63mr2731029qke.85.1579874817549;
        Fri, 24 Jan 2020 06:06:57 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:fdb6:49de:4189:c4f0? ([2001:4898:a800:1010:aeec:49de:4189:c4f0])
        by smtp.gmail.com with ESMTPSA id 2sm3079309qkv.98.2020.01.24.06.06.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jan 2020 06:06:57 -0800 (PST)
Subject: Re: Misrendering of git 2.24 log --graph
From:   Derrick Stolee <stolee@gmail.com>
To:     Jan Engelhardt <jengelh@inai.de>, git@vger.kernel.org,
        James Coglan <jcoglan@gmail.com>
References: <nycvar.YFH.7.76.2001232353220.26179@n3.vanv.qr>
 <b64e8fb7-1dd3-439f-6ab1-1b88c52879d1@gmail.com>
Message-ID: <75f5c537-bb46-7f04-54fe-0bc62762a682@gmail.com>
Date:   Fri, 24 Jan 2020 09:06:56 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:73.0) Gecko/20100101
 Thunderbird/73.0
MIME-Version: 1.0
In-Reply-To: <b64e8fb7-1dd3-439f-6ab1-1b88c52879d1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/24/2020 9:05 AM, Derrick Stolee wrote:
> On 1/23/2020 6:12 PM, Jan Engelhardt wrote:
>> Greetings.
> 
> Hello, Jan. Thanks for sending this report.
> 
>> I have observed git 2.24 outputting a garbage graph element for a 
>> particular history. The issue does not appear in 2.25, but the 
>> underlying bug may still be in there; it is just that _this particular 
>> history_ does not expose it anymore due to the new, more compact tree 
>> rendering that 2.25 seems to be shipping.

I completely misread your ordering here. You are clear that this
is an issue in 2.24 and NOT 2.25. Sorry.

I'm not sure that there is anything to do since the graph rendering
has changed so much, and we intend to keep the new version instead.

Thanks,
-Stolee

