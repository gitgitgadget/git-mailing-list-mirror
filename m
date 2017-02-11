Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 34CB01FAF4
	for <e@80x24.org>; Sat, 11 Feb 2017 19:01:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751155AbdBKTBK (ORCPT <rfc822;e@80x24.org>);
        Sat, 11 Feb 2017 14:01:10 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33255 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750994AbdBKTBJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Feb 2017 14:01:09 -0500
Received: by mail-pf0-f193.google.com with SMTP id e4so4231891pfg.0
        for <git@vger.kernel.org>; Sat, 11 Feb 2017 11:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=nQzT3UB1EqlfLNn1c72Zz2pwCbpoyGjlkmlEoRQ6n4E=;
        b=ly2GV2D+Ui6KwHrRPJ2mA2LDFkIlUQ/J5URsKUlbfou5GzVVu/GJ85PWDs3WLoHIoJ
         5KrcFjDRRyB58D4HUGN6Z5oygRQPwFay4AXDx8yAOgVxuoPBzibGoyzMXPEgCFkMF/Ue
         d1jfoFCUPzwPATcnPhtAW2cNrHz2FD/uZlFMB6J1wOJ7pckEkJ1oJXtrLQjwZVm4wMDv
         iLuLdf3P39F6GAI3IREGkSl3KNIxFZcvVXHO/dooyC+fKDg0JOobEeajHxZ48nLlOlHf
         Y4zvbtfsJvzB2xynXMlrN2QX8Fs49PD4eV/cvJmMyY46DMZ3X1hlaj0W8tCve56KaHzX
         bEvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=nQzT3UB1EqlfLNn1c72Zz2pwCbpoyGjlkmlEoRQ6n4E=;
        b=plytWdfOTHjpteEG/cstcZvAGwJozGKXFAsPIUGdGFbzHI7d72vxc2QHWoPcbRXRY5
         uT49YHwVjED0cT2t6tLBOo7OKeNnxY4JBNl1OsCXlCp1NmZLC6GSux2fOmNtu5NMtwKa
         KSYqkulekQVvOYIpY+SVNpvsJT2xnLP/4j6DVjFRX5T8Mbg8I15BC0vgNeJwd6p4pMYG
         fe4QkRuDKtSku8HQd8h71poWQMXrSxdIrZKsoY8KdVopeU6a2mHFqIoVRC3AeKDMBA3L
         ga6txWtGigTcYYinFK/nBmy3u8+GAV6qOfus3qPbet0c4zA084iEVDBka6G1iUHbrTs5
         Tk5w==
X-Gm-Message-State: AMke39nQKlPUVG9YiE5Tr3Q0eWf4XNosDT9Ige6rfx9hTl2Mr33OLk61tbiVBzRBaFoAog==
X-Received: by 10.99.99.193 with SMTP id x184mr18103240pgb.226.1486839668660;
        Sat, 11 Feb 2017 11:01:08 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:d4bf:82d:ab5d:5a31])
        by smtp.gmail.com with ESMTPSA id x81sm12319798pff.69.2017.02.11.11.01.07
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 11 Feb 2017 11:01:08 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>,
        Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH] cocci: detect useless free(3) calls
References: <7e10f934-f084-ceb4-00eb-b75cdb01886b@web.de>
Date:   Sat, 11 Feb 2017 11:01:07 -0800
In-Reply-To: <7e10f934-f084-ceb4-00eb-b75cdb01886b@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Sat, 11 Feb 2017 14:58:44 +0100")
Message-ID: <xmqqr334h7rg.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> writes:

> Add a semantic patch for removing checks that cause free(3) to only be
> called with a NULL pointer, as that must be a programming mistake.
>
> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---
> No cases are found in master or next, but 1d263b93 (bisect--helper:
> `bisect_next_check` & bisect_voc shell function in C) introduced four
> of them to pu.

Thanks.  This should have been caught by code inspection, but
having automated way to do so is always good.

>
>  contrib/coccinelle/free.cocci | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/contrib/coccinelle/free.cocci b/contrib/coccinelle/free.cocci
> index e28213161a..c03ba737e5 100644
> --- a/contrib/coccinelle/free.cocci
> +++ b/contrib/coccinelle/free.cocci
> @@ -3,3 +3,9 @@ expression E;
>  @@
>  - if (E)
>    free(E);
> +
> +@@
> +expression E;
> +@@
> +- if (!E)
> +  free(E);
