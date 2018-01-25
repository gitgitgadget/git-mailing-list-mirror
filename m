Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 563681F404
	for <e@80x24.org>; Thu, 25 Jan 2018 23:28:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751599AbeAYX2g (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jan 2018 18:28:36 -0500
Received: from mail-yw0-f172.google.com ([209.85.161.172]:36013 "EHLO
        mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751578AbeAYX2e (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jan 2018 18:28:34 -0500
Received: by mail-yw0-f172.google.com with SMTP id q6so3620226ywg.3
        for <git@vger.kernel.org>; Thu, 25 Jan 2018 15:28:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=UDPlNjCvoDVWoQu73Nwv38x6myrQteTttyUcC1X32R0=;
        b=VPvM9ucLzEpdkJRqwArutJ1+SEf1tezkEAydfBJ/D3VGuRYIIN6vBC/9dk73izuajW
         QaKrAnvgMIXc3sda2nbY+yZVn45VpnTUljO+F0dpu137eog5nz/mEbVI8Jaf3gHaOacZ
         eHSF/a4XhWxu9y9PHuI4kVCwKIObxuSlJW96b7htJRyo6Blh3eOx7MWqZyfTFhRlbu4+
         PhnHtZB6yHogCmJ8yeyPgYmpxJQkpdQUI1ImNAG2Jab7mBWU59GrSxVDQ0PyZOxx0GjE
         gpH6/+UFJ0oDyJfkKXEkc9IT8eq+t9mL+uu2MdeTVoDinzF07CMgxJBF5N3jqBMBOsVj
         4mjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=UDPlNjCvoDVWoQu73Nwv38x6myrQteTttyUcC1X32R0=;
        b=KA23Hj+DAO+VSTtzXlsh8k4HN/gQmeuVCAXUx0t0METcjqIVbOGqcSUFnttwUlWHSz
         R/JNyJQ9taUsfp5NcwlXT4t7Y4bayVVKR7YakjEVOBIprEknpi374kSiartaEEn4C8EJ
         m2vDDNCU8y1/kDjcmkxN62OuNF6mFN7jyImswMnanV+aYTX3gf57eiFviyTuIO1pSTZr
         Hm6fyYmYnzcZ6IreRGakbwsyu8CJHlxmAbd5c50pVGPb5EAGaJgqEPxY4YQVmxuwzKLp
         tTB/co+qlFXZ365W/WSJ9rXXE/EnDKQ4zUCZaDdwv1tKSbS8D3sb2EGqxHKR6V3dnuG0
         X8wQ==
X-Gm-Message-State: AKwxyteXR4IjWo0FH99ApvxxfM0RT2sExTQuNEE02YD7F2Chg+D0BYOV
        ehvAsFnmneDbyzC626dCR5lEYAvyGuJ0o49bvX2c3A==
X-Google-Smtp-Source: AH8x227T+nY1ut7clsKMsEGB9kWt74UelEd4f4yLgB2OBCI7A3NKwuyx/dwH8YwIRA1JlxMpbg0BR7eMvwt8Rjfjf3k=
X-Received: by 10.129.108.149 with SMTP id h143mr9777356ywc.373.1516922913411;
 Thu, 25 Jan 2018 15:28:33 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.210.209 with HTTP; Thu, 25 Jan 2018 15:28:32 -0800 (PST)
In-Reply-To: <20180125140231.65604-7-dstolee@microsoft.com>
References: <20180125140231.65604-1-dstolee@microsoft.com> <20180125140231.65604-7-dstolee@microsoft.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 25 Jan 2018 15:28:32 -0800
Message-ID: <CAGZ79kYQfHc398w5QMATotLYaCZW+sPiY05gGx9pGFm4GzBE+A@mail.gmail.com>
Subject: Re: [PATCH 06/14] packed-graph: implement git-graph --write
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 25, 2018 at 6:02 AM, Derrick Stolee <stolee@gmail.com> wrote:

> +------------------------------------------------
> +$ git midx --write

midx?

> +test_done

The tests basically tests that there is no segfault?
Makes sense.
