Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD0F53A8A3
	for <git@vger.kernel.org>; Wed, 23 Sep 2026 19:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790190671; cv=none; b=CN6RJgqupcZzjQqNxT/tEqdkSM0wDQdGJgI+oSfhlpjP2SzJN7pb8ycVkkRDi3NQQewargyRvG5h9U8tgxQO9VWOKZIe4/NARym/dar7bi1q+0AH/kC2Q2hfvXD4EJV0yX0H53sz8x3icazJAcCez1BeZlIPNZYQo2mi407wt/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790190671; c=relaxed/simple;
	bh=XwQQDfTUmzf7oVVreCIzqhj6628idkXrk7MmSuffZh4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Y4AgwyG44y35YoRC2I/6iJxM8vQDwQm8VMlUbg92bX6Rhb8Ld7ZanUCQUW2JFUQ6sATiCVDdFOlP+NdrHbcATSJ6fcRDph/2Wgm8ccDQep7HGAz81e+1qhA7q98IqaFPDBhvrInkVvovi7SAVVaKu4zG5Es1WOywqs/oATSwTTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bfEQ3fR3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ro02L3jz; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bfEQ3fR3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ro02L3jz"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id E378EEC009C;
	Wed, 23 Sep 2026 15:11:08 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Wed, 23 Sep 2026 15:11:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790190668; x=1790277068; bh=ytHqujYZyO
	kUiHx8v6DeqsfnPkqRwrbuvbnXMJYvpJw=; b=bfEQ3fR3vTvUcbnYh5dpjsMgCa
	YaUVoMIburN4FrPyEij+PzpAOBGnBwH1OGqxWwJd0PvZZzpOyYPFN2aRqYQx85Xm
	Yql1oaycThN6ZTQm9ikMiLFTNmAzCE3aXTAOJFwcXqkK0Uxw764QmcA1nIvyvjY8
	lJRen8+kHXSsBxV5/a2kg0AMfrOu3zTwcEnXju87FBGzGTLT0SRu03TuQClpVTKY
	1uZ5wFQ2OrQ74uagPeXyQp+8Ipj9y+XwoWoX+/l0OXgIrhOucJu0V7Wxf+OaFb0A
	eZUTWeHRLVStWXxdvKtm52KwN4ovstuPd15EUDiTnLMdgAGm6p3Rp1Dq7zhA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790190668; x=1790277068; bh=ytHqujYZyOkUiHx8v6DeqsfnPkqRwrbuvbn
	XMJYvpJw=; b=ro02L3jzbp//whOH1N3Zhcpw906EI55N6LPuyZStqJMb8Bpn3pD
	mWSMf97AN1/OyPHcS/uw6J4bHzEkhhwdpNNtLlglyBeXaER5BkhTzWdPF4VGTpQm
	AtfkugiifPEjyT8WGEmxhCxcFj6HCNLHc2wSb5Nc+mluu5iXfvesAar+oFOBXTdO
	kzuXAeddyZJ/7zFp3Zgn69uxvDFqMABcIVCfZkeVKA+9jgDwXrc103ZwF4h+UT2s
	PKio7egF/NeHP8u7p/RlxomEx1meZFgOfitiJbC20ANFWVrD2yWI/M1RKItqICZt
	0TI8NPYPwxl81jEJsS3iWzRj2wQk4FhgBaw==
X-ME-Sender: <xms:TCS0argFtYwn_0lEiKfKZ8to8gfTLKCey_PaIrbydLiwDZ9w0SfJ3A>
    <xme:TCS0avB_BcU89obxbuCy34I5PfRTcF_T_d1Er8rcFU3q7s6q3JRdm8OVsLBczE6fV
    wLkTXmJiFzh3sOIIc1VnNmkLz-q7Ilo1G4UaqHKO0gf_KOqw4F9bAk>
X-ME-Received: <xmr:TCS0agEnc1NH_2mcy9USOD-_BEL9bsYiUKbPx94IZ-fq4QOsT1Nerp8q2POMR8tzRCWWTJT39JTLNiem1jSjGmuH-CPicLLWk6CZ>
X-ME-Proxy-Cause: dmFkZTFCZnPdwABz+w1E5n7/5But+oLxi3iTUM3i7DDbspFBTogpDNhpTkPwoRqGd2gbK3
    eP8nmpEypIdRgQklQXfgmzX6qF//zC9B8Tfg6zPbo0H64suL8dNWBDXN2in8pr5bX2QLq9
    Dd9sMI1XkBvLiJTp+RgeAelvKvcKEW2WR4eHRl9GiiVNGMHNu4gPxRDs2W9U3DSug8tMN3
    J4fLOT/SVfEufjWmRnu5pVA0pixafBwkRmAd+7BZLpXn35ZU35LijShUpubiiHnTmliuIV
    p5LrTUvQvlg9Z7KE6giFVejiueRzWeJALaD8OwJPDgyA7GxfojoPPR55oBU99C9ebY+4tW
    gTZ8DdoX9ybmWy6LdZ+cR5fzmwj8ljJFRs76pICuJAXmQx4v8vGuoLXtLvMiZhUArzUfAR
    lbE/XDR0ZX8shHWADJfVbsbSBZvsbWLam4A1QTIIRW5xqRl48/YaKa0BDh+gXLNQaPobeN
    ZQ4YY0teX31jRt55yZrS33NPVX7Kvly9NK7vj5fsIzy1vFKDFE4ynRvbpO+DwjZWAHngbO
    dlgn/nqO66wv4rX3H5iGytkev3B808iDTIrJUvCStyKYRkbACCQbmNummAw3LoB949ksY3
    XeGw8fULAsAl8ewWqjrGkCSPBHjFkyZoAUPilCrAjVw32WkU66+IRBQAMzgQ
X-ME-Proxy: <xmx:TCS0anKPHqmifIeg4lJ4MIIDofpyKn3Ft1vpeW2qlKN08kLOEcakAQ>
    <xmx:TCS0akm1PD3Qqi9JLzGCDDnh_YBCSbxWXssK9j0XefhrsPNaVl0SGA>
    <xmx:TCS0avQTm1ke4AH_6Eh5nmzIG8Z36ylISqIdNtq-y4dqLhZYCVE6TQ>
    <xmx:TCS0amLKz_85dku29-cV6SUQfKA4t8p5wb3D_1OIJt7TAQ9XpNCzUQ>
    <xmx:TCS0anm4S2X31Jg9aRxDk3mI9xtpIuZiluEygrPTVdvyvmzxzThtJgoj>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Sep 2026 15:11:08 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Anupam Mediratta via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Anupam Mediratta <mediratta@gmail.com>
Subject: Re: [PATCH] git-p4: avoid shell interpretation of commit ids in
 applyCommit
In-Reply-To: <pull.2411.git.git.1790093506966.gitgitgadget@gmail.com> (Anupam
	Mediratta via GitGitGadget's message of "Tue, 22 Sep 2026 16:11:46
	+0000")
References: <pull.2411.git.git.1790093506966.gitgitgadget@gmail.com>
Date: Wed, 23 Sep 2026 12:11:06 -0700
Message-ID: <xmqqv77vailx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Anupam Mediratta via GitGitGadget" <gitgitgadget@gmail.com> writes:

> @@ -2279,7 +2290,7 @@ class P4Submit(Command, P4UserMap):
>  
>              if fixed_rcs_keywords:
>                  print("Retrying the patch with RCS keywords cleaned up")
> -                if os.system(tryPatchCmd) == 0:
> +                if diffTreeApply(id, tryPatchArgs) == 0:
>                      patch_succeeded = True
>                      print("Patch succeesed this time with RCS keywords cleaned")

Both of these check the result of running diff|apply pipeline and
react to a failure.

> @@ -2291,7 +2302,7 @@ class P4Submit(Command, P4UserMap):
>          #
>          # Apply the patch for real, and do add/delete/+x handling.
>          #
> -        system(applyPatchCmd, shell=True)
> +        diffTreeApply(id, applyPatchArgs)

It is a bit hard to discover, but the original code catches a failed
"diff|apply" pipeline invocation, because the "system()" used here
is what git-p4.py defines for itself.  When the pipeline fails, this
system() raises subprocess.CalledProcessError().

The new one ignores the exit status from the pipeline, so even after
a failure to apply the change, the program continues.

Which may not be what you want to see.

>  
>          for f in filesToChangeType:
>              p4_edit(f, "-t", "auto")
> diff --git a/t/t9803-git-p4-shell-metachars.sh b/t/t9803-git-p4-shell-metachars.sh
> index 2913277013..ef8fd6e094 100755
> --- a/t/t9803-git-p4-shell-metachars.sh
> +++ b/t/t9803-git-p4-shell-metachars.sh
> @@ -105,4 +105,20 @@ test_expect_success 'branch with shell char' '
>  	)
>  '
>  
> +test_expect_success 'git p4 submit --commit does not execute shell metachars in commit id' '
> +	git p4 clone --dest="$git" //depot &&
> +	test_when_finished cleanup_git &&
> +	(
> +		cd "$git" &&
> +		git config git-p4.skipSubmitEditCheck true &&
> +		echo f3 >file3 &&
> +		git add file3 &&
> +		git commit -m "add file3" &&
> +		name='"'"'$(touch${IFS}injection-marker)'"'"' &&
> +		git branch "$name" HEAD &&
> +		P4EDITOR="test-tool chmtime +5" git p4 submit --commit "$name"
> +	) &&
> +	test_path_is_missing "$cli/injection-marker"
> +'
> +
>  test_done
>
> base-commit: d38352cd43ab9745686d697872408bc3249a153f
