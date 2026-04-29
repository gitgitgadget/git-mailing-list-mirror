Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E302F290A
	for <git@vger.kernel.org>; Wed, 29 Apr 2026 20:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777493653; cv=none; b=oCp3cTZNcdzgzmKgtjrdxWj4eVwHaANPdeDAYF/1W/16/pyuBrvnM6PzQCXS+eYLht6eydUnNV44Yng2FC3kE90pf56BbPxc0pyQYooCyWfZMh/cU6/MWhZWmV0r3m7/nS7sDsLEWy4VcEfAEuhjKY+0WkvG7cBIr7oP8uFy+0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777493653; c=relaxed/simple;
	bh=Np23F9laI9qIpxnHWI+heRPHHfyMthSHs8quv9EYJQA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nrfTHoe+fNT6F20n9MV2ELPDirHON6L6GCn/JF4+6rkWVeAoTAiIB4XXNaWlmUp3RommfFoWFkhc3M16iD5cdKM1vVPhnMmHNc/x5Oz3bl47lQzDr5D0/2uWCFlyHPw+h9D0ybrlweEgoKPubZX1KpPo/Ny+D0exQ6lgBbj3OuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nrzi/xWJ; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nrzi/xWJ"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8ef0ba61d46so18388685a.2
        for <git@vger.kernel.org>; Wed, 29 Apr 2026 13:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777493651; x=1778098451; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rJhM+6ybyXGbxAnFTeiarX7seI+YFXrDIhsrnABK9xc=;
        b=Nrzi/xWJnF35eGSpJmw+KhEeewzwycWLndjWDf/guWyCBPKpumWe80pMsA0WAkhrlo
         GIaThuOSwbCLjGSF5S7sovEwSwa5LasAwfuHXEOq6PCk8VTIzZR8e98RiT74nJ5yLbgC
         jEB/CLUH2qsSjQ+4OhjF4LSdLMjkUNFdt7ipV3AcuAaCbDsxyNDg9imfnXnZl1bQpy/s
         cqvkMr/i0qLjR2n7ak12gUY6pcr3tLdcCZfHSK5R9nrkXHsIGuDv/rVdR3EHtFB+qY5t
         cnFBMX9+gtrttr28a1goRA4B+Pq9vzGoYouIIb+tgbPxZFy3s1oifZi1e9SH4QX2Vokd
         BKrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777493651; x=1778098451;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rJhM+6ybyXGbxAnFTeiarX7seI+YFXrDIhsrnABK9xc=;
        b=YJ2QaJmP4g+FiNQvO0dxnFki33nYuNpwBOeqSRdYrkoGo8axizgyRTMQq1pJXgMJmo
         c3YthFocseesrhSnowq/fl+kY2SGaD0s9snoKQJu8yVG0MpFAf4EZo/Ri0IrVMeSdl/c
         TGUhJWJ7bqYXJM/VMARIui39cqF+JP8SyQnGweXZMDEP8ELr/8MZ/ARc3gQ39oRCANUn
         6UaB0oD2/lDIOtg/sQXt5Aeui8tZorXdNrM0mryJZNkh4fVqdJpAAa3u2f/U5cP6rrTm
         a1lRe68VCfUQaX45ziP9U9RInw0LsXmS1G7KJ+EQCw7RUN+Yo6P+S55gF5q3MrZF4TKE
         SHQQ==
X-Forwarded-Encrypted: i=1; AFNElJ95BEo6Fy2RscHHZMnOR/CJ6hgAingil1nFQvwdtkJxTsBBaZz5ITI40LvkfbL4AZ3iA1c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa4CvUi/MN9qSg8f0+eFZgFdvsHyWQ8BXEnqLGUqL3IowBBtm7
	uAddlzBSjOJomB8vhNDfkT1Co7H+WuKNj5bJ8j2/oke6clFCLzlzC4LlwPDfNxq4
X-Gm-Gg: AeBDiesZBclwxpd/d8iLbJoeF16aW1pkanC969qihE3rgtvk7706hzt6F5gC/3xaKzC
	8YsPuB4Xjp9aHIlxxp4nHTc9AFmSUn77zv1fqJH4ctfDDipTNM9ODMFGlP72KE47Dh2TEK1AQW7
	/Y7DF8yQJAdSmRmzsB6k+/TT1m8lYdXiwTZ5iaD7HgQ1vwC/Mu0tCWlFZWesSyx2THvK1Jmbne+
	IVGFZCX/FGpLMSe44Mcrjsf1GftOR6NARJLG4f0Ew608/H5VIDbaOKxBzW/vlHOviA4mkR8rbH7
	1zfr9W+xfxa8+jpnOSeSR/9Ctx3q7AALBsU1jGWAd5sk/oLyumyWWtJGcAjG81pByen9gmWx3j0
	zGA/bEJg4qqDR48OzicqTLOus/+aqiH/EWCzkbNpQUYcBK5hWWro/ih4O9qDYEq2PWi9Itx885b
	QLD0pXvTa03rCYdgzZy3K3xf28vusmT0zCjONn0T7FVD0E
X-Received: by 2002:a05:620a:1710:b0:8ca:fe5c:ea6d with SMTP id af79cd13be357-8fa8a5b7d96mr37420085a.59.1777493647934;
        Wed, 29 Apr 2026 13:14:07 -0700 (PDT)
Received: from ?IPV6:2600:4040:264b:4100::59a? ([2600:4040:264b:4100::59a])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8f93ccff7e3sm269137185a.12.2026.04.29.13.14.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2026 13:14:07 -0700 (PDT)
Message-ID: <0100848a-d408-49f0-aeb1-8835c8775539@gmail.com>
Date: Wed, 29 Apr 2026 16:14:06 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] git-gui: protect rev-parse --show-toplevel call
To: Shroom Moo <egg_mushroomcow@foxmail.com>, git@vger.kernel.org
Cc: j6t@kdbg.org
References: <308229f2-0d20-4f3b-8e6a-c962bd9c3a6e@kdbg.org>
 <tencent_AEE968E8E785907BA55A383977C8968ED406@qq.com>
Content-Language: en-US
From: Mark Levedahl <mlevedahl@gmail.com>
In-Reply-To: <tencent_AEE968E8E785907BA55A383977C8968ED406@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/29/26 1:32 PM, Shroom Moo wrote:
> When starting git-gui from a directory that is a bare repository or
> where the working tree is missing, git-gui previously executed
> 'rev-parse --show-toplevel' without error handling. This caused a
> fatal Tcl error ("this operation must be run in a work tree").
> 
> Wrap the call in a catch to prevent the fatal error. The existing
> error paths after this call already handle bare repos and missing
> worktrees appropriately.
> 
> Signed-off-by: Shroom Moo <egg_mushroomcow@foxmail.com>
> ---
>  git-gui/git-gui.sh | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
> index 23fe76e498..aee37685e1 100755
> --- a/git-gui/git-gui.sh
> +++ b/git-gui/git-gui.sh
> @@ -1169,7 +1169,9 @@ if {![file isdirectory $_gitdir]} {
>  load_config 0
>  apply_config
>  
> -set _gitworktree [git rev-parse --show-toplevel]
> +if {[catch {set _gitworktree [git rev-parse --show-toplevel]}]} {
> +    set _gitworktree {}
> +}
>  
>  if {$_prefix ne {}} {
>  	if {$_gitworktree eq {}} {

Unfortunately, this allows starting git-gui inside the separate gitdir created by

	git clone --separate-git-dir=/some/where/else ...

There is no hint where the workdir is, but git recognizes the repository is not bare:

	git rev-parse --is-bare-repository  ==> false
	git rev-parse --is-inside-git-dir   ==> true
	git rev-parse --is-inside-work-tree ==> false
	git rev-parse --show-toplevel       ==> fatal: must be run in a work tree
	git worktree list                   ==> absolute path to gitdir (not a worktree)

As git-gui has no protection against modifying what is effectively a bare repository,
allowing git-gui to run in this directory is dangerous, or possibly just very confusing.

git refuses to work in this gitdir: "git status" run in the above gitdir gives: "fatal:
this operation must be run in a work tree."

The simplest safe thing is to catch the error and abort with a more useful message than
currently provided. Or perhaps, check git rev-parse --is-inside-git-dir and abort, and do
so before trying --show-toplevel.


Mark

