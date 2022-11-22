Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5EC0C43217
	for <git@archiver.kernel.org>; Tue, 22 Nov 2022 16:41:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232783AbiKVQk7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Nov 2022 11:40:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232583AbiKVQk4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2022 11:40:56 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75845275D2
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 08:40:55 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id p13-20020a05600c468d00b003cf8859ed1bso11733378wmo.1
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 08:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IGs14wrbdvZf3I1fhvRc3ltnpVRTvyjlmMwbNmXk0Y0=;
        b=c1MKrOSLGZuSvhr3jvQ3QhYxdIJ9qS3eNAcwcGnilfaYHcPKLpCDjG3azlnFGcM5Xx
         lEd1uivUb9/VA6RHLjD9yruel34mZT3llhVovK8G/q5mOROf602IVGUngLdbu78D7Uz7
         w5uqOg8XwWLUdxMNjNKhVogLrHAw4WZyb32f8+8np6BEdJZ5KWsTEIH2U7QzYQguoOxP
         cKWYAUMUfBDYO6F1sWw2KQ8WWruVtUBzDVq9e88j9HetXlAHubRzaA4lYbE0URXdoKWN
         d6BmHDKMTaH2gA32aCP+wGxfEH9MAUdkC8LfG6Two+Z61poIGq+0N/NLcFapIq8qA+JJ
         I/BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IGs14wrbdvZf3I1fhvRc3ltnpVRTvyjlmMwbNmXk0Y0=;
        b=oNUHjQZ2CKL1gxuZ6CtDWsnwhCVUeMWnncZdE0qTs1WnugYoeKJ89f5z0v/Mq0W7Os
         2xuYL0B8c9Uzh5tZ8LziHwLl/px4pjDjsFtX4b+1iGYs3UdkPvA6VYiURWLYGXlfv/qX
         bpYgiPv1qkGTs6zsW1XRp2WrWUYUet9KfJhH9Vgj+St1QNmXLckjrpxomllaCNCc1aoV
         qW6TzBQL3eTXqXbnTxpZUFzWtYSFZIScX3q6Jmt8me93QcBU6/9htShn+DqBHRqKSh+q
         TLZyX8OwNcMP9cveu/1PZ1zPuB/40i4ffMIdfed0A788IOlxD7t4LEE+ZBw3NdvDtHW6
         68Hg==
X-Gm-Message-State: ANoB5pnpTYYmhcYRj+2muCQU5gAnZUiFSR2Kcp2EzT4IeyYYn2hSrSz4
        IrZLq/z0uENOql4wrBpQchc=
X-Google-Smtp-Source: AA0mqf5pkVxN5KoKmex/I45JbCYNWScLSXTnRO1aj6WkAZ0oAobwIJDh8ReEUJukX0ey3Db7pf2b1g==
X-Received: by 2002:a05:600c:4386:b0:3cf:a4a6:a048 with SMTP id e6-20020a05600c438600b003cfa4a6a048mr3482156wmn.202.1669135253632;
        Tue, 22 Nov 2022 08:40:53 -0800 (PST)
Received: from [192.168.1.74] ([31.185.185.212])
        by smtp.gmail.com with ESMTPSA id p15-20020a05600c468f00b003cfd10a33afsm22769891wmo.11.2022.11.22.08.40.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Nov 2022 08:40:53 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <61b42a7c-5772-dec2-c895-386f1613ac35@dunelm.org.uk>
Date:   Tue, 22 Nov 2022 16:40:52 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 2/2] git-jump: invoke emacs/emacsclient
Content-Language: en-US
To:     Yoichi Nakayama via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>
References: <pull.1423.v3.git.1669033620.gitgitgadget@gmail.com>
 <pull.1423.v4.git.1669126703.gitgitgadget@gmail.com>
 <2f0bffb484beccf58f2440ed5e2c04a1ba26e6c3.1669126703.git.gitgitgadget@gmail.com>
In-Reply-To: <2f0bffb484beccf58f2440ed5e2c04a1ba26e6c3.1669126703.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Yoichi

On 22/11/2022 14:18, Yoichi Nakayama via GitGitGadget wrote:
> From: Yoichi Nakayama <yoichi.nakayama@gmail.com>
> 
> It works with GIT_EDITOR="emacs", "emacsclient" or "emacsclient -t"

Thanks for working on this, I'm looking forward to being able to use 
"git jump" with emacs.

> Signed-off-by: Yoichi Nakayama <yoichi.nakayama@gmail.com>
> ---
>   contrib/git-jump/git-jump | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
> 
> diff --git a/contrib/git-jump/git-jump b/contrib/git-jump/git-jump
> index babb3b5c68d..bfd759aa4b2 100755
> --- a/contrib/git-jump/git-jump
> +++ b/contrib/git-jump/git-jump
> @@ -26,6 +26,17 @@ open_editor() {
>   	eval "$editor -q \$1"
>   }
>   
> +open_emacs() {
> +	# Supported editor values are:
> +	# - emacs
> +	# - emacsclient
> +	# - emacsclient -t
> +	editor=`git var GIT_EDITOR`
> +	# Wait for completion of the asynchronously executed process
> +	# to avoid race conditions in case of "emacsclient".
> +	eval "$editor --eval \"(prog1 (switch-to-buffer-other-frame (compilation-start \\\"cat $@\\\" 'grep-mode)) (delete-other-windows) (while (get-buffer-process (current-buffer)) (sleep-for 0.1)) (select-frame-set-input-focus (selected-frame)))\""

I just tried this out in a frame (window for non emacs users) showing 
two files and the (delete-other-windows) call replaced both of them with 
the grep buffer. It would be nicer if it created a new window in the 
current frame or showed the grep buffer in one of the existing windows. 
If I delete (delete-other-windows) then the first time I run "git jump" 
it shows the grep buffer in the frame I already have open, but then if I 
run it again without closing the grep buffer it opens a new frame. I 
wonder if it would be better just to close the buffer if it exists 
before creating the new one or pass NAME-FUNCTION argument to 
compilation-start that creates unique names.

I'm using emacsclient as my editor and when I run "git jump" it prints

#<buffer *grep*>

in the terminal (presumably because that is the return value of 
select-frame-set-input-focus)

Could we read the file and set the buffer's mode to grep-mode (or 
compilation-mode?) without forking cat?

Best Wishes

Phillip

> +}
> +
>   mode_diff() {
>   	git diff --no-prefix --relative "$@" |
>   	perl -ne '
> @@ -98,4 +109,8 @@ tmp=`mktemp -t git-jump.XXXXXX` || exit 1
>   type "mode_$mode" >/dev/null 2>&1 || { usage >&2; exit 1; }
>   "mode_$mode" "$@" >"$tmp"
>   test -s "$tmp" || exit 0
> +if git var GIT_EDITOR | grep emacs >/dev/null; then
> +	open_emacs "$tmp"
> +	exit 0
> +fi
>   open_editor "$tmp"
