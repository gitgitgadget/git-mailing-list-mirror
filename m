Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B96CC1F404
	for <e@80x24.org>; Wed, 28 Feb 2018 14:38:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752517AbeB1Oi3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 09:38:29 -0500
Received: from mail-qt0-f170.google.com ([209.85.216.170]:43903 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752213AbeB1Oi2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 09:38:28 -0500
Received: by mail-qt0-f170.google.com with SMTP id d26so3176210qtk.10
        for <git@vger.kernel.org>; Wed, 28 Feb 2018 06:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=+UUkVgeLETAgaWeJnyhSlIVvOeIv+VZ9AKVWZFen6rs=;
        b=i3SgxVO4PLJ7V75OrK0Mx1OzW3ahiXdIbBLfuogMKeIQEje5Avy+q6o9b7vq5KhBmH
         1SMyI9wCCi5CFCjA+XYqsDodg4/yhlcO1HeOFoHBH/0UDUve4WOKyihANf26MfuAPAsX
         frfMHxes4m/Khptw01FonNbUgknwGmmX2DQM1jQ3yMqTcC6P7r7JPTxDPE+n3/cCHXZC
         ksRXAcbyYkUog8jJm6v846ENRK3mdp6nLYUwYOZrEm4OaQX3drxMQgKPoqDMqEKpYjf9
         PQV7fegipUXC27m9l2Zr/9wq81h7rwYlbkk2xmv9AnveV85KQFfeXhRqD97UxPy1/heE
         kDpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=+UUkVgeLETAgaWeJnyhSlIVvOeIv+VZ9AKVWZFen6rs=;
        b=CwWOm9lf+5qMJ/MgzZX04xxs2UCXj560ft5zf5KRndry37nEA+XJm1IIe1EYr9Xtif
         XGwn7bi3HF3C8YkcWyTBSB758zHmXq2KxxshQCxZuX5s48B+oEWuxQ6lnsX3POSLpZG5
         hYUXnqFXtTnwbNDgm3fJwQH2wxYQlc6RMh+OGVVXkRuK41gFm4CIdGRepehwI4ab7HxV
         S8gNCEat6rmIy+L8UJPMMdPa1e0F530Am3h+0JOTBJZUnFqQnAxESB3EhhscuZUzrSF3
         lh3TuyX7Lj1T+aCeC/fNnvhDP5Qa73l9uLjjZapxwbliUKfp4dn2TsrOaLDQ0gunN5cS
         EXTw==
X-Gm-Message-State: APf1xPB6igkad0sLNcPNuw0WsauaRj5hPPOs2/25KgNH8y5b947RB8Y6
        TCG/DKcD3y7G7lz9BXgnzNcqH9zR
X-Google-Smtp-Source: AG47ELv1/G4uAAXVt9PMeWYLhKI3ygGDwPLN9Zxj3gcVsdhKra82Pm2QAi9cIYdLHE4OD7gVBtc5XA==
X-Received: by 10.237.32.9 with SMTP id 9mr29137376qta.74.1519828707600;
        Wed, 28 Feb 2018 06:38:27 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id v57sm1280286qtv.7.2018.02.28.06.38.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Feb 2018 06:38:25 -0800 (PST)
Subject: Re: [PATCH 03/11] packfile: allow install_packed_git to handle
 arbitrary repositories
To:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org
Cc:     pclouds@gmail.com
References: <20180228010608.215505-1-sbeller@google.com>
 <20180228010608.215505-4-sbeller@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <a662ba5a-9bd9-9182-9bf9-1177b8238d4d@gmail.com>
Date:   Wed, 28 Feb 2018 09:38:25 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180228010608.215505-4-sbeller@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/27/2018 8:06 PM, Stefan Beller wrote:
>   
> -void install_packed_git(struct packed_git *pack)
> +void install_packed_git(struct repository *r, struct packed_git *pack)

This is a good thing to do. I'm just making note that this will collide 
with the new instances of install_packed_git() that I added in the 
serialized git commit graph series, specifically when adding the 
--stdin-packs argument [1].

Thanks,
-Stolee

[1] 
https://public-inbox.org/git/CAGZ79kYM0fHiYQ2+k5__A2hY1PeCyigYf3n9ZBJSKH8yJZOF0A@mail.gmail.com/T/#u
