Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 817F7C76196
	for <git@archiver.kernel.org>; Mon, 10 Apr 2023 23:41:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbjDJXlT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Apr 2023 19:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjDJXlQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2023 19:41:16 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E551BC7
        for <git@vger.kernel.org>; Mon, 10 Apr 2023 16:41:13 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id cd9-20020a056820210900b0054195d9431dso1615565oob.11
        for <git@vger.kernel.org>; Mon, 10 Apr 2023 16:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681170073;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sSbCsL6mcEjGuJP5xwMB0sO75bZIO2r9HuinE2KRsOs=;
        b=iQ6UXObLoBF3rRYbcRL5snVYCXVQAGAbwE6CCg3e+IbIKEzARS0VOoo2q98ilUsxOV
         2SnF0FPINRstetLP3iBtL0C0CD9JRCSCfQjQ/uqdTOUQ1QKJubyCRN8DT271My4huggy
         6Z0VAM/wyL6OV4IiT/Y2UjaiJaVD0TL41uJMfIUqCKc7XiejLdwkg7ce/5SGnv7N7VKr
         ZUl3lnGGwBX7qFoP3A0P97mDuYi1XCAGLj14Sw17SpgSn+qPOKE0iQWUFy5gNXRW89uK
         g236iOd5kEQlkRaJaAWnUJ2zs8ikCfLRCxlI4SE8C8LjulxHr72YGnS7FdvsChwBzKRy
         uYUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681170073;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sSbCsL6mcEjGuJP5xwMB0sO75bZIO2r9HuinE2KRsOs=;
        b=FzfHIOfSkDBK8mL9bRr3TmQbx/umyea5+tKp6gIyfmHXch0uilXDTAUrVO5CQA5i5j
         PrsJP2VbvWVD7Tk950Vtu9dcsp74Rt6EP6aqde4IgYhilVtR+B6Nlg6BokOhS2RDq1e9
         0XFdJHRalp7GmX5hUFBjOC0LV9ZTIpBEnlw0dkEab7G05pJX9j+yUbmO2IHocJs5Vjd2
         +aveVl5XBcNaEeDxE+l7er3MNBnbvGJXEDr5Y06W+lxU4ny7VWP5fPKOX+CtGj78v1JZ
         skgFI6MhyfEV8TfYoKafw8yQ/QQbOBmhU5k7g0ozSxw3MIraCazb59UE8JrQLx9hAvrX
         n57A==
X-Gm-Message-State: AAQBX9d+F0AH0KMGDVvbC5KJSDyZBwBa4za2jDgrbCx9+0BR418IFEbZ
        F8ndLBh+Rmni5gM5lDHcZr0=
X-Google-Smtp-Source: AKy350bKVbU4Sip9kyd3eAXcWtq+5ElX8G7KBxKV0AOK7tqCyhvwgNjFppQA6uK7QrwnUrbimvTSKg==
X-Received: by 2002:a4a:45cf:0:b0:53d:3f78:21d1 with SMTP id y198-20020a4a45cf000000b0053d3f7821d1mr4921878ooa.3.1681170072732;
        Mon, 10 Apr 2023 16:41:12 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id a43-20020a4a98ae000000b00541269a2fcesm5206611ooj.25.2023.04.10.16.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 16:41:12 -0700 (PDT)
Date:   Mon, 10 Apr 2023 17:41:11 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
Message-ID: <64349e979419a_745294e8@chronos.notmuch>
In-Reply-To: <20230409190805.GA77061@coredump.intra.peff.net>
References: <20230408001829.11031-1-felipe.contreras@gmail.com>
 <xmqqr0suf0wz.fsf@gitster.g>
 <20230409190805.GA77061@coredump.intra.peff.net>
Subject: Re: [PATCH] doc: simplify man version
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:

> I do think we probably want to pair this with another patch removing the
> asciidoctor-extensions hack, but the reasoning there is separate (it was
> needed for some older versions that we can probably declare as "too old"
> now).

Indeed. That patch requires deciding a minimum asciidoctor version for
certain backends.

This patch does not.

-- 
Felipe Contreras
