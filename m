Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCD41925B4
	for <git@vger.kernel.org>; Wed,  4 Dec 2024 21:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733346904; cv=none; b=o4fk3XOxK2MU9AwRpV7id8ZjWViiaNXnCo4b15HtE5DPbLMO04Ph7iAthEQBCFqAubmSLXwRa7O6ejgM8kbWSO3B5QzaeNbyiSd+1nh9ZwADLuQHqSYWgBTOas6eDvpUuYv8WcRbgl76upl5cf9SuwEh5ng70MXNH34OT6sobg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733346904; c=relaxed/simple;
	bh=NS34Xo5s8sDC81EKX+7UPo9mQiBhmF0ggKSjehV6aTw=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IDA9ADxMQTH9lvq+rotvv823FMi4rkM9yK5SD1lcvKhwiUz8rkLs1gQHgDtrkil4MpcXlNPOnRDLwoRUN6QwpLaG+Ohgq1SQUGHQ/UfJs+Xya6rBjSt9JKF0NzLho0tgQg5owblCaieqR6MGFMBkFuz21U3pryz3mHYZSbYDy+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RfiQ/ZQ7; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RfiQ/ZQ7"
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-4af3bfbb721so57713137.3
        for <git@vger.kernel.org>; Wed, 04 Dec 2024 13:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733346902; x=1733951702; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=+dhyWSzcVnONy5q1yxmpplF52uEHTd94b1OFv1MWyHQ=;
        b=RfiQ/ZQ7cWcpvXywVBKheXalFHH1YBkd3AJqBZKvRzgt9Fp/cR1YpTChPL5Oh2r98/
         hv9ucVC3k0cJ2/rDA2u1giGHvcJP82ar5V7dMpi8x3uasfNZ7MgoPlUq8LsibUd02CeC
         FHSIYv4Ny7NAlSixXV045pu1YpAYBHZaHxvGOd2E5P/q1L+a5GMNZWml5uZm4ocLHU3L
         oEWXerCGumj1xZh6tHDBfsV1KRZa59KutrMHu4JRiG9HoQY/npluPs5uOu7fRo2TRE5h
         3yLgjyBKLVlN5Znd1Ah5JMrtY2E5uZq1QB4sGlNNrhR54ozNqU0acPDyNJSqEx3J7X2A
         zMdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733346902; x=1733951702;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+dhyWSzcVnONy5q1yxmpplF52uEHTd94b1OFv1MWyHQ=;
        b=UPWJK9g2QEKjwo7bol6SqixFbItMyc4PUblfxyxcONYWVR5BUxSQheGIbeI00maL5J
         d9eofpD9t3d5yzVeMoshKGNofDAp3VmbC9Jl2SSyCOWOKBCEXMwPzx/BCRtSQb4XVSjZ
         5fcJogJ5Tkh+tonpt0FQi+CkL4JbOOsGSK8QAdZX0dJ0Qgh+ZbpPIMct83x6TozbN6Dy
         29YHuMU4mFMqT7xE4VShTxbd670p+LYxzjeTByRcTCy+4fyU4b6AkKr+Nqi8RiroTuoG
         Pyf2/NGRdsPXKVTPnWudbQ0FI+thgkVC+lZ2cPRhNaBm1+dzbk07Yhvftvt75PzzdmOP
         qnOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMEv1GHNTT8zyN+2F0L041u7Z4EYGDwwNG1ki5laRzQZuxaJ7AaPGuShhg4CchKZkcdHs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz1S6cytowcdsUFF5eDhiO0UbRtDplHjbABS95EhzwQTG0jSB+
	lmCcHT4178DmG5Xzxm1Knv/DLtsEAocf2vimSnrHBJBAGHW69LJv8DnSqWVAiYYBrvzepSR8Rza
	lvEjA7OHbVWxUJ5DWvieg26hpVUI=
X-Gm-Gg: ASbGncsFOtgX6+91GJtZDhbzRn/kEWU/pzjIWv4hSbdqIEYBFCZoGmLoW80WKESll76
	6BqAdMQXNhdNChZJsRmScxHOG0YGZQ+F+ygQ+K17mwGAxFYnsVzWcwiyZpaLry4vZ
X-Google-Smtp-Source: AGHT+IEW7kqW0kUNYIHpNV3voK9y/DEbJCYZlLuQqj1a4eem4DeQYj3jtXFtKw0h5aKuass7+qQk+QfxV3x5SHZhi1Y=
X-Received: by 2002:a05:6102:2ad0:b0:4af:5b9a:3350 with SMTP id
 ada2fe7eead31-4af971fce54mr12286753137.3.1733346901739; Wed, 04 Dec 2024
 13:15:01 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 4 Dec 2024 13:15:01 -0800
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <1947d1bf448d71ccd4a44ef25751bab50784a73e.1733181682.git.gitgitgadget@gmail.com>
References: <pull.1823.git.1730775907.gitgitgadget@gmail.com>
 <pull.1823.v2.git.1733181682.gitgitgadget@gmail.com> <1947d1bf448d71ccd4a44ef25751bab50784a73e.1733181682.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 4 Dec 2024 13:15:01 -0800
Message-ID: <CAOLa=ZQcicLN462PFz_2sFeKKB0VvthPZhgwuR3CM0RSM6Y-Ow@mail.gmail.com>
Subject: Re: [PATCH v2 3/8] repack: add --name-hash-version option
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: gitster@pobox.com, johannes.schindelin@gmx.de, peff@peff.net, ps@pks.im, 
	me@ttaylorr.com, johncai86@gmail.com, newren@gmail.com, 
	jonathantanmy@google.com, Derrick Stolee <stolee@gmail.com>
Content-Type: multipart/mixed; boundary="00000000000059ef350628784660"

--00000000000059ef350628784660
Content-Type: text/plain; charset="UTF-8"

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

[snip]

>  DESCRIPTION
>  -----------
> @@ -249,6 +251,36 @@ linkgit:git-multi-pack-index[1]).
>  	Write a multi-pack index (see linkgit:git-multi-pack-index[1])
>  	containing the non-redundant packs.
>
> +--name-hash-version=<n>::
> +	While performing delta compression, Git groups objects that may be
> +	similar based on heuristics using the path to that object. While
> +	grouping objects by an exact path match is good for paths with
> +	many versions, there are benefits for finding delta pairs across
> +	different full paths. Git collects objects by type and then by a
> +	"name hash" of the path and then by size, hoping to group objects
> +	that will compress well together.
> ++
> +The default name hash version is `1`, which prioritizes hash locality by
> +considering the final bytes of the path as providing the maximum magnitude
> +to the hash function. This version excels at distinguishing short paths
> +and finding renames across directories. However, the hash function depends
> +primarily on the final 16 bytes of the path. If there are many paths in
> +the repo that have the same final 16 bytes and differ only by parent
> +directory, then this name-hash may lead to too many collisions and cause
> +poor results. At the moment, this version is required when writing
> +reachability bitmap files with `--write-bitmap-index`.
> ++
> +The name hash version `2` has similar locality features as version `1`,
> +except it considers each path component separately and overlays the hashes
> +with a shift. This still prioritizes the final bytes of the path, but also
> +"salts" the lower bits of the hash using the parent directory names. This
> +method allows for some of the locality benefits of version `1` while
> +breaking most of the collisions from a similarly-named file appearing in
> +many different directories. At the moment, this version is not allowed
> +when writing reachability bitmap files with `--write-bitmap-index` and it
> +will be automatically changed to version `1`.
> +
> +

Nit: I wonder if it'd be nicer to simply point to the documentation in
'Documentation/git-pack-objects.txt'. This would ensure we have
consistent documentation and a single source of truth.
>
>  CONFIGURATION
>  -------------
>
> diff --git a/builtin/repack.c b/builtin/repack.c
> index 05e13adb87f..5e7ff919c1a 100644
> --- a/builtin/repack.c
> +++ b/builtin/repack.c
> @@ -39,7 +39,9 @@ static int run_update_server_info = 1;
>  static char *packdir, *packtmp_name, *packtmp;
>
>  static const char *const git_repack_usage[] = {
> -	N_("git repack [<options>]"),
> +	N_("git repack [-a] [-A] [-d] [-f] [-F] [-l] [-n] [-q] [-b] [-m]\n"
> +	   "[--window=<n>] [--depth=<n>] [--threads=<n>] [--keep-pack=<pack-name>]\n"
> +	   "[--write-midx] [--name-hash-version=<n>]"),
>  	NULL
>  };

So this fixes the mismatch in t0450 which is seen below.

Nit: might be worthwhile adding this in the commit message.

[snip]

--00000000000059ef350628784660
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 9ce48eb60832f68c_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1kUXhsTVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mM1hWREFDRWt0T2JvR3ZGM0FWeG1xSkdTdW5Pc0FGcApqcnJHQ0t4bm15
TzRlcitOZVdxNkt3eUNNWTBoTmJPcWRSQ2c4MTFHVkxGTlJwTkZIQklFL05qZlFOWGowYnE5Cmxh
a3BjSlpEQ25MY2ROMVRKelg3QUpFeG9yanMyVUNjQVA1blkyNFA5Vmo0OG5YQkh6ZHBWZW02TEpk
bmVVWnMKQkhSTk9JQUN1T1hZd3hiblhvK2ZRY2pQT2prTHlhQmRpNjE3WEk5Skx4Y2pCWFU2TGo4
bW5mMEljUTY2eWlPSgpnZjhLNUtOQUtIbm9EMDRPbDhXaVFSOXdNdXg4NmxvcGN3LzB3cTJLSjFO
VXBpek1pTlhjTm9HTHFLVUZIZThWCm5kR2Y4L1FjRWpoek9uUG5GMmhVZkk4L1FGM2RQQjF4bFY3
blFBMjJpb085Z1I2U1dyditSUEhtNmNSR2lIS0oKandyWXFCT3MrZml1QVJiTEE0ZkQ3QmVXZllv
eEhwbURtYUpWQkJXa2JQL1lhY2hYOTNiWWZsNkIzbEhFNU1OZQpmUEtSb0dRbmFCS2JoNW1OVk1I
QUpNTEU3WnlGVTVLWHJpcXBsSTBNMU1QWlRkdjVqelFIUnNMUGZnNlVZc1R1CitjSU12emVUQ2tE
Q3hBM1loSDN4RXJxWkdwKzlEVm9aaUdWT050Zz0KPTJvejUKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000059ef350628784660--
