Return-Path: <SRS0=24D7=6H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 625D2C54FD0
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 21:27:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3243B20776
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 21:27:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eEh1+YZ6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726071AbgDWV15 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Apr 2020 17:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbgDWV14 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Apr 2020 17:27:56 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FDF1C09B042
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 14:27:54 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id e26so8211400wmk.5
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 14:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RAiry45WqT2j3HWyn3ZDU6DOG6l4wz1ACSU2wCQfGe0=;
        b=eEh1+YZ6pOuuZ+y7ub/4XXGt/4Lj1HnY5o4JKZXZrGSlT9PyDSNSb2XZAtfAPIBx56
         WqOKgHLwnYltiYSqQMEEeYzWSNvjSI5hWYv+2Fyf/gSycYrr6hJPiNo6tj4KJElnLnSe
         EyiimL0CCei3/1S8+lR9okKN4vessWTwagts1iMwxhgyql1zCVaIiKg1N6HkBHD5PFqU
         eVN6hu+3AKXRw1wOKmDWs+tWi0hIANpyARqkZ7Socoj/dr2ccCbHsuXYa7bZsy0jlHSj
         gPZtVXULxbItlDCLM80hKLNVH9D/ics1ktMRuOo3AjC6Ld1rHbVQwSjENT+RmMWyE8HH
         2X3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RAiry45WqT2j3HWyn3ZDU6DOG6l4wz1ACSU2wCQfGe0=;
        b=VsaLpmSO+zmGOwFRJ5ubpPiRNwc5e7vzMxoSRTkoxUgwfchf28UX11Nk+JQmmPEFw0
         fG3ZQeHWRt9a+Lrnt+SE4j2ZFKPgCDEubhqWG1ebjgwEOMt+jwbZXLvLdujtmIDXGav7
         PhJDGh6PJe82ZcZCO8aa1tnhj2DIAwF8nVk7Xab4noSPCSZA/ZrNO+jcdV4K7ON0ZtH5
         AQaVTwzEk/ld0HxltnPek9ZoGPeryL58LznYTswy/W6ub/kGd+Zmw8jVe0sHg6fWcmG8
         DHjzhLQa8xIf4NS2MEa2nHkApfYjE0o4FXgzxsDyO7sjei6MpCE9TN3yXnCeBedjthsY
         nQOQ==
X-Gm-Message-State: AGi0PuZuePyEgLNuGpND/gg3hWzoEeobDUjO1uB36WviY+C5ABV/I4kF
        Dg0+gP55zNOZhJYBHVinPGOl0KinTgTcsGeXYlfLBQ==
X-Google-Smtp-Source: APiQypLaefoDRjJLdUSeat+ADRgKd2NT1OGGTeQiVeHtKtTBYzM+WU9ZgkJQbZ83/YddNBiB+Vr8Y+8a6t6leBuZ9rY=
X-Received: by 2002:a7b:c14b:: with SMTP id z11mr6079387wmi.44.1587677272637;
 Thu, 23 Apr 2020 14:27:52 -0700 (PDT)
MIME-Version: 1.0
References: <pull.539.v8.git.1585740538.gitgitgadget@gmail.com>
 <pull.539.v9.git.1587417295.gitgitgadget@gmail.com> <xmqqmu74mwaw.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqmu74mwaw.fsf@gitster.c.googlers.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Thu, 23 Apr 2020 23:27:40 +0200
Message-ID: <CAFQ2z_OhWDzc40WMy=bwUKRJQ4rcvnFmYvk-ga_cTtCjviMoBg@mail.gmail.com>
Subject: Re: [PATCH v9 00/10] Reftable support git-core
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 21, 2020 at 10:14 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> >  * what is a good test strategy? Could we have a CI flavor where we fli=
p the
> >    default to reftable, and see how it fares?
>
> I do not know if the current tests are prepared for it yet,
> e.g. there may be places that say "cat .git/refs/heads/master" and
> do something to its contents.  But I think that it is a good goal to
> shoot for to make sure we can run all the tests with reftable
> enabled.

Obviously, it would be nice if all tests pass, but that doesn't seem
very realistic.

hanwen@chiquinho:~/vc/git/t$ grep '^ok' log | wc
  18457  154017  896360
hanwen@chiquinho:~/vc/git/t$ grep '^not ok' log | wc
   3416   39825  228427

I expect that the bulk of this number reflects a (hopefully) small
number of bugs in the reftable glue, but there are many tests that do
things that are just not compatible with a more abstract ref database.
For example,

not ok 10 - check rev-list
#
# echo $SHA >"$REAL/HEAD" &&
# test "$SHA" =3D "$(git rev-list HEAD)"
#

What is the right way to approach this? Should the test use

  git update-ref HEAD $SHA

instead of writing to the loose ref? Or should we skip it in case of
reftable? Similarly

  git update-ref $m $A &&
  test $A =3D $(cat .git/$m)

My suggestion to leave these tests as is, but skip them if they can't
work for reftable. However, this needs a new primitive in the test
library; what should that primitive look like? Maybe a function, eg.

   test_expect_succes_skip_reftable

or similar?
--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--
Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
