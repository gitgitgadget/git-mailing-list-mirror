Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B47A0201CF
	for <e@80x24.org>; Sat, 20 May 2017 10:31:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752623AbdETKbA (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 May 2017 06:31:00 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:32842 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751457AbdETKa6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 May 2017 06:30:58 -0400
Received: by mail-pf0-f193.google.com with SMTP id f27so12107696pfe.0
        for <git@vger.kernel.org>; Sat, 20 May 2017 03:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=KW7SkvyVnJ/6ksIu4gQ7JE4U+LbosfM24SPJRglO1Uc=;
        b=nNlTLHu3XIcQ6ZwTcKat63ahkE6HBdQuUunig07kXEm49ZQr/l75okJpULuhLNeODK
         vfO99mfpz3YxvLm7R35Ug/th1CIAf8ocd5hg0eUSoshWrjD09+Tf8WebpOqCP72plz8x
         4TZUawyklfjmiS0KNUZIOrGcT0F7xUwjh9r3wbwYTKgW+XIN6oilCYNPchZ8MIJA+qgV
         wpETBa0X5tJNkQoOTtxk5L6LBIrlYjWxoN7QKZ3XqIvn8sEqikvI6cAsEvFrjiwHv7wd
         Ggub7GTywlrCydUyYE7GKbDlit1732ifk6WIyHs2LS9VKDS6D4ubtn4XhUblsfB5fN5r
         o1oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=KW7SkvyVnJ/6ksIu4gQ7JE4U+LbosfM24SPJRglO1Uc=;
        b=Q6SsIdDyP/rDYNKkClDvmzbkFZfyZpyhuHf1fumd3md74Bsb1sTUbUIVSclMnMPTjx
         McIqoCHDsMuq5W0aVs7YxTjlE6i5vcL+zqUaXCA/cSzAGhvi4vI/tE3UpXIO9lWnasGf
         Wdv+RwS37nkjYoVPpgQfg+ionW2x6okMKhgVRf+Wvf2xmVYtHabBgpep7IdNLOmUHx+7
         XOOozRQ4/qAdSNQ8byk5lxV0ijYMwvhLvkMlNcKXjxPbywk8iE2lFRmqKBEdDSIisXcJ
         zQbQrWa8zlEBywpq5qGc3apFdb2TDwF3jdI35HiswiHMjUOE7bcqlbtF/KfcqBZQRZb4
         xgEw==
X-Gm-Message-State: AODbwcBiaJYFcIgokb7/wj3b3z5LyQKIBltk2Bq1VxHsQvLRpW/5vEMD
        T5dAzAvGp2gHrA==
X-Received: by 10.99.114.94 with SMTP id c30mr14831743pgn.6.1495276258050;
        Sat, 20 May 2017 03:30:58 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:4027:806a:d2b9:807c])
        by smtp.gmail.com with ESMTPSA id v9sm19798154pfa.43.2017.05.20.03.30.55
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 20 May 2017 03:30:55 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     manishearth@gmail.com
Cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH v2 1/2] refs: Add for_each_worktree_ref for iterating over all worktree HEADs
References: <CACpkpxkGWhcALQZ2+2nOCRKgzAa7U7EjZg--S71zocdGY8NYag@mail.gmail.com>
        <20170518014210.94189-1-manishearth@gmail.com>
Date:   Sat, 20 May 2017 19:30:54 +0900
In-Reply-To: <20170518014210.94189-1-manishearth@gmail.com>
        (manishearth@gmail.com's message of "Wed, 17 May 2017 18:42:09 -0700")
Message-ID: <xmqqy3trstup.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

manishearth@gmail.com writes:

> +int for_each_worktree_ref(each_ref_fn fn, void *cb_data)
> +{
> +	int i, flag, retval = 0;
> +	struct object_id oid;
> +	struct worktree **worktrees = get_worktrees(GWT_SORT_LINKED);
> +	struct commit* commit;
> +	for (i = 0; worktrees[i]; i++) {
> +		if ((commit = lookup_commit_reference(worktrees[i]->head_sha1))) {
> +			oid = commit->object.oid;
> +			if (!read_ref_full("HEAD", RESOLVE_REF_READING, oid.hash, &flag)) {
> +				if ((retval = fn("HEAD", &oid, flag, cb_data)))
> +					return retval;
> +			}
> +		}
> +	}
> +	return retval;
> +}

I would have expected for-each-worktree-ref to iterate over all the
refs in a given worktree, but that is not what this does.  This
instead iterates over worktrees and shows only their HEAD ref, no
other refs.  This helper is somewhat misnamed.

By the way, doesn't nd/prune-in-worktree topic that has been cooking
in 'pu' supersede this change?  It not just protects the commit at
the tip of HEAD in each worktree, it also makes sure the ones in
HEAD's reflog are not prematurely pruned.

Thanks.

