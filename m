Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D0BC433ED
	for <git@archiver.kernel.org>; Fri,  7 May 2021 22:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC9F560FF2
	for <git@archiver.kernel.org>; Fri,  7 May 2021 22:55:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbhEGW4Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 May 2021 18:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbhEGW4P (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 May 2021 18:56:15 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 157D1C061574
        for <git@vger.kernel.org>; Fri,  7 May 2021 15:55:14 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id w16so1966541oiv.3
        for <git@vger.kernel.org>; Fri, 07 May 2021 15:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:message-id:in-reply-to:references:subject:mime-version
         :content-transfer-encoding;
        bh=mxdc/DzYmYxYkwTVYclMIeg44RfoT38V7OarrWLPfKE=;
        b=VPAqzaP+IpSZSp3EpBtmqS5ht534lhm+a8HL1rIQ4bbpvJ/end4d3LQkJ0RFJCX9yB
         FZNK+eXTh5Biurre7vPEQCbEVF87mamgMQAj1CJk6wEh8GQFpH31y8Ff9ZwVlGxxoyLM
         DLUCO1cTeyHHsCPsaLr04JbFDwGWgcSZK4xjkbfT49x2qcNJ6sZY+q9i+k0afcZDcO03
         E5UOPAVYQw+ValrLKkGgS3g8xOpCA5KkC2WFDOQ1BTAzvjvdmYjDnFK+HgJZ8k3bKUj6
         QiDphOI5bBqyaIkG4QIbI/F86OEey/Dh7IwEhMg1Dj6hrS7q8gcxpMt075NQc4wGhF8l
         hXjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:message-id:in-reply-to:references
         :subject:mime-version:content-transfer-encoding;
        bh=mxdc/DzYmYxYkwTVYclMIeg44RfoT38V7OarrWLPfKE=;
        b=UbycDA7ZxNZRKlA6Uw4LbNCA7w7CW1jw2KjmPue0mECD9OvVRL8kaf5bAcBwoUrvMV
         Bu+7iNkwlc+1obu5aH75HT/GMmIrZOK2w+W2XkXT/C+bfjRyov9qegK9+q0ELsTXxaM6
         X7KQt/7nG54LkEiRCgSibPVtQ1d93AYDU9hT0+qpD/KXaNMehhmoEhoah1qL3wF9RE+t
         lNnmUDz6XEKtqrCYA21PgcUYeDV9VW/LS6zB9HhGncN1WTDm/B3+unR3QGMIBTPFM5Pw
         X11HNbrOltGm4nq388H8i/GcCa4F+SWZ4F3Qu2RT0NfBGPNJR/QcH1KF8qND/PoKuRG1
         T+og==
X-Gm-Message-State: AOAM533Cej6+y1ww1F10zJuwBygIXbWnj4A95tYHQPNa+/wR58Q4aBkS
        rgjiLl77HS2b1KezGZceyQJqfV2zllXbDQ==
X-Google-Smtp-Source: ABdhPJyWadUkd8ifcOWHLZfOe3kVAjRHGiu7lHgUPv6EqnhGZKtOsa2FPwXYACWWNOFUwE3jz3SxfQ==
X-Received: by 2002:aca:edd5:: with SMTP id l204mr8792064oih.41.1620428113490;
        Fri, 07 May 2021 15:55:13 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:638f:a2c5:89ff:fe0c:1151])
        by smtp.gmail.com with ESMTPSA id y11sm1223911oiv.19.2021.05.07.15.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 15:55:13 -0700 (PDT)
Date:   Fri, 07 May 2021 17:55:11 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>,
        'Bagas Sanjaya' <bagasdotme@gmail.com>,
        'Git Users' <git@vger.kernel.org>
Message-ID: <6095c54fe0766_cfc7208e0@natae.notmuch>
In-Reply-To: <00db01d74338$d45615c0$7d024140$@nexbridge.com>
References: <3461c7b0-594d-989e-3048-2fc6583084ad@gmail.com>
 <00db01d74338$d45615c0$7d024140$@nexbridge.com>
Subject: RE: [RFC suggestion] Generate manpage directly with Asciidoctor
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Randall S. Becker wrote:
> On May 7, 2021 2:07 AM, Bagas Sanjaya wrote:
> >To: Git Users <git@vger.kernel.org>
> >Subject: [RFC suggestion] Generate manpage directly with Asciidoctor
> >What do you think about above?
> 
> Our toolchain does not support asciidoctor itself because of porting
> issues. I am not sure it is available everywhere.

Then don't use it.

If I understand correctly the proposal affects people that build with
USE_ASCIIDOCTOR=YesPlease only.

-- 
Felipe Contreras
