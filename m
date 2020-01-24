Return-Path: <SRS0=Vx3J=3N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE36EC2D0DB
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 18:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 834222075D
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 18:45:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m3N0oWxa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391531AbgAXSpg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jan 2020 13:45:36 -0500
Received: from mail-qv1-f50.google.com ([209.85.219.50]:34302 "EHLO
        mail-qv1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388325AbgAXSpg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jan 2020 13:45:36 -0500
Received: by mail-qv1-f50.google.com with SMTP id o18so1397740qvf.1
        for <git@vger.kernel.org>; Fri, 24 Jan 2020 10:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0WQj4QlcTaiintsxlPRQubeki0Pm6JlkCjPlxXYJKS4=;
        b=m3N0oWxa2ttlVK7QxKXWeIKLuQBeyk93LnVnO/bZrWGhL18w4Cvfe/nUzIeYacFwd7
         xbD8x/Ci54c9beEKlanPCGS6OuI37EFZsAtfA1g9aLAYIpfihuoD7ZCn81LndMcSFc/A
         j0xeCengUZonqCd9YB3/Oy19cSiGEO3o5ZFd30cTaErwhlzjV+JMWTcHiHAz16GudUey
         EQZT7zLBumiNVwVY88o0X4X2a6qBXWNK32529luzid38/ZmJk0Px+PrgA0atNMpenDgx
         f+32SZhfXSGSav4uqgahugaf2y1IPbxVPgKW4jk8JPZmcalORlLoUyjysXRTGUuOGEls
         aODA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0WQj4QlcTaiintsxlPRQubeki0Pm6JlkCjPlxXYJKS4=;
        b=Ol/p/rD/tilCu+1iWNMZGTR3EFyTn6u+r+e+3jqiR1OkAf0B4h8vrfs+AhzbDkISKL
         RMwiTUJHrKdzequBy3rqd+4YaUCsSCrnv8FzDsNGdJhJ2znMH9aCMOBfU/ZJVp77g8Ua
         EkuVZBuFCT5ulDnN4bAOW5aM0LA6L9bK5lfGRTw1NPrdERspWkLrLFIvG8+696fi6wIA
         YXOjomXbUYv4PQBZlRVSHjkec5JLeMIjOFzoImN0WOax7aPLZKRca/xXVEmdeUhn2qyw
         T0QfVGAhCqmvLLSWueNmorB/Pyy9C7ZsYXxWidCtTIERvYT36slqZvvCKRETl9Vieofs
         MxOg==
X-Gm-Message-State: APjAAAUAOZCL0G81gmzrm3fW5h7ScSCp4Rjo+MEjpV7m30WLtGzIHMaq
        BoGcUzR7IRYINqooqpyXo5h5QBMvrSs=
X-Google-Smtp-Source: APXvYqxn/Wrb4wB2f/vpa9+RBjaW35zoVyBohbY3VMgQ5E899OrGZU0JVhw24S6VJLSFJFMska3Xmg==
X-Received: by 2002:a05:6214:13a3:: with SMTP id h3mr4326789qvz.212.1579891535592;
        Fri, 24 Jan 2020 10:45:35 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:a0e6:7d5:ea31:352? ([2001:4898:a800:1012:521a:7d5:ea31:352])
        by smtp.gmail.com with ESMTPSA id k23sm1225432qta.19.2020.01.24.10.45.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jan 2020 10:45:35 -0800 (PST)
Subject: Re: Misrendering of git 2.25 log --graph
To:     Jan Engelhardt <jengelh@inai.de>
Cc:     git@vger.kernel.org, James Coglan <jcoglan@gmail.com>
References: <nycvar.YFH.7.76.2001232353220.26179@n3.vanv.qr>
 <b64e8fb7-1dd3-439f-6ab1-1b88c52879d1@gmail.com>
 <75f5c537-bb46-7f04-54fe-0bc62762a682@gmail.com>
 <nycvar.YFH.7.76.2001241730030.32144@n3.vanv.qr>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <3e9089c4-8ba6-b62c-cda3-607152790566@gmail.com>
Date:   Fri, 24 Jan 2020 13:45:34 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:73.0) Gecko/20100101
 Thunderbird/73.0
MIME-Version: 1.0
In-Reply-To: <nycvar.YFH.7.76.2001241730030.32144@n3.vanv.qr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/24/2020 11:34 AM, Jan Engelhardt wrote:
> On Friday 2020-01-24 15:06, Derrick Stolee wrote:
>>
>> I completely misread your ordering here. You are clear that this
>> is an issue in 2.24 and NOT 2.25. Sorry.
>>
>> I'm not sure that there is anything to do since the graph rendering
>> has changed so much, and we intend to keep the new version instead.
> 
> I now have a minimized reproducer, for *2.25*:
> 
> » ../git/git log --oneline --graph --all --decorate --topo-order
> *   e1ee7b8 (HEAD -> master) Merge branch 'k9' into k10
> |\  
> | *   7b48214 Merge branch 'k8' into k9
> | |\  
> | | *   ed02a51 Merge branch 'blah' into k8
> | | |\  
> | | | * 44279cf blah
> | | * |   4053c4d Merge branch 'k7' into k8
> | | |\ \  
> | |/ / /  
> | | | _   
> | | * 5b449d6 update 8.7 news
> | |/  
> | * 43a324f foo
> |/  
> * 5932a51 root

Hm. I get the above output for v2.24.1. Since you are using a
specific path for your execution, then perhaps that version
disagrees with the one on your PATH that reported "git version"?

For v2.25.0 I get this:

*   e1ee7b8 (HEAD -> master, origin/master, origin/HEAD) Merge branch 'k9' into k10
|\  
| *   7b48214 Merge branch 'k8' into k9
| |\  
| | *   ed02a51 Merge branch 'blah' into k8
| | |\  
| | | * 44279cf blah
| | * | 4053c4d Merge branch 'k7' into k8
| |/| | 
| | |/  
| | * 5b449d6 update 8.7 news
| |/  
| * 43a324f foo
|/  
* 5932a51 root

Again, the key is at 4053c4d where the first edge out
of the merge commit moves to the left.

Thanks,
-Stolee
