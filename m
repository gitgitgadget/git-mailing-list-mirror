Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6690B4962C
	for <git@vger.kernel.org>; Mon, 24 Jun 2024 21:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719265988; cv=none; b=sh45hrCnbd/NgiG3OcBDx3wTi1EWIEYt+oePO6FKFXV9MgDoWryPtclpCljlh9Ny5aXjNeAotpLl7kP1omXPdTJX4hHDrNupwyJELqxPS9kORHpXSpqIk7ZBBDh1KpsLrawcXHr9tD5PClslxBcKa9MtLZg8nSmrpSD2YPWK1j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719265988; c=relaxed/simple;
	bh=YYEChOYIXK8eKc1cp2vNa8s8LsX75dHxGheYl3Qmx2E=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=AXBxkU0iSwWih4oG8kUtEa3Oy1oQAO4jRrPOQeMRjyZFkWOVhdFLl3GgkWVEmj+a7kSGUQd3V/6bhjghENL0Xj2S6kb0c9jHzR+I/c3Daum4o6C9YHnR6gX9929rWbTxYu1docj3Nh9i6a4/Ksed2Ks5bVDWp4gArT5QD+X685I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=sGGLloca; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="sGGLloca"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1719265978;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fe5il9STpmg6f6d8clJN2TX5cqWENGn5qzRmdZiQyn8=;
	b=sGGLloca/CC4V+EvASuVfg5r82jLkrTooPBximgj1PW8ndG/Yld7kUrj/g3ZgFCIA5eE7r
	dnTsRBmnFCPgvhiNs2alrNn+lMqwZM3wUmpV3xXDIAVDgnBT40/fNZtn2m5ePfYu9sNqWs
	Po5Tgf54JiztWmgtSjDdgOzYKfd8FoShz6Ctomam1eb0KuATIMUZ0kg7K1acjpspo6B3An
	flpi/mThl8Ef9dhbCaPdVum9L7tKL6OTtizzyq9eISjCn0bZBlDNChxF1fUQYOvivrSuGj
	TI7pnJ728BJnToA3XnAM/cPnP+5vR6ZrJWBVkE9Rc9yJsZPop8BIUUB+Qgob7Q==
Date: Mon, 24 Jun 2024 23:52:57 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: rsbecker@nexbridge.com
Cc: 'Randall Becker' <randall.becker@nexbridge.ca>, 'Johannes Schindelin'
 <Johannes.Schindelin@gmx.de>, "'Randall S. Becker'" <the.n.e.key@gmail.com>,
 git@vger.kernel.org
Subject: Re: [PATCH v2 1/2] Teach git version --build-options about libcurl
In-Reply-To: <036d01dac67b$a6457da0$f2d078e0$@nexbridge.com>
References: <20240621180947.64419-1-randall.becker@nexbridge.ca>
 <20240621180947.64419-2-randall.becker@nexbridge.ca>
 <f44f1e25-41ca-0784-3186-f9e1bdae0d4f@gmx.de>
 <DS0PR17MB603115E943565C4281FBE199F4D42@DS0PR17MB6031.namprd17.prod.outlook.com>
 <5dc18b418f57cb8376b9fd9a5a4ad9d7@manjaro.org>
 <036d01dac67b$a6457da0$f2d078e0$@nexbridge.com>
Message-ID: <cd0f4bee77c6afbc5deda43b339d22fe@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-06-24 23:15, rsbecker@nexbridge.com wrote:
> On Monday, June 24, 2024 1:09 PM, Dragan Simic wrote:
>> On 2024-06-24 16:33, Randall Becker wrote:
>>> On Monday, June 24, 2024 10:13 AM, Johannes Schindelin wrote:
>>>> I am not sure that this is the most helpful information Git can
>>>> provide:
>>>> It reports the version against which Git was _compiled_, whereas the
>>>> version it is _running against_ might be quite different.
>>>> 
>>>> Wouldn't calling `curl_version()` make more sense here?
>>> 
>>> I think the more important information is the build used. My 
>>> reasoning
>>> is that one can call run curl --version to see the current curl
>>> install. However, different versions of curl have potential API
>>> changes - same argument with OpenSSL. What initiated this for me (the
>>> use case) started with a customer who incorrectly installed a git
>>> build for OpenSSL 3.2 (and its libcurl friend). Git would then get a
>>> compatibility issue when attempting to use either library. The
>>> customer did not know (!) they had the git for OpenSSL 3.2 version 
>>> and
>>> I had no way to determine which one they had without seeing their 
>>> path
>>> - hard in an email support situation. Having git version
>>> --build-options report what was used for the build *at a 
>>> compatibility
>>> level* would have easily shown that the available library (after
>>> running openssl version or curl --version) reported different values.
>>> Otherwise, we are back to guessing what they installed. The goal is 
>>> to
>>> compare what git expects with what git has available. The above 
>>> series
>>> makes this comparative information available.
>> 
>> How about announcing both versions of the library if they differ, and 
>> only
> one
>> version if they're the same?  We're building this to serve as a way 
>> for
> debugging
>> various issues, having that information available could only be 
>> helpful.
> 
> I don't have a huge problem with that except it will significantly 
> decrease
> performance. We do not currently have to load libcurl/openssl to obtain 
> the
> build version (it is the --build-options flag), so adding additional 
> load on
> this command is not really what the series is about. Doing this 
> run-time
> check might be something someone else may want to take on separately, 
> but
> from a support use-case standpoint, it should be covered as is. Doing a
> comparison is a separate use case.

Yes, the additional load is actually a bit concerning.  Perhaps we could
wrap the current series up as-is and leave the possible improvements to
the follow-up patches?
