Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C213C433ED
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 09:21:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01FD3613B7
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 09:21:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbhDWJVo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Apr 2021 05:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbhDWJVn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Apr 2021 05:21:43 -0400
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C96AC061574
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 02:21:06 -0700 (PDT)
Received: by mail-vk1-xa35.google.com with SMTP id h130so5181794vkh.11
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 02:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BJ+ov6qy1c9ofZs78qHu2kD5kupRjQbub9etZ4R6BeY=;
        b=KXxAxXctWRreOlVYArXvsBAGRA5OrUzdCbRn5AlIDAYwAgGt1PCOWQyh5hTn3hvYpq
         S6Pp/QcGMUHv5E2IcffBAO1cW72Rl3fP/Zz62BhDhWK5egH+U7qySNe2773wDIUzFu9z
         pTyxYYXVi4pot+9A23DK/uUk156AsHatNXR1lZOdpREauqqIZXWeyB0D6uiwF8KAWQNE
         o4VyPTCs9z+EhAb10cgtyGvMttn+atw400jrZbnqoCEp9A/HBVSQuGB0PM5pYDQ09NUU
         69lBnMAnfjoLaLtqVqP6+HFPFpbHBnEjflzQTsxKWAJe9EjAMOGSnRHwbeecwgbIf9Pm
         7SwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BJ+ov6qy1c9ofZs78qHu2kD5kupRjQbub9etZ4R6BeY=;
        b=OBMetLa04EmPIippsVM8yzEa+OMEkHMU9DEUw76q5EgUEU/qU0LBHFbsfZvv9HGSzi
         lOTr+8itDGkwXKnY2FfxVA26MtzTMX8qvuBTY6g+U3jY1RSphWRZdfMankPouMjZPW4l
         q0L9GfEM5V2MT6CaVAloPNHLAAPYm2sXLn3jBYIElk1eWD/BpeKWQyq1Ga1qplZmOOeW
         /kQbOFF+p6JEacTOly/yYvhFQHKtqL5xXVRLvxOmQc1tEwvSBFb5jVdvBAjjg1aiV4FG
         Q53dBvmNaQ7ErDTQjLcihaMaDqf5xrUTns/nZi/yCdbG03dQBLTO1qJMuN1BmAqUlqs3
         1Q3w==
X-Gm-Message-State: AOAM530gwhnXY2+9tMCJg/2TDwgNp85tRX94Aei0p98XcP4J2mqVvJR2
        JFGqlWkNRUC64Q9pFnszCqWiNUucvSMimProsPyRoQ==
X-Google-Smtp-Source: ABdhPJy1RCgHLdluSmv+qbNsUh7BaR7YfeyiJzV11QEdxEqF8Itw/4hRH0Ep5QgZhEZhaygUMNzyX4lCMdVKeCT+Ps4=
X-Received: by 2002:ac5:c185:: with SMTP id z5mr2337687vkb.19.1619169663258;
 Fri, 23 Apr 2021 02:21:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAFQ2z_Ps3YxycA+NJ9VKt_PEXb+m83JdNB7ujzWw1fTPKyZ=fg@mail.gmail.com>
 <87im4f3l62.fsf@evledraar.gmail.com> <xmqqim4fzier.fsf@gitster.g>
In-Reply-To: <xmqqim4fzier.fsf@gitster.g>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Fri, 23 Apr 2021 11:20:52 +0200
Message-ID: <CAFQ2z_OGv3qNp9jaeuMij5gqv1MoOeb73zH9mOvikLs8dWvmmg@mail.gmail.com>
Subject: Re: reflog existence & reftable
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 21, 2021 at 6:55 PM Junio C Hamano <gitster@pobox.com> wrote:
> If there isn't, then we could do either one of these two things.
>
>  (1) we could add "git reflog create <ref>" and the reftable can
>      record the fact that "reflog exists for the ref, but no ref
>      movement recorded yet".  Then the condition C can be checked.
>
>  (2) we could declare that there is no way to create an empty reflog
>      supported across ref backends, and make the tests that rely on
>      the "feature" conditional on REF_FILES prerequisite.
>
> I have no strong preference.  In the early days I found the ability
> to limit which branches get logged convenient, so if reftable
> backend can learn the similar trick, we would want to go route (1)
> (the convenience largely came from the fact that there was no need
> to add one configuration item per branch, so I do not think we would
> want to bother with branch.<name>.reflog=3Dbool configuration---that
> won't be an easy-to-use substitute).  On the other hand, logs are
> useful, and dormant logs are not costing anything (other than holding
> onto stale objects we may no longer want), so it could be that it
> may not be as convenient as it used to be to be able to turn logs on
> only on selected refs, in which case approach (2) is fine.

Exactly, these are the two options I outlined in my original message.
Both can be made to work. I slightly prefer 2 (empty reflogs don't
exist, and make logging a global switch), because it is simpler to
understand and document. The divergence with the files backend itself
is extra complexity, though. Maybe we could deprecate the behavior and
always write reflogs in the  files backend too.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
