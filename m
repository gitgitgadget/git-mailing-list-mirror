Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBA734F488
	for <git@vger.kernel.org>; Wed, 11 Feb 2026 20:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770840913; cv=pass; b=ClQ/j7aUsFaAzMFAtCVpXhzt6p0Ja3/M6MzROelyQUJ5fUWwu9oy8n3QKvFFuKUNfG0JgwQglmyNkQW6CrEseqqdbwjdZwAwqb4slQ8xymb9s466eCfX60M36FherecYQdKSWvz4NET53AjQdR2PTD7MbvHKfHh7LzgMlv7hvMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770840913; c=relaxed/simple;
	bh=uaxx4hJ8tR+UZBhFdFay8ZzxobATmkrfmmxouAWGp/M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BBihwj5Fx8f90FQhAlFDTt/T9FF0K/ZjKaAFvDO9tJTjUr1qO7wh1Gl21x2fpf74CJ6NF47HUpOgmLqYmnSo/KQPebSGE6yNgMmvbMZxNKSLJb/PmCoYVeH1u58OHuTGPEmnRb5xCaQ/35WzTZala2ZkNP67uIPyjTY/c9ztt98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aeTFqpm+; arc=pass smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aeTFqpm+"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c6e23cb81f4so279504a12.2
        for <git@vger.kernel.org>; Wed, 11 Feb 2026 12:15:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770840912; cv=none;
        d=google.com; s=arc-20240605;
        b=VI3Xt3umzmHami6ZbsN8wOUW5ZF2xllRPuCHXv96T9lWYoCHy/r2mHX0poTC/5MwMb
         gdegY/3+qp3F6sAl/8Sje9jh/mcdf1XH1hiJ5C6DXoqrdKxLkxRq5jEStl5OmsWGQbhS
         +8D9hCTQIcWworIEXgK06i8VB3CKSBMMTdyhiAo8U31v2+4EYznMJ/TpfQ9elztDj2wa
         CBEowxD03t24u6Mmftej9q4PVSlYax6kfur3Se5jB/lAawR6gmcTUWXjHRRPC+q3nDvl
         MSTe2FOIN8IlKeQHjEz/DjVmK0/dJl7oUrpgKhlWlqtPzdcSMWRnV0PvbsIstorXQrjh
         0EFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dPfLM3Mzx0Vxb6JMRx8WMOoDwZgT+1f8rEljWqjN5qk=;
        fh=sY0qntvYIGRE+D5nQFUxTPRB0Kai1WvBDG1o4g6CRC4=;
        b=UFrkbLTlFaaLRtExQgmtSxmk4wac0iL5Be3dgAflqrNrHibu6aqz2THdy1Obel2j2O
         2nBYr+ePsMs1pcG+4e71t0/3mKYGXJj94+BpUd8dA8KeTExcaJ3x+MYJ3fT5riWELc/F
         dGbSnvluf5sNPCrcFaQ3SQ4NCZNsLOc+8g0dd0UavuwpeWmyeGrhc3eQ32U56s5mmSAj
         8SJ1vMoJtYIj3p60cfXY5XjqOJoO0/OA4HS6DDLMmm+3bd6Ex/SxnoS1cDq4heBBiHIC
         EUwllpxTsHQsyZvM2ZpdEDzKjKptFbynqhGVimrQA0fAsmzuAAUekepmANjbRaOXDlck
         8emA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770840912; x=1771445712; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dPfLM3Mzx0Vxb6JMRx8WMOoDwZgT+1f8rEljWqjN5qk=;
        b=aeTFqpm+PC4+AZ/oJdipbKxlQGAHCkEe74MlgvvyOWEt5SnCj80ybFny63yu15LcHI
         IWQCBFbKoNqUZ17RS/3avMVazLIeBVhyV++e65hjwuLTwqSA2ZxTApMjn0IYaH0w9IoW
         40P6OCpSw6qJiy1CzipmmFn2qdE9xHj2rx/ZX76RUUG4p+4ob3pRB3c7FCHFhYu5Gs4A
         IWviW2z8dITZ38Bt/4w2QwqWVLT+isUxRKNtXZrRyvdkfGIRSNXA2QM8VqDiXSqHX+tZ
         Isz8j3M7T8Lj7vPDupA7+9xvVHVB3+G3QY24ysCI63EJB32Bs6oNBP+xJbZXzlNf8d/h
         5g8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770840912; x=1771445712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dPfLM3Mzx0Vxb6JMRx8WMOoDwZgT+1f8rEljWqjN5qk=;
        b=MDob3bf/20UEDLpINyehXgyicz8VV3Ol9I4ZS1WIrK6Mt8nJGLDx5rT7GoBczxsobR
         WIBZEv5eCltDz12YrjbmD9PFugfczo2WBYHFPLapPC+EiMQAJjQqllahPSCtlCIB+mjf
         V1S9xpXG3CATq/VXZIBSCVEbGGEVf4nFL4jxTnuY8uS4hsd2uATlFGWpisrx9ZxmAiQ8
         YflkMPxk69uD+YIq6zU+O/t29X8ihDGztm8bGdIgJeh6t9PprkP0k1mc7eWaLyYLRPPK
         k11Xlq6US0at3vdy11tFp6Tguxn5yg1ZH45RWGfnb2+QAFlO/2BMP8U302QzQ3VuZQhe
         zLew==
X-Forwarded-Encrypted: i=1; AJvYcCXUm005Cfh8nXLwA0dEaUJ1Br9b1SBmXKjY3qv7zQ5et8bRf4+mH3XdbEQwbZmu8PN5JpA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqbsZsIPYC5786+6ecBqBvQ9kkSg53IggDy8vwaPSpZgPwYz8U
	XYr/oRewoYPjWYsZqaTn2lAzj67vFfKQmCGIAvUSACcvn1XBqaWymv33V+vypgJMhNVyCVTVQqd
	dNTfZmK0TpWPWBoUUuoELhEPX1JM4YZA=
X-Gm-Gg: AZuq6aLgrA1PWLsWwc8jtxcbR78CNdKAxsLwPiGHHbuSopMkfpx6AKt2CvvqRxHLKJt
	EBM914wN1WAuWPNEgoKr3huk1CHrRboSJW41jJm8uSEDvWM8+leLSrEbgJCPhgmLAgh6/k/Jux+
	BpMhL1ciiZIWLobRpgMCl/UAPk+9hnK2S02wXJd2Rpm4rdOqwReWJBuV9sd66Am5hTmxEgcr7x/
	qGhau678TiNMCeYu4/TXQYZgfAsuDW9RVJMBgZst7KpWkdLwh+wkjiUQV8UTx9v3MJ0cq3NAKZo
	ZHEwsoQb9jJSZCvbZD6j7qpcBd0nVTl69LNw14yeyM10yUhkqE+uJJj+LPFnKAQiTDmd9Es2ZNR
	6RzCN
X-Received: by 2002:a17:90b:58ee:b0:354:56fc:b721 with SMTP id
 98e67ed59e1d1-3568f2be833mr548744a91.8.1770840911855; Wed, 11 Feb 2026
 12:15:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aYn8XKv2hH2HX2xO@pks.im> <20260209215015.25867-1-ben.knoble+github@gmail.com>
 <aYwzAt-dugh_acj9@pks.im> <4a566010-821b-4078-9563-9ca00ada55a0@gmail.com>
 <aYxguUQ6A1cuphCe@pks.im> <171c0724-7891-41d7-8a70-94fbbf8b43b2@gmail.com>
In-Reply-To: <171c0724-7891-41d7-8a70-94fbbf8b43b2@gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Date: Wed, 11 Feb 2026 15:15:00 -0500
X-Gm-Features: AZwV_QjJO2qRLzAdbHiII8YbOMZSa9M_59oUxx1AThOX0VGnh-rHpam3GIIhqrc
Message-ID: <CALnO6CCoSKKxFZVPbWpTdxkW0xfxwZgJNv1wS2Qz7GGhAKkeAQ@mail.gmail.com>
Subject: Re: [PATCH] meson: regenerate config-list.h when Documentation changes
To: phillip.wood@dunelm.org.uk
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Evan Martin <evan.martin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 11, 2026 at 9:05=E2=80=AFAM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
>
> On 11/02/2026 10:58, Patrick Steinhardt wrote:
> > On Wed, Feb 11, 2026 at 09:44:48AM +0000, Phillip Wood wrote:
> >> On 11/02/2026 07:42, Patrick Steinhardt wrote:
> >>> On Mon, Feb 09, 2026 at 04:50:06PM -0500, D. Ben Knoble wrote:
> >>>>> On Sat, Feb 07, 2026 at 04:59:17PM -0500, D. Ben Knoble wrote:
> >>> [snip]
> >>>> Only, things are behaving oddly. For example:
> >>>>
> >>>>       =CE=BB meson setup build2
> >>>>       =CE=BB ninja -C build2
> >>>>
> >>>> works fine, but
> >>>>
> >>>>       =CE=BB ls -l build2/config*
> >>>>       -rw-r--r-- 1 benknoble benknoble 17169  9 f=C3=A9vr. 16:39 bui=
ld2/config-list.h
> >>>>
> >>>> I don't see the dependency file.
> >>>
> >>>> Further, re-building seems to get stuck (I get
> >>>> similar symptoms if I add or remove a relevant config.adoc file, but=
 let's keep
> >>>> it simple for now):
> >>>>
> >>>>       =CE=BB ninja -C build2
> >>>>       ninja: Entering directory `build2'
> >>>>       [1/28] Generating GIT-VERSION-FILE with a custom command (wrap=
ped by meson to set env)
> >>>
> >>> With "stuck" you mean that it doesn't do anything, or that it doesn't
> >>> actually rebuild?
> >>>
> >>> I guess it kind of makes sense that a new file wouldn't trigger a
> >>> rebuild, even though I would have expected a removed one to trigger o=
ne.
> >>> After all, the dependency file only tracks the set of _existing_ file=
s
> >>> so that we know when to rebuild, and of course the dependency file on=
ly
> >>> gets regenerated in case any of those files changes.
> >>
> >> If anyone adds a new file under Documentation/config/ they will need t=
o
> >> update Documentation/config.adoc which should then trigger the rebuild=
. That
> >> rebuld will then add the new file to the list of dependencies. If they
> >> remove a file we should pick that up with the dependencies that are al=
ready
> >> listed.
> >
> > Oh? Well, if that's the case then the additional changes should indeed
> > not be required.
>
> I think so. The only problem I can think of is that if you delete a
> file, build, restore the file without changing anything else and build
> again then config-list.h will not be rebuilt because the deleted file
> would have been removed from the list of dependencies by the previous bui=
ld.
>
> >>
> >> It would be really nice if we can avoid regenerating the depfile with =
every
> >> build.
> >
> > Agreed. So maybe the first patch I sent is sufficient after all?
>
> We need to add the script to the list of dependencies and reading the
> comments in
> https://github.com/ninja-build/ninja/blob/master/src/depfile_parser.in.cc
> we should be backslash escaping space, hash and backslash in the
> filename when we write the dependencies. Apart from that I think it is ok=
.

Re-reading, I now see something actionable:
- use Patrick's original patch
- add the script itself to dependencies
- quote dependencies correctly

Thanks

> I guess the alternative is to bite the bullet and list these
> dependencies explicitly as we do for other targets.
>
> Thanks
>
> Phillip
>
