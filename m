Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	RCVD_IN_DNSWL_HI,T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6950F207D2
	for <e@80x24.org>; Fri, 23 Jun 2017 22:51:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754109AbdFWWvT (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Jun 2017 18:51:19 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33662 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753942AbdFWWvS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2017 18:51:18 -0400
Received: by mail-pg0-f67.google.com with SMTP id u62so7728804pgb.0
        for <git@vger.kernel.org>; Fri, 23 Jun 2017 15:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=/pDAIZ1TgGuFqzWm8qdYGsDELK4vIMh1CuxeSBrZkdE=;
        b=e1qWCu5+FEzK/NEk1Qo/+pcxo3W6xzf9UdMyHForXFW0tkzvNLsSWhkJjS2nWRFLwV
         1KMYDxr9OVvVSpmZMbwIQTwYDlCY2KH1W2PQD7G6hFbJqCtuoCtE7cB3jiMUS/VyQrKH
         J+9BxM7XkCzIQ7xbluGP5CDFQFcKdfQjRgLzCbMVcC37MKG4ZjRHq1ydNbOYO93ax6qs
         A4HqG5HqLQkEo6Z8WiUIP1YWBF+sl5MgQIYqbQckBrVFFt8Ac+XrUoIXnWG6FtFk4rSZ
         aGaI/BcjywylU+Pqf2kRN5oLH8YybEpQYGo7DAufYsn61qyQWNVPnavt3IA+ZExmsgVf
         3DmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=/pDAIZ1TgGuFqzWm8qdYGsDELK4vIMh1CuxeSBrZkdE=;
        b=j9SOu5bUrTIpvg4eas8tGtrSWwfmPuPQCBdRvKHLVuSBG0i5EO0nDJuLDJlusL7301
         4Rvt1mjPhN9uvc69+8tQyvY7aoaqWJuJcovJnFNSjb2S1jzWe5kbDukCjaW728pY9rGx
         q3evtMbWj0oWV9PfN0zlSiY+leW2ybz+fIJOPqN5CXHARyl9eIZCqorJliZyi1MWTDdA
         R3JoXejMtNXGbtSeDLzJOW4xoEmX+QGBZ7spLMcdXAdS2tsvfUSV9XPWDNDUdBcjEaRG
         2/bt1XVM6U4FFV8xaIJtvcpkD1NWpRSJr1fIOKmbdnu1Akwo+p3KyIlBK6LvMDf6WtH1
         Xvjw==
X-Gm-Message-State: AKS2vOwBxNwRZcOllkTwlTPKTliRR9rTCB0dDyOWB2cZ+aS1NgOau2Ez
        wGYzIcHtoDcTmg==
X-Received: by 10.84.224.134 with SMTP id s6mr11407278plj.263.1498258278013;
        Fri, 23 Jun 2017 15:51:18 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:4cd0:d6d2:1e09:4052])
        by smtp.gmail.com with ESMTPSA id c75sm13906120pga.38.2017.06.23.15.51.17
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 23 Jun 2017 15:51:17 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com, sbeller@google.com
Subject: Re: [PATCH] submodule--helper: teach push-check to handle HEAD
References: <20170623200427.26803-1-bmwill@google.com>
Date:   Fri, 23 Jun 2017 15:51:16 -0700
In-Reply-To: <20170623200427.26803-1-bmwill@google.com> (Brandon Williams's
        message of "Fri, 23 Jun 2017 13:04:27 -0700")
Message-ID: <xmqqk242b9nf.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> In 06bf4ad1d (push: propagate remote and refspec with
> --recurse-submodules) push was taught how to propagate a refspec down to
> submodules when the '--recurse-submodules' flag is given.  The only refspecs
> that are allowed to be propagated are ones which name a ref which exists
> in both the superproject and the submodule, with the caveat that 'HEAD'
> was disallowed.
>
> This patch teaches push-check (the submodule helper which determines if
> a refspec can be propagated to a submodule) to permit propagating 'HEAD'
> if and only if the superproject and the submodule both have the same
> named branch checked out and the submodule is not in a detached head
> state.
>
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>  builtin/submodule--helper.c    | 57 +++++++++++++++++++++++++++++++-----------
>  submodule.c                    | 18 ++++++++++---
>  t/t5531-deep-submodule-push.sh | 25 +++++++++++++++++-
>  3 files changed, 82 insertions(+), 18 deletions(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 1b4d2b346..fd5020036 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -1107,24 +1107,41 @@ static int resolve_remote_submodule_branch(int argc, const char **argv,
>  static int push_check(int argc, const char **argv, const char *prefix)
>  {
>  	struct remote *remote;
> +	const char *superproject_head;
> +	char *head;
> +	int detached_head = 0;
> +	struct object_id head_oid;
>  
> -	if (argc < 2)
> -		die("submodule--helper push-check requires at least 1 argument");
> +	if (argc < 3)
> +		die("submodule--helper push-check requires at least 2 argument");

"arguments"?

> +
> +	/*
> +	 * superproject's resolved head ref.
> +	 * if HEAD then the superproject is in a detached head state, otherwise
> +	 * it will be the resolved head ref.
> +	 */
> +	superproject_head = argv[1];

The above makes it sound like the caller gives either "HEAD" (when
detached) or "refs/heads/branch" (when on 'branch') in argv[1] and
you are stashing it away, but ...

> +	/* Get the submodule's head ref and determine if it is detached */
> +	head = resolve_refdup("HEAD", 0, head_oid.hash, NULL);
> +	if (!head)
> +		die(_("Failed to resolve HEAD as a valid ref."));
> +	if (!strcmp(head, "HEAD"))
> +		detached_head = 1;

... the work to see which branch we are on and if we are detached is
done by this code without consulting argv[1].  I cannot tell what is
going on.  Is argv[1] assigned to superproject_head a red herring?

>  	/*
>  	 * The remote must be configured.
>  	 * This is to avoid pushing to the exact same URL as the parent.
>  	 */
> -	remote = pushremote_get(argv[1]);
> +	remote = pushremote_get(argv[2]);
>  	if (!remote || remote->origin == REMOTE_UNCONFIGURED)
> -		die("remote '%s' not configured", argv[1]);
> +		die("remote '%s' not configured", argv[2]);
>  
>  	/* Check the refspec */
> -	if (argc > 2) {
> -		int i, refspec_nr = argc - 2;
> +	if (argc > 3) {
> +		int i, refspec_nr = argc - 3;
>  		struct ref *local_refs = get_local_heads();
>  		struct refspec *refspec = parse_push_refspec(refspec_nr,
> -							     argv + 2);
> +							     argv + 3);

If you have no need for argv[1] (and you don't, as you have stashed
it away in superproject_head), it may be less damage to the code if
you shifted argv upfront after grabbing superproject_head.

>  		for (i = 0; i < refspec_nr; i++) {
>  			struct refspec *rs = refspec + i;
> @@ -1132,18 +1149,30 @@ static int push_check(int argc, const char **argv, const char *prefix)
>  			if (rs->pattern || rs->matching)
>  				continue;
>  
> -			/*
> -			 * LHS must match a single ref
> -			 * NEEDSWORK: add logic to special case 'HEAD' once
> -			 * working with submodules in a detached head state
> -			 * ceases to be the norm.
> -			 */
> -			if (count_refspec_match(rs->src, local_refs, NULL) != 1)
> +			/* LHS must match a single ref */
> +			switch(count_refspec_match(rs->src, local_refs, NULL)) {

"switch (count..."

> +			case 1:
> +				break;
> +			case 0:
> +				/*
> +				 * If LHS matches 'HEAD' then we need to ensure
> +				 * that it matches the same named branch
> +				 * checked out in the superproject.
> +				 */
> +				if (!strcmp(rs->src, "HEAD")) {
> +					if (!detached_head &&
> +					    !strcmp(head, superproject_head))
> +						break;
> +					die("HEAD does not match the named branch in the superproject");
> +				}

Hmph, so earlier people can "push --recurse-submodules HEAD:$dest"
and $dest can be anything, but now we are tightening the rule?

> +			default:
>  				die("src refspec '%s' must name a ref",
>  				    rs->src);
> +			}
>  		}
>  		free_refspec(refspec_nr, refspec);
>  	}
> +	free(head);
>  
>  	return 0;
>  }
