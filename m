Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDE4351C1C
	for <git@vger.kernel.org>; Thu, 30 Apr 2026 16:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777565927; cv=none; b=NMGerPkoDPS9KSe/HF8Q+28ZYHPHu8r4qnRs+AtHdxZG2ZSbtJpC63wr0CLPFrgGWqhkHVbNQatTKx1ZmqCVy77fXqL8ELxO0kXHRCQ5SxvbUcp0c5qnBAB9OSHhBkWTgLvn1C0ayds2DiB6AfgQ/nlzoaryejaeK3HlopHOeNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777565927; c=relaxed/simple;
	bh=4tEJCdf8RdJJRbY351ZbDptv72xsHEtXo7ewgMGxmF8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vn3lssbRkj3bJ5OgOnwUasY4PFV1x8F57u55qacKEqC6SIdmnGdFUUce8h0tSESPkug3okYIxkMko+v7j5HAZ45DUkbDgkf6yneElZ5C4FSZaxWGKAit8hu8xHavOMJBkzjTgjytRjPYMmxFOuiEd2q7HTMONQMz4gUSHJXc4zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j7Yf6DTB; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j7Yf6DTB"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8eb5ad01402so116802485a.2
        for <git@vger.kernel.org>; Thu, 30 Apr 2026 09:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777565923; x=1778170723; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CGFqBiMrcUQ+5CXPgGVYH02shNsYdfYJ2TmJzYQfkI8=;
        b=j7Yf6DTBrL4Fns4trlCDXaqbv0NL6EEA4bYQdrJ19bL6bssR8kHMUvGQg5BVHBbBuT
         tGAfm8fFkFWxFhp5R7YJ7srSSs+7mCcEC2rByjEyqQ80SwSvJcKccIljhRDrmSht1bOZ
         +AWeRjMDs0zvypzuIlRVt+mBruI6cTfUa/k6aSQ7G/X0G3T2G+jJmny9GCQr/zlKAEDP
         pns1yCaP4Y/uo9rX03QVQH0it1KtKpRR/LgFGzQiCNTbrVVlYE3wdoZntw4gIbVDx2CL
         w4DX9FN1gywe0bEXvDC2WuPH/M52wYB30JKsxHErG87wNs0NGGrSjkmJFHs8WRhNz1V7
         YuJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777565923; x=1778170723;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CGFqBiMrcUQ+5CXPgGVYH02shNsYdfYJ2TmJzYQfkI8=;
        b=iO/qwCIUMdPXLCu2ESkYd6BcsrwDHITjzmRp1ADO5g9jSGen44tgNZq8oXYOg89HBh
         aygynd8ph1jwJdohdpcEK7W4m4u7Wh7FaAnfBZmbFYdC8Elh+KFqcgr2UoCqemSiAI4X
         EOAxYnylCQha8PWJmuJ4171gQB9xHjAi2B0KOuVcf2Ndn4QtyWBpLxuUe32/g9GYjCsg
         GAjOW0ND4ctqgjhtIRppW86/VHhTOZspmZleMO1IjULTFw5bPFuuRdzCi3LrHWZZ3VGw
         hE3LRsQIXfW/7vIJlnmO3E02TTuMKQyizIp0TF7amzoz62aRxIib0nnbugX6JKskL+X+
         b/hw==
X-Forwarded-Encrypted: i=1; AFNElJ+zVUz7WFoEKqiMjuglb1BvM8iQxIywhEH5tOsJhpJV+7OB5tnlauiyJ+qqz0FfQlyq4as=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx30cz7OklhN6qOF0AZRv+9wRJW5o6qRd4ia66ElxUl8NGrBYd1
	ZbGHJP9WbaO1k2QW/GKVaJy8QfXLkAht9rOGjn03mfWoa7hKig4NrXxdVsHGpsx8
X-Gm-Gg: AeBDiettOETn7Jw9w8nPzcGqDSOkBMPM26YitB18j+Bx5K+N3xwvc+YtfR2StJYpjoV
	4K3ZNaL60F0DgZ2MTFw7XLFIZ5LU6mI2vkXParJz4kfa8SFvECVxJ/NIYp0GiFhp/TaDfseSFXQ
	JjU9SnYtVCCepTXyzcz1JtIk34Om9xn5GEulL2GD6BPLr+bF7SE/YEQoXrE13OF2gIajkXJBsGy
	xsg/NBhxBgjbkjPrkIBG6FaSIgDOTd611tcKUk5mfBOPvj/zDyjr2X6z9BqoOLM8RpsrTBQmKYm
	LT/3DfiAUekz/YtgqcCpmz7uSsZ9vqIc/NAlG2gGjX6a84rPaGunP7wJBHhLEORFRSXBZ5B0tck
	TF6Seh8LszFa1m3YeKI39FWdcD//DXDOJgDt9TsvycAskK7tB+VCTcMFxxPy5SaDgsnCpFAo8az
	6DeouK4AWwHMnM0oLip+9uAXFNpes4hnqZUe9UAmJFlV77
X-Received: by 2002:a05:620a:bc7:b0:8dc:5094:ea79 with SMTP id af79cd13be357-8fa88847307mr558878585a.39.1777565923178;
        Thu, 30 Apr 2026 09:18:43 -0700 (PDT)
Received: from ?IPV6:2600:4040:264b:4100::59a? ([2600:4040:264b:4100::59a])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fbb3d33744sm8762485a.34.2026.04.30.09.18.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2026 09:18:42 -0700 (PDT)
Message-ID: <3b0b37ed-1a5d-4fe1-b2b4-7db67a62a06d@gmail.com>
Date: Thu, 30 Apr 2026 12:18:42 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] git-gui: handle missing worktree and separated
 gitdir
To: Shroom Moo <egg_mushroomcow@foxmail.com>, git@vger.kernel.org
Cc: j6t@kdbg.org
References: <tencent_AEE968E8E785907BA55A383977C8968ED406@qq.com>
 <tencent_8A236D9D4A8D8CCA7DAA083157AA8543700A@qq.com>
Content-Language: en-US
From: Mark Levedahl <mlevedahl@gmail.com>
In-Reply-To: <tencent_8A236D9D4A8D8CCA7DAA083157AA8543700A@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 4/30/26 6:02 AM, Shroom Moo wrote:
> When git-gui is started from a directory that Git recognizes as a
> valid repository but the working tree is not accessible (e.g., a
> separated gitdir created by `git clone --separate-git-dir`, a bare
> repository, or a case where the worktree directory was removed),
> it previously called `rev-parse --show-toplevel` without error
> handling, causing a fatal Tcl error ("this operation must be run
> in a work tree").
>
> Wrap the call in a `catch` and handle the failure as follows:
>
> - For bare repositories, keep `_gitworktree` empty so that the
>   existing `is_bare` check shows "Cannot use bare repository" and
>   exits.  No behavioral change.
>
> - For non‑bare repositories, try to locate the worktree from the
>   parent directory using `git -C $parent rev-parse --show-toplevel`.
>   If the parent is a valid worktree, change to it; this covers the
>   legitimate case of starting git-gui from within the .git
>   subdirectory of a normal working tree.
>
> - If the parent directory is not a worktree, refuse to start with
>   a clear error message.  This prevents dangerous operations in a
>   separated gitdir, where ordinary Git commands like `git status`
>   would themselves refuse to run.
>
> The approach intentionally avoids two pitfalls:
>
>   - Testing `--is-inside-git-dir` before calling `--show-toplevel`
>     would break the normal use case of starting git-gui from within
>     a .git subdirectory (where --show-toplevel would succeed).
>
>   - A simple “non‑bare” check after a failed --show-toplevel would
>     reject a normal repository whose worktree was only temporarily
>     removed.
>
> The chosen method keeps the original behavior for bare repositories
> and for regular working trees, fixes the crash, and properly blocks
> separated gitdirs without a reachable worktree.
>
> Signed-off-by: Shroom Moo <egg_mushroomcow@foxmail.com>
> ---
>  git-gui/git-gui.sh | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
>
> diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
> index 23fe76e498..2392282df3 100755
> --- a/git-gui/git-gui.sh
> +++ b/git-gui/git-gui.sh
> @@ -1169,7 +1169,28 @@ if {![file isdirectory $_gitdir]} {
>  load_config 0
>  apply_config
>  
> -set _gitworktree [git rev-parse --show-toplevel]
> +if {[catch {set _gitworktree [git rev-parse --show-toplevel]}]} {
> +	# For bare repositories, use the existing error handling
> +	if {![catch {set bare [git rev-parse --is-bare-repository]}] && $bare eq {true}} {
> +		set _gitworktree {}
> +	} else {
> +		# Non-bare: try to find the worktree from the parent directory
> +		set parent [file dirname [pwd]]
> +		# Cannot go higher than the root directory; leave _gitworktree empty
> +		if {[file normalize $parent] eq [file normalize [pwd]]} {
> +			# Already at the filesystem root; let existing paths cope
> +			set _gitworktree {}
> +		} elseif {![catch {
> +			set _gitworktree [git -C $parent rev-parse --show-toplevel]
> +		}]} {
> +			cd $parent
> +		} else {
> +			catch {wm withdraw .}
> +			error_popup [mc "Cannot start git-gui from inside the Git directory."]
> +			exit 1
> +		}
> +	}
> +}
>  
>  if {$_prefix ne {}} {
>  	if {$_gitworktree eq {}} {

A bare repository can be contained in a workdir / worktree pointing at a different gitdir:
the logic above can thus a workdir that doesn't use the gitdir where git-gui was started.
The bigger issue is that a gitdir can support multiple checked-out directories with no
one-to-one mapping and no clear idea of which of those a user may have intended.

So, I believe the correct fix is to test "rev-parse --is-inside-git-dir, and if so throw a
clear error message and exit. This will give the user something to start with to solve the
problem of why they started git-gui in a gitdir, and not in a worktree.

Mark

