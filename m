Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5403A1E94
	for <git@vger.kernel.org>; Sat, 27 Dec 2025 10:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766830224; cv=none; b=bLWjzCAmxuUIh/BF8+q44kk0AMPknlgPTpCQyCA//at8eCPeexlGnCTipEHi4EnnZ9+5tb6puacSZsnE/TkLHmC/XFbecRrcOzgKZIhXbbj1cR0GRxed2TaNMBMmlR5qOhL3vtCcEl8l95Z7LxO9nMdhlFK6LfNuMh+ch0xiKWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766830224; c=relaxed/simple;
	bh=u2VLybbaMoDA4Ow/MoDMqo4N1JyQTPcHbLygXFmaxuw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lbGT+x1K8DQ5rh1xx758P41dOq5tRHgW46Ee4p1X4y65i74x7gLrzZUDCecuo9m4dS/OEBOchtMIQD4cinSyakGaLj0v0mFgcJd8C16IONC2N3g6F99a3fIEbvx3M9wKQ2aVXiKOPA3DpNGLHeiSLCSJy6xB6+yaa1RJwdeSU4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QNx5a6oq; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QNx5a6oq"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b72b495aa81so1309876766b.2
        for <git@vger.kernel.org>; Sat, 27 Dec 2025 02:10:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766830221; x=1767435021; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u2VLybbaMoDA4Ow/MoDMqo4N1JyQTPcHbLygXFmaxuw=;
        b=QNx5a6oqEBkoqx0qm4jnmxWiLERJOweX8r6c6uwbD43J5I/cnrc9Bv1pmlJvodhwNA
         v3ntTAqoV5FkSVxUaY8G9O18SQd9HKlDmvr1YygFPn1908hB/5gs8GRlqY6XchhUrxkm
         MjdkAobBY68+eRm4uvhPE6Yk0rxVXxSrYpwd1sLUssAAtgXn5/G7mPBie5Ben2DrRd8t
         f4eP6WGIfO1I5MFoyuP1x8TA/Y+gwqVqjTSd0jJ8aXzL+AqM9LtJYGU3VOcpIUStfjzf
         H7BnOakiWYZpHtYIgMQUzn+vD1ZvGsPED/5bTEk/CT6qA+BfGRKb5uwSETXVp4G9ZQUx
         NhNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766830221; x=1767435021;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u2VLybbaMoDA4Ow/MoDMqo4N1JyQTPcHbLygXFmaxuw=;
        b=BMW6vThDiQpuyCQJv++JSLSb9absDHLBn/bJQv2Gj8goRSPpcPKT1CZmj7yudKPBBm
         5FzDc3BHWuo1dESICVSvYoODK/K8vWiZr5whr3FvZhodM3H8gtrzNOmoy3VguUXbyZKv
         h1qufV7ZY0J1MR7vZXRHhjPwFwYFq3FT2fgPVQcYbvsp+tYovnGyK6wz+0zpJtaSdIAp
         7O53xTEATdV0L5qkNES2o6/3zPmiu5P4707FvQ08CXJrXwjIx448W8l9J2fQLM2U2HeA
         KIMBuhop46OyHE774/Bmv2pagBEvgggPAOcztCyke1PAPIexH93PdmhP2sB5G3Gn1ilU
         1T8A==
X-Gm-Message-State: AOJu0YyuunUZHGKsCgJV8CQLo5UGWC5k9FD+3KXnF7x5y3M35wr0nfPD
	qFBjcUv3bG13rwUO6GDrX5gsxp2kXwilBUcCmP2Y/gMUK0hgc0g0HYgz64V82Nibs9fSo03Pf6T
	OYILzanxi/2ybIzbD3iigggPPLnANtcQ=
X-Gm-Gg: AY/fxX7EDD2vVwDMfkNSVTnFqtnxlRzDR6/tXXpLNmekRV9jy8vvZtdOUrqrE/kGW1v
	xvTjxdR+37Idwsk00LXfkJVnNobOsiOmfXDrovfu9M3gOjJX+UAMocVIkTR9DDQIa5zHYP1BViu
	Xk/5D9CxKraMU5PrI7RIYp25Z4i7T2+qoYFdF3Hn65tfqOL9xNbkh9NXtIqOPQVfElRYF6ekjEX
	J6vw8gTx3YK10HJ+ZC5mYNAa8O7MFnYCc3C3ftCK5nmBz1FrBrabppK4rNDeWu16BK6+6gLc3tO
	ZB/H3z1qvPsmVhVojCdxEvFFJH8t1ZHMOgQ9Xg5xRJ9877bBkJcKgt5+
X-Google-Smtp-Source: AGHT+IGEzs1bw+Ro8La8t1bgaeZNPzZwMuhN3Y7guceLGNERFm24gSZBZFQ01MX/sqoyeoC3g3m0+xf2gvpdxX/0wCo=
X-Received: by 2002:a17:907:7f8e:b0:b76:eec9:a1a9 with SMTP id
 a640c23a62f3a-b8036f34039mr2421484366b.7.1766830220763; Sat, 27 Dec 2025
 02:10:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAG7UgERJa8ktfetWty6A_0VL=s=yzfi-y0mLEta-NvQcd-0aDA@mail.gmail.com>
In-Reply-To: <CAG7UgERJa8ktfetWty6A_0VL=s=yzfi-y0mLEta-NvQcd-0aDA@mail.gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Sat, 27 Dec 2025 11:10:08 +0100
X-Gm-Features: AQt7F2rLmHIwQrtPDLz4mnEt6Rvp3cCbaP-_xOc1nJDCm5ioJH-5Y9RuLVvew-Q
Message-ID: <CAP8UFD2pTOQVU58dMsix6GjWCygskXtCM_6EN=A4cMoscgdV+w@mail.gmail.com>
Subject: Re: Introduction and interest in Git - Deveshi Dwivedi
To: Deveshi Dwivedi <deveshigurgaon@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Deveshi,

On Tue, Dec 23, 2025 at 3:45=E2=80=AFPM Deveshi Dwivedi
<deveshigurgaon@gmail.com> wrote:
>
> Hi all,
> I'm Deveshi Dwivedi, a fourth year Computer Science undergraduate from In=
dia.
>
> I'm excited to be here and wanted to introduce myself. I've been
> interested in open source for a few years now and have contributed to
> a few organizations in the past. I'm currently exploring Git and would
> really like to start contributing to it, particularly as I'm
> interested in GSoC 2026.
>
> I have been reading through the documentation and the "Hacking Git"
> article to get familiar with the codebase. I have set up the
> repository locally and run the test suite successfully. I am hoping to
> start with some small contributions and learn along the way.

Thanks for your interest in Git and welcome to the community!

I would suggested starting with a few tutorials like:

https://git-scm.com/docs/MyFirstContribution

You might also be interested in the following page if you haven't read
it already:

https://git.github.io/General-Microproject-Information/

Best,
Christian.
