Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 565391F97E
	for <e@80x24.org>; Tue,  9 Oct 2018 09:27:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbeJIQnX (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Oct 2018 12:43:23 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55078 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbeJIQnX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Oct 2018 12:43:23 -0400
Received: by mail-wm1-f65.google.com with SMTP id r63-v6so1097326wma.4
        for <git@vger.kernel.org>; Tue, 09 Oct 2018 02:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=B5bjzuKVuAl2xmuXdYPLHHfGYpaPm/ugKKv/QizKg9k=;
        b=H9wWOSSG+JkcbYCozDo60D34LqLaz0JNZhMyh7H87wmPj3Vqh7d0TCWAg8KA/DipqX
         haFC/ot3XsDD8l28ihKx134g6tfUGP1FguQgxl8xghA5HM3coaaD5vtS+YbmMJienLol
         OuI4WTsjkfm7/2ei1f5BloZ/QJ+40qDIbQYYMVoOEIwIYSVwhWMKHwdiDM1A6+DTeCgO
         s7srAUF6ws0EaA1WVHbMsB5E9b0+MI3L0R3cd1kIxTQhnk17JfzckyItY/DzQIK1Pvbe
         8xJEFHdfU3y23L1LHVWzADX/Zafwot7pBETq4uN0FPQstQM+ZGWEIVsG8Iq3ckuBUEYM
         se+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=B5bjzuKVuAl2xmuXdYPLHHfGYpaPm/ugKKv/QizKg9k=;
        b=rlLAqHoM8ZI+KOw2NrKQCriQjox1aHsdg5HEi/62BffU4QCTu40/80I6CWULKzplYx
         23dSPVQDRpQRtmEkLVTHcfqpdBx8EBh4diHMyvFebGhgKPkjb6ecJ6cqTvbOOFBPxCHq
         7dF0GOfOGWlTiLkcl8XLp0CdnqE1slYEuNf1c0GorqDYGRk0GNHYZsjZFBt0jONZW3UN
         EHGDLCU3uCPH1+pwet8Kj48hFN0JXfU9uKxGI4UQz91nHiRK50md/r8In7EeRabevg5v
         bSzSq9b8U9rVXW+KoxhYyrrUO263g3HsGJUfEI0eARkWDSjp532Ub1VhgWkr121/wn1v
         w3UA==
X-Gm-Message-State: ABuFfogee7PFg2Zd61nl0D4yVBnyarVvvnyGG259skdsSSKDc9FgGbQu
        zB2evB+GhDBBOA/W5ZfEqEQ=
X-Google-Smtp-Source: ACcGV61SJUY/uf9GlcyEeGp2bvx8QuC/mMjVhZw8BAK1k4iIFWyaDxerssn78UtZ1klw8pToyErbCA==
X-Received: by 2002:a1c:89cd:: with SMTP id l196-v6mr1231995wmd.7.1539077242618;
        Tue, 09 Oct 2018 02:27:22 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id e142-v6sm39721447wmf.20.2018.10.09.02.27.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Oct 2018 02:27:21 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] unpack-trees: allow missing CE_SKIP_WORKTREE objs
References: <20181008214816.42856-1-jonathantanmy@google.com>
Date:   Tue, 09 Oct 2018 18:27:21 +0900
In-Reply-To: <20181008214816.42856-1-jonathantanmy@google.com> (Jonathan Tan's
        message of "Mon, 8 Oct 2018 14:48:16 -0700")
Message-ID: <xmqqtvlvpj0m.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Because cache_tree_update() is used from multiple places, this new
> behavior is guarded by a new flag WRITE_TREE_SKIP_WORKTREE_MISSING_OK.

The name of the new flag is mouthful, but we know we do not need to
materialize these blobs (exactly because the skip-worktree bit is
set, so we do not need to know what's in these blobs) and it is OK
for these to be missing (to put it differently, we do not care if
they exist or not---hence we short-circuit the otherwise required
call to has_object_file()), iow, the name of the mode is "A missing
object with skip-worktree bit set is OK", which makes sense to me.

>  		if (is_null_oid(oid) ||
> -		    (mode != S_IFGITLINK && !missing_ok && !has_object_file(oid))) {
> +		    (mode != S_IFGITLINK && !missing_ok &&
> +		     !(skip_worktree_missing_ok && ce_skip_worktree(ce)) &&
> +		     !has_object_file(oid))) {

For a non-gitlink entry, if the caller does not say "any missing
object is OK", we normally check has_object_file().  But now
has_object_file() call happens only when ...

Hmph, isn't this new condition somewhat wrong?  We do not want to
skip it for entries without skip-worktree bit set.  We only do not
care if we are operating in skip-worktree-missing-ok mode and the
bit is set on ce.  IOW:

	if ((skip_worktree_missing_ok && ce_skip_worktree(ce)) ||
            has_object_file(oid))
		/* then we are happy */

but the whole thing above tries to catch problematic case, so I'd
need to negate that, i.e.

	if ( ... &&
	    !((skip_worktree_missing_ok && ce_skip_worktree(ce)) ||
             has_object_file(oid)))
		/* we are in trouble */

and pushing the negation down, we get

	if ( ... &&
	    (!(skip_worktree_missing_ok && ce_skip_worktree(ce)) &&
             !has_object_file(oid)))
		/* we are in trouble */

OK.  The logic in the patch is correct.  I however feel that it is a
bit too dense to make sense of.

Thanks, will queue.
