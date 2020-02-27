Return-Path: <SRS0=G+lC=4P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5819C35677
	for <git@archiver.kernel.org>; Thu, 27 Feb 2020 17:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CA862469B
	for <git@archiver.kernel.org>; Thu, 27 Feb 2020 17:57:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qRwHAVTM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729891AbgB0R5G (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Feb 2020 12:57:06 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33471 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726877AbgB0R5G (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Feb 2020 12:57:06 -0500
Received: by mail-wm1-f68.google.com with SMTP id m10so7543632wmc.0
        for <git@vger.kernel.org>; Thu, 27 Feb 2020 09:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jQLWxEbJDtRFFN8KjkSfZ6KL5gSw2vvnlxhLDIOqT2o=;
        b=qRwHAVTMBl2yMtQy2n/QuzGAnG7QN+Yvx46TYk1lNOiTRCgT/Jn0DMuv7JXvyA1RyU
         XCcE1MtdrfcpgIfolT9Q2bZuL4MDhRbKTiVr/HxT3HkUtg2u31VJhUK1Kr+A9P/muMjS
         aAJxq51fxGD5qpnHiBCP41tdF5Je7RRiFwNQ4rifNghr6Nsqzvp3ED7oEH48l0lDRdtC
         ygxfOdnhfFmZScEa63aJvZfO/fWdgo4e4j87u4z2JTpkC/590WKN1Ptzr5Mj07DTtVwe
         C5oRpwOT8O30SwVoaASmw7vtDCxB9cpTwj/nkwmF/H1JdmCekjpWLBfqJwj+Xc7uZJc4
         a7UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jQLWxEbJDtRFFN8KjkSfZ6KL5gSw2vvnlxhLDIOqT2o=;
        b=syp5VTkqcgwp+jjdyAwAAvmg5wvo2+f831nbAovhPI8t7/xjgJUt33MDwijterVLKh
         8hU89byRq7pJBWmfBizFd+Qcc9xGSPtieLLgNYO/dTHTGLHsS2LgmbV+hoSb4/moyY4z
         8fnB4YxSV8ns0v5J9JIOk1RYX4nYMZC0xkWHAcuj7AM8t+TqS1UhFGJyWdRiOq/SjCrL
         OvJ/8lfecLZ+qDvsgOMeQQZnLcsBAqwR1aKZ88ZLRNudFlbraN2t0Owq7jQRq63p3UOi
         YWnqrkBKvd2Z66Ma1Yy/j/qVSZqUwilf8lNXbS8qACoVLEXHI+xr4cXquqmbPjugDZeA
         Gkzw==
X-Gm-Message-State: APjAAAXb+GZha8RA43Ua+TucvFfKjZAg0t70y+OQZUlcIuk2Z+C413DO
        qLvNwhYIOJaMjralCTI7TWYHcP2ZnQVCqNKad2rCNPwXlf4=
X-Google-Smtp-Source: APXvYqycK5r7miEYDwVdpcvNW+1inwFPfIxrXPPZC1gd171higUORG8Ag4bZgWymKKLyv0NY50oNKC/zQe3WWXXqx28=
X-Received: by 2002:a1c:4c0c:: with SMTP id z12mr663578wmf.63.1582826223419;
 Thu, 27 Feb 2020 09:57:03 -0800 (PST)
MIME-Version: 1.0
References: <pull.539.v6.git.1582015420.gitgitgadget@gmail.com>
 <pull.539.v7.git.1582706986.gitgitgadget@gmail.com> <a622d8066c7fe27accc5101c3341c30bf706dae1.1582706986.git.gitgitgadget@gmail.com>
 <xmqq8skpjjyz.fsf@gitster-ct.c.googlers.com> <CAFQ2z_PikWsjFizg8=e9+YunkiaciD64BDks8=J55185NC5oQg@mail.gmail.com>
 <xmqqv9nti0gl.fsf@gitster-ct.c.googlers.com> <CAFQ2z_PGgQ19uyjaEaJ4XMuvbkzW5fvJng3r2vYHDz4Z6pT3Aw@mail.gmail.com>
 <xmqq5zfsgfti.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq5zfsgfti.fsf@gitster-ct.c.googlers.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Thu, 27 Feb 2020 18:56:51 +0100
Message-ID: <CAFQ2z_OBSbUJLv6dRiebu7yJ9uL7ZK9sJcySRkapRuu+peD4Mg@mail.gmail.com>
Subject: Re: [PATCH v7 6/6] Reftable support for git-core
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 27, 2020 at 5:23 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Han-Wen Nienhuys <hanwen@google.com> writes:
>
> > So, the ref backend should manage the HEAD ref, but iteration should
> > not produce the HEAD ref.
>
> Yeah, as there is a dedicated API function head_ref().
>
> Things like ORIG_HEAD and MERGE_HEAD have always been curiosity
> outside the official API, but IIRC read_ref() and friends are
> prepared to read them [*1*], so the vocabulary may be unbounded [*2*].
>
> These won't be listed in for_each_ref() iteration, either (think of
> for_each_ref() as a filtered "ls -R .git/refs/" output).


currently the code says

 int refs_for_each_ref(struct ref_store *refs, each_ref_fn fn, void *cb_dat=
a)
 {
   return do_for_each_ref(refs, "", fn, 0, 0, cb_data);
 }

but it looks like this should do

   return do_for_each_ref(refs, "refs/", fn, 0, 0, cb_data);

instead.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--
Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
