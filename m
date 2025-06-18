Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993B73085A0
	for <git@vger.kernel.org>; Wed, 18 Jun 2025 19:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750275176; cv=none; b=YEncVAtrAWVRkICZKOhCz34yCiD6aH3WGQPvHBrbdb9Nc8uCXpkID3sAI2aiV+b7KhRx4564XlT7cvKHMswyLwa6mpS/2jEyEtqAHwqXrLxqKwLS4anVZCAymKlBqF72J5/eiSf99ejQVgRZUe5TGcYg5kREgw33K5afzzuKh/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750275176; c=relaxed/simple;
	bh=zKxnpRS/aYridY1yOhEVUKtfQk0cdIHxF1Abh+6FxXU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VR8mRHOyEv4s3J646a6gkEkLjNaOJoUgBUGUOAbFNhifDqWAchsREOd+7yVqhOsEVSJXmOA1Db94rZ1HDPOezlqR0D5io4zqlOmbEMjL534sw70BDu7G0E07lGI1R3JsebX26LM6AlGSjw33IvdOZNhOWLmQomKUs3fKcVMC7Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MkLiFrak; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MkLiFrak"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-748e63d4b05so758767b3a.2
        for <git@vger.kernel.org>; Wed, 18 Jun 2025 12:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750275174; x=1750879974; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IqpRxPtdxOsJ/OHGEcfIAkoKaELAU4wF7CzOGAEUY9c=;
        b=MkLiFrakf/CLk8NiitbjarbMy+qVCAPhjWxkWeeJK14mmrV3G6aMhNyQr41DFLaOxE
         cUmqASjOA4fXmik98IQIoBlIdaNZZDi9Aa0cOSq/Iiw0I/PCvORVwS7yRE0f9WpZxZQq
         OuWybviSnN5ALbSatQTjFq5D1zyuY+UHbXEh04u5y4TV+Y2+kBbM8ujM8b0nxjWexUOW
         yh92ylXziE6v891C8xkVpMzdUwDFdGJZ+/NHBEjHoMlrnipsm+tEZVOPfg/+wki2IJHf
         rNzVlXJ22gzkO2j9f4pKW8fTtmpmUlepMamwhb3zAm+00pSFOD3mouDYqyGQHHIFnZeG
         e/qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750275174; x=1750879974;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IqpRxPtdxOsJ/OHGEcfIAkoKaELAU4wF7CzOGAEUY9c=;
        b=GLKqli9hOOQWuvCQuD547bOSh4Gv1rb4+CSkX28joHxmTuygdpgGiQnmmQqhJQ3dVo
         92lrsJxnu97ELjxvvXKWEd4NGjlzOrxZni6iulDa3Y5+SMiMlKHA5BJNE/YrBM2gObfG
         WsYcNGuFcUrqOD1vl1Xqtl3EozXPiNEA9ggZodSdueZUazfajQCzUiJZZ4pICklzXfjw
         Loua7n0N2uY0v0SNt/xNM1yZdqOFb9tWdgnINGuYi+pOL2DExKt1C1iy3VcQ4wRJvoHJ
         KGo6mVoglH7pX8PbxEdmH3ugeo8imERRahHJErBY3MXCNdc/JuOMy2aZIskmNSuVGHi3
         tEbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbe7aZVzodmvkNlSmdaOOlh1jR56Hmi3zGIPJCMl1AYCjSbwT1c9UXezStyT4xxA/eslg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+DxKTiWDUAgfu9CJiBLKZslRarbpPbUiO7sarxo7DIfvqkr65
	panCZTy7Twp+i1dmjpg0YOpsZFK2Tgoqbem4I5Jnvm+eXsPZr7P+m9iw
X-Gm-Gg: ASbGnctVK+nIDKU4z1ZQ9WPn16n6I0StRz1EvEadCHhZ5FmLkj9w96p8Z/B3Nl8Jsta
	nSRa03m6bgBXGuWYpfeDFc9Al4eXSTq/AU8qXZAEl5V00T39p9CpACbCtRzk8Eq/0Lt71w6+kgz
	pXVd89qUjecVSTSCv5dmUUC6+RENBzhV2I8vbP0PVa8TYPoSdRhb9oRbmCKKFDwnNKXdR6cSdsl
	OSEZthkzV8j9VVp8gOYy+jMi0Wd2jNRrmwdqfWDfRrxusM8RSkhPgY9tdWU2babq97y/VaG17iT
	mRTY+2CC0MpT1yWz4tl4hyOhbWtpdtTPA9tx7/en4O8=
X-Google-Smtp-Source: AGHT+IE7Y8LwN5OcoAptTmK0nWXEPK1295+d9DdSaFKBB0biNzbDYv4pRFd4uh/BSuT0sXvMXCY6AA==
X-Received: by 2002:a05:6a00:3d10:b0:740:aa31:fe66 with SMTP id d2e1a72fcca58-7489ce0d39fmr24494815b3a.4.1750275173589;
        Wed, 18 Jun 2025 12:32:53 -0700 (PDT)
Received: from fedora ([2601:646:8081:3770::de7b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-748900829f7sm11426978b3a.87.2025.06.18.12.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 12:32:53 -0700 (PDT)
From: Collin Funk <collin.funk1@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,
  git@vger.kernel.org,
  Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH] portability: allow building in systems without d_type
In-Reply-To: <xmqqwm98ewsd.fsf@gitster.g>
References: <20250618062331.78059-1-carenas@gmail.com>
	<xmqqwm98ewsd.fsf@gitster.g>
Date: Wed, 18 Jun 2025 12:32:52 -0700
Message-ID: <87frfwsv4r.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Junio,

Junio C Hamano <gitster@pobox.com> writes:

> This may allow you to compile and build, but does the resulting
> binary do what you want it to?
> [...]
> On a platform without d_type member, DTYPE() macro gives DT_UNKNOWN
> that is not DT_DIR, so essentially you are always passing 0 even
> when you are looking at a directory (in which case you must pass 1)
> to match_leading_pathspec().
>
> So I somehow doubt this is a correct fix.

Good points. I guess I had reviewed the original patch too late to
realize myself...

> I do not know if get_dtype() helper function is easily applicable to
> this codepath, so I wrote this in a longhand...
>
>
>  diff-no-index.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
>
> diff --git c/diff-no-index.c w/diff-no-index.c
> index 7c95222ba6..677df91fc5 100644
> --- c/diff-no-index.c
> +++ w/diff-no-index.c
> @@ -41,12 +41,28 @@ static int read_directory_contents(const char *path, struct string_list *list,
>  
>  	while ((e = readdir_skip_dot_and_dotdot(dir))) {
>  		if (pathspec) {
> +			int is_dir = 0;
> +
>  			strbuf_setlen(&match, len);
>  			strbuf_addstr(&match, e->d_name);
> +			if (dtype != DT_UNKNOWN) {
> +				is_dir = dtype == DT_DIR;
> +			} else {
> +				struct stat st;
> +				struct strbuf pathbuf = STRBUF_INIT;
> +				strbuf_addstr(&pathbuf, path);
> +				strbuf_complete(&pathbuf, '/');
> +				strbuf_addstr(&pathbuf, e->d_name);
> +				if (!lstat(&st, pathbuf.buf))
> +					is_dir = S_ISDIR(st.st_mode);
> +				else
> +					; /* punt */
> +				strbuf_release(&pathbuf);
> +			}
>  
>  			if (!match_leading_pathspec(NULL, pathspec,
>  						    match.buf, match.len,
> -						    0, NULL, DTYPE(e) == DT_DIR ? 1 : 0))
> +						    0, NULL, is_dir))
>  				continue;
>  		}
>  

Two very minor issues with with this patch. The arguments to 'lstat' are
reversed and the 'dtype' variable is not declared. Here is a diff that I
applied after your diff:

diff --git a/diff-no-index.c b/diff-no-index.c
index 677df91fc5..a768b46dcd 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -42,6 +42,7 @@ static int read_directory_contents(const char *path, struct string_list *list,
 	while ((e = readdir_skip_dot_and_dotdot(dir))) {
 		if (pathspec) {
 			int is_dir = 0;
+			int dtype = DTYPE(e);
 
 			strbuf_setlen(&match, len);
 			strbuf_addstr(&match, e->d_name);
@@ -53,7 +54,7 @@ static int read_directory_contents(const char *path, struct string_list *list,
 				strbuf_addstr(&pathbuf, path);
 				strbuf_complete(&pathbuf, '/');
 				strbuf_addstr(&pathbuf, e->d_name);
-				if (!lstat(&st, pathbuf.buf))
+				if (!lstat(pathbuf.buf, &st))
 					is_dir = S_ISDIR(st.st_mode);
 				else
 					; /* punt */

With Carlo's patch the following tests fail:

    $ sh t4053-diff-no-index.sh
    [...]
    not ok 35 - diff --no-index with pathspec nested pathspec
    #       
    #               test_expect_code 1 git diff --name-status --no-index c d 1/2 >actual &&
    #               cat >expect <<-EOF &&
    #               D       c/1/2/a
    #               D       c/1/2/b
    #               EOF
    #               test_cmp expect actual
    #       
    not ok 36 - diff --no-index with pathspec glob
    #       
    #               test_expect_code 1 git diff --name-status --no-index c d ":(glob)**/a" >actual &&
    #               cat >expect <<-EOF &&
    #               D       c/1/2/a
    #               EOF
    #               test_cmp expect actual
    #       
    ok 37 - diff --no-index with pathspec glob and exclude
    # failed 2 among 37 test(s)

But with your patch (+ the minor corrections) the tests pass as
expected:

    $ sh t4053-diff-no-index.sh
    [...]
    ok 35 - diff --no-index with pathspec nested pathspec
    ok 36 - diff --no-index with pathspec glob
    ok 37 - diff --no-index with pathspec glob and exclude
    # passed all 37 test(s)

Therefore, I think your fix is good to go with a commit message and my
changes. Feel free to add me to Reviewed-by/Tested-By.

Collin
