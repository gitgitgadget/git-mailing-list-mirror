Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CC371F406
	for <e@80x24.org>; Tue, 15 May 2018 03:24:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752312AbeEODYy (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 May 2018 23:24:54 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:53065 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752249AbeEODYw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 May 2018 23:24:52 -0400
Received: by mail-wm0-f65.google.com with SMTP id w194-v6so16734772wmf.2
        for <git@vger.kernel.org>; Mon, 14 May 2018 20:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=hnxb9x71pxIRL3ecJ5BLA1EJI9KFpPIc/V+TODZzghs=;
        b=FSueG0rOttvz0dGOjbu+skIwtjoRaSLvzebOu2kGAsLtJ7AZbbo6iiiWvp2DB59YIF
         UkiuW34ya/wxNAQ0ZLjqlAH7LQrUF37UEQ8jcxECaiocvwJhmVpLAuLvb31yDf6Cp0xc
         I3cimtthR7tvIXYtk1hM/4gGmu2blR38FfWDy6K7apc3D9SeqhudNY7oUQi7mx9aJ4ok
         E4t83Y3qI2Wt0p+AhPIelp1rk0r6aADOYjB4GaoiRwQ9MNaRg6dwE96fzgIM/wC4td6U
         AKO0xLWGkT+x2fiDXegnfwYrUK1uC9g97robIrGqooOJvqqPk/ccsmfL4Y7lPiZ2aCYF
         lfwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=hnxb9x71pxIRL3ecJ5BLA1EJI9KFpPIc/V+TODZzghs=;
        b=biV+Vl6MNlYEW91tBQf05krFqHxed+wdU3IAA6icDcA0XRu0Mv2xo2NScDawNDqKeh
         RDS69oBAdc5uJmeUCsHjpd6iJYar1E3l0yINqu8cP+qR4ipW7ok+MoLXtjkUvR0pBZnc
         QSneVIW5xhUHexHEQQ+EAIqQpMZyOE6NM7yHrPpyFUPMXPf4cdPknT7oXPxagCTZL3qw
         C3eS89ALNI1tgThNKxiohNvePT+EOkns9nuCSUxdWD7EAGFkuNmevpweTZFKr4jlm4VY
         iOASwHX84Xkh9iChemwcV2GDBQ3E+hqQ59ls8Zg2vesv39RFyzAl8V6llZZLQohpPy+G
         MceA==
X-Gm-Message-State: ALKqPwcyE7JskQwDnmYHZDefl0z7jYwTDOU3IbmNC4RBGVfMP7CmzlOo
        jMmAaDZuakOCyc3gYDjIX+f7Gyuq
X-Google-Smtp-Source: AB8JxZr1o0vWZULBvpq4ICQUTEqynLg85Bcp4osgC5OBNVCJ+Lfn9Z4lbBqgTZq+y17ugfoa2t3N7A==
X-Received: by 2002:a1c:96c1:: with SMTP id y184-v6mr6481703wmd.156.1526354691273;
        Mon, 14 May 2018 20:24:51 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 141-v6sm11205044wmf.35.2018.05.14.20.24.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 May 2018 20:24:50 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Olga Telezhnaya <olyatelezhnaya@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH RFC] ref-filter: start using oid_object_info
References: <010201635e16d282-89bdd0cd-df10-4509-bad7-fd49fd80ff2b-000000@eu-west-1.amazonses.com>
Date:   Tue, 15 May 2018 12:24:50 +0900
In-Reply-To: <010201635e16d282-89bdd0cd-df10-4509-bad7-fd49fd80ff2b-000000@eu-west-1.amazonses.com>
        (Olga Telezhnaya's message of "Mon, 14 May 2018 09:59:04 +0000")
Message-ID: <xmqqd0xxa9dp.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Olga Telezhnaya <olyatelezhnaya@gmail.com> writes:

> Start using oid_object_info_extended(). So, if info from this function
> is enough, we do not need to get and parse whole object (as it was before).
> It's good for 3 reasons:
> 1. Some Git commands potentially will work faster.
> 2. It's much easier to add support for objectsize:disk and deltabase.
>    (I have plans to add this support further)
> 3. It's easier to move formatting from cat-file command to this logic
>    (It pretends to be unified formatting logic in the end)
>
> Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
> ---
>  ref-filter.c | 34 +++++++++++++++++++++++++++++++---
>  ref-filter.h | 21 +++++++++++++++++++++
>  2 files changed, 52 insertions(+), 3 deletions(-)
>...
> @@ -383,9 +400,9 @@ static struct {
>  	int (*parser)(const struct ref_format *format, struct used_atom *atom,
>  		      const char *arg, struct strbuf *err);
>  } valid_atom[] = {
> -	{ "refname" , FIELD_STR, refname_atom_parser },
> -	{ "objecttype" },
> -	{ "objectsize", FIELD_ULONG },
> +	{ "refname", FIELD_STR, refname_atom_parser },
> +	{ "objecttype", FIELD_STR, objecttype_atom_parser },
> +	{ "objectsize", FIELD_ULONG, objectsize_atom_parser },
>  	{ "objectname", FIELD_STR, objectname_atom_parser },
>  	{ "tree" },
>  	{ "parent" },

Hmph, so this patch does not teach us to interpolate any new %(field-type)
but changes the way %(objecttype) and %(objectsize) are computed.

> @@ -1536,6 +1553,13 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
>  			continue;
>  		} else if (!deref && grab_objectname(name, &ref->objectname, v, atom)) {
>  			continue;
> +		} else if (!deref && !strcmp(name, "objecttype")) {
> +			v->s = type_name(format_data.type);
> +			continue;
> +		} else if (!deref && !strcmp(name, "objectsize")) {
> +			v->value = format_data.size;
> +			v->s = xstrfmt("%lu", format_data.size);
> +			continue;
>  		} else if (!strcmp(name, "HEAD")) {
>  			if (atom->u.head && !strcmp(ref->refname, atom->u.head))
>  				v->s = "*";

Because this addition is made to the early "Fill in specials first"
loop of the populate_value() function, we may be able to satisfy
some requests early without calling get_object() which then calls
parse_object().

> @@ -2226,6 +2250,10 @@ int format_ref_array_item(struct ref_array_item *info,
>  {
>  	const char *cp, *sp, *ep;
>  	struct ref_formatting_state state = REF_FORMATTING_STATE_INIT;
> +	format_data.oid = info->objectname;
> +	if (format_data.use_data && oid_object_info_extended(&format_data.oid, &format_data.info,

Style: fold the line after " &&".

And this checks the .use_data field to see if these fields whose
value could be computed by a call to oid_object_info_extended()
without calling parse_object().  If there is one, we call it;
otherwise we don't.

So there are three possible cases:

 - The request does not ask for these fields that can be filled from
   "format_data" (by the way, that is a horrible name---all the data
   in this codepath is for formatting, and in that sense the
   variable is not named after its most significant trait, which is
   that it is to grab data needed for formatting via a call to
   a function in the object_info() family.  Perhaps object_info_data
   or oi_data for brevity).  We do not call object_info() and the
   performance characteristic of the code stays as before.

 - The request asks for these fields that are helped by
   "object-info" and no other fields.  We make a call to
   "object-info", instead of parse_object(), which hopefully is more
   efficient (we need to measure, if we are selling this as an
   optimization).

 - The request asks for both.  We end up calling object-info and
   also parse_object(), so presumably there is degradation of
   performance.

In the third case, after v->s and v->value are filled by the new
code that copies from format_data, grab_values() will again fill
objecttype/objectsize by overwriting v->s field.  Doesn't this cause
memory leaks?  type_name() returns a constant string that does not
leak, but your objectsize seems to use xstrfmt(), so...

I think it was OK before this patch as grab_common_values() was the
only place that did v->s = xstrfmt() for the field, but now the code
with this patch can do the same assignment from two places, we would
need to be a bit more careful about memory ownership?

