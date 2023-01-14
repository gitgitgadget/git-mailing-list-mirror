Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A59C3DA78
	for <git@archiver.kernel.org>; Sat, 14 Jan 2023 08:27:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbjANI1w (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Jan 2023 03:27:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjANI1t (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Jan 2023 03:27:49 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A6359DF
        for <git@vger.kernel.org>; Sat, 14 Jan 2023 00:27:48 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id n8so19435028oih.0
        for <git@vger.kernel.org>; Sat, 14 Jan 2023 00:27:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cp/wMRgTs1pMus7tU4TCXVOLX7m1k/kuJJKE/fMBuu8=;
        b=fGx18SFhrBLJyk7NBaT93akFgDkOJECwaJDw2r2hLA6nD8yN1DMgnUZ8l9XFVqOREL
         4gKpDeXBkuYuuo0l/ePSFt5xFVCLRsn2kgf1Ur/qCU6+FIRZKr7YZCiUUbD5TXww4DR2
         p1a6iVMQckDZcij1yBhfMzda6ln5we32T0mj6Z8KqJiZdD81uPP2p4SSH2L/bIJykKWi
         pF/DHR7BY1lAkBilFJ70F1ymTgiCrAxUijC4SvZ0lSDFAEmux7bqUFypmMwdIxT2yeOD
         uqqOuDvPQRJElnofvVOVCr+vRiNE4Q+z2E3Vz9s7WOY52qyj1d8w4FA/14pMDd2ncQSl
         wDng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cp/wMRgTs1pMus7tU4TCXVOLX7m1k/kuJJKE/fMBuu8=;
        b=TEqAJWvlfGzmRJay2TjFZ7KiuMAZJIG4O3fjVG7ZhEkh28m9JCrwIA0uYTwv0ONTIv
         ejgpghdmopmECI8+I/amSA1P3xuz3AsJt/o88QvXSmGPp8V5qqCyBwlizJZasmbO3Lf8
         v8U94kaow1mgWKZXf+3HzaUj1WuoHor/01MjAB2MXqtfc1dSiAZ1+wGmmKDL0mFeP/Q9
         YEpXWWBdG853q2QLC8dlYJfeGqmyTXDdtC6uH/4mvKaCA3Jiz6t6+AGhFSMXtRA5CVhE
         VMONKsTCD5cZuMVsPMmLXeTg85Ul7DAhA6AXknfMarv5QubS1r9J7vwh9VHCjuDR4OxL
         aJqg==
X-Gm-Message-State: AFqh2kpnUV50F5Zderz9weFxDaSwpf8imhHCe82cpJg0biStX1T0TR0Z
        kX8J38Jgdn65ApbRe2zIr8iafLdoR3mfQgI5XCU=
X-Google-Smtp-Source: AMrXdXuNo+DbuZrlRLX2AL07j/6lWOFWXrxIJ+n46KgU8+MlqzHmnQ498iHx8gcE3TECQylN6EO9ei5USRM7psC8eDE=
X-Received: by 2002:a05:6808:18b:b0:35e:6cbc:bab7 with SMTP id
 w11-20020a056808018b00b0035e6cbcbab7mr3697604oic.232.1673684791702; Sat, 14
 Jan 2023 00:26:31 -0800 (PST)
MIME-Version: 1.0
References: <cover.1671793109.git.karthik.188@gmail.com> <23813496fc73b7e5cb9f09b166e05c9a02bac43c.1671793109.git.karthik.188@gmail.com>
 <230112.86lem728ig.gmgdl@evledraar.gmail.com>
In-Reply-To: <230112.86lem728ig.gmgdl@evledraar.gmail.com>
From:   Karthik Nayak <karthik.188@gmail.com>
Date:   Sat, 14 Jan 2023 09:26:04 +0100
Message-ID: <CAOLa=ZQdNy-gQ0-gUdQM8z+k0fpLjXcRY3fAC4v2PnEvSRS2PQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] attr: add flag `--source` to work with tree-ish
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Toon Claes <toon@iotcl.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 12, 2023 at 2:21 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Mon, Jan 02 2023, Karthik Nayak wrote:
>
> > +static struct attr_stack *read_attr_from_blob(struct index_state *ista=
te,
> > +                                           const struct object_id *tre=
e_oid,
> > +                                           const char *path, unsigned =
flags)
> > +{
> > +     struct object_id oid;
> > +     unsigned long sz;
> > +     enum object_type type;
> > +     void *buf;
> > +     unsigned short mode;
> > +
> > +     if (!tree_oid)
> > +             return NULL;
> > +
> > +     if (get_tree_entry(istate->repo, tree_oid, path, &oid, &mode))
> > +             return NULL;
> > +
> > +     buf =3D read_object_file(&oid, &type, &sz);
>
> Here you flip-flop between istate->repo and "the_repository". I think
> you want to use repo_read_object_file(istate->repo, ...) instead.

Let me add this to v7! Thanks
