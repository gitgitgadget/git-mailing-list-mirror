Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB363C4332F
	for <git@archiver.kernel.org>; Sat, 10 Dec 2022 00:03:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbiLJADV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Dec 2022 19:03:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiLJADU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Dec 2022 19:03:20 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F5FD747D4
        for <git@vger.kernel.org>; Fri,  9 Dec 2022 16:03:17 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id b13-20020a17090a5a0d00b0021906102d05so6573909pjd.5
        for <git@vger.kernel.org>; Fri, 09 Dec 2022 16:03:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y0TSti/As1qftoB2ECuUnP+o1RPNwJmj4CTyEfxg+nM=;
        b=OUY9FKgld+uufdkpsTtmvYA1FDxfFq9/Kpf1yFOY+RsjP8ThVjEOqnAELGvqeEw6so
         nPr2aFTV1jorQmvoC2q+72ghQqHgGy+P/nCKo8pKK6oNEIOv8xtc587wvqbWWLSsTxyx
         /WXzBfMJWwZ9ueM/Yjh4uwD0iRmUYJFQclXZ1BEmyy/AIZdRHXiviX6lodJr2Ec0Jh+p
         8orzOEM5SIHhEfki/MsEohHbn4kSoUwYBUy4/J1e7RqIUkqTlYvoCFHy3YSIihZjgxfi
         sB97TdHEH/3nMOiQsfglEjpiSUx2NGf9Wki0iEwUnm+xURghfLSUskRWHzaaWkuWI9p3
         JeWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Y0TSti/As1qftoB2ECuUnP+o1RPNwJmj4CTyEfxg+nM=;
        b=gGd2VVb/1BfOYIpnaDNzv3sGAHMAmXdffoIbz8lETMEzVTX63ppksW40FJQ+EKAdna
         cCua0SgZO1FQjJ8j1jYXZZi6CO74paJ2WtRwKk5IgbLjYrl1ZFlyzCCE5Fd3Kw0RnGWl
         Lkz3bDD7d4VDS5tTzgWAYnhK77hvoLhURxF/sHoy5TWOX0FNQhrcqdTXcVZDiF1bmnsO
         /mKB/4Hy2KOKTqNjZrx87VWqZ/vaeMx0YjK54YPkPiz/75+KugWP3E7MVjqtiOz3RhBi
         D7MM1I5+YqGvimd806by3a1y7u4BVtzbfQ4SvTYcpvdHsTVF0gD4dC8uK7oGcId/ZNef
         Nreg==
X-Gm-Message-State: ANoB5plCKfxGK/0ZYjA+geLoSooY+Obpwk3KnVn2inxLCoRL1WK2rf95
        yNob2sDBixAPxuhSk+Qghdw9kqEYNWsxqw==
X-Google-Smtp-Source: AA0mqf75ZXNvlTaieD6EccCJCQZWl98TT8K7KyPKjc/gSeY9eZ8U4GQyPE67VgRE5Di60+Gat0ugjQ==
X-Received: by 2002:a17:902:e20c:b0:189:a934:ee33 with SMTP id u12-20020a170902e20c00b00189a934ee33mr6993313plb.58.1670630596872;
        Fri, 09 Dec 2022 16:03:16 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id i15-20020a170902c94f00b00189502c8c8bsm1854401pla.87.2022.12.09.16.03.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 16:03:16 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Karthik Nayak <karthik.188@gmail.com>
Cc:     git@vger.kernel.org, toon@iotcl.com
Subject: Re: [PATCH v2 0/2] check-attr: add support to work with revisions
References: <20221209210321.709156-1-karthik.188@gmail.com>
Date:   Sat, 10 Dec 2022 09:03:16 +0900
In-Reply-To: <20221209210321.709156-1-karthik.188@gmail.com> (Karthik Nayak's
        message of "Fri, 9 Dec 2022 22:03:19 +0100")
Message-ID: <xmqq1qp8yvjv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Karthik Nayak <karthik.188@gmail.com> writes:

>     ++'git check-attr' --stdin [-z] [-a | --all | <attr>...] [-r <revision>]

Please never design your CUI to take unbound number of non-option
arguments before dashed options.
