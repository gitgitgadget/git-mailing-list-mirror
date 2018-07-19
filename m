Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5D111F597
	for <e@80x24.org>; Thu, 19 Jul 2018 19:26:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732025AbeGSUKU (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jul 2018 16:10:20 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34053 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731774AbeGSUKU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jul 2018 16:10:20 -0400
Received: by mail-wr1-f67.google.com with SMTP id c13-v6so9138634wrt.1
        for <git@vger.kernel.org>; Thu, 19 Jul 2018 12:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=irMqo8ncC4/caNSHTrtD1QKDANXdoLYEP3tV9bUAbG8=;
        b=D38Uch98HqBofuG0WfbpxsgqaHHdwJ3IMqOVMbDvxiwApz7+iXvkSe/fqtbuHebuqe
         BJv2Q76bmGOSgcQU0kb5ZrGoUOJ0WBUoZzvBBy4zQv45ORvzqoQUVudou5pClTWFkLyu
         a3ee/suNePjzjTnP2/f2v0Q0o4021iQcBgkayY5Ae0+9J/8izRdC9qmhnAunWR/+1wtW
         nguLnSHVjOUfSakkFEFqebSrZX8C49Fqb4aPvGlQdYbgKZsCEPSn9DZUJBpojCDYVxzw
         JbgE3GiQlEU2hjir+9FLMIbvK8jBlXDDCB2n636sZOKeYNMhkoqniSVUK/VeTv2f2Hv3
         E8ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=irMqo8ncC4/caNSHTrtD1QKDANXdoLYEP3tV9bUAbG8=;
        b=nuWfTsrucZOqkBnIomMDsBbmepXXBb3cmJM1D6VP095cMwatVe0wYGHBMDkXoEmRSh
         65xryPceifY5f4WdmgBso7UsUVXhQm1CcjdtNe6wUDLgpKNusP/HpeiByZz5TEsIVB4k
         FnYElkmEDJjQF0EbPU+n71RnLF2apoz8r2VkbL7xeE0bE6usnyqlhVb1Sfv+8XMlCquK
         YauMNgcv0m96YC/dPXyNkzD8kY4hsOs9w2CdGcV+QB4XhZFuBmheI/gL3L39rBZrApUh
         eQrdNr/94bvfL0z6DY4jBWpRaPDNtfiGlTPc/msNGRLpPvhid4YH+EQ8Yweuyx3kC7uH
         LWKg==
X-Gm-Message-State: AOUpUlGL7ClvcoN3esBfNYMx5nyL9XnzGZWSDdqCoMM6HA3MXQdOO534
        v0nJ5Wb/g71PuliFceZmT8NZpSRx
X-Google-Smtp-Source: AAOMgpc7fMzhaSUp2+YbAXv8iTw2z0Ajv34BBHXTLyX/vS2uE6BWve65c733Szc+67qsiEG3UBu3MA==
X-Received: by 2002:adf:d142:: with SMTP id b2-v6mr8275454wri.17.1532028346081;
        Thu, 19 Jul 2018 12:25:46 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id a9-v6sm6448813wrp.55.2018.07.19.12.25.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Jul 2018 12:25:45 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Subject: Re: 2.18.0 Regression: packing performance and effectiveness
References: <20180718225110.17639-1-newren@gmail.com>
        <20180719054424.GB23884@sigill.intra.peff.net>
        <CACsJy8BNGboUb0F5NRR9tKj_P24j2ZgB48SCuLEphSHQAU2EUA@mail.gmail.com>
        <20180719151640.GA24997@duynguyen.home>
Date:   Thu, 19 Jul 2018 12:25:44 -0700
In-Reply-To: <20180719151640.GA24997@duynguyen.home> (Duy Nguyen's message of
        "Thu, 19 Jul 2018 17:16:42 +0200")
Message-ID: <xmqqlga7do3r.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> @@ -330,20 +330,27 @@ static inline void oe_set_size(struct packing_data *pack,
>  static inline unsigned long oe_delta_size(struct packing_data *pack,
>  					  const struct object_entry *e)
>  {
> -	if (e->delta_size_valid)
> +	if (!pack->delta_size)
>  		return e->delta_size_;
> -	return oe_size(pack, e);
> +	return pack->delta_size[e - pack->objects];
>  }
>  
> +void oe_prepare_delta_size_array(struct packing_data *pack);
>  static inline void oe_set_delta_size(struct packing_data *pack,
>  				     struct object_entry *e,
>  				     unsigned long size)
>  {
>  	e->delta_size_ = size;
> -	e->delta_size_valid = e->delta_size_ == size;
> -	if (!e->delta_size_valid && size != oe_size(pack, e))
> -		BUG("this can only happen in check_object() "
> -		    "where delta size is the same as entry size");
> +	if (!pack->delta_size && e->delta_size_ == size)
> +		return;
> +	/*
> +	 * We have had at least one delta size exceeding OE_DELTA_SIZE_BITS
> +	 * limit. delta_size_ will not be used anymore. All delta sizes are now
> +	 * from the delta_size[] array.
> +	 */
> +	if (!pack->delta_size)
> +		oe_prepare_delta_size_array(pack);
> +	pack->delta_size[e - pack->objects] = size;
>  }

Imagine that you create a delta and set its size (which happens to
fit in the entry) and then create another whose size does not fit in
the entry.  How does oe_delta_size() know not to look at
pack->delta_size[] and instead look at e->delta_size_ when it wants
to know the delta for the first one?  IOW, shouldn't there be a
"backfill" procedure when oe_set_delta_size() notices that we now
switch to pack->delta_size[] array?

