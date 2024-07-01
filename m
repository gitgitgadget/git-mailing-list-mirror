Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6110239FD0
	for <git@vger.kernel.org>; Mon,  1 Jul 2024 11:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719834368; cv=none; b=JXh947K/QooE+GwIn76saM0ZKlz+pAIsXAP11NJaH1rJcPQGGWPX/hn9iIkzsrgNiTTJAvWkZHlH+H8etq5IFsXLts+/glb9d0P6+fc8EcitRFaAixHDvU96rX1t/q48SK7RPpBVmQvyvg8eXhI+kw8O3GKWtukV6Uh2FIXRo5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719834368; c=relaxed/simple;
	bh=8AFunC1q3AeHqi3Wqy2hFeTG0jBk7DPOLVhp+t4dCo0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rzuHw+kJ3VIlPUDNOzh21G9KTMIEvkAE5GNxU9ke2YcPPisJuKzLHSyJiy/7bVYCnASTO7+1cqVnklP5jFzBZh8+vu70iyMD5vCaUcde7XvuAahIzq5QPhOXmo9ww/hpW76aPednYvhRWSs78wfW60+2Q8jCimVh+6OLjyPWF+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JOgKQsoc; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JOgKQsoc"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7066c9741fbso2356714b3a.2
        for <git@vger.kernel.org>; Mon, 01 Jul 2024 04:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719834366; x=1720439166; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=krh1qpSvKWBYkJK9og4qfM8EiRjFJuwqS5jPdEwx85o=;
        b=JOgKQsoc+AdCLOgy8+bvRxH/LBfhbE8nBPd0uRSX7Rne9PyTkRDSIIfUBu4wSuTfcq
         gzOazc7b3rklFJttxULttJawq05Zz/BWzeKJEBv/wmkF2QW+Fi+rNDTpjFKFDJ2JySJG
         qX1pxppnDLyRXEFEPipObGBbTuy72OSsDIdkBBa7UoN5edVeqA/nUKE0YbwOZMCFze7X
         gF6VqyCgR+CnVWDrK26THNgM7UZqkggidpfyw9hIaAjRaEvrVvMbIC/6IkKrt2Pz+fzw
         9lccJHDc9flsCtV2z0jMShaviZ/w+mw3kcJRJVFfToaLOA/BFVWhKvPkXzrlnpG/gSGi
         XLtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719834366; x=1720439166;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=krh1qpSvKWBYkJK9og4qfM8EiRjFJuwqS5jPdEwx85o=;
        b=iQ7wGueJFsGWXeBEFXRVVgMqcy9TjOCgUk2nhlAKpZkfZFJroyeC89otW/8KSKCInU
         jFR7LMHPNJPUSPfDfys8S5TQbZYcM49JgyTmka1t92pcfQzW9Iep2sXF17AOMgcTqeyl
         81RnS+aVuSQg5bju6xR0g6n7HR2vumXt3pXo0Z2TI2xSRNhMlNy1TfKKdNbs1Hltkq30
         YIW14mzbQnd3WrkMb7byeFtIHVUhqduSze8nqo7oE+Ek2M0Vfyw0MSqLwIC77rjogl6V
         wXJ0gxPNuEvQ774GKl0AqldeIZ/Kd1flNYARaDlLehTEWpTQ5hoZ8V3sEk7ozZuf/y3Q
         3EMw==
X-Gm-Message-State: AOJu0YxI0cVrZ4uCShkZ5gO1pcw+JT09w4i7jvAN/LNz03w11EkWfyEX
	OX2Sa/8W0AJi7JFMHD2/oCkIv3DTluVvFBpsye0OKOwfNDmWfs5cmsJoR5Up
X-Google-Smtp-Source: AGHT+IHtKZiXOG28eBZtDyzHf2+C1G0M1OVgYa4UbcRwA+iuxTedNOQWqxfnOMJrFJCRNMUNfjyfiQ==
X-Received: by 2002:a05:6a20:9186:b0:1be:d299:d818 with SMTP id adf61e73a8af0-1bef6109d16mr8779286637.14.1719834366136;
        Mon, 01 Jul 2024 04:46:06 -0700 (PDT)
Received: from google.com (202.168.16.34.bc.googleusercontent.com. [34.16.168.202])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac1598cfbsm62812055ad.250.2024.07.01.04.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 04:46:05 -0700 (PDT)
Date: Mon, 1 Jul 2024 13:46:03 +0200
From: Jonathan Nieder <jrnieder@gmail.com>
To: limin <1159309551xcz@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Git remote origin leaks user access token
Message-ID: <ZoKW-yDJMsz9JPSI@google.com>
References: <CALFtjBBvk+JPmU_GzrnM=ANwaQDdiLtzh4YkZFbcVENyCu9fxA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALFtjBBvk+JPmU_GzrnM=ANwaQDdiLtzh4YkZFbcVENyCu9fxA@mail.gmail.com>

(+cc: git@vger.kernel.org, git-security -> bcc)
Hi!

limin wrote:

> Hi, I found a potential security issue when running a tool in my private
> project. I think this exposes my personal access token to danger when using
> "git remote get-url origin".

I'm moving this conversation to the public Git mailing list, as this
behavior is well known.

I look forward to working together on ways to reduce the impact (for
example, ways to encourage people to use their system's password
keychain instead of including credentials in URLs).

Report left unsnipped below, for reference.

Thanks,
Jonathan

> Version
>
> 2.45.2
>
> Description
>
> Lots of people are using personal access token to clone their private
> repository. To use a access token, you can include your username and token
> in https url to clone projects on github, gitlab or any other DevOps
> Platform:
>
> git clone https://<username>:<token>@github.com/username/repository.git
>
> However, we can get the token back easily by just using git remote get-url
> origin.
>
> cd privateProject
> git remote get-url origin
> > https://username:ghp_xxxxx@github.com/username/repository.git
>
> This can be dangerous, because we often run third party tools in our
> private repository. If a malicious tool runs git remote get-url origin, it
> can steal our personal access token of github/gitlab. In this case, our
> github/gitlab will be controlled by attackers which can have severe
> consequences.
>
> I found this issue during code auditing via safety tool
> <https://github.com/pyupio/safety>. After scanning a project using safety
> check -r requirements.txt --save-json test.json, safety saved results into
> test.json file. However, when I looked into test.json, I found my personal
> access token in this file.
>
> "report_meta": {
>     "scan_target": "files",
>     "scanned": [
>         "/home/kali/huntr/azure-sdk-for-python/tools/azure-sdk-tools/ci_tools/versioning/requirements.txt"
>     ],
>     "target_languages": [
>         "python"
>     ],
>     "git": {
>         "branch": "main",
>         "tag": "",
>         "commit": "b182b0c4f9d07d18f118130bc941c3b7a75667b1",
>         "dirty": false,
>         "origin": "https://outh2:ghp_xxxx@github.com/sunriseXu/xxxx.git"
>     },
> }
>
> So, I looked into the source code of safety. The class GIT
> <https://github.com/pyupio/safety/blob/f15d7908d27fd887dcc6b31237b8e3df79a9359b/safety/scan/util.py#L49>
> is
> responsible for collecting repository information in current repo where
> safety runs.
>
> class GIT:
>     ORIGIN_CMD: Tuple[str, ...] = ("remote", "get-url", "origin")
>     def __run__(self, cmd: Tuple[str, ...], env_var: Optional[str] =
> None) -> Optional[str]:
>         if env_var and os.environ.get(env_var):
>             return os.environ.get(env_var)
>
>         try:
>             return subprocess.run(self.git + cmd, stdout=subprocess.PIPE,
>
> stderr=subprocess.DEVNULL).stdout.decode('utf-8').strip()
>         except Exception as e:
>             LOG.exception(e)
>
>         return None
>     def origin(self) -> Optional[str]:
>         # get the origin of repository
>         return self.__run__(self.ORIGIN_CMD, env_var="SAFETY_GIT_ORIGIN")
>
> Impact
>
> This can have severe consequences. *Any* tools running in private
> repositories have ability to steal personal access token if the token is
> written in git remote url explicitly. Git should mask user’s access token
> when using cli command git remote get-url origin.
