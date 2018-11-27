Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DAC81F97E
	for <e@80x24.org>; Tue, 27 Nov 2018 19:52:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726288AbeK1Gvl (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Nov 2018 01:51:41 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43520 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbeK1Gvk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Nov 2018 01:51:40 -0500
Received: by mail-ed1-f68.google.com with SMTP id f4so20065418edq.10
        for <git@vger.kernel.org>; Tue, 27 Nov 2018 11:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BXlqw7cpuVFQ1DEseL7MWjvioxu5J4dIq5vhYMraPXg=;
        b=soxXf9vvw9MNBOLcKYgAzeB0QrI+MXgJenpTEJP/HU9/DEDBIY+lwMathnro93CSKG
         +sychAK4LuwTDZVincc2wJ8TEngCia4UgQ+oln59cnEK6TC4+BycTO+2NL5yAH1tySN+
         VaMWglRyUNC94WgQtgnIVBfce3WbAeerT8G38jN+twCGbdQfvGP4tsILZkdd1dGL+OyC
         N3wnUFQKv9Z/zcZqy1eIx7FjEkAgjEQKP7ndvHwQTTcAs8hIeY5xwpwVesfIaHyWjFuH
         jX7diP0bruDNfHkIPYpDWSXobrBsz94TQerFPHBSocx+yqaswqSBJtuZYXYHhYV9vYSe
         YApg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BXlqw7cpuVFQ1DEseL7MWjvioxu5J4dIq5vhYMraPXg=;
        b=Je3RVtCI6Sl28wWGSUNEQkng0pRzbSkDbm8c/SK1kd9WbGNunnz6YFGyLmiEQUEKlX
         fZ80IvoYzTUmWpD1hJwxCtniROr/bsgEIe6Zjd2Ftpoxv7b1yMluWoKo56+GMrqc7Es8
         L/YwGDdLwtZW10ZddWx8YYtreeuvCDr3jIJ40wJ/B9k/mUnLyZ2tB8zettBBs+gSU88N
         0JOVjPIS/8a8sGB13oi7v5nWa2ZWcPg6QVLQ0n5BdfEUe65s1QeDTtAyDtragVH0j2ir
         X4BR+pGoVWXLJDVRArxez76kXwSOKh/wSBvrdtdKeNmfbuKoA123yKHfbZFvjjvOePGs
         gZuQ==
X-Gm-Message-State: AA+aEWZlbylpOxkcsZ07uB25uVJ0eUu0JMi0DA3Bk5CKLA+H6othGxza
        US8eHvOtjryT09REPwkWwSRSlmRsYf8rWHXjLHtVOeY4+eI=
X-Google-Smtp-Source: AFSGD/VYBNwRYfY3dYO3gTHoadZX2kd6Pmlg4OhL2I4khDHsWlVZf0FpYND41uSLzwZtGzF3I4lWHDhM7sPXZiZNkCc=
X-Received: by 2002:a50:acc3:: with SMTP id x61mr27480088edc.76.1543348360369;
 Tue, 27 Nov 2018 11:52:40 -0800 (PST)
MIME-Version: 1.0
References: <20181120174554.GA29910@duynguyen.home> <20181127165211.24763-1-pclouds@gmail.com>
 <20181127165211.24763-5-pclouds@gmail.com>
In-Reply-To: <20181127165211.24763-5-pclouds@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 27 Nov 2018 11:52:28 -0800
Message-ID: <CAGZ79kbKwYgs2un8phaQ9fMSpYqATGV+A-B0aH1gDKykrHBk8w@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] checkout: move dwim_new_local_branch to checkout_opts
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 27, 2018 at 8:53 AM Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <=
pclouds@gmail.com> wrote:
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>

I would not mind to have this squashed into the previous patch
but keeping it separated is fine, too.
(Reason for squashing: it makes it clearer that we do not
care about one specific option, but have to treat all the loose
options the same way.)
