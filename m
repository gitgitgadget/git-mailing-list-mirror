Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C42C1F78F
	for <e@80x24.org>; Mon,  1 May 2017 21:55:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752669AbdEAVyq (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 May 2017 17:54:46 -0400
Received: from mail-pg0-f48.google.com ([74.125.83.48]:33924 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752680AbdEAVym (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2017 17:54:42 -0400
Received: by mail-pg0-f48.google.com with SMTP id v1so50530140pgv.1
        for <git@vger.kernel.org>; Mon, 01 May 2017 14:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=uV5vNkYy1XuJzRDfc9xhwJJKGo5qAa0jmnbt+msuefg=;
        b=rtv3XM58h22iE96gi8Y/BsHKVmfozTabFbQ9ujtxLUJP/SkAkr3sh3bRpkjT7MVSVL
         F4fCQA9KWhBbn4nK5DGfP8p1VJ1oM2Xm5e0SC2jXKvVdSv3ub8aDj4EuMi5wV1GQDz1r
         5fnVjGOmo1expMrlcYwxBSbrag7G9Y01kKU9lhUvH56h07TXur0FpkQZKZMMtgBjgXUx
         MGWKStHDEkCaO1MHjQX8JwPj+WqRDJP+Po1MfnJzjBz8menK8bsZIoR6+NG8R0intThp
         F9RygngpVry/a4NfODZ6eBEA0Sayz7iVZOrcXpZ5pCUg3cjNgSAz0alHIUY1YHymbyaF
         8IiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=uV5vNkYy1XuJzRDfc9xhwJJKGo5qAa0jmnbt+msuefg=;
        b=TsdRWhWjpskEcAjzvFtE2E33FPVSIV/vTWEg4MPYy5sveFlc1Iva3JESB5qtWw12m8
         XFuPhAPG15AydZHOYGVQXkh63K2vXAsQxFz/3fA5aWKBYCrvEuLa+Vv/OozxjR2V3Plt
         FvSj2qe05QpibOG7l3ekN4K54MbkAzxP/UwaZKEE0OYvFspqvTDOkNSwc88z8GDr11ay
         tOPwo12skOfti4+jsxVX98YzVTpQ6gVfs68LUoQKWS2T+v0Eg+PegVCEMfANjzvwkF9U
         wH5pwzW/gr3SsB67uSQztYW0jqcQNTgQyma9RwGBOMcGxTIXX5UmrkXW7GqQNGbZZpju
         xM1Q==
X-Gm-Message-State: AN3rC/7a3qyMW/1cXHhxPjXcLh0jhLpqThm3gyRPCh4KoX5eNYwFQS3y
        BNPh1O48FjHOtIqyMLIIrQ==
X-Received: by 10.99.56.90 with SMTP id h26mr28960627pgn.43.1493675666420;
        Mon, 01 May 2017 14:54:26 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([2620:0:100e:422:a910:d570:c34e:20d9])
        by smtp.gmail.com with ESMTPSA id y5sm33895712pge.19.2017.05.01.14.54.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 May 2017 14:54:24 -0700 (PDT)
Subject: Re: [PATCH v2 09/53] builtin/rev-parse: convert to struct object_id
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
References: <20170501022946.258735-1-sandals@crustytoothpaste.net>
 <20170501022946.258735-10-sandals@crustytoothpaste.net>
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
From:   Jonathan Tan <jonathantanmy@google.com>
Message-ID: <ee83bfa4-ac6d-9ad7-5783-02f42e95dc82@google.com>
Date:   Mon, 1 May 2017 14:54:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170501022946.258735-10-sandals@crustytoothpaste.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/30/2017 07:29 PM, brian m. carlson wrote:
> @@ -340,7 +340,7 @@ static int try_parent_shorthands(const char *arg)
>  	}
>
>  	if (include_rev)
> -		show_rev(NORMAL, sha1, arg);
> +		show_rev(NORMAL, &oid, arg);
>  	for (parents = commit->parents, parent_number = 1;
>  	     parents;
>  	     parents = parents->next, parent_number++) {
> @@ -352,7 +352,7 @@ static int try_parent_shorthands(const char *arg)
>  		if (symbolic)
>  			name = xstrfmt("%s^%d", arg, parent_number);
>  		show_rev(include_parents ? NORMAL : REVERSED,
> -			 parents->item->object.oid.hash, name);
> +			& parents->item->object.oid, name);

No space after ampersand.

Up to (and including) this patch, looks good. I didn't notice any 
changes other than introductions of parse_oid_hex() and mechanical changes.
