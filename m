Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 591321F516
	for <e@80x24.org>; Mon, 25 Jun 2018 18:20:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964888AbeFYSUM (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Jun 2018 14:20:12 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:40211 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964849AbeFYSUL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jun 2018 14:20:11 -0400
Received: by mail-pf0-f194.google.com with SMTP id z24-v6so6824791pfe.7
        for <git@vger.kernel.org>; Mon, 25 Jun 2018 11:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wVA67HCionYl+tfpYUHzbnJy8DPvO4AhLIJLT2YcoZ4=;
        b=KTjtc6fXOAyFRH9itTg34+Uld6jbMEg8abJSptjeH+KAftVRJMtrkByWn0XeTLUKdf
         SIgjAcc2zbthid0HyumRCxXDF3IJ+ZYGvQHCAuJfXLSX3ib1/KoRNPRSiSUXrSmRBdNY
         r+ApDoqMxmP1QlmEYOKhG+MYOxj0XZtdRWciwhWeskLBE6NC0pqkcOXugm0rbNtQ++5Y
         tZXkV20ypowT4/sspEXitX6X4QIfSjraiDxSYdOtadshx7p52lJczcYhQvQJgo/ThcoT
         g8b44ujyCNE6RAXakHrVcEks0gZcg5dtmePgsHeFCtjwXSstSbQnMnBH4z3zeJ0JJZM3
         fviQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wVA67HCionYl+tfpYUHzbnJy8DPvO4AhLIJLT2YcoZ4=;
        b=fmSK0wEGc1tvfb0LG7W9hHKEwVh/ukK/L2d6TCvKsPKAIxwX0mU/KqH+CBC2JT4ZVO
         sII6ftPCQ/H4SQotYFGaTVcYNrmhoGXpAqGOPYeUyt2u3NZkdrTaBITj6BYpF7NpzwYj
         E0anYSV6bxmNM3OP7pZgqkvQBL6HiNvORKpVJfWAdT9KVKGrTYthv8FSkOwtE5ujn2mc
         Z2kMTBe7G+wkjLFuB5V1Evxy0FpXW2g3B47WuWXKASF1s3t75X4MeB+T/rs856GxuiC2
         ktBFckw7+lnNeuAUf6YFbkFFSFchzMU5EllmK21v5xS75+uvva+9MXY/PjtgXjIMkYw5
         xeuw==
X-Gm-Message-State: APt69E0stfzdERQ/bvU7yUI2gKXO0gE/nprARQNQwwEFHqXRwHXDELXT
        vSsvNbwJEHNoQdt3mTYO0ku9zVkxA+U=
X-Google-Smtp-Source: ADUXVKIixZUM+6jg+n0taUHCPfanmJU8p2LchcTO9CdmdWk1mIVo0GzegJ10D6W3Cg71FWLES8FQOQ==
X-Received: by 2002:a65:6605:: with SMTP id w5-v6mr7734950pgv.316.1529950810875;
        Mon, 25 Jun 2018 11:20:10 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id n9-v6sm2632204pgu.77.2018.06.25.11.20.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Jun 2018 11:20:09 -0700 (PDT)
Date:   Mon, 25 Jun 2018 11:20:08 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, sbeller@google.com
Subject: Re: [PATCH v3 2/8] upload-pack: implement ref-in-want
Message-ID: <20180625182008.GC19910@google.com>
References: <20180620213235.10952-3-bmwill@google.com>
 <20180625180934.229573-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180625180934.229573-1-jonathantanmy@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/25, Jonathan Tan wrote:
> > +static int parse_want_ref(const char *line, struct string_list *wanted_refs)
> > +{
> > +	const char *arg;
> > +	if (skip_prefix(line, "want-ref ", &arg)) {
> > +		struct object_id oid;
> > +		struct string_list_item *item;
> > +		struct object *o;
> > +
> > +		if (read_ref(arg, &oid))
> > +			die("unknown ref %s", arg);
> 
> One more thing - if you're planning to "die" here, also write out an
> error to the user, just like in parse_want().

Oh good idea, I'll add an ERR pkt here

-- 
Brandon Williams
