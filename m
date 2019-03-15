Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 381F920248
	for <e@80x24.org>; Fri, 15 Mar 2019 10:39:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728883AbfCOKjp (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Mar 2019 06:39:45 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37954 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726559AbfCOKjp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Mar 2019 06:39:45 -0400
Received: by mail-ed1-f65.google.com with SMTP id e10so3274608edy.5
        for <git@vger.kernel.org>; Fri, 15 Mar 2019 03:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=+M6LxxBDSk38pmLSf1QuDWpnW9Lmdfsp4xeg9zU3AfI=;
        b=spL4l2Mup48eo45psihjPmggNnIvgXJBKzMfHZtao1auFtrKb+MQ/lRwcVuWSIULcO
         WDBcwcydUWJ8MkfJQl310Ij35hAfhMRA0t16szKHtOuPAYsQLgqB4ZiM8gnAiOIHkQjh
         yf/amnOkbye0HXTkksk9KSX0MiatV21dGkmG+8S+RnulupvT37+hHzL30+WdjYFcup7B
         Z3YH2SEwCH2HRz1AD9r2yNUBu7317dLOwvY+NP+ZrFt6/ucxRDPXY/0h70aDtGTp3hW2
         urYh2cDJBureJw2GFLjU9bTtmW30mv3/4cYR6O1iKMGomYF34pOGc08BhOKXhPmuqZfd
         pFJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=+M6LxxBDSk38pmLSf1QuDWpnW9Lmdfsp4xeg9zU3AfI=;
        b=S25OR2nyFw1xQwmAB1NqMjg8OUA/CYsr2PPeU9wSELWsbAVhg9A8+yfvjHd2rBbrGd
         I+AVzs7yI513HFBImNOUE1zwYeEgwlgFrViatE75BQMNlcUmXB4EoQAxDsO3sf1+y6CO
         3MdV3vW9+su+89HEKwv0Fp+pHZtspgSIs+meaLyngbTlYbZxzB4Oc09jZDtsT6AikZW2
         4lV6TMLGuCT3DtLpkrbh3RmD3p1q4PeMIowCsYLEQcqeV7HQAuuD0mcVY/adYVEtqEyo
         /XcgSRkyCHs5KqL+CrQXmEr6IoiDlsGE2X0rWQe17Wyh5GSSFLUQ8EMuOEoZj/KeJ0Uv
         H8uw==
X-Gm-Message-State: APjAAAW2/kAjX7i2SSjWL9t59UnTAEfoYGZTUw1a0RQVpdpSIXLfwRIC
        rXlmfIqLLPfnYaLzZcJD+HU=
X-Google-Smtp-Source: APXvYqybM2cc891Lr8b/9iLGrIswnasQJ/guwbl0p+Eoj6/HbGAEfuntTWJ6ZtBrmLA4W5i+UCJcXQ==
X-Received: by 2002:a50:b641:: with SMTP id c1mr2208121ede.155.1552646382869;
        Fri, 15 Mar 2019 03:39:42 -0700 (PDT)
Received: from evledraar ([5.57.21.49])
        by smtp.gmail.com with ESMTPSA id i9sm334126ejc.67.2019.03.15.03.39.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Mar 2019 03:39:42 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v2 0/8] commit-graph: segfault & other fixes for broken graphs
References: <20190221223753.20070-1-avarab@gmail.com> <20190314214740.23360-1-avarab@gmail.com> <CAPig+cTZAhRekr0Yvmtb-gTEATEX19RO0=Zh-ycCPkyEc0OxxA@mail.gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <CAPig+cTZAhRekr0Yvmtb-gTEATEX19RO0=Zh-ycCPkyEc0OxxA@mail.gmail.com>
Date:   Fri, 15 Mar 2019 11:39:41 +0100
Message-ID: <875zskbevm.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Mar 15 2019, Eric Sunshine wrote:

> On Thu, Mar 14, 2019 at 5:47 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>> I fixed a test to avoid the pattern a0a630192d
>> (t/check-non-portable-shell: detect "FOO=3Dbar shell_func", 2018-07-13)
>> tests for. The new pattern is more obvious.
>>
>> As an aside I don't get how that doesn't work as intended from the
>> commit message of that commit & its series.
>>
>>     $ cat /tmp/x.sh
>>     sayit() { echo "saying '$SAY'"; };
>>     SAY=3Dhi sayit; sayit;
>>     $ sh /tmp/x.sh
>>     saying 'hi'
>>     saying ''
>>
>> I get the same thing on bash, dash, NetBSD ksh, Solaris's shell &
>> AIX's. I.e. it's explicitly not assigning $SAY for the duration of the
>> shell [...]
>
> The shells you tested may all behave "sanely" given that input, but
> not all shells do. For instance, on MacOS, the factory-supplied bash
> 3.2.57 behaves in the "broken" way in 'sh' compatibility mode:
>
> $ cat /tmp/x.sh
> sayit() { echo "saying '$SAY'"; };
> SAY=3Dhi sayit; sayit;
>
> $ /bin/sh /tmp/x.sh
> saying 'hi'
> saying 'hi'
>
> $ /bin/bash /tmp/x.sh
> saying 'hi'
> saying ''

Thanks. Also I found (with help from Freenode ##POSIX) that this part of
the spec[1] talks about it:

BEGIN QUOTE
    Variable assignments shall be performed as follows:
    [...]

    * If the command name is a function that is not a standard utility
      implemented as a function, variable assignments shall affect the
      current execution environment during the execution of the
      function. It is unspecified:

      - Whether or not the variable assignments persist after the
        completion of the function

      - Whether or not the variables gain the export attribute during
        the execution of the function

      - Whether or not export attributes gained as a result of the
        variable assignments persist after the completion of the
        function (if variable assignments persist after the completion
        of the function)
END QUOTE

I.e. this is undefined behavior that just happened to work on the
various shells I tested. Makes sense, was just wondering if I'd entirely
missed out on what behavior was, turns out it's just fairly rare.

FWIW My bash 5.0.2 on Debian behaves as I noted in both sh and bash
mode.

1. http://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html
