Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5887F1F62E
	for <e@80x24.org>; Wed, 16 Jan 2019 04:16:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731821AbfAPEQH (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Jan 2019 23:16:07 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33837 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728227AbfAPEQH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jan 2019 23:16:07 -0500
Received: by mail-wr1-f67.google.com with SMTP id j2so5376218wrw.1
        for <git@vger.kernel.org>; Tue, 15 Jan 2019 20:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=Uij4CW/y8g+EVyRuagOX3fsZ81+bZHpdMXlHnE2nESk=;
        b=i3Mbz+ju1bUPjvKoOi8KO2U/tbwGgggYT5671YOIYwv21K2dpq1/aUnZMC3bUKli0/
         pviaGEz3REV9JzYKxWiJnfh0CIKC5tEcXzkEX5B1ZHCRcqzWBU7O/2Bq+sVqS/0Nglk5
         sRw72e7jmiLRj8HJU7a2qTrKYruhIVr3bNE4GlaIru1+Ktfpgg8kza4ZsdZywdFOlSw0
         4Y5qVzjOkEhzEgkJMWcsdwk83mJzvc0R8LancmLwjJ0IIxn6exxNzZyj5laKwJ1ZbaHo
         T6hlLq26rXUm6MWy+tZFKlp7wYebJcz1EkHb3E91D9ITkWGj1W8mCBZXDpj8WDqTS/BD
         thpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=Uij4CW/y8g+EVyRuagOX3fsZ81+bZHpdMXlHnE2nESk=;
        b=bdXzLIoFZ11fBneAPy+KsCl2mwaqKPYLVEG0sZuNgOklA2D6NHL/fw75r3x8ghy1tM
         RR8R/UNOL+kkngpR3THNNmInjKTmz1TZmGCic34MxvNmZl1EBDXA1W+3K1miuwz5OEQv
         0UAKKda1kMPs3Db7fXOer1EbnpHIDUXe3vWFVyEL7VSaxzzq3T5RFUianp80ZRANXxXd
         WWopCcBooncHjX6Tc/g55ifn5D66Qb7JAUEyR7Xw3oqptORebgs3k6CusoS5rqfS58+D
         DHuByVu9k4gchXSx3nNzYf94VNy2agVAEvlADGg57jt6RPA3ko0UXEOdfNVe1K85LlbS
         9nAg==
X-Gm-Message-State: AJcUukf9oOCgYbec5hLdpk4uY8JS/qO4eTN8+wrHdee/3i8cpho6JA10
        s4RfQ9GF4N2YLp7ayAt5voM=
X-Google-Smtp-Source: ALg8bN6Gpu9UVCQxcn8XUGEoEQgMajeimOzaayd/sbioAggxXqcNP1IWpo9itByHnq5xJGhs/ILOww==
X-Received: by 2002:adf:fc89:: with SMTP id g9mr5514512wrr.96.1547612165521;
        Tue, 15 Jan 2019 20:16:05 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id t5sm36332321wmd.15.2019.01.15.20.16.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Jan 2019 20:16:04 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/5] compat/obstack: fix -Wcast-function-type warnings
References: <20181220162452.17732-1-szeder.dev@gmail.com>
        <20181220162452.17732-2-szeder.dev@gmail.com>
        <87zhszeqsr.fsf@evledraar.gmail.com>
        <xmqqef9k1a4n.fsf@gitster-ct.c.googlers.com>
        <20190111003743.GA840@szeder.dev>
        <xmqq4lafysve.fsf@gitster-ct.c.googlers.com>
        <20190111185118.GD840@szeder.dev> <20190115235546.GF840@szeder.dev>
Date:   Tue, 15 Jan 2019 20:16:04 -0800
In-Reply-To: <20190115235546.GF840@szeder.dev> ("SZEDER =?utf-8?Q?G=C3=A1b?=
 =?utf-8?Q?or=22's?= message of
        "Wed, 16 Jan 2019 00:55:46 +0100")
Message-ID: <xmqqtvi9nsor.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> writes:

>> Well, first I'm not sure what changes Ævar meant to be backported.
>> Back then I briefly glanced at glibc's gitweb [1], but didn't see
>> anything remotely relevant to these compiler errors.
>
> So, I looked at the gnulib repository, where glibc got it's
> obstack.{c,h} from, and it does have a fix for this issue in commit
> 127ed6a3e (obstack: avoid potentially-nonportable function casts,
> 2014-11-04):
>
>   http://git.savannah.gnu.org/cgit/gnulib.git/commit?id=127ed6a3ea9c46452f079dee50382dc1f70ea796
>
> It chose basically the same approach as my fix, i.e. storing pointers
> to functions with different signatures in an union.  However,, the
> differences between our and their obstack.{c,h} are way too big to
> backport their patch.

Thanks.  In the meantime, I've queued your fix in my tree, and with
your digging, we can say we did due diligence and apply a local fix
with conscience ;-).
