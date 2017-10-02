Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26D352036B
	for <e@80x24.org>; Mon,  2 Oct 2017 19:20:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751654AbdJBTUb (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 15:20:31 -0400
Received: from mail-qk0-f175.google.com ([209.85.220.175]:46558 "EHLO
        mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751613AbdJBTUa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 15:20:30 -0400
Received: by mail-qk0-f175.google.com with SMTP id k123so2774652qke.3
        for <git@vger.kernel.org>; Mon, 02 Oct 2017 12:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JCr768bSMR2NoNv6sq/8vKUAzUQFHrY+1BVXXTjMfaE=;
        b=RZz6B1DXVQMavpzkZldY2WUuAbfHWzT+bdBDQkYHaTwz4H9HJiptca8pX/eFoF59q3
         PS2GKm/Brp6dMyYnUEBlaCM7VGcKwqo7k+SC24RrN2pcyxDS/NwtTEeuCFBR3J2D6SQb
         PE/qMuxM+lLLk5FrfMSq0PdqSaM5x9cS9oE4tjYsI64wwbDT3mOWMDKWhdjuO2X3DMkr
         pMhyaL8nxhQ88krob+0O+gsQagGlHCVXrLQePq7NEw/DwBfkpmkenrNQ3eG04UY1i9uN
         RmoNyule/DU4Sg2v69HyxmUdHZjUh1SnE53NOgFvAxJNceSp4TCbye1ppHnzXR/XE4g7
         Om0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JCr768bSMR2NoNv6sq/8vKUAzUQFHrY+1BVXXTjMfaE=;
        b=GnoBAkkiAeP8yqLWN99xLK25CV6nB4GLCcTjs9I2Pa8alZ63EZZAJ4XkdDGyCIdj6l
         DJGmYOLBOQWwquxNLS9XzNZQjfD+nPU26yoyHgJhtCX3ANe8jQAAKWIGSvKmy1lAo8V0
         aZKJyn9ix8EZNl+J/b+9Ll0/B2BK7c/a02hTWX0HySrgUAGXGiFt1Y4v1r4PgVfrOadF
         PYa+tNtE8X5il6Jm9uWDgJRoRYQVP2Qw+9fZyQj1Gx0H3zhYi+9Y68Z6gqVYxVppu7WV
         RR5sWnSdejNC7yRe65dXUWJmhIfFVARnX9SHoxSFJDqcfhVaYYk7uK43bJMk3tA2/REX
         FU9w==
X-Gm-Message-State: AMCzsaWbr8KoiLDnN/YND8entSOY3asjzE2ewS/r7yZ9fteBYcrmiE4/
        IaHZxAVOpjGgf/5eANZ4AGqB5y4GD7AgniHZJXnN7w==
X-Google-Smtp-Source: AOwi7QBHE9JZTIFsK4Kd2J+DAn92bMVzdIVAFb6jEOShAWIIbJi0zxlolKBl8motGhodByDap+k3T75IHoTaWtwPMMw=
X-Received: by 10.55.90.199 with SMTP id o190mr17607388qkb.180.1506972029203;
 Mon, 02 Oct 2017 12:20:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.46 with HTTP; Mon, 2 Oct 2017 12:20:28 -0700 (PDT)
In-Reply-To: <6343155c-0986-06b0-8ced-146b23b8a137@web.de>
References: <c4abb7ac-dafd-57f2-8b46-45d610d656c4@web.de> <6343155c-0986-06b0-8ced-146b23b8a137@web.de>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 2 Oct 2017 12:20:28 -0700
Message-ID: <CAGZ79kazU=JEnAAdzf-oGOMBDQaFZabxJzFOTYmhFLssrvY=BA@mail.gmail.com>
Subject: Re: [PATCH 2/2] run-command: use ALLOC_ARRAY
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 1, 2017 at 8:14 AM, Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
> Use the macro ALLOC_ARRAY to allocate an array.  This is shorter and
> eaasier, as it automatically infers the size of elements.

easier

Thanks,
Stefan
