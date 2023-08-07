Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4315FC001DB
	for <git@archiver.kernel.org>; Mon,  7 Aug 2023 22:39:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjHGWjf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Aug 2023 18:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjHGWjd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2023 18:39:33 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F947100
        for <git@vger.kernel.org>; Mon,  7 Aug 2023 15:39:31 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-583a89cccf6so46876937b3.1
        for <git@vger.kernel.org>; Mon, 07 Aug 2023 15:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691447970; x=1692052770;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3DuceRjdSEdbMp6ggj5mboyou/rlu/H4NAR6skBR5nU=;
        b=s/jC9Qn9A/UYXsXXwqrZh8hD4TDTCdeUMMW9w7cHS1SqIdQf7KA/Tc1KJCo9aDHCjI
         VAk0KqegObeMJ2yhccQDX6ZYrjrvZqqCqY2K5p+DkOmU00QQn25CwYFzuS0cAl75IbkG
         VdpO/bNNU27ZtaTtkHot+pb0bREwXnbI+03Xmuh5cqySE/FPNWn46SFAvt8xua1edjLi
         vdSe3bk4TnLM8GEJKxLGbTMoE2HNdsWdYT8BSODb1p6dU7Oru2RDofm4vLmanupLZywX
         +MkVUYEO7VEuR20OFL4gIz7glz9bOrosaQCrXVbmX/D98iZULtVU0qn3xP6FvcS74v8Q
         vp1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691447970; x=1692052770;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3DuceRjdSEdbMp6ggj5mboyou/rlu/H4NAR6skBR5nU=;
        b=LUTxjOR4yCadUKhCRek4t3CqE6C6fM0yrs2tvg0F2W+mo1KGi9p5Otm0ecU5AIVm6W
         jL/m09eBT2QC5xIhpCOSSPvJTGOWT2v75eblvfPuIosxT/pU/R/pVgXM69iFyVldEp4o
         jjrN9v221WmOtHKr8FA798i8VYT9eRnruFYF640p8nJXnQ9wNF3wmydR7txnJ7rKrbGa
         tU631WP74y3YLLvsl6gm0sAZUCFujCrFdRM90Sd2yep4SE/4S+B/ai7Pe1X2DN/fAbGY
         QfhwDsMIPEohISrHRF/PrR932u+rUHhvZXAspsg6OGrnKtzvqvn7OOYAsYowKYZrcIqw
         A36g==
X-Gm-Message-State: AOJu0YwpAGdvaxlsyfB2uHRb8SdCv4GK4SycPUVLanLWh8zBd++zGP3T
        rA9V/6OCVpRqBlSUV+ZvmXG5FdqjGoOF9A==
X-Google-Smtp-Source: AGHT+IHUFvbtVY+WO7bPTzj3/Az1ihxcCqacs+UHTA8m/ZnZDt0nHqoruCsg68RYzacUHS/6lF59uLJVzFDj6w==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a81:b647:0:b0:577:619e:d3c9 with SMTP id
 h7-20020a81b647000000b00577619ed3c9mr89822ywk.10.1691447970674; Mon, 07 Aug
 2023 15:39:30 -0700 (PDT)
Date:   Mon, 07 Aug 2023 15:39:28 -0700
In-Reply-To: <d023c297dcac0bb96f681dc1fc0116a649c2efec.1691211879.git.gitgitgadget@gmail.com>
Mime-Version: 1.0
References: <pull.1563.git.1691211879.gitgitgadget@gmail.com> <d023c297dcac0bb96f681dc1fc0116a649c2efec.1691211879.git.gitgitgadget@gmail.com>
Message-ID: <kl6l5y5qa34v.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH 2/5] trailer: split process_input_file into separate pieces
From:   Glen Choo <chooglen@google.com>
To:     Linus Arver via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Linus Arver <linusa@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Currently, process_input_file does three things:
>
>     (1) parse the input string for trailers,
>     (2) print text before the trailers, and
>     (3) calculate the position of the input where the trailers end.
>
> Rename this function to parse_trailers(), and make it only do
> (1).

Okay, process_input_file() is a very unhelpful name (What does it mean
to "process a file"?). In contrast, parse_trailers() is more
self-descriptive (It parses trailers into some appropriate format, so it
shouldn't do things like print.) Makes sense.

Is there some additional, unstated purpose behind this change besides
"move things around for readability"? E.g. do you intend to move
parse_trailers() to a future trailer parsing library? If so, that would
be useful context to evaluate the goodness of this split.

> The caller of this function, process_trailers, becomes responsible
> for (2) and (3). These items belong inside process_trailers because they
> are both concerned with printing the surrounding text around
> trailers (which is already one of the immediate concerns of
> process_trailers).

I agree that (2) doesn't belong in parse_trailers(). OTOH, (3) sounds
like something that belongs in parse_trailers() - you have to parse
trailers in order to tell where the trailers start and end, so it makes
sense for the parsing function to give those values.

> diff --git a/trailer.c b/trailer.c
> index dff3fafe865..16fbba03d07 100644
> --- a/trailer.c
> +++ b/trailer.c
> @@ -961,28 +961,23 @@ static void unfold_value(struct strbuf *val)
>  	strbuf_release(&out);
>  }
>  
> -static size_t process_input_file(FILE *outfile,
> -				 const char *str,
> -				 struct list_head *head,
> -				 const struct process_trailer_options *opts)
> +/*
> + * Parse trailers in "str" and populate the "head" linked list structure.
> + */
> +static void parse_trailers(struct trailer_info *info,

"info" is an out parameter, and IIRC we typically put out parameters
towards the end. I didn't find a callout in CodingGuidelines, though, so
idk if this is an ironclad rule or not.

> +			     const char *str,
> +			     struct list_head *head,
> +			     const struct process_trailer_options *opts)
>  {
> -	struct trailer_info info;
>  	struct strbuf tok = STRBUF_INIT;
>  	struct strbuf val = STRBUF_INIT;
>  	size_t i;
>  
> -	trailer_info_get(&info, str, opts);
> -
> -	/* Print lines before the trailers as is */
> -	if (!opts->only_trailers)
> -		fwrite(str, 1, info.trailer_start - str, outfile);

We no longer fwrite the contents before the trailer, okay.

> +	trailer_info_get(info, str, opts);

This is where we actually get the start and end of trailers, and each
trailer string. This is parsing out the trailers from a string, so what
other parsing is left? Reading ahead shows that we're actually parsing
the trailer string into a "struct trailer_item". Okay, so this function
is basically a wrapper around trailer_info_get() that also "returns" the
parsed trailer_items.

> -	if (!opts->only_trailers && !info.blank_line_before_trailer)
> -		fprintf(outfile, "\n");
> -

So we don't print the trailing line. Also makes sense.

> @@ -1003,9 +998,7 @@ static size_t process_input_file(FILE *outfile,
>  		}
>  	}
>  
> -	trailer_info_release(&info);
> -
> -	return info.trailer_end - str;
> +	trailer_info_release(info);
>  }
>  

Even though "info" is a pointer passed into this function, we are
_release-ing it. This is not an umabiguously good change, IMO. Before,
"info" was never used outside of this function, so we should obviously
release it before returning. However, now that "info" is an out
parameter, we should be more careful about releasing it. I don't think
it's obvious that the caller will see the right values for
info.trailer_end and info.trailer_start, but free()-d values for
info.trailers, and a meaningless value for info.trailer_nr (since the
items were free()-d).

I think it might be better to update the comment on parse_trailers()
like so:

  /*
   * Parse trailers in "str", populating the trailer info and "head"
   * linked list structure.
   */

and make it the caller's responsibility to call trailer_info_release().
We could move this call to where we "free_all(head)".

>  static void free_all(struct list_head *head)
> @@ -1054,6 +1047,7 @@ void process_trailers(const char *file,
>  {
>  	LIST_HEAD(head);
>  	struct strbuf sb = STRBUF_INIT;
> +	struct trailer_info info;
>  	size_t trailer_end;
>  	FILE *outfile = stdout;
>  
> @@ -1064,8 +1058,16 @@ void process_trailers(const char *file,
>  	if (opts->in_place)
>  		outfile = create_in_place_tempfile(file);

Thinking out loud, should we move the creation of outfile next to where
we first use it?

> +	parse_trailers(&info, sb.buf, &head, opts);
> +	trailer_end = info.trailer_end - sb.buf;
> +
>  	/* Print the lines before the trailers */
> -	trailer_end = process_input_file(outfile, sb.buf, &head, opts);
> +	if (!opts->only_trailers)
> +		fwrite(sb.buf, 1, info.trailer_start - sb.buf, outfile);

I'm not sure if it is an unambiguously good change for the caller to
learn how to compute the start and end of the trailer sections by doing
pointer arithmetic, but I guess format_trailer_info() does this anyway,
so your proposal to move (3) outside of the parse_trailers() makes
sense.

It feels a bit non-obvious that trailer_start and trailer_end are
pointing inside the input string. I wonder if we should just return the
_start and _end offsets directly instead of returning pointers. I.e.:

   struct trailer_info {
     int blank_line_before_trailer;
 -  /*
 -   * Pointers to the start and end of the trailer block found. If there
 -   * is no trailer block found, these 2 pointers point to the end of the
 -   * input string.
 -   */
 -   const char *trailer_start, *trailer_end;
 +   /* Offsets to the trailer block start and end in the input string */
 +   size_t *trailer_start, *trailer_end;

Which makes their intended use fairly unambiguous. A quick grep suggests
that in trailer.c, we're roughly as likely to use the pointer directly
vs using it to do pointer arithmetic, so converging on one use might be
a win for readability. The only other user outside of trailer.c is
sequencer.c, which doesn't care about the return type - it only checks
if there are trailers.
