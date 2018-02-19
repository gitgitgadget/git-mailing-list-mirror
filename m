Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11DE31F404
	for <e@80x24.org>; Mon, 19 Feb 2018 03:45:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751914AbeBSDpn (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Feb 2018 22:45:43 -0500
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:65484 "EHLO
        alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751696AbeBSDpm (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 18 Feb 2018 22:45:42 -0500
X-AuditID: 1207440f-acfff70000000ab0-4e-5a8a4863a52c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id DA.36.02736.4684A8A5; Sun, 18 Feb 2018 22:45:40 -0500 (EST)
Received: from mail-io0-f180.google.com (mail-io0-f180.google.com [209.85.223.180])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id w1J3jcm8019541
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT)
        for <git@vger.kernel.org>; Sun, 18 Feb 2018 22:45:39 -0500
Received: by mail-io0-f180.google.com with SMTP id n7so9920126iob.0
        for <git@vger.kernel.org>; Sun, 18 Feb 2018 19:45:39 -0800 (PST)
X-Gm-Message-State: APf1xPBKJnf64vUTDSC79glfQWLLs6ECT9I1l/ujpGxzoPgw0Y2cKh3x
        hsFxjPe51Uh13N/0aTTDRZ6Efvwq0OZQaGEhaYI=
X-Google-Smtp-Source: AH8x2274X0qVJnAApKBMeRng2ygDR2goZ9vcaH5oL343ChYeBOlsEVIAXTOzZmJiz1dWjF+VAADXXALMYXx+iFZBIDU=
X-Received: by 10.107.43.7 with SMTP id r7mr17544277ior.302.1519011938890;
 Sun, 18 Feb 2018 19:45:38 -0800 (PST)
MIME-Version: 1.0
Reply-To: mhagger@alum.mit.edu
Received: by 10.79.199.68 with HTTP; Sun, 18 Feb 2018 19:45:38 -0800 (PST)
In-Reply-To: <20180213234149.GA21964@sigill.intra.peff.net>
References: <20180213234149.GA21964@sigill.intra.peff.net>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Date:   Mon, 19 Feb 2018 04:45:38 +0100
X-Gmail-Original-Message-ID: <CAMy9T_Ho6cypqgtp9gnZtbgnO-F778pe2B3qAbu1XoTBQw9xLQ@mail.gmail.com>
Message-ID: <CAMy9T_Ho6cypqgtp9gnZtbgnO-F778pe2B3qAbu1XoTBQw9xLQ@mail.gmail.com>
Subject: Re: [PATCH] sq_dequote: fix extra consumption of source string
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOKsWRmVeSWpSXmKPExsUixO6iqJvq0RVl8HCagEXXlW4mB0aPz5vk
        AhijuGxSUnMyy1KL9O0SuDIefLzEWLCSqeLUIrsGxneMXYycHBICJhLd3W+BbC4OIYEdTBKN
        /ztZIJynTBKTTneyQzi9jBJbp3dDtZRL7F25iAXCLpK49u42O4x9eP40MJtXQFDi5MwnYDVC
        AnISrzbcAOrlALK9JE7sYAIJcwpYS7z/9RkqbCWxaFoMSJhNQFdiUU8zE0iYRUBVovuTJcTw
        RIkppy4yQQwPkLj98AAriC0s4C6x48MBZhBbREBW4vvhjWBHMgtoSWz++Y0dwtaUaN3+m30C
        o8gsJLfNQpJawMi0ilEuMac0Vzc3MTOnODVZtzg5MS8vtUjXRC83s0QvNaV0EyMkrPl3MHat
        lznEKMDBqMTDK7CxM0qINbGsuDL3EKMkB5OSKG/D+fYoIb6k/JTKjMTijPii0pzU4kOMEhzM
        SiK8992BynlTEiurUovyYVLSHCxK4rzqS9T9hATSE0tSs1NTC1KLYLIyHBxKErzf3bqihASL
        UtNTK9Iyc0oQ0kwcnCDDeYCGJ7kD1fAWFyTmFmemQ+RPMbpyfJv1oI2Z489eENm28gmQ/Dbt
        OZC88eJ1G7MQS15+XqqUOK8ESLMASHNGaR7cfFj6esUoDvSuMG8CSBUPMPXBbXgFtJwJaPlq
        EZDPiksSEVJSDYyZ14tyfkmIVk81Ys4JNJW+bvw6a/oWncCVlTW6TK+dzb14zy/aElDQ9/VY
        ZqBjmot6RVghR0fs/W6h+keJVmJslvbbJ/D5h09X157ecbZfgD9p3q+79pcSus02Pnwj1bfx
        1FkOC4cFndos2vx6P/awi/yb+P/Ets6lkS3n9m22yVBSf/DtsxJLcUaioRZzUXEiAG1RJ4g6
        AwAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 14, 2018 at 12:41 AM, Jeff King <peff@peff.net> wrote:
> This fixes a (probably harmless) parsing problem in
> sq_dequote_step(), in which we parse some bogus input
> incorrectly rather than complaining that it's bogus.
> [...]

LGTM. Thanks for taking care of this.

Michael
