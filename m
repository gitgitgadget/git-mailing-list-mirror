Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2FFDC4743C
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 00:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A481660FEB
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 00:25:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbhFVA1X (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 20:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbhFVA1V (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 20:27:21 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB07FC061574
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 17:25:05 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id i68so35190228qke.3
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 17:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QgSowDOIauMGlFdCoA/ftMCdEg7IT4paGIhXF9cM/Ag=;
        b=VL/r/FJpik4gAq3X+7owCmF+eSbQF8bGVvJ6dTeSKCE6fYPUzueBFlqekNNq1lyW1k
         7o2PabVjnZ34uiewMu+tsAwpfJVkpEEzkdzx4lAhIG7ELiGzdhTfOAQkCE8LMWw8zTf6
         bQTuI4IrxxoygAc/7npD800c6mlfqIYMoDRC5MKVcK8zBZmM+LEU7MlRD1Xjce/BBLqx
         CnBzfgFPXaPuf5DX5UWbONcwVOgA4Bzwg0bXnMxJbqIUMXlP0CG+4Nee6LXg/pRowDLV
         euirG7x4ztenXtpMHNIle2O2w/ZgQ6gXuYkXIkS8n+bXybCc7vh+tnI5ZXwh7/3lAfZs
         7CMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QgSowDOIauMGlFdCoA/ftMCdEg7IT4paGIhXF9cM/Ag=;
        b=frKTIan1y+A8IVqHqYrwNs7KlhoNn03dHGgiSdNHITjargUIdH5qVKMKI1zftJJ4yg
         Tk1vVpFeAnxmF09Rvb352O7MglnIiFX0ZioMe7eniHsO3OuZ46u5v26pVpM8p9dPkjTz
         sTBg+EX9VWhx0DzpAbGiQcp0xiIV7iubHPsLB7aUL1wCdJRtDwwnwZ0fgvZZYsfT+ZzQ
         S/7F4Mze30HdKl9WMke/GONsMUOpMXHTY/FLOKMZBoxZUSWPbAZRX2m74Z15Q0i9Vt2q
         zFRdY5W6MacllyqSyrtLW4QlZjzPMvBy00wKYgiBwJGYCYFbI523moFuV3Sbk/Xqhldp
         I45A==
X-Gm-Message-State: AOAM531pshmHndk9KfFvXLw+ndftoB/nMMAQcxdLwQpClPpfHLKJyyrP
        9J9zBpnQZ8h+TqqGMaDoAKLkj3wVvrXZJH/EXDw=
X-Google-Smtp-Source: ABdhPJzzWytS9qsTbdWSDyMRg8Rebt2iOwYbxjuVd5uOB/ilJSrMds7DSmqrR8zfde/Fz+b5OiBEmlrhw7M8uyQfbTo=
X-Received: by 2002:a25:b53:: with SMTP id 80mr1054353ybl.155.1624321504693;
 Mon, 21 Jun 2021 17:25:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210621020740.25577-1-worldhello.net@gmail.com> <alpine.DEB.2.21.2106212034050.12899@perkele.intern.softwolves.pp.se>
In-Reply-To: <alpine.DEB.2.21.2106212034050.12899@perkele.intern.softwolves.pp.se>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Tue, 22 Jun 2021 08:24:53 +0800
Message-ID: <CANYiYbFt-kk2zj54MtJqfb_S9DswLvHicBNd5MmiayUxqJFPqw@mail.gmail.com>
Subject: Re: [L10N] l10n: fixed tripple-letter typos
To:     Peter Krefting <peter@softwolves.pp.se>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Peter Krefting <peter@softwolves.pp.se> =E4=BA=8E2021=E5=B9=B46=E6=9C=8822=
=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=883:36=E5=86=99=E9=81=93=EF=BC=
=9A
>
> Jiang Xin:
>
> > Andrei found that the word "shallow" has an extra letter "l" in
> > "po/zh_CN.po". There are similar typos in other l10n files.
>
> Andrei also pointed out another typo in the Swedish translation, where
> a configuration option had been copied incorrectly. Could you please
> amend your patch to contain both these changes?

Will merge.
