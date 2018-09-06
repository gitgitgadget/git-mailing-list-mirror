Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 467311F404
	for <e@80x24.org>; Thu,  6 Sep 2018 17:10:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728175AbeIFVrD (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Sep 2018 17:47:03 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43353 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727740AbeIFVrD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Sep 2018 17:47:03 -0400
Received: by mail-wr1-f65.google.com with SMTP id k5-v6so12184408wre.10
        for <git@vger.kernel.org>; Thu, 06 Sep 2018 10:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=I5zXxbDfrtelEddSRfhN677fcETZckgeiaz3o6dtZPE=;
        b=P2f8ypgdVpvRrD9Y3jC5E0xHguVtVGCrYUfwE7kyIrBM790xre9DJaC5fptld/wTBn
         iivicL3BI5yBromADe+tjCufqGPciA3VKVLpuPAL5L0GbQTvjlj9ZS3exjsamdrNUBmA
         yd/AIXRfpmapZ00eXPZatpno0EnZeExxTnjp2LvYALHfLwANYXrhfcA4elvYc45Em0+2
         ljhTYcywKtaXtOri93zeY30A0P1lIAWWt+H08B5+fFjFZs0joKzDkHV+G1gyewLRXfDI
         vtfQzkTcv0XBiQDNUf2/wDkBHLJqWuKtpW162i2Vh6YZ4u6lx/JXMqWYOK7QHztXJwZU
         ABaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=I5zXxbDfrtelEddSRfhN677fcETZckgeiaz3o6dtZPE=;
        b=k4Xx70ljbqdNY4TO6KKL41VTrqsEmbu7IV/6BuccNbu9STkAQSkgn1XH5EvdrNgJsF
         R9RgFQM+IPmE25ZXnk14P6oB5C4UeJZBhCpBYZyroQRK32mVx/aJ6Gq/lKn56ydv5t8K
         OcLCHg2XywsGSMd8o6x/Vb1lo9PMS++5a92jedJumSXI8fSBc+9TdApMvVD+CVSZ6px9
         /pzBKSw3zQ3ZHrnxUuuJTYJV+07fcKe7Sg2NTDOpY8ymueiwzKPSODdFxFI1bt9gK3bu
         KGUfe0dumnsxDME5xBjqg29zjYT10LGqErRfmOdNAj+a4RQUABY3yX11ytuhjfyxRK2k
         5p3w==
X-Gm-Message-State: APzg51B35xJLR+pwJqtp4KneuU824KXjvN+16lokpy1Ap5iLLy6fA/wd
        1LdukiqzTm5pmIAv4HVb9U8=
X-Google-Smtp-Source: ANB0VdY31KLGBPOPOwFkU8AUfnUijdRwdYdGRUxa/ghrpUXI8KWUJ3fYfajuvaWzPUw1vBgW8lF6Gg==
X-Received: by 2002:adf:dfca:: with SMTP id q10-v6mr2967412wrn.113.1536253835702;
        Thu, 06 Sep 2018 10:10:35 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id d22-v6sm10768049wra.80.2018.09.06.10.10.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Sep 2018 10:10:34 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 02/11] string-list.h: add string_list_{pop, last} functions
References: <20180904230149.180332-1-sbeller@google.com>
        <20180904230149.180332-3-sbeller@google.com>
Date:   Thu, 06 Sep 2018 10:10:34 -0700
In-Reply-To: <20180904230149.180332-3-sbeller@google.com> (Stefan Beller's
        message of "Tue, 4 Sep 2018 16:01:40 -0700")
Message-ID: <xmqqwory1rhx.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> A string list can be used as a stack, but should we?

verb missing.  "We can use a string list as ..., but should we?" is
readable.  "A string list can be ..., but should it be?" also is.

> A later patch shows
> how useful this will be.

Instead of all of the above, how about being more direct, i.e. e.g.

	Add a few functions to allow a string-list to be used as a
	stack:

	- string_list_last() lets a caller peek the string_list_item
          at the end of the string list.  The caller needs to be
          aware that it is borrowing a pointer, which can become
          invalid if/when the string_list is resized.

	- string_list_pop() removes the string_list_item at the end
          of the string list.

	You can use them in this pattern:

		while (list.nr) {
			struct string_list_item *item = string_list_last(&list);

			work_on(item);
			string_list_pop(&list);
		}

Then the readers would immediately have enough information to judge
if the new API is useful without blindly trusting what you promise.

Two things to note in the above suggested rewrite are:

 - It is curious that _pop() is not accompanied by _push().  It
   probably is a good idea to add the third bullet point that says
   "existing string_list_append() can be used in place of the
   missing string_list_push()."

 - As it already lays out the memory ownership issue, it probably
   makes the description we see below unnecessary (besides, the code
   snippet in there were buggy in at least two counts).

> In an earlier iteration of this patch it was suggested to return the last
> ...
> Also provide the function to access the last item in the list.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  string-list.c | 14 ++++++++++++++
>  string-list.h | 11 +++++++++++
>  2 files changed, 25 insertions(+)
>
> diff --git a/string-list.c b/string-list.c
> index 1ebbe1f56ea..21559f222a7 100644
> --- a/string-list.c
> +++ b/string-list.c
> @@ -80,6 +80,20 @@ void string_list_remove(struct string_list *list, const char *string,
>  	}
>  }
>  
> +void string_list_pop(struct string_list *list, int free_util)
> +{
> +	if (list->nr == 0)
> +		BUG("tried to remove an item from empty string list");
> +
> +	if (list->strdup_strings)
> +		free(list->items[list->nr - 1].string);
> +
> +	if (free_util)
> +		free(list->items[list->nr - 1].util);
> +
> +	list->nr--;
> +}

Conceptually, this allows string_list_clear() to be implemented in
terms of this function, i.e.

	string_list_clear(struct string_list *list, int free_util)
	{
		while (list->nr)
			string_list_pop(list, free_util);
		free(list->items);
		list->items = NULL;
		list->nr = list->alloc = 0;
	}

It is unfortunate that string_list has become such a kitchen-sink in
that a string list whose util field is used in such a way that
string_list_clear_func() needs to be used to clear the list cannot
be used as a stack.  Ideally each of these "features" (like
"sorted/unsorted", "owning/borrowing util", "owning/borrowing
string", etc.)  ought to be orthogonal, but they are not.

> diff --git a/string-list.h b/string-list.h
> index 5b22560cf19..d7cdf38e57a 100644
> --- a/string-list.h
> +++ b/string-list.h
> @@ -191,6 +191,17 @@ extern void string_list_remove(struct string_list *list, const char *string,
>   */
>  struct string_list_item *string_list_lookup(struct string_list *list, const char *string);
>  
> +/**
> + * Removes the last item from the list.
> + * The caller must ensure that the list is not empty.
> + */
> +void string_list_pop(struct string_list *list, int free_util);
> +
> +inline struct string_list_item *string_list_last(struct string_list *list)
> +{
> +	return &list->items[list->nr - 1];
> +}

inline functions declared in a header file must be marked "static
inline", I think.

>  /*
>   * Remove all but the first of consecutive entries with the same
>   * string value.  If free_util is true, call free() on the util
