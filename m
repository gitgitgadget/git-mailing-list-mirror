Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 252AD1F516
	for <e@80x24.org>; Mon, 25 Jun 2018 19:57:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965154AbeFYT5F (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Jun 2018 15:57:05 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33604 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964980AbeFYT5E (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jun 2018 15:57:04 -0400
Received: by mail-wr0-f195.google.com with SMTP id k16-v6so14886339wro.0
        for <git@vger.kernel.org>; Mon, 25 Jun 2018 12:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=8nNd/o0HQ14Hq7kTYuDbsIi0yGcQVvBdRzdWRuG+8p8=;
        b=BddHm3onZaJ3AF5Ol7UEuIKH5twVH52w03U2qhUypneu0RV9ThyNFbhBNvGZ4pmUYH
         i7xXt4NxvdH3gikeiyAv/TuqH8wN5qCPOf8TtULzzhETLiySWMNVL7CkZMZAlIN+TnIj
         tppQXdfNRo9i1+yOsqheTuLaZGt4LILj1jlOBTCb6DHA74yp4Yf6hAsWpB3dPDa416wg
         EuPLGfLFQKs62FQMmGS5paORUyxaC1S6TgQpeCuZ72NVAM6diDYWCQ/VYEWV3sc4TZfk
         MkkuwIOvk475H9p8jLC8lsKoY5+TjIh+yVzvah7uLMoh3yEfphiAz9ZssU5/xjT/21iF
         6zAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=8nNd/o0HQ14Hq7kTYuDbsIi0yGcQVvBdRzdWRuG+8p8=;
        b=BUgpwmSq50lwKuy+JsBVkyM+YCJOWap7qWFw/E8cNco9+hCMo4RtafDXzXKfT0bR/p
         X/1FmaBeChlAPzHhe6PdCCysb/iTWEd2dey0r8M7rUpzs/WDAXkncgqsJVQWTeWUnGaH
         49rREcRYJzkk+QfBApnXESlAbx5ERMbpgUZOd6zuXb/+j1zkC5hOXy31pggWizRRBZ0A
         4sMOjU9hfeCbYBxcWqdfibVTFa159fL6ZOog55oDfBm7HY1Ch9eAAklhlqiZGoOx61dc
         +/Gpj3K5ZRfV2W7ZMyw/UXzZZuMddBpiIeaTAnHna8IDlgi+4oDqM5uw44mNdb2SRl6i
         Z3IA==
X-Gm-Message-State: APt69E0Seao9PVALP+7RjYmL4Z7ar8ZWOrczoiePe2hJkO4XYmRZro1u
        Eqei7TiD/oWVKjwWJUby4go=
X-Google-Smtp-Source: AAOMgpdPzvSFFrfsWwxWWJbEY/mAJLBzuUAQ/1CU72Cy9iK43WzPUpaYT6n9pnoQyjkU54W4MZ5LaQ==
X-Received: by 2002:adf:c44c:: with SMTP id a12-v6mr4322244wrg.20.1529956622515;
        Mon, 25 Jun 2018 12:57:02 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id h7-v6sm29104wmb.48.2018.06.25.12.57.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Jun 2018 12:57:01 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, sbeller@google.com, pclouds@gmail.com,
        avarab@gmail.com, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 08/24] packfile: generalize pack directory list
References: <20180607140338.32440-1-dstolee@microsoft.com>
        <20180625143434.89044-1-dstolee@microsoft.com>
        <20180625143434.89044-9-dstolee@microsoft.com>
Date:   Mon, 25 Jun 2018 12:57:01 -0700
In-Reply-To: <20180625143434.89044-9-dstolee@microsoft.com> (Derrick Stolee's
        message of "Mon, 25 Jun 2018 10:34:18 -0400")
Message-ID: <xmqq7emmod0y.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> +struct prepare_pack_data
> +{

ERROR: open brace '{' following struct go on the same line
#88: FILE: packfile.c:777:
+struct prepare_pack_data
+{

> +	struct repository *r;
> +	struct string_list *garbage;
> +	int local;
> +};
> +
> +static void prepare_pack(const char *full_name, size_t full_name_len, const char *file_name, void *_data)
> +{
> +	struct prepare_pack_data *data = (struct prepare_pack_data *)_data;
> +	struct packed_git *p;
> +	size_t base_len = full_name_len;
> +
> +	if (strip_suffix_mem(full_name, &base_len, ".idx")) {
> +		/* Don't reopen a pack we already have. */
> +		for (p = data->r->objects->packed_git; p; p = p->next) {
> +			size_t len;
> +			if (strip_suffix(p->pack_name, ".pack", &len) &&
> +			    len == base_len &&
> +			    !memcmp(p->pack_name, full_name, len))
> +				break;
> +		}
> +
> +		if (p == NULL &&
> +		    /*
> +		     * See if it really is a valid .idx file with
> +		     * corresponding .pack file that we can map.
> +		     */
> +		    (p = add_packed_git(full_name, full_name_len, data->local)) != NULL)
> +			install_packed_git(data->r, p);
> +	}

This is merely a moved code and the issue was inherited from the
original, but can we make it easier to read and at the same time
remove that assignment inside if() condition (which generally makes
the code harder to read)?  The most naïve

	if (!p) {
		p = add_packed_git(full_name, full_name_len, data->local);
		if (p)
			install_packed_git(data->r, p);
	}

isn't all that bad, but there may be even better ways.

> +	if (!report_garbage)
> +	       return;

This "return;" is indented with a run of SP not with HT?

