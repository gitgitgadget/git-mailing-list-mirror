Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E183C352A1
	for <git@archiver.kernel.org>; Wed,  7 Dec 2022 00:12:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbiLGAMU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Dec 2022 19:12:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbiLGAMT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2022 19:12:19 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E201731F99
        for <git@vger.kernel.org>; Tue,  6 Dec 2022 16:12:18 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id 65so3405182pfx.9
        for <git@vger.kernel.org>; Tue, 06 Dec 2022 16:12:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DuHC1IN2IBKjF5WPQ2jllrHpGaURHvsA5L1zB4NfPgk=;
        b=ENrJ4HPN/eSxO0oEIVOKvor5CTWF8gNBvj1RRXOeF7K5nh1j1l/AwgXZeLfGtGoRiG
         dFybpMnMdAILF4JrpXsxiscP9T/z5fHme0mdxLqQgoKBoElJYK6xnA48PRkIkCGxapTX
         WAZ4okkMR3LjLpvj4MAsTPa6+osvtkMMTg2nmMrhDXwqq9uAi18XhyKnoYSp7iOoQDDU
         BLqACwykJyjWp4H1URABoqK/sSsEtedrOhqUMfxaFdLvX2J/2jkrPFKB43TFn3ykUNNy
         S1cxJeHxvelMKkK1dusswyQFupPTMrK7IcAnJPsTWlLJ13M5q8mCXdeGcYHAomxxxfB4
         qlVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DuHC1IN2IBKjF5WPQ2jllrHpGaURHvsA5L1zB4NfPgk=;
        b=j38ClcHpjZuonkjG8q+ZODCf8sRSTmPcktkbPGx+yx+VoqfWkUVZjhIIxjYPTkCyer
         Gfu5IN++pulhXGNAMbZrFzl/h3fpK86bf3YJd+r1GPox+LuJ7EyOCJho31DeDi8jZ/I+
         tNUF9CifxeFEYVv+5zVkKH3s49gznYGDr72SL1b405Uqqa03m4ydtwcaYY1j6TNsE/W+
         qdKfZzG/SHJaJMDkNxRXBxhEgz8gLNsxeDEzCzO43DHvuurqYNIkjjINfAlAJ5NqW4TY
         gXTYHgzXqeAl2ZPrLEpaDzFkcGmIpNGa9HiSAe5hGl1trasxePaAlYDcR7jXfFMkwDyP
         49Pg==
X-Gm-Message-State: ANoB5pmSNR4EVM1Vv5qi/MfQUySPmeSrbROs6CiRIMlVNmplhWdOW91j
        apFERL5/wXs0yiDvYiePbBARg/Pd3bxyuQ==
X-Google-Smtp-Source: AA0mqf4YRfh27rcbnvFm4mIrQwK9/YuWQ2A4t0MFzBJ+CukhfOhW+XUpdmJ9fDLaTAs3400YY14Kng==
X-Received: by 2002:a63:fb11:0:b0:478:e97b:7a1 with SMTP id o17-20020a63fb11000000b00478e97b07a1mr3055975pgh.113.1670371938225;
        Tue, 06 Dec 2022 16:12:18 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id i17-20020a170902c95100b00189847cd4acsm13349263pla.237.2022.12.06.16.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 16:12:17 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Karthik Nayak <karthik.188@gmail.com>
Cc:     git@vger.kernel.org, toon@iotcl.com
Subject: Re: [PATCH 2/2] attr: add flag `-r|--revisions` to work with revisions
References: <20221206103736.53909-1-karthik.188@gmail.com>
        <20221206103736.53909-3-karthik.188@gmail.com>
Date:   Wed, 07 Dec 2022 09:12:17 +0900
In-Reply-To: <20221206103736.53909-3-karthik.188@gmail.com> (Karthik Nayak's
        message of "Tue, 6 Dec 2022 11:37:36 +0100")
Message-ID: <xmqqedtc842m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Karthik Nayak <karthik.188@gmail.com> writes:

> Add a new flag `--revision`/`-r` which will allow it work with
> revisions. This command will now, instead of checking the files/index,
> try and receive the blob for the given attribute file against the
> provided revision. The flag overrides checking against the index and
> filesystem and also works with bare repositories.

As "check-attr" was not invented as a user-facing subcommand but was
a hack for debugging, I would have minded this change, but these
days people seem to treat it as if it is just one of the proper
plumbing commands, the new command line convention bothers me a
bit.  No other command uses --<anything> to signal that what comes
after it is a rev.

But I do not think of a better alternative without making the
command line ambiguous, so I'll stop at raising a concern, so that
others who may be better at UI can come up with one.

As to the C API, please do not append the new parameter at the end.
When there are no logical ordering among the things listed, be it in
the members of a struct or the parameters to a function, we encourage
to append, but in this case

    void git_check_attr(struct index_state *istate,
                        const char *path,
                        struct attr_check *check)

we are saying "pick <path>, referring to .gitattributes files from
the index as needed, and apply the checks in check[]", and the new
behaviour is "pick <path>, referring to .gitattributes files from
the tree-ish as needed, and do the same", so istate and the tree-ish
object should sit together.

Also, at the C API level, I suspect that we strongly prefer to pass
around either the "struct object_id *" or "struct tree *", not working
with end-user supplied character strings without any sanity-checking
or parsing.

Another concern, among many existing callers of git_check_attr(),
is there any that will conceivably benefit in the future if they
could read the attributes from a tree-ish?  If not, it may make a
lot more sense if you did not butcher them, and instead introduce a
new API function git_check_attr_from_tree() and use it in the only
place you handle the "-r tree-ish" command line option in the
updated part of the "git check-attr" command.

Thanks.
