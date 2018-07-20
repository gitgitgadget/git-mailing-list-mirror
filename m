Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74D2B1F597
	for <e@80x24.org>; Fri, 20 Jul 2018 21:50:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728329AbeGTWkb (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jul 2018 18:40:31 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:53055 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728297AbeGTWkb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jul 2018 18:40:31 -0400
Received: by mail-wm0-f66.google.com with SMTP id o11-v6so10660989wmh.2
        for <git@vger.kernel.org>; Fri, 20 Jul 2018 14:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ZcUVECzSOMcfvGOPJ+s/SB0rosCtFfaAi50DBIyTezY=;
        b=WPB7OTaLbc2A+CULzlqvFYrrsSz80AYJI5omw8D3mkwSM5ZMqzh0D21QRTQRVM7C0z
         MPmHXmMpy8MM9IPVsvlCv9hLJcLRga9BcoPsMhMssSXrVFvSfTf+8RcnWL/xnxt97LEw
         nqLnxtKI0gg+SQ5he5BFnOlGPQBwN5GcAxM3uzKNfaJW4bKmw2Va/TQsl/VgPqV0DSp8
         wxeOj2WF65nfrO9iGfbAZ6ARGMDwofa/eKHkYMvQr71ZifwwseqIbYOrbrzZa7/BkWtG
         Yw6rYeoIayY+54iDumcygQgxuoVRcd1BoCi8YsbovI2q9TC3SA/m+GG3QmWouEC9120P
         6gTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ZcUVECzSOMcfvGOPJ+s/SB0rosCtFfaAi50DBIyTezY=;
        b=NIeXP0+g02/TUd4NWSgMDrdalJosjynld5I9wWkTqE+WbEY1FAzw04ZLqpBbFACJ7h
         Ji1Y599VfeTRlWKfDAiGAv9LEuD7bgKQazX0PygBFshNfEftpRB7s0LphHgmBttxZXlF
         XkFnDy/g682sEsQmzGOWq+GtJdkjx/Ns3EDEE86xdnrgZmJ96FzKfUxg1cUb0mEIQ75M
         Dn2Xe635dXlk4CNKGP5GFYf2nfR1+hO1Y52GR6CrtfPyTIbCIJcLkG29iiG/vvkYfw6+
         yxIoTjRDUrKgAHjniSUiUAWr8pA7ewml7gWB1npkjglyFA0NMrvuANwdmKo16mZuaGLZ
         DQrA==
X-Gm-Message-State: AOUpUlHEaKm/cUiIwnD/hcsa1K3xFni6ZpdQ2Hv3YVf3v4FafHjbyy6Q
        8ZKF5fuUbHqXAHFOD/4DxgzvR49b
X-Google-Smtp-Source: AAOMgpcstT0597MWtkPNkEdmyzt39ahaIPZoXZUi5s74RFzIPnwp39jgZu2nhepqmC/iKQjRfhDKcg==
X-Received: by 2002:a1c:ed07:: with SMTP id l7-v6mr2597644wmh.139.1532123421388;
        Fri, 20 Jul 2018 14:50:21 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id o4-v6sm4771239wra.3.2018.07.20.14.50.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Jul 2018 14:50:20 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 0/2] fail compilation with strcpy
References: <20180719203259.GA7869@sigill.intra.peff.net>
        <xmqqo9f1bupp.fsf@gitster-ct.c.googlers.com>
        <20180720191839.GB26403@sigill.intra.peff.net>
Date:   Fri, 20 Jul 2018 14:50:20 -0700
In-Reply-To: <20180720191839.GB26403@sigill.intra.peff.net> (Jeff King's
        message of "Fri, 20 Jul 2018 15:18:40 -0400")
Message-ID: <xmqqfu0da86b.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I suspect it has more to do with system/libc differences between our
> machines, anyway. There was discussion elsewhere in the thread about the
> need to #undef before redefining. I guess this answers that question.

Yes, that is it.  For now I can squash this in before pushing it out
on 'pu'.

 banned.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/banned.h b/banned.h
index ae6aaaa4a9..d138f3ecf2 100644
--- a/banned.h
+++ b/banned.h
@@ -10,11 +10,17 @@
 
 #define BANNED(func) sorry_##func##_is_a_banned_function()
 
+#undef strcpy
 #define strcpy(x,y) BANNED(strcpy)
+
+#undef strncpy
 #define strncpy(x,y,n) BANNED(strncpy)
 
 #ifdef HAVE_VARIADIC_MACROS
+
+#undef sprintf
 #define sprintf(...) BANNED(sprintf)
+
 #endif
 
 #endif /* BANNED_H */
