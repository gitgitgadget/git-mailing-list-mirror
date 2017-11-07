Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B93020A36
	for <e@80x24.org>; Tue,  7 Nov 2017 23:20:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757528AbdKGXUi (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Nov 2017 18:20:38 -0500
Received: from mail-it0-f43.google.com ([209.85.214.43]:46269 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753000AbdKGXUh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Nov 2017 18:20:37 -0500
Received: by mail-it0-f43.google.com with SMTP id f187so4604154itb.1
        for <git@vger.kernel.org>; Tue, 07 Nov 2017 15:20:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=31xNwPyHCgWRCT+9Kz7HRZxSE7BTL641fhmsgT1yeKE=;
        b=iicrH7WHO4/+XNMCoTLa5ibHw6omAVHeGuJzZuDmrjflPS6ATguEZyLDVzq60SkdyC
         96C8QgAcQ5+nt3ijiSVczu/an6r477ZjHpBppWEs7moxgHjXU1ddvVGd8Cc8fKWjVohp
         Up2HwkeAgP3jAsxuFGqmwu7mlwB5AZIfNSIGbNHKGoPwlO28aWS9COf4hT1LHX5WE8qI
         cWUHVw3tX7kaktxwBkxJdkPbPATrlMVcfZnsc6chiVRPW2bRdNXCBhBPP/azuWg2A3uz
         6/lcVWkgyY8dse44DAsNff8KFlU5HIm7krMq84oCOpJXsJc/Y3exDKkVM8vcTL5xOT7B
         BfgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=31xNwPyHCgWRCT+9Kz7HRZxSE7BTL641fhmsgT1yeKE=;
        b=Tg1jffo2O/IlxLKn3MiRwXVSFN6Fj8Qc6sYUr8/O3JrZtoVS40zCkgB7Tn+fyhBKdz
         OXkNLy8Bn3FDWKo8bN5wbeURGaAVt7SFILLRcbuJ3yQFQ9XRq42AKmVYue2iQMD/Ln0P
         YwCvbUYatQ5Zdqe5lPHWdkIXQjfmz2qy9uNSQXhnJQP4wrTbLxep11k14dMGFUlvQnZg
         8LP/d+MxOU2SPLgZxDHK5FawctguGgnskk6dSyXjFgIHhaotXo+afmp85jlTg2J7nvTw
         V7ZNQKHvsMV+jcGsafd2nyLIvj8e86lNTw8YhDHr84Y+/A01VzSW4c7IzMk5wP3qBwrl
         sYnw==
X-Gm-Message-State: AJaThX59tkLg0iE6AEmeah82Rku+MN9mq30iKyFoxjfMi9oFBUMTnv+C
        FJ9HoPnZ73SyegSKTsBVLNJWhg==
X-Google-Smtp-Source: ABhQp+T0DlA3Bye+NoUjnC/Yk/znuO6vFXCa2wV1oZSf3mtWG4wTlI0vEI8DshDgbs/gLoQ99TFG6g==
X-Received: by 10.36.33.71 with SMTP id e68mr1180369ita.111.1510096836481;
        Tue, 07 Nov 2017 15:20:36 -0800 (PST)
Received: from twelve3.mtv.corp.google.com ([2620:0:100e:422:8df4:1665:e9bb:1ae7])
        by smtp.gmail.com with ESMTPSA id h20sm1086719iob.65.2017.11.07.15.20.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Nov 2017 15:20:35 -0800 (PST)
Date:   Tue, 7 Nov 2017 15:20:34 -0800
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v3 4/6] list-objects: filter objects in
 traverse_commit_list
Message-Id: <20171107152034.47686f6ece72ea3d43005b12@google.com>
In-Reply-To: <20171107193546.10017-5-git@jeffhostetler.com>
References: <20171107193546.10017-1-git@jeffhostetler.com>
        <20171107193546.10017-5-git@jeffhostetler.com>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue,  7 Nov 2017 19:35:44 +0000
Jeff Hostetler <git@jeffhostetler.com> wrote:

> +/*
> + * Reject the arg if it contains any characters that might
> + * require quoting or escaping when handing to a sub-command.
> + */
> +static int reject_injection_chars(const char *arg)
> +{
[snip]
> +}

Someone pointed me to quote.{c,h}, which is probably sufficient to
ensure shell safety if we do invoke subcommands through the shell. If
that is so, we probably don't need a blacklist.

Having said that, though, it might be safer to still introduce one, and
relax it later if necessary - it is much easier to relax a constraint
than to increase one.

> +	} else if (skip_prefix(arg, "sparse:", &v0)) {
> +
> +		if (skip_prefix(v0, "oid=", &v1)) {
> +			struct object_context oc;
> +			struct object_id sparse_oid;
> +			filter_options->choice = LOFC_SPARSE_OID;
> +			if (!get_oid_with_context(v1, GET_OID_BLOB,
> +						  &sparse_oid, &oc))
> +				filter_options->sparse_oid_value =
> +					oiddup(&sparse_oid);
> +			return 0;
> +		}

In your recent e-mail [1], you said that you will change it to always pass
the original expression - is that still the plan?

[1] https://public-inbox.org/git/f698d5a8-bf31-cea1-a8da-88b755b0b7af@jeffhostetler.com/

> +/* Remember to update object flag allocation in object.h */

You probably can delete this line.

> +/*
> + * FILTER_SHOWN_BUT_REVISIT -- we set this bit on tree objects
> + * that have been shown, but should be revisited if they appear
> + * in the traversal (until we mark it SEEN).  This is a way to
> + * let us silently de-dup calls to show() in the caller.

This is unclear to me at first reading. Maybe something like:

  FILTER_SHOWN_BUT_REVISIT -- we set this bit on tree objects that have
  been shown, but should not be skipped over if they reappear in the
  traversal. This ensures that the tree's descendants are re-processed
  if the tree reappears subsequently, and that the tree is not shown
  twice.

> + * This
> + * is subtly different from the "revision.h:SHOWN" and the
> + * "sha1_name.c:ONELINE_SEEN" bits.  And also different from
> + * the non-de-dup usage in pack-bitmap.c
> + */

Optional: I'm not sure if this comparison is useful. (Maybe it is useful
to others, though.)

> +/*
> + * A filter driven by a sparse-checkout specification to only
> + * include blobs that a sparse checkout would populate.
> + *
> + * The sparse-checkout spec can be loaded from a blob with the
> + * given OID or from a local pathname.  We allow an OID because
> + * the repo may be bare or we may be doing the filtering on the
> + * server.
> + */
> +struct frame {
> +	/*
> +	 * defval is the usual default include/exclude value that
> +	 * should be inherited as we recurse into directories based
> +	 * upon pattern matching of the directory itself or of a
> +	 * containing directory.
> +	 */
> +	int defval;

Can this be an "unsigned defval : 1" as well? In the function below, I
see that you assign to an "int val" first (which can take -1, 0, and 1)
before assigning to this, so that is fine.

Also, maybe a better name would be "exclude", with the documentation:

  1 if the directory is excluded, 0 otherwise. Excluded directories will
  still be recursed through, because an "include" rule for an object
  might override an "exclude" rule for one of its ancestors.
