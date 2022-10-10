Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 851AAC433FE
	for <git@archiver.kernel.org>; Mon, 10 Oct 2022 10:09:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231557AbiJJKJd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Oct 2022 06:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbiJJKJc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2022 06:09:32 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4924E1263E
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 03:09:31 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id a13so15250285edj.0
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 03:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vLuErcSdZVP67oXN2gSvYgny5b259LCWVVoj90X7MT4=;
        b=oOMKr29Xo4LJfeH1c0anWpmI07qRIxtCEw79F9BNPf46urNwb0w98qYbxrHhQwm+z1
         den2Ou/LLOU/clIvi8MV7NFGRF72sGdYTu38AMq3gf0D7CruzfaSFNZiNL4XlbWkHD/r
         9VJsoS7s85Fa6GHOUBl2/fLVIh29v562fAWExJzqusYedyumuP4A5n2FHr8ikyO+vjg2
         j2KKG0ZQQimqH8goVJKZny3vh0DvZwSIRdOWx5MKVwufX4kOuOQ73fgfGHxIqXk788q0
         bkjEkWaoqCnBrZfF1wKbp3SWORcSG2UGQDH0gfTzu8lHr0WBghVPMLDhW78qS6GYxXwo
         LZhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vLuErcSdZVP67oXN2gSvYgny5b259LCWVVoj90X7MT4=;
        b=u0+8xAQLo21FJVD5DgoXxGC8fQAoKSTzm57a6Kis4TPgQXqRmqEylisW+F0hs6BX5H
         v/9qAAz3HeG3H886i2keRw8MUvs9naT2HJI2wk2qkbjyRPz8plL1gP+uTL4yfaP62E98
         JrSqYSzQhHTkIfB13zKo5o3L9am7+yoWB3FY2sZmd0Vv9y1t+BFdfjopWoCXCuu0bKaz
         WY61Xf777gAonjFHTyYlwIOzF/yN9wepjjOGjGPIGHWzfHfxlaQaaSo0wgwkP0+wVnBv
         KURsp+mfDfDbUd9nMBL4nXzl9TH3y9o3dLA/8OwNwHYmDfNIjarR4C7KJkTjdYTLxJHp
         tVrA==
X-Gm-Message-State: ACrzQf2XlCUKO3sbvn2BuCpbi/AoK4j0xLSRZDjysnQj4U50dOJq7zfR
        0qpA/+FDuIy5xrIamu+glQ7hpcgjAzo=
X-Google-Smtp-Source: AMsMyM6dwcajP1U1h698ub53e9oc4NcXLVh7sVVIROIcQeLFn/jK2drp9m60ToeHLRmlVPAGYiD+uA==
X-Received: by 2002:aa7:c751:0:b0:459:b0e1:4ad7 with SMTP id c17-20020aa7c751000000b00459b0e14ad7mr17039991eds.193.1665396569658;
        Mon, 10 Oct 2022 03:09:29 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id p26-20020a17090653da00b0078d38cda2b1sm5060569ejo.202.2022.10.10.03.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 03:09:28 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ohpiw-003RHc-0r;
        Mon, 10 Oct 2022 12:09:26 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric DeCosta via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric DeCosta <edecosta@mathworks.com>
Subject: Re: [PATCH 08/12] fsmonitor: determine if filesystem is local or
 remote
Date:   Mon, 10 Oct 2022 12:04:01 +0200
References: <pull.1352.git.git.1665326258.gitgitgadget@gmail.com>
 <5ecbb3082f16956d049cfa98662f8e3384a6aea2.1665326258.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <5ecbb3082f16956d049cfa98662f8e3384a6aea2.1665326258.git.gitgitgadget@gmail.com>
Message-ID: <221010.86sfjwouqx.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Oct 09 2022, Eric DeCosta via GitGitGadget wrote:

> From: Eric DeCosta <edecosta@mathworks.com>
>
> Compare the given path to the mounted filesystems. Find the mount that is
> the longest prefix of the path (if any) and determine if that mount is on a
> local or remote filesystem.
>
> Signed-off-by: Eric DeCosta <edecosta@mathworks.com>
> ---
>  compat/fsmonitor/fsm-path-utils-linux.c | 163 ++++++++++++++++++++++++
>  1 file changed, 163 insertions(+)
>  create mode 100644 compat/fsmonitor/fsm-path-utils-linux.c
>
> diff --git a/compat/fsmonitor/fsm-path-utils-linux.c b/compat/fsmonitor/fsm-path-utils-linux.c
> new file mode 100644
> index 00000000000..369692a788f
> --- /dev/null
> +++ b/compat/fsmonitor/fsm-path-utils-linux.c
> @@ -0,0 +1,163 @@
> +#include "fsmonitor.h"
> +#include "fsmonitor-path-utils.h"
> +#include <errno.h>
> +#include <mntent.h>
> +#include <sys/mount.h>
> +#include <sys/statvfs.h>
> +
> +/*
> + * https://github.com/coreutils/gnulib/blob/master/lib/mountlist.c
> + */
> +#ifndef ME_REMOTE
> +/* A file system is "remote" if its Fs_name contains a ':'
> +   or if (it is of type (smbfs or cifs) and its Fs_name starts with '//')
> +   or if it is of any other of the listed types
> +   or Fs_name is equal to "-hosts" (used by autofs to mount remote fs).
> +   "VM" file systems like prl_fs or vboxsf are not considered remote here. */
> +# define ME_REMOTE(Fs_name, Fs_type)            \
> +	(strchr (Fs_name, ':') != NULL              \
> +	 || ((Fs_name)[0] == '/'                    \
> +		 && (Fs_name)[1] == '/'                 \
> +		 && (strcmp (Fs_type, "smbfs") == 0     \
> +			 || strcmp (Fs_type, "smb3") == 0   \
> +			 || strcmp (Fs_type, "cifs") == 0)) \
> +	 || strcmp (Fs_type, "acfs") == 0           \
> +	 || strcmp (Fs_type, "afs") == 0            \
> +	 || strcmp (Fs_type, "coda") == 0           \
> +	 || strcmp (Fs_type, "auristorfs") == 0     \
> +	 || strcmp (Fs_type, "fhgfs") == 0          \
> +	 || strcmp (Fs_type, "gpfs") == 0           \
> +	 || strcmp (Fs_type, "ibrix") == 0          \
> +	 || strcmp (Fs_type, "ocfs2") == 0          \
> +	 || strcmp (Fs_type, "vxfs") == 0           \
> +	 || strcmp ("-hosts", Fs_name) == 0)
> +#endif

So, this is just copy/pasted GPLv3 code into our GPLv2-only codebase?:
https://github.com/coreutils/gnulib/blob/cd1fdabe8b66c102124b6a5b0c97dded20246b46/lib/mountlist.c#L230-L247

> +static struct mntent *find_mount(const char *path, const struct statvfs *fs)
> +{
> +	const char *const mounts = "/proc/mounts";
> +	const char *rp = real_pathdup(path, 1);
> +	struct mntent *ment = NULL;
> +	struct mntent *found = NULL;
> +	struct statvfs mntfs;
> +	FILE *fp;
> +	int dlen, plen, flen = 0;
> +
> +	fp = setmntent(mounts, "r");
> +	if (!fp) {
> +		error_errno(_("setmntent('%s') failed"), mounts);
> +		return NULL;

This code would probably be nicer if you returned int, and passed a
pointer to a struct to populate as a paremeter. Then you could just
"return error..." for this and the below cases.

> +	}
> +
> +	plen = strlen(rp);
> +
> +	/* read all the mount information and compare to path */
> +	while ((ment = getmntent(fp)) != NULL) {
> +		if (statvfs(ment->mnt_dir, &mntfs)) {
> +			switch (errno) {
> +			case EPERM:
> +			case ESRCH:
> +			case EACCES:
> +				continue;
> +			default:
> +				error_errno(_("statvfs('%s') failed"), ment->mnt_dir);
> +				endmntent(fp);is 
> +				return NULL;
> +			}
> +		}
> +
> +		/* is mount on the same filesystem and is a prefix of the path */
> +		if ((fs->f_fsid == mntfs.f_fsid) &&
> +			!strncmp(ment->mnt_dir, rp, strlen(ment->mnt_dir))) {
> +			dlen = strlen(ment->mnt_dir);
> +			if (dlen > plen)
> +				continue;
> +			/*
> +			 * root is always a potential match; otherwise look for
> +			 * directory prefix
> +			 */
> +			if ((dlen == 1 && ment->mnt_dir[0] == '/') ||
> +				(dlen > flen && (!rp[dlen] || rp[dlen] == '/'))) {
> +				flen = dlen;
> +				/*
> +				 * https://man7.org/linux/man-pages/man3/getmntent.3.html
> +				 *
> +				 * The pointer points to a static area of memory which is
> +				 * overwritten by subsequent calls to getmntent().
> +				 */
> +				if (!found)
> +					CALLOC_ARRAY(found, 1);

It seems we never populate >1 of these, so don't you just want
xmalloc(). Or actually...

> +				free(found->mnt_dir);
> +				free(found->mnt_type);
> +				free(found->mnt_fsname);
> +				found->mnt_dir = xmemdupz(ment->mnt_dir, strlen(ment->mnt_dir));
> +				found->mnt_type = xmemdupz(ment->mnt_type, strlen(ment->mnt_type));
> +				found->mnt_fsname = xmemdupz(ment->mnt_fsname, strlen(ment->mnt_fsname));

Don't mix mem*() and str*(). In this case we need the string to be '\0'
delimited, so use xstrndup().

And once we do that, we might wonder why we're explicitly finding the
'\0', just to pass it to the xstrn*() function, when we can just do:

	found->mnt_dir = xstrdup(ment->mnt_dir);
	...

Which would AFAICT be equivalent to what you're doing here.

> +			}
> +		}
> +	}
> +	endmntent(fp);
> +
> +	return found;
> +}
> +
> +int fsmonitor__get_fs_info(const char *path, struct fs_info *fs_info)
> +{
> +	struct mntent *ment;

...make this (or above) a "struct mntent ment", then pass &ment down, so
we can fill that struct? Dunno...

> +	struct statvfs fs;
> +
> +	if (statvfs(path, &fs))
> +		return error_errno(_("statvfs('%s') failed"), path);
> +
> +	ment = find_mount(path, &fs);
> +	if (!ment)
> +		return -1;
> +
> +	trace_printf_key(&trace_fsmonitor,
> +			 "statvfs('%s') [flags 0x%08lx] '%s' '%s'",
> +			 path, fs.f_flag, ment->mnt_type, ment->mnt_fsname);
> +
> +	if (ME_REMOTE(ment->mnt_fsname, ment->mnt_type))
> +		fs_info->is_remote = 1;
> +	else
> +		fs_info->is_remote = 0;

Shorter:

	fs_info->is_remote = ME_REMOTE(ment->mnt_fsname, ment->mnt_type);
