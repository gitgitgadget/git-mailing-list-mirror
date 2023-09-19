Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DADE2CD54AB
	for <git@archiver.kernel.org>; Tue, 19 Sep 2023 08:46:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbjISIqM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Sep 2023 04:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbjISIqL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Sep 2023 04:46:11 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C650A118
        for <git@vger.kernel.org>; Tue, 19 Sep 2023 01:46:05 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1c4cf775a14so3190149fac.3
        for <git@vger.kernel.org>; Tue, 19 Sep 2023 01:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695113163; x=1695717963; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tgeey2eVt6N+RfRCefnl9B1ydFKc43ETMOqW0VVDYG8=;
        b=RIHnIbrdWJZGvLHyi8kdGOHFqmFeDT5zKD0NWhFqK0uz3Og77nM2/VVR4dbMS8kr0H
         xUazIP6KWih+NpUgrtsBMv5XOLNji68oPx5IFq2/ZPz/XVYOwDXCSwSiEv8WnYL7ctIT
         GwJ0qHeogeSB79K/dU2vqRsqkGu9oXkEqcr7gzSXD9GlUgfnchp5tqJuV4XhD+k9yt+f
         Xlf+UGL4Zdx6WMPnan3K7IYMvaFSj11obrNQI/wu7+0Bu9dnyC/IjNozTGZb2IAhTAq1
         ZycboY0tR9q7swc6pJdD+BWI6RANFJnIEstMz1uR8LZI6lt2B6cGRGHLfU0xWXjI23Qn
         QG6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695113163; x=1695717963;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tgeey2eVt6N+RfRCefnl9B1ydFKc43ETMOqW0VVDYG8=;
        b=jzIY3DUkvfq4XJlOXycOv28an0ggYP3YsrFjw5RdnDD3SOmrC0wwBR5Y4P29FYTaIy
         l+Kww6Ti5c1XOLIQovj/p3Kdft/txY141KlcUDLI57OzATPuNvrOv00VqzEangeuCYuu
         AAIS2Q/fr0fZk9GRh/9Vfxj5v1tr7TZqINkdFUwJYUKefF7nRXkaodUNcVq/h1EMmxIx
         DenSE98j8xutoyCWWw8QefBe1KC5AkUjaXnEp2GYfyJkJTu/cfNhMzFQKnI6L2QBhhOo
         hhcguvJVEqpNQMBAN8YI5U2+kpAVxwx3Z/yUNl4lrmvsl1Pq7ODrprfkqpY7+wOKnDn0
         0iwQ==
X-Gm-Message-State: AOJu0YxRaAnbN/6aqNBjZ3gJ6wadXQQovpebOXlty6vKdAZ5vvL4IYQW
        1v7spddQdApqqlIiIIYkSj7ZOG5GAZT+ucZep9D9lAe0C73ofw==
X-Google-Smtp-Source: AGHT+IFzUmTHE/nfril9zti+veWerIwoT0g+h7jc7zypnOBh1bBf5SwkVdy/TE6a9lmqHjOy7BH1uSk4lLSvO3Bz8SU=
X-Received: by 2002:a05:6871:b29:b0:1d5:5660:3ae0 with SMTP id
 fq41-20020a0568710b2900b001d556603ae0mr13043791oab.20.1695113163325; Tue, 19
 Sep 2023 01:46:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230912155820.136111-1-karthik.188@gmail.com>
 <20230915083415.263187-1-knayak@gitlab.com> <xmqqfs3fe08e.fsf@gitster.g>
 <CAOLa=ZQ9ZRmYe5b6R9ZTTpDCzb2L0UmxkeBujb2kOMSeFuwJGA@mail.gmail.com> <xmqqv8c7mq4o.fsf@gitster.g>
In-Reply-To: <xmqqv8c7mq4o.fsf@gitster.g>
From:   Karthik Nayak <karthik.188@gmail.com>
Date:   Tue, 19 Sep 2023 10:45:37 +0200
Message-ID: <CAOLa=ZQdtdpu3KMMpvgr16A19xtjtOXG=HAtNrLKv97-D=Cd+g@mail.gmail.com>
Subject: Re: [PATCH v3] revision: add `--ignore-missing-links` user option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 18, 2023 at 5:56=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
> > This is to be expected, in my opinion. In terms of revision.c and
> > setting the `revs->ignore_missing_links` bit, the traversal will
> > go throw all objects (commits and otherwise) and call
> > `show_commit` or `show_object` on them.
>
> Yes.  And the user can choose how to handle such an object here by
> telling finish_object__ma() with the --missing=3D<how> option, so
> letting them do so, instead of robbing the choice from them, would
> be a more flexible design here, right?
>
> > if a commit is
> > missing, git-rev-list(1) will still barf an error, but this error
>
> OK, yeah, I do see the need for setting the ignore-missing-links bit
> for what you are doing, and --missing and --ignore-missing-links are
> orthogonal options.  Getting rid of the hardcoded skipping of
> finish_object__ma() would make sense from this angle, too.

Well. The only problem is that setting `ignore_missing_links` bit never cal=
ls
`show_commit` for missing commits (since commits are pre-parsed in revision=
.c).
So to keep that behavior consistent for non-commit objects, I hardcoded the
skipping of `finish_object__ma()` in `show_object`.

If I remove the hardcoding, it would mean that `--ignore-missing-links` wou=
ld
skip missing commits but for non-commits objects, the user would have to pa=
ss
`--missing=3Dallow-any` else rev-list would still error out with a
missing object error.

Don't you think this would be confusing for the user?
I'm happy to send a revised version removing this hardcoding if you still t=
hink
otherwise :)
