Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D367E1F404
	for <e@80x24.org>; Fri, 20 Apr 2018 12:13:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754691AbeDTMNg (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Apr 2018 08:13:36 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:32812 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754591AbeDTMNf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Apr 2018 08:13:35 -0400
Received: by mail-wr0-f196.google.com with SMTP id z73-v6so22449434wrb.0
        for <git@vger.kernel.org>; Fri, 20 Apr 2018 05:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=YKebbf6vHSm5GgLVdzjMnOcuCZQay6e97Mw1Wb4NynA=;
        b=e3+Ul1k5nbUF5ZORjx+19HL8PxgfIt3NcSmU/E10FtL7Cuu71cInt8eCFhJbIyKjxV
         pMMy8Unld/88Qlqvx+85rsNgEyp60bLufShX+NsC8TlU6J0iItqqPr8VmjynpcPDNdBP
         NCPHfKovJ2OT0wbkY6q0pX0oV2GWAnNihvHv6C4gBdbGQwNv/0JPQDmwDVLPQfEoBTwp
         /IVqdBnL7x1uHkPtwxnbmIoFGpPavWDbsnuULB2gADOMNvgl0IcA8Csnp2WmpNyYIwiG
         /eUMe2/4HG08DUJ9aX2w9/sG3Ef8ttoLEhXqDk67w6Kian/WbXnVW1CXR7ifZCIBY8w+
         9ilQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=YKebbf6vHSm5GgLVdzjMnOcuCZQay6e97Mw1Wb4NynA=;
        b=dBqA8JNNyitA6xYWhbgf/kJt+ZoKF781BFQdlBZScL9ez8lgKJl1dUwuktETCRzGWI
         aI2I8KJ6Y+UAoaMO7mFDP/U2Dm2sT2UiUgtVYJE/y4TAxQjAHuh3YARdyiWC8a2hxZ75
         vUV+ew0n2mNhuFffHpCk3K2wi943DAUwLq/pZvUPwMhBJb7aSjqJgRlrM2Xpei2pSEu+
         rIUbmGGWfHx/q95XW/7Hby95iiIpoWMONWpmIhpCaxCrb2RiiPbbtxz2E5IEZ6DlD1Kg
         8mSArV16Zl2EaMHuNwWYaYuGR+y7wXuVgtANLxlIIoM/h9JJTpO6NewwVqtyhy8VF4+x
         JSgA==
X-Gm-Message-State: ALQs6tBSUempsZLsNtMTBAhqg4z9W2FW2yJpw5Mghz0SxjpmYe7CmqIN
        Yi8WJtbXgErcntxbvtaoEy0=
X-Google-Smtp-Source: AIpwx48KcU+5j4FufbaBzD2C+3uTBiXKDPR14SWTUOEIVre8SFNRql3Js6uFH+giLi+cnNqKG51wXw==
X-Received: by 2002:adf:9f09:: with SMTP id l9-v6mr7437538wrf.185.1524226414293;
        Fri, 20 Apr 2018 05:13:34 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (egc153.neoplus.adsl.tpnet.pl. [83.21.66.153])
        by smtp.gmail.com with ESMTPSA id o20-v6sm6136919wro.7.2018.04.20.05.13.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Apr 2018 05:13:32 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [RFC PATCH 06/12] commit: force commit to parse from object database
References: <20180417181028.198397-1-dstolee@microsoft.com>
        <20180417181028.198397-7-dstolee@microsoft.com>
Date:   Fri, 20 Apr 2018 14:13:32 +0200
In-Reply-To: <20180417181028.198397-7-dstolee@microsoft.com> (Derrick Stolee's
        message of "Tue, 17 Apr 2018 18:10:41 +0000")
Message-ID: <86tvs6dqj7.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <dstolee@microsoft.com> writes:

> In anticipation of checking commit-graph file contents against the
> object database, create parse_commit_internal() to allow side-stepping
> the commit-graph file and parse directly from the object database.

Nitpick/Bikeshed painting: do we have any naming convention for such
functions (*_internal() here)?

>
> Due to the use of generation numbers, this method should not be called
> unless the intention is explicit in avoiding commits from the
> commit-graph file.

Looks good to me, except for some stray whitespace changes in the
patch.

>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  commit.c | 14 ++++++++++----
>  commit.h |  1 +
>  2 files changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/commit.c b/commit.c
> index 9ef6f699bd..07752d8503 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -392,7 +392,8 @@ int parse_commit_buffer(struct commit *item, const void *buffer, unsigned long s
>  	return 0;
>  }
>  
> -int parse_commit_gently(struct commit *item, int quiet_on_missing)
> +

Stray empty line, though I think it may improve readability of the code
by using two empty lines between separate functions.

But to be consistent with the rest of the file, there shouldn't be this
extra empty line.

> +int parse_commit_internal(struct commit *item, int quiet_on_missing, int use_commit_graph)
>  {
>  	enum object_type type;
>  	void *buffer;
> @@ -403,17 +404,17 @@ int parse_commit_gently(struct commit *item, int quiet_on_missing)
>  		return -1;
>  	if (item->object.parsed)
>  		return 0;
> -	if (parse_commit_in_graph(item))
> +	if (use_commit_graph && parse_commit_in_graph(item))
>  		return 0;

All right.

>  	buffer = read_sha1_file(item->object.oid.hash, &type, &size);
>  	if (!buffer)
>  		return quiet_on_missing ? -1 :
>  			error("Could not read %s",
> -			     oid_to_hex(&item->object.oid));
> +					oid_to_hex(&item->object.oid));

Stray whitespace change (looks like spaces to tabs conversion).

>  	if (type != OBJ_COMMIT) {
>  		free(buffer);
>  		return error("Object %s not a commit",
> -			     oid_to_hex(&item->object.oid));
> +				oid_to_hex(&item->object.oid));

Stray whitespace change (looks like spaces to tabs conversion).

>  	}
>  	ret = parse_commit_buffer(item, buffer, size, 0);
>  	if (save_commit_buffer && !ret) {
> @@ -424,6 +425,11 @@ int parse_commit_gently(struct commit *item, int quiet_on_missing)
>  	return ret;
>  }
>  
> +int parse_commit_gently(struct commit *item, int quiet_on_missing)
> +{
> +	return parse_commit_internal(item, quiet_on_missing, 1);
> +}

All right; if it is internal details of implementations, I don't mind
this slightly cryptic "1" as the value of last parameters.

> +
>  void parse_commit_or_die(struct commit *item)
>  {
>  	if (parse_commit(item))
> diff --git a/commit.h b/commit.h
> index b5afde1ae9..5fde74fcd7 100644
> --- a/commit.h
> +++ b/commit.h
> @@ -73,6 +73,7 @@ struct commit *lookup_commit_reference_by_name(const char *name);
>  struct commit *lookup_commit_or_die(const struct object_id *oid, const char *ref_name);
>  
>  int parse_commit_buffer(struct commit *item, const void *buffer, unsigned long size, int check_graph);
> +int parse_commit_internal(struct commit *item, int quiet_on_missing, int use_commit_graph);
>  int parse_commit_gently(struct commit *item, int quiet_on_missing);
>  static inline int parse_commit(struct commit *item)
>  {

All right.
