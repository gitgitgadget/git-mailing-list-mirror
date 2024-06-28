Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7963D17F8
	for <git@vger.kernel.org>; Fri, 28 Jun 2024 02:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719542312; cv=none; b=S8vuTzYSt+ro1RD5D9x8huJS7iFUcILRkKt6diFaeBQoqq7f8it8s3yWqwJszJ3CvqtKbbe/D/UUN5NQvE94+zTbQDmLZ2wBtg/xkYwgujG401ztkgDYIdRfhyjBdeJDKW8p9bk095fmVxBtF3zk0Z2q1FLSNskeXcX5LGVI3Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719542312; c=relaxed/simple;
	bh=e81RfO0Cpnsg0nzVstM8IGhFp0+WcPdRsocGy7b5XYU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JmbF7VvB4CvagkzeGrLZFKRbmqkKbK8oQTCmJ8fDRcnrKYaNiPP6QD9LB1yw5X7xhiIrpd5UIbY6YLhXQw4DbZk8VZkO0La6U00uVvospCyqbG8HSyCt1ZPPSRzwV+tniRLMTHbvqcKQAALs23wmjnIqi/bh1SdXxUNhZKkltfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lxCyVo/G; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lxCyVo/G"
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7f3d3919a4aso3341439f.1
        for <git@vger.kernel.org>; Thu, 27 Jun 2024 19:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719542310; x=1720147110; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NbEnSPkA8z6Br3f96+GJUwGxGZ/+//2Q55+Gu1e7e8w=;
        b=lxCyVo/GF0aLyI9OekSur3aykuV5j/NMXyWLY2LSEN+5m2kBs1GvFUM+ufZF9p6fsL
         iRIXXRC0KFydPifzZeYXPQbUTrst8hrkXVH+VHzv2+Kn/56zeyh8IhHjOc2+y4mUENCj
         GjtVJeQ8FPw2F0uprtcI5CsSj5UkVag9xKRmOt7UVI5/FRqAdw71UnHiSdE01+N0yfOi
         nsQmVb4u/q7LLsIBb0ePofKIBD/lShPFOAbE5FWu1UtHB9E0iHwmgZBt26oZe6Xc3WSX
         JXVYGsU5bB3W62n5BWPDSpVI/pxJW+P8TRWtPtaUrDVub5oAC0J7JH5WkYp3W36T51TI
         74xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719542310; x=1720147110;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NbEnSPkA8z6Br3f96+GJUwGxGZ/+//2Q55+Gu1e7e8w=;
        b=gQwu2gh4hvDn44SwY5i+pohIOC0O5yiUVbLbz7cWKLUVMgxCyVB+FNDQ5Bt2kVnxx5
         yGXYmiL6y49LZX6lw7KAjiUm8w13EoTk+O+0X7t/2un/UlUveR6ffud8A59Wtn2sPZAz
         A9+0je/CrT1vIn3X7Sr0fK4mrPNm75+YOAzudonJo8GKoP3VHa7/hsY6lupGObtT8+zo
         3GPgd7dBaQmMDUdBd49PhznhqzGuNIwdxLUVlIxP9IRodQSeHceS4jBD+ztq5hMgArf7
         dy8T+BxiQWO3rm7JDJBugmzjnZ5078LCnMJnMUevJfy1naaYzaU8Ds9XweZDduNkpcV4
         hCVw==
X-Forwarded-Encrypted: i=1; AJvYcCVClLMlPSR2ip0qVW5qBCEUxSUxm5/UAvIw/jUYxEIW9sA7APaFV3b4ZX7VCJ9bIMQVAR9yOvGRCU0XKvRhC2/KGh6h
X-Gm-Message-State: AOJu0YzQTGsYL1k3eVZSOuwLM01ULhAEpJ6tBCXQTWo10ad/GSmUGubf
	zfodzlBICm7aFFl7EkRMaVMm8B7QR+oiZC69QgSiyOopfgvFG+2duHzJQL3AjSyyqmnJiY7p4/d
	0goADgoEOR/qamrIKihYpJDnHfLw=
X-Google-Smtp-Source: AGHT+IHCIiayFyVxy2aEHsSHHzfk6lkjgTaaGbmn92Fro1XiXzqqPCMxakQcSrsVwAQ+SmaWd3eDmFxX8WiJfQea35Q=
X-Received: by 2002:a05:6602:6b89:b0:7eb:dc70:979c with SMTP id
 ca18e2360f4ac-7f3a4e68497mr1847100039f.21.1719542310514; Thu, 27 Jun 2024
 19:38:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1748.git.1718310307.gitgitgadget@gmail.com>
 <pull.1748.v2.git.1718766019.gitgitgadget@gmail.com> <2813a15b48b70ead7e3fd062d1b49baee665fc9d.1718766019.git.gitgitgadget@gmail.com>
 <63caecb4-19cd-4b6f-91f0-bd00df2ecb54@gmail.com>
In-Reply-To: <63caecb4-19cd-4b6f-91f0-bd00df2ecb54@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 27 Jun 2024 19:38:18 -0700
Message-ID: <CABPp-BHgd1Diqaiqc+a+UinHb947iwEx99cpVFqckUGXjmGVsQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] merge-ort: clearer propagation of
 failure-to-function from merge_submodule
To: Derrick Stolee <stolee@gmail.com>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Taylor Blau <me@ttaylorr.com>, Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 7:12=E2=80=AFPM Derrick Stolee <stolee@gmail.com> w=
rote:
>
> On 6/18/24 11:00 PM, Elijah Newren via GitGitGadget wrote:
> > From: Elijah Newren <newren@gmail.com>
> >
> > The 'clean' member variable is somewhat of a tri-state (1 =3D clean, 0 =
=3D
> > conflicted, -1 =3D failure-to-determine), but we often like to think of
> > it as binary (ignoring the possibility of a negative value) and use
> > constructs like '!clean' to reflect this.  However, these constructs
> > can make codepaths more difficult to understand, unless we handle the
> > negative case early and return pre-emptively; do that in
> > handle_content_merge() to make the code a bit easier to read.
>
> This patch is correct and valuable.
>
> Would it be valuable to go a bit further and turn 'clean' into
> an enum that reflects these states? Perhaps that would prevent
> future changes from slipping into this mistake.

That may make sense to investigate, but I suspect it may be a bigger
change and would recommend making such a clean up a separate series.

Also, I'm curious if it makes sense to finish off replacing recursive
with ort first; as long as recursive exists, it has the same problem
and in fact was the source of using a tri-state 'clean' variable and
thus would need the same cleanup.  But if we replace recursive with
ort (making explicit requests for 'recursive' be handled by 'ort', as
originally designed and intended), that cuts the number of sites
needing this cleanup in half.
