Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A10CC1F406
	for <e@80x24.org>; Tue,  9 Jan 2018 18:27:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934837AbeAIS1i (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jan 2018 13:27:38 -0500
Received: from mail-pg0-f41.google.com ([74.125.83.41]:38450 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934832AbeAIS1h (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jan 2018 13:27:37 -0500
Received: by mail-pg0-f41.google.com with SMTP id t67so8537354pgc.5
        for <git@vger.kernel.org>; Tue, 09 Jan 2018 10:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=alIuVKkLSwa4mUpbe+85ukfs9Tg/ZWQds+KY0Q2RdvY=;
        b=oOYoSDDSpyP90ZeBApC99/V64tSHHLr9R2dyYWxfmNQeGYVUUklVoYVf0VMS6aPpi9
         +xj3V4QQv5WKHo4btW3hLlVewEbPi5t5+51ri/KzEn2YiMXudWYBOl8EmWi5Foqx0sYw
         R6YUTaYu8pkqQHnd6oVFaTNgBeQwB4c4kabR0NxNUMX2q0ljS5Hwvm6ucwydoSqhhRo3
         yIvyiEEDg8xP2BCjgD285EneP/cbXL1iszB2IJhLHmTiN23g2Zfq4hsJMpUf051dkJHI
         pZ5tIWVnoGuIxNKI2c2QLDgXEu1k0Ls1uMNWKNT/O0Z8ZqKqH3wN94wnj+kPSsZRavtm
         P1Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=alIuVKkLSwa4mUpbe+85ukfs9Tg/ZWQds+KY0Q2RdvY=;
        b=pszxSKJ4aHHyuJpE2pVtsEVaHfIggjyTDu3K3yxkJ2r2rJgq+ZImuq9LQ4i5z485/W
         tJ6rcmoeqNCD6ZTBSDW4hdw2T9F4rseQCs7G7IcbqyfSsPAfoINOGwMQsP9g6kaO1FrA
         7ryc5vrqlfKaGghhXP1qhUrAyCVytKTUKMBvBidHFLmlQKGzUzQxvya7Zwyr9uB4gKyX
         oLhe7XAGuj45/y7ObQc0JWzQdvkYz/ebHxTIrjdvVOk2RVrMZVXgXCSdRLEGF4dC6OD/
         KYyP8FIEFBXktQcICNMFkWF535Ibp6zfoCyDw5i5LCESwT3bNGPKUeoOpv+/ErzuGquf
         DL2Q==
X-Gm-Message-State: AKGB3mLH6s5IgVhSFPNmFpkmwRbwD6DJaYfdCUyHYdxOEhU44vMtmHcQ
        +aRW25VHWksbNeMDqyutrPu8dQ==
X-Google-Smtp-Source: ACJfBosFGKQ7oBi1+Sf+cU4CGEh7uJd3qVNKjJ3blGcER6KsLXApENRt5g/7whV7JHG1I5AazPtRJw==
X-Received: by 10.101.68.78 with SMTP id e14mr12765193pgq.76.1515522456861;
        Tue, 09 Jan 2018 10:27:36 -0800 (PST)
Received: from twelve3.mtv.corp.google.com ([2620:0:100e:422:592e:240e:24e2:56aa])
        by smtp.gmail.com with ESMTPSA id v88sm36307834pfk.31.2018.01.09.10.27.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jan 2018 10:27:36 -0800 (PST)
Date:   Tue, 9 Jan 2018 10:27:35 -0800
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, gitster@pobox.com,
        peff@peff.net, philipoakley@iee.org, stolee@gmail.com,
        jrnieder@gmail.com
Subject: Re: [PATCH 07/26] connect: convert get_remote_heads to use struct
 packet_reader
Message-Id: <20180109102735.a6d3330325aef428fde87700@google.com>
In-Reply-To: <20180103001828.205012-8-bmwill@google.com>
References: <20180103001828.205012-1-bmwill@google.com>
        <20180103001828.205012-8-bmwill@google.com>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue,  2 Jan 2018 16:18:09 -0800
Brandon Williams <bmwill@google.com> wrote:

> -	while ((len = read_remote_ref(in, &src_buf, &src_len, &responded))) {
> +	while (state != EXPECTING_DONE) {
> +		switch (packet_reader_read(&reader)) {
> +		case PACKET_READ_EOF:
> +			die_initial_contact(1);
> +		case PACKET_READ_NORMAL:
> +			len = reader.pktlen;
> +			if (len > 4 && skip_prefix(packet_buffer, "ERR ", &arg))

This should be a field in reader, not the global packet_buffer, I think.

Also, I did a search of usages of packet_buffer, and there are just a
few of them - it might be worthwhile to eliminate it, and have each
component using it allocate its own buffer. But this can be done in a
separate patch set.

> @@ -269,6 +284,8 @@ struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
>  			if (process_shallow(len, shallow_points))
>  				break;
>  			die("protocol error: unexpected '%s'", packet_buffer);

Here too.
