Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BF0DC433EF
	for <git@archiver.kernel.org>; Mon, 18 Apr 2022 18:24:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347374AbiDRS0y (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Apr 2022 14:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiDRS0y (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Apr 2022 14:26:54 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D6621209B
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 11:24:13 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 2so13664078pjw.2
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 11:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:user-agent:in-reply-to:references
         :message-id:mime-version:content-transfer-encoding;
        bh=qUM+zeVC6J9m8G7/yikG/rJWhMd+immxk0EVBStNSxU=;
        b=c7pX0W+FtGNw3y3aDmx29/p11woAlQFsrfGTGr+os9tVg73iqy7euD6nygJd4bOnBq
         ctxFvaw4J0Tei2Bt26x8gNVimYbUxWDAjaqXMjzmJrYdZ/sFbiSeufeS87wSlJNv84e7
         Fa64JXba4BBYv6nN1fCq3FaDdJ1kDoXsdh3ywBRPgznniNoOHyw0oKHdXGEGc0NdTUu8
         RUZuN9xpraNHNxwlH+Z/L1wYJoDOIl7/0S6kFf+K8Bg6szpU+Mhe5FuM+niCOfNVF1zp
         BSkI4qHFKyZKbOrCCFAWNUGX5NT/AgozBOB4NfW3HU+7VJ3re4z0z77+cqXNJnufXd86
         JFcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:user-agent:in-reply-to
         :references:message-id:mime-version:content-transfer-encoding;
        bh=qUM+zeVC6J9m8G7/yikG/rJWhMd+immxk0EVBStNSxU=;
        b=XVp2RPH1r2yFu/hLf1ViM+93um4XZwnktaJcjKbIjHFfo9gBNZpYNFj6XEzaOoHKnI
         RZLNYrpXOCcVfQbOTT++OQKH/6T6XFhRUjgjeUrLdOASd2kKG8aXGbqC9/vxN8G6y7U4
         Tl/21eDxeUFfCO/I9VjSWNHxWdSqNcvlPJf4/nrL/By5VuhQxva9FAAG5x9Y0HShgbGn
         BBmPbfXHmXSfV8B1vRRZvWKIcergp0U6KAb9Ph0fA5Vq8R2b9Eqa51yz/RX6i2S04I6S
         FI8rgnR3A7itq7WQb9qFbiLiQFJnQNDd1kP38R1PfijdPvfPWsZeCwE+uCNiyEoTIpfX
         Y0ZQ==
X-Gm-Message-State: AOAM531+7OmTj1VUFaIck14uqlRj+mYmIe6Ak3eZrP/4jlDY5YNJ43/y
        bTy+mSIWqp8kq4vahldzgAs=
X-Google-Smtp-Source: ABdhPJzEPKkqI5ALoSKBr3JgKKOqZMl8+B/Bk2Ycpz40nf4uP1LsT/TlqKeuOi/ceH8mkdPuU1Ye/Q==
X-Received: by 2002:a17:903:240e:b0:158:eab9:2662 with SMTP id e14-20020a170903240e00b00158eab92662mr11007267plo.87.1650306253179;
        Mon, 18 Apr 2022 11:24:13 -0700 (PDT)
Received: from [127.0.0.1] ([49.204.135.226])
        by smtp.gmail.com with ESMTPSA id q16-20020a62e110000000b005061e2323bcsm13001446pfh.162.2022.04.18.11.24.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Apr 2022 11:24:12 -0700 (PDT)
Date:   Mon, 18 Apr 2022 23:54:05 +0530
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     Plato Kiorpelidis <kioplato@gmail.com>,
        Shubham Mishra <shivam828787@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Labnan Khalid Masum <khalid.masum.92@gmail.com>,
        Jayati Shrivastava <gaurijove@gmail.com>,
        Jack McGuinness <jmcguinness2@ucmerced.edu>
CC:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: [GSoC] Contributor candidate introduction
User-Agent: K-9 Mail for Android
In-Reply-To: <660025e5-637d-8e93-e7ba-65a3ad474bad@gmail.com>
References: <CAO2gv81zCGbxNN_7a2j7sJZ_fbHiFXf4YxagddWLBWw7-ki5zw@mail.gmail.com> <660025e5-637d-8e93-e7ba-65a3ad474bad@gmail.com>
Message-ID: <E6525E16-10E8-4C08-A596-6C16AD31F62A@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adding other potential contributors to notify them too=2E

See mail with details below=2E



On 18 April 2022 11:24:34 pm IST, Kaartic Sivaraam <kaartic=2Esivaraam@gma=
il=2Ecom> wrote:
>Hello all,
>
>Just a heads up that the proposal deadline (19Apr2022 18:00 UTC) is
>approaching shortly=2E I noticed that Abhradeep has submitted his proposa=
l
>so far=2E Others, do make sure you submit your proposals in the GSoC
>website before the deadline=2E Only then can we consider your proposals
>for GSoC [ref]=2E
>
>Thanks=2E
>
>[ref]:
>https://developers=2Egoogle=2Ecom/open-source/gsoc/faq#should_i_send_prop=
osals_directly_to_the_mentoring_organizations
>
>

--=20
Sivaraam

Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
