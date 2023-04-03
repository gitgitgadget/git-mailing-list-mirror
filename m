Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC70CC76188
	for <git@archiver.kernel.org>; Mon,  3 Apr 2023 16:51:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbjDCQvp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Apr 2023 12:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232939AbjDCQvn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Apr 2023 12:51:43 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AF3C1BEE
        for <git@vger.kernel.org>; Mon,  3 Apr 2023 09:51:42 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id u10so28638402plz.7
        for <git@vger.kernel.org>; Mon, 03 Apr 2023 09:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680540702;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=obzDSe12lcqKKJG2vg6kjVyonbI4agqHAmfKPuqT+Lk=;
        b=NsWLZCF0Ct8i3jguXCt0MAWqQYVaQqShO/GUkmQLqFHuZX6U4UR2HGWVNLcQuBrp7s
         au+uvdIstDsaf4Wble3ZkFuXZuJqO9wlGqsArl93GNwg1RdJEbtm89VfPcyAOFTxlXuk
         scjUtMdEOeR7B6rPfg0sl1ez652VGNwzdrWZigGc8KeZuhFmk9yu7+2tKXNeE0kXg6mP
         z8uoyZ+2UvsvnCN65mOyxiw3vHpI5xoQ1fx6ZusawKjW2uDo4Y7mjOM6Vc72oAwMcIEg
         u5C/+zJfr1Uys64LZlGj9vfyPaa0wGzIGTQlr4mm3MMEMDzoEH6Q+ov+DOd1nNIu6Q83
         eLMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680540702;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=obzDSe12lcqKKJG2vg6kjVyonbI4agqHAmfKPuqT+Lk=;
        b=hbg98cvznvMmU8WsaF+65WPRAhwoH2aQDoOjoVQ64+S5MFNmri7fAiwG6Yay/QmNO5
         h0nJFzNoR3FlhCtPONZzg3+e69Pio2p2HYULGiFRQsJTDEeht014DXXLowp+pdbRucEu
         UsZZrODcdqyd1qH34v808ks1dJYOC3oqCczBQnwbuyj8NN5H+/UItYMsEMCXROOZBjmn
         I0wt1RhMXMtMGi9KqgDS+dAjL4OOhk5cKWl3KtVTloU4lo08O22E0vOrdT6wcG6MZvM9
         loQxhUoILAe0dwNNrKr1ff85BFF6W+MOjldjcPJfFTyrVPFAYEPQGkbZY9+PehwTxnfv
         owuQ==
X-Gm-Message-State: AAQBX9fcCXxye2slAdUR5wT9Ot/iwPo1VZbP62VkjLNiOiMfwLfTaRKR
        EGDkIj8E6Euh8xCnS7VjZJiBy3n9JXU=
X-Google-Smtp-Source: AKy350arCgyQB/Nr+dqJnPe1EKICOgMFjyngwqMPszWgWow9txmBU3oxlRLGiSKqxQMykMWsPJvF/w==
X-Received: by 2002:a17:902:c941:b0:19c:e405:4446 with SMTP id i1-20020a170902c94100b0019ce4054446mr2276041pla.30.1680540701722;
        Mon, 03 Apr 2023 09:51:41 -0700 (PDT)
Received: from localhost (254.80.82.34.bc.googleusercontent.com. [34.82.80.254])
        by smtp.gmail.com with ESMTPSA id j11-20020a17090276cb00b0019e5fc3c7e6sm6870721plt.101.2023.04.03.09.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 09:51:41 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Alexandre Garnier <zigarn@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Revision ref '@{push}' not resolved as documented
References: <CAFFOgCUs9d6wJDf3p-+8UkzXRSymCgBctGt+rP+k0CzZPp2LJw@mail.gmail.com>
Date:   Mon, 03 Apr 2023 09:51:41 -0700
In-Reply-To: <CAFFOgCUs9d6wJDf3p-+8UkzXRSymCgBctGt+rP+k0CzZPp2LJw@mail.gmail.com>
        (Alexandre Garnier's message of "Sun, 2 Apr 2023 17:16:18 +0200")
Message-ID: <xmqqh6tw7vtu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alexandre Garnier <zigarn@gmail.com> writes:

> # Push is done with the expected remote, and only then the ref can be resolved
> $ git push
> Total 0 (delta 0), reused 0 (delta 0), pack-reused 0
> To ../myfork.git
> * [new branch] mybranch -> mybranch
> $ git rev-parse --symbolic-full-name @{push}
> refs/remotes/myfork/mybranch

This one is expected.

I think the root cause of this confusion is that the "rev-parse"
command, even with "--symbolic" or "--symbolic-full-name", is still
about answering a question about an existing object name.  If
"rev-parse X" fails because X does not spell a valid object name,
"rev-parse --symbolic-full-name X" is designed to fail the same way.

I am not sure how involved the implementation to change the above
design to be offhand.  The general flow of rev-parse is to feed an
end-user supplied string to the object-name layer and ask it to be
turned into an object name, and "--symbolic-full" must be stopping
that flow after the original string is canonicalized (e.g. 'master'
is turned into 'refs/heads/master') but before it is turned into an
object name, in order to be able to return 'refs/heads/master'.  I
would not be surprised if it wasn't to hard to special case the
"--symbolic" request to yield an unborn branch name like you
expected, but it would change the semantics and breaks backward
compatibility, so care must be taken if anybody wants to pursue
this.

Thanks.


