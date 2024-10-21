Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A97A1F4FA1
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 12:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729513640; cv=none; b=NfpnzUGuigDxRPuc6BGPppql37og4pyk8prFh1Ll0Klj8DrtVXH9z176jMjiRtmMxw4Kc1ej5NDhEccmjN5NsFGjyk8ak9grnh5tfv7fMLvimDP8Ymt3Fv3KEvtsOZiwT2JkDxzfIHWjmZ3e+pGohypy2Ty7Iz6YEqFAJ4o5kWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729513640; c=relaxed/simple;
	bh=AdE+y54u3oGqHz3YRTKW7ruzqQmCdBXBLLcMisYbZ4o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jq0RlB3LzAZc5HkfAfYVN83kj/qJES04n1oMK075TsESLLYjJVsin+5gYitZ1nUHWSEDCWYYeLM0qH41YuhzrMk5h1sFDyOVHO3cu8vjgpBs1LPj6sX+lJdu1BOAq1RSux5s8F/Amb4TJgJoWst6+zdgStMXUJ+TuqrRq4a8IOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hsdDtpGe; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hsdDtpGe"
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-50d2e71de18so1322991e0c.1
        for <git@vger.kernel.org>; Mon, 21 Oct 2024 05:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729513637; x=1730118437; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AdE+y54u3oGqHz3YRTKW7ruzqQmCdBXBLLcMisYbZ4o=;
        b=hsdDtpGexATaE7tQJSN/7gemOqKz9y7U9/yUU51od3BrFWjzAvfqTi+47PiwtvFJ+D
         fHZ6LCNQCMNXZqg6tp1zWFfl3hUhSTkjFrH50hxgyVQ4seKIO/RUhfAHwnU1JtS3inNT
         mSsn2yhUM2h59mrZO3YJS5ryFAEH+pPyjUrPPDVt1xmOtKUxE6CMqt1SMXq9X1pT6oty
         fwJxqY6qs073WgF2sCKevlEDSX69PC3mvfy8cgBLzxQObgipUzY8Nw+TRnq/hCi6bEAj
         igGA0DEXP1mD6hw77IjS4hY3rIx8CN/qga1u/VUzSlI4ypifVgR5Bc45Z6xjEoiEK/L+
         utgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729513637; x=1730118437;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AdE+y54u3oGqHz3YRTKW7ruzqQmCdBXBLLcMisYbZ4o=;
        b=os1Giznzy0CRyKmH05Chy7li55CLYxrUKMWjTVm57orD0U9izG9WIXhXdRC+lSDZVw
         LlLxgzyFLINcIOYdrDqanYkNv0+Rph1CyLXDo/eLEQB2bkOQbK5CkFFPzXQVD3EI8QEG
         9r95Xq29KLG+B4VzygnkLckZKyu9slKfn6PzXfGk89rlzIBHgB0ejvBq2nC74HaRdbqv
         K+nBuTdq2luyoalK4b38gR/CChkWtE+hl8m50Z2E42X81iofkW/g+UiIZ+Dc0R/NLkzb
         Va2DPB+mRDOGhmIbtElMXNmDqqJZM8XfAFpZSZr6XAAy6cxeLWnvTzvrnVsl++smN/tl
         2sCA==
X-Forwarded-Encrypted: i=1; AJvYcCXJX4k5hP8WTCTxKK2gKFX8WrOc+yyRxixOMoDJvu4k+HCr3LKyIhosPUxH1zC+OFJ+524=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSYctMLNngGwvbPSdA2UfunomIMgVWE/aB0d85n1V+ZqToanGt
	ijLSqFYmGgahWUwTImdW6MRdFHJZLAhuQROE9SwffXZBu1peH2fHNXdfl/8MrE+KGzo6rbBAkGk
	y3n37+Tl/rBzwiwlKO8z85sMQkhrxr2E1
X-Google-Smtp-Source: AGHT+IGOV2yKDceVg4B/23TQw+O6Gnbdk7oo7kvIizp/bZdq6N1iNwckZhHanazVl7rTwy9K7HQFVns+WkX+EwjJIqo=
X-Received: by 2002:a05:6122:2002:b0:50c:4efb:835a with SMTP id
 71dfb90a1353d-50dda02ffd5mr7676774e0c.1.1729513637140; Mon, 21 Oct 2024
 05:27:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1810.git.git.1728774574.gitgitgadget@gmail.com>
 <pull.1810.v2.git.git.1729259580.gitgitgadget@gmail.com> <c09c7b3df0d7eac3069cee45cddc49a76da2503e.1729259580.git.gitgitgadget@gmail.com>
 <ZxZHIk-gH0Onpt15@pks.im>
In-Reply-To: <ZxZHIk-gH0Onpt15@pks.im>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Mon, 21 Oct 2024 12:27:05 +0000
Message-ID: <CAPSxiM-wLZfA1+1zvfjW-PN=Zpjrgy3KR9c_jrb=we7vhvoUYg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] imap: replace atoi() with strtol_i() for
 UIDVALIDITY and UIDNEXT parsing
To: Patrick Steinhardt <ps@pks.im>
Cc: Usman Akinyemi via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 12:20=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wro=
te:
>
> On Fri, Oct 18, 2024 at 01:53:00PM +0000, Usman Akinyemi via GitGitGadget=
 wrote:
> > From: Usman Akinyemi <usmanakinyemi202@gmail.com>
> >
> > Replaced unsafe uses of atoi() with strtol_i() to improve error handlin=
g
> > when parsing UIDVALIDITY, UIDNEXT, and APPENDUID in IMAP commands.
> > Invalid values, such as those with letters,
> > now trigger error messages and prevent malformed status responses.
>
> The line break after "letters," is a bit funny.
I just noticed that I will change it.
>
> It would also be nice to point out why this commit doesn't add any new
> tests. I guess the answer is that we don't have any tests for
> git-imap-send(1) at all, which is too bad, but a fair excuse and not a
> problem of your patch. So introducing such tests would be too much to
> ask.
I can try, but, why was it not introduced before, is there a reason ?
>
> Patrick
