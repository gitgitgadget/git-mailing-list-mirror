Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE762F290E
	for <git@vger.kernel.org>; Mon,  2 Feb 2026 20:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770064055; cv=pass; b=E1YkbHRlg7rEakVflyvAhe+bj7xG77Wsr7mzku9v2Oz/Jz9k4bJPDmGJovDsVxJNwcZP6YrHpO/oHpzd2WEtHxNmvk9ZMkCjlyUXspCHSGEa8RQk9RbWnyBx/z/O1oZxubVz9jyByzjm3TmMO/Xv+wNYFBzGL1WzOziL9N9UUyw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770064055; c=relaxed/simple;
	bh=HRIL7eccAsPnWD94vi79OuwsYTn27829MjGFNtVuKwo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lru9gffGIFDYzmYoesFdOry/LEAFE+6oBuCwcgLWJa6+9LtAdByCfzTF4QPbTQT1RGuzkP/hr6rEs7mOYFOFe94d+ueUwypuyxoNqgf4C1zf2adx8uguqGRc4MoZOm5cMCE4pyWwnk9nj2UbqDUSDgiiNHh0V+8QJQwCSi/1mrM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zhh3gCaa; arc=pass smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zhh3gCaa"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c0ec27cad8cso1840596a12.1
        for <git@vger.kernel.org>; Mon, 02 Feb 2026 12:27:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770064053; cv=none;
        d=google.com; s=arc-20240605;
        b=VSg9Jk5ZERD8ja9OI6jWlJs/NotOqtxbfCU2pNUneoKW4aYu9InziK2SFCxBRP12OT
         lFgsDtbTEPUiLK8KvZn2sHS8AZ82Q79PuV3/NwbNVWymkD9CLfHaLv7iVCe+CDLlE27m
         uJhxDewMFKKcbXRdjCTbt5hNXeFn6nQOtu3/za9bdqjrZ+kSUjgh1TyBOWg9YR52XpDF
         P0v+2a1AAkaC6QkabKluBcERTk0WYUHLln8Avo+CFmCDcFZ9cNphjksCc1xP6wImRfMp
         RYH2DwtyN6lYuMY+1lIi2CYYwR2a1pUOWLDdyxB7dfPGGQyuyLBJyzFySyhES/un5n3O
         ohEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ttYmC3pAp+8MDvQ5OnwuV51Sav2veC6Wv4qn6ebYixE=;
        fh=9+c8rOkdYfwQUzgA2a2fehh41hVdPVj0SxMOVVwWAnE=;
        b=OScuJ0mx0sAhIQ/YgqJaZlpil7TIij/6q402ubjJ8g8mbzXGltToi3pjMPieiAngY4
         91iOFmg5ouIZNfICHMO2gbkAvHTxv/74xxV5zw+FLCa6deUjBH+/HdJ2hqatu0UaUVVy
         0oU5opkhm5DEjoyRd+RmlflHNUfxr4OnrzNBcdu4Cg0lxc61AimRs83zLReEn+NL+Mge
         FpVDLmWcNavMBfytSPfN4cWvC21xgIVMfJ3PIk/6ZivYmNV/XYcYMNP0dpIc2useK5xc
         IqfToPUimQCl3O/XVcoS+pbsjt2laIPUAJyQKgVhNSsns0zTiRVQyDvUIzXAB7WIXB3N
         lioQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770064053; x=1770668853; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ttYmC3pAp+8MDvQ5OnwuV51Sav2veC6Wv4qn6ebYixE=;
        b=Zhh3gCaagjKXnuz0YDugSNp3QYQx09RtXPbm0tIdlWU4pK6LHQK2TGuPUr7+tZOlKQ
         olL9QjBWm1TWCQdMqLGlzmOueCowzz65JwQKe1ZhXfZfVLIFjtsaQ0g2OMHLXc6d7mIG
         IWMUBKXloIgNMiAjZLAmtKvOBXWInJltVgAx7BqQk2dUhRtUZlJK7OJvG6oLSwiEjACz
         PwFwGHNvYdvWB0B6B9NuYUSkHrj2C+kDG/zrxar9s7XcJNrDdA49qom1D8OGt7qshIkj
         8Rt9PHdJtfNqexTcVSDX51bIF9SyAq+Xuib3b74IlaVYCKUmXVhHhUIQ/kcJwBVutnHs
         CDuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770064053; x=1770668853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ttYmC3pAp+8MDvQ5OnwuV51Sav2veC6Wv4qn6ebYixE=;
        b=VhOm/XeqLoEXheilWqDx5ZdKnj97fOrzeH5B/bkJ4E1iW3sfNSFcyYi1VdTUWdM+hX
         cNUCa+hH9kBH2QjCIPEiohBoXRlrGjkwcPTf0FZQcOe32Ts+nLXvMYnjxUg/JMobUssM
         4pX0uUPvYPFSE6VAJp1mol5WDSSzE7kTfsWBLYUSHtAl7ax2haPCS3aHdNn5yqxKBVjG
         twKOqPrT0plI6HLYkMRfn61m1/dxuMUZZEh7h17iig4fU0apeiaht/GDuhHpOqfy3hdC
         CRgSLPC7Yn6Oaut+YzfWpkWwqhZmlcNB9X1m/H/tnf0sFYxwfKbigC5sszKDrptAsBrz
         aVkg==
X-Gm-Message-State: AOJu0Yzi+7iHaLESXFJsEG9jSDTE7sE1Kuq8mGxQdRGTx+PJJ86FjP7f
	RY+3XYB0L8CpvDX652VjegkCW1iCVNW9zFwRpRKals/FUUQX/hIoT1BQoZ7l7so1Gq+TT4rX4HK
	K2UmEhgWV3UJ56YuG8+oH5IRRyopnG2s=
X-Gm-Gg: AZuq6aL+jUBHSXGeJaJ+eGKFUSeuUumUdtKAJJOleJRHvdTEL9bvPaS2MJsJh2Z5qov
	7aLQX5zUStJ3i6wcuQ0oNtOXoTqJW5O+dWNaZeAboc9GALefhTHyw7veM/+wHT0hfUjvxSNGkX8
	NfWu2dd/q/WyzrXgkTbbq1R4c8zwi9oJJsDc2FfOgw3W37gcplJ+y9qF2sq7IT99kHT95B1vym0
	Qxu67uMir3MKtmQFoJwfXtwS7Dy/YdbFuiseto1kkwbVQSIy73dUrDx6QmOxYJFM3V/vmMe6VC0
	U1lKERuqZyOtxq1Mm0cClO3izGrA3svHbZqH7qPLmHkOn3V9WV6wZxa+DavqXH7Iz5un
X-Received: by 2002:a17:90b:2dc8:b0:341:134:a962 with SMTP id
 98e67ed59e1d1-3543b3d6620mr11590187a91.28.1770064053519; Mon, 02 Feb 2026
 12:27:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <trinity-ed0884d3-098e-44be-aa1a-a96f664ce7ca-1770049279182@trinity-msg-rest-gmx-gmx-live-5dd78c558c-fv4g4>
In-Reply-To: <trinity-ed0884d3-098e-44be-aa1a-a96f664ce7ca-1770049279182@trinity-msg-rest-gmx-gmx-live-5dd78c558c-fv4g4>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Mon, 2 Feb 2026 15:27:22 -0500
X-Gm-Features: AZwV_QgL243KGbT4XBceVpGanpPHPQDZulX5fme9R8LHrm0z0Y40j7962ZuDxQ8
Message-ID: <CALnO6CCqwnTcQWSUBPV+o3OO=sMZJjj6jRuMNnBjV3F-dYx+0w@mail.gmail.com>
Subject: Re: [BUG] git log --graph --pretty=format misplaces graph characters
 when -p given
To: lolligerhans@gmx.de
Cc: git@vger.kernel.org, Pushkar Singh <pushkarkumarsingh1970@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 2, 2026 at 11:22=E2=80=AFAM <lolligerhans@gmx.de> wrote:
>
> Hello,
>
> Git can pretty-print a commit graph with git log --graph and a custom --p=
retty
> format. I alias some uses of git log --graph --pretty, to which I then wa=
nt to
> manually add "-p" upon invocation.
>
> When using the working command
>     git log --graph --pretty=3D'format:%h'
> and appending "-p/--patch", the output appears erroneous:
>     git log --graph --pretty=3D'format:%h' -p                            =
     (1)
>
> Expected output:
>       1 !    * d0c34d4
>       2      | diff --git a/git-bugreport-2026-02-02-1427.txt b/git-bugre=
port-2026-02-02-1427.txt
>       3      | index 5a83af1..2740fd4 100644
>       4      | --- a/git-bugreport-2026-02-02-1427.txt
>       5      | +++ b/git-bugreport-2026-02-02-1427.txt
>       6      | @@ -1,22 +1,53 @@
>       7      |  Some context-before line
>       8      | -Some removed line
>     ---      | ...
>     101      | +Some added line
>     102      |  Some context-after line
>     103 !    |
>     104 !    * 28299b2
>     105      | diff --git a/git-bugreport-2026-02-02-1427.txt b/git-bugre=
port-2026-02-02-1427.txt
>     106      | new file mode 100644
>     107      | index 0000000..5a83af1
>     ---      | ...
>
> Actual output, shortened, with line numbers:
>       1 !    * d0c34d4|
>       2      | diff --git a/git-bugreport-2026-02-02-1427.txt b/git-bugre=
port-2026-02-02-1427.txt
>       3      | index 5a83af1..2740fd4 100644
>       4      | --- a/git-bugreport-2026-02-02-1427.txt
>       5      | +++ b/git-bugreport-2026-02-02-1427.txt
>       6      | @@ -1,22 +1,53 @@
>       7      |  Some context-before line
>       8      | -Some removed line
>     ---      | ...
>     101      | +Some added line
>     102      |  Some context-after line
>     103 !
>     104 !    * 28299b2|
>     105      | diff --git a/git-bugreport-2026-02-02-1427.txt b/git-bugre=
port-2026-02-02-1427.txt
>     106      | new file mode 100644
>     107      | index 0000000..5a83af1
>     ---      | ...
>
> In the actual output, note the trailing "| " sequences in lines {1, 104} =
and the
> missing graph character in line 103. I believe the sequence in line 1 bel=
ongs to
> line 103.

Yep. I think this is because format:%h doesn't add a newline by
default. With tformat:%h or format:%h%n, the issue goes away. (See
"git help log" under "tformat:"=E2=80=94this is probably what you want in
order to get "oneline"-style format.)

--=20
D. Ben Knoble
