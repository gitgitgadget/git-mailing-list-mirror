Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76C5A1F404
	for <e@80x24.org>; Mon, 12 Feb 2018 21:04:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754072AbeBLVES (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Feb 2018 16:04:18 -0500
Received: from mail-wr0-f177.google.com ([209.85.128.177]:40057 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753393AbeBLVER (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Feb 2018 16:04:17 -0500
Received: by mail-wr0-f177.google.com with SMTP id o76so13474580wrb.7
        for <git@vger.kernel.org>; Mon, 12 Feb 2018 13:04:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=CY1YJQmUv2zPJotZBq52qk5yBB/lv5tDSiICoFE/MYA=;
        b=c6MtsGZxFXOLzBODip49YHaVtBox/r5+C6a5jhH3f62R/IpgEURn3e7GlpFrjZuFc6
         vshRMlSsrAUJJ4yrzGJF1kaIBGTVgG82MdsQIbrupisaORXYP63N5M6ZnQ8pLyzZAlxB
         1QFwoCMyTrKFJXEufMRBmoiTbI0UST+BNXoKjbWahHUXNmz6w6tWtd3TGydMPe9EwuLa
         MLB+y7bTm5TN/DjbfAadfWqTHsFDsXJDFbIiaUFSHdCGjKO29jPvbF+CZUoobSvAN/BN
         vXBh6MSKIFqyDJHffoZ0aOMiWL27i9ucsxLDI/Y0HNoHF2VJQShTQ5ZPQZ05XFK8Nkm5
         KuVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=CY1YJQmUv2zPJotZBq52qk5yBB/lv5tDSiICoFE/MYA=;
        b=rGqlkgaRRky3QRPfCnXvPgT5aPYmHBDqWUdT3OYJvZz+avjOtI5/Hp7qDShneFVOIV
         erldTmKVL0gDzSJ9g9GciOGgxoX+DeM1EMKdjJxx9ztN/u5gruV46Au8Sm7PerBHryT5
         cm3cxWgUMQ6/iAeC4GjPaAJ7csJ0aRPIfxVggk67E0vEAPUr5JVvnt+upV+Pju+abyqu
         bnZ9M+R6vPydT+kmgjVC2wmz+bjWsttl8EOTmg7tI3ayJmjf7Q/ibmyE+QrJhQOh/mcQ
         TX8QmeJwL5H0MBAoNRSlVmMjD4Srp//6N9XFgZgMsQVlfssHPL0YoK+pF5Iv/hLq1TqA
         xlHQ==
X-Gm-Message-State: APf1xPBiBqH4KSJmW9JO/rE0YHxHIxw8O3Gklb1dLpjghzZf0yf67RQQ
        7r5fBfbjvzjVE4vRUSeTIQM=
X-Google-Smtp-Source: AH8x224pmIRzt9nRXLWo0zTt3bUTGAFtfSC6rD49QVU77GtEtBA6kfR+++SNw7dHPFTcvgWtkTVrjQ==
X-Received: by 10.223.184.36 with SMTP id h33mr11700808wrf.15.1518469455844;
        Mon, 12 Feb 2018 13:04:15 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id a53sm11319919wrc.52.2018.02.12.13.04.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Feb 2018 13:04:15 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>, Jonathan Nieder <jrnieder@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 003/194] object-store: move packed_git and packed_git_mru to object store
References: <20180205235508.216277-1-sbeller@google.com>
        <20180205235508.216277-4-sbeller@google.com>
        <xmqqsha9vmqt.fsf@gitster-ct.c.googlers.com>
        <CAGZ79kacD5Bevw==v3fbyWmz0FiDDM5ypkYuxHxbXJM62FX40w@mail.gmail.com>
Date:   Mon, 12 Feb 2018 13:04:14 -0800
In-Reply-To: <CAGZ79kacD5Bevw==v3fbyWmz0FiDDM5ypkYuxHxbXJM62FX40w@mail.gmail.com>
        (Stefan Beller's message of "Mon, 12 Feb 2018 11:00:59 -0800")
Message-ID: <xmqqsha5sywh.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> I thought it may be a helpful
> for merging this series with the rest of the evolved code base which
> may make use of one of the converted functions. So instead of fixing
> that new instance manually, cocinelle could do that instead.

Having the .cocci used for the conversion *somewhere* would indeed
be helpful, as it allows me to (1) try reproducing this patch by
somebody else using the file and following the steps in order to
audit this patch and (2) catch new places that need to be migrated
in in-flight topics.

But placing it in contrib/coccinelle/ has other side effects.

I can think of two precedents in this project, namely:

 - fixup-builtins in 36e5e70e ("Start deprecating "git-command" in
   favor of "git command"", 2007-06-30)

 - convert-cache in d98b46f8 ("Do SHA1 hash _before_ compression.",
   2005-04-20)

that are about tools that is useful during a transition period but
can and should be removed after transition is over.  These two were
done as one-off and added at the top-level, but perhaps we want a
new directory at the top (e.g. devtools/) to add things like this
and hold them while they are relevant?
