Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D0AB1F803
	for <e@80x24.org>; Tue,  8 Jan 2019 02:00:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727295AbfAHCAi (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Jan 2019 21:00:38 -0500
Received: from mail-pf1-f202.google.com ([209.85.210.202]:42120 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727145AbfAHCAh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jan 2019 21:00:37 -0500
Received: by mail-pf1-f202.google.com with SMTP id y88so1592011pfi.9
        for <git@vger.kernel.org>; Mon, 07 Jan 2019 18:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ByQPYG9hQ8Zc164eUHl0JgJfR34Ha6153GXy0Ody6Ms=;
        b=qy5MKjb0lqDmsLR21T/4EDDuT/Ka7Hk/nwZOhIVaBuqMw2PLSkX2oIZb/BqNqCtbAl
         JpAgjFTfwaeSkc5f0jcRv7AZ97O05G8C5wGtsu2MJ1pdQ/ZLA/AqK9SUGH7ynn9N0pOn
         EP4gWTVwzef/t8cFbYbTc641keBkA7tUnztBMneUi2PUmIcagbMj5qZojBqYaTusUeQU
         zEHTlfJNW9Hwc4OtmUcVd4AF3+4FNlwxYF7IU55FSMbef3jylUqP1VW8SIaP50P3QZ/o
         khBK7DFNsc+/CCLI4b2ytL+NGKnFotJ9UWP56qq7qLdHlaIk+/yaFSt6An1w1KoiDzcm
         X5eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ByQPYG9hQ8Zc164eUHl0JgJfR34Ha6153GXy0Ody6Ms=;
        b=McpEmoO3k2pc0aGkNLS6+gZ/wC3unzhmqva+1srCwJl1X3rsA/fTFnL4M7DSbJYG/a
         HOOpVyMMHflOvS7lhJrnsQG4CAS/lkxllW2yjfknFf7188apLYCieKr1mzCqqvDtyxp0
         S41S3SLjfsJ17e+DwoBcLNZBcfz5Cg2Lvp2jSyjc8Qx79YqhcEdFMlmtW+HxkN6iC1r0
         36vJMRRRzVxPe7WaLWrlpeoi87SyqyL2l0jz9m8sW9yN8Ym9YzZacxGI9GqYAdAwbW6i
         ejC47lf0ORIslEaf3uJASnjOejWXS3kSoKYfSU+WeIjo00LUseLxaf83tiZHr5ZShyuH
         BkZw==
X-Gm-Message-State: AJcUukd55PKRwMQR47QVMQlw5evnfYJe+sqHKHi41JV/2r+QU22CrPz/
        sPUV0hBAM59m12ox1TQDFfIxJquzG/1kVciDfrpQ
X-Google-Smtp-Source: ALg8bN7rKoCy5Exz/FWKb76F4Fs/sS7fIigT6xv+H2ryXdxels/MVM5TrzJHF+p96s83b0wQ8/PA1OHIvutOpH6uAZRI
X-Received: by 2002:a17:902:6684:: with SMTP id e4mr2643739plk.96.1546912837309;
 Mon, 07 Jan 2019 18:00:37 -0800 (PST)
Date:   Mon,  7 Jan 2019 18:00:34 -0800
In-Reply-To: <20181210234030.176178-3-matvore@google.com>
Message-Id: <20190108020034.23648-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20181210234030.176178-3-matvore@google.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: Re: [PATCH v2 2/2] tree:<depth>: skip some trees even when collecting omits
From:   Jonathan Tan <jonathantanmy@google.com>
To:     matvore@google.com
Cc:     git@vger.kernel.org, sbeller@google.com, git@jeffhostetler.com,
        jeffhost@microsoft.com, peff@peff.net, stefanbeller@gmail.com,
        jonathantanmy@google.com, pclouds@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> -static void filter_trees_update_omits(
> +static int filter_trees_update_omits(
>  	struct object *obj,
>  	struct filter_trees_depth_data *filter_data,
>  	int include_it)
>  {
>  	if (!filter_data->omits)
> -		return;
> +		return 1;
>  
>  	if (include_it)
> -		oidset_remove(filter_data->omits, &obj->oid);
> +		return oidset_remove(filter_data->omits, &obj->oid);
>  	else
> -		oidset_insert(filter_data->omits, &obj->oid);
> +		return oidset_insert(filter_data->omits, &obj->oid);
>  }

I think this function is getting too magical - if filter_data->omits is
not set, we pretend that we have omitted the tree, because we want the
same behavior when not needing omits and when the tree is omitted. Could
this be done another way?
