Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0CAD1F405
	for <e@80x24.org>; Thu,  9 Aug 2018 00:45:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730531AbeHIDGR (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 23:06:17 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:38688 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729732AbeHIDGR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 23:06:17 -0400
Received: by mail-wm0-f49.google.com with SMTP id t25-v6so4563149wmi.3
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 17:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=/7Kv5yk6g5xZVa0s5Xyj7aIGjGdKiV5IeKnPUcRvavU=;
        b=q1fXGnO8ACdXEfkODF99tYbusnplLeJ/oTmFN3xcs4LPmltRStrLA7GlNERdDpsUri
         AqrVjsyA8bBpxCoIMGrVK1dfKwfQb6JBs7ThZ7PdTeS+/VSrQARDF5n2aBjWUfV9L93x
         fHniPAIMyIzOEtPooFu1iQARj8e/idyF2l7vo/Y3kPRy6q6IN4OlKNwx8+NjqCVip/UB
         kENantAzxM4edKSZr+5US2ubtkTkTPoGrFr36Na90jCMyD5LXUZ2FJaad3cUk1/dXZHg
         9JalgqFYDNqOrXBXcaDMu8KQ0ftsVUEFhuYauTaPoQcusqgjuRuNZNg2gd2npAumZgCl
         3j0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=/7Kv5yk6g5xZVa0s5Xyj7aIGjGdKiV5IeKnPUcRvavU=;
        b=PhjglA8mHf53nf1v+JaJxkYK7OAKjyO3zVNeuPbGexFz69uSaWF+BRnHIUKUDtVUAL
         RDj3CVXBh85olGoWjkzqA4pJAVUjk7r46bI9tH+6wtlkzWg3xgdXyd0z+lmXRIThCMsc
         nHYUysVHW52aSHAOY+N+YSzmRJeEq/Ph+7XUXwbSwzQr2xE66RZk0hgrenkwz0ar3RnO
         VsG7FJmuiW98suUI58YmhPjzhDuhycrkTpwwicv1mPh0Ma87G1PHkBDzj3kWDH6Bap7F
         jSvEgcQ0sB+i66pJSvRRbs2kY50BJl/ZFdBDzsiv/LdUbKcq+1tzmpe45FEhxEcLapIq
         064A==
X-Gm-Message-State: AOUpUlEOVUUIleiIZP4zEj0qFa2arpX7jzkcPur4G/0+b4aJRLBSbmOo
        8gdBAdYSG6+IoH5lDA+PwIQ=
X-Google-Smtp-Source: AA+uWPzC28b/0Ai+7vWEJTenlxXqIu/YFo9dtN32nckOsih1atndY7axxfSBzy4EyLfhxQEChmRChQ==
X-Received: by 2002:a1c:37cd:: with SMTP id e196-v6mr142144wma.84.1533775448644;
        Wed, 08 Aug 2018 17:44:08 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id m35-v6sm2231314wrf.41.2018.08.08.17.44.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 Aug 2018 17:44:07 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 0/5] chainlint: improve robustness against "unusual" shell coding
References: <20180711064642.6933-1-sunshine@sunshineco.com>
        <20180807082135.60913-1-sunshine@sunshineco.com>
        <20180808225327.GD3902@sigill.intra.peff.net>
Date:   Wed, 08 Aug 2018 17:44:07 -0700
In-Reply-To: <20180808225327.GD3902@sigill.intra.peff.net> (Jeff King's
        message of "Wed, 8 Aug 2018 18:53:28 -0400")
Message-ID: <xmqq4lg4e5d4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I had two minor comments on the first patch. I'll admit my eyes glazed
> over looking at the rest of them, and to make any kind of intelligent
> review I'd need to spend an hour understanding how the sed script works.
> Which frankly, I'm not sure is worth it.

Didn't I make this prediction when we started the "text inspection"
approach that it quickly go downhill resulting in unmaintainable
mess rather quickly ;-)?

> Given the empirical results
> (both on the real code base and the new tests you add) and the low-risk
> nature (it's linting our tests, after all, not code users run), I'd be
> inclined to say it's not making anything worse, and probably making
> things better. We can find out about any further short-comings in the
> wild.

Amen to that.
