Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D82920357
	for <e@80x24.org>; Mon, 17 Jul 2017 20:12:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751387AbdGQUMG (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Jul 2017 16:12:06 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36810 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751374AbdGQUMF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jul 2017 16:12:05 -0400
Received: by mail-pg0-f68.google.com with SMTP id y129so34379pgy.3
        for <git@vger.kernel.org>; Mon, 17 Jul 2017 13:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=dDKIrKvnfV5rWUEkEsFmTybv/Mr/m+7+TNnQV7ZtlNk=;
        b=YvMSyOJWoYayWgvrht82vzTcGQuVwIQ1isBRxohz5QcWw9B6vSnqyWElgUXOXWeM+R
         ehIer6BGQS4hvTmU1jRaJqOi00FuXmX2/VONdRd0gT0ln0e14miaNbLJPcGo6hCqPPZQ
         QjLB1NSqZiPRckbMKeIPrVfxwpQ9vKlerLmRd++LNBVVjktpGmh141+F2/+p9Hg/iDSi
         8Ghit4pXf8E2qznTsbX3o7W5lkGdjXmBBznlKQwcsjphlZRYMJoF/z9Z5AjdKlRNUwTn
         VknQ39SnXK5Rf3q32CZZ1rITEbN+dDouEssM3qNpGPoWs7OtrlQrwuPKg/n4v6E3HWAC
         ySbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=dDKIrKvnfV5rWUEkEsFmTybv/Mr/m+7+TNnQV7ZtlNk=;
        b=npQ1f2Ft0QzB3YyxOg4W59SbT1iCH/y4QU87vSKgJ/lkiXUXYpK02ltte/7uprnTdF
         sqdU04NZRiWqqSlrHsBZy6sQk5Gqja+6naYn/JD0bEjuy28LXsBlbf9MTOB/h9q5Udrt
         kndVZCNOffpak5f2nhlnVpMbWRV6KyR9XVGRJY0YkMjbxu3XVkjzqUn56AdQgeV2TD5T
         H4mUb3vtnrzpEvwRxB5IWof5ytG4KL6OBxLQ0Plv7eoi5x6asuMsozLayTvO1oqzysm9
         oXiHvKK+BnYX7/PX8OJvKhrnhJqgV/TOewO93gY3jbYOH5T5HbsYCGIEbeVdJtefHA34
         r2hA==
X-Gm-Message-State: AIVw1114vO63uYr2iPgURqpT17umC3Uhl1taur6Qh9Y94fkkxxk87rua
        ZyCftC7A9lyiRRZNIXc=
X-Received: by 10.98.71.13 with SMTP id u13mr20670728pfa.240.1500322324834;
        Mon, 17 Jul 2017 13:12:04 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:480d:579b:4a3b:27f3])
        by smtp.gmail.com with ESMTPSA id r9sm136229pfi.114.2017.07.17.13.12.03
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 17 Jul 2017 13:12:03 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] commit: check for empty message before the check for untouched template
References: <20170717153615.16252-1-kaarticsivaraam91196@gmail.com>
Date:   Mon, 17 Jul 2017 13:12:02 -0700
In-Reply-To: <20170717153615.16252-1-kaarticsivaraam91196@gmail.com> (Kaartic
        Sivaraam's message of "Mon, 17 Jul 2017 21:06:15 +0530")
Message-ID: <xmqqh8yahlgt.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaarticsivaraam91196@gmail.com> writes:

> The check for whether the template given to 'git commit' is untouched
> is done before the empty message check. This results in a wrong error
> message being displayed in the following case. When the user removes
> everything in template completely to abort the commit he is shown the
> "template untouched" error which is wrong. He should be shown the
> "empty message" error.
>
> Do the empty message check before checking for an untouched template
> thus fixing this issue.
>
> Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
> ---
>  builtin/commit.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Makes sense to me.

> diff --git a/builtin/commit.c b/builtin/commit.c
> index aff6bf7aa..9c299d792 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -1736,19 +1736,19 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>  	if (verbose || /* Truncate the message just before the diff, if any. */
>  	    cleanup_mode == CLEANUP_SCISSORS)
>  		strbuf_setlen(&sb, wt_status_locate_end(sb.buf, sb.len));
> -
>  	if (cleanup_mode != CLEANUP_NONE)
>  		strbuf_stripspace(&sb, cleanup_mode == CLEANUP_ALL);
> -	if (template_untouched(&sb) && !allow_empty_message) {
> -		rollback_index_files();
> -		fprintf(stderr, _("Aborting commit; you did not edit the message.\n"));
> -		exit(1);
> -	}
> +
>  	if (message_is_empty(&sb) && !allow_empty_message) {
>  		rollback_index_files();
>  		fprintf(stderr, _("Aborting commit due to empty commit message.\n"));
>  		exit(1);
>  	}
> +	if (template_untouched(&sb) && !allow_empty_message) {
> +		rollback_index_files();
> +		fprintf(stderr, _("Aborting commit; you did not edit the message.\n"));
> +		exit(1);
> +	}
>  
>  	if (amend) {
>  		const char *exclude_gpgsig[2] = { "gpgsig", NULL };
