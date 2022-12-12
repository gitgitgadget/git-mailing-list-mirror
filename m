Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6381C4332F
	for <git@archiver.kernel.org>; Mon, 12 Dec 2022 10:46:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbiLLKqX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Dec 2022 05:46:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232215AbiLLKoT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2022 05:44:19 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D78E4EB6
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 02:40:20 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id u19so8327144ejm.8
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 02:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0nrdrR3B/l3H/RJO2PYD/Yg4rm7+5PvctZQb2kqd3PI=;
        b=IiJFgJe8MEAkNHrD/KYW7NABv2LpLTlhX3hhhe8hzmSb7EfQrJH6NNvvFYj29cDzcp
         iCs3J96qhoIzuv/KV8oTsQ9jWfbX0/+iVWXopDpO6NhHf26HdObdYDErVO+O9xg6bbsn
         XKZfRKvAAcA9VyIlQrJ/TQBz50SngErUFqTb919zPznyUCDodaQ1Jq9Ho4SO6/91aIaz
         9lk1xILgS2iL9ZSXr7ghgl1AHw3zrCko0eQIuTEEZqVIWprMtOaDXCB4dioAAgq6+4BT
         EobFo5mfBJQxushJiOzUNZnXCnp/e0avSwZd11fO4Bo2cx0H2jf4RFYWZojA7D42Wx0p
         cgYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0nrdrR3B/l3H/RJO2PYD/Yg4rm7+5PvctZQb2kqd3PI=;
        b=F9Q5NlgUKuDWpDxCIEBEZ7/PyArLOydnZzK5fLBfHvGNETSLsgqO087ZTGSVs9ONVN
         3C0v5dCAusNcUNuYlfNvfHXSadvW7y+DM+KCcV+MEEz3z8TxHYZZSA2+uNcI7fsuUCwD
         2cZgvIYmYhL1inxpEIJvke3U37D8QDd2eCUOBfmBumIThEiAU6EgXKDJdsIkCKFdeDYn
         eGyxyIhCSnnrPcgZfVZ1gbSVioPS+zwVug1I0WwiFcPi2HzpwHM1g3E3acgjYIkswfjO
         uQproOZvW78OXbPspWPROgzQ3NvHzxekk2WZ/hJWYMSJli/fqWY5OB0VH2YH1AAX1+v6
         ObuA==
X-Gm-Message-State: ANoB5pktNLvy2xVNcwgglNbmjgUyBMZ7HV4b5zD5Mf+/dXcWkWRj+TLE
        lgpTWFL+YOAB3nr0pyTvCLI=
X-Google-Smtp-Source: AA0mqf41QpvDGpq0eGzXVKxXFk47/zzmzZ9oX542hLD1ngOtKDJU3ExsL/aUNZheQ2sT3JObqRblIA==
X-Received: by 2002:a17:907:1719:b0:7c0:f9ef:23a2 with SMTP id le25-20020a170907171900b007c0f9ef23a2mr19897074ejc.30.1670841619227;
        Mon, 12 Dec 2022 02:40:19 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id h1-20020a50ed81000000b00458dc7e8ecasm3698706edr.72.2022.12.12.02.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 02:40:18 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p4gEM-005Hho-0Q;
        Mon, 12 Dec 2022 11:40:18 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric DeCosta via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Glen Choo <chooglen@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Taylor Blau <me@ttaylorr.com>,
        Eric DeCosta <edecosta@mathworks.com>
Subject: Re: [PATCH v4 2/6] fsmonitor: determine if filesystem is local or
 remote
Date:   Mon, 12 Dec 2022 11:24:27 +0100
References: <pull.1352.v3.git.git.1668641019.gitgitgadget@gmail.com>
 <pull.1352.v4.git.git.1669230044.gitgitgadget@gmail.com>
 <e53fc07754094aa5ba8080ec7761869c6429a8af.1669230044.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <e53fc07754094aa5ba8080ec7761869c6429a8af.1669230044.git.gitgitgadget@gmail.com>
Message-ID: <221212.86lenc6h2l.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Nov 23 2022, Eric DeCosta via GitGitGadget wrote:

> From: Eric DeCosta <edecosta@mathworks.com>
>
> Compare the given path to the mounted filesystems. Find the mount that is
> the longest prefix of the path (if any) and determine if that mount is on a
> local or remote filesystem.
>
> Signed-off-by: Eric DeCosta <edecosta@mathworks.com>
> ---
>  compat/fsmonitor/fsm-path-utils-linux.c | 186 ++++++++++++++++++++++++
>  1 file changed, 186 insertions(+)
>  create mode 100644 compat/fsmonitor/fsm-path-utils-linux.c
>
> diff --git a/compat/fsmonitor/fsm-path-utils-linux.c b/compat/fsmonitor/fsm-path-utils-linux.c
> new file mode 100644
> index 00000000000..d3281422ebc
> --- /dev/null
> +++ b/compat/fsmonitor/fsm-path-utils-linux.c
> @@ -0,0 +1,186 @@
> +#include "fsmonitor.h"
> +#include "fsmonitor-path-utils.h"
> +#include <errno.h>
> +#include <mntent.h>
> +#include <sys/mount.h>
> +#include <sys/vfs.h>
> +#include <sys/statvfs.h>
> +
> +static int is_remote_fs(const char* path) {
> +	struct statfs fs;
> +
> +	if (statfs(path, &fs)) {
> +		error_errno(_("statfs('%s') failed"), path);
> +		return -1;
> +	}

Nit: Drop the braces and do:

	if (statfs(...) == -1)
		return error_errno(...)

> +	switch (fs.f_type) {
> +		case 0x61636673:  /* ACFS */
> +		case 0x5346414F:  /* AFS */
> +		case 0x00C36400:  /* CEPH */
> +		case 0xFF534D42:  /* CIFS */
> +		case 0x73757245:  /* CODA */
> +		case 0x19830326:  /* FHGFS */
> +		case 0x1161970:   /* GFS */
> +		case 0x47504653:  /* GPFS */
> +		case 0x013111A8:  /* IBRIX */
> +		case 0x6B414653:  /* KAFS */
> +		case 0x0BD00BD0:  /* LUSTRE */
> +		case 0x564C:      /* NCP */
> +		case 0x6969:      /* NFS */
> +		case 0x6E667364:  /* NFSD */
> +		case 0x7461636f:  /* OCFS2 */
> +		case 0xAAD7AAEA:  /* PANFS */
> +		case 0x517B:      /* SMB */
> +		case 0xBEEFDEAD:  /* SNFS */
> +		case 0xFE534D42:  /* SMB2 */
> +		case 0xBACBACBC:  /* VMHGFS */
> +		case 0xA501FCF5:  /* VXFS */

So, before we'd compare against the name, but to avoid the GPLv3
copy/pasting we're now comparing against the fs.f_type.

If we are hardcoding them, our usual convention is to lower-case
hexdigits, so 0xbacbacbc not 0xBACBACBC.

But at least my statfs() manpage documents the named defines in
linux/magic.h for most of these. Why not use those?

> +			return 1;
> +		default:
> +			break;

You could just "return 0" here, and...

> +	}
> +
> +	return 0;

...drop this "return 0".

> +}
> +
> +static int find_mount(const char *path, const struct statvfs *fs,
> +	struct mntent *ent)

Misindentation.

> +{
> +	const char *const mounts = "/proc/mounts";
> +	const char *rp = real_pathdup(path, 1);
> +	struct mntent *ment = NULL;
> +	struct statvfs mntfs;
> +	FILE *fp;
> +	int found = 0;
> +	int dlen, plen, flen = 0;
> +
> +	ent->mnt_fsname = NULL;
> +	ent->mnt_dir = NULL;
> +	ent->mnt_type = NULL;
> +
> +	fp = setmntent(mounts, "r");
> +	if (!fp) {
> +		error_errno(_("setmntent('%s') failed"), mounts);
> +		return -1;

Ditto "return error_errno()"


> +	}
> +
> +	plen = strlen(rp);

Let's make "plen", "dlen" and "flen" a "size_t", not "int"
> +
> +	/* read all the mount information and compare to path */
> +	while ((ment = getmntent(fp)) != NULL) {

Drop the "!= NULL"

> +		if (statvfs(ment->mnt_dir, &mntfs)) {
> +			switch (errno) {
> +			case EPERM:
> +			case ESRCH:
> +			case EACCES:
> +				continue;
> +			default:
> +				error_errno(_("statvfs('%s') failed"), ment->mnt_dir);
> +				endmntent(fp);

Shouldn't we check the endmntent() error too? Now, from the manpage the
interface is funny, and always returns 1.

But since this is linux-specific code it seems safe enough to go with it
& glibc assumptions and:

	errno = 0;
        endmntent(fp);
        if (errno)
        	return error_errno(....);

I.e. it'll just call fclose(), which might set errno() on failure.

Maybe it's not worth it...

> +	if (statvfs(path, &fs))
> +		return error_errno(_("statvfs('%s') failed"), path);

Here you do use that "return error_errno(...)" pattern...", yay!


> +
> +
> +	if (find_mount(path, &fs, &ment) < 0) {
> +		free(ment.mnt_fsname);
> +		free(ment.mnt_dir);
> +		free(ment.mnt_type);
> +		return -1;
> +	}
> +
> +	trace_printf_key(&trace_fsmonitor,
> +			 "statvfs('%s') [flags 0x%08lx] '%s' '%s'",
> +			 path, fs.f_flag, ment.mnt_type, ment.mnt_fsname);
> +
> +	fs_info->is_remote = is_remote_fs(ment.mnt_dir);
> +	fs_info->typename = ment.mnt_fsname;
> +	free(ment.mnt_dir);
> +	free(ment.mnt_type);

If you're going to \n\n-seperate this and the trace_printf_key() above I
think moving the second free() here to that "block" would make sense,
sinec here is the last time we use mnt_dir, but the last time we used
mnt_type was in the trace_printf_key().

But...

> +
> +	if (fs_info->is_remote < 0) {
> +		free(ment.mnt_fsname);

...aren't you NULL init-ing these, why not just for all of these:

	goto error;

Then....
> +		return -1;
> +	}
> +
> +	trace_printf_key(&trace_fsmonitor,
> +				"'%s' is_remote: %d",
> +				path, fs_info->is_remote);
> +
> +	return 0;

Have this be:

	int ret = -1; /* earlier */

	ret = 0;
cleanup:
	free(...);
	free(...);
	return ret;

> +}
> +
> +int fsmonitor__is_fs_remote(const char *path)
> +{
> +	struct fs_info fs;
> +
> +	if (fsmonitor__get_fs_info(path, &fs))
> +		return -1;
> +
> +	free(fs.typename);

This will segfault if you take the part through fsmonitor__get_fs_info()
where we don't have the fs.typename yet, i.e. if statfs() fails.

There's the trivial NULL-init way to work around it, but I think this
suggests a leaky abstraction. If we fail to get the fs info, then the
function itself should have free'd that, shouldn't it?

> +/*
> + * No-op for now.
> + */
> +char *fsmonitor__resolve_alias(const char *path,
> +	const struct alias_info *info)

Ditto misindentatione
