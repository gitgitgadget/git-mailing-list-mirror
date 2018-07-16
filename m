Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A2DB1F597
	for <e@80x24.org>; Mon, 16 Jul 2018 22:19:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729593AbeGPWsw (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 18:48:52 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40861 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728556AbeGPWsw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 18:48:52 -0400
Received: by mail-wr1-f68.google.com with SMTP id t6-v6so33394370wrn.7
        for <git@vger.kernel.org>; Mon, 16 Jul 2018 15:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=InNgGG8sxj4grM3S917BtfqXEufDRKzQZmWZesOyrXs=;
        b=HF3DbcmEBaYjXJTlbHXj5cMqc8p8dvswQhiCH7JAtif1wNkl90wgxN0LnZfagK5iWH
         /DQlfKaFxEpyY2TibOC6pYNFcMR84bfaxThUGl+ZU6b1fs9adaICUWDpikF6ihnmFZIX
         8ESt5FdJrCxAdcgvRSRhgXssnVr0Diin2w4cgDd8cAMCAhHPlM6Xn8lkSUSw0ILN6n2/
         1zmCW+vxcf8RePZBCnQcIdSrO/BPNZ1V+/hinicvzhWRsKeZyhL27V3v2wCDioOC7BsX
         oPOtCF2ianFk860Jh+iqPmInC9Bf7yELS275PFJS4dH2Nrbyu4FgkBC98lkuSSeBlq1r
         /sFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=InNgGG8sxj4grM3S917BtfqXEufDRKzQZmWZesOyrXs=;
        b=bgqi16NT0x5TTNoCjeqiv1aIegDxTHZvnYb3pEb0ZkVpnxMOUp8C3riOBcVdwodxIC
         4sBlCgSJV+XrElWthINLp0sc1Kz4iK0BeU+Iwc87yaX2y0rymrYLpxfCNuOSSNT+h27A
         2WMvapPo787OsasuUXSLhPFHxhzMYihiXwlubWrhUXDmryWHlNyjtNjWtBmGr5EdE/bd
         ncCDO6dTeZpewXNr5ev4IwRyc4f2GuXcqU4G83IYYfvcZcDu35GJONZWJJ74wuYGc7Xm
         jM1k/t4iBEvg2TMx9PT4Qo5QBmqXzgtTWsRs34DLQvMCFJusFShZhb7e99cdFgeha0xT
         dXRg==
X-Gm-Message-State: AOUpUlEI5yK3/mzCQIrkcICd/HX7WZbVEO25aL054PD/eqBm3GJTY/Ym
        u5DOg3Vmcfoa66+MPiPuUjRpJngv
X-Google-Smtp-Source: AAOMgpc+OS5GMbFyZ8zAYPZDYmSWQK8OZeOpHGhbrFo2gDrxL36/VewcUbE8dYQrnFtNG5kzhM5uJQ==
X-Received: by 2002:adf:9aeb:: with SMTP id a98-v6mr12868699wrc.110.1531779565210;
        Mon, 16 Jul 2018 15:19:25 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id x184-v6sm8374958wmg.24.2018.07.16.15.19.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 15:19:24 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jules Maselbas <jules.maselbas@grenoble-inp.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] send-email: Fix tls AUTH when sending batch
References: <20180714021440.22995-1-jules.maselbas@grenoble-inp.org>
        <20180714085848.4031-1-jules.maselbas@grenoble-inp.org>
Date:   Mon, 16 Jul 2018 15:19:23 -0700
In-Reply-To: <20180714085848.4031-1-jules.maselbas@grenoble-inp.org> (Jules
        Maselbas's message of "Sat, 14 Jul 2018 10:58:48 +0200")
Message-ID: <xmqqwoturfh0.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jules Maselbas <jules.maselbas@grenoble-inp.org> writes:

> The variable smtp_encryption must keep it's value between two batches.
> Otherwise the authentication is skipped after the first batch.
>
> Signed-off-by: Jules Maselbas <jules.maselbas@grenoble-inp.org>
> ---
>  git-send-email.perl | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/git-send-email.perl b/git-send-email.perl
> index 8ec70e58e..1f9a73f74 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -1479,7 +1479,7 @@ sub send_message {
>  							 SSL => 1);
>  			}
>  		}
> -		else {
> +		elsif (!$smtp) {
>  			$smtp_server_port ||= 25;
>  			$smtp ||= Net::SMTP->new($smtp_server,
>  						 Hello => $smtp_domain,

Puzzled...  The code is prepared to deal with the case where $smtp
is still active at this point by using "$smtp ||=", but this hunk
forces any caller that still has $smtp active from entering this
block.

So the conditional assignment "$smtp ||= Net::SMTP->new()" is
meaningless after this patch---we always do "new" if we reach this
statement.

This hunk did not exist in your v1, yet the proposed log message has
not changed since v1.  With this hunk, it appears that the problem
and the solution are not about $smtp_encryption but is about not
calling ->starttls() or ->command('STARTTLS') when we reuse $smtp
that has been established earlier, and the description in the log
message feels a bit off.  Some exaplantion on why this hunk is a
good thing may be missing, I guess.

Dropping the assignment to $smtp_encryption in this block (i.e. hunk
below) makes sense, as we do not call read_config() to re-read its
value after the batching code quits and unsets $smtp.

> @@ -1501,7 +1501,6 @@ sub send_message {
>  					$smtp->starttls(ssl_verify_params())
>  						or die sprintf(__("STARTTLS failed! %s"), IO::Socket::SSL::errstr());
>  				}
> -				$smtp_encryption = '';
>  				# Send again to receive fresh

By the way, the patch claims that it is against 8ec70e58e, but has
an edit on this context line and does not apply.  Did you hand-edit
your patch after generating it?  Please don't.


>  				# supported commands
>  				$smtp->hello($smtp_domain);
