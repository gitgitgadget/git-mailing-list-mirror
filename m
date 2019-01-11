Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1FD3211B4
	for <e@80x24.org>; Fri, 11 Jan 2019 18:03:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732407AbfAKSDG (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Jan 2019 13:03:06 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40921 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731964AbfAKSDF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jan 2019 13:03:05 -0500
Received: by mail-wm1-f68.google.com with SMTP id f188so3213721wmf.5
        for <git@vger.kernel.org>; Fri, 11 Jan 2019 10:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=HDCRPon50k1osAFkVX1kf35zQqEhh5vZLOZzbteP+pM=;
        b=ujx5x16YF2pAiLTsR0PS0mN1Zx0RsPfsOfan/EXFiGVK3Fyk/fSTUgGlsZMeiSXY1d
         G03JtUhVsyNgtfJydJAmH46ZcmX6ZUjTF5VX457OQt8mMouG6UQWu+NHfo60ioYQ4KxN
         8sRq1Uknm4VvH8/0flNuXm+tiKTJDTcK5G6GhnyX7+G2vcU1bVj7n+dNngRC/0KUPn+h
         ot+Vf2bZKBEYgDFyfoQJnaa73DMlDVGNhPmTzwjbwAgD1uf6w0jpnIFmtYS9sg76X3Ym
         p3iHwl1IglPCaVo6HfhPkoaRM3Ydp8glYyXo1kp+N3w5f/DvfF4gUE6KOnEwj2bngBjn
         EM2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=HDCRPon50k1osAFkVX1kf35zQqEhh5vZLOZzbteP+pM=;
        b=AobPTMGFNAyWHiD9TGkY2qRFHzyh59MpJpxOw4wsABdGLV87t0W4LfMyHIglR2KGp4
         F7DG1VbA2nNMkhHYDvtneycfrdJg1XQRsxYqDYr/5Ph7quuZqIVM3TBjxgmFt/IXBVgb
         NSTiWWhf7xA5UacDLhiWHeTNHDQC2Yqk7WeONHnnpegewT8Kck2tdZVAg0yyUV6k0ipG
         9zLKqyygcb1lAyU+YzFODD+K5NCjBsvUmdwlkxSNqYzCIRXlUYmwZHcAMoiCwl+KpvLW
         7KQGJF+bJkOYJsBMUGgV3EH7k1TnPHozwuL/ZIWuZpRyNGdy1eGp9PuEaP7MlxfdPLIE
         MBQg==
X-Gm-Message-State: AJcUukc+BaN0rsHddF7lDiwZhkedYMw2oas/DwF7NbPZI2f2eaQdtSYh
        ZawZngs4Qidih7Qwz+cJ1iU=
X-Google-Smtp-Source: ALg8bN42tkJ1dXKdbJLKod9AVkxbJUACc73LeedZV82BogOS3/JAtX3wso2KgPH4WM0YT/RNw/ugxg==
X-Received: by 2002:a1c:4855:: with SMTP id v82mr3214395wma.15.1547229782763;
        Fri, 11 Jan 2019 10:03:02 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id a17sm63946684wrs.58.2019.01.11.10.03.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Jan 2019 10:03:02 -0800 (PST)
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
Date:   Fri, 11 Jan 2019 10:03:01 -0800
In-Reply-To: <20190111003743.GA840@szeder.dev> ("SZEDER =?utf-8?Q?G=C3=A1b?=
 =?utf-8?Q?or=22's?= message of
        "Fri, 11 Jan 2019 01:37:43 +0100")
Message-ID: <xmqq4lafysve.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> writes:

> On Thu, Jan 10, 2019 at 01:22:00PM -0800, Junio C Hamano wrote:
>> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
>>  ...
>> > I.e. is this another case where we're blindly fixing bugs but should
>> > just re-import upstream's code instead?
>> 
>> Good point.  I am inclined to queue the remainder of the series
>> without this one for now.
>
> Note that without this first patch the linux-gcc build job will fail
> with the above compiler error, and that's the only build job that runs
> the test suite with all the misc test knobs (split-index,
> commit-graph, etc.) enabled.

I know.  

The point is to give more incentive to try what was suggested
earlier by Ævar (in short, "try to do the right thing, before
hacking around locally in this project" ;-)
