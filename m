Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 681F2C12002
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 19:34:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EBD7613C9
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 19:34:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbhGNTgy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 15:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhGNTgy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 15:36:54 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79A62C06175F
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 12:34:02 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id om5-20020a17090b3a85b029016eb0b21f1dso2096218pjb.4
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 12:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=KWs6d9kvwEWWycsEBXJfkvVMVKAExul5XPm7LXd6KU8=;
        b=V+XMW5SPsXKZbWD58h/u+Ul9cf17gp6d04Nk96wwWHNhXFflySHQpA0r+EhiimICtQ
         SdnlK34GvMN412WUHt6ZXM9fGugVZ/BsJCHhEEajGN9nnDVhlNPMrowtAnSfkvKgiz7s
         T0FbdTPwWUKG5bNctyxkfOlDsKpta/72auCB4IyAkzFjggiQp4oysMV/5EENJGmkmIzZ
         ZPK54/6gA5m/qp6bCaXrcPpJ9gyQ0MGmbLVhmOfXEb/AaN+GRpwItUOMUI6G4zaXGjq4
         FknosW7OuOuDliiUek4jfcpFdPKnd3O5BnOsDJDH6WDCfG8iirEJVYdlZDg7DqwcVYVj
         Ui4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=KWs6d9kvwEWWycsEBXJfkvVMVKAExul5XPm7LXd6KU8=;
        b=Q7Yh63MwJD1CNJxjC9x8WnmtOkeDjiWneaY6sNtAQW6DPnLE++e3iVq/80ZkV2XC3d
         YJxvGuGoV1uyEissvUwbp3KJF9Jq4QtfXcsUzCNu/WlSVoQBGXtewyYlrwwnhGj6OwIs
         lJRrG/A9fxQjOrdZLIrBETIxAWZ1NeLpA7axG1zGe+dnqsuUIE8SYCOQ1E+8Pj9MNugy
         c1Dfjj8lTF2y7JdhzS55RsUMf69rIa1iZ30Ayg7JSjtAqyV7igMCHhWC2txTRK93USxP
         hiNY3Bm8vkuIiONBxV+ltPS91KmhcxpxOqmXLMCE2l31sdNGRRQzMSihpQ0R+Ra+roli
         GivA==
X-Gm-Message-State: AOAM530L+aHGcwSDUW07F28oGyNQwSvpzct8SJF3gDTnAIjQJ20rm5g8
        6MxvoYFye4PYn2Jmp2rzrbQJMUFqbFmH5HTzErGk
X-Google-Smtp-Source: ABdhPJyglkqxHwnVjjdR1ViYR7jsQD30e6sEGXXVKy/aCW/yO//TuUaA7CImf+5+IOd2JDD38L60BH6zSrzsbJyXf6Nt
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a62:30c5:0:b029:31e:fa6d:1738 with
 SMTP id w188-20020a6230c50000b029031efa6d1738mr11429619pfw.55.1626291241955;
 Wed, 14 Jul 2021 12:34:01 -0700 (PDT)
Date:   Wed, 14 Jul 2021 12:33:59 -0700
In-Reply-To: <YO4UIGQPugvHcYrw@google.com>
Message-Id: <20210714193359.4083725-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <YO4UIGQPugvHcYrw@google.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: Re: [PATCH 2/3] send-pack: fix push nego. when remote has refs
From:   Jonathan Tan <jonathantanmy@google.com>
To:     emilyshaffer@google.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On Wed, Jun 23, 2021 at 03:30:52PM -0700, Jonathan Tan wrote:
> > 
> > Commit 477673d6f3 ("send-pack: support push negotiation", 2021-05-05)
> > did not test the case in which a remote advertises at least one ref. In
> > such a case, "remote_refs" in get_commons_through_negotiation() in
> > send-pack.c would also contain those refs with a zero ref->new_oid (in
> > addition to the refs being pushed with a nonzero ref->new_oid). Passing
> > them as negotiation tips to "git fetch" causes an error, so filter them
> > out.
> 
> So here we are filtering those redundant refs on the client side?

Yes, but I don't know what you mean by "redundant".

> > @@ -210,6 +211,7 @@ test_expect_success 'push with negotiation' '
> >  	rm event &&
> >  	mk_empty testrepo &&
> >  	git push testrepo $the_first_commit:refs/remotes/origin/first_commit &&
> > +	test_commit -C testrepo unrelated_commit &&
> 
> So now we are asking 'testrepo' to initially advertise that it also has
> unrelated_commit, which we don't care about, and expect to work fine
> anyway. Ok.

Yes.

> Seems reasonable enough to me.
> Reviewed-by: Emily Shaffer <emilyshaffer@google.com>

Thanks.
