Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FFA4C4332F
	for <git@archiver.kernel.org>; Tue, 18 Oct 2022 12:40:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbiJRMkr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Oct 2022 08:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiJRMko (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Oct 2022 08:40:44 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6291646638
        for <git@vger.kernel.org>; Tue, 18 Oct 2022 05:40:40 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id g27so20220180edf.11
        for <git@vger.kernel.org>; Tue, 18 Oct 2022 05:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h56ejDzYW6fQwQFgidQejFumLQYu9y9ESxfyjDPVAJc=;
        b=FFdCjo4EFFdPr8l2C+yHdEiRZkcIvcPzMybWoNJgYReado9wb2ipf9AJHt/4qx7N7P
         gY5MK0IPNhKqpTHOAt22iVNlHpVJRhLW7SNtKmNlXXEJGd9vSa6kFbkuhYpS/zTKjaxv
         9HFEiAf3/VmJ63Bw7K4eKRtBURRWnUAltxSn0daR53ciNvUsWuwNsJtxxlkTyrPRI/1m
         YQLwjAFux3q6Q0Mt3gyYx4qjg5D8z8J/P2nGGeanEYAIuGrPNBM4MKaBpUVPWBsgEFYO
         xooln+ErHaexwHX2PzVD+4pSinBP9ga2p9EKdpCVBtBwHSakpmbYkea0S8wR8hOBr7D9
         KTDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h56ejDzYW6fQwQFgidQejFumLQYu9y9ESxfyjDPVAJc=;
        b=Sudd9248fb1FdXADfBddKKCyKpO6DhKzQyZxsjF2wBuZgeBahQpGSUaNKOOxX4hAbs
         aqZ74/zjW+SbZg15s+L82r4JIsqTytSHy8hq5tf8GIpi0BJxoMhSsJUYXMoLU7gT28fH
         lyvOIVfKaXpgDg5u9JwHAjgReHVZ1KlkfUZcKGk5JDRc5PTLgHeOkuRWAzg7xAnB/hDr
         2tbNWUFJkIxjgBQXnYI/8gaHbHx9xcP/7rGYpFoqIMjyUpUrsmcPd/L9OM/sqcYXIQFX
         y0GnJaMIDB15/K5ZB4lHL8VLVO5ee3YxIjOaN9+/kQgZ8CTuoUuLYWoZXKo0eos6GyuP
         tudg==
X-Gm-Message-State: ACrzQf0+8wbriXJZtU9P6C+NnD7n4fZTeMDMHYNU2kk+YQGACmln4RVd
        fn9pZwP3y9UE0iLckjPaQdZxSD2SCslwPg==
X-Google-Smtp-Source: AMsMyM40EN/wcL5i8Y3aZufr/Xq2ggiP4AJ8MNfPGZqLjO1iem9CekZkFZxN32GAqDO3a59jAYODjQ==
X-Received: by 2002:a05:6402:35cc:b0:45d:4a39:2a43 with SMTP id z12-20020a05640235cc00b0045d4a392a43mr2466413edc.304.1666096838835;
        Tue, 18 Oct 2022 05:40:38 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id la5-20020a170907780500b0077f20a722dfsm7549062ejc.165.2022.10.18.05.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 05:40:37 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1okltc-005k0b-1A;
        Tue, 18 Oct 2022 14:40:36 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric DeCosta via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric DeCosta <edecosta@mathworks.com>
Subject: Re: [PATCH 01/12] fsmonitor: refactor filesystem checks to common
 interface
Date:   Tue, 18 Oct 2022 14:29:55 +0200
References: <pull.1352.git.git.1665326258.gitgitgadget@gmail.com>
 <ec49a74086dee4545a3bb7b24c8da22e77aef579.1665326258.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <ec49a74086dee4545a3bb7b24c8da22e77aef579.1665326258.git.gitgitgadget@gmail.com>
Message-ID: <221018.86r0z5i9tn.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Oct 09 2022, Eric DeCosta via GitGitGadget wrote:

> From: Eric DeCosta <edecosta@mathworks.com>
> [...]
> +int fsmonitor__get_fs_info(const char *path, struct fs_info *fs_info)
> +{
> +	struct statfs fs;
> +	if (statfs(path, &fs) == -1) {
> +		int saved_errno = errno;
> +		trace_printf_key(&trace_fsmonitor, "statfs('%s') failed: %s",
> +				 path, strerror(saved_errno));
> +		errno = saved_errno;
> +		return -1;
> +	}
> +
> +	trace_printf_key(&trace_fsmonitor,
> +			 "statfs('%s') [type 0x%08x][flags 0x%08x] '%s'",
> +			 path, fs.f_type, fs.f_flags, fs.f_fstypename);
> +
> +	if (!(fs.f_flags & MNT_LOCAL))
> +		fs_info->is_remote = 1;
> +	else
> +		fs_info->is_remote = 0;

Odd to go through the trouble of inverting the flag check like this just
to assign to it manually. I'd think:

	if (flags & LOCAL)
		is_remote = 0;
	else
		is_remote = 1;

Would make more sense, or actually if you do invert it:

	fs_info->is_remote = !(fs.f_flags & MNT_LOCAL);

No?

> +	fs_info->typename = xstrdup(fs.f_fstypename);

Instead of xstrdup()-ing this...
> +
> +	trace_printf_key(&trace_fsmonitor,
> +				"'%s' is_remote: %d",
> +				path, fs_info->is_remote);
> +	return 0;
> +}
> +
> +int fsmonitor__is_fs_remote(const char *path)
> +{
> +	struct fs_info fs;
> +	if (fsmonitor__get_fs_info(path, &fs))
> +		return -1;
> +
> +	free(fs.typename);

...just to have some callers free() it again, maybe it makes sense to
say that return a const char *, and if you need it past the call to
fsmonitor__get_fs_info() you should do the xstrdup() yourself.

Skimming the end-state the OSX one gives you a copy of your own, as it's
stuck into the struct you provided.

For Linux we don't get a copy, but it's filled per getmntent() call.

Anyway, small potatoes...

> +	if (h == INVALID_HANDLE_VALUE) {
> +		error(_("[GLE %ld] unable to open for read '%ls'"),
> +		      GetLastError(), wpath);
> +		return -1;
> +	}

Do away with the braces and just "return error(..."

> +
> +	if (!GetFileInformationByHandleEx(h, FileRemoteProtocolInfo,
> +		&proto_info, sizeof(proto_info))) {
> +		error(_("[GLE %ld] unable to get protocol information for '%ls'"),
> +		      GetLastError(), wpath);
> +		CloseHandle(h);
> +		return -1;
> +	}
> +
> +	CloseHandle(h);

And this duplication you can avoid with an earlier:

	int ret = 0;


Then
		ret = error(...)
		goto cleanup;

and then at the end:

cleanup:
	CloseHandle(h)
	return ret;

> +	/*
> +	 * Do everything in wide chars because the drive letter might be
> +	 * a multi-byte sequence.  See win32_has_dos_drive_prefix().
> +	 */
> +	if (xutftowcs_path(wpath, path) < 0) {
> +		return -1;
> +	}

Don't need the braces.
> +
> +	/*
> +	 * GetDriveTypeW() requires a final slash.  We assume that the
> +	 * worktree pathname points to an actual directory.
> +	 */
> +	wlen = wcslen(wpath);
> +	if (wpath[wlen - 1] != L'\\' && wpath[wlen - 1] != L'/') {
> +		wpath[wlen++] = L'\\';
> +		wpath[wlen] = 0;
> +	}
> +
> +	/*
> +	 * Normalize the path.  If nothing else, this converts forward
> +	 * slashes to backslashes.  This is essential to get GetDriveTypeW()
> +	 * correctly handle some UNC "\\server\share\..." paths.
> +	 */
> +	if (!GetFullPathNameW(wpath, MAX_PATH, wfullpath, NULL)) {
> +		return -1;
> +	}
> +
> +	driveType = GetDriveTypeW(wfullpath);

Can't you just do away with this driveType variable and assign directly
to fs_info->is_remote if it's == DRIVE_REMOTE?...

> +	trace_printf_key(&trace_fsmonitor,
> +			 "DriveType '%s' L'%ls' (%u)",
> +			 path, wfullpath, driveType);

...well, not due to this, but do we really need to log the raw value &
is that meaningful? A user of the trace2 logs would need to reverse map
that, doesn't the API provide some "what is it then?" function?

> +
> +	if (driveType == DRIVE_REMOTE) {
> +		fs_info->is_remote = 1;

Here we do that assignment...

> +		if (check_remote_protocol(wfullpath) < 0)
> +			return -1;
> +	} else {
> +		fs_info->is_remote = 0;
> +	}
> +
> +	trace_printf_key(&trace_fsmonitor,
> +				"'%s' is_remote: %d",
> +				path, fs_info->is_remote);

ditto just "is remote?"
