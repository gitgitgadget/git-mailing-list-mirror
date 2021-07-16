Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F70AC07E95
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 10:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 270BE613FA
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 10:23:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238243AbhGPK0G (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jul 2021 06:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238337AbhGPK0E (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jul 2021 06:26:04 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 301A8C061762
        for <git@vger.kernel.org>; Fri, 16 Jul 2021 03:23:10 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id f17so11487646wrt.6
        for <git@vger.kernel.org>; Fri, 16 Jul 2021 03:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UvjmkAYWlM4JNMXwFsWCMu+QM20aKZkfFcQupTdivig=;
        b=qe9UTzrhmayRDMLifWFo40M0TEcfcuZUOxP6qu7Ihhkm1mUWTuKhy/bfWMbeBajvPq
         jINSThY6b+lIHLX0OSMS0PlRWrDsbPDi6pMpzfmXuA+wh+sxolPKg1lQ9pTs3bu7glQx
         Txfb4yfpHUWIYyuwux2JwTN2M+DHrDX9pumU6oY+XMA5NDoZ2dcrMDzIz0XYZo+DQdyL
         61u7LOLkaReo7LiSFeXFyCgTJVxKlktgvAiCaPNwFbCeMdtc6Jw7PMHMtGrSVZRr77RU
         S9f5fgWbJVBzu8g2UYKERfbdCLU/5SW/m0XaYSlOX7bm6lmv27a56ea+ntn/WK1Jsn2i
         I0Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UvjmkAYWlM4JNMXwFsWCMu+QM20aKZkfFcQupTdivig=;
        b=Jw2jaQMKYF4zJ9yqrh/gHQeI/jFEibu6LhgKCnwJCpH1zIk0/vWx7Cdj5PY6PpoHTf
         /AKxSNeyV7xIKgrYS2/IXyXz/XKzVo7SHnZFUJKhf85vekoh6Up7QtSs3nJuTY5snDjq
         Nf3gAi4RzmiwAsRdTgLFoz2betP5fpysyafR+U56bUIo2VSgGIEMMkOPRNXAjh20rZNH
         aGUOHk6cfg10OGYD8AAOreojUU9tN5J94jKHsvNMxSHseof7uMy3P/P4W/odnyrRhPp6
         mQCqsUIQwxNNilxJ3lFtzrP1WMcmCAQx6iM/05nxQE3ICmtNZuirtdwCP0uSZvWa6D1V
         X7ZA==
X-Gm-Message-State: AOAM5310Uwe8qPW42irvTnPvR7px3BGYclzLHeIVG4XpPicKiQ6HGeNw
        GE7bQEZ2VXvZGp0MV8QyGHE=
X-Google-Smtp-Source: ABdhPJwrfZwdlsKZ9i/vhcKDTZig1nF5HIlH339oybFTVM2TR5jI3bloV7bya0RtMPKuJB/XV07FMQ==
X-Received: by 2002:a05:6000:1a8b:: with SMTP id f11mr11358002wry.408.1626430988758;
        Fri, 16 Jul 2021 03:23:08 -0700 (PDT)
Received: from [192.168.1.201] (141.2.7.51.dyn.plus.net. [51.7.2.141])
        by smtp.googlemail.com with ESMTPSA id v14sm9760537wru.77.2021.07.16.03.23.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jul 2021 03:23:08 -0700 (PDT)
Subject: Re: [PATCH 2/2] merge: make sure to terminate message with newline
To:     Luca Weiss via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Luca Weiss <luca@z3ntu.xyz>
References: <pull.1048.git.git.1626421416.gitgitgadget@gmail.com>
 <31371c25743e1001b4fac89e80e7206ff477ac8a.1626421416.git.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <8678772b-dd5d-9188-8b63-98d05cedb323@gmail.com>
Date:   Fri, 16 Jul 2021 11:23:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <31371c25743e1001b4fac89e80e7206ff477ac8a.1626421416.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Hi Luca

Thanks for your patches. It would be very helpful to have the 
explanation from the cover letter in the commit messages for both 
commits to explain why this change is being made, otherwise that 
information will not appear in the history.

The cover letter says this happened when using '--no-edit', but unless 
I've missed something 'git merge --no-edit' creates its message using 
fmt_merge_msg() which calls strbuf_complete_line() just before it 
returns. append_signoff() and 'merge -m' always terminate the message 
with a newline. The only path I found that does not ensure the message 
ends with a newline before calling the prepare-commit-msg hook is when 
using '-F' and I suspect that may have been a deliberate decision but it 
could be an oversight. In any case we would want to make sure that 'git 
commit -F' and 'git merge -F' to behave the same which I think they do 
at the moment.

Best Wishes

Phillip

On 16/07/2021 08:43, Luca Weiss via GitGitGadget wrote:
> From: Luca Weiss <luca@z3ntu.xyz>
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
>   builtin/merge.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/builtin/merge.c b/builtin/merge.c
> index a8a843b1f54..646bb49367f 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -867,6 +867,7 @@ static void prepare_to_commit(struct commit_list *remoteheads)
>   	}
>   	if (signoff)
>   		append_signoff(&msg, ignore_non_trailer(msg.buf, msg.len), 0);
> +	strbuf_complete_line(&msg);
>   	write_merge_heads(remoteheads);
>   	write_file_buf(git_path_merge_msg(the_repository), msg.buf, msg.len);
>   	if (run_commit_hook(0 < option_edit, get_index_file(), "prepare-commit-msg",
> 

