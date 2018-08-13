Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 18F7C1F404
	for <e@80x24.org>; Mon, 13 Aug 2018 18:20:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730131AbeHMVDu (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 17:03:50 -0400
Received: from mail-ua1-f73.google.com ([209.85.222.73]:46837 "EHLO
        mail-ua1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728821AbeHMVDu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 17:03:50 -0400
Received: by mail-ua1-f73.google.com with SMTP id g12-v6so7924262ual.13
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 11:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=VON/VZOEiytRYaAEJtOQIIz4SbS7KtNg5z1BS7o4osQ=;
        b=jmasB74Q8hY6tXl7nUp+lY9zWyrSr8ayDpIF3kalBhSPFD4G6WoMNqTMJNeAuMxS78
         i+Kx6la9EYHyF6zg2VYABKCGhnoaXYSBwc6DP2D5GeuFYsEH9lVk1f3SZUHs/bZXtP0K
         AJHALq83kgjiFmod6Xr67At7IGth4k26Iivv5gW2oRDeNDS3qwmr/f6beSqH+diKCC94
         lvwmpRL8DjhPrCecHA730fXsoWEhMEuJoReDCtZ6mUtRL6KMJwAkBViYJukbq5245vpZ
         fL3wUh8kc77eeqPM/Ax5aCGkZYufmMyHfZqHxs8FYAIoGMKoP2zUqIjK4pL4+gIwxreU
         rADQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=VON/VZOEiytRYaAEJtOQIIz4SbS7KtNg5z1BS7o4osQ=;
        b=PmU/EEguXBRuRfqhc8W5SSHMBinFjRhNceaV7PMPQ4ZqL/OA9+DkqEAsAT2+iZrTF2
         uNRIl9+d3FpKo6ZjOShdvXibxS1PjoF0a5IRhKPXyyf1IMr9RhX6rZ00Bih0ujVSVLSV
         RoGuHcPf22hniiuJYigpdzbUgOm6YX7ZdAj7ozw5rsVzl/JB0Pm+677vYqoOA0dPWB2B
         UkWkD2fJ2wevYwn2fF51WFflsbDELSuddVhYvQVbdgfQayYLDVTRzaU0wcCS9hl6H/T1
         Ty/PS+JEDIW+cPFHeEOHikHIf7topY9zWcG37jI8gb2clKvnmzKzqztoKf/q/1o8qa1h
         i00g==
X-Gm-Message-State: AOUpUlEwa4xDLJORn43TDY35muPQlfmTqrWi4YDk5D4pLKHdF5+V+YVg
        R5d53cAT5Qgu3vFEbmVDe4UZTfz8GedYIgdN6bTE
X-Google-Smtp-Source: AA+uWPwZMz9adrsh5oiJA9Gq9nh2mobDhvKdYg6IB5r4pttFXuhXsNEcWVNuMEQ9jTpt1movrL2yMbn0uZ5/Ob/EY8QH
X-Received: by 2002:a1f:2a86:: with SMTP id q128-v6mr10509548vkq.62.1534184429055;
 Mon, 13 Aug 2018 11:20:29 -0700 (PDT)
Date:   Mon, 13 Aug 2018 11:20:25 -0700
In-Reply-To: <6d6b06e870b5d6dbe9bb88bd80fcce34ba4dcccf.1533941986.git.matvore@google.com>
Message-Id: <20180813182025.14229-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <6d6b06e870b5d6dbe9bb88bd80fcce34ba4dcccf.1533941986.git.matvore@google.com>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
Subject: Re: [PATCH v2 3/5] rev-list: handle missing tree objects properly
From:   Jonathan Tan <jonathantanmy@google.com>
To:     matvore@google.com
Cc:     git@vger.kernel.org, jeffhost@microsoft.com, peff@peff.net,
        stefanbeller@gmail.com, jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> In list-objects.c we no longer print a message to stderr if a tree
> object is missing (quiet_on_missing is always true). I couldn't find
> any place where this would matter, or where the caller of
> traverse_commit_list would need to be fixed to show the error. However,
> in the future it would be trivial to make the caller show the message if
> we needed to.

Indeed, and I'm not sure why the message was there in the first place -
if parsing fails when revs->ignore_missing_links and
revs->exclude_promisor_objects are both false, we print the OID anyway
in the "die" call, so any message printed by parse_tree_gently() seems
superfluous.

It might be better to add an additional commit that removes the "gently"
condition (in other words, always parsing gently), with a message
explaining the above. Also, in that commit, I prefer not to add the
"/*quiet_on_missing*/" explanation (we don't seem to do that in Git
code); I also know that the ">= 0" is a holdover from the existing "< 0"
code, but we don't need to do that either.

> This is not tested very thoroughly, since we cannot create promisor
> objects in tests without using an actual partial clone. t0410 has a
> promise_and_delete utility function, but the is_promisor_object function
> does not return 1 for objects deleted in this way. More tests will will
> come in a patch that implements a filter that can be used with git
> clone.

is_promisor_object() should. If you still have the code you used to
verify that, can you share it? In particular, pay attention to the path
of the repo - promise_and_delete is hardcoded to use one particular
path.

Whether you test in this patch or in the last patch, make sure that the
following are tested:
 git rev-list --missing=error, allow-any, allow-promisor, print
 git rev-list --exclude-promisor-objects

Also, test when a tree pointed to by a commit is missing, and when a
tree pointed to by a tree is missing.

> @@ -152,20 +151,21 @@ static void process_tree(struct traversal_context *ctx,
>  		die("bad tree object");
>  	if (obj->flags & (UNINTERESTING | SEEN))
>  		return;
> -	if (parse_tree_gently(tree, gently) < 0) {
> +	parsed = parse_tree_gently(tree, /*quiet_on_missing=*/1) >= 0;
> +	if (!parsed) {
>  		if (revs->ignore_missing_links)
>  			return;
>  
> +		if (!is_promisor_object(&obj->oid))
> +			die("bad tree object %s", oid_to_hex(&obj->oid));
> +
>  		/*
>  		 * Pre-filter known-missing tree objects when explicitly
>  		 * requested.  This may cause the actual filter to report
>  		 * an incomplete list of missing objects.
>  		 */
> -		if (revs->exclude_promisor_objects &&
> -		    is_promisor_object(&obj->oid))
> +		if (revs->exclude_promisor_objects)
>  			return;
> -
> -		die("bad tree object %s", oid_to_hex(&obj->oid));
>  	}

The missing mechanism (for error, allow-any, print) should work without
needing to consult whether an object is a promisor object or not - it
should just print whatever is missing, so the "if
(!is_promisor_object..." line looks out of place.

In my original review [1], I suggested that we always show a tree if we
have its hash - if we don't have the object, we just recurse into it.
This would be the same as your patch, except that the 'die("bad tree
object...' is totally removed instead of merely moved. I still think
this solution has some merit - all the tests still pass (except that we
need to check for "unable to read" instead of "bad tree object" in error
messages), but I just realized that it might still be backwards
incompatible in that a basic "rev-list --objects" would now succeed
instead of fail if a tree was missing (I haven't tested this though).

We might need a flag called "do_not_die_on_missing_tree" (much like your
original idea of "show_missing_trees") so that callers that are prepared
to deal with missing trees can set this. Sorry for the churn. You can
document it as such:

 Blobs are shown without regard for their existence. But not so for
 trees: unless exclude_promisor_objects is set and the tree in question
 is a promisor object, or ignore_missing_links is set (and in this case,
 the tree in question may or may not be a promisor object), the revision
 walker dies with a "bad tree object" message when encountering a
 missing tree.

 For callers that can handle missing trees and want them to be
 filterable and showable, set this to true. The revision walker will
 filter and show such a missing tree as usual, but will not attempt to
 recurse into this tree object.

[1] https://public-inbox.org/git/20180810002411.13447-1-jonathantanmy@google.com/
