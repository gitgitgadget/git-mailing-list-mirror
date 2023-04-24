Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A7A8C7618E
	for <git@archiver.kernel.org>; Mon, 24 Apr 2023 15:22:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231608AbjDXPWB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Apr 2023 11:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjDXPWA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2023 11:22:00 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EFB42D53
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 08:21:59 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-b992ed878ebso13182306276.0
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 08:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1682349718; x=1684941718;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L0awrcUJvZcwqBltP5hLfXWfyZKEITTGQqFASB5RvWM=;
        b=C+OgOnvHaXcRisJ4Uv0FSMnF6zfvVehK2dvEX/ZxmMxUPbExvOYoXhcVuyDiR+ofSG
         +AeC+rZCcZhLARZ5Ko1f98GdFDVXyUlToj36CSh47648nwscUEocnv/q2rbU29pRimCr
         zmIWkO7E7ESNSvNi3nSWu0D4u1uyYlap16c2ccONBiURyJYC6qRhANxb5ut2gM5L0i4i
         tG1nujnovfvu2svY1qGA9ZdS4z2B8rGl/WbPaf9t4QDb7kx6CLzpqLRgUj5nTvWjXxtW
         cXUWltmwLHy1pgCTRzp7SQkZwycMn1MaEO/wSMlpJ4HAaIqflhvpnqIsiBFdkvkGNCjH
         xNWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682349718; x=1684941718;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L0awrcUJvZcwqBltP5hLfXWfyZKEITTGQqFASB5RvWM=;
        b=G0RbXfI7D2YJwp3xOoxDiWFQ147IAmqfG2zIPgc9s3tvxkYybtJVFCRh650XiyzTwB
         x1u9JRSjK/S+Tt7T2y0BhhsqA9HMHM597R3LdIxfQXSXcfq5o7P/lxYnT+0pgvtvDId6
         DbHsFEwgnv3VWcC3yEw2qB1NhkJj4N4XzyElA1dk4JFCY5T5ClajNKljt8zWQQUbvZRq
         SQHdTkOQD3iCZdhopHeKHsk+haA+Rh5qrqw9emDMZqHOxbEtA9/pTIAeP0wHgZ918Mhq
         Gxiqam/y/W9eEQdMq1a69VzPJl0sI6KpSA/eBbPDSrD4SySFAmHYJltckdQP7KcPKGoO
         U5xA==
X-Gm-Message-State: AAQBX9cb7rnN8paWcXpFlnMA1cxVvWoL8WkRpMd/iIEBY1e04XD4MlHU
        iHrBkcogYmWs/22umAj0oLE2
X-Google-Smtp-Source: AKy350bghpbeZBc9sVBBQJWCIVxw7OaaKmowG30dUR332Pquc6kdAnGgTsdvDK1rsHXmoIJSJ+/YxA==
X-Received: by 2002:a81:700c:0:b0:54b:f8b4:bc8d with SMTP id l12-20020a81700c000000b0054bf8b4bc8dmr8076250ywc.0.1682349718555;
        Mon, 24 Apr 2023 08:21:58 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:4c:5bca:4632:1d72? ([2600:1700:e72:80a0:4c:5bca:4632:1d72])
        by smtp.gmail.com with ESMTPSA id r67-20020a818146000000b0054eff15530asm3020149ywf.90.2023.04.24.08.21.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Apr 2023 08:21:57 -0700 (PDT)
Message-ID: <d2825134-61db-9da4-450c-f027117b3d48@github.com>
Date:   Mon, 24 Apr 2023 11:21:56 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] Fix memory leak in get_reachable_subset
Content-Language: en-US
To:     Mike Hommey <mh@glandium.org>, git@vger.kernel.org
Cc:     gitster@pobox.com
References: <20230421234409.1925489-1-mh@glandium.org>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <20230421234409.1925489-1-mh@glandium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/21/2023 7:44 PM, Mike Hommey wrote:
> @@ -944,6 +944,8 @@ struct commit_list *get_reachable_subset(struct commit **from, int nr_from,
>  		}
>  	}
>  
> +	clear_prio_queue(&queue);
> +

Thanks. This is a leak that has existed since the method was first
created in fcb2c0769db (commit-reach: implement get_reachable_subset,
2018-11-02). I appreciate the attention to detail.

-Stolee
