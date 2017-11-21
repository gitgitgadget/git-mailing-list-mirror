Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C85D72036D
	for <e@80x24.org>; Tue, 21 Nov 2017 23:42:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751409AbdKUXmq (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 18:42:46 -0500
Received: from mail-qt0-f175.google.com ([209.85.216.175]:44646 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751290AbdKUXmq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Nov 2017 18:42:46 -0500
Received: by mail-qt0-f175.google.com with SMTP id h42so21507458qtk.11
        for <git@vger.kernel.org>; Tue, 21 Nov 2017 15:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8YV9KolG1mwM/O5e87xBOLpg5PgROzvxorPj0DJcY80=;
        b=uk9jb6MyxF+GBGp3bU1KiPFaBAL0m2Jo1wQVcJ9FVpRENPxg0yv6M2ItgN+uB2Jtj5
         7Q1UrbIMW4sRB5TFLqeDmB2CArblAhXEpp1r5qQioZnB1+cZ9ZUKMHfJ2n+9I3h9vRlo
         CWKdbMSHGTUOuCKK/H+rPIG7quSmxyShsJ+e1z1oBB8NXWK55reMil/GzSVbQbzOtF3R
         e9d3DZM8fDioRbRhrA6MOZQ1Cfx+2+OWg3wvsVdWKn9t0zQNlw8xJkgAkXgF6rXsC2PW
         XcJi2PIyMDbPV1IVIhfny0ZeeywqtazpknTi4YJXPJOne9u9SSAJnXzNGHgXE0Q/Qhhl
         9H6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8YV9KolG1mwM/O5e87xBOLpg5PgROzvxorPj0DJcY80=;
        b=DJbJf2HtdPxjXuhwhNMe7QOuJvSMetjBZUqfBeNbvrEm/4dmwofMf2uCiP2ZcHNrLo
         4DAKGjHjAST88mJpS0ItMeURpPuomK+01F43MbGFzHfINZLWLw/oA7NUCphRGwY28fhW
         LUJfuO1R9JJPhF4pHpmu8tRNU+cOa8eggbXAvCsw4wqEGATIE2AR+BhK/Ju5L6PxP/2p
         j/3omN3xIqyVv5+PVh2RsVQ+ZE/GRS2zR4q5E/BZVBjxmUK4wTXbkkEDqx6Uc/DNYR5P
         QUhXNTrXID0k21Frv9613GPoIVO+OTOeDG4kSHL0/XcKkctpB/D8BeIbA60XSs7S0XAC
         Txpw==
X-Gm-Message-State: AJaThX7NI3aHSHatGOslajCWXim1EctB113Vd4BuEdFtUNqSSm73N22r
        V/oZ2IN5bYZqyfsjjPCiSqxVfvzTk0k1a1tZiZ7Pxg==
X-Google-Smtp-Source: AGs4zMblqcA/Asdo+ylPoRkip7Ip+pikukXx63KxE+Hlf8ARdwGr85u3bY7CZa6ikB97wLZpQWbiPcwxDHoYhgJcT7U=
X-Received: by 10.237.61.181 with SMTP id i50mr31347437qtf.29.1511307765063;
 Tue, 21 Nov 2017 15:42:45 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.85.179 with HTTP; Tue, 21 Nov 2017 15:42:44 -0800 (PST)
In-Reply-To: <20171121014919.p4cl5esf7evptzbk@aiede.mtv.corp.google.com>
References: <20171120212134.lh2l4drdzu6fh5g2@aiede.mtv.corp.google.com>
 <20171120212223.wquyxbmz34foynrk@aiede.mtv.corp.google.com> <20171121014919.p4cl5esf7evptzbk@aiede.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 21 Nov 2017 15:42:44 -0800
Message-ID: <CAGZ79ka6HVtF10K9_t30E0bjRzc+Ac-GZB99fqoU5CVvUjooug@mail.gmail.com>
Subject: Re: [PATCH 1/8 v2] ssh test: make copy_ssh_wrapper_as clean up after itself
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Segev Finer <segev208@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 20, 2017 at 5:49 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:

>  @@ -317,7 +317,7 @@ test_expect_success 'set up ssh wrapper' '
>
>   copy_ssh_wrapper_as () {
>         cp "$TRASH_DIRECTORY/ssh$X" "${1%$X}$X" &&
>  -      test_when_finished "rm -f ${1%$X}$X" &&
>  +      test_when_finished "rm $(git rev-parse --sq-quote "${1%$X}$X")" &&

I wondered why the line above doesn't need the same treatment, but there
the argument is quoted, in this line we cannot use quotation as we are already
using it for bundle up the argument for test_when_finished.

The patch looks good.
Stefan
