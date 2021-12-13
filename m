Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49515C433F5
	for <git@archiver.kernel.org>; Mon, 13 Dec 2021 16:46:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236084AbhLMQqk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Dec 2021 11:46:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232517AbhLMQqk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Dec 2021 11:46:40 -0500
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 070E0C061574
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 08:46:40 -0800 (PST)
Received: by mail-vk1-xa31.google.com with SMTP id 84so10775002vkc.6
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 08:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=y0iAFQYWdVGrNvRu9Ee0VfmElI/MVDzkcTOuounF1MM=;
        b=I9z8gT4WusiSlo6vjFPAXayho9KIukMUAfBs9nEpDnPYUdNnRYRj8jPO9wIloGKVEr
         1V8EAueyiq37CDovz3zIHGIPrVofPGwFUvxQjdmdz/2gG5lQ1aLF0dOqKWoDqCiD8fEo
         WfyumKUAmmNCPmz8VK3s1mA806saBLrhPb4vD5+ezwN1z0iCXw92laCVseYsnMaY3TCG
         YSCMk5+jxd+I+T7eUWlym0cSnnySv/f9X00xPqMjuYYRMmUtejptT62K8jWGfHxJ0O9N
         6CjDucMgNWmSicRXpl0hMf5MLucq9lGHmTvhzrIPti1F2ZeQVmfOZORo75NxxWgGyQt7
         ZBfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=y0iAFQYWdVGrNvRu9Ee0VfmElI/MVDzkcTOuounF1MM=;
        b=PC08IF5LMBwRnG8JbZb9oR0YUBQOk4zDkg568cXpX8t4GeXuK4Le1CpDchh3ySF7yx
         AP7SbBvgII5hG/PHkiE//AvyTsO/jLSKbY7AwzQuZt1wZrom9reRL31zAh2fJ3anTwMd
         XDzKuxFnwnz6zISDWGvcIO5WPe7EtSBivpe/7d1WO/mv0r3Xc7UIIRRbQXOPjQORNrNw
         IP2zvTd16gh0x0DpN6OW64+SgxWTsWHzB+dEDNcj2S82myf25ttF9cIt2vhVIF0yLMQj
         IttVzN5EtQbewNLqxtD9dEZkZIq7IQ1xmqIQjtQUv/otYDzHcaMxfcPyi0vDUSXo8a4U
         AjNg==
X-Gm-Message-State: AOAM530r9aZBeDqu/lS3y5pMZfTxqBp4LOEBxy80egPImx/oM2dVILXW
        lFGQ6mr444dd5CeRs3ukvs8nDuOSdWE5IrM3pjx5E5DiSg0=
X-Google-Smtp-Source: ABdhPJxiImx2SE+k8RX5rPuS7Hm7c3xY/OG3PldyNBijCX8oNmIYgiLFJgdBqZtJusZd+py2EIdbu4lUPqutDtIZG9c=
X-Received: by 2002:a1f:2b4a:: with SMTP id r71mr32784470vkr.37.1639413998660;
 Mon, 13 Dec 2021 08:46:38 -0800 (PST)
MIME-Version: 1.0
References: <pull.1152.v2.git.git.1639000187.gitgitgadget@gmail.com>
 <pull.1152.v3.git.git.1639411309.gitgitgadget@gmail.com> <6b0af68f0b94fb96c81e25f9a1911fa05dcf07fd.1639411309.git.gitgitgadget@gmail.com>
 <211213.86czm08o8k.gmgdl@evledraar.gmail.com>
In-Reply-To: <211213.86czm08o8k.gmgdl@evledraar.gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Mon, 13 Dec 2021 17:46:27 +0100
Message-ID: <CAFQ2z_Nr-Rf2kjujPcMtRV6VfweP68A44ZD2XPL8+CqM4F4hZg@mail.gmail.com>
Subject: Re: [PATCH v3 09/11] reftable: drop stray printf in readwrite_test
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 13, 2021 at 5:26 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> Is this something coverity raised and I'm missing why it's bad (per the
> CL), or just a stray unrelated cleanup?

I spotted it while working on this series. It prints something
unexpected into the output of the unittest, so better remove it.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
