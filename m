Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 743EBE95A8E
	for <git@archiver.kernel.org>; Mon,  9 Oct 2023 07:28:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345388AbjJIH2F (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Oct 2023 03:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232625AbjJIH2E (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2023 03:28:04 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CED1A6
        for <git@vger.kernel.org>; Mon,  9 Oct 2023 00:28:03 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9b1ebc80d0aso719077966b.0
        for <git@vger.kernel.org>; Mon, 09 Oct 2023 00:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696836481; x=1697441281; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4jDOHHu3WUa9oMhx9HQzlwofcMBDTQP619qho3Tr2y4=;
        b=RL+uqDaRSA3BhxfrHUCkHgPUgdU5l4NGWS3v+kpeWZK5JJL3a5pSiOjtcAWMbQ29Js
         hbVEQquK2e4gcPOgLUQSVZaXwe8aaDSMxmIywZa0HqXTUuhY7atDrvQ9jDxU25ugYWss
         N5Di8N3/r831hnuTKUkbdq4B44AJwlJ3zGqwcAfv4fW9tkhADlKxg/ysCFPAL5/9fVs4
         QTWf3Xe+7lQnAxSSALeuQaae4v1Jj6n0LTZ36bhIV92FdrLDZIMTPZbjRbh5XuWGv2t+
         sCYGR8wNsI3l87b6oF1rSgT5+V30ka6qzsOi6BAbVgE9zLXQm/Dg+fVWqHRev4I6LCg/
         Ixeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696836481; x=1697441281;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4jDOHHu3WUa9oMhx9HQzlwofcMBDTQP619qho3Tr2y4=;
        b=E1sP8gWkMbRhdz6Mp+8rbcNJ0o1+TDg3aITm8RwkmHf5qF4KIoTiy6XgOvzbtnY+vF
         ITgp214c07KW4mzsMawo/oJ1s9Oj8l9vfldNzhARMzN95Zb2myz/0pfw9WqLQ8a9T/Qr
         zUdkkbEXT2ruvXdLEafWFzmqGnWzAl190OI/CNyTAUCp16BimLn4K7vmNx5NmPT7mzO2
         mT0tJYjEpCIGR91Oqg3CPoar09ywGHR2FDGNSP5Q/WNSl4MUYEf/XVNK3JEFQ4c33iAX
         +HV0/l3/SvfmcD8GkQxSg9hanna3q0t2/V6Ycvc/F8zX3uBAftVtRwfp+DV2HF/6h/JK
         F7kw==
X-Gm-Message-State: AOJu0YyGA/e1UkHa/hHRzCGTv2s840s0SeT05l7GWHZuhZc8geqlCzRc
        3+3TwsDb2yB9YDKD1GiwCGdqjB5xQHyZ5tNQPwYEoPN/VN1QRw==
X-Google-Smtp-Source: AGHT+IEdRhRIEoC5gybHBZ6iSy2gMiKUog2QGG6AW1+YV8q2NFDIMfegdD5Q8Ft2KhK+rMqguGx+t1elKWbW1StQHSM=
X-Received: by 2002:a17:907:b609:b0:9af:6bb:6c54 with SMTP id
 vl9-20020a170907b60900b009af06bb6c54mr11177077ejc.26.1696836481399; Mon, 09
 Oct 2023 00:28:01 -0700 (PDT)
MIME-Version: 1.0
References: <20231009011652.1791-1-naomi.ibeh69@gmail.com>
In-Reply-To: <20231009011652.1791-1-naomi.ibeh69@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 9 Oct 2023 09:27:49 +0200
Message-ID: <CAP8UFD35DBBwQ1Mgc+NGVoh1ReLncAz9OJF3Yj++FFrESw8rtw@mail.gmail.com>
Subject: Re: [PATCH 1/1] [OUTREACHY] Fixed add.c file to conform to guidelines
 when using die() listed in issue #635
To:     Naomi Ibe <naomi.ibeh69@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 9, 2023 at 3:17=E2=80=AFAM Naomi Ibe <naomi.ibeh69@gmail.com> w=
rote:
>
> From: Naomi <naomi.ibeh69@gmail.com>

First the subject should start, after "[PATCH 1/1][Outreachy]", with
the area of the code you are changing followed by ":", so here "add:"
(no need for ".c").

Also even if the subject gives a lot of information already, it's
better to use the body of the commit message to give a bit more
context and details. For example here either the subject or the body
of the commit message should say which specific guideline(s) the patch
is enforcing.

> Signed-off-by: Naomi Ibe <naomi.ibeh69@gmail.com>
> ---
>  builtin/add.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>

Otherwise the patch looks good to me.

Thanks!
