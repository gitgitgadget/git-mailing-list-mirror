Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AAD0C83F33
	for <git@archiver.kernel.org>; Mon,  4 Sep 2023 10:10:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238681AbjIDKKg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Sep 2023 06:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231425AbjIDKKf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Sep 2023 06:10:35 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D10CAD
        for <git@vger.kernel.org>; Mon,  4 Sep 2023 03:10:31 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-307d20548adso1087829f8f.0
        for <git@vger.kernel.org>; Mon, 04 Sep 2023 03:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693822230; x=1694427030; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Dx1PWfrajZrb9Pj8f/Iv4yru2tg7csQHpLgsZo9vktc=;
        b=CS3JYOtBSwEuP9NNiz2CWIdZssBaSNq/nDvwy49hgOogyCh6fQsSexk+uWqkZYF8+n
         mk1So/bg65SrAAhOV+v6DxV+uF/PZ8YzHUmrkqYDTkDmszOqkuHSdlGek6N2MMQApc0k
         lQD+VbueyNdGhfV7M5/AS5V/HeCVDn3hQ8X61T3iALdDI8VOTjWVhZRzX5co5xECqD+9
         MN4gFMGxBFoxEvqVzpohbP2lGVAh4WV071lvkgxe6tOVr2LamBd6MmVh2kout6Bh5IXD
         w2D4q3Um+tCTeRfYzcF6vlAFSNl+fLtcjvpsoWcP3aySSkDYEMhJNlBd932P0ewp0FpW
         KCVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693822230; x=1694427030;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dx1PWfrajZrb9Pj8f/Iv4yru2tg7csQHpLgsZo9vktc=;
        b=CZRfkTZNhp1HTKB5SbS+KIMH3LB4SniV4wAyowTEC9DGNRZLklT+PGBysYrH/XfAnx
         LP0qDpQEhm4pvUtpnTbVCxdUaldTyUWgCyPcTMTtfMZOwQhh38PzoGFhNf/HH3wGMB1U
         8+qpk8/382Raw5W2Hcc7egp4SSHUzjr6+XnLXSzeJzV+NYxSTWnIHFZWJYKL+tlqZIlB
         Xae2kbYkGKocdzU2VEHRHgj+q0b+Fm5WhUzfN/rsd+UOlmwQ1Wwpx2NrQYw5krW/ATvi
         CnWdzGM4ta55SpFaW5seBktTLeVdTd1G2wdAmABPwhBOgwcno0KllkrzEPiEio5sDwel
         ty9A==
X-Gm-Message-State: AOJu0Yyl0jelE6eLZZJc+c1clopt9FQ1Ej1TM4mmZIgmLklWTvWxiHv9
        YV+THMzJWv03Z++2twnEMs8=
X-Google-Smtp-Source: AGHT+IEmMOS4GZ/v1WYMs76qIwBkFz7+wc3dW03JIVF5dnUCQWKdrxWeRawuMH8/6JZue22kypmjBw==
X-Received: by 2002:adf:ed84:0:b0:31a:d450:c513 with SMTP id c4-20020adfed84000000b0031ad450c513mr7880151wro.26.1693822229857;
        Mon, 04 Sep 2023 03:10:29 -0700 (PDT)
Received: from [192.168.1.101] ([90.242.223.1])
        by smtp.googlemail.com with ESMTPSA id x16-20020adfffd0000000b0031c8a43712asm14083307wrs.69.2023.09.04.03.10.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Sep 2023 03:10:29 -0700 (PDT)
Message-ID: <553482a5-e7cc-47ed-9279-307f258748ca@gmail.com>
Date:   Mon, 4 Sep 2023 11:10:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] sequencer: fix error message on failure to copy
 SQUASH_MSG
Content-Language: en-US
To:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>, git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
References: <20230903151132.739136-1-oswald.buddenhagen@gmx.de>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20230903151132.739136-1-oswald.buddenhagen@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/09/2023 16:11, Oswald Buddenhagen wrote:
> The message talked about renaming, while the actual action is copying.
> This was introduced by 6e98de72c ("sequencer (rebase -i): add support
> for the 'fixup' and 'squash' commands", 2017-01-02).
> 
> Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
> 
> ---
> i didn't try verifying whether the action shouldn't be actually be a
> move, as i'm getting lost in this forest of files.

This looks good, thanks. I think copying the file is OK. We're creating 
.git/SQUASH_MSG as a convenience in case the user decides to commit the 
conflict resolution themselves rather than leaving it to "rebase 
--continue". I don't think we reuse the contents of 
rebase_path_squash_msg() when tho rebase continues but copying it 
certainly isn't wrong and we're not in a hot path where we need to worry 
about the cost of copying a small file.

Best Wishes

Phillip

> Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
> Cc: Phillip Wood <phillip.wood123@gmail.com>
> Cc: Junio C Hamano <gitster@pobox.com>
> 
> ---
> totally on a tangent, does someone feel like teaching copy_file() to try
> ioctl(FICLONE) (i.e., reflink) first?
> ---
>   sequencer.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sequencer.c b/sequencer.c
> index a66dcf8ab2..2f3d7d4eee 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -2320,7 +2320,7 @@ static int do_pick_commit(struct repository *r,
>   			const char *dest = git_path_squash_msg(r);
>   			unlink(dest);
>   			if (copy_file(dest, rebase_path_squash_msg(), 0666)) {
> -				res = error(_("could not rename '%s' to '%s'"),
> +				res = error(_("could not copy '%s' to '%s'"),
>   					    rebase_path_squash_msg(), dest);
>   				goto leave;
>   			}

