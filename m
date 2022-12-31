Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2538C3DA7A
	for <git@archiver.kernel.org>; Sat, 31 Dec 2022 15:03:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231610AbiLaPDt (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 31 Dec 2022 10:03:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbiLaPDn (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Dec 2022 10:03:43 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E841D6360
        for <git@vger.kernel.org>; Sat, 31 Dec 2022 07:03:41 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id t15so13720134wro.9
        for <git@vger.kernel.org>; Sat, 31 Dec 2022 07:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l3gdb7QXPibuxv1oBAc7uFoq1vP9G0hA0b487G13/XI=;
        b=F4bbdJFK55OjGvb/wCuOrNgNJAcfVh3Xdrbgz1C8a+E0gdRLkknyP4We7G4KSAtH5R
         FP+cNz2+xaoxQpkN8K4UjhcslH0DC9NP8Q6hB5SPIk56tiQtsdMLdFoli2TRvMlzMasG
         yHmK8EoHOCZ5kPosKu81flpemLlpT+3o6EbBTTTXthMLQg3WhnGdzxO7pZRJT0FXON3L
         S0CsAn+dRT+VjOh0Jh69X5OZ4P7u0pAOodNTCOL5KaPWFtZbXWxMDAI1XBQvK4NbbKH0
         e7GUtL48WDH28Ey5+1Bi7XwvppuMn1qaTYAi9lmSnbNa6iEWthonqf7Zf45ZsI/2HKpU
         nl1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l3gdb7QXPibuxv1oBAc7uFoq1vP9G0hA0b487G13/XI=;
        b=NRZlIC1jJ4ar8CVb56C5YwiVwGUOTnv8fcN6hAIJlmM+XDx4erkollJxNP6ZWplHML
         OdPOCrcnRWXS2F+ZenhGeRwqMD1T/wYFNu7TfPKIq3Bb2sr5fDd52G+PkRoSJvtFDNih
         Rx6tcbYxJ3/asws/gaWyz1cYJbLnY3OH5RN+j8d3yzVBBZh7PBnrSoWnMV7An9aiyIRA
         wZoPLaW+qW9XTvzo21z22EQITu/giCg6itgY+l2ndCMAgcduklbxp3G2tzN4Uem9y3eb
         SQ8yOnWcOmhgitV+AI4gdhzkgKenk5sdBL8yejzHHEDVQLA8y85H/2RkcdgajmWkLbeL
         sdug==
X-Gm-Message-State: AFqh2kqMrLcvlGSRPxNFrrSxG7+jII514zuFztYfS8zm73TK0Q1q3gub
        ukAnEKlv1YsUsiINI7DiwVE=
X-Google-Smtp-Source: AMrXdXvwPkmNEyaK1zLfHVzKpHZl7sGJUXx37NVBOrbVvMkfSYstg8Py9TEXQUwvtMlHaGorqmwsYw==
X-Received: by 2002:a05:6000:136b:b0:27f:85ce:bc9e with SMTP id q11-20020a056000136b00b0027f85cebc9emr15163538wrz.24.1672499020491;
        Sat, 31 Dec 2022 07:03:40 -0800 (PST)
Received: from [192.168.1.14] (host-92-2-151-214.as13285.net. [92.2.151.214])
        by smtp.gmail.com with ESMTPSA id z13-20020adff74d000000b002366f9bd717sm27354235wrp.45.2022.12.31.07.03.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Dec 2022 07:03:40 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <bcace50b-a4c3-c468-94a3-4fe0c62b3671@dunelm.org.uk>
Date:   Sat, 31 Dec 2022 15:03:39 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 08/10] sequencer.c: always free() the "msgbuf" in
 do_pick_commit()
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
References: <cover-00.10-00000000000-20221230T071741Z-avarab@gmail.com>
 <patch-08.10-d607dbac38e-20221230T071741Z-avarab@gmail.com>
In-Reply-To: <patch-08.10-d607dbac38e-20221230T071741Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar

On 30/12/2022 07:28, Ævar Arnfjörð Bjarmason wrote:
> In [1] the strbuf_release(&msgbuf) was moved into this
> do_pick_commit(), but didn't take into account the case of [2], where
> we'd return before the strbuf_release(&msgbuf).
> 
> Then when the "fixup" support was added in [3] this leak got worse, as
> we added another place where we'd "return" before reaching the
> strbuf_release().

This message makes it sound much worse that it is. The leak only happens 
if there is an error and in that case rebase bails out straight away.

> Let's move it to a "cleanup" label, and use an appropriate "goto". It
> may or may not be safe to combine the existing "leave" and "cleanup"
> labels, but this change doesn't attempt to answer that question. Let's
> instead avoid calling update_abort_safety_file() in these cases, as we
> didn't do so before.

It is safe as update_abort_safety_file() is a no-op when rebasing and 
you're changing code that is only run when rebasing. I feel this patch 
is adding complexity for no real gain, at least if we can avoid adding a 
second label it would be simpler.

Best Wishes

Phillip

> 1. 452202c74b8 (sequencer: stop releasing the strbuf in
>     write_message(), 2016-10-21)
> 2. f241ff0d0a9 (prepare the builtins for a libified merge_recursive(),
>     2016-07-26)
> 3. 6e98de72c03 (sequencer (rebase -i): add support for the 'fixup' and
>     'squash' commands, 2017-01-02)
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>   sequencer.c | 19 ++++++++++++-------
>   1 file changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/sequencer.c b/sequencer.c
> index 47367e66842..db8d789fa76 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -2280,8 +2280,10 @@ static int do_pick_commit(struct repository *r,
>   		reword = 1;
>   	else if (is_fixup(command)) {
>   		if (update_squash_messages(r, command, commit,
> -					   opts, item->flags))
> -			return -1;
> +					   opts, item->flags)) {
> +			res = -1;
> +			goto cleanup;
> +		}
>   		flags |= AMEND_MSG;
>   		if (!final_fixup)
>   			msg_file = rebase_path_squash_msg();
> @@ -2291,9 +2293,11 @@ static int do_pick_commit(struct repository *r,
>   		} else {
>   			const char *dest = git_path_squash_msg(r);
>   			unlink(dest);
> -			if (copy_file(dest, rebase_path_squash_msg(), 0666))
> -				return error(_("could not rename '%s' to '%s'"),
> -					     rebase_path_squash_msg(), dest);
> +			if (copy_file(dest, rebase_path_squash_msg(), 0666)) {
> +				res = error(_("could not rename '%s' to '%s'"),
> +					    rebase_path_squash_msg(), dest);
> +				goto cleanup;
> +			}
>   			unlink(git_path_merge_msg(r));
>   			msg_file = dest;
>   			flags |= EDIT_MSG;
> @@ -2331,7 +2335,6 @@ static int do_pick_commit(struct repository *r,
>   		free_commit_list(common);
>   		free_commit_list(remotes);
>   	}
> -	strbuf_release(&msgbuf);
>   
>   	/*
>   	 * If the merge was clean or if it failed due to conflict, we write
> @@ -2403,9 +2406,11 @@ static int do_pick_commit(struct repository *r,
>   	}
>   
>   leave:
> +	update_abort_safety_file();
> +cleanup:
>   	free_message(commit, &msg);
>   	free(author);
> -	update_abort_safety_file();
> +	strbuf_release(&msgbuf);
>   
>   	return res;
>   }
