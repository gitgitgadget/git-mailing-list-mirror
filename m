Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70943C433EF
	for <git@archiver.kernel.org>; Sun, 19 Sep 2021 08:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49B5460FF2
	for <git@archiver.kernel.org>; Sun, 19 Sep 2021 08:53:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237087AbhISIya (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Sep 2021 04:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233210AbhISIy3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Sep 2021 04:54:29 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65B37C061574
        for <git@vger.kernel.org>; Sun, 19 Sep 2021 01:53:03 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id g1so53761174lfj.12
        for <git@vger.kernel.org>; Sun, 19 Sep 2021 01:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=BH1w5f4NyFu/epeWNfz3iLoc48U9eDPOn0noIbdvxxM=;
        b=FRjZ5COFq/NTTC9liigOam1m599REsmoeJy2WuYGL3/rdYbFXCVcdFYaCcpfNyTo37
         hIPO4ykjdUwu7d9ZZX275qP8ULNCnV/YWEoD3KmHmqtgagDdX6qBZeKfJ0I838j56oRW
         K8qH2Omw7F3pDVob0j7OSVLijOTudPhOqtcxwLzPKVxJ/NyaFtanwg01eoIDNZWlT14k
         qXjV/QYOCcdxMZ8jLcDkIzxEt5ZrgyjkJLsMbGLxK+ebNXcvI8cg9WBpjiSEwR3e0yVm
         dS8XkuoHCYaATWCV/Yw2WhVBz1wr236FQPBNqCbZDhQaLvXLA56dliVwjyjXlHYtiXbo
         EM0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=BH1w5f4NyFu/epeWNfz3iLoc48U9eDPOn0noIbdvxxM=;
        b=ZQL57CookNKu98tuF9DMFE+Y/YxDp+bWt9/GdgdCjgGP0Qilz4RKqKTXSV45rf16xv
         ooIx+NeyQAjKoRKsdvavOR4cmme+rnS60juXaaKi95lvFVQVUZucRYd3J8cVcVAkrnQX
         CiNL6+q9koVKP+k0lk/7/LNrKLtHYrDpazEDNU5ejCrWnCkk7fPVcanXTjDsOANPdjId
         RnKuhvt0VqD/3sNTAJX2Jt0WaaPi5UlqgvbcNwDeTMGusRJlK6eJR28iuoQVrKXl0Cq5
         UDS1rUnMIuxagrnMgldhjL6Jdx80YJg1KhHs3gb76jJqggr86bfPr1gKT44PPVl3xauw
         epRw==
X-Gm-Message-State: AOAM532IOI1Y5H0vPNbKkptQzMgQcvxGWnif6toEt1Ox+lsuJHtLIJcQ
        7E6hcXFRSZuuglZemNI0GKCuaTNZ4pk=
X-Google-Smtp-Source: ABdhPJxcInksy6NIO5mRLbQIwSLapI0/AzN+LN3qSzUXhwwHDyPGxvfstNPd14YnI1lMLvNSV29lcg==
X-Received: by 2002:a05:6512:1584:: with SMTP id bp4mr15125419lfb.188.1632041581379;
        Sun, 19 Sep 2021 01:53:01 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id s9sm1280800ljp.34.2021.09.19.01.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Sep 2021 01:53:00 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Git Users <git@vger.kernel.org>
Subject: Re: LANGUAGE instead of LANG respected in git?
References: <8ed06f91-2efc-1816-aa82-beac8e174549@gmail.com>
Date:   Sun, 19 Sep 2021 11:53:00 +0300
In-Reply-To: <8ed06f91-2efc-1816-aa82-beac8e174549@gmail.com> (Bagas Sanjaya's
        message of "Sun, 19 Sep 2021 12:04:04 +0700")
Message-ID: <87pmt5c5g3.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> Hi,
>
> Supposed that I would like to display `git help` in French
> (`fr_FR.UTF-8`) language. I ran `LANGUAGE="fr_FR.UTF-8" git help`, and
> indeed the help is displayed in French. But when I instead ran
> `LANG="fr_FR.UTF-8" git help`, the help is in English instead of
> French.
>
> It seems like Git use LANGUAGE to display localized messages instead
> of LANG (like many other tools do). Why?

You probably have LC_ALL set in your environment. Neither LANG nor
LC_MESSAGES overrides that, while LANGUAGE does.

quote from here:

https://www.gnu.org/software/gettext/manual/html_node/Locale-Environment-Variables.html#Locale-Environment-Variables

"Some systems, unfortunately, set LC_ALL in /etc/profile or in similar
initialization files. As a user, you therefore have to unset this
variable if you want to set LANG and optionally some of the other LC_xxx
variables."

HTH,
-- Sergey Organov
