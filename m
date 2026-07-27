Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B833CFF4C
	for <git@vger.kernel.org>; Mon, 27 Jul 2026 22:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785191065; cv=none; b=LqChTxHe47DVo5W3bJH8WpgodE2lkjT1w48Ef2iLSu5k3C8RasNYbFSAlOn96WX56RbT9KgkfIqHwjvI0yW7LdsewAOT+As/WKSOgmTSTm8WdoCqNuXKO/QxGro3hDm2l3yjXGJAle+Zs5yI0RX/ajKr987XlBbVjFZvwT4MC/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785191065; c=relaxed/simple;
	bh=3JMO820sKQcb2qQWkrB+u7AucXmfBlTUBSipkgkngoI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hFm7sJrjDaOt0vD1LYo1lWzUj24K0vCzghMXvsJ3QZHOSIg7k3nEVwBVgdgo0q2xRokBk+aLPP0DWFv+g31ccNKW7cgDVoplaiOR8GKCjX/XQNxeyjJIf6GQXzxu9HVPpsMt6qfgx0wZUEJA7/y89jJRRNzadgxzuzZx4rRpwKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=RWpXNpaP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eePgvq0U; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="RWpXNpaP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eePgvq0U"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 2413B1D0022F;
	Mon, 27 Jul 2026 18:24:23 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Mon, 27 Jul 2026 18:24:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1785191062; x=1785277462; bh=jI5llbB1kJ
	mFs9MsBae8b0qPLXa5DOoecAO+8nYFSUQ=; b=RWpXNpaP/6db4BSN0eVy/UIqDC
	8HKRV4Ci9nfb0OBVnpJDIgus/+13mYOXhWpUDyDUnf7hpQcOTkQ+N8MVy6fJnnxI
	iVp5ixPuXQAiboBfn3RHnvPlSRTqh2fwp1bEWAPbGwva+H47m7AeT3lMHqAcQJuQ
	2gSllVKSr2sCZRllyVxV6+gCI7X8jAbDyFMzXVn5xhREzos6M/18FIVSThlB6waq
	LH90L4Vx+ts5ysFG/DxsZbrlb3hRECclW5p66aa6jTfG2PuBWXJYnLjFvXnwbrZG
	tD4ZGbAfQQhS57MzPyjdogUnirlcfIbekkWdvb3YA8eBw7prcVcX6hjcUiYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1785191062; x=1785277462; bh=jI5llbB1kJmFs9MsBae8b0qPLXa5DOoecAO
	+8nYFSUQ=; b=eePgvq0Uia0tnARiG4G3SN/17BJAMWp6cxL6FxLsN6zO0rRsc54
	2r4AsOB9ioNeBj+taEJMKDiOpNHafmGpatrtylzFaqj0CITbt2eXsjtFzHu8QTnG
	c/niJbJY4BY/kJfvz0wND20hISLd9M3W5TWcBmO0kqENAqUYXuNZd67nzAyVRV6e
	TytSaA0epv7IpxUg0mD5iJHVm3FdnymjAfyeMnQZCPmCkM5xiGmCbigYBusGpay4
	7D+JBABgGrXgQ/mR2x9GFFIqhlJcsA1hB49JFxqAVynpPlgI8SNDZzwMEupAdN3y
	VM2k5ahWRx8y1YLoQ35U+LO4aSYlMv1iSSw==
X-ME-Sender: <xms:ltpnakZSmtm7DMI9DcU96PTGZ1WeKn9Mx59qoeXpQ3S4dPQlWLFo2Q>
    <xme:ltpnajEtmdAWSRKUDYj4HU7yZFG182DluXRNJcFHvUJCP32TqDaMA1rjCKdYbzoGI
    uVMc-CNXBgHK73EGg4c7q9j4A0izE7Ygennlyjxv_YthxVCPUkA>
X-ME-Received: <xmr:ltpnaoyewd-5t5Lc_vf4UR46zIl7H63zdPsACHXjN-_kCiBCq_h80BTgaCVatvO18HdFGU3AlhEe5nBUgrYjCh03X_Tb-8D25Q>
X-ME-Proxy-Cause: dmFkZTFoCGQ1/5Ha1pflzbs7Y6rFyM6PMx2BFu5HnK/9pdJChKd8AHZUKqq2pR2s/PZxe4
    YsnHazysg2PE+dKx2feQITEzAiDgiqygk9YHALRpJg0NKfPdO68ccBl8GPnXijxFTgqFu/
    uiBTpBosvFaOmdOv7lQ3fGqF+hdneo0gUiuPYiHx06rIo2neK+IfIAqrIPqCfK5Dh00Va1
    OkZTF2FK3koe7EjA4vi9GUZ+pd+eIwJFXrPoLfFUc7p05S46tVp7MtAj8j7R5zhaJo4O2N
    AP4lPHYdIOVZI+pmlAFr59xU++SoVhJFvmytxT5Nu/cM8bl3//EXVrxGhCaIK+kPBs2JqJ
    e8BiUqhc2lf4ySoI33ysshenCOGgHvdkkcEGEXf1WreHJAkhDbozBDvD9Ir5KMR3aZrijn
    x8K+SthD+XyRmmUgARSKEl5TJsC6uwjZxtdH5PPJnf8zCNHYkLbmhJ6EftKWRtYDp1VPg4
    /5+7Oq/lBpSSDdw2ZqykDMSu4wWgXs2te1VQggoAFKSdkudpfmcygqfjPrwckbkuJkrIh0
    FdQI8EKYGYdUTsz3wspDNJFBakt5i4qNdqWdVy87BA9+zDKxpY0A7xMnb0WPjZ3MI92BYQ
    h21ybeU9dksgk4EyCpqTdQW/jJnhj0wppoMiTXobVfqzWaApT+MPtiPN3WpA
X-ME-Proxy: <xmx:ltpnalm53679qC6Ji93dK-c_ROGUCXzWX_4U_PG4llcjFrwbS_FejQ>
    <xmx:ltpnahmwSejefDkgmDobCESEakEWX-VgAm567cd5bN_8VF-LG5FNmA>
    <xmx:ltpnanyP0q8cbwqpZsv6VFBQCihcsGv7Bv7V9gbm-A9cDkB-pmcgqg>
    <xmx:ltpnamr26OXbCXYpqZsBtFiYEI0FSV9fsfC4t50ycUNLSo_VODk0Jg>
    <xmx:ltpnaqo2U9dGwEAE20EBmdD8Ia2t8QrIYX6oLWSLD-P2ikPtKQqYGhOe>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Jul 2026 18:24:22 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Lucas Zamboni Orioli via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Ben Knoble <ben.knoble@gmail.com>,  Pablo Sabater
 <pabloosabaterr@gmail.com>,  Lucas Zamboni Orioli <lucaszam0@gmail.com>
Subject: Re: [PATCH v4 2/2] mv: reject a destination whose leading path is
 missing or a symlink
In-Reply-To: <6b72efb4130d96947c7f90026042fa09a440d091.1785097071.git.gitgitgadget@gmail.com>
	(Lucas Zamboni Orioli via GitGitGadget's message of "Sun, 26 Jul 2026
	20:17:51 +0000")
References: <pull.2356.v3.git.git.1784842831.gitgitgadget@gmail.com>
	<pull.2356.v4.git.git.1785097071.gitgitgadget@gmail.com>
	<6b72efb4130d96947c7f90026042fa09a440d091.1785097071.git.gitgitgadget@gmail.com>
Date: Mon, 27 Jul 2026 15:24:21 -0700
Message-ID: <xmqqbjbsgjfu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Lucas Zamboni Orioli via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Lucas Zamboni Orioli <lucaszam0@gmail.com>
>
> Moving a file into a destination whose leading directories are not all
> present, real directories is only diagnosed later at rename(2), and for
> a symlinked component is not diagnosed at all.

I cannot quite parse this.  Do you mean to say something like this?

    When moving a file, if any leading directory in the destination 
    path is missing or is not a real directory, the problem is detected 
    only later when rename() is called.  Furthermore, if a leading 
    directory component is a symbolic link, the issue is not detected 
    at all.

> Three cases reach rename(2) unchecked today:
>
>   - A leading directory is missing: rename(2) fails with ENOENT,
>     reported against the source (misleading), and "git mv -n" does not
>     detect it since the dry run never reaches the syscall.

OK.  With [PATCH 1/2] in place, this is an easy case for the user to
deal with.  Either the directory name was misspelled, or the user
forgot to create intermediate levels of the destination directory.

>   - A leading component is a non-directory ("git mv x a/b" with 'a' a
>     file): rename(2) fails with ENOTDIR, again only at the syscall.

True.  'x' cannot become 'a/b' as long as 'a' is a file sitting there.

>   - A leading component is a symbolic link: "git mv" follows it. Since
>     Git tracks symlinks, the destination is really occupied by a
>     tracked object, and following it is wrong regardless of the link
>     target. The move is done on disk at the resolved location while the
>     index records the literal path, leaving the index describing a
>     worktree that does not exist. A later "git add" can reconcile it,
>     but "git mv" alone has already corrupted the state.

Yeah, that is horrible.

> Detect all three in the checking phase. Reject a destination that goes
> through a symlink with has_symlink_leading_path(), which uses lstat()
> and never follows the link, so the refusal is independent of the
> target. Then lstat() the leading directory: report "destination
> directory does not exist" for ENOENT/ENOTDIR and "destination is not a
> directory" for a non-directory. Other errors fall through to rename().

> Guard the directory check with the same condition under which rename(2)
> runs, so directory moves and sparse/out-of-cone destinations are not
> flagged incorrectly.

Nice touch.

> This changes behavior: a move through a tracked symlink that previously
> "succeeded" while corrupting the index is now refused. The other two
> cases only change when the failure is diagnosed.

Nice bugfix.

> diff --git a/builtin/mv.c b/builtin/mv.c
> index 35e504484a..535599e6be 100644
> --- a/builtin/mv.c
> +++ b/builtin/mv.c
> @@ -22,6 +22,7 @@
>  #include "string-list.h"
>  #include "parse-options.h"
>  #include "read-cache-ll.h"
> +#include "symlinks.h"
>  
>  #include "setup.h"
>  #include "strvec.h"
> @@ -443,6 +444,40 @@ dir_check:
>  			bad = _("destination directory does not exist");
>  			goto act_on_entry;
>  		}
> +		if (has_symlink_leading_path(dst, strlen(dst))) {
> +			bad = _("destination is beyond a symbolic link");
> +			goto act_on_entry;
> +		}

With a proper helper, this part of the fix is surprisingly simple.

> +		/*
> +		 * If we are going to move SRC to DST on disk, DST's leading
> +		 * directories must already exist.
> +		 */
> +		if (!(modes[i] & (INDEX | SPARSE | SKIP_WORKTREE_DIR)) &&
> +		    !(dst_mode & (SKIP_WORKTREE_DIR | SPARSE))) {

This small piece of logic is a duplicate of the next block that
actually performs the move.  I wonder if we can have a small helper
function that takes mode and dst_mode as parameters and returns this
value?  Then this part would become:

		if (that_function(modes[i], dst_mode)) {

and the "real thing" would become

-		if (!(mode & (INDEX | SPARSE | SKIP_WORKTREE_DIR)) &&
-		    !(dst_mode & (SKIP_WORKTREE_DIR | SPARSE)) &&
+		if (that_function(mode, dst_mode) &&
		    rename(src, dst) < 0) {
			if (ignore_errors)
				continue;
			die_errno(_("renaming '%s' failed"), src);
		}

and we will never risk them drifting apart.  Naming is the tough
part, though.  I will leave it up to you and the list to come up
with a good name that fits the semantics of what that function
computes.

> +			char *dst_dir = xstrdup(dst);
> +			char *slash = strrchr(dst_dir, '/');

Are the elements of the destinations.v[] array normalized so that
they are all full final pathnames?  I mean, 'mv A B' when B is an
existing directory would succeed, remove A, and leave 'B/A' in the
resulting working tree.  If we can depend on the preprocessing code
and the element in destinations.v[] corresponding to the move is
'B/A' (and presumably the corresponding element in the sources.v[]
array would be 'A') in such a case, then stripping the final name
component and checking whether the remainder (that is, the dirname)
is a directory, as the code below does, sounds like the right
approach.

> +			if (slash) {
> +				struct stat dir_st;
> +
> +				*slash = '\0';
> +				if (lstat(dst_dir, &dir_st) < 0) {
> +					/*
> +					 * other errors fall through to rename(),
> +					 * which reports them
> +					 */
> +					if (errno == ENOENT || errno == ENOTDIR)
> +						bad = _("destination directory does not exist");
> +				} else if (!S_ISDIR(dir_st.st_mode)) {
> +					bad = _("destination is not a directory");
> +				}
> +			}
> +			free(dst_dir);

If you did this instead

			const char *slash_ = strrchr(dst, '/');
			if (stash_) {
				char *dst_dir = xstrdup(dst);
				char *slash = &dst_dir[slash_ - dst];

then you need to allocate only if you need a copy.  I do not know if
it matters, though.  What do we do to elements in destinations.v[]
that lacks a slash?

> +			if (bad)
> +				goto act_on_entry;
> +		}

Thanks.
