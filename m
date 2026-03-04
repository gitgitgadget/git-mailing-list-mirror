Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685A4309DB5
	for <git@vger.kernel.org>; Wed,  4 Mar 2026 07:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772610193; cv=none; b=sGIftdF4iUXsHkuZZw4oYw24aYYphXNN8eBqYDDLEcQ2TDvp/c/uXPhm6xfYd8GDszjj32e3915a2dEy53tukw0xSWlUq2ndM+GcPdP3G+Ywi/jRx1cgSBI33gJzy91o/HHidhB8BoTNDyDWuzkjMChrcUXR+pIRA1URSVvmeQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772610193; c=relaxed/simple;
	bh=jjsULvRz3pnnrgMQA511mVKOvmzKI1SjGUfeyPyoCgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X6+tePMMI1qfC+8kPYKU4ON4vUxmbk9wby9Xk0MLmO1SO96tBaLQnFzrxJXLL/ztDUAxIQigqsOi8cDjOpfmslEBv5D1KLKogn6nyTw96wwAeP33umwyJBqIZMTDLpVIgFB6svfuTRBG328xKMRoXSjfzsLwBaSthIbzzCxksuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=k+/gkwHo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DrYLXDzy; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="k+/gkwHo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DrYLXDzy"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id B1244EC00C3;
	Wed,  4 Mar 2026 02:43:11 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 04 Mar 2026 02:43:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1772610191; x=1772696591; bh=zQnpAwgDnP
	OdSWOTG6NEGNVcBT3NvX6I71W+R/eq8DM=; b=k+/gkwHo7k8dEsx+D2Q1mgnKmr
	UKGFCPoPI/qgwrDUVresq+VzZpWYkXERTNtiBI2bzZ0pYXhqvk2T8shbLlKsl0Ti
	M1B//Pgg0Ov3Lv1G6irddl8cjqIlZEvKG8X1bF5VJeVaTCqEpRTK6rt5X7jQjw0t
	uHjekwzfhUfCI9xZ9GoSxRj6LaFdacwy7yasIaWwov1syJZ94gTxCzU3LF8aNJA0
	GJSCTVChx17hU6nuaP+pnOwbvY4lfrjU2RqswRSKceMOZCgvtB7Ijk/Zws95W68p
	rk/yEbhDDTFykWInXq9Vxn//raQD1OYAsqeWmvT11YNW9jKnPvz6kEPLgYyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772610191; x=1772696591; bh=zQnpAwgDnPOdSWOTG6NEGNVcBT3NvX6I71W
	+R/eq8DM=; b=DrYLXDzyVJOK4JT1Sv6oA3+IBB3cSBYF0mpbsZforBCHOTIUCmp
	dGOHp53lvK1GOlIhYRHZStYf8613yXFVjuOITSfLuEPIavf0hUmndE5HcG7LFlip
	3DJG/5YhB5dLr+fv8whTyegGr2Hl4hGf18Va8CjfHeJCVacM0ah6bQCftjIhwlYV
	zaUzOF+xm7NgPRmEg47DMDwL7pdU85e5E6z/AiyXMyJqvknLQXluT9np0a4V7Bca
	E3Rqktw7WKyQzbN34M/ok4rtj7ulWFLaiNUUCRld+s058sr4xPN7GMDdBNflF4Z2
	SNjo5oIFfSu87UEBeSspwrddJ+v5Pf0txyQ==
X-ME-Sender: <xms:j-KnaaDTvxORN-oLCbG7iZn0Ml08jwj4ALUVLpvrabTZjuyoYZBjcA>
    <xme:j-Knab_SIEqjb4rEkoltVn4sw60edS1LxPexGztFhbuH2CmY4MTWtbLGfZhmYt--4
    5UHM11-ZSFurYJ5Jn8WBgp7dqslYRu-69bNBJoGNJLJ9ky5ZiHY7A>
X-ME-Received: <xmr:j-Knaa9d4ytmJ3eYVpbn8BdsovGcBwFitT-TUQGLxPqLpf8A4J8g-s7rNoMUATu82vw6-1pIJqpr0oMBYTrkNOekxGrTnKpket266y-2fwcM6A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddviedvleduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtghhith
    hgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhthhhusgesphgruhhl
    ihhsrghgvggvkhdrtghomh
X-ME-Proxy: <xmx:j-KnaSehGP5zFvF-M2P6Oll3hSbA66XY1dRQCrfE_PXsjcPsK3d_EA>
    <xmx:j-KnaTEjmx10CHu9IZg20arV3a4IaWoK7m1akMAT5229LRmob9JzcA>
    <xmx:j-KnaQeDafbuvvkCNogvt9iPJuNPrHG1whlXb4AFX9NCnT8gEEBifA>
    <xmx:j-KnadEd7ACswyzOIw4f_H_Uo_Vykh3gseGwdBgqYb0gtdqqsqyj5w>
    <xmx:j-Knaab5O5zRlFlz6_vVLNQYIFjX5Bi4V9ZgYgvRTCYj-kZ7yQ1sorYn>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Mar 2026 02:43:10 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f08d0831 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 4 Mar 2026 07:43:10 +0000 (UTC)
Date: Wed, 4 Mar 2026 08:43:07 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Paul Tarjan via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Paul Tarjan <github@paulisageek.com>
Subject: Re: [PATCH v7 07/10] fsmonitor: implement filesystem change listener
 for Linux
Message-ID: <aafii97SoHS96rkA@pks.im>
References: <pull.2147.v6.git.git.1772050636.gitgitgadget@gmail.com>
 <pull.2147.v7.git.git.1772065643.gitgitgadget@gmail.com>
 <adac7964cce28d237ef09574858be240fe3269fc.1772065643.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adac7964cce28d237ef09574858be240fe3269fc.1772065643.git.gitgitgadget@gmail.com>

On Thu, Feb 26, 2026 at 12:27:20AM +0000, Paul Tarjan via GitGitGadget wrote:
> From: Paul Tarjan <github@paulisageek.com>
> 
> Implement the built-in fsmonitor daemon for Linux using the inotify
> API, bringing it to feature parity with the existing Windows and macOS
> implementations.
> 
> The implementation uses inotify rather than fanotify because fanotify
> requires either CAP_SYS_ADMIN or CAP_PERFMON capabilities, making it
> unsuitable for an unprivileged user-space daemon.  While inotify has
> the limitation of requiring a separate watch on every directory (unlike
> macOS's FSEvents, which can monitor an entire directory tree with a
> single watch), it operates without elevated privileges and provides
> the per-file event granularity needed for fsmonitor.

Thanks for adding this explanation, makes sense.

> diff --git a/compat/fsmonitor/fsm-path-utils-linux.c b/compat/fsmonitor/fsm-path-utils-linux.c
> new file mode 100644
> index 0000000000..b4c19e0655
> --- /dev/null
> +++ b/compat/fsmonitor/fsm-path-utils-linux.c
> @@ -0,0 +1,220 @@
> +#include "git-compat-util.h"
> +#include "fsmonitor-ll.h"
> +#include "fsmonitor-path-utils.h"
> +#include "gettext.h"
> +#include "trace.h"
> +
> +#include <sys/statfs.h>
> +
> +#ifdef HAVE_LINUX_MAGIC_H

I saw that this define is only wired up for CMake. I guess we should
also add it to our Makefile (probably via config.mak.uname) and Meson
(probably via compiler.has_header()).

[snip]
> +/*
> + * Get the filesystem type name for logging purposes.
> + */
> +static const char *get_fs_typename(unsigned long f_type)
> +{
> +	switch (f_type) {
> +	case CIFS_SUPER_MAGIC:
> +		return "cifs";
> +	case SMB_SUPER_MAGIC:
> +		return "smb";
> +	case SMB2_SUPER_MAGIC:
> +		return "smb2";
> +	case NFS_SUPER_MAGIC:
> +		return "nfs";
> +	case AFS_SUPER_MAGIC:
> +		return "afs";
> +	case CODA_SUPER_MAGIC:
> +		return "coda";
> +	case V9FS_MAGIC:
> +		return "9p";
> +	case FUSE_SUPER_MAGIC:
> +		return "fuse";
> +	default:
> +		return "unknown";
> +	}
> +}

This selection looks rather interesting to me. Why wouldn't we include
common filesystems like ext4 and the like? Certainly hints that the
function needs better documentation, and potentially a better name.

> +/*
> + * Find the mount point for a given path by reading /proc/mounts.
> + * Returns the filesystem type for the longest matching mount point.
> + */
> +static char *find_mount(const char *path, struct statfs *fs)
> +{
> +	FILE *fp;
> +	struct strbuf line = STRBUF_INIT;
> +	struct strbuf match = STRBUF_INIT;
> +	struct strbuf fstype = STRBUF_INIT;
> +	char *result = NULL;
> +	struct statfs path_fs;
> +
> +	if (statfs(path, &path_fs) < 0)
> +		return NULL;
> +
> +	fp = fopen("/proc/mounts", "r");
> +	if (!fp)
> +		return NULL;
> +
> +	while (strbuf_getline(&line, fp) != EOF) {
> +		char *fields[6];
> +		char *p = line.buf;
> +		int i;
> +
> +		/* Parse mount entry: device mountpoint fstype options dump pass */
> +		for (i = 0; i < 6 && p; i++) {
> +			fields[i] = p;
> +			p = strchr(p, ' ');
> +			if (p)
> +				*p++ = '\0';
> +		}
> +
> +		if (i >= 3) {
> +			const char *mountpoint = fields[1];
> +			const char *type = fields[2];
> +			struct statfs mount_fs;
> +
> +			/* Check if this mount point is a prefix of our path */
> +			if (starts_with(path, mountpoint) &&
> +			    (path[strlen(mountpoint)] == '/' ||
> +			     path[strlen(mountpoint)] == '\0')) {
> +				/* Check if filesystem ID matches */
> +				if (statfs(mountpoint, &mount_fs) == 0 &&
> +				    !memcmp(&mount_fs.f_fsid, &path_fs.f_fsid,
> +					    sizeof(mount_fs.f_fsid))) {
> +					/* Keep the longest matching mount point */
> +					if (strlen(mountpoint) > match.len) {
> +						strbuf_reset(&match);
> +						strbuf_addstr(&match, mountpoint);
> +						strbuf_reset(&fstype);
> +						strbuf_addstr(&fstype, type);
> +						*fs = mount_fs;
> +					}
> +				}
> +			}
> +		}
> +	}
> +
> +	fclose(fp);
> +	strbuf_release(&line);
> +	strbuf_release(&match);
> +
> +	if (fstype.len)
> +		result = strbuf_detach(&fstype, NULL);
> +	else
> +		strbuf_release(&fstype);
> +
> +	return result;
> +}

Sorry, but I still don't quite understand what we're doing here. Isn't
the longest matching mount point always the one that statfs(3p) gave us?
Why do we have to scan "/proc/mounts"?

Patrick
