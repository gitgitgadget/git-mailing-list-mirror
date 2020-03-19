Return-Path: <SRS0=WCE0=5E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F979C4332B
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 00:17:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B5472076F
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 00:17:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EVQid3RE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbgCSARf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Mar 2020 20:17:35 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34073 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbgCSARf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Mar 2020 20:17:35 -0400
Received: by mail-ot1-f68.google.com with SMTP id j16so633944otl.1
        for <git@vger.kernel.org>; Wed, 18 Mar 2020 17:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JdsWZrr3+5fCpQJ8mHKHy6bd5BfJDknuzkJMPJAozOU=;
        b=EVQid3REPM3uzhmhMHbAGNXukqIRoN0SRiaS+OjAXdQ5DDLNpQiwrXl1/0T+nO/+V4
         mpej/23HZqSFw1OCPosH7qa1bbONI5Ou+YQlNS7bq23qCHQX7x5wgHh8WnKAqzjfHTIh
         CjSzZcXBsPJH1s4wbpbPWDrgWGypYB+TSq6sAXgrRAnMv7qsYorhPvok7uR+CnepqW3m
         LEXT8bh6UYKGdW4h1EU7neywbINKnTy6e37JwPCtY2hnUaqlygGCfeIGWlAKNx60BxBe
         dCjrkLUuE7zhoawHZsU0f/VqrIdxowQfH2SeX0emeBVyVxgNka11j3BxeIhx4xwFpgqh
         PB+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JdsWZrr3+5fCpQJ8mHKHy6bd5BfJDknuzkJMPJAozOU=;
        b=D3mKfBSFOEvV9NlpZstRNSUqggKUPeN2LlWYriMYpGFJvfuGpAMoKUDLtlHq3khAGz
         +Uk2SLqfHqO2LZgFbsWZvp7v9gMut5qDPEU7Ihvj6+Z1j81ggZY7ZNeoJP8QoDVllhSC
         Lq1Yq4vUSC1mvRu857H7I+4lZLgk9MGnTtWd25IlNYPxYyEO2zj2hquszD35+yaLFQc2
         41qOBWDr9bSY9A8VaxW5lRfTf6puVH2oVc0WJ3Q4HdwaUkQ3ZBZyqYAYD85zBYplH4SH
         uhbuAxp54RvXX7KfzjtCwNDF0vgqkACpJHl1p9G20WwdcYNjFPEaWd6rN4RRsAEywgF3
         JxVA==
X-Gm-Message-State: ANhLgQ2tucqj2+Rdvf2bawGx5G/HMBSsH8UyYCkQPNilurPaMFRNy4Iw
        9ZiMQRPfQMAbWRvSMa47P7ogLm0ZL87WNLdZ8Fs=
X-Google-Smtp-Source: ADFU+vt+2eWn+Jy3afavznyvs4v5llGItJorH2k1hSVCFn7d7o1ZxTpLgio1FqRLPYwHnLi95m/XeCRn6PfE3DAWAGE=
X-Received: by 2002:a9d:6457:: with SMTP id m23mr239629otl.162.1584577054520;
 Wed, 18 Mar 2020 17:17:34 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqpnd9fql0.fsf@gitster.c.googlers.com> <20200318192821.43808-1-jonathantanmy@google.com>
 <xmqqd099fnfm.fsf@gitster.c.googlers.com> <CABPp-BGSvT9zu1xjHUPHBQ3jEktZ56O=m6VNH2v0E-RcfBN_tw@mail.gmail.com>
 <xmqqsgi5dygn.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqsgi5dygn.fsf@gitster.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 18 Mar 2020 17:17:23 -0700
Message-ID: <CABPp-BHM7_+QcpnQe1H4RGz7MmvS07r2Ks+aVzV61DGwYAPvAg@mail.gmail.com>
Subject: Re: [PATCH v2] rebase --merge: optionally skip upstreamed commits
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 18, 2020 at 4:39 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > 4) Jonathan provided some good examples of cases where the
> > --keep-cherry-pick behavior isn't just slow, but leads to actually
> > wrong answers (a revert followed by an un-revert).
>
> That one cuts both ways, doesn't it?  If your change that upstream
> once thought was good (and got accepted) turned out to be bad and
> they reverted, you do not want to blindly reapply it to break the
> codebase again, and with the "drop duplicate" logic, it would lead
> to a wrong answer silently.
>
> So from correctness point of view, I do not think you can make any
> argument either way.

Good point.  Thanks, that helps.
