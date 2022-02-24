Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFEEBC433EF
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 14:48:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbiBXOtJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 09:49:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiBXOtH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 09:49:07 -0500
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B7D222182
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 06:48:34 -0800 (PST)
Received: by mail-oo1-xc2e.google.com with SMTP id j7-20020a4ad6c7000000b0031c690e4123so3713440oot.11
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 06:48:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=20gO99yziOQrWCvo6ceGP+ZKbfyLi6ofNTNppcA5mu0=;
        b=I79YodQwsI5GAEHT1C1DDCtsvabNANC+OW6FsxLwkjx7eOtNAoXsBgucKxKh6eD+zL
         j/nXsfy/1doHpybK6UBV3Oz+nusllNaOW50VaFUG+n7AxRpJAj3KVU/nu3FXQcdQKVdT
         gQeKUm4bXjy5TvbQzreEzmz4Y2TfoUslBL5oFtwstD/+koLsalf6gJw9LYPekRjVhxIm
         IHUAMVEDHYHtK59BQgtSX/ZDB2XH9kFDCPGFFA8V8/QctGVGdvC8XpzJ9oqSoAFidJcE
         64tsPdf1WtyNulw8PFFVROgSdQ6iOYw92VV8+5QU8F13+A4w0wfre973TpLzX2Q9bDGL
         +0sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=20gO99yziOQrWCvo6ceGP+ZKbfyLi6ofNTNppcA5mu0=;
        b=578/IyQGyZNNy6pBw+1KHjXLdw9zBKTY3JPtlUeyxkBoCBrDmYc53RCn1EWKLb58g3
         fFDUF7T+LKzukRM0P7A4nHRNYa2ks5JVjSQb014uTYgOhAGeaJzsYzO2E04N7Xaaa9sv
         ec8G2M0lXYUy2rDdvjK+MAVPPL98Vra+d61suanemH18SbJdzq8jfKQzkzI8sN/Cw8kp
         EnG6BzBVwkKL6QYtIBNn8tq9tqdAduwY4XdO9J5m+SSpTHTnzNwWDow94ZLBpxx8W3Cy
         fUCWRdNKDXXO5TutlIUKTCOnSSZvrmZCw2wMLej8ddnJ7+djv7fPjxQmqcvkUH6nvFBL
         e8oQ==
X-Gm-Message-State: AOAM532MfVHGP3mCHZuUFA+EVDhAcUkJshwF+WMznkfLcn+jQFylidaN
        K2TVW3tcUbPOSjSry7wDBMM/
X-Google-Smtp-Source: ABdhPJznkDxDvnLvcFUhnzN3YcaCo6NetFmnmcLeJa9iL92TX4fH8Pw/RyDOZdwFAqcVBbFPTLi0Tg==
X-Received: by 2002:a05:6871:400d:b0:b4:6ffe:cb0a with SMTP id kx13-20020a056871400d00b000b46ffecb0amr1287657oab.158.1645714114138;
        Thu, 24 Feb 2022 06:48:34 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id o205sm1509246oia.22.2022.02.24.06.48.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Feb 2022 06:48:33 -0800 (PST)
Message-ID: <e3b854c5-540a-980a-ceac-492d1ad3af90@github.com>
Date:   Thu, 24 Feb 2022 09:48:31 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 01/23] fsm-listen-win32: handle shortnames
Content-Language: en-US
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.1143.git.1644940773.gitgitgadget@gmail.com>
 <23f38338cecd270c15fd1bba42de79c53e14ca2a.1644940773.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <23f38338cecd270c15fd1bba42de79c53e14ca2a.1644940773.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/15/2022 10:59 AM, Jeff Hostetler via GitGitGadget wrote:
> From: Jeff Hostetler <jeffhost@microsoft.com>
> 
> Teach FSMonitor daemon on Windows to recognize shortname paths as
> aliases of normal longname paths.  FSMonitor clients, such as `git
> status`, should receive the longname spelling of changed files (when
> possible).
> 
> Sometimes we receive FS events using the shortname, such as when a CMD
> shell runs "RENAME GIT~1 FOO" or "RMDIR GIT~1".  The FS notification
> arrives using whatever combination of long and shortnames were used by
> the other process.  (Shortnames do seem to be case normalized,
> however.)
> 
> Use Windows GetLongPathNameW() to try to map the pathname spelling in
> the notification event into the normalized longname spelling.  (This
> can fail if the file/directory is deleted, moved, or renamed, because
> we are asking the FS for the mapping in response to the event and
> after it has already happened, but we try.)

I recall when we first discovered that this was important for users.
I'm glad we haven't needed to worry about it since this fix.

> Special case the shortname spelling of ".git" to avoid under-reporting
> these events.

This is particularly critical due to the case of deleting the .git
directory being really important to catch, but GetLongPathNameW()
won't work in that case.

> +	if (!GetLongPathNameW(buf_in, buf_out, MAX_PATH)) {
> +		/*
> +		 * The shortname to longname conversion can fail for
> +		 * various reasons, for example if the file has been
> +		 * deleted.  (That is, if we just received a
> +		 * delete-file notification event and the file is
> +		 * already gone, we can't ask the file system to
> +		 * lookup the longname for it.  Likewise, for moves
> +		 * and renames where we are given the old name.)
> +		 *
> +		 * NEEDSWORK: Since deleting or moving a file or
> +		 * directory by shortname is rather obscure, I'm going
> +		 * ignore the failure and ask the caller to report the
> +		 * original relative path.  This seemds kinder than

s/seemds/seems/

> +		 * failing here and forcing a resync.
> +		 */
> +		return GRR_NO_CONVERSION_NEEDED;
> +	}

This NEEDSWORK is something I saw while reading that makes it seem
like we _need_ to do something here. I think this is an appropriate
short-term solution that we can revisit if necessary. I don't
anticipate that actually being the case, though.

Thanks,
-Stolee
