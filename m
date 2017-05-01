Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD65D1F78F
	for <e@80x24.org>; Mon,  1 May 2017 22:07:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751175AbdEAWH1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 May 2017 18:07:27 -0400
Received: from mail-pg0-f49.google.com ([74.125.83.49]:36112 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750798AbdEAWH0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2017 18:07:26 -0400
Received: by mail-pg0-f49.google.com with SMTP id t7so50573787pgt.3
        for <git@vger.kernel.org>; Mon, 01 May 2017 15:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=FqQhXkURWaLKmDm8DY4v0WNqYh+bqzXeyvJxuyBI3WA=;
        b=B7BAzDbQgDk4CvKI1EkJ4FLE2TlWzGif2Ipil2XYlYBFTiAjfiSKheH0igm7OiJV3L
         SfesGvvrVjXrH6lkmMZwQtgGj8G+rjBVYFjMUhqcZfRwq8seVYFx26iZjg6POyyAS0+h
         1rcjc2/6ksyi3Je9PVg11w0HqP6KGY1dbljSCfjczVRdD8Mxpy+88vAn7IPHocjXE4eb
         HnlVtoGNni4FFAMverFSD6TTLI2aDRwPkx2yna/hUPw3PnGXAO7qKdzyfOcxBrU3huCz
         9ldgfpu1BN0I8ZsVpaF15lgx1irbJa+2a2e030EKYPO3/GL/hWVhN3KeR0Jtp88dPJg5
         GDjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=FqQhXkURWaLKmDm8DY4v0WNqYh+bqzXeyvJxuyBI3WA=;
        b=QSlIqZ7PQE2PUN70yYG1eZj25R9UZ6ToY5bjD9D2in6wBuoi02RWieVYufPFw/rOkz
         erSyMP/b2eePWNdm63TvwK4zuMW/bnna7r1eK2mBh4pBo0RvyJRf9KYW275iJVZma1YJ
         dAypm9ghwKCikNiRNyMTk4zX5+w8ND7jUbImSOJB5HWsmw3/IPFGh5U6K/JxHMPFREAU
         6KhHgXh38JfCw7RdRj7Id5NbBSl2kPWBEHy6pgZ/bdaLj/832wLi8ySqxDo7uAB9OLvE
         u/bC2W0x5th5KPQBYUAgUDuRpiMzbWyPYW4TlMsLHBKuC3SIeYtfMlNC7RiYQWAuksKI
         ilgw==
X-Gm-Message-State: AN3rC/4Wzs95LZ4jU8l/fYQNS7yagnYC/QijfK8Uja9ZGn5xBvdrnofk
        Jg7mV2pl0B09k5MD
X-Received: by 10.98.69.213 with SMTP id n82mr28779544pfi.216.1493676445221;
        Mon, 01 May 2017 15:07:25 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([2620:0:100e:422:a910:d570:c34e:20d9])
        by smtp.gmail.com with ESMTPSA id q68sm610206pga.57.2017.05.01.15.07.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 May 2017 15:07:23 -0700 (PDT)
Subject: Re: [PATCH v2 11/53] fast-import: convert to struct object_id
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
References: <20170501022946.258735-1-sandals@crustytoothpaste.net>
 <20170501022946.258735-12-sandals@crustytoothpaste.net>
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
From:   Jonathan Tan <jonathantanmy@google.com>
Message-ID: <165f4108-267b-f522-d78d-36b0064ee48c@google.com>
Date:   Mon, 1 May 2017 15:07:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170501022946.258735-12-sandals@crustytoothpaste.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/30/2017 07:29 PM, brian m. carlson wrote:
> @@ -391,10 +391,8 @@ static void write_branch_report(FILE *rpt, struct branch *b)
>  	fputc('\n', rpt);
>
>  	fprintf(rpt, "  tip commit  : %s\n", oid_to_hex(&b->oid));
> -	fprintf(rpt, "  old tree    : %s\n",
> -		oid_to_hex(&b->branch_tree.versions[0].oid));
> -	fprintf(rpt, "  cur tree    : %s\n",
> -		oid_to_hex(&b->branch_tree.versions[1].oid));
> +	fprintf(rpt, "  old tree    : %s\n", oid_to_hex(&b->branch_tree.versions[0].oid));
> +	fprintf(rpt, "  cur tree    : %s\n", oid_to_hex(&b->branch_tree.versions[1].oid));
>  	fprintf(rpt, "  commit clock: %" PRIuMAX "\n", b->last_commit);
>
>  	fputs("  last pack   : ", rpt);

These look like unnecessary line rewrappings.

> @@ -2298,8 +2296,12 @@ static uintmax_t do_change_note_fanout(
>  static uintmax_t change_note_fanout(struct tree_entry *root,
>  		unsigned char fanout)
>  {
> -	char hex_sha1[40], path[60];
> -	return do_change_note_fanout(root, root, hex_sha1, 0, path, 0, fanout);
> +	/*
> +	 * The size of path is due to one slash between every two hex digits,
> +	 * plus the terminating NUL.
> +	 */
> +	char hex_oid[GIT_MAX_HEXSZ], path[GIT_MAX_HEXSZ * 3 / 2];

If your comment is correct, shouldn't the size of path be 61 (that is, 
add "+ 1")? I took a look at do_change_note_fanout() and your comment 
seems correct.

> +	return do_change_note_fanout(root, root, hex_oid, 0, path, 0, fanout);
>  }
>
>  /*

Other than these, patches 10 and 11 look fine.
