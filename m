Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 30FF11FBB0
	for <e@80x24.org>; Thu,  1 Sep 2016 08:33:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752371AbcIAIdf (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Sep 2016 04:33:35 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:36811 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752185AbcIAIdc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2016 04:33:32 -0400
Received: by mail-wm0-f53.google.com with SMTP id c133so66014903wmd.1
        for <git@vger.kernel.org>; Thu, 01 Sep 2016 01:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fmhO71iZVrIkmvOEdbBKlR4+neAS6OP7XnWXwDe4IX0=;
        b=LHQbpwT3D/OFKXCK0xmr4VkZi+iIcdePyOvW+4/VaCoINBHB/NuhtS4MGN87R+Zyv/
         /RHlSFei2Y6lyBcrlCc1QkYahZjfEzjD/EYjjAoH58hDOWXDKSJuTNUkLQM0q2TwqSNo
         dEOSuZGVV7pNtSRAMUoyhxTNFjbRpRZ6k4oh/6E6goHxtd8k617jASYnzhzNym3WY/m1
         EdYpjXo97YpIS3PpIAA5PIE/0yMOyWuQ4tRWXNy5hgV7QAGWrKjoEHqb3m/E1gjF7j6e
         AOopfP78S8vP3pscs8ATmDv0nHWNb8/APkENj9ED4AMVZX3yUHsjna7T76axPLV3I7SS
         dvYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fmhO71iZVrIkmvOEdbBKlR4+neAS6OP7XnWXwDe4IX0=;
        b=mit/iY/gPXc5HO4O8FWY9xKH64Rk0bUI/P2X4MKZBmzqvr/XwQC4kQC+9HRIul/9wQ
         VHTXNqrp4C0yInY0dB2pkJ0ISt+ED36CYYpxx5F/CaUSVKhEY4cfcl6malKXyBM/gWdl
         NH+WHbW0DV/lnbC5HhlkcmIUhTuxrlZAPZR6meN+EpZH3UoGL8PDYhb/0gBYop7ut0vU
         emn37ZRJHKHUiWGmB/hhwvUDDubuULmTvN4/P23M3y+TudMSRoQtigxozE7LJYSlh0Fk
         KRhleJ6CP5KznvUDMEZzeoLrB0cawdXQndhy3ajd9hCzZcp4FO/d/0EJrSKp+9BcWYVW
         JOfQ==
X-Gm-Message-State: AE9vXwMKWIC/Lu20CzeameRbaB/wlqro6okE6A0w2A+acf4blE1nrVrdhOBXgsMuE2Wu8g==
X-Received: by 10.28.95.67 with SMTP id t64mr26836120wmb.99.1472718810740;
        Thu, 01 Sep 2016 01:33:30 -0700 (PDT)
Received: from [10.42.1.91] ([145.132.209.114])
        by smtp.gmail.com with ESMTPSA id lv9sm4003376wjb.22.2016.09.01.01.33.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Sep 2016 01:33:30 -0700 (PDT)
Message-ID: <1472718808.4680.19.camel@kaarsemaker.net>
Subject: Re: [PATCH 07/34] sequencer (rebase -i): add support for the
 'fixup' and 'squash' commands
From:   Dennis Kaarsemaker <dennis@kaarsemaker.net>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Date:   Thu, 01 Sep 2016 10:33:28 +0200
In-Reply-To: <5488a031ffe14373b7434d497b7fd2f2e5fe55bd.1472633606.git.johannes.schindelin@gmx.de>
References: <cover.1472633606.git.johannes.schindelin@gmx.de>
         <5488a031ffe14373b7434d497b7fd2f2e5fe55bd.1472633606.git.johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On wo, 2016-08-31 at 10:54 +0200, Johannes Schindelin wrote:

> +static int is_fixup(enum todo_command command)
> +{
> +	return command == TODO_FIXUP || command == TODO_SQUASH;
> +}

It sounds wrong to have a function named is_fixup return true when the
command isn't a fixup but a squash. Maybe name it
changes_previous_commit or something?

> +static const char *nth_for_number(int n)
> +{
> +	int n1 = n % 10, n10 = n % 100;
> +
> +	if (n1 == 1 && n10 != 11)
> +		return "st";
> +	if (n1 == 2 && n10 != 12)
> +		return "nd";
> +	if (n1 == 3 && n10 != 13)
> +		return "rd";
> +	return "th";
> +}

>8---

> +	if (command == TODO_SQUASH) {
> +		unlink(rebase_path_fixup_msg());
> +		strbuf_addf(&buf, "\n%c This is the %d%s commit message:\n\n%s",
> +			comment_line_char,
> +			count, nth_for_number(count), body);
> +	}
> +	else if (command == TODO_FIXUP) {
> +		strbuf_addf(&buf,
> +			"\n%c The %d%s commit message will be skipped:\n\n",
> +			comment_line_char, count, nth_for_number(count));
> +		strbuf_add_commented_lines(&buf, body, strlen(body));
> +	}

This way of handling numbers is not translatable, and I really think we
should mark these strings for translation, like they are in the .sh
version.

D.
