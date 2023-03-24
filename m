Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 880C0C6FD1C
	for <git@archiver.kernel.org>; Fri, 24 Mar 2023 14:56:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232180AbjCXO4u (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Mar 2023 10:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232241AbjCXO4s (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2023 10:56:48 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F0A22D5F
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 07:56:40 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id o7so2092098wrg.5
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 07:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679669798;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=okzBI3Z7PKLvET+0ZDLIWOEc8lRg0e3alfbsr1mvpa8=;
        b=L1OD43XohIURweP+uQAqEWfFbNAJ9BOrWMZFDIPl5EaGsRiTQnUZ87cHJip5rqSXoU
         XEc5Y30bWh3ySa6EnlqHZ5Ob+fbPSxTyIIt5xnkjay0MN8VKzkn8229rna8zgNBKioO1
         2yT7sdQ/hb25qIOIc+QO+KGK6wOpUJKTK45ihBQY2r5nlCyhWK7tsA06r1edzbD8L6iO
         FSkd42fhaa2ZNtAuLS58xP9hgpB922hXT0y2KBfLpU34/TXUI9BukyfwtCmR7FPdT1Br
         kaitBHoFu1Zoq+kEGGeNw795N0rHk+pjK+vY45tvA7f193xyaTt0vS+RTHwQbmetefcN
         01yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679669798;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=okzBI3Z7PKLvET+0ZDLIWOEc8lRg0e3alfbsr1mvpa8=;
        b=10U+zf1J493B8UCA9jNjF3UgwF9iG8efzilb0I9rYxYKZz0fW9icvjtnzIa2BG0hbG
         TcixzYiSRmgXS7cizEg2eVpKup2kLjUCTZlqAp40T7Xv7ibdRswdJcjeWDLrm8AcS0b+
         rR1ftN5pQlj1Vu2WyOwvl01H5NSOVwGbFxjx+Nh4im5w3CbIr5eF6SZURDkICGXGTkMH
         B6QxHsUQWjRbE3DxgqDfByX+2l1Own48DT75XlgHwd0Xwt8ORjDRFtLWOeTwzCf03/UX
         /gC5oT7/+TwbyjgKE2/AN1kUNzRRvk03CWLxdKNhrCysNugvBQEGQTr3ZpTpSQ3DW4qv
         HBTg==
X-Gm-Message-State: AAQBX9dDJqZrMeWiogXvtCDa57yNpZl4yj0u/Umhb406bK4PoF5f4Xwa
        YSj8wprVqRg94+7QIuyUXEM=
X-Google-Smtp-Source: AKy350ZNjHuwWwV+8lZHaKY4ZAKcFVlDig8P3yVN1JyTwcgNxRAmEAuIAyFgAmTq1bgJmOpQL5Ge3A==
X-Received: by 2002:adf:f689:0:b0:2c7:17e0:54f5 with SMTP id v9-20020adff689000000b002c717e054f5mr2313315wrp.13.1679669798628;
        Fri, 24 Mar 2023 07:56:38 -0700 (PDT)
Received: from [192.168.1.212] ([90.253.29.198])
        by smtp.gmail.com with ESMTPSA id z8-20020adfec88000000b002c5691f13eesm18502642wrn.50.2023.03.24.07.56.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Mar 2023 07:56:38 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <d6c0bb22-94d4-5186-136d-4127b1eaf883@dunelm.org.uk>
Date:   Fri, 24 Mar 2023 14:56:37 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] send-email: prompt-dependent exit codes
Content-Language: en-US
To:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>, git@vger.kernel.org
References: <20230323162234.995435-1-oswald.buddenhagen@gmx.de>
In-Reply-To: <20230323162234.995435-1-oswald.buddenhagen@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Oswald

On 23/03/2023 16:22, Oswald Buddenhagen wrote:
>  From the perspective of the caller, failure to send (some) mails is an
> error even if it was interactively requested, so it should be indicated
> by the exit code.

I think this is a useful change as I was caught out by the existing 
behavior recently when I quit send-email without sending any patches and 
the shell thought it exited successfully.

I'm not sure about this implementation though. If I send one patch and 
then quit it looks like it will still exit(0) as both $sent_any and 
$sent_all will be true. I think it would be better to count the number 
of patches sent and compare that to the total number of patches when 
calculating the exit code to use.

Best Wishes

Phillip

> To make it somewhat specific, the exit code is 10 when only some mails
> were skipped, and 11 if the user quit on the first prompt.
> 
> Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
> ---
>   git-send-email.perl | 26 ++++++++++++++++++++++----
>   1 file changed, 22 insertions(+), 4 deletions(-)
> 
> diff --git a/git-send-email.perl b/git-send-email.perl
> index 07f2a0cbea..2ab6766583 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -254,6 +254,18 @@ sub system_or_die {
>   	die $msg if $msg;
>   }
>   
> +my $sent_any = 0;
> +my $sent_all = 1;
> +
> +sub do_exit {
> +	exit($sent_any ? $sent_all ? 0 : 10 : 11);
> +}
> +
> +sub do_quit {
> +	cleanup_compose_files();
> +	do_exit();
> +}
> +
>   sub do_edit {
>   	if (!defined($editor)) {
>   		$editor = Git::command_oneline('var', 'GIT_EDITOR');
> @@ -1172,8 +1184,7 @@ sub validate_address {
>   		if (/^d/i) {
>   			return undef;
>   		} elsif (/^q/i) {
> -			cleanup_compose_files();
> -			exit(0);
> +			do_quit();
>   		}
>   		$address = ask("$to_whom ",
>   			default => "",
> @@ -1593,8 +1604,7 @@ sub send_message {
>   		} elsif (/^e/i) {
>   			return -1;
>   		} elsif (/^q/i) {
> -			cleanup_compose_files();
> -			exit(0);
> +			do_quit();
>   		} elsif (/^a/i) {
>   			$confirm = 'never';
>   		}
> @@ -1968,6 +1978,12 @@ sub process_file {
>   		return 0;
>   	}
>   
> +	if ($message_was_sent) {
> +		$sent_any = 1;
> +	} else {
> +		$sent_all = 0;
> +	}
> +
>   	# set up for the next message
>   	if ($thread) {
>   		if ($message_was_sent &&
> @@ -2187,3 +2203,5 @@ sub body_or_subject_has_nonascii {
>   	}
>   	return 0;
>   }
> +
> +do_exit();
