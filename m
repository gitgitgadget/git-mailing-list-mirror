Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 787A2C7618E
	for <git@archiver.kernel.org>; Wed, 26 Apr 2023 19:26:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239557AbjDZT0B (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Apr 2023 15:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239593AbjDZTZ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2023 15:25:59 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CAE226B8
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 12:25:56 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-b8f57401d2aso16698604276.1
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 12:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682537155; x=1685129155;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=P5us/G7LVjanew1zE4bVKEzu0C6sr41huu+B0zrE+vI=;
        b=pjhw4f+cBgZNz7nw7WpPaSDXYvb82ECygWflEoBpuSEUbLFAZkDfA+2GBxg+v1Tnfi
         CoEirzVkxRKsW7oMnQBbmU57fjyMFqZk3J2zif0WLIBbTrXPVdtCzV3chhCtofFNj/oB
         XDN9mj5AEtWXolmUZRgEMX/l1LzpQjyjUe9B85jc+/Ys9giqv4GG5CueD9oeZPOr+E3U
         LogAt/FGNzJn/Jih5XDqDLgu6x+UNVFFLWGRG3SICNkYcN+YkExdF1PV2f71aifCsNYY
         jLrCromBV/Zdy6Nh6gLufZr0h9nDjPjZmSa53Mn2ZrIXKfaJiNWWCnNd7Uug729rOH3A
         /N/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682537155; x=1685129155;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P5us/G7LVjanew1zE4bVKEzu0C6sr41huu+B0zrE+vI=;
        b=BmK89x/k6sW9C7AZtwRk7odS/KWem0f4FUrgirnvQpn42cEpr2zQi+LOWkN911SSn4
         /ecXbxqf2DXxKR0Nxf3D2jtu7aYOjMxWh3YiX3GOkfSIh86zjWpEtU64oVmEJ6GafM6e
         hhfNr3ZfBcDIYLlsNTYnSWBnCKUI8TmssOWCfmfo7Zg40ypbSlXPmZsDv4lYknoqNmDy
         IzO5SNzBMz6tbMwZ9T2Hbls8NKBsy327VEcydciX5V3J0B4GjYJ8LYwGyQ4JyhzM9JMu
         AsIMb8aW9AXtYOIFvRYSb2LCsApyv9Fvj71TZKzoOnvdjv/9+ZigBEctwJ/mAqBJpg+E
         7VVg==
X-Gm-Message-State: AAQBX9fGUsVwXiJhYAM20EfOH5eK0rgTY2NFVdkgIabqQosTpsY3srug
        sqxIqkHE7u5FXfR0xp7JVXsXeAltDIcpvg==
X-Google-Smtp-Source: AKy350ZoMlDW1TQCf2WhylBRvfyOQ/HYfX0/Iu6/qX03D7OP3khg1eIQPxeFXg4qZPOWr3Kv9JXuVZyvVXpBHw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a25:7494:0:b0:b8f:3881:1638 with SMTP id
 p142-20020a257494000000b00b8f38811638mr8847864ybc.7.1682537155403; Wed, 26
 Apr 2023 12:25:55 -0700 (PDT)
Date:   Wed, 26 Apr 2023 12:25:53 -0700
In-Reply-To: <596e12f03a296d753ee6fe8face9522edc9e397e.1681906948.git.ps@pks.im>
Mime-Version: 1.0
References: <cover.1681906948.git.ps@pks.im> <596e12f03a296d753ee6fe8face9522edc9e397e.1681906948.git.ps@pks.im>
Message-ID: <kl6l5y9io37i.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH 3/8] fetch: fix missing from-reference when fetching HEAD:foo
From:   Glen Choo <chooglen@google.com>
To:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rearranging the lines slightly,

Patrick Steinhardt <ps@pks.im> writes:

> When displaying reference updates, we print a line that looks similar to
> the following:
>
> ```
>  * branch               master          -> master
> ```
>
> The "branch" bit changes depending on what kind of reference we're
> updating, while both of the right-hand references are computed by
> stripping well-known prefixes like "refs/heads/" or "refs/tags".
>
> [...]
>                   we also use this value to display reference updates.
> And while the call to `display_ref_update()` correctly figures out that
> we meant "HEAD" when `what` is empty, the call to `update_local_ref()`
> doesn't. `update_local_ref()` will then call `display_ref_update()` with
> the empty string and cause the following broken output:
>
> ```
> $ git fetch --dry-run origin HEAD:foo
> From https://github.com/git/git
>  * [new ref]                          -> foo
> ```
>
> [...]
>
> Fix this bug by instead unconditionally passing the full reference name
> to `display_ref_update()` which learns to call `prettify_refname()` on
> it. This does fix the above bug and is otherwise functionally the same
> as `prettify_refname()` would only ever strip the well-known prefixes
> just as intended. So at the same time, this also simplifies the code a
> bit.


The bug fix is obviously good. I'm surprised we hadn't caught this
sooner.

As a nitpicky comment, the commit message goes into a lot of detail,
which makes it tricky to read on its own (though the level of detail
makes it easy to match to the diff, making the diff quite easy to
follow). I would have found this easier to read by summarizing the
high-level mental model before diving into the background, e.g.


  store_updated_refs() parses the remote ref name to create a 'note' to
  write to FETCH_HEAD. This note is usually the prettified ref name, so
  it is used to diplay ref updates (display_ref_update()). But if the
  remote ref is HEAD, the note is the empty string [insert bug
  description]. Instead, use the note only as a note and have
  display_ref_update() prettify the ref name itself...

> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index c310d89878..7c64f0c562 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -918,12 +918,14 @@ static void display_ref_update(struct display_state *display_state, char code,
>  	}
>  
>  	width = (summary_width + strlen(summary) - gettext_width(summary));
> +	remote = prettify_refname(remote);
> +	local = prettify_refname(local);
>  
>  	strbuf_addf(&display_state->buf, " %c %-*s ", code, width, summary);
>  	if (!display_state->compact_format)
> -		print_remote_to_local(display_state, remote, prettify_refname(local));
> +		print_remote_to_local(display_state, remote, local);
>  	else
> -		print_compact(display_state, remote, prettify_refname(local));
> +		print_compact(display_state, remote, local);
>  	if (error)
>  		strbuf_addf(&display_state->buf, "  (%s)", error);
>  	strbuf_addch(&display_state->buf, '\n');

As expected, we now prettify the name isntead of trusting the 'note'
that came in the parameter...

> @@ -934,7 +936,7 @@ static void display_ref_update(struct display_state *display_state, char code,
>  static int update_local_ref(struct ref *ref,
>  			    struct ref_transaction *transaction,
>  			    struct display_state *display_state,
> -			    const char *remote, const struct ref *remote_ref,
> +			    const struct ref *remote_ref,
>  			    int summary_width)
>  {
>  	struct commit *current = NULL, *updated;
> @@ -946,7 +948,7 @@ static int update_local_ref(struct ref *ref,
>  	if (oideq(&ref->old_oid, &ref->new_oid)) {
>  		if (verbosity > 0)
>  			display_ref_update(display_state, '=', _("[up to date]"), NULL,
> -					   remote, ref->name, summary_width);
> +					   remote_ref->name, ref->name, summary_width);
>  		return 0;
>  	}
>  
> @@ -959,7 +961,7 @@ static int update_local_ref(struct ref *ref,
>  		 */
>  		display_ref_update(display_state, '!', _("[rejected]"),
>  				   _("can't fetch into checked-out branch"),
> -				   remote, ref->name, summary_width);
> +				   remote_ref->name, ref->name, summary_width);
>  		return 1;
>  	}
>  
> @@ -970,12 +972,12 @@ static int update_local_ref(struct ref *ref,
>  			r = s_update_ref("updating tag", ref, transaction, 0);
>  			display_ref_update(display_state, r ? '!' : 't', _("[tag update]"),
>  					   r ? _("unable to update local ref") : NULL,
> -					   remote, ref->name, summary_width);
> +					   remote_ref->name, ref->name, summary_width);
>  			return r;
>  		} else {
>  			display_ref_update(display_state, '!', _("[rejected]"),
>  					   _("would clobber existing tag"),
> -					   remote, ref->name, summary_width);
> +					   remote_ref->name, ref->name, summary_width);
>  			return 1;
>  		}
>  	}
> @@ -1008,7 +1010,7 @@ static int update_local_ref(struct ref *ref,
>  		r = s_update_ref(msg, ref, transaction, 0);
>  		display_ref_update(display_state, r ? '!' : '*', what,
>  				   r ? _("unable to update local ref") : NULL,
> -				   remote, ref->name, summary_width);
> +				   remote_ref->name, ref->name, summary_width);
>  		return r;
>  	}
>  
> @@ -1030,7 +1032,7 @@ static int update_local_ref(struct ref *ref,
>  		r = s_update_ref("fast-forward", ref, transaction, 1);
>  		display_ref_update(display_state, r ? '!' : ' ', quickref.buf,
>  				   r ? _("unable to update local ref") : NULL,
> -				   remote, ref->name, summary_width);
> +				   remote_ref->name, ref->name, summary_width);
>  		strbuf_release(&quickref);
>  		return r;
>  	} else if (force || ref->force) {
> @@ -1042,12 +1044,12 @@ static int update_local_ref(struct ref *ref,
>  		r = s_update_ref("forced-update", ref, transaction, 1);
>  		display_ref_update(display_state, r ? '!' : '+', quickref.buf,
>  				   r ? _("unable to update local ref") : _("forced update"),
> -				   remote, ref->name, summary_width);
> +				   remote_ref->name, ref->name, summary_width);
>  		strbuf_release(&quickref);
>  		return r;
>  	} else {
>  		display_ref_update(display_state, '!', _("[rejected]"), _("non-fast-forward"),
> -				   remote, ref->name, summary_width);
> +				   remote_ref->name, ref->name, summary_width);
>  		return 1;
>  	}
>  }

...

> @@ -1277,7 +1278,7 @@ static int store_updated_refs(struct display_state *display_state,
>  					  display_state->url_len);
>  
>  			if (ref) {
> -				rc |= update_local_ref(ref, transaction, display_state, what,
> +				rc |= update_local_ref(ref, transaction, display_state,
>  						       rm, summary_width);
>  				free(ref);
>  			} else if (write_fetch_head || dry_run) {
> @@ -1288,7 +1289,7 @@ static int store_updated_refs(struct display_state *display_state,
>  				 */
>  				display_ref_update(display_state, '*',
>  						   *kind ? kind : "branch", NULL,
> -						   *what ? what : "HEAD",
> +						   rm->name,
>  						   "FETCH_HEAD", summary_width);
>  			}
>  		}

and we stop passing the 'note' as a parameter. Looks good.

> @@ -1252,14 +1254,13 @@ static int store_updated_refs(struct display_state *display_state,
>  			if (!strcmp(rm->name, "HEAD")) {
>  				kind = "";
>  				what = "";
> -			}
> -			else if (skip_prefix(rm->name, "refs/heads/", &what))
> +			} else if (skip_prefix(rm->name, "refs/heads/", &what)) {
>  				kind = "branch";
> -			else if (skip_prefix(rm->name, "refs/tags/", &what))
> +			} else if (skip_prefix(rm->name, "refs/tags/", &what)) {
>  				kind = "tag";
> -			else if (skip_prefix(rm->name, "refs/remotes/", &what))
> +			} else if (skip_prefix(rm->name, "refs/remotes/", &what)) {
>  				kind = "remote-tracking branch";
> -			else {
> +			} else {
>  				kind = "";
>  				what = rm->name;
>  			}

I really appreciate that this makes the patch easier to read. I don't
really appreciate this sort of churn, but it _is_ following
CodingGuidelines:

	- When there are multiple arms to a conditional and some of them
	  require braces, enclose even a single line block in braces for
	  consistency. E.g.:

		if (foo) {
			doit();
		} else {
			one();
			two();
			three();
		}

(I initialy thought it wasn't. Thanks to other Review Club participants
for pointing this out).

> diff --git a/t/t5574-fetch-output.sh b/t/t5574-fetch-output.sh
> index 0e45c27007..55f0f05b6a 100755
> --- a/t/t5574-fetch-output.sh
> +++ b/t/t5574-fetch-output.sh
> @@ -54,6 +54,25 @@ test_expect_success 'fetch compact output' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'fetch output with HEAD and --dry-run' '

The commit message and diff didn't imply that this is a --dry-run only
bug. I tested locally, and it seems to reproduce without --dry-run too,
so I think we should drop "--dry-run" from this test name. In a later
patch, you also add a test for porcelain output with --dry-run, but
since this test seems designed for just this bug, I think we can drop
the later test.
