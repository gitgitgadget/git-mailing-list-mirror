Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 513A0C433B4
	for <git@archiver.kernel.org>; Mon,  3 May 2021 08:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F11A613B3
	for <git@archiver.kernel.org>; Mon,  3 May 2021 08:40:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232959AbhECIlN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 May 2021 04:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232887AbhECIlM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 May 2021 04:41:12 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65190C06174A
        for <git@vger.kernel.org>; Mon,  3 May 2021 01:40:18 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id r5so3206145ilb.2
        for <git@vger.kernel.org>; Mon, 03 May 2021 01:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=koordinates.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hE6dAleyDW/SdVD35Anv4aWXI5mf5csfpPbPVH+Gn1A=;
        b=1rsoNUEgIAMwvmFdbzHByBnV8U1Til9f7upufC7ggpr4J855L+E8fci/NUMTvAtUKT
         +KrP4dawegr2pcLolK0vFiOxSgu8HQgV9xSoMTIoOtKk9FH9SYvaAEvkpB56PGyBDP1V
         Sm0C8MeN4mL+86aPuvU94a/cfGWjjitdLfwTnUak4S0SZ595I8EQQiz1vPHmBOJeEfzT
         YNHxjyVxlXr2+gsmWyDijE+B1X0O4tpHD9MhlU408TK3fWeT3+sFGNQHKZI260TJJ6lB
         aGguQgN9kZhQXfBVzIJibMtuztdBXnm5g16SvyrUjsjs5KPXdfzg65WJgkOoQ2B/LjDx
         J44g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hE6dAleyDW/SdVD35Anv4aWXI5mf5csfpPbPVH+Gn1A=;
        b=OnMh92W9ZYBZw265AZXoxkvdD/tTfE+YMLa2TviqfSi6nKfB+zg8TAQ7OhXMN9dImd
         5E7uCD1CVaMG+SwztfdE87sK/ep004J30VVSptnH3cAv1jzvfBMLRcVn2Mq4NqQneCLy
         GYd0AJC1JsT3LI2w8MwBImPy4dn97YzqX+Zv8ZLD/pfVMnwinqCMrBFL6354jDtuw+I/
         6aEJGFujPniV6rJf3LC1Y0eOCnfR+hYwNfjCYexzPqWYuBv5DPvVSnJAEdXobV4NrMgZ
         O2YkMOSzLQVYSnf7MmCz+F3i4eZeEoSjh8utnrD5zpJUrQE3B/c+pFm0svuym8Qa2Za7
         C1pg==
X-Gm-Message-State: AOAM531prK/NrMILr/VJOxvKuoHIY6bSC3C7KOrITUA+6pMqux9Lwe6t
        zoZkX4ea01uuU+6G8vQtuY2r0aFt373/df2mrPUahQ==
X-Google-Smtp-Source: ABdhPJxe9zy9Dzt6hRYxf5Di8PnR+fITZOm4aDldlR988lTatuCEy3Svwlz3sJ06Q76UoDMBlrfot+uwyecz5SdSsYg=
X-Received: by 2002:a05:6e02:92c:: with SMTP id o12mr15307686ilt.256.1620031217832;
 Mon, 03 May 2021 01:40:17 -0700 (PDT)
MIME-Version: 1.0
References: <pull.945.git.1619807844627.gitgitgadget@gmail.com> <87czuayfy9.fsf@evledraar.gmail.com>
In-Reply-To: <87czuayfy9.fsf@evledraar.gmail.com>
From:   Robert Coup <robert.coup@koordinates.com>
Date:   Mon, 3 May 2021 09:40:01 +0100
Message-ID: <CAFLLRp+LA8WNsmOYPEBbNuSR4o8TBOqZpX-_P8fh6h46tNWmCw@mail.gmail.com>
Subject: Re: [PATCH] urlmatch: do not allow passwords in URLs by default
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, Jeff King <peff@peff.net>,
        me@ttaylorr.com, christian.couder@gmail.com,
        johannes.schindelin@gmx.de, jrnieder@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 1 May 2021 at 10:13, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab=
@gmail.com> wrote:
>
> Unlike SSH this is a thing that the HTTP protocol supports, so I don't
> think it's the place of git to go out of its way by default to break
> working URL schemas by making hard breaking assumptions about the user's
> workflow.
>
> I think a much better way to address this issue, if it's an issue that
> needs to be addressed, is on the server-side. The service operator is in
> a much better position to know if URL passwords are a bad idea in their
> case (e.g. is the software frequently used in certain ways, is there no
> transport security, are we using debug URL tracing etc).

A URL scheme of the form https://user:password@example.com/my.git gets
translated by the http *client* into a request of the form:

  <Connect via TLS to example.com:443>
  GET /my.git HTTP/1.1
  Host: example.com
  Authorization: Basic dXNlcjpwYXNzd29yZAo=3D
  ... some more headers ...

So the server can't determine whether either/both the username or
password in the Authorization header were retrieved from a credential
helper, were parsed from a URL string, or came via a terminal prompt.
Conceivably If the server only uses a non-default Authorization method
("Token", "Bearer", "Key", etc) or uses a separate header (eg:
"MyGitHosting-Auth") then it could conceivably block Basic
Authorization, and afaik Git only supports that approach via
http.extraHeader - which doesn't go via any credential helpers, and is
essentially obscuring authentication as something else (and is pretty
user-hostile).

Rob :)
