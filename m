Return-Path: <SRS0=4+BP=3K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84508C2D0CE
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 16:37:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53D6122525
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 16:37:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HjowEtw+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729017AbgAUQhr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jan 2020 11:37:47 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36580 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbgAUQhr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jan 2020 11:37:47 -0500
Received: by mail-wr1-f65.google.com with SMTP id z3so4009246wru.3
        for <git@vger.kernel.org>; Tue, 21 Jan 2020 08:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NLCBD1I8mz2WEC0Vpj1/TQCBpA5l0Ho5hG4h8YX0F6o=;
        b=HjowEtw+VSX0YklH+Nw0lS4cMZNM66G4BbUCjpdT/nG3w0jyAQarcjry9QMTzt0MTg
         O7dI1D0PtMHhLlNoIpQsAfbDIepe2NNQyUpFdaWmNkkGBTjrbKytB2LQKhgbSZ4O7abg
         EXNkx+uPCpOhTRwA2mFlXTwAeJd6Y4aZ6EtHrjrNqiblacAJVWjjXJut+fFwfyDzy9Yw
         fTMoPUAj5Rf0z2/wpGFbK8X3xD51F4BGNhv2sOdpWxPT3dTG40LJMWuPkLqWzqn2oPav
         E3OboUlfapRsYFejinClAwK/6E0gBf9+r8+gJ8RkV5Y4ORSMBS7Vnrn4PLnPfJ1Em5dM
         N6eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NLCBD1I8mz2WEC0Vpj1/TQCBpA5l0Ho5hG4h8YX0F6o=;
        b=Px184lKL4lKMBcWJa6O+y1Z9GyiaQz2UKrXTlaUkWB5rdEj/QoJW8YpsVk46IzTiPT
         EhejsNyJq9eEWt1aRwZKHv8w2VX8itS61lPnLi/38HLJ0tAp2Rk5f0Z2ueKo9vwd3VR7
         MLVHT6PsoeeOnb9eEwivvgKMs+5m0U72Isn5fKaz9kySQE6n6MxPj2J/JHLR9Al6hG0i
         JmBPlkgt7Q+L24GX9VThQZqRsae8j6tolItArXepf3yI+pxy1Bg7w8JqA8vEAKdB4nQW
         tRFf69bR5oDZtabqMl57NM7PZjOUtT6xIYofzR/SwDocGyj47Qmf6N5o79Op4zrnggqM
         73Ug==
X-Gm-Message-State: APjAAAUaBIWQP8OXd0ItudNPwykiR718aZIfz3kQSZ/61Y0lyQcJFXRU
        UE9r7UvioMhRrODkiKLd1997wJByFh6np9ZN1ZU=
X-Google-Smtp-Source: APXvYqzjhMLUylS/Rbq7uV9QNPrzNzk2q/60gzvUkR1RDL4d9SeemgwCqNu3GXdP0dEk0l29FvXJix2NR496+s4LJsg=
X-Received: by 2002:adf:f28c:: with SMTP id k12mr6309334wro.360.1579624664983;
 Tue, 21 Jan 2020 08:37:44 -0800 (PST)
MIME-Version: 1.0
References: <CANsz78JyawDpp_SewRQp4_AbZVduSYiazhvCqUcqUV810az5MQ@mail.gmail.com>
 <20200118145318.5177-1-shawarmakarma@gmail.com> <xmqqftgcd55s.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqftgcd55s.fsf@gitster-ct.c.googlers.com>
From:   Eyal Soha <shawarmakarma@gmail.com>
Date:   Tue, 21 Jan 2020 08:37:33 -0800
Message-ID: <CANsz78J93XynUJkBvvdD=BfXPQ-Wq17uzqPi3opMAPPKbt2Rwg@mail.gmail.com>
Subject: Re: [PATCH 1/3] color.c: Refactor color_output to use enums
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 18, 2020 at 9:51 AM Junio C Hamano <gitster@pobox.com> wrote:
> Please downcase Refactor; that way this change would not
> meaninglessly stand out in the "git shortlog --no-merges" output.

Sure, no problem.

> The blank before your sign-off means all the times spent gets
> discarded, which is not exactly encouraging to the reviewers.

So I should make a better description for the patch?  Sure!  What
should I put?  It's kind of hard to get a good description that
describes the refactoring without digging into the reasoning behind
it, which is in the follow-up patch.  What kind of description should
I give?  How about like this:

    color.c: refactor color_output arguments

    color_output() now uses a more descriptive "background" argument
    instead of "type".

    Signed-off-by: Eyal Soha <shawarmakarma@gmail.com>

Suits?
