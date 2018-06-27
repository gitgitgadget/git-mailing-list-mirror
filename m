Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA94B1F516
	for <e@80x24.org>; Wed, 27 Jun 2018 22:51:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751410AbeF0WvJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Jun 2018 18:51:09 -0400
Received: from mail-yw0-f202.google.com ([209.85.161.202]:38802 "EHLO
        mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751391AbeF0WvI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jun 2018 18:51:08 -0400
Received: by mail-yw0-f202.google.com with SMTP id q128-v6so2926208ywe.5
        for <git@vger.kernel.org>; Wed, 27 Jun 2018 15:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=W5WpUMFMBDQ7LA/c4esaRGiMjniJ+nPjlJ8vBVBe0XA=;
        b=vb7moYfYqkCGuS5W6nqcdZ3aZw837CrYZrvzmJHQ/k6ahckW1b9aaGu+T3KRW/VkV/
         8DBbCMgf2YYOOOdztE7HO8y046GwgNWjtSPbjTva+Lwmg+QWc1JxCKD0ak515sPOpKz+
         LbDKpYLTys3zfs2u/vLiELFWZ41smJsWssLi6iq3x/1gzSgM3NZUefgbjlHpbZcpZNV0
         b5M17P/WaqRTP1eJp3T3LnbfKX4CsF80THHvqRK0cG1yorZECm8z1b/Sx3zatSc2yiNk
         j4erwik1UaiNwn57VcHxH1xjzP51uWglKXqaQNpdCdVNiQjaVm2n+D7ymqOqvqvBmfkb
         1ufQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=W5WpUMFMBDQ7LA/c4esaRGiMjniJ+nPjlJ8vBVBe0XA=;
        b=EoQXlvNLpiXi7gXIFbUTFvUKLeZADu57+rinDOz345KXjc9xp+AUYEuiN1/xEETgLX
         YuTeqBlLDBJf6h5YJn0yLph7ig2Y3as3UnlSQK3v1Bt6uaWPMjwcnSKsRe/V6PrGEUcr
         bH0/YDompjV/VC6UkAlzu/PPJhBfmbBnSSssQSum+AISVjIG5vAbNYbX7SilNNXMzMn8
         +A2iegElsYvXiyte1DPmtpKAxDI8KZHNoAs4Tl1Esv5b+I8FNY02dSUpozeIwqcSE/z0
         mXdO71qzCN8h6sbfh1e3wZDwnuUgyiVhVvO2+bjy1X6PvH5rKWqyZuQ+fyfefdX2e4Oi
         Wa2A==
X-Gm-Message-State: APt69E3POBLvth39ib9GqIgwbWWIBgMbDP3MGHkRoAYdQkrxdszZwK3l
        yLyZ34QGxiizfFiFUiqZu3rd89ddMW4SZHpgFGg5
X-Google-Smtp-Source: ADUXVKKnX2gHhIxYlbKLWjnlJO6/vj2SoMPjKuOnqcpq4RRokCPwPQwRq/kxn0BU6jFUr0ZG3U8eT8AuauSdpyMXdlkG
MIME-Version: 1.0
X-Received: by 2002:a25:e80d:: with SMTP id k13-v6mr2243440ybd.32.1530139868026;
 Wed, 27 Jun 2018 15:51:08 -0700 (PDT)
Date:   Wed, 27 Jun 2018 15:51:05 -0700
In-Reply-To: <xmqqa7rgdlwf.fsf@gitster-ct.c.googlers.com>
Message-Id: <20180627225105.155996-1-jonathantanmy@google.com>
References: <xmqqa7rgdlwf.fsf@gitster-ct.c.googlers.com>
X-Mailer: git-send-email 2.18.0.rc2.346.g013aa6912e-goog
Subject: Re: [PATCH] fetch: when deepening, check connectivity fully
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Jonathan Tan <jonathantanmy@google.com> writes:
> 
> > +test_expect_success 'shallow fetches check connectivity without stopping at existing refs' '
> > +	cp -R .git server.git &&
> > +
> > +	# Normally, the connectivity check stops at ancestors of existing refs.
> > +	git init client &&
> > +	GIT_TRACE="$(pwd)/trace" git -C client fetch "$(pwd)/server.git" &&
> > +	grep "run_command: git rev-list" trace >rev-list-command &&
> > +	grep -e "--not --all" rev-list-command &&
> > +
> > +	# But it does not for a shallow fetch...
> > +	rm -rf client trace &&
> > +	git init client &&
> > +	GIT_TRACE="$(pwd)/trace" git -C client fetch --depth=1 "$(pwd)/server.git" &&
> > +	grep "run_command: git rev-list" trace >rev-list-command &&
> > +	! grep -e "--not --all" rev-list-command &&
> > +
> > +	# ...and when deepening.
> > +	rm trace &&
> > +	GIT_TRACE="$(pwd)/trace" git -C client fetch --unshallow "$(pwd)/server.git" &&
> > +	grep "run_command: git rev-list" trace >rev-list-command &&
> > +	! grep -e "--not --all" rev-list-command
> > +'
> 
> Hmph, don't we quote these in the trace output, requiring us to grep
> for "'--not' '--all'" or somesuch?  

I thought so too, but this was changed in commit 1fbdab21bb ("trace:
avoid unnecessary quoting", 2018-01-16).

> I do not think of a better way to do the above without a huge effort
> offhand, and the approach taken by the above may be the best we
> could do, but it looks like quite a brittle test that knows too much
> about the current implementation.  "rev-list $new_commits --not
> --all" is a so very common and useful pattern that it is not all
> that implausible that we may want to come up with a new option to do
> so, or more likely we may want to do that with an in-process API
> without spawning an external rev-list (hence making it impossible to
> observe via GIT_TRACE).

I agree. The best way to do it would probably be to intercept the fetch
response and substitute an empty packfile for the packfile returned by
the fetch, like the one-time-sed mechanism [1], but I think that it is
outside the scope of this patch.

[1] https://public-inbox.org/git/afe5d7d3f876893fdad318665805df1e056717c6.1485381677.git.jonathantanmy@google.com/
