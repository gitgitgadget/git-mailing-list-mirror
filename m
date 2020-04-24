Return-Path: <SRS0=LF8V=6I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5AEBC2BA1A
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 06:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BE802084D
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 06:57:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tGd94jtU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbgDXG5i (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Apr 2020 02:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726072AbgDXG5i (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 24 Apr 2020 02:57:38 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D46BC09B045
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 23:57:38 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id z25so10667132otq.13
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 23:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=jqVXJkVT4AzdHGXc+Z+aHp4dFUykdGZVOzmg/JgM/RY=;
        b=tGd94jtUAspQK656M1jT9DiS2FzUjhLsfUU28Z2cUS39qocfaAFZzQJn7V6WCTCQ1x
         RVb2A8AjhMB9VFR2XHSjdFcbdgupbxrMsvpq4LaDHBKifUFwv50qg+zM2PNkWYATgTjs
         8xe9palFstFQeL6hHtZMfFISSJYMpyiVy3B+oxmdH4G2E6YjAmis4OPdrB4Kc7SO2HbO
         FqYd1uOOaeSa1FVC5KhPdnUNqpKxkWG8JoxocFkqUM3saY7WM+M/QmTBuGfXz3XzrIhW
         usz7FvZe3DCrJ03aF7xURjmUjy7gzizyeeclJCAiuknErD/Kcuz1nNedeyybbaxnVLVG
         bJDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=jqVXJkVT4AzdHGXc+Z+aHp4dFUykdGZVOzmg/JgM/RY=;
        b=QR6DDsauXR/3B5hcKBomLD7f5Z2Qg+aiCd6J1eX7LIVYwsHR1947a19XSfiLSE6vC/
         Vpan0Lvnqhiwx2o+fAhNIEaZ1MCRCy+gkB90E0fCB5eITNypkmGP1zhfgsS//HwjEsFn
         Mqir8BrSvIeZQnkSBtcXi4ZF4yfUXdtHUUHRZtni+xIrpjTLD40JyitBopXiWAFi6R9g
         iks4tPURA5G6+stM5as8GHc+eTTevdjBmiTpWkTSxhRp9Cax2SPJxRSSGGMr6f0vlQsP
         p6Ci5Gvye9ILZesNsmkIpvWEA9xut1NQDeFS5msJAzO6Dup4cn2yBWtO7kf6bUnbUTmv
         B8aQ==
X-Gm-Message-State: AGi0PuYvqyMfJ12th87rbkdJQn1N9l5ip+zbALVA9XXM1NOmaoFNSyED
        ErcJcP6joZoftSISViwdUdMk7O11G+ntu1RUuPoM3q4SnJ8=
X-Google-Smtp-Source: APiQypKdfrlNTPbk8iX8SzIgqJ01cAfjgzaSeThyz0ZRfOdbKUAlpqhMerBVnqLodA6CH/V+pDCbBNpqw7CdUcObch0=
X-Received: by 2002:a05:6830:138c:: with SMTP id d12mr6897221otq.310.1587711457342;
 Thu, 23 Apr 2020 23:57:37 -0700 (PDT)
MIME-Version: 1.0
References: <CANYt6aFi+6vKRD71digEh-D0RKkLPBRtek5t8zA-8_cPzwexkQ@mail.gmail.com>
 <20200424064805.GB44448@Carlos-MBP>
In-Reply-To: <20200424064805.GB44448@Carlos-MBP>
Reply-To: lars.fricke@googlemail.com
From:   Lars Fricke <lars.fricke@gmail.com>
Date:   Fri, 24 Apr 2020 08:57:27 +0200
Message-ID: <CANYt6aFjp4wVzYk85Ag9mH3AWp4qUS3+4xsGioyQknKz9tmRUA@mail.gmail.com>
Subject: Re: p4merge no longer working after upgrade to 2.26.0
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks Carlo for the pointers

git mergetool --tool-help indeed does NOT list p4merge.

So support was discontinued?

Configuring it as merge.guitool also does not work.

Regards,
Lars

On Fri, Apr 24, 2020 at 8:48 AM Carlo Marcelo Arenas Bel=C3=B3n
<carenas@gmail.com> wrote:
>
> does it say it is "not currently available" if you run:
>
>   $ git mergetool --tool-help
>
> does it work if you do :
>
>   $ git config --global merge.guitool p4merge
>   $ git config --global mergetool.p4merge.trustExitCode true
>
> or change your PATH to include the location of the tool?
>
> Carlo
>
> PS. mergetool.prompt is a valid confguration, but not mergetool.$TOOL.pro=
mpt
