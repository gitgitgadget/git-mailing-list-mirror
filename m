Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7DC421F404
	for <e@80x24.org>; Fri,  9 Feb 2018 04:41:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752203AbeBIElU (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Feb 2018 23:41:20 -0500
Received: from mail-qt0-f196.google.com ([209.85.216.196]:34424 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752154AbeBIElT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Feb 2018 23:41:19 -0500
Received: by mail-qt0-f196.google.com with SMTP id d14so9115152qtg.1
        for <git@vger.kernel.org>; Thu, 08 Feb 2018 20:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=rmbL98nY0oVBNW4ekKXeDH1EEg7P3Kz+XfSh+KANvlI=;
        b=ARnkzOQH1ShdBO99lag3hYsikCzfVc/E1siQCjEAY+8fzveGps1snNDl/p4My4hAR5
         QSJc3uZp+Wm/F8uAjXKzLh7mW2hcnGwI2s3jNLIdFhYkLTwCRru4bnBSAcW6KKkKEw+H
         X453OkhGol3lXizuWR6v7IiFoGppiKiaC+GdNDAEDlRxkpz/+jow4kKfpgBdF7anSqTB
         vsX86OCsaoyR5oeoCwcJ4xN9JBHvGDnEDZFMpNg0ntbu8mgBQHTob9dDIWurm4501EBK
         2IV+fdS554CZVrhXC+1A5Ff+bpeXaIhUBQGGFd591lSH7lB40CYLVxm6e7mPBr+8DJnC
         1huw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=rmbL98nY0oVBNW4ekKXeDH1EEg7P3Kz+XfSh+KANvlI=;
        b=SXJpsGCm0XhzdvZbFmt+xu1V55S+CbFhBwjQoj2ImlpYYcgVKJ3M7vS06BicpF6qOx
         SraVqWt1zHiq3uydAA9D7O8JjeIUaXrb3GbI8D6VFyxFs0OPluNLFiRdHACLSe0Pim0y
         R+gB1b7th/AhXan0GDm48u0pYVIqXTS6jsHDbzZqNrx5NYOE3nb+/dHuSp+QPPwJPIWs
         bLCrPyirIkAJ3L/RsuZc6hbhlxr4DV9iyLltEkXx7ATUKDfXjWdoEgQcu83vbAg4PRcx
         Tt/C1iw8/8PI3M6U9xQjgGj4UD2QNjS7LdFPgMCTgZBDao7uE6/aDECYqNkc3xsUSfQt
         0fcQ==
X-Gm-Message-State: APf1xPBm0IgWCIuWU+isg+p7aQKbCM6ii1AIcyk2G0pIgUrA9U6CtKTt
        h3eHMjRpbTswy+0vHPpVfEsAsE4qIhOwLh69qi4=
X-Google-Smtp-Source: AH8x224cNbRYbgy9M0wvvUU9l5y+5/AuoRf7IzJlZ6ZJBUAzq+dde/jzRbGvqmbtq0McDlygSDpE2k9OAt5iyTnKmXU=
X-Received: by 10.200.51.66 with SMTP id u2mr2589550qta.127.1518151279046;
 Thu, 08 Feb 2018 20:41:19 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.137.133 with HTTP; Thu, 8 Feb 2018 20:41:18 -0800 (PST)
In-Reply-To: <20180208161936.8196-3-avarab@gmail.com>
References: <20180123221326.28495-1-avarab@gmail.com> <20180208161936.8196-1-avarab@gmail.com>
 <20180208161936.8196-3-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 8 Feb 2018 23:41:18 -0500
X-Google-Sender-Auth: lWFlUS8wtu-aoYkNhKArUb_gzEs
Message-ID: <CAPig+cQhCkQknxhH0T_ULpvtStBLv9UiBCAeXgRee_uikF-asg@mail.gmail.com>
Subject: Re: [PATCH v2 02/17] fetch: trivially refactor assignment to ref_nr
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Michael Giuffrida <michaelpg@chromium.org>,
        Michael Schubert <mschub@elegosoft.com>,
        Jeff King <peff@peff.net>,
        Daniel Barkalow <barkalow@iabervon.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 8, 2018 at 11:19 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> Trivially refactor an assignment to make a subsequent patch
> smaller. The "ref_nr" variable is initialized to 0 earlier, just as
> "j" is, and "j" is only incremented in that loop, so this change isn't
> a logic error.
>
> This change makes a subsequent change which splits the incrementing of
> "ref_nr" into two blocks.

"This change _simplifies_ a subsequent..."

or

"This change make a subsequent change _easier_..."

> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
