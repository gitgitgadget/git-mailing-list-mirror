Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C42B6E94101
	for <git@archiver.kernel.org>; Fri,  6 Oct 2023 18:55:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233461AbjJFSzD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Oct 2023 14:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233332AbjJFSyo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2023 14:54:44 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D3B8197
        for <git@vger.kernel.org>; Fri,  6 Oct 2023 11:53:25 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2bb9a063f26so29653361fa.2
        for <git@vger.kernel.org>; Fri, 06 Oct 2023 11:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696618403; x=1697223203; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F0QqPpKV5ge44P1w7Uc3moqarlvU/mj5PrzSgCUjjeQ=;
        b=eulbEi7SGcVDSenPmzcUoNEbzS3pvTnX+87Ld5GFfQHxYrAGdR+QRMH2HDc0uHMAJb
         CMA4R4k0j4bIyb06Ff3tIkHAOcID6ZQy9L5J0eRR6pQVYyZxfqkKsgd3R1RTUBvLNr5Z
         HBW4OQ16yRrwrt3PKFSVmaTG+VjVycb7AD8RklfIiIBl+AlCVByjS5301ZRb96msLYsA
         6VGMCoeoBfg4XxE7kTBefm4OPympOHc81PlWeXTIDGfiDARQEI6z9udSSnVpnf/GRLo9
         +sBN1UbnUCxLjRSlrC4IQifIQEX5lMusHPliBwNUmgs6jNi9A/88Kjs0sLelLOF+VDhC
         afBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696618403; x=1697223203;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F0QqPpKV5ge44P1w7Uc3moqarlvU/mj5PrzSgCUjjeQ=;
        b=tbTgjKO7LsQaDVA9oKxPoH8KmM896EPgGK1mVRMckrOkACCX7bkcqlhOry5TGr9UK4
         vYF+vALElt+XkfDLH706C08UxuwBe8aVfbZCLnJaP5A7EnNdfO46cmL8mLw3Gf5QZajz
         EYlit3A8mhrFfyqI0RBAc2mf2BHGXtkTDjFMW97EsvH5b01ToB1oaF2upErzmjTcPWOV
         k+vNDcUbt4wmY5/kucHQdNGPXBTkgmgDdw6aN+XJ52ibrEo6ZZjQ9aQIQI9cl53m7p2Q
         o5KJB3wvnKtwx1Ho+v+w5oLaYgja72rzRsCb5GQG5L/gANY4yzq9K5uYoaTOgaB5b28j
         msvA==
X-Gm-Message-State: AOJu0YxKS3yHjP4knfdHYz0GQWbHItDNhJu9mmQZ4n7TJ2vkL307JX3i
        ptqS7gKXFa97fHr1cq2BgOy1hyK08Ew=
X-Google-Smtp-Source: AGHT+IGEU5kH+vYJFp//zRkk4Qui8C5XoqvERk6X7NmEeYljcj2Rh1ND9D1zifR2tAjIGLqWbpsTRQ==
X-Received: by 2002:a2e:9882:0:b0:2bd:f8:1b6a with SMTP id b2-20020a2e9882000000b002bd00f81b6amr6900710ljj.36.1696618402857;
        Fri, 06 Oct 2023 11:53:22 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id x2-20020a2e8802000000b002bce38190a3sm887925ljh.34.2023.10.06.11.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 11:53:22 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 3/3] completion: complete '--dd'
References: <20230909125446.142715-1-sorganov@gmail.com>
        <20231004214558.210339-1-sorganov@gmail.com>
        <20231004214558.210339-4-sorganov@gmail.com>
        <xmqqlecgeoan.fsf@gitster.g>
Date:   Fri, 06 Oct 2023 21:53:21 +0300
In-Reply-To: <xmqqlecgeoan.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        05 Oct 2023 14:45:36 -0700")
Message-ID: <87v8bjpopq.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>> '--dd' only makes sense for 'git log' and 'git show', so add it to
>> __git_log_show_options which is referenced in the completion for these
>> two commands.
>>
>> Signed-off-by: Sergey Organov <sorganov@gmail.com>
>> ---
>>  contrib/completion/git-completion.bash | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
>> index 133ec92bfae7..ca4fa39f3ff8 100644
>> --- a/contrib/completion/git-completion.bash
>> +++ b/contrib/completion/git-completion.bash
>> @@ -2042,7 +2042,7 @@ __git_log_shortlog_options="
>>  "
>>  # Options accepted by log and show
>>  __git_log_show_options="
>> -	--diff-merges --diff-merges= --no-diff-merges --remerge-diff
>> +	--diff-merges --diff-merges= --no-diff-merges --dd --remerge-diff
>>  "
>>  
>>  __git_diff_merges_opts="off none on first-parent 1 separate m combined c dense-combined cc remerge r"
>
> Quite straight-forward.  I am kind of surprised that we do not have
> to list "--cc" here.  Perhaps it is so short and common that people
> do not need completion help?
>
> But that is not a new problem caused by this series, so it is OK.
>
> Unless "--cc" gets completed without being listed here, using some
> automation like the "--git-completion-helper" option, in which case
> we may want to see if we can remove all of the above and complete
> them the same way as "--cc" gets completed.  I didn't check.

I checked, though with rather old 2.25.1 running on my Ubuntu, and it
is not completed.

I think that it's still a good idea to add --cc to completions, so that
it's there in the suggested completion list, for the sake of
discoverability. That's why I bothered to add --dd to the completions.

Thanks,
-- Sergey Organov


>
> Thanks.
