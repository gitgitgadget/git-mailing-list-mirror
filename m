Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5569CC00140
	for <git@archiver.kernel.org>; Wed, 10 Aug 2022 20:37:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233376AbiHJUhQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Aug 2022 16:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232579AbiHJUhO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Aug 2022 16:37:14 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AF7066A5B
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 13:37:12 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id z20so18656427edb.9
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 13:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=8XVznU1IrlBDzxoZ64kT51FnXPt3TeWL1sVIlKt3pXA=;
        b=EHKwIx2+K4tnOjIQPLcBdSf0zMEC4boKLxr3xiBq9SgWRobRkcTx4zCqmIvc6a5+mb
         PGiijV9hu/4+6Wy1PMIkTM0CUKaVavTP4tBHTApYHPvCIyM5kvRVuk+f9pypeLmZXfbv
         US/DgIgpDrz+Hsxp0t1cZFGBQc+h1PwAq97zVB2UPZo9CmhljOJ2CbcwlaIWq+JSpDlg
         5X1ejFrvXOChBPz4qDUbAzec0jnnSRrm7GKiBnEhNGG6U36nTiNp85xRvWrj126cYb9C
         RRA2qTAH3Q5uo7FNz4MXjeJKXm7EuX6eGysx65H3c/OxfrT51EzCh2JWAS91gEMcOs3n
         OTpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=8XVznU1IrlBDzxoZ64kT51FnXPt3TeWL1sVIlKt3pXA=;
        b=IFFcSaIBndEbi5ScWjcuBoIJru7QTTleZyVy6x4hzK08FI5LkNiWwaEAFrczSr4WSj
         2yLPe9P70XPKo/nMx4e5TOQJDDaxLJEQEQm/ozP4Nj2isHCxgLB2XhVJUWRHPGD8npUJ
         5PXZq0VI5rL52HQqBbqoJ7XmzAoqUuL7t+Lbm/YQ0zKCb0aNqN1nRG4kbktMR4xA2QgO
         ZtDDf2QLyzPA8m+z3c3ho09wo4k7/eaG3DUyn0bWC38KbSyywkOMmodkjiFwZ3yTUWJ8
         9ELiiGPJ8oQJTpPKthE2g6JAMeDNnYWdqurSf1fgOwQbqByB/BHqtKGRnSaSi8nr/Q8H
         QrHA==
X-Gm-Message-State: ACgBeo17oPVY9lTTqweuehRB6d3t1LPtFDHJTpOHLPfoaVYFMcB26Z9K
        f3vEBlmcJGOFE9Df2dBHd4+VvZI3R6TRH851elQ=
X-Google-Smtp-Source: AA6agR7GN6WSogf7Jg7A/rXoZRA3p3VNlkjFvDoaLrKPBC2Qq4wh3mCnHgkx8DMEpXjsEi2PElAL5npjlEnjv2k1sZQ=
X-Received: by 2002:a05:6402:1681:b0:43d:2e92:63d with SMTP id
 a1-20020a056402168100b0043d2e92063dmr28573291edv.253.1660163830893; Wed, 10
 Aug 2022 13:37:10 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1317.git.1660067049965.gitgitgadget@gmail.com>
 <xmqqmtccniw4.fsf@gitster.g> <CAMxJVdH3B2An7La9knM=QJojQ334O+Z2-tqNvqRZz2Eu6CV+-w@mail.gmail.com>
 <xmqqbksrlvyb.fsf@gitster.g>
In-Reply-To: <xmqqbksrlvyb.fsf@gitster.g>
From:   Eric D <eric.decosta@gmail.com>
Date:   Wed, 10 Aug 2022 16:36:57 -0400
Message-ID: <CAMxJVdH-UbCZYp1hcvy4efEYd33jk0bFosJOtag5S4F9-m3-sg@mail.gmail.com>
Subject: Re: [PATCH] fsmonitor: option to allow fsmonitor to run against
 network-mounted repos
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric DeCosta via GitGitGadget <gitgitgadget@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>, git@vger.kernel.org,
        Eric DeCosta <edecosta@mathworks.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 10, 2022 at 3:50 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Eric D <eric.decosta@gmail.com> writes:
>
> > Makes sense. How about FSMONITOR_OVERRIDE_REQUIRED ? The error message
> > could then indicate that remote repos are normally unsupported but
> > that setting the fsmonitor.allowRemote flag overrides this behavior.
>
> I actually think check_allow_remote() should be renamed to have
> "config" somewhere in its name, and return -1, 0 or 1 and not "enum
> fsmonitor_reason".
>
>         static int check_config_allowremote(...)
>         {
>                 int allow;
>
>                 if (repor_config_get_bool(..., &allow))
>                         return allow;
>                 return -1; /* undecided */
>         }
>
> then caller can do
>
>         switch (check_config_allowremote(...)) {
>         case 0: /* config overrides and disables */
>                 return FSMONITOR_REASON_REMOTE;
>         case 1: /* config overrides and enables */
>                 return FSMONITOR_REASON_OK;
>         default:
>                 break; /* config has no opinion */
>         }
>         return check_smb(...);
>
> > If we do as you suggest above, then fsmonitor.allowRemote=true would
> > override regardless of the protocol being used.
>
> Exactly.  The code should not try to outsmart the user.
>
> If the user says they wants to use it on a particular remote, even
> if you do not know if that particular remote system works, just let
> them try and see if it works.  If it does not, they can easily
> disable, because the enabiling was a deliberate act by them in the
> first place.  They know how to fix it.
>
> Thanks.
>

100% agree with you, thanks.
