Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1184A4A1E0D
	for <git@vger.kernel.org>; Tue, 15 Sep 2026 17:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789492918; cv=none; b=oR+8Mnmm3+ZkHtWOdRRdQtWCHctqlNcB/YM3mQpwfiWnArIulQKEygigHNegvaLU/KsDkfu1nWpCGI30RxH1cHtwturR6kRGXfnbrJ38IRsxQ4nbzhk7UdHDSWcMPMciv1CrxLl8I9pEZ5uUf2LkxZrrV0jUXIth0UevhQLK+b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789492918; c=relaxed/simple;
	bh=sYAk2IU7umtyhoQm2nfIxCjc8dCYeS8uKL1Vu9xvlXo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=itp6ccoVBInR3Bc5kgcjWOC1UEMIAhm4xplZM1cCla6PBBkylu8RKRLfVuccxiDBMqycnOtZNMApCDL7+2pU9ufacmGARZDmXSiT6K6d9QjHL+rc4E2smeK8oK7hw2KcFOn/YsZ1cpjgD3s6hP9G5DKsUP+J5Mtk5yK+dHF8PRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=dMQlkJkZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wbr29GJb; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="dMQlkJkZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wbr29GJb"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 99B9C1D0020E;
	Tue, 15 Sep 2026 13:21:53 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Tue, 15 Sep 2026 13:21:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1789492913; x=1789579313; bh=bW88hW5+f0
	up8ZUGwo+UdhlwWwQt5TP3qNwbpa4SbTg=; b=dMQlkJkZxTBidq4wkbSRcQdCEb
	a51aae4eqQcNHFySjsMjmLerpyBVK/x+fYfiQh0CN0e3icIa/Ae4pH99KgTVdzfV
	tjNamRZMfyNZlBOK5s/CidzB4cLYhksi2GIKkq53vVkA+y4KogYDkJIpCs7ZXiw1
	N4G8i23VT2NCQERh6Z02IAH++h0inxQTfzwdBVoPpMwjPXLRb/xhS3kh6wA4LXGz
	sCa5B7YQ2J0EG94kOFx4YDEYvnlY5jJwy0lVRdnMDf4cegid+d84Elr4ZJGuSB/h
	QV918iVEX6LA6lwLcOmIWPUyp2hBsgufgRbO90C6GYly25Mbekkss55SMQQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1789492913; x=1789579313; bh=bW88hW5+f0up8ZUGwo+UdhlwWwQt5TP3qNw
	bpa4SbTg=; b=wbr29GJbQfMCmAbxdgmOijqiE5NypjnbEW76q4IBbq7maewLq1H
	fWn7NyIPNQ4Lmj4LdshaRsECJ0e2n2LxhyAV0d8GAXwQ6CsNzNoJzz1P21EFrgum
	QFZs501ij8JVD1smtiOVGjS7h9VKC+MFY4rHOr8Rma4nhEcWNxP4/LTXHWJZiFdn
	Kj0P7fiW62KypYD+gGZ02O7eAtMfL3LHo90//s1gDS1+f6Oy9EYLv8vVE5mBFmC1
	Fvx6TRwpdAPZ5nkNuyico4vcNGsTW1oe0R8h1DX5TTBFtb5zpWY83sVThsLDrB/F
	qXVN0E7G2RKvh72Sp6QiRAOawa7HRzwej4Q==
X-ME-Sender: <xms:sX6palugokiLQxZop4MhAVWWApJ87EIUUZRxRWAcwCRFg2bYQ4Sp5A>
    <xme:sX6patgDnVUiUV6jEripxC39690WX1jnJkaJWoz5ZgF2lALY02aJ5gHkBuDDkzT9p
    6774fpEAcNVUcQSRyW1bHpfGpXtIfcZFylH8heHa5yP0Kbnwb8NVQM>
X-ME-Received: <xmr:sX6pau9w-_OzVJYSyUvIHxcO-N345kSdyZ3AY9iy6kpRuPPJGRGudppMryw5eh620TtL1e8Ac8vg-OwSoJWjnD88gaRG48BQ0xcw>
X-ME-Proxy-Cause: dmFkZTF6jJuSSvbMxbK93Lu5lj/AutvJNg4U3t2r941oYpDF5JJ9S1dO3THBjs9KQFY4yB
    i+0bE7el7j5itWyol8mzadzftT+8AluWMPA8isSwNGS0ubkD2eF7wAv8P5gQcGihYQN2Gf
    JcpYyPrzWnHei0X4pQ0vVWwKJe2/QGtFg6Bky6DwbiS0BxeV1pCcCMmoAiUWUR7ioVlzpl
    2KNc3+FtQ2MXtgD0RZLXoVNNXzij6Cw5pU9BOjzUiuhzaHi/17hJ9D0iSeNwHu4A2Jp8nJ
    lZTrtMY9gHiM5ene37WwubutM+stRDGQog3snH8NeWb+fFC0WeV8XbEru5OY/zT158DrRF
    og+iWfGQgumNkInGsi6sdYnP4+1Px6+fx1AcRIT2KZokv8CfpXW0pPCymnRki03KRCL2zv
    taPAzEFAoIia2ckQp1FNsmCt7wxJMPs/yIwydAII6oQOPth/VSojjH+sENJAYVYg+0Cii1
    J15x7NvRw4x4dVhiZIsN+hihI5GvaPToyrJVs4B3ZKGlr7vZX6gApzjvm9gg8vTHwvFTCx
    tTGjedkKZ8BA/Ggnn3udJgFFePGLQB3uum+v89pzQ9X/JsP4tWyVrJj+0pSu/D2pqyjcC/
    +4yhCHnDGLArq0RCcphkjPB9oVZPjnpPznPgU+coQb79QG2Xk2hXdpt96+dw
X-ME-Proxy: <xmx:sX6paovtwpxYk0ioG7vUgFmkglziX-oz--pYhbztbA70mxa1NV4DGQ>
    <xmx:sX6paqqUzI56cRL3vbD56bBPTlpgyVTFKAnVTHPAoVMd4FxOSOp6uA>
    <xmx:sX6pakoGHPRgb0ADDwx3J-n3wpd_aAW78Vmfh86ffmIbFug0YgDjBw>
    <xmx:sX6pahZ6kJhWGn0R_JH7JmQrNtoVdwKtVUtaT-BBb7vh4-NipPp71A>
    <xmx:sX6paszm3v4i84bWZ49u8mj3KZbNx4N1A1kgpXm_G7BHBwqVDK2Ci7Ke>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Sep 2026 13:21:52 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Andrew Pleeter via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  "brian m. carlson" <sandals@crustytoothpaste.net>,
  Jeff King <peff@peff.net>,  Ben Knoble <ben.knoble@gmail.com>,  Phillip
 Wood <phillip.wood123@gmail.com>,  Andrew Pleeter
 <andrewpleeter@gmail.com>
Subject: Re: [PATCH v8] var: support broken-down idents, signing key,
 multiple args, and -z
In-Reply-To: <pull.2388.v8.git.git.1789426226860.gitgitgadget@gmail.com>
	(Andrew Pleeter via GitGitGadget's message of "Mon, 14 Sep 2026
	22:50:26 +0000")
References: <pull.2388.git.git.1787690802942.gitgitgadget@gmail.com>
	<pull.2388.v8.git.git.1789426226860.gitgitgadget@gmail.com>
Date: Tue, 15 Sep 2026 10:21:51 -0700
Message-ID: <xmqq33va1lcg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Andrew Pleeter via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Andrew Pleeter <andrewpleeter@gmail.com>
>
> While 'git var' exposes GIT_AUTHOR_IDENT and GIT_COMMITTER_IDENT,
> extracting individual components (name, email, or date) currently
> requires callers to manually parse the composite string. Furthermore,
> there is no way to query the resolved commit signing key through
> 'git var', and the command only accepts a single variable at a time.
>
> Teach 'git var' to expose individual identity components and commit
> signing configuration, and allow querying multiple variables with
> optional NUL-termination:

The huge laundary list (below) strongly tells us that this single
patch is doing too many things at once and it is better done as a
multi-patch series.  Also, some descriptions seem to hint how the
implementation evolved during the development of this patch, which
nobody is interested when they read "git log" output (which is the
ultimate target audience we write our commit log messages for).

I would say this should be split into at least 3 patches.

 (1) Add "-z" output mode.

     To allow reading scripts to unambiguously parse output from
     "git var (-l | <var>)" command, implement a NUL terminated
     output mode, similar to how "git config -l -z" shows list of
     configuration variables and their values.  When showing the
     value of a single variable this only makes difference for
     variable with multiple values, but in the next step in this
     series, we will introduce a mode where multiple variables are
     queried.

 (2) Add (2 <= argc) mode that displays like "var -l" mode on top.

     To allow reading values for multiple variables with a single
     command invocation, teach "var" to take more than one variable,
     and show output the same way as "git var -l [-z]", giving list
     of "var=value" but only for variables requested by the user.

 (3) Add new variables.

     Scripts reading from "git var GIT_AUTHOR_IDENT" needs to parse
     the output if they want to extract only the author name.  

     To allow scripts to easily access broken-out fields of
     GIT_{AUTHOR,COMMITTER}_IDENT, add a GIT_AUTHOR_NAME variable
     and its friends, as well as GIT_SIGNING_KEY.

After you receive a review, you should respond and try to engage in
a dialog with reviewers, before sending a new iteration of a patch.

When your new iteration is different from what reviewer suggested,
without such an exchange beforehand, reviewers cannot tell if that
is merely due to miscommunication, or you had a good reason to do
things differently.  Don't make reviewers feel as if they are
talking to silent machine that takes an earlier iteration of the
patch with their input and spits out a new iteration.

Thanks.

> - Add GIT_AUTHOR_NAME, GIT_AUTHOR_EMAIL, and GIT_AUTHOR_DATE.
> - Add GIT_COMMITTER_NAME, GIT_COMMITTER_EMAIL, and GIT_COMMITTER_DATE.
> - Add GIT_SIGNING_KEY to resolve the key that would be used to sign
>   the resulting commit if you were to run 'git commit' right now.
> - Allow passing multiple variable arguments (e.g., 'git var
>   GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL').
> - When a single variable is requested, print its bare value for backward
>   compatibility.
> - When multiple variables are requested, model the output after
>   'git var -l' by printing 'VARIABLE=value' pairs (or 'VARIABLE\nvalue\0'
>   when '-z' is given).
> - Format multi-valued variables in multi-variable mode as repeated
>   'VARIABLE=value' entries (or 'VARIABLE\nvalue\0' with '-z'),
>   eliminating stream ambiguity without extra trailing delimiters.
> - When querying multiple variables, omit any variable that has no value,
>   continue processing remaining variables, and exit with code 1.
> - Support '-z' to terminate variable outputs with NUL bytes.
> - Format 'git var -l -z' using the same convention as 'git config
>   list -z' (newline separating key and value, NUL separating entries).
> - Use parse_options() to strictly require options before arguments.
> - Update Documentation/git-var.adoc and t/t0007-git-var.sh.

