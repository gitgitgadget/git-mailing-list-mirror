Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 647AC2036D
	for <e@80x24.org>; Sun, 19 Nov 2017 01:04:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760369AbdKSBE5 (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Nov 2017 20:04:57 -0500
Received: from mail-qt0-f195.google.com ([209.85.216.195]:34039 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760304AbdKSBEz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Nov 2017 20:04:55 -0500
Received: by mail-qt0-f195.google.com with SMTP id 33so2252085qtv.1
        for <git@vger.kernel.org>; Sat, 18 Nov 2017 17:04:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=euKQaqOdh05xJ4lYzP4Kq2Nvl2YWxTQV00IUIouoIIQ=;
        b=Ft4nhUo91fHRuw4+z8/rEIrhY4ehq5kRIjkCnwgd0GpYGmc6q7DBydfinVUDNwfcVq
         mONFr81WtLF68L8vOpoMPPuyWi4w4V0desIsjPNJWg7fJwQuqeJfAfH2JZPImBGsDEEA
         DoJ6QPwgo7FsotUcDZPuyKcrv8oDWQkBNBwaiOi0MMh9XMzFqW8kcZi+UrChBpAJAXl6
         o2RDgvcsVqkn8GOhjdL9qCRtv1J6VuqenL680VKP2efi0iQINSi/gn8HgCIbT0Zl5azd
         szUYMJVNh5e48cvIUy8TyvD5Lc5npoeuZVeoRCSP0wx0wnyd8NAKylQRfm190VR2mgMM
         GXNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=euKQaqOdh05xJ4lYzP4Kq2Nvl2YWxTQV00IUIouoIIQ=;
        b=TxKe4nyzjI4NuhFM1x7tUTYFLZx6UE4HkburKkpRZORPt3gX/3wyFzCRcSqynBZ7p3
         0NrwGPAAn0evtTHiND55073FqAIT2+JLDVAjFIDXbcrcNHtUF1HmEx8bwLMY6/gECDck
         t5w2Z/H3PfzPRaW5GK/PWQCoB3YmDAnmxaeVWpPRIxIvcGxNoyFGpuW4zhnyugQp5TNm
         czjz4Rlj+em7OwpkJ6lqeFI3rWpxVkJn4F5o7UocALXo1MRv7k5pWBFcTbar/5os2Azh
         62zEYNAcDgOqZ/nGVpjyR0nIwfetvvPpKsxnLUd4kGaPRMnooRgEiOhgcJEKjOabjVJ+
         eHUw==
X-Gm-Message-State: AJaThX5VKF0bkOyhh6ksB/YEjWXqlzWIWWStFUlCJdzSyPqJIyPuruCB
        dUxna8JD7nD7DklynWitE34up0sryXTCywlaxkw=
X-Google-Smtp-Source: AGs4zMYyZJrEm6ie4h1mCFJZr/XYU7Lh81tsiX2BBBDCboDnvCJYcLKyVEc4V4yg/DDVj2cc25GXIvBZTOb0tgC9/yY=
X-Received: by 10.237.37.47 with SMTP id v44mr16130961qtc.55.1511053495140;
 Sat, 18 Nov 2017 17:04:55 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.155.209 with HTTP; Sat, 18 Nov 2017 17:04:54 -0800 (PST)
In-Reply-To: <20171118172648.17918-5-kaartic.sivaraam@gmail.com>
References: <20171102065407.25404-1-kaartic.sivaraam@gmail.com>
 <20171118172648.17918-1-kaartic.sivaraam@gmail.com> <20171118172648.17918-5-kaartic.sivaraam@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 18 Nov 2017 20:04:54 -0500
X-Google-Sender-Auth: wRZaQiE6skw1AjuJEdFqGuFAVww
Message-ID: <CAPig+cRrJVhYMYfoFhSi+FOLv0X4or1-YV=M8_X10_d_Bbt3pA@mail.gmail.com>
Subject: Re: [PATCH 4/4] builtin/branch: strip refs/heads/ using skip_prefix
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 18, 2017 at 12:26 PM, Kaartic Sivaraam
<kaartic.sivaraam@gmail.com> wrote:
> Instead of hard-coding the offset strlen("refs/heads/") to skip
> the prefix "refs/heads/" use the skip_prefix() function which
> is more communicative and verifies that the string actually
> starts with that prefix.
>
> Though we don't check for the result of verification here as
> it's (almost) always the case that the string does start
> with "refs/heads", it's just better to avoid hard-coding and
> be more communicative.
>
> Signed-off-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
> ---
> diff --git a/builtin/branch.c b/builtin/branch.c
> @@ -462,6 +462,8 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
>  {
>         struct strbuf oldref = STRBUF_INIT, newref = STRBUF_INIT, logmsg = STRBUF_INIT;
>         struct strbuf oldsection = STRBUF_INIT, newsection = STRBUF_INIT;
> +       const char *prefix_free_oldref = NULL;
> +       const char *prefix_free_newref = NULL;

A bit of a mouthful. Perhaps name these 'oldname' and 'newname' or something?
