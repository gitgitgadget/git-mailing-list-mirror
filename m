Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476874BA1C1
	for <git@vger.kernel.org>; Mon,  5 Oct 2026 15:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791214653; cv=none; b=QnGqfgaJPC3Ikfss3Zrh6Cjixw5F0oNQcwBttFbjmUlEiaU3jVWB8M0pr8ygGVYd9Ju+h1GJJcFvjDW+yQmax8VVE72pUnyZLGiTMQTaWNbPx43X0ksZ5d4WRVlFRjNrabP9spb40UKDJUEd6q2awpXTgxN64pDanwSHtBvPNpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791214653; c=relaxed/simple;
	bh=zh5Z8qPYHuiygGBtIvCm/xPdne8tP7rL43hj33ikwP0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZyTqfEVmWQSZT2rlKRBtGIgUanVBj79w/covbXQPspZH+69s3u7exNwgC7Pc6M73uH2sVMOp+IvRTB5UuGejTfV4fyPXyNec/JNYoGEvS3/iPeBYrJbT+bFh1Q0pmSkCPo1OqaN6gkN+wJouYXXszEVSJ7TlDqm3FlXpM3hI1kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Ls182Hao; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fqYoig77; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ls182Hao";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fqYoig77"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id E748EEC08D3
	for <git@vger.kernel.org>; Mon,  5 Oct 2026 11:37:29 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Mon, 05 Oct 2026 11:37:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791214649; x=1791301049; bh=u6DOT8RWt5
	vhcNYAOfereDrxOkLcwFAllnX29sBMiW8=; b=Ls182Hao8gwG/h2SGz77tj5ks5
	bEvLUGIIqZRB79Zszv2qv3UlrAFYKewiz04dzQbOzDFQM4CRL3MfzXqC4gJeYgtc
	mVRuWaOiGEpJVj9uqW4sejrP82ylzDv4P0QW624BDowymQWBiuL7LUsLHT4hMzHX
	KDSRXCXTJR/MV6BgqP0mVwfEjP6h1cvTIoshdo8xYgjrYTJWH/yPScfFFFjwHo1U
	xV61jIBPNh+iUzCBlrsSmVSk98RqS1mR5P5h62YKfxNVwgEGxaIim8JpYrtj2+FQ
	2Dcu+iOAY7LMGr04wQ+SX5pA6oDYpZuUWAsXEcxOiiIO/0dfVRU8ckRnIDSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791214649; x=1791301049; bh=u6DOT8RWt5vhcNYAOfereDrxOkLcwFAllnX
	29sBMiW8=; b=fqYoig777QrkC0g8EM0BJRIAeXe8j+wkUu63vSiAfReyfBNjikl
	CTotInmKe6Cp91M1wENZxTU6rNOoXNfwQYdVB8M3M3KaryRSFy38xMD7w5ovy9mI
	lSWNFVtr8Hb0BGT3s4xaMfCRqKlZKuHHRFBAWDbHOGGrrdRWMvLCY3Pr/jWbCh9r
	PtvaJQOxw7IBxEKuz4TDwGsejACIO0HYCfsenAWzBqPikhCtjANwr6o07d5dOrZ+
	0E4xlpXq3nnXQAu0pJaWAgeKaLmN+QtY+F3r6764a5rNyHc+kqexowe9IM7wtM5p
	Db3jXPX0Ljm8q6b8mMsn/Tds6HJchfJQ4Rg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791214649; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:UWb5ElrX22IGEOOsLDXcJus+buiBhNupk0YCC9gvf04zYQU
	mmE9NgH9Cj6Yys0AdFTioyGeNiHWwaaIXmXU9d+RyqZBK6vXu0+Fmd6c6GBPVmhD
	wigyaIGe+Chpuf5LGLUECKr3GenkcHszzW1l4ckviij7ZZL5oTcMBzXiMWKuNmQV
	/HOw0diyEZd8eyoDVN8yBz1ag2UNLKp75qPBLAv+fNCrhJIwcm5b7SRKh5VsCMsv
	zT/MROGeFAEweF7DZSQw/IqRSmaZT8jMUJpyPlb+gudWZn3VGxbJxfUzHc/XT19X
	unJhcDonnXbD1o2izRq+vSkRWoOPlPHbCtXLT+w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:pnmS7Ushh+35MWzZVk9e0t4KpTEiwP4ZgZOH04qiakY=:zh5Z8qPYHuiygGBtIvCm/xPdne8tP7rL43hj33ikwP0=;
X-ME-Sender: <xms:OcTDamhFVkZCZWkx3e2bVcKCqeI47UaRiLB9jShuoe0ir4oENJpJJg>
    <xme:OcTDahAb4BV-v4cfjX9_jIaIPy20eWCDoe7zISkOLKhK3B29TDEeuHx8xSrn0wIfA
    D-VDlhNvdJLLMAbAHhcfOLSb_z4Fus6YwZiYoAN8F-Cfj54Os1Pys6L>
X-ME-Received: <xmr:OcTDakt0uqMy_IMXqT0lkzGvXjJZd1raHWILjrTnKYXEaItHw4lqV6SonjGDG88sSjABA37E8pT7FJ_oOqiazuC9eR6DrqTQGRKW>
X-ME-Proxy-Cause: dmFkZTGaoOTuCaJgDSLITKx6OlOqpYQvnvJ7NdMF2Jq3fy6TxaM2BeuEu+5yJstWkkTPkN
    JCE/67mEWRa43gJ/HCjzc8rb8zQ+Zs+hDFzxbVQ3DJWVOHzAJxQCFpJkkLPcH+3qimdyED
    aM7872lcrf2j/ksIU0LAGhKKoBxR4Y02istUbxJqMCUnWkMVoUmjp8KqzkAwbMuqhLx5xv
    4UytJGyJLOEvr3wIDBN7nkhfLpXUCZ+/4CnL/BjITukoaQNsxnCgyCwdGV7M/yaVKDwQOQ
    dZxRodaQfQxf4b6d0T00UZxp+FkN+88eFWOnlMwwOkpStxdrawKq926T2QuFrbeer5E1bN
    9OEHiBKZFUCuql7+oTN84TY4z35U/PjN4AY1OYsof4AOseAXLBeTN94wJEpBsF3h+DV40b
    /Tx6zuvY3LSqgQ0v4Btt50DLcuJz9TnsDsq+pJnj+8gH2sz+AkC3ZL0tmdILR+FDG61ndO
    MkwErGIekmFtnt6oVc+tR45BUeXSJT0nAaJ7FI+MK7aFt0WWVm8REMxvougYcxPV+VKFrm
    /0wTA+lrmGGwCAEIRuwMnxoJvVsblqB/aUKtIRuMrLPZ3qlLEwU1e8cifoQrH0PTxvkEBD
    /RbNfSDyKT1MK9Y8X2U5bmo6l65FCb4QxZjSBGePhTnusf8TpwXhZgR6kQpQ
X-ME-Proxy: <xmx:OcTDatfjulpUpGiQdMXG39k0UqMFSM2cfLopNM_N-T2TDRt_9q3I2A>
    <xmx:OcTDah99PYk8iK9W3hVm12wxLlmNDqkgd__GLmxbrQ5x5Vo7fwv4Ww>
    <xmx:OcTDaoQA4BqxUBzOp6APPvwM0odtSiSjyFeZVzvq38U3KVtXPBwLdw>
    <xmx:OcTDaiqlpCqOxu4mHGFWQr2y9wLJO01sL9oBhvAmgzCB7ueDTAs9_g>
    <xmx:OcTDaq8fShcUTfA62lyfA1z-GK86rab_UoiZLfgurgCMGXj46xPl88-q>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Oct 2026 11:37:28 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Ravi Mistry via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Abhijeetsingh Meena <abhijeet040403@gmail.com>,
  Kristoffer Haugsbakk <code@khaugsbakk.name>,  Phillip Wood
 <phillip.wood@dunelm.org.uk>,  Eric Sunshine <sunshine@sunshineco.com>,
  Ravi Mistry <rmistry@google.com>
Subject: Re: [PATCH] blame: default to ignoring revisions in
 .git-blame-ignore-revs
In-Reply-To: <pull.2224.git.1789169384240.gitgitgadget@gmail.com> (Ravi Mistry
	via GitGitGadget's message of "Fri, 11 Sep 2026 23:29:44 +0000")
References: <pull.2224.git.1789169384240.gitgitgadget@gmail.com>
Date: Mon, 05 Oct 2026 08:37:27 -0700
Message-ID: <xmqqse2kma4o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Ravi Mistry via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  blame.ignoreRevsFile::
>  	Ignore revisions listed in the file, one unabbreviated object name per
>  	line, in linkgit:git-blame[1].  Whitespace and comments beginning with
> -	`#` are ignored.  This option may be repeated multiple times.  Empty
> -	file names will reset the list of ignored revisions.  This option will
> -	be handled before the command line option `--ignore-revs-file`.
> +	`#` are ignored.  If `.git-blame-ignore-revs` exists at the root of the
> +	working tree in a non-bare repository, it is used by default.  This option
> +	may be repeated multiple times; files specified here are processed after
> +	the default file.  An empty file name will reset the list of ignored
> +	revisions from previously processed files and disable the default file.
> +	This option is handled before the command-line option `--ignore-revs-file`.

The proposed log message explains that '.git-blame-ignore-revs' is
used as the default for blame.ignoreRevsFile even when the user does
not ask to do so in order to match what hosting sites do, as it
would be confusing if the local repository behaved differently.
While wanting consistency is reasonable, the description above does
not quite match that goal.  If an untracked '.git-blame-ignore-revs'
file exists at the root of the working tree, or if a tracked one has
local changes relative to HEAD, the local repository behaves
differently from hosting sites that operate on the
'HEAD:.git-blame-ignore-revs' blob.  It may make more sense to say:
"If the 'HEAD:.git-blame-ignore-revs' blob exists, it is added as
the initial element in the list of ignore-revs files.  Other files
listed in the configuration are also used, but an empty element
makes all elements that appeared before in the list forgotten."
This rule should apply whether the repository is bare or not.

The proposed log message also talks about taking only a regular file
and ignoring everything else for "security" [*], but there is
another important thing we need to worry about security-wise.
Somebody has to audit the parser for these files (one unabbreviated
object name per line, ignoring whitespace and lines starting with
'#') and ensure that the implementation is truly secure.

This is a new threat vector introduced by this change.  Without this
patch, blame.ignoreRevsFile comes only from the configuration, which
cannot point to an attacker-controlled file under our threat model.
Now, however, the parser must read upstream-controlled content at a
known path, and it must be prepared to cope with attempts to use it
as an attack vector.

[Footnote]

 * By the way, "we do not read anything from the working tree.
   'HEAD:.git-blame-ignore-revs' is the only thing that is added
   to the picture" would make it unnecessary to lstat() and ignore
   non-regular files.
