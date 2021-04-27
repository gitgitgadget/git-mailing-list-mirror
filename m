Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0194DC43460
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 09:20:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C880D61107
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 09:20:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235179AbhD0JVf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Apr 2021 05:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231148AbhD0JVd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Apr 2021 05:21:33 -0400
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B278CC061574
        for <git@vger.kernel.org>; Tue, 27 Apr 2021 02:20:49 -0700 (PDT)
Received: by mail-vk1-xa35.google.com with SMTP id h130so7519294vkh.11
        for <git@vger.kernel.org>; Tue, 27 Apr 2021 02:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=W+nmv3JndNmkliRN2JW7k42YpEzMAA0dEvhmerVoAi0=;
        b=YlaHhnyrHl00vtES5fFpM8ZfLE3pk+UJhxL2mxfNWdZME+BxJ5/xzRVebH9gP/2mmw
         6sNnKbippIKGx0PxbUdhljr0vEFDDvut/khM4GNBAq6f2sRPILECYD123TsHcRZzyps6
         bSMoCDAPNVtUKyKlyLmJizqwrJxTkZlzPtWo9hBJ7ChFMQ4ur3a3+2e3hIyEofKwXEgr
         mVbjGsz4o/WNHyfBuDqx7E+kq9aw5PPMY5wvy4ERPOicDTRyH94U5Sx2S9zls6Yg4t6W
         Ws6i1NL3KI1ZYQHZbNhxhoiil5BAMGUXWW9JKrGnpHE0swPdj8hvD0TyJK5BBsUpjRMq
         1opA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=W+nmv3JndNmkliRN2JW7k42YpEzMAA0dEvhmerVoAi0=;
        b=J/GtfC0I4PNCBV93Jbmu6YxrkSr2VyqMXGuSwg1CxWfBca1AOl+oDSJHHr7bZhLpJ7
         nukzk/1U6F/dq5/+o6zdJ5NVK0N34rCnzxc2bVOnkUu/91MDchailY2fTVoXdGwTl4a7
         9uNgfTJZKEn1ErqVuo2g619GfllpGI1ojkCzva63P6JobeDE2VUE+u13VMn/TzZ3xbQl
         VPCnLy7kv3cQwoPuBCAXRdIiLswnLU48HWBLqSF3Kour6OFayTIi9a/pHwIQOX0Vq8VJ
         l6Ycg1TKYmXTxCwF7kFuJN/waxQqXa19P2PV7WhhBSkxcCZ/P7jyWXhsU0APaQdQK2ov
         iiew==
X-Gm-Message-State: AOAM532av5rg8lQiDKnzqz2F7aUlIH1yrcJNSWa/fLPrelMRqAJhduVk
        GSHtKL/lEZbQaOUMIeneKtihhBZeeXI4m88VMXf03Q==
X-Google-Smtp-Source: ABdhPJxABg7PTZhcY142jAOrYtQN8XrBj8XE0CsNyS4WXwvtQBVHAW1jQLyVTBvuYQKNqKkg3GSE+7Z15o/OKyowY9Q=
X-Received: by 2002:a1f:5e51:: with SMTP id s78mr10599789vkb.19.1619515248790;
 Tue, 27 Apr 2021 02:20:48 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1008.git.git.1618829583.gitgitgadget@gmail.com>
 <ccc26a8950be41e5be4dc78295c66ecbade8a50e.1618829583.git.gitgitgadget@gmail.com>
 <87k0ow2n29.fsf@evledraar.gmail.com>
In-Reply-To: <87k0ow2n29.fsf@evledraar.gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Tue, 27 Apr 2021 11:20:37 +0200
Message-ID: <CAFQ2z_OmjgWd-nrNSOS_QfcfXQ=rNT8_sXymYk6fvLH8iCQ3YA@mail.gmail.com>
Subject: Re: [PATCH 02/18] t9300: check ref existence using git-rev-parse
 rather than FS check
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 21, 2021 at 8:01 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> It seems to me that this breaks the test, to the extent that it's
> testing something we care about at all.
>
> I.e. reading ea08a6fd19 (Actually allow TAG_FIXUP branches in
> fast-import, 2007-08-02) the whole point is to test that a "TEMP_TAG"
> ref is accepted by fast-import, as opposed to "refs/heads/TEMP_TAG".

I've changed it to use the test-tool instead, which doesn't search for refs=
.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
