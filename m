Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 498001F597
	for <e@80x24.org>; Thu,  2 Aug 2018 02:56:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726032AbeHBEpi (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Aug 2018 00:45:38 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33872 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbeHBEpi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 00:45:38 -0400
Received: by mail-pg1-f196.google.com with SMTP id y5-v6so399337pgv.1
        for <git@vger.kernel.org>; Wed, 01 Aug 2018 19:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=YRkAmsUn4QwzrB5Ttq5nIb0hhJwNAP5ucuFk1Ti9Y2s=;
        b=DKLijNxKhwpiIDsBiOyIpT3PuhFVVmW4aln90EnwIpfrWpjYa/cGGYCxWhCGLQmCLn
         XMF3F0gHYJ5AU93ZC0ZfcvamXqzSZhTXTp3CW7s/SolBR4MesmMvvkatV/1OdNQO6N/0
         On74RQT11/z64sL9vRG0UI1pRwnJhYZYBmtiIcXaMALo4EbXMe7et5w5tE+sTY+76OeD
         An56A3x5u4viK5jxN3w1kfA5dO03LH/dfWsleFQGfbAnOg6TKpqohp/TVjwv/67/tgbJ
         vugDQWdqILtYbDzXwJ0JA14QCVpvQFiNeLi51howGbOO0defihy2SGmV8o6axalBA5Ew
         z4kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=YRkAmsUn4QwzrB5Ttq5nIb0hhJwNAP5ucuFk1Ti9Y2s=;
        b=JwXkcefUekpCkGKjqYUalk4AHLNbz1b78Sv1cw8LEHNjIo+LjuJ76kmZn9kayrmwH7
         efeZ9gwJPRl2w4lPBOcsaX+jOIBmfRrKMPiQDYEf2IiSKAKQKiODRSUQ1lZmEZb9vtn6
         xcIDSEzPPhY5Z5Sj9V6dgNgmR31cVkOctIhEW2AXAdGl/J4bte0jceCUy3E7OwTRYMzR
         BMWmGcavTeGsULiP94xqXX8rWelp5rWAroZTQr0jGETRixuQdkQUbCGCDp0XZHGfKzqe
         GdedHXdwSkuAn7CP8IWAkyNlB0HDud6wBrG8OKVITlpekn3TAjv7MM/FjU8dmVYTyhnd
         RbjA==
X-Gm-Message-State: AOUpUlGm9OrHiaBCcBhs5jeycYGIKAxZS+pT6qGko9dCjNPHKpJn3XlZ
        RDT5ykrUp0dVUXODdU7b2n8=
X-Google-Smtp-Source: AAOMgpdeWipKxfCdD+SCam3cXLh1f9rlPRyspzq8r3kjL6mWKTsjY2ATND9Ss9rBcVnV8azWm5OPpg==
X-Received: by 2002:a63:d309:: with SMTP id b9-v6mr877904pgg.163.1533178603771;
        Wed, 01 Aug 2018 19:56:43 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id n24-v6sm624163pfi.161.2018.08.01.19.56.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 Aug 2018 19:56:43 -0700 (PDT)
Date:   Wed, 1 Aug 2018 19:56:41 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH] remote: clear string_list after use in mv()
Message-ID: <20180802025641.GF189024@aiede.svl.corp.google.com>
References: <553f84f2-7d9d-9a92-d5ca-39bd862ff748@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <553f84f2-7d9d-9a92-d5ca-39bd862ff748@web.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

René Scharfe wrote:

> Subject: remote: clear string_list after use in mv()

This subject line doesn't fully reflect the goodness of this change.
How about something like:

	remote mv: avoid leaking ref names in string_list

?

> Switch to the _DUP variant of string_list for remote_branches to allow
> string_list_clear() to release the allocated memory at the end, and
> actually call that function.  Free the util pointer as well; it is
> allocated in read_remote_branches().
>
> NB: This string_list is empty until read_remote_branches() is called
> via for_each_ref(), so there is no need to clean it up when returning
> before that point.
>
> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---
> Patch generated with ---function-context for easier review -- that
> makes it look much bigger than it actually is, though.

Thanks, that indeed helps.

[...]
> --- a/builtin/remote.c
> +++ b/builtin/remote.c
> @@ -558,23 +558,23 @@ struct rename_info {

optional: Would it be worth a comment in the struct definition to say
this string_list owns its items (or in other words that it's a _DUP
string_list)?

I think we're fine without, since it's local to the file, but may make
sense to do if rerolling.

[...]
> @@ -607,133 +607,134 @@ static int migrate_file(struct remote *remote)
>  static int mv(int argc, const char **argv)
>  {
>  	struct option options[] = {
>  		OPT_END()
>  	};
>  	struct remote *oldremote, *newremote;
>  	struct strbuf buf = STRBUF_INIT, buf2 = STRBUF_INIT, buf3 = STRBUF_INIT,
>  		old_remote_context = STRBUF_INIT;
> -	struct string_list remote_branches = STRING_LIST_INIT_NODUP;
> +	struct string_list remote_branches = STRING_LIST_INIT_DUP;

Verified that these are the only two functions that touch the
remote_branches field.  This patch didn't miss any callers.

[...]
>  	if (!refspec_updated)
>  		return 0;
>  
>  	/*
>  	 * First remove symrefs, then rename the rest, finally create
>  	 * the new symrefs.
>  	 */
>  	for_each_ref(read_remote_branches, &rename);

As you noted, this is the first caller that writes to the string_list,
so we don't have to worry about the 'return 0' above.  That said, I
wonder if it might be simpler and more futureproof to use
destructor-style cleanup handling anyway:

	if (!refspec_updated)
		goto done;
 [...]
  done:
	string_list_clear(&remote_branches, 1);
	return 0;

[...]
> +	string_list_clear(&remote_branches, 1);

not about this patch: I wonder if we should make the free_util
parameter a flag word so the behavior is more obvious in the caller:

	string_list_clear(&remote_branches, STRING_LIST_FREE_UTIL);

Or maybe even having a separate function:

	string_list_clear_free_util(&remote_branches);

That's a topic for another day, though.

With whatever subset of the changes suggested above makes sense,

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks for a pleasant read.
