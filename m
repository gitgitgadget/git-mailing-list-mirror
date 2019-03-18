Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 547D720248
	for <e@80x24.org>; Mon, 18 Mar 2019 06:15:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbfCRGNG (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Mar 2019 02:13:06 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40521 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725967AbfCRGNG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Mar 2019 02:13:06 -0400
Received: by mail-wr1-f66.google.com with SMTP id t5so15597895wri.7
        for <git@vger.kernel.org>; Sun, 17 Mar 2019 23:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=2DrE3g0MDKSHzaz2Df6JSHBV8jNQS5plEiwd/J41yLw=;
        b=pg0xYWvRkrfD01J/mfUb9ZN814jmbAYg46v2Nqe22Glo+HgR+uMhxHx0JZaOG6keGw
         iVyEGXS9swm0NA1u082KVU4lXWolOvUleB+hOpLij98baFjD6698APys9nwhQBYEX7IZ
         e4f52BG/UBOolKsfblMOuzeLo5NetbhSZK9yY12jx+J146BDTxnTxry8brPSPg3w+tYs
         7mqMv2SZEtD8nwFPeNWc6IYZzw/6tVg3j0Esk0AAHhWzvAkvqq/WIdugQRon40YVjQBl
         XC97oVS15bLfx0MQJ4mZcVm3Epe1jCcXEAHMTQCOrZ269OnfE5ujC/LQxnkKKG9G02Wn
         EFEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=2DrE3g0MDKSHzaz2Df6JSHBV8jNQS5plEiwd/J41yLw=;
        b=EfdeOFVx+duJ3vYcSon4kPBRzDPh4VAp8PZMT3UvEJ/DSg6vnBf/z41nXK2OrdqDrp
         uQXZoy9WSWm4mT4J1V3THbADpJFXR1CEBwd2dHmmUo59znThrabmOslfvdSHcrfiQuWH
         4kihT8cs1x0pS6t56IC0NMa1dINemHdqjp6goSK2+GIG4a0DFTYuBKIYgqWflgrYKacf
         cltuGSlilLoxpzLS8G+QFPeWNU9QVFyDYcyMKjOwfbZTFtqI+8TZ72D6cRV2C+lMt/9z
         c+iazxYsNNenpzH7yURR2QglDKyJdgbuUv/cSKaA/o51GEwLY4PL2St9feTKeTvksN60
         UF3Q==
X-Gm-Message-State: APjAAAV//ERX+iGlMHyORIfvjYVbBSwy1NnVSQ47XqvKNtKG87Otws2c
        e2H0snu/xc4qa/e+8sntCAw=
X-Google-Smtp-Source: APXvYqz7TaQ0NBxwAkkS6Q6PppAjPHjeWuVsVnYFOWPiOs0MCfXONLSKYX/4jYRBdq2eZlf+8/EheA==
X-Received: by 2002:adf:d84d:: with SMTP id k13mr11822856wrl.154.1552889584546;
        Sun, 17 Mar 2019 23:13:04 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id e5sm12615946wrh.71.2019.03.17.23.13.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 Mar 2019 23:13:03 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3 0/8] gc: minor code cleanup + contention fixes
References: <20190314123439.4347-1-avarab@gmail.com>
        <20190315155959.12390-1-avarab@gmail.com>
Date:   Mon, 18 Mar 2019 15:13:03 +0900
In-Reply-To: <20190315155959.12390-1-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Fri, 15 Mar 2019 16:59:51 +0100")
Message-ID: <xmqqpnqo3e34.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> Changes since v2:
>
>  * The "let's detect that we don't need work in reflog expire" patch
>    is gone, as noted in a new set of tests/commit messages that was
>    tricker than expected, and not worth it.
>
>  * Minor rewording fixes to commit messages.
>
>  * Further paraphrased rationale in commit messages from replies to v2
>    feedback (thanks all!)
>
>  * The "no OID" and "no mustexist" case was confusingly conflated, now
>    we still do that in 8/8, but with a commit message & commit
>    explaining why and how that works.

All made sense (admittedly from a cursory look).  Will queue.

Thanks, all.
