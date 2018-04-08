Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEEE51F404
	for <e@80x24.org>; Sun,  8 Apr 2018 13:00:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751770AbeDHNAD (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Apr 2018 09:00:03 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:46262 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751601AbeDHNAC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Apr 2018 09:00:02 -0400
Received: by mail-wr0-f194.google.com with SMTP id d1so5680933wrj.13
        for <git@vger.kernel.org>; Sun, 08 Apr 2018 06:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=fIF4/alhvK4ZjFAE+RJOE0FUwIUZZJ+EVRfRuvvQpAA=;
        b=h3Uxy5/SsUfSTIt+++TATL1kR+LJGw+8Wfotw+rke9JzCjPmuON9MD59Y5v8tTPmYz
         lA4GnJx8Lg0n2LtaokREVkundhKNptfIYuPrTG2tVOBua15n9ba+qoXxeETWvFQIBVRh
         tWAOmKI6RETqEIoyyZhEdSXpoCVa1/qRwVVc7xbZ2sky92lpDIkH/WkBeuJQpk1pkuCW
         KliGC5ra0B8XlnCPH6rXMNSqEO0tDeyMOE9qhP7klKeFlxa9QvZCJejObaNGDGdQydxt
         pyu1bfc7LnmVM8C326Xq3PYFNMPajWzm69jg+gNL9JTdACrQc+g/jE3NQqvRZYE9ue4/
         am+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=fIF4/alhvK4ZjFAE+RJOE0FUwIUZZJ+EVRfRuvvQpAA=;
        b=i23ab/7lf6YMihzAKc5Qv9Tc3peim/X63DnUahHgtPqX/RDFbFvejnV/hXzQIxCYBc
         A9ELVV/cXb8PhC5sVrcb9YkV7eUhhwZsgiSaFVgdmWLq8+ThDSw5jGHMGCLcTk8toFu6
         1512QEDa7VlgT88FhMRhWOuOk/h52Mwa4r+rUTSCE4badJOt1JGWE28j/rF0LO0Km1dG
         Dt5TRlRFDpaozp7Wht/sqASebRJJRlczVh5j57+t38tYp4pdQ4ljoovCNU4Bp6JMmliq
         J8q/0fXtqkmp3Y1y9WAYTKkVDq2fOE3NO36yZH3TtBg7fqvnp+Essju3UmTXwOVuCob8
         jJhA==
X-Gm-Message-State: ALQs6tCD4xl/eTLQQFiFNTjaH5TW7gSaEGZa715QvLyr65V8bYywrbhj
        gC5tsdjiC1VXk0+OlAdgjzA=
X-Google-Smtp-Source: AIpwx4/kD/azHCQXhoaeCYX73UEGDKiQ20n7HjgPcM+YGsW+Ny6B2Fmst+oJuO5gR7vmzf1DdHTxcA==
X-Received: by 2002:a19:b588:: with SMTP id g8-v6mr20394958lfk.90.1523192401467;
        Sun, 08 Apr 2018 06:00:01 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (aga121.neoplus.adsl.tpnet.pl. [83.25.156.121])
        by smtp.gmail.com with ESMTPSA id q28-v6sm2969419lfb.84.2018.04.08.05.59.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 08 Apr 2018 06:00:00 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, sbeller@google.com,
        szeder.dev@gmail.com, ramsay@ramsayjones.plus.com,
        git@jeffhostetler.com, peff@peff.net,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v7 08/14] commit-graph: implement git commit-graph read
References: <20180314192736.70602-1-dstolee@microsoft.com>
        <20180402203427.170177-1-dstolee@microsoft.com>
        <20180402203427.170177-9-dstolee@microsoft.com>
Date:   Sun, 08 Apr 2018 14:59:57 +0200
In-Reply-To: <20180402203427.170177-9-dstolee@microsoft.com> (Derrick Stolee's
        message of "Mon, 2 Apr 2018 16:34:21 -0400")
Message-ID: <86woxhdfaq.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

[...]
>  EXAMPLES
>  --------
> @@ -45,6 +51,12 @@ EXAMPLES
>  $ git commit-graph write
>  ------------------------------------------------
>=20=20
> +* Read basic information from the commit-graph file.
> ++
> +------------------------------------------------
> +$ git commit-graph read
> +------------------------------------------------

It would be better to have example output of this command here, perhaps
together with ASCII-art diagram of the code graph.

[...]
> +	if (!graph)
> +		die("graph file %s does not exist", graph_name);
> +	FREE_AND_NULL(graph_name);

Shouldn't the error message be marked up for translation, too?

Regards,
--=20
Jakub Nar=C4=99bski
