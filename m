Return-Path: <SRS0=lL1X=3Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ADDFC35247
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 18:54:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A56E2082E
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 18:54:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gK+PZX5E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbgBDSy2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Feb 2020 13:54:28 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43226 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727331AbgBDSy1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Feb 2020 13:54:27 -0500
Received: by mail-wr1-f67.google.com with SMTP id z9so12226153wrs.10
        for <git@vger.kernel.org>; Tue, 04 Feb 2020 10:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=w68UUPcCczX6frUoBQzuokynq4ZdSs6Y9eLKsVojCVY=;
        b=gK+PZX5EiqO9qarz7hCmjtzTLNl0VGt4/YcqbaatMl6rTetupJU88wHmk08KNxbSoZ
         11ggTxUZ+lK4syWuWd1ZuFFNt2bZ7ed1IJ/1tt82sS9M/q1vSE/xvzfWDu+905Y+oq8K
         NfvSFIEMX8Dca6D0HJy7lrgsDU8U4rlAnwTsx1xSfTE3qXwxG1AfHihCFUnwr01YfFim
         lgsoX2PqsGDzotF/+v+N68ffUa6BkKVXCxJZDxmbVV1NHxROiYI8u6eYNd4PE0pRG1dR
         PfhNKwzu1CdSxA+uEQMt5tYVqKnrCCUpWO/pT7R5TT8VWi12eDRNbG+1q7/DORpieuzW
         yhUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=w68UUPcCczX6frUoBQzuokynq4ZdSs6Y9eLKsVojCVY=;
        b=SNRiFYQs5ebZrfQsWSWoBHIprN5ecVQp/GO0xD0MJt0PZFL9+wtcVPKxSw19CG1vuw
         LV2EGGxhqLeeSanX1yPypgM2cSigYb9DLexBpSA/LK0DWtuRSVpDPieOULVL0Rxwc5ho
         HjT+ODJPVaL3aYmSyKvzjMJOTppVjtbAZAa1jRIKIoTH6wRxWD2+2uxkmU6wNvvw6wgk
         1VkDt4/r9+DDt6CrKKW5ISaft0+89GgMmMbMoL0FBTSz5HW6mB/j0YsTeAkWV6dEFivm
         wpfVpjxJ34rthQSSyAdPnRXvw0fcJmVvkOdrPOmSBvgQDcJOoUFRRJEWLSoOm2oqj2ur
         LPdg==
X-Gm-Message-State: APjAAAVicmELhU+kNPr0nt+HqsHQDid0vuYWWW3dcwWL7CcU3Qguz6pg
        aQec1V0DC5Al8q3Mu/S+Rm/HoO8VZW/h1PammY0mlQ==
X-Google-Smtp-Source: APXvYqwFOsY5CXLDpH85F9HipWgx4/0OU/SkIYXzu/pwSg1kNjzNcEDcRA7yA5q9ZTfRB7CTZqu5BMwMAfJWsqH5dPA=
X-Received: by 2002:adf:e746:: with SMTP id c6mr22238965wrn.323.1580842464302;
 Tue, 04 Feb 2020 10:54:24 -0800 (PST)
MIME-Version: 1.0
References: <pull.539.git.1579808479.gitgitgadget@gmail.com>
 <9138554.c73hJVQVja@mfick-lnx> <CAFQ2z_NkU6ekZkMqZpcFSEr8M3kfw0tiVCB2doHp3QTZtQ8UNg@mail.gmail.com>
 <2165647.H0RpPiDeFZ@mfick-lnx> <CAFQ2z_OgGvX3mFLeWSvEqdfxupRuHN_eFgqENaCRHHpO364_xA@mail.gmail.com>
 <20200130072122.GC2189233@coredump.intra.peff.net> <CAFQ2z_PvKiz==GyS6J1H1uG0FRPL86JvDj+LjX1We4-yCSVQ+g@mail.gmail.com>
 <20200203170555.GB3525@coredump.intra.peff.net>
In-Reply-To: <20200203170555.GB3525@coredump.intra.peff.net>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Tue, 4 Feb 2020 19:54:12 +0100
Message-ID: <CAFQ2z_P0X87bdCTSCXLHrV-M7vb+3BBjVmG+3CzYVY0RUHdKXg@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] Reftable support for git-core
To:     Jeff King <peff@peff.net>
Cc:     Martin Fick <mfick@codeaurora.org>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Jonathan Nieder <jrn@google.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 3, 2020 at 6:05 PM Jeff King <peff@peff.net> wrote:
> >   HEAD - convincing enough for old versions to accept
> >   refs/ - a standard rwx directory
> >   reftable/ - a normal directory
> >   reftable-list - the list of tables
> >   reads/heads  - a file containing "this repo uses reftables. Upgrade
> > to git vXYZ"
> >
> > this would prevent people from erroneously creating normal branches.
>
> That seems reasonable. They could still write "refs/tags/foo", etc, but
> presumably branches would be more common.
>..
>
> PS I don't know if it's set in stone yet, but if we're changing things
>    around, is it an option to put reftable-list inside the reftable
>    directory, just to keep the top-level uncluttered?

I put up https://git.eclipse.org/r/c/157167/ to update the spec inside
JGit. Please review.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--
Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
