Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EA56C433EF
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 19:31:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 023CE60EE4
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 19:31:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240807AbhJGTdw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Oct 2021 15:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232829AbhJGTdv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Oct 2021 15:33:51 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7897DC061570
        for <git@vger.kernel.org>; Thu,  7 Oct 2021 12:31:57 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id h7-20020a056a001a4700b0044bae446a52so3461617pfv.16
        for <git@vger.kernel.org>; Thu, 07 Oct 2021 12:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=hlp1aSSUv5uUwuHcuJR36Gv8NwY0k2f7dAta7cR6GNM=;
        b=S6Y/8hNEaHi7cUEEQSzSDSJLKZGZScQ8EmLB796k9zyLZan11sqAq35fn20OdXoJ5H
         ceNtRDUfAghpCJRZxWvpbBXmNoYGhYqwKyq4fW4f8iucPikcJaY7Aii9LIrVV5/vdady
         QTBbVr/D87IAV+HPY3K8t1Exo7Dd51lvlxTYPvcrPBQBOWRmf65Hp/Wk5EL6b2k7HaSb
         copJ0/2xAJ9JwIPMut14H4rviPlGXyRdjsQEKhMUxhDQrNkuFs8pEjpJNoxOIwH0zAhV
         l3PJoXo2i0NjtmV6h9V/tNqJJ56pLXp+Apu03GFtxlBRBTURk2BkXI3ntbtnqfGRKFv3
         5RyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hlp1aSSUv5uUwuHcuJR36Gv8NwY0k2f7dAta7cR6GNM=;
        b=PT8HUhstBjSJrIex33uwn+W553VTiSrWvlevp8B/XJnEehskbaeDb6e2qWRVuzUHuB
         gBe/sMpzJ6t2TVCoFrLswOrhzb4vpv0p6LkfOBDmBYW1M+zJajITZOOzcL1YKNScmUYu
         lCJlSfEXauNQJWRpgm0/yOmXl6VX6CFoRh3M2TY7lthZmeS8rlWPTVwJbhqbhUh0oCfU
         7bDeFds3tvMrcHk2ESQZv7NCPqAQg4awuXBxUk+j+HMgwyAJmkgtJllu3ofgcV4MXPJO
         bZG1Y+H93JNQ4tCxdsa1ESZlkZl3bxhRXJ9aMgDGVLH2QfAj+MpuD2BF4ER7WaJ3L2aS
         Zucg==
X-Gm-Message-State: AOAM5315ZbmY5AK3GvLwrP1Wr+1o1BG7Uf2xzWnva2V8jwMQjJ5KVsFM
        Ad5EqRoCaxxUF53nyIixUMffoh3lVLLrnA==
X-Google-Smtp-Source: ABdhPJwk6npV5n+H+v9hlVjQmVJMhE7NECSBPACmrN+QmQsK82URqQSoAFbLBrODN9US6g6qWGkXkitwBmR3wg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:9689:b0:138:d2ac:44f with SMTP id
 n9-20020a170902968900b00138d2ac044fmr5534306plp.85.1633635116982; Thu, 07 Oct
 2021 12:31:56 -0700 (PDT)
Date:   Thu, 07 Oct 2021 12:31:49 -0700
In-Reply-To: <c8799d408f2a3b4421db14d756540f287e17b3d1.1632956589.git.jonathantanmy@google.com>
Message-Id: <kl6ly274y6l6.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <cover.1632242495.git.jonathantanmy@google.com>
 <cover.1632956589.git.jonathantanmy@google.com> <c8799d408f2a3b4421db14d756540f287e17b3d1.1632956589.git.jonathantanmy@google.com>
Subject: Re: [PATCH v3 2/7] refs: teach arbitrary repo support to iterators
From:   Glen Choo <chooglen@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> @@ -1139,7 +1142,7 @@ static int should_pack_ref(const char *refname,
>  		return 0;
>  
>  	/* Do not pack broken refs: */
> -	if (!ref_resolves_to_object(refname, oid, ref_flags))
> +	if (!ref_resolves_to_object(refname, the_repository, oid, ref_flags))
>  		return 0;

Nit: It would be nice to have a NEEDSWORK the explain why the_repository is
hardcoded instead of the commit message. Without having something in the
code, it is a little surprising to see the_repository when we are so
close to removing the_repository from refs/ altogether.

This in the spirit of your check in patch 3, where we explicitly warn
readers when non-the_repository is not supported.

  +	if (iter->repo != the_repository)
  +		BUG("peeling for non-the_repository is not supported");

