Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0AF81F453
	for <e@80x24.org>; Thu, 25 Apr 2019 10:13:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbfDYKNK (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Apr 2019 06:13:10 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:35765 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727138AbfDYKMm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Apr 2019 06:12:42 -0400
Received: by mail-it1-f195.google.com with SMTP id w15so11305623itc.0
        for <git@vger.kernel.org>; Thu, 25 Apr 2019 03:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tzWdA1DNeXc4AvM1amnOruprVyCFWrLPq8aWFiMrgXU=;
        b=bitQe/C7r9DeK193DPK89AdZuoOEHZfseO5lomqmsXvr7rU8BjReKZ3s+9T2SVEjY5
         x+M9MirZYfLAH8xHQSFV9m9lA4Qyd9A9R/SIA6Ic5YFXdjLwDtAhcXBcI8vif/YnOWFq
         NPj5iTZNtVLmEQopP98DWyL3OPQx2Tx6yT6UfFACj0p97Lxsnw7OEJs8ZyY4SrMkv+8K
         ruuka/nN8sCeyQhCQ4ADi/WG9+7RhtYaC8OLwZoNfOFwPZKWfNJzFn3p3Ia+Ep7YjeTr
         qYEIn104kV75YCyW2tYk6Bp/OkNRXgPxzpUz9+TPQpUExBRDomL4raDGXAVYJbKDotUp
         PYSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tzWdA1DNeXc4AvM1amnOruprVyCFWrLPq8aWFiMrgXU=;
        b=lqQyBvdLG1152r9ZTr7zmCEmpwy6ve9CGpKHKzbdNsTw++i2dxMgonBmNR91fqF+0b
         ktIrqchpdESvMGfuxsTx+T6jRG0GvGyJJJO21m7tKmNiV5T6uPP72DDdr1qlrH0prncT
         Q5bYElRqDIi4ohcvEnlGKxSezPecXQtuf78TWKRCjIb3YHUfC4VPe1pDnvDNdRFkGOch
         o6wVxnIIdDeQb3bMtPbb1HLuTkIDf6RhsMq4XjK8N668SyQCZKifGwPx85YUV3ZZkJ3T
         uQHuuTDC0YIxollA4gnT2iS2U5FWsH1gw552AtJotj14g6CosWipZI0dtcTivV55FbUs
         OtiA==
X-Gm-Message-State: APjAAAX/8OgnTfHau5E8ZjPlBEniite7JrYCZouXRqsPNx/yBXL3JYHq
        gC+sGM0+RvXKtvJKIMnGQcztPYtBS3jFFcw+xbI=
X-Google-Smtp-Source: APXvYqz6EefH9BrCDsxbS36Xp+7v3J7zalNyfyAjp83OSwYXqmn4zNOLRdG/kK2Bu8HXBGb9WzaK/xYG9E06hKgb3a8=
X-Received: by 2002:a24:478a:: with SMTP id t132mr3031800itb.123.1556187161598;
 Thu, 25 Apr 2019 03:12:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190321131655.15249-1-pclouds@gmail.com> <20190329103919.15642-1-pclouds@gmail.com>
 <20190329103919.15642-16-pclouds@gmail.com> <17402ee1-68c1-e51f-dc32-0795e0b63bc8@gmail.com>
In-Reply-To: <17402ee1-68c1-e51f-dc32-0795e0b63bc8@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 25 Apr 2019 17:12:15 +0700
Message-ID: <CACsJy8BF5DwykEmmPGDR7+AzhOAFreJnML073K0xNBdTDjqMJg@mail.gmail.com>
Subject: Re: [PATCH v6 15/27] switch: add --discard-changes
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     =?UTF-8?Q?Eckhard_Maa=C3=9F?= <eckhard.s.maass@googlemail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 25, 2019 at 5:02 PM Phillip Wood <phillip.wood123@gmail.com> wr=
ote:
>
> On 29/03/2019 10:39, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
> > --discard-changes is a better name than --force for this option since
> > it's what really happens.
>
> I didn't realize when I suggested the name that --force overwrites
> untracked files as well as discarding changes from tracked files. I
> think we should document that. It would be nice if read-tree --reset -u
> took an optional argument so read-tree --reset=3Dtracked -u would not
> overwrite untracked files. Then we could have --discard-changes just
> discard the changes and not overwrite untracked files. I had a quick
> look at unpack trees and it looks like a fairly straight forward change
> (famous last words) - perhaps I'll have a go at it next week.

So, --discard-changes is all about tracked changes, and we may have
--overwrite-untracked to cover the other part, and --force enables
both? That does not sound so bad (and maybe a good cure for those
"overwriting untracked" reports we've seen quite often lately).

Good luck with unpack-trees.c. But if it turns out you're too busy,
just let me know if want to hand that back to me.
--=20
Duy
