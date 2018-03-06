Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E8F4B1FAE2
	for <e@80x24.org>; Tue,  6 Mar 2018 22:53:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933008AbeCFWx2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Mar 2018 17:53:28 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36944 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932905AbeCFWx1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Mar 2018 17:53:27 -0500
Received: by mail-wm0-f65.google.com with SMTP id 139so1215612wmn.2
        for <git@vger.kernel.org>; Tue, 06 Mar 2018 14:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=0dYxTiEVHRv4l8DtGstZ/mG+9E/qfa6ZNOxFtoMCp9I=;
        b=Lm8/4dKCHT/Hh2uo/i6mS/xM5Em59Lv2Imw4VIxM5CfAmzqShTLfXhW0P8+C9aC31j
         UT71tqlmkWBiXSRhS4o6OSbZhT0Zp07DGOc14RR8+T0UBB4F3sJYK8gIv4uWenkW1sx4
         JBVfpYDOQGhcTo3vK8htw78mqxKpONnMNGGANZXMMnDWIiF9GD3IZcnevV2rGFkqI0vp
         lNivKmJnt5ylPceoOqY6nTr4kJasRSjiM1vubij4JsdawxekRT+zRPqdMXOTrdc5jCfT
         MNeJ4SUW0iSm9PSVpA30G46qt1B2KC/Uz26oN0LtSFGOVEEH30M/C25jGsy77+W+HA7G
         uD2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=0dYxTiEVHRv4l8DtGstZ/mG+9E/qfa6ZNOxFtoMCp9I=;
        b=WogL1ZsxzTQfc56v+Vl+0fEFQx+U47Cqow2iwVbPrHF+ooRg4DT5XvdEWAv9K2GMU1
         NAujVTurFuidUy7IdViMbGsryvKY+HFCqqbaeoBYpTs1Aok/U1Pi9jgWxSyQIB/kN/1u
         5k7ZhzkEhY4IN01fmZ+tEKOsmbzQkwH3KEvpeBsRFikHhrrFagg7RSKDpZ39/lW8ZXK+
         fPTN4WTaq7Ikh0FNKWl7B+uHISRJ9VMSSOBVFdZsjaNYv6YDzw1ZtZ9fdf2zHK3xHQq8
         Gjsyqkec1y6ODom4izSzmPGkuAiupsmDgznD4cerTEqB/+Tdh7Us6TkbKa6m6AW22hhv
         mssQ==
X-Gm-Message-State: AElRT7EjeADe940rPbHuQsYfrkUljZc7vaKHEQQz3JKZl9OMPj/blhgS
        /uP3lxFI4YkoJkBAujJkLzQ=
X-Google-Smtp-Source: AG47ELsgrupIj3ZMEkNjCXMtwbB4o+75/9wsUQIfQicTgOd0DjqpCiyshIZ5XafF5UINnebJCaE24g==
X-Received: by 10.28.1.14 with SMTP id 14mr12006104wmb.40.1520376806504;
        Tue, 06 Mar 2018 14:53:26 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id c78sm10386103wmd.45.2018.03.06.14.53.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Mar 2018 14:53:25 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     lars.schneider@autodesk.com, git@vger.kernel.org, tboegi@web.de,
        j6t@kdbg.org, sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v9 4/8] utf8: add function to detect a missing UTF-16/32 BOM
References: <20180304201418.60958-1-lars.schneider@autodesk.com>
        <20180304201418.60958-5-lars.schneider@autodesk.com>
        <xmqqvae92ajv.fsf@gitster-ct.c.googlers.com>
        <0DCED348-C6DB-49B2-8C0A-E4E1F485B255@gmail.com>
Date:   Tue, 06 Mar 2018 14:53:25 -0800
In-Reply-To: <0DCED348-C6DB-49B2-8C0A-E4E1F485B255@gmail.com> (Lars
        Schneider's message of "Tue, 6 Mar 2018 23:39:16 +0100")
Message-ID: <xmqq8tb43jfe.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

>>  Also "UTF16" or other spelling
>> the platform may support but this code fails to recognise will go
>> unchecked.
>
> That is true. However, I would assume all iconv implementations use the
> same encoding names for UTF encodings, no? That means UTF16 would never be
> valid. Would you agree?

After seeing "UTF16" and others in "iconv -l | grep -i utf" output,
I am not sure what you mean by "Would you agree?"  People can say in
their .gitattributes file that this path is in "UTF16" without dash
and that is what will be fed to this coe, no?
