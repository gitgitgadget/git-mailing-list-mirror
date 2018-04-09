Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DAA91F404
	for <e@80x24.org>; Mon,  9 Apr 2018 00:56:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933617AbeDIA4x (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Apr 2018 20:56:53 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33222 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933442AbeDIA4w (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Apr 2018 20:56:52 -0400
Received: by mail-wm0-f67.google.com with SMTP id o23so15283659wmf.0
        for <git@vger.kernel.org>; Sun, 08 Apr 2018 17:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=+awndxW2JZzqytYazxTWFd/IDlO8g/BOy278HoeSFyk=;
        b=SsLyq7zgkSAJz+B+Rz2yfJ9soLSgqx1chKYVJcv5vB6gO8QCv1dnkDFqwN2z5RKuFe
         qoQiPdf+NBraaxdcjaTv5RjYItvIOP+ZmslgxOJ/sG9E4f4/N70LsJiIlxUIYdlnj6hl
         ZR9SI0VDwta8G6uTu2a+eZP/HV7XI3DAW/m0lZr1lM6Rp0U2um9/t8SxyX7RiAa6Y7G9
         8BvvbSD57FxYSaaCCke+4YIZE0ylPIKt6wjeEYia3WVElykYGdnBgcrbW7QEKrkIZKTf
         pkFhIL7fvuUOUDTZI77pU47A8W3rbEpAOo5Wn7h6Urw45fUP0lqFbqB322GZ7s7hVNaD
         ESOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=+awndxW2JZzqytYazxTWFd/IDlO8g/BOy278HoeSFyk=;
        b=AqM6GJhEGhBa9742B2XbDwV37qlbF5RRlS2VIKxwF9Igy6Mn1gXXzoogwx+7RtyKd8
         o/uDFXfyfXmXTYKtbbGw+8Y7lSC4os+kCoUhFtmPP0NKSJXmB9o/Qm/Zw3brUIy6L0Tp
         Nwbo7ln0Lw0cgpL+urLaR8U9rFpNn6rrouGEyWtg1KPGFyopIV5i9C4dASExXMNIKXu1
         kxqanNWD/x5UI5+/P82SJESpaKEW8jMEDyCWKqqELPayvnydUoWC1/QBXn+3BG5FlHUk
         RA0fpimPA72xCwstA3zjPwQabItcYc4AbGMx+O/dBLQ6dIxGI2EhK+giuENDTaQfXkJy
         54EQ==
X-Gm-Message-State: AElRT7E/K1n8xkbD+ylnSAJ0Y/zQoJcNPVsFeBEst4K3p1ysUPin+kyJ
        wR6ZMhMMwS2Az4D/98qXNM4=
X-Google-Smtp-Source: AIpwx49yxB5y2lsAq+Y47Efec23yMyhfKHPx0j9Rvty19kb798kZtYJmWsQ1qH2ZoWhXh0QRXqlKvg==
X-Received: by 10.28.110.17 with SMTP id j17mr21191187wmc.65.1523235410620;
        Sun, 08 Apr 2018 17:56:50 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 19sm22663905wmv.18.2018.04.08.17.56.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 08 Apr 2018 17:56:50 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Harald Nordgren <haraldnordgren@gmail.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, peff@peff.net,
        sunshine@sunshineco.com
Subject: Re: [PATCH v13 4/4] ls-remote: create '--sort' option
References: <20180408235815.36582-1-haraldnordgren@gmail.com>
        <20180402005248.52418-1-haraldnordgren@gmail.com>
        <20180408235815.36582-4-haraldnordgren@gmail.com>
Date:   Mon, 09 Apr 2018 09:56:49 +0900
In-Reply-To: <20180408235815.36582-4-haraldnordgren@gmail.com> (Harald
        Nordgren's message of "Mon, 9 Apr 2018 01:58:15 +0200")
Message-ID: <xmqqin916vu6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Harald Nordgren <haraldnordgren@gmail.com> writes:

> Create a '--sort' option for ls-remote, based on the one from
> for-each-ref. This e.g. allows ref names to be sorted by version
> semantics, so that v1.2 is sorted before v1.10.
>
> Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
> ---

Thanks.

> +--sort=<key>::
> +	Sort based on the key given. Prefix `-` to sort in descending order
> +	of the value. Supports "version:refname" or "v:refname" (tag names
> +	are treated as versions). The "version:refname" sort order can also
> +	be affected by the "versionsort.suffix" configuration variable.
> +	See linkgit:git-for-each-ref[1] for more sort options, but be aware
> +	that because `ls-remote` deals only with remotes, keys like
> +	`committerdate` that requires access to the objects themselves will
> +	not work for refs whose objects have not yet been fetched from the
> +	remote.

With the update since v12, I think "because `ls-remote` deals only
with remotes," can be dropped entirely, and still convey what needs
to be told: "Be aware some keys that needs access to objects that
are not here won't work".

Instead, it is probably a better idea to spend that half-line worth
of characters to describe in what way they do not work (do they try
to deref a NULL pointer and dump core?  do they notice we need
missing objects and give an error?).

> diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
> index 540d56429..b5ca67167 100644
> --- a/builtin/ls-remote.c
> +++ b/builtin/ls-remote.c

As I said earlier, let's keep these extra UNLEAK() near early
return; they point developers at the places that needs future work.

Thanks.



diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
index b5ca67167d..d3851074c2 100644
--- a/builtin/ls-remote.c
+++ b/builtin/ls-remote.c
@@ -98,6 +98,7 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 
 	if (get_url) {
 		printf("%s\n", *remote->url);
+		UNLEAK(sorting);
 		return 0;
 	}
 
@@ -106,8 +107,10 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 		transport_set_option(transport, TRANS_OPT_UPLOADPACK, uploadpack);
 
 	ref = transport_get_remote_refs(transport);
-	if (transport_disconnect(transport))
+	if (transport_disconnect(transport)) {
+		UNLEAK(sorting);
 		return 1;
+	}
 
 	if (!dest && !quiet)
 		fprintf(stderr, "From %s\n", *remote->url);


