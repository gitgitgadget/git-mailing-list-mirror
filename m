Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A5063D
	for <git@vger.kernel.org>; Sat, 23 Mar 2024 19:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711223182; cv=none; b=YEA2hKEJvOTIUSqiOKeOIHcjVhsBUFWzvolqrfDMb5WhD/EfiCxLfkrqYhgh8IFrS5yUQztC3RhwIhXVHpGr5euX/SVsdTnAX6cNya7zy3+n5GR5miT3VlSYeO1tiUUM5CVrcVWXnGzPLbZsX0savgRnSfLTeOo/qtwZz0bqR8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711223182; c=relaxed/simple;
	bh=ushgdkVlgmEhtChho/3/VcSNc4Vxua8XMralUl5r1p0=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=gqdPTk/7wk8RHsq8wTkxMpONGCyyK+rRRwx3Fi+Z01POIZ/XsXfpYAf+6979N4C13Oo7sA/rUhzN5/+NbopxD8i4RLz1E05ID7nOH/79pIzYY/qQAv0ZowegCTL7tS0gYJEyhK2TPhQfLhgLd5QE7MHSNUQnH8Nf46bxW5U7zuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=vBHzKM2h; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="vBHzKM2h"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1711223176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y1bnSBXahjgJsIYy1PZ/S8ShEZ5/mVRkGwVpthmitHM=;
	b=vBHzKM2hKsxqcmPvOH2pFNVC+M9g1Wtkdxq6dnMCTTKMS3kC2iy4xDDrB6C7Wb8tV5qpQa
	Z8Osc04dtti4Xh4UQ576s8fyIQNai9hO/I9+fqizNdK1rI4eyFhMssH7YW7As0g46V1093
	K/b2F5cdle8UvVxoyQTxTg1ISpLJcFXelN0V6lBXyKI+1wblFYzec3Xnva4jbhhxo9xeFU
	S1Vb1RUJC2NOGh4XUgD7ef8cRv6K7aLBpo97w/jZBU9dJArMP5XGFwk9j+TbrgURe7/k3d
	cBQzzEBjuzH75GlSoqlg3PM8kEn1ViDPd0ggFFZfknUMGPWSvO20A2m/pFMUiA==
Date: Sat, 23 Mar 2024 20:46:16 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: =?UTF-8?Q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>
Cc: git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com
Subject: Re: [PATCH 3/3] grep docs: describe --no-index further and improve
 formatting a bit
In-Reply-To: <6056709.lOV4Wx5bFT@cayenne>
References: <cover.1710968761.git.dsimic@manjaro.org>
 <264643a638fd1ee9970f96e7aa4914c37e30b3d2.1710968761.git.dsimic@manjaro.org>
 <6056709.lOV4Wx5bFT@cayenne>
Message-ID: <ed050f2d496a6db07e698fd2f1094b81@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Jean-Noël,

On 2024-03-23 20:26, Jean-Noël AVILA wrote:
> On Wednesday, 20 March 2024 22:08:46 CET Dragan Simic wrote:
>> diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
>> index f64f40e9775a..b144401b3698 100644
>> --- a/Documentation/git-grep.txt
>> +++ b/Documentation/git-grep.txt
>> @@ -28,7 +28,7 @@ SYNOPSIS
>>  	   [-f <file>] [-e] <pattern>
>>  	   [--and|--or|--not|(|)|-e <pattern>...]
>>  	   [--recurse-submodules] [--parent-basename <basename>]
>> -	   [ [--[no-]exclude-standard] [--cached | --no-index | --
> untracked] | <tree>...]
>> +	   [ [--[no-]exclude-standard] [--cached | --untracked | --no-
> index] | <tree>...]
> 
> This change gives precedence to some option in alternatives, which 
> seems
> weird.

As explained in the patch description, it isn't about the precedence,
but about grouping together the options that have something in common.
In more detail, --cached and --untracked have something in common,
i.e. they both leave git-grep in the usual state, in which it treats
the directory as a local git repository, unlike --no-index that makes
git-grep treat the directory not as a git repository.

>> @@ -45,13 +45,20 @@ OPTIONS
>>  	Instead of searching tracked files in the working tree, search
>>  	blobs registered in the index file.
>> 
>> ---no-index::
>> -	Search files in the current directory that is not managed by Git.
>> -
>>  --untracked::
>>  	In addition to searching in the tracked files in the working
>>  	tree, search also in untracked files.
>> 
>> +--no-index::
>> +	Search files in the current directory that is not managed by Git,
>> +	or by ignoring that the current directory is managed by Git.  This
>> +	allows `git-grep(1)` to be used as the regular `grep(1)` utility,
> 
> Auto-referencing the git-grep manpage in itself is useless.

Please note this isn't a link, it just mentions the operation.  Though,
I agree that rewording it a bit might be beneficial.

>>  When grepping the object store (with `--cached` or giving tree 
>> objects),
> running
>> -with multiple threads might perform slower than single threaded if 
>> `--
> textconv`
>> -is given and there are too many text conversions. So if you 
>> experience low
>> -performance in this case, it might be desirable to use `--threads=1`.
>> +with multiple threads might perform slower than single-threaded if 
>> `--
> textconv`
>> +is given and there are too many text conversions.  Thus, if low 
>> performance
> is
>> +experienced in this case, it might be desirable to use `--threads=1`.
> 
> I'm not native speaker, but I'm not sure the switch to passive form is
> helpful. In Simplified English, passive form is considered harmful and
> difficult to translate because the subject is elided.

In general, not addressing the user/reader directly is preferred in
technical documentation, because it eliminates the possible element
of persuading the user to do something.  In other words, we should be
telling the user what our software can do, instead of telling the
user what to do.
