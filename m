Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B813ECAAD3
	for <git@archiver.kernel.org>; Thu,  1 Sep 2022 13:54:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234405AbiIANyB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Sep 2022 09:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234386AbiIANx5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2022 09:53:57 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A28E1B62
        for <git@vger.kernel.org>; Thu,  1 Sep 2022 06:53:55 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id j26so9074744wms.0
        for <git@vger.kernel.org>; Thu, 01 Sep 2022 06:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=74x/yVsLVnBdlUtSAE6jo9sTC2/Ko8leMaGZn/KdssI=;
        b=RafFbC/vNq4gHYJ1pArOqiqifdw7z4oNKxdrtfDUYCk0MJHUyskdsD6xKH/gEeaf56
         ZiCXV9AXRNS49yNTO3QCiwmxlsBpanVzQM7yaVgNznL9f7FoGjQxBiUAhLfla1qSH58A
         2IPdiTM7TG5+u3H6Y0bDy/IOBQUoEBbNwJU066mKCdahRV1zKYnE639l4uaID+kAQfnE
         lyYYZyYuyX6D0Ou7csTSPoR1YVkbBj+6M2SN0hoO0NtThD1rtCRvRVzN+tj1AKcyzdMu
         5ZmQz1gkID/8VgURGA5xxxsPkcmKkY8qzN6puoNN83RwBF0e95iUMrV0aMnAksgl9DjF
         ELKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=74x/yVsLVnBdlUtSAE6jo9sTC2/Ko8leMaGZn/KdssI=;
        b=jCc2kvu0ghCwmufZRc+u/a674VE4BtpHwS/2tfOFpai7kfEbj4IsEAd6r15TUPnHBK
         iXa4/N/wDNVZLkxt/Gx2JC7QoV1Z1WTHUIk7INVoOVh6aYOznpVWo/Ursv5Ndboyw1GQ
         BfTFqsOxeduI64rzSA0mOZjEnQKToLvPNmJqsSo6+xFfUrlad1l4PWUDN7k5aw5VQQ/N
         s9rzSf1lFh0oEBLjnNGZhY284x7YdVdA3le30lDSS2/t1E9JMWxtIV/oUX3ezvNUn7j4
         CScl/A10lAF5+EHFjTb7dEJv7Pm6k1Yeig3rSPOaxLDUB14UqZ6y/8JYKrArpdjT1G+K
         3hBg==
X-Gm-Message-State: ACgBeo2E2r4zqZZKK+KuAyYG0RemdSneYbhvtH1P7GYKIRd/n7bVyJRE
        IAicr+RArYkc3EK3Q7/D+8o=
X-Google-Smtp-Source: AA6agR5ezVuMiUHO/6WPcaTIEim8fX1CVg16BaV7ZtDw7+nZNDKPeItlONeWuSZhWuKGp3FH5/dUcw==
X-Received: by 2002:a05:600c:1912:b0:3a5:f4fc:cd40 with SMTP id j18-20020a05600c191200b003a5f4fccd40mr5288178wmq.205.1662040433976;
        Thu, 01 Sep 2022 06:53:53 -0700 (PDT)
Received: from [192.168.1.74] ([31.185.185.144])
        by smtp.gmail.com with ESMTPSA id j6-20020a056000124600b002258956f373sm14543938wrx.95.2022.09.01.06.53.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 06:53:53 -0700 (PDT)
Message-ID: <19d4c44b-868e-628d-5715-54f37ef56c0d@gmail.com>
Date:   Thu, 1 Sep 2022 14:53:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 2/3] add -p: gracefully handle unparseable hunk headers
 in colored diffs
Content-Language: en-US
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.1336.v3.git.1661785916.gitgitgadget@gmail.com>
 <pull.1336.v4.git.1661977877.gitgitgadget@gmail.com>
 <cd1c51005068247fc92f1c515469bcd384bfe589.1661977877.git.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <cd1c51005068247fc92f1c515469bcd384bfe589.1661977877.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho

On 31/08/2022 21:31, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> In
> https://lore.kernel.org/git/ecf6f5be-22ca-299f-a8f1-bda38e5ca246@gmail.com,
> Phillipe Blain reported that the built-in `git add -p` command fails
> when asked to use [`diff-so-fancy`][diff-so-fancy] to colorize the diff.
> 
> The reason is that this tool produces colored diffs with a hunk header
> that does not contain any parseable `@@ ... @@` line range information,
> and therefore we cannot detect any part in that header that comes after
> the line range.
> 
> As proposed by Phillip Wood, let's take that for a clear indicator that
> we should show the hunk headers verbatim. This is what the Perl version
> of the interactive `add` command did, too.
> 
> This commit is best viewed with `--color-moved --ignore-space-change`.

or --color-moved-ws=allow-indentation-change

This looks pretty good, unsurprisingly I like the fact that the output 
now matches the perl version. I was confused by the grep in the test 
which lead me to realize we're printing an color escape code when we 
shouldn't.

> [diff-so-fancy]: https://github.com/so-fancy/diff-so-fancy
> 
> Reported-by: Philippe Blain <levraiphilippeblain@gmail.com>
> Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>   add-patch.c                | 42 ++++++++++++++++++++------------------
>   t/t3701-add-interactive.sh | 10 +++++++++
>   2 files changed, 32 insertions(+), 20 deletions(-)
> 
> diff --git a/add-patch.c b/add-patch.c
> index 34f3807ff32..3699ca1fcaf 100644
> --- a/add-patch.c
> +++ b/add-patch.c
> @@ -238,6 +238,7 @@ struct hunk_header {
>   	 * include the newline.
>   	 */
>   	size_t extra_start, extra_end, colored_extra_start, colored_extra_end;
> +	unsigned suppress_colored_line_range:1;
>   };
>   
>   struct hunk {
> @@ -358,15 +359,14 @@ static int parse_hunk_header(struct add_p_state *s, struct hunk *hunk)
>   	if (!eol)
>   		eol = s->colored.buf + s->colored.len;
>   	p = memmem(line, eol - line, "@@ -", 4);
> -	if (!p)
> -		return error(_("could not parse colored hunk header '%.*s'"),
> -			     (int)(eol - line), line);
> -	p = memmem(p + 4, eol - p - 4, " @@", 3);
> -	if (!p)
> -		return error(_("could not parse colored hunk header '%.*s'"),
> -			     (int)(eol - line), line);
> +	if (p && (p = memmem(p + 4, eol - p - 4, " @@", 3)))

nit: there should be braces round both arms of the if, but it's hardly 
the first one that does not follow our official style.

> +		header->colored_extra_start = p + 3 - s->colored.buf;
> +	else {
> +		/* could not parse colored hunk header, leave as-is */
> +		header->colored_extra_start = hunk->colored_start;
> +		header->suppress_colored_line_range = 1;
> +	}
>   	hunk->colored_start = eol - s->colored.buf + (*eol == '\n');
> -	header->colored_extra_start = p + 3 - s->colored.buf;
>   	header->colored_extra_end = hunk->colored_start;
>   
>   	return 0;
> @@ -666,18 +666,20 @@ static void render_hunk(struct add_p_state *s, struct hunk *hunk,
                 if (!colored) {
                         p = s->plain.buf + header->extra_start;
                         len = header->extra_end - header->extra_start;
                 } else {
                         strbuf_addstr(out, s->s.fraginfo_color);

I don't think we want to add this escape sequence unless we're going to 
dynamically generate the hunk header

                         p = s->colored.buf + header->colored_extra_start;
                         len = header->colored_extra_end
                                 - header->colored_extra_start;

If we cannot parse the hunk header then len is non-zero...

                 }
>   
> -		if (s->mode->is_reverse)
> -			old_offset -= delta;
> -		else
> -			new_offset += delta;
> -
> -		strbuf_addf(out, "@@ -%lu", old_offset);
> -		if (header->old_count != 1)
> -			strbuf_addf(out, ",%lu", header->old_count);
> -		strbuf_addf(out, " +%lu", new_offset);
> -		if (header->new_count != 1)
> -			strbuf_addf(out, ",%lu", header->new_count);
> -		strbuf_addstr(out, " @@");
> +		if (!colored || !header->suppress_colored_line_range) {
> +			if (s->mode->is_reverse)
> +				old_offset -= delta;
> +			else
> +				new_offset += delta;
> +
> +			strbuf_addf(out, "@@ -%lu", old_offset);
> +			if (header->old_count != 1)
> +				strbuf_addf(out, ",%lu", header->old_count);
> +			strbuf_addf(out, " +%lu", new_offset);
> +			if (header->new_count != 1)
> +				strbuf_addf(out, ",%lu", header->new_count);
> +			strbuf_addstr(out, " @@");
> +		}
>   
>   		if (len)
>   			strbuf_add(out, p, len);

... and so we print the filtered hunk header here and do not reset the 
color below. That is probably ok as the filter should be resetting it's 
own colors but we shouldn't be printing the color at the beginning of 
the line above in that case.

                 else if (colored)
                         strbuf_addf(out, "%s\n", s->s.reset_color);
                 else
                         strbuf_addch(out, '\n');
         }


> diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
> index 8a594700f7b..47ed6698943 100755
> --- a/t/t3701-add-interactive.sh
> +++ b/t/t3701-add-interactive.sh
> @@ -767,6 +767,16 @@ test_expect_success 'detect bogus diffFilter output' '
>   	grep "mismatched output" output
>   '
>   
> +test_expect_success 'handle iffy colored hunk headers' '
> +	git reset --hard &&
> +
> +	echo content >test &&
> +	printf n >n &&
> +	force_color git -c interactive.diffFilter="sed s/.*@@.*/XX/" \
> +		add -p >output 2>&1 <n &&
> +	grep "^[^@]*XX[^@]*$" output

I was wondering why this wasn't just `grep "^XX$"` as we should be 
printing the output of the diff filter verbatim. That lead to my 
comments about outputting escape codes above. Apart from that this patch 
looks good.

Best Wishes

Phillip

> +'
> +
>   test_expect_success 'handle very large filtered diff' '
>   	git reset --hard &&
>   	# The specific number here is not important, but it must
