Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E4EBC4320A
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 00:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E48160F4C
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 00:08:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234370AbhH3AIP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Aug 2021 20:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbhH3AIP (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Aug 2021 20:08:15 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5449EC061575
        for <git@vger.kernel.org>; Sun, 29 Aug 2021 17:07:22 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id h29so14012457ila.2
        for <git@vger.kernel.org>; Sun, 29 Aug 2021 17:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=78nM5CKcU69N3dy4/2SQqwm1GYhN2bS9SRjPmrcX9qs=;
        b=lpBlhHWeXQSZ5oRqQdXzpl4GNSaOrBVnVMtkleHxkwPD7y9kcb45zHKTvKB026KPit
         nKj7EkG+vj8HaxWme2/85NvT/D2JISWGLSYaXo6vUAqFEG2FZWKjWKXLYH3t25neLVHf
         ssj6Z5uTi/d/UbXFX+GD3dkVcnjvUr5JzGIZWoIcBdF6sGpxytbz6AtQXemLl8BZPRjw
         y0UktbDUNqGewNIaxhHeMk2ECnbxqN+bwa5BZmZ71iei46ApuCyuBh5pAZAarx37BlYL
         2D41VwX/GU4wI4emNh8/loWMD0TIxr3/jBzElT+TAmPjARtOS1ZPkKCHf1yA4cPSgxqR
         J86A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=78nM5CKcU69N3dy4/2SQqwm1GYhN2bS9SRjPmrcX9qs=;
        b=iEAnYpXIrhiI4pmCRsMYUrWdaAiRCnEgJchXL7x9GDJdnt8HY3+fDYpaYECDaZaiet
         OZavdkE9denoGokRCySWQL8fTqFzTr3EfGvoRMcyxI6H+iikCxPujzqxwteRHmSe6M0t
         0Lp/WWj++c5DRFE0hIwMTdBDaUgsv0zZ+aXXUlsl9iC0ppCBCnbFuZlxMvRxeGakbjRY
         nTX4I+tfH+DXitXF6Ki+s4DE1Eq8waEfHSXu5rlCxt2uuuT+gQjh7p855BZHKnBPaCcK
         M103LI/b0hVdaRfBg7hgEmSHqjV5/0OEoMq2VsTskiCnNaAGhNl0rzr5sMOQ4UCnjSmq
         uHnA==
X-Gm-Message-State: AOAM5332zRPX/kClyjIgno+1MkMQ6XEuBMLKFPFJRc7v7V5ljUpF8lJL
        2wbhkFqaHeL6jHJZP5/vUXOIWQ==
X-Google-Smtp-Source: ABdhPJw4SRV2rXCR+bD9e6Jmf4KJTB4zIQYnDlpiJd3qKlR9VTnaxRnXEbudlNgzV983ru8IQLaKBQ==
X-Received: by 2002:a05:6e02:78d:: with SMTP id q13mr14548806ils.262.1630282040844;
        Sun, 29 Aug 2021 17:07:20 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id l15sm7455966ilo.22.2021.08.29.17.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Aug 2021 17:07:20 -0700 (PDT)
Date:   Sun, 29 Aug 2021 20:07:19 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org, peff@peff.net,
        dstolee@microsoft.com, jonathantanmy@google.com
Subject: Re: [PATCH v4 05/25] midx: clear auxiliary .rev after replacing the
 MIDX
Message-ID: <YSwhNxqAS8JajA7p@nand.local>
References: <xmqqa6l6oafd.fsf@gitster.g>
 <YSVX18UXh9vX+Zhp@nand.local>
 <xmqqr1eimtrp.fsf@gitster.g>
 <YSVjnSDaBXgXvT9W@nand.local>
 <xmqq35qymrcn.fsf@gitster.g>
 <xmqqy28qlcow.fsf@gitster.g>
 <YSVuUYFh7lmhNlEy@nand.local>
 <xmqqo89jbf49.fsf@gitster.g>
 <YSko4OwwPb7MwEMa@nand.local>
 <xmqq4kb797xc.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq4kb797xc.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 29, 2021 at 03:56:31PM -0700, Junio C Hamano wrote:
> My recollection is that "--object-dir" is mostly about the alternate
> odb usecase---am I correct?

That matches my understanding. The documentation refers to the value of
this flag as `<alt>`, making me think that supporting non-alternates is
a historical accident.

> I wonder if it is safe to assume that in practice a directory given
> to the "--object-dir" option is always the "objects" subdirectory in
> a repository, and it is an error if there is no "config" file next
> to the directory.  Then, we could check ../config relative to the
> given directory and error out if they use different hash.

Maybe... although I have to admit to not being very excited about it. Is
the idea to read ../config to try and check for any incompatibilities
between the in-core state and the target repository's settings? If so,
this seems like a recipe for catching bugs too late.

For e.g., catching the_hash_algo != target_repository->hash would
definitely squash the bug you saw when integrating, but we would have to
remember to update this spot later on if, say, the target repository
started using a different reference storage backend (since bitmap
generation necessarily iterates the references to figure out which
commits should receive coverage).

> I do not recall offhand how careful link_alt_odb_entries() is, but I
> suspect it isn't at all (back when I invented it, there weren't need
> for configuration to switch between hashes, and since then I do not
> recall seeing any heavy update to the alternate odb code).  Perhaps
> we should tighten it so that we check the accompanying "config" file
> first and ignore the entry with incompatible "hash" (and we may
> later discover other trait on a repository that is incompatible with
> the current one)?

Or are you saying you're concerned about an alternates chain which
don't all use the same object format?

If the former, then I would say:

    "Supporting arbitrary --object-dir when invoked from outside a
    repository is a bug that happened to not cause any problems, but
    is surprising, error-prone, and should fall outside of the burden of
    backwards compatibility, so we should get rid of it."

If the latter, then I agree we could and should do better at detecting
it and providing a helpful error message, but I don't see how doing so
now or later would affect this series. Even if we just disallow
--object-dir pointing at a non-alternate repository, we would still have
the issue of having alternate chains which don't all have the same
object format.

So that makes me feel like the latter is a problem outside of this
series that can be dealt with later.

I'm admittedly a little unsure of how to progress here. Given that this
series has received positive review over the complicated parts, it seems
that it is getting stuck on how to deal with `--object-dir`, especially
when invoked outside of a Git repository. My inclination would be to
send a new version that simply requires the MIDX builtin to be run from
within a repository (as well as the cleanups from Johannes).

Does that seem like a good direction forward to you? If not, let me know
if there's another issue that we should deal with first and I'd be happy
to start there.

> Thanks.

Thanks,
Taylor
