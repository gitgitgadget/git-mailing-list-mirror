Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8EF1C433B4
	for <git@archiver.kernel.org>; Thu, 13 May 2021 20:04:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80B7A613CD
	for <git@archiver.kernel.org>; Thu, 13 May 2021 20:04:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232395AbhEMUFe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 May 2021 16:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232389AbhEMUFd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 May 2021 16:05:33 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E9D4C061574
        for <git@vger.kernel.org>; Thu, 13 May 2021 13:04:23 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id t4-20020a05683014c4b02902ed26dd7a60so14494039otq.7
        for <git@vger.kernel.org>; Thu, 13 May 2021 13:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=FbtH+cJhXsRUJ/fnE8qBQy/Ru5Al6PQWuhw0U/WaHxw=;
        b=CvBnj+XSndMBPuyySILlBbwkxv79AunwYIPs0h8L/EqhDo74ab/AaPDEYFaG9hfnFZ
         3tnYlNRAG57rRkPjeyDOa7IwEbdH6IgZIRsJPBA1U/hLOXW9pmG45qywaHFmOimKUY43
         nD4HsUsXQExkFfn2o2JPa5tDmXiATyt+nTrsfZw39Dldidx5e9pkf0J9NhXzUjfUo5NJ
         9dcYhlR5vdjrU1YqG/Qm9xXm7k6CMg2yBft+fmNToZBdDrUTm2zlH3DlrYnlArJ4Cufx
         6xsQ+SuXygeFC70PdzMtrkWVvTDe7jli4qU0etpiaq9k/6j4b6VglRvTp0bevhXqQK28
         vNtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=FbtH+cJhXsRUJ/fnE8qBQy/Ru5Al6PQWuhw0U/WaHxw=;
        b=LOfy40CTg57U6WHB7TNtnBoudtIhQ6pWn98vlPEcByGyCO+VrWFq79C99kx7j1BLuj
         OdFJmKz7hBlRp2ksd6GA1HRxc01aHXKkKj5xQJCWmYi6TUzCvQkd7X+p6kW0LAlcEFlL
         efSXE3nPz6gfiuvDFmnlfGersMfcNafw6fEdGpaLdWp2dhhOl08F4kVkcALdtqo0urKZ
         quIlOBM6RfXlyiW6jN2gLOfU4PrCzHY13wtY+4d/pac7NkPsz7EavlJKC/X6CF3Du2rb
         wTITnvv5wTP5Fc8fFO+zNqTfTCGuBf9BGHHFsWQRsCmn6EWiFqC/AGGSZMY/If+Gdiyr
         ffpA==
X-Gm-Message-State: AOAM5309tzzURrNFP+j+Gf/Uokct19XFHRgdUzuZhZw4fmtPvk45EXaz
        ekfKpGzIXIEsWJAwh7967Pc=
X-Google-Smtp-Source: ABdhPJzvMvHFlX06E63JUEAhpyFnx0QS6NCAiTUnWdRNDfGgQe3JOsDGWpHPw2iKCbL9zW358oDSyA==
X-Received: by 2002:a9d:c24:: with SMTP id 33mr35870499otr.289.1620936262974;
        Thu, 13 May 2021 13:04:22 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id d19sm852938oti.57.2021.05.13.13.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 13:04:22 -0700 (PDT)
Date:   Thu, 13 May 2021 15:04:21 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Dave Huseby <dwh@linuxprogrammer.org>,
        Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org, christian.couder@gmail.com,
        felipe.contreras@gmail.com, stefanmoch@mail.de,
        philipoak@iee.email, bagasdotme@gmail.com, sunshine@sunshineco.com
Message-ID: <609d8645626ac_80a2208cc@natae.notmuch>
In-Reply-To: <20210513171706.GD11882@localhost>
References: <20210512031821.6498-2-dwh@linuxprogrammer.org>
 <20210512233412.10737-1-dwh@linuxprogrammer.org>
 <xmqqy2cjcwn4.fsf@gitster.g>
 <20210513171706.GD11882@localhost>
Subject: Re: [PATCH v3] doc: writing down Git mailing list etiquette
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dave Huseby wrote:
> It sounds to me like adding a MailingListEtiquette.txt file isn't the
> favored approach. I can tailor the information in here to fit into new
> sections of SubmittingPatches.

I don't think this belongs to SubmittingPatches because it applies to
*everyone*, yes people submitting patches, but also people reviewing
patches. Additionally people submitting bug reports, people responding
to bug reports. People suggesting improvements. And of course people
maintainging the project too.

Also, any other discussions.

-- 
Felipe Contreras
