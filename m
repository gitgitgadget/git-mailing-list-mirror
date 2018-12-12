Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FF8720A1E
	for <e@80x24.org>; Wed, 12 Dec 2018 06:16:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbeLLGQb (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Dec 2018 01:16:31 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:33763 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726237AbeLLGQa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Dec 2018 01:16:30 -0500
Received: by mail-io1-f67.google.com with SMTP id t24so13973586ioi.0
        for <git@vger.kernel.org>; Tue, 11 Dec 2018 22:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TTggd3WkW9pb6cE5N+vnmgFw0oT+56m2WpYgRsYz5jI=;
        b=bjvqpuVAvKQE5SHAnTANQlED21/vXW8ibVnzpgsbsPEAeRiTQ1I5tmnb6XdARzvyYX
         veUoO7uDahvcLSyslA9NK27Wxm2GxMof33HFgcWrwpaQPX+Joyb+iorTyQW1NPKN9dvq
         ABJ4sE7lHhwpWlgze9WoycJd7DJ2T1N1Kk3sMhAz4NFeXtbC4wrZ/0nmg+7qvDYCc3U1
         Ny82RrGGUWT4N96qs0TFCwge2n/RrUamx1HbKs5OKNe98dpk974nAhZfpWkrLVym1XDu
         KVvCWoYb//Mrz2ycv37fFoGngXElZIymT+AZERk6H6yJhTnSGdgyPteFnbAj/idpjLd7
         Dw0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TTggd3WkW9pb6cE5N+vnmgFw0oT+56m2WpYgRsYz5jI=;
        b=eCNViWZuaKbAG9WjxyEuGpIh+TR56ov6wNOt/GTe2h8LXOc9uxev+GkUa0S/JOZ7oE
         eQ6So2wWuc5PSrf3SPpFCvVRtQUsEndkqddIM12/kbMc1MxQEXYBLBtNRazFXhYi20In
         jSpe/fokDohUEvbEz1G0Sb8S3wwVAu4dqMkzP4delioZstkIo7MXuu84Ng+oinoh/I1d
         k0Kx4Rn+Mi2FrL9+jFFZCa+WQhqMXtj8LOScZVcJuppODU3blSiO4hMAW1HVcTOf90BL
         S4FG+G6sCqkq5pdHQUx+f+Jo4VI+fV8epH6PIQe/BnE0eU3gbbDgTG8lbOs2n5a7uv+v
         jl0Q==
X-Gm-Message-State: AA+aEWaUf8iY42+QFR4d0X2ajAGbAUuyfvOtGNRP+GkN38Y27pR0woiO
        XwcxA5RHo2OCc9CwZPZiICkz9T2IRpc3nBSrgNQ=
X-Google-Smtp-Source: AFSGD/Ucddqjx59yxZvfzsIrFCDLUVj4g9/KbO3maYEwZ0QmmweLQwPvXBJTmucbcC3s/igE/oPZNx3daK5WR+ufJA0=
X-Received: by 2002:a6b:242:: with SMTP id 63mr15777152ioc.118.1544595389153;
 Tue, 11 Dec 2018 22:16:29 -0800 (PST)
MIME-Version: 1.0
References: <20181209200449.16342-1-t.gummerer@gmail.com> <20181209200449.16342-4-t.gummerer@gmail.com>
 <CACsJy8DQd_DcuogF2Wnj47F6ef26L1dea7M2Yi-ESZ_naQZ=kw@mail.gmail.com> <xmqqbm5sn6f6.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqbm5sn6f6.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 12 Dec 2018 07:16:02 +0100
Message-ID: <CACsJy8C6VuH=hr9JE+AXeqU5V9RwouzZSb5+jV++GHU3myoDTA@mail.gmail.com>
Subject: Re: [PATCH 3/8] entry: support CE_WT_REMOVE flag in checkout_entry
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 11, 2018 at 3:28 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Duy Nguyen <pclouds@gmail.com> writes:
>
> >> +       if (ce->ce_flags & CE_WT_REMOVE) {
> >> +               if (topath)
> >> +                       BUG("Can't remove entry to a path");
> >> +               unlink_entry(ce);
> >> +               return 0;
> >> +       }
> >
> > This makes the path counting in nd/checkout-noisy less accurate. But
> > it's not your fault of course.
>
> When we check out absense of one path, how do we want to count it?
> Do we say "one path checked out?" when we remove one path?

It is still "checked out" according to this non-overlay concept.
Although we could make it clear by saying "5 paths updated, 2 deleted"
(but that may make us say "3 paths added" as well, hmm). Or maybe just
"%d paths updated" where updates include file creation and deletion.
-- 
Duy
