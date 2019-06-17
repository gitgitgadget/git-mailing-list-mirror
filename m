Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD8291F462
	for <e@80x24.org>; Mon, 17 Jun 2019 15:03:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728364AbfFQPDk (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Jun 2019 11:03:40 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46304 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbfFQPDk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jun 2019 11:03:40 -0400
Received: by mail-qt1-f194.google.com with SMTP id h21so11017451qtn.13
        for <git@vger.kernel.org>; Mon, 17 Jun 2019 08:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Fs/cK4csELC9D7io/TLZCjFAVArhGZYS3chEEF0FFzQ=;
        b=lJnfoRAqB2h6s/LnQOv9EnHJbdT90msbBgdkwSpUG/TcXy4QY2/h5mOIoleiJVlu6C
         7sltTkWGzKNjAAgh3SWXdUjKgi6kB4xKZAk/Q7nKDzvvcqx7fTX/VCrD5Qd5cijf1t0+
         zSo7Wg0HpL3mW8zzG0B2tTqJSn6SrBj+5VTD2WQ7G4q6GKJjevkdNBlft2DVmfp07VWP
         gU9e1EmULdPKSldQhS3kLNKw0KUgDbHcT1ZyBaD+byhZYd+Xxm6DudwGGpo8b6r0NzUb
         vClW6bIECrpDoS3ico723gHXczuVmjVN3VjuMPljrtsNijXf6UuaKevhk0g42qjs4Mo1
         CryA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Fs/cK4csELC9D7io/TLZCjFAVArhGZYS3chEEF0FFzQ=;
        b=j2rfP1muFPuyV36tMmvsUGoI3+m76Uwf/O/Zr1lAitt9KyHUF7YLHuRTqazXsyUnAI
         CKwj/5+jfndeNmxrpvNDfF0e4B6zwT0iOcE0N4Z3E40lCX0/oRoNDGrK6a+QZ8jLjoUf
         y7cxcsNe/ibuvQdBaBqBlnWjhdJ3gDu4vdOd/xOhf/AO4NZQ02cpfSRlHnuGWImfTNNb
         qqQ5DdHHfpxir/sDwab2tEarkZrplmxqh+CjVKhwwEEeq6ztGuYt6HMNVXktjMSiTBdi
         jWHUV45m8cbZxJOOXc94C2eJJOmRVdjQGSar1Z63Eb6Sue+L9jBdrB0A320RK9I3dyBg
         tLsA==
X-Gm-Message-State: APjAAAVQDDguNGaRmuuGjFr4iUAuDPi4Ld7CH6bNCsp4kBWAzZwZrsqe
        abuAKO782FQAbgtrf8tMUwbVJA==
X-Google-Smtp-Source: APXvYqw+nWWuHym6qlTkKbLO2uUV99xrdjGNelRJ+qfiQwiOaI14PTlzFte6XZVq9nPgMgGtbvz4oQ==
X-Received: by 2002:a0c:895b:: with SMTP id 27mr21518452qvq.94.1560783819011;
        Mon, 17 Jun 2019 08:03:39 -0700 (PDT)
Received: from [10.0.1.18] (50-199-225-241-static.hfc.comcastbusiness.net. [50.199.225.241])
        by smtp.gmail.com with ESMTPSA id z57sm8377922qta.62.2019.06.17.08.03.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2019 08:03:38 -0700 (PDT)
Subject: Re: [PATCH] t8014: avoid git command in upstream pipe
To:     michael@platin.gs, git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Stefan Beller <stefanbeller@gmail.com>,
        Jeff Smith <whydoubt@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        David Kastrup <dak@gnu.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
References: <20190613151756.GA31952@szeder.dev>
 <20190616204441.5400-1-michael@platin.gs>
From:   Barret Rhoden <brho@google.com>
Message-ID: <91d5a68d-6d63-5f1a-af9c-ba857a1f9daa@google.com>
Date:   Mon, 17 Jun 2019 11:03:37 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190616204441.5400-1-michael@platin.gs>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/16/19 4:44 PM, michael@platin.gs wrote:
> From: Michael Platings <michael@platin.gs>
> 
> Use an intermediate file between between git blame and sed to avoid
> git blame's exit code being hidden.

Thanks, Michael.  I'll squash this for the next version.

Barret


> 
> Signed-off-by: Michael Platings <michael@platin.gs>
> ---
>   t/t8014-blame-ignore-fuzzy.sh | 13 +++++++++----
>   1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/t/t8014-blame-ignore-fuzzy.sh b/t/t8014-blame-ignore-fuzzy.sh
> index 1ff59624e9..6f1a94caef 100755
> --- a/t/t8014-blame-ignore-fuzzy.sh
> +++ b/t/t8014-blame-ignore-fuzzy.sh
> @@ -332,7 +332,9 @@ test_expect_success setup '
>   for i in $(test_seq 2 $last_test); do
>   	eval title="\$title$i"
>   	test_expect_success "$title" \
> -	"git blame -M9 --ignore-rev $IGNOREME $i | sed -e \"$pick_author\" >actual && test_cmp expected$i actual"
> +	"git blame -M9 --ignore-rev $IGNOREME $i >output &&
> +	sed -e \"$pick_author\" output >actual &&
> +	test_cmp expected$i actual"
>   done
>   
>   # This invoked a null pointer dereference when the chunk callback was called
> @@ -357,7 +359,8 @@ test_expect_success 'Diff chunks with no suspects' '
>   
>   	test_write_lines 1 1 >expected &&
>   
> -	git blame --ignore-rev $REV_2 --ignore-rev $REV_3 file | sed -e "$pick_author" >actual &&
> +	git blame --ignore-rev $REV_2 --ignore-rev $REV_3 file >output &&
> +	sed -e "$pick_author" output >actual &&
>   
>   	test_cmp expected actual
>   	'
> @@ -387,7 +390,8 @@ test_expect_success 'position matching' '
>   
>   	test_write_lines 1 1 2 2 >expected &&
>   
> -	git blame --ignore-rev $REV_3 --ignore-rev $REV_4 file2 | sed -e "$pick_author" >actual &&
> +	git blame --ignore-rev $REV_3 --ignore-rev $REV_4 file2 >output &&
> +	sed -e "$pick_author" output >actual &&
>   
>   	test_cmp expected actual
>   	'
> @@ -424,7 +428,8 @@ test_expect_success 'preserve order' '
>   
>   	test_write_lines 1 2 3 >expected &&
>   
> -	git blame --ignore-rev $REV_4 --ignore-rev $REV_5 file3 | sed -e "$pick_author" >actual &&
> +	git blame --ignore-rev $REV_4 --ignore-rev $REV_5 file3 >output &&
> +	sed -e "$pick_author" output >actual &&
>   
>   	test_cmp expected actual
>   	'
> 

