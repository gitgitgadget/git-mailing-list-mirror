Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE1211F404
	for <e@80x24.org>; Thu, 15 Feb 2018 18:23:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163425AbeBOSXS (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Feb 2018 13:23:18 -0500
Received: from mail-qt0-f180.google.com ([209.85.216.180]:46773 "EHLO
        mail-qt0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1163391AbeBOSXO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Feb 2018 13:23:14 -0500
Received: by mail-qt0-f180.google.com with SMTP id u6so746733qtg.13
        for <git@vger.kernel.org>; Thu, 15 Feb 2018 10:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=ae5XmoC1ElXSKBmUt2F9D5Sm2YsYVgifFwJXSOTUXWk=;
        b=ZZ/47PMfTSARG3K5ItS8s2xqo2ZZUimKJCbjeF1n3QpEXp+2UrwqOuEfaFgw3jxjXF
         KTMN5zftq+gIr+hbLWguOGwFOehk5hxNNr+INwiXm1nI0nFxdb3yGHHC9pt2gTEH8VME
         9ahPKPoCIEnwJ9/cW90+qEQUq8YYt5L2hIjMlMOzPIvBvMpOK7FntVfEQUnAH5jLSEKs
         +nJZ80nE+Lj9xTNWGm0X3jDWHBNnQoCp4qSv5ROQuWnDOEgCRma5AfFev7eKnUs2fAwj
         tetLmRiaEWfro2TcyPpiZzPBvr3agzPCdYZIYgfqFTHEY34fGI62E12BW5ZXVLYRMJv4
         KyXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ae5XmoC1ElXSKBmUt2F9D5Sm2YsYVgifFwJXSOTUXWk=;
        b=to4XRzEm34KCVEFDrhxLNkrlFAAIMkhx7VwSSrmLkgRV+KG0MohdRE57TO6okmO91F
         yRuN+9a3jb5c5XCMiWtgALClQZkU4U5fnzhTi8yrUNSXncWyEGSrLQtTaaJ6YGQHoXae
         RlSHAFLKxZVXWv2M4/jCaFRjXdkJzcU+vidgdP1Tk5QXHQjt0mFNx5iL+EWhk2nAHe0+
         Mc3KQ+kh4A1MA8JCxCca3hkLCAuH4D20RAxnthC566ekRZ/oXf6o6KJvKpHq/sRA3ig3
         xxHhEVVDGivXdkROYCdu090gdbKsvt1NmKZT59QKmB2gRNn1yvAhS+S7yTL4JLQkDvZn
         BQUQ==
X-Gm-Message-State: APf1xPB4FeyFLnOi7xj//60UL/6FQVCVyxdSZ8X2uTWcH8UfuLnvogZm
        c6deG0txA7GapaIkhqeFnK0=
X-Google-Smtp-Source: AH8x225vTEX95XYA/924XLLDsjeygqIn0qw7Hy4QfvWP3XaLf3rCVMfHn7w5vFYtXgsIAsne4GP11g==
X-Received: by 10.200.13.71 with SMTP id r7mr5742555qti.55.1518718993811;
        Thu, 15 Feb 2018 10:23:13 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:55f7:85dc:e24b:e410? ([2001:4898:8010:0:3f2d:85dc:e24b:e410])
        by smtp.gmail.com with ESMTPSA id j22sm10517272qkk.64.2018.02.15.10.23.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Feb 2018 10:23:13 -0800 (PST)
Subject: Re: [PATCH v3 04/14] commit-graph: implement write_commit_graph()
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, git@jeffhostetler.com,
        peff@peff.net, jonathantanmy@google.com, sbeller@google.com,
        szeder.dev@gmail.com
References: <1517348383-112294-1-git-send-email-dstolee@microsoft.com>
 <1518122258-157281-1-git-send-email-dstolee@microsoft.com>
 <1518122258-157281-5-git-send-email-dstolee@microsoft.com>
 <xmqqinay9kv4.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <91e19f5b-ac4b-5843-b3b0-8eba37aaee68@gmail.com>
Date:   Thu, 15 Feb 2018 13:23:12 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <xmqqinay9kv4.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/15/2018 1:19 PM, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
>
>> +struct packed_oid_list {
>> +	struct object_id **list;
>> +	int nr;
>> +	int alloc;
>> +};
> What is the typical access pattern for this data structure?  If it
> is pretty much "allocate and grow as we find more", then a dynamic
> array of struct (rather than a dynamic array of pointers to struct)
> would be a lot more appropriate.  IOW
>
> 	struct packed_oid_list {
> 		struct object_id *list;
> 		int nr, alloc;
> 	};
>
> The version in the posted patch has to pay malloc overhead plus an
> extra pointer for each object id in the list; unless you often
> replace elements in the list randomly and/or you borrow object ID
> field in other existing data structure whose lifetime is longer than
> this list by pointing at it, I do not see how the extra indirection
> is worth it.
>

The pattern used in write_commit_graph() is to append OIDs to the list 
as we discover them and then sort in lexicographic order. The sort then 
only swaps pointers.

I can switch this to sort the 'struct object_id' elements themselves, if 
that is a better pattern.

Thanks,
-Stolee
