Return-Path: <SRS0=RPsp=7C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE829C433DF
	for <git@archiver.kernel.org>; Wed, 20 May 2020 17:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B48B920709
	for <git@archiver.kernel.org>; Wed, 20 May 2020 17:20:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UlRyXStj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbgETRUc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 May 2020 13:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgETRUc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 May 2020 13:20:32 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28679C061A0E
        for <git@vger.kernel.org>; Wed, 20 May 2020 10:20:32 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id f134so3251376wmf.1
        for <git@vger.kernel.org>; Wed, 20 May 2020 10:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5UCgcTFXDA6kRRnHtytwyphY29GUI4aC7vtSe7k4uR4=;
        b=UlRyXStjTXuiAJdOEKfxHTMmCPiFyFY3SVlqHKqh5LwPD2eygPCMJMRvBtyEnaMopD
         LGl3w7qU5QSBShIjL8LST03SN6LM2w4Mo7IVpoa+7b0oUd2zYuW0vY+E56y/82HIqFdz
         dqDRTWuNiPm8uD64OFYAyjbfuK5eGK+vujj47OteJikGBKFRJmB97g8JAEreH9Vpf00n
         3YQWewEjl5Hm7KdhvCHiC7fsFBY20qPbT6tYF0RETX8QovLl+/lWu/KPfigbfd2IF5sN
         jTmP5d8gGbD70qg11kPfAYf5SWoNjrfLefuIpMbHxN4vjW+N7fvNHkr1d3vQCnhha/js
         AaWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5UCgcTFXDA6kRRnHtytwyphY29GUI4aC7vtSe7k4uR4=;
        b=jVEbHT+0s4VRigAY0YPAOeSwsD8dhaz9y7hH9T4C64pz9ssqpCQTrcUf0teaBCatgT
         X9ZhfNizj+mviQM1VQ5JxxSWl0PGpqHMeIo0EwZd51bYxclHFu1v7luy2IAxedS1Px6G
         8rHVTJsIDqW5Vzy4yN0yYN00wrzi3HiheY4QDRUiifzZ4BbFt7QjC6QUUasFK4mgxSwB
         8k4SdVoWn8p+yj80tdGHDDQjz/w4eakLziIhRGgDM6aWG5BTys1csChsKxRq5vXbMy97
         fEs05m15bgyxmFhTRCsUqUJ29C6Evft72bQ5vyz4zGAn2eAkK1D7Bzh0MDwhHFKcVzWA
         Ozaw==
X-Gm-Message-State: AOAM530oeuuBH9GmdlgrmkQMIOxsIc6JPYxf4TWQLn9dUmfr2OEZKfib
        8hRQHDgSrx/zuNsJYUp9Pr9BO7slbNdcdoDERAe0AJuDUgc=
X-Google-Smtp-Source: ABdhPJzuXvuzRfk7ixfgJsiSyejTS6Am/qlyWdqtwjX6WB9lJvglHFoozGq/pNJngCUirHewuAgSFmM2/f3mPUSklFs=
X-Received: by 2002:a7b:cd84:: with SMTP id y4mr5368214wmj.2.1589995229555;
 Wed, 20 May 2020 10:20:29 -0700 (PDT)
MIME-Version: 1.0
References: <pull.539.v12.git.1588845585.gitgitgadget@gmail.com>
 <pull.539.v13.git.1589226388.gitgitgadget@gmail.com> <96fd9814a6753e87fb99c6f9d55a0728d3dba6cb.1589226388.git.gitgitgadget@gmail.com>
 <xmqqeerfzitt.fsf@gitster.c.googlers.com> <CAFQ2z_OazuU32Nm3geLCbu_R2u_JKTqCXX0NF35C0=9xV7Ow0g@mail.gmail.com>
In-Reply-To: <CAFQ2z_OazuU32Nm3geLCbu_R2u_JKTqCXX0NF35C0=9xV7Ow0g@mail.gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Wed, 20 May 2020 19:20:17 +0200
Message-ID: <CAFQ2z_P-cf38yR-VyvfDSgPUO_d38mgsi32UkRSPWMZKJOmjZg@mail.gmail.com>
Subject: Re: [PATCH v13 04/13] reftable: file format documentation
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 20, 2020 at 6:06 PM Han-Wen Nienhuys <hanwen@google.com> wrote:
> > > +The `message_length` may be 0, in which case there was no message
> > > +supplied for the update.
> > > +
> > > +Contrary to traditional reflog (which is a file), renames are encode=
d as
> > > +a combination of ref deletion and ref creation.
> >
> > Yay?  How does the deletion record look like?  The new object name
> > being 0*hashlength?  I didn't see it defined in the description (and
> > I am guessing that log_type of 0x0 is *NOT* used for that purpose).
>
> quoting the spec:
>
> "Log record entries use `log_type` to indicate what follows:
>
> * `0x0`: deletion; no log data."
>
> > So, NEEDSWORK: describe how "creation of a ref" and "deletion of a ref"
> > appears in a log as a log record entry.
>
> the creation would be the appearance of a reflog record for the ref.
> You'd have to search back in time to decide if a reflog record it was
> an update to an existing record or a creation.

Correction. This is one of the things that confused me earlier: reflog
entries for creating and deleting branches look like this

    000000000000 -> xxxxx      (create)
    xxxxxx.. xx        -> 00000 .. (delete)

respectively. When the rename happens, we can signal that the deletion
and addition are linked, because they occur at the same update_index.

The deletion records for logs (type=3D0x0) remove a reflog entry at a
specific (earlier used) update_index. So you could have the following
situation:

0x0001.ref : reflog "refs/heads/master" @ update_index=3D0x0001,
new=3Dxxx, old=3Dyyy ...

and then a subsequent table could specify

0x0020.ref : reflog "refs/heads/master" @ update_index=3D0x0001 (type=3D0x0=
)

which would hide the earlier reflog entry.

Jonathan Nieder said that this is used for git-stash, but I have never
understood why this is necessary, and would love to clarify this
better.

I'll clarify the explanation to reflect this.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--
Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
