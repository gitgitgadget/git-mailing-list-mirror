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
	by dcvr.yhbt.net (Postfix) with ESMTP id DE5551F404
	for <e@80x24.org>; Sun,  8 Apr 2018 13:50:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752037AbeDHNuW (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Apr 2018 09:50:22 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:38289 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751549AbeDHNuW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Apr 2018 09:50:22 -0400
Received: by mail-wm0-f65.google.com with SMTP id i3so10883708wmf.3
        for <git@vger.kernel.org>; Sun, 08 Apr 2018 06:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=7Ia/6aYYfrdwtJFdXb00J1NPaEmQUbX/sqUT/qeoRqc=;
        b=rXF68G+R/8VEsGFeuX8YXoqlAJK1jeV9vv0VsZHKSBfTV8YuUoVvjIzoRxUMn+SDlZ
         IY9If66Ta8lXjolM04QWQ1zKi4wGz4chUtj9Pez6GXz5AUrcKdDYurOub1HO1PP+KNcy
         dkDGnLftNGDYALVD873bUx+J7AZrfnHsAuFLR5tKgQ8woUQ5RE8tGloqiyq2EAQKNtgZ
         u5llLwiofa6Mgp9qWvhp2O+8gcoeYLwYSkxpOMHaQbtVogBK1auE6Z4s+NRT3YBwNndo
         OqIHjLJIckSmg9Jn5K7ALvtwp4CHQfQnM5qlqJ+rY7PfWDpnS8HLuj1iZE+rjS6158JO
         IpuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=7Ia/6aYYfrdwtJFdXb00J1NPaEmQUbX/sqUT/qeoRqc=;
        b=iw06Pr9xJkaH5MBUxCALxs3ziS+AmiWDcJxWYlwsGf1dMwV7iSNCjP5q+UtA8m1tdd
         ZGEQjeQ3PBR2mCjpDW4HeFXfPzSPUeKsGNPVZDi3xlpb+Lry9uamcm19C942GGJDAk+l
         tepIuIYli1v8ymPzTmSLhCGcugef1I/Kwju1Y7t4S65NC15pBWDZXBQwseoHEhvRIWoo
         dRCM31cYhyKyKc6KsLk7k8bOOgTYdVJBfeGW/JDx0vE/YgYlezmRp/wtU4BqRaKrWu6F
         bTdjIRbCwTnh3dTcMuRhg7ojyUp3g2QBh5Jvsbj3JubJV+SMjibk6I2IxPwnmcxAwYp2
         a9kA==
X-Gm-Message-State: ALQs6tDdektEwxJasYdKJ4Rz7OzEF9nRaI4QC7pNxx+rpyd6zbK3tPf4
        hbQPuMl4ktjMKgAIQYBtxp8=
X-Google-Smtp-Source: AIpwx4/Lr7bW5/XOebWyZdtpMw9CwOMseesaBzz4YyDDzATnAmXwhW2gzl2d3Ilv4am9XLpPC+m3sQ==
X-Received: by 10.46.144.72 with SMTP id n8mr8020637ljg.96.1523195420808;
        Sun, 08 Apr 2018 06:50:20 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (aga121.neoplus.adsl.tpnet.pl. [83.25.156.121])
        by smtp.gmail.com with ESMTPSA id w73-v6sm2992780lfi.60.2018.04.08.06.50.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 08 Apr 2018 06:50:19 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, sbeller@google.com,
        szeder.dev@gmail.com, ramsay@ramsayjones.plus.com,
        git@jeffhostetler.com, peff@peff.net,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v7 13/14] commit-graph: build graph from starting commits
References: <20180314192736.70602-1-dstolee@microsoft.com>
        <20180402203427.170177-1-dstolee@microsoft.com>
        <20180402203427.170177-14-dstolee@microsoft.com>
Date:   Sun, 08 Apr 2018 15:50:16 +0200
In-Reply-To: <20180402203427.170177-14-dstolee@microsoft.com> (Derrick
        Stolee's message of "Mon, 2 Apr 2018 16:34:26 -0400")
Message-ID: <86o9itdcyv.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> @@ -96,10 +101,12 @@ static int graph_write(int argc, const char **argv)
>  			     builtin_commit_graph_write_options,
>  			     builtin_commit_graph_write_usage, 0);
>=20=20
> +	if (opts.stdin_packs && opts.stdin_commits)
> +		die(_("cannot use both --stdin-commits and --stdin-packs"));

Here error message is marked for translation, which is not the case for
other patches in the series.

--=20
Jakub Nar=C4=99bski
