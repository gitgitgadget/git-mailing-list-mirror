Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6DCA20209
	for <e@80x24.org>; Thu, 25 May 2017 05:21:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S941918AbdEYFV3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 May 2017 01:21:29 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33891 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S941909AbdEYFV0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 May 2017 01:21:26 -0400
Received: by mail-pf0-f194.google.com with SMTP id w69so36798722pfk.1
        for <git@vger.kernel.org>; Wed, 24 May 2017 22:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=JtEefDqGdU0lNriS/BMAwysgSWAHeOTMJXcEWD2nQ+g=;
        b=OCtPgDrwHtF26IIykoUFL4+DcoNLzUF+2pQpnfodKq1mf4ed0FSbV9SS7mbFsGdo3j
         HiHPIuR7CyYrP5z0tEoA6/GezBYQyi4TB5LtomvF79uw7jANv1u1y6lC7WncnRa1ZOnC
         sUx9aOWnY4ipHMoK+BFdk9KIsm9/7Bf8ASqGbwrktAAUGPmVQU0eNiNdg7TVl8teNsLx
         kvspPsj/KL2T2Lde/tC7QDfd5RAwGS7hSbRcaZdeZLFlKLmCNBEsKDDsn1hqmi9dQep5
         3QeaVmn2rkaYyaWAkr3VLEbCUU/DcJTP7i7v0jnvR1jFl6asovjhTLgSzlSI43B1S1Ch
         9lyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=JtEefDqGdU0lNriS/BMAwysgSWAHeOTMJXcEWD2nQ+g=;
        b=PTMnZdrCB6OUVhXb3k0tQeSEakOupm1D4Xh8n6SOVJu9HQiSU+yJrGvrb/5hbgbLF5
         J4L3laVQtiFB9dy6fZkbzN+bVJzHSShxzlEWBqPYxFpZhCKQkOMaIkpLDUjZihCnUBYl
         3sUwCQuVfesd/w7chvgErwXgQh+AvmmZ50hhb38K/Mg2RXOQqbTSKb5AX20EHV2/bf99
         8l7D6TCWvUPOaawxSdVRHMQr5UrXfvcfWDzrgrC5erO8p2Dpr7n9PWKgSbvjNWRlddpj
         qlz7EatBvVkH/leXr/y9oGeQN8ecveVzsknuAbfSIuoKMyegP9n2WInVu2FbKjwN0VMv
         qDUA==
X-Gm-Message-State: AODbwcB41E45p/KLGKVqDz3fcj1npRrooABnZgAw/kx1QQj+wiJHL2l6
        xzyb8n9kN0Khww==
X-Received: by 10.84.218.7 with SMTP id q7mr47031168pli.80.1495689685624;
        Wed, 24 May 2017 22:21:25 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:bc81:1d63:7e7e:dfa1])
        by smtp.gmail.com with ESMTPSA id v9sm9926711pfa.43.2017.05.24.22.21.24
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 24 May 2017 22:21:25 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Smith <whydoubt@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH 23/29] blame: create entry prepend function
References: <20170524051537.29978-1-whydoubt@gmail.com>
        <20170524051537.29978-24-whydoubt@gmail.com>
Date:   Thu, 25 May 2017 14:21:24 +0900
In-Reply-To: <20170524051537.29978-24-whydoubt@gmail.com> (Jeff Smith's
        message of "Wed, 24 May 2017 00:15:31 -0500")
Message-ID: <xmqqo9uheckr.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Smith <whydoubt@gmail.com> writes:

> Create function that populates a blame_entry and prepends it to a list.
>
> Signed-off-by: Jeff Smith <whydoubt@gmail.com>
> ---
>  builtin/blame.c | 25 +++++++++++++++----------
>  1 file changed, 15 insertions(+), 10 deletions(-)
>
> diff --git a/builtin/blame.c b/builtin/blame.c
> index fd41551..29771b7 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -2643,6 +2643,20 @@ void setup_scoreboard(struct blame_scoreboard *sb, const char *path, struct blam
>  		*orig = o;
>  }
>  
> +struct blame_entry *blame_entry_prepend(struct blame_entry *head,
> +					long start, long end,
> +					struct blame_origin *o)
> +{
> +	struct blame_entry *new_head = xcalloc(1, sizeof(struct blame_entry));

We have a slight tendency to favour sizeof(*pointer_to_thing) over
sizeof(type_of_thing), which is why the original is written that
way.  The tendency is so slight that if this were a new code, I do
not think we mind it written either way, but a patch whose goal is
to move existing code around does not have a justification to change
between the two.

> +	new_head->lno = start;
> +	new_head->num_lines = end - start;
> +	new_head->suspect = o;
> +	new_head->s_lno = start;
> +	new_head->next = head;

On the other hand, naming the variables that receive start/end
anything but start/end was a stupidity in the original code (I can
badmouth the original because it is all my code ;-).  Thanks for
fixing the sloppy naming.

> +	blame_origin_incref(o);
> +	return new_head;
> +}
> +
>  int cmd_blame(int argc, const char **argv, const char *prefix)
>  {
>  	struct rev_info revs;
> @@ -2885,16 +2899,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
>  
>  	for (range_i = ranges.nr; range_i > 0; --range_i) {
>  		const struct range *r = &ranges.ranges[range_i - 1];
> -		long bottom = r->start;
> -		long top = r->end;
> -		struct blame_entry *next = ent;
> -		ent = xcalloc(1, sizeof(*ent));
> -		ent->lno = bottom;
> -		ent->num_lines = top - bottom;
> -		ent->suspect = o;
> -		ent->s_lno = bottom;
> -		ent->next = next;
> -		blame_origin_incref(o);
> +		ent = blame_entry_prepend(ent, r->start, r->end, o);
>  	}
>  
>  	o->suspects = ent;
