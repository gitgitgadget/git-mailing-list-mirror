Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23C12580CA
	for <git@vger.kernel.org>; Thu, 31 Jul 2025 20:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753993161; cv=none; b=VA9d5qs/tXcSgffLBNgZuR/7yJn/h6oCt1erYmx5D1SnLbIPd1fXrx6oJcW3XOigiCXUdk7ohSnGNKb2dlvwRj3wE7lAv5k8dIPofqhuBI0NIGBwZyoVQjhBfVozQ/CMi0Q9i1HLFiMCdalNoUy/QDojQ7OObAdOU0wIwm+I6Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753993161; c=relaxed/simple;
	bh=GoH8NdOyiv498dtiyFTxLd0EJ0dyaf96Q687CaA7hPo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mqvK+8bMa8bGQEkwFT0/kJGyl5YAbh3pIWqhGihPmeY3Dl23Xqs5H16gTd5hsEvUtEEkHvJjj2PFPN3B4yJ7tzI+/p4DXMRgLGMMDaQMFQQlKBnM2J8f4CEVQZjEbEarzrXau4xr2H/kZjJDD0nxTPbHO0lrubdBScqGT+sMud8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZKrmxJ27; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZKrmxJ27"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-3322bb2ac6eso7567221fa.0
        for <git@vger.kernel.org>; Thu, 31 Jul 2025 13:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753993157; x=1754597957; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pDl9WczJzuWSnc8TySHbEe/joTk0T3KOYdzQzkhIgt4=;
        b=ZKrmxJ27QAr3fDfVgxrcAPxk+Y42z1XFV4DOCeLEYUIO5AEzAAikhzuM5n2pPWlFsm
         OVzcqBwTGYXVpVQhXryDaarlT6OHE8R8AzeMoceZ7MNxWBysu7/pzsKYHCJcG1e9oZZg
         /vSUxJq2c1lefBSPCbacRncgcMpifKYZs8T2w2zqJOI1HAS5sFFMb8Mxha4hLKMXWEw4
         3D9ry8L249nq940JDIq/45Ed16cIcy1Dij3Ness3LLLsjcuD1/qBiimEENd11bCH1nlR
         AnyV6vX+djQob7yKJ37URFCMEc+UIrJHjbW0FjId3bqHXfv9cDgpuE0QwgDKBlmz/ewL
         8nfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753993157; x=1754597957;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pDl9WczJzuWSnc8TySHbEe/joTk0T3KOYdzQzkhIgt4=;
        b=RK8zVYYS/xlvgfJVOU8Y7IpFQAr0P7mK8GmWIxyAOw39hS5oo8IPJxusMhA+nj4bOq
         PHD9D5JqJu652GrHEk7pe1mhkux913yqAd3ii/e9ogTj4CUbEwrgYx2ImRbh4jXrxAys
         UZdC8HgKYBCqvHcuD9m79TWGCX4oahdbjH2lMtsxTRLBQ2NfRTF/8KcvcYQvCiC1/4+u
         HZgpFq3NCPeaJ+4wR8VojOxefveDgJMBTbkER2o0PUOuFQ0/r4zzVXsuAmMsLde3WiVl
         4HTDFxtTUrNIXaSv2MTqD7iJ6J+qiRSSzj+mdTvRDA457yVnCJgWC1N0uO3FY1iEm2MM
         aHJA==
X-Forwarded-Encrypted: i=1; AJvYcCVx7e9lxijJDpa4m35GKO2mRBCNJl92NdtAuGm7hU2KCa2snvWrMsHZ22W9U3kkVftvGHw=@vger.kernel.org
X-Gm-Message-State: AOJu0YykU7pyFdaGjwcPr0upiTHPLAwPWMEmTwRYgwI9GZ/7TnOqNb52
	lJhq6LzXUCRzQl+X4Q8NAsnBRtka5jw5siuhtzgmfzZL5XVlATrro9XWHzKWatjd/LrgXP7uh/u
	p0YXjqaRrVRv2bDjPCmuc3GWJYhnn7b0=
X-Gm-Gg: ASbGncuASS0/Nnjj3wYkB50I2vh//lKXFwHixvNpS/AxRP6AFwMUNETJxF//LcAnscn
	YVK9/BKxNLnc50ggnX9Rf4ZIzE8MJAtMZx8CRnSwqmd+xSOKorGStvp4+F3V5Ua2eA+PxxSqy8l
	PZxnHHkJFlSP33gsTNbDKANP8GKymS8PCldnLvURoFomNvS/OMsvkFasjpcxQlP3qR5QbpJM8p5
	zg0cCgld9szzBgB5Qa4pq34PI4jdtNfApyqf1c=
X-Google-Smtp-Source: AGHT+IEceVkCcsrNX4NH4xf9pgkPSEv4tJBvg43FfdmHJM9Q8/wEUAy0w28FRekk/tTmgGL9+S8rKzGtvmTpu4UlZOc=
X-Received: by 2002:a05:651c:50e:b0:32a:749a:14d4 with SMTP id
 38308e7fff4ca-332482ecd6dmr241781fa.12.1753993156606; Thu, 31 Jul 2025
 13:19:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGW8g7=21pPAgCixjpayEvmw_ns-hcB4e59NP476TKtCRXHPXQ@mail.gmail.com>
 <ZvM39VNFptcfwMGk@tapette.crustytoothpaste.net> <m0r097mv19.fsf@epic96565.epic.com>
 <ZvXMSKaUWWA-MG9J@tapette.crustytoothpaste.net> <CANgJU+Xs-sQgAOCPL-5skaZGq7eHmhg0MaFGDr8N57=CK67iog@mail.gmail.com>
 <CAGW8g7=xK0S-i_Ekfwwo_NjMbngO_5m4LERtWRhSCgA0vf+ZAg@mail.gmail.com>
In-Reply-To: <CAGW8g7=xK0S-i_Ekfwwo_NjMbngO_5m4LERtWRhSCgA0vf+ZAg@mail.gmail.com>
From: Ron Ziroby Romero <ziroby@gmail.com>
Date: Thu, 31 Jul 2025 21:19:05 +0100
X-Gm-Features: Ac12FXyVXCPiRgqfX6FWEwkGszNv5LtEiCi5P4wNurIN4_l8XTSRM1pU3AVzcII
Message-ID: <CAGW8g7mjJ8+aRkg5nf1c6CCAWTnxery86uLuN-9n3nt_VDaZvA@mail.gmail.com>
Subject: Re: Pretty output in JSON format
To: demerphq <demerphq@gmail.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, Sean Allred <allred.sean@gmail.com>, 
	git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> On Fri, 27 Sept 2024, 10:30 demerphq, <demerphq@gmail.com> wrote:
>>
>> On Thu, 26 Sept 2024 at 23:04, brian m. carlson <sandals@crustytoothpast=
e.net> wrote:
>>>
>>> On 2024-09-25 at 18:45:54, Sean Allred wrote:
>>> > "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>>> >
>>> > > On 2024-09-24 at 21:52:35, Ron Ziroby Romero wrote:
>>> > >> What do y'all think?
>>> > >
>>> > > I think this is ultimately a bad idea.  JSON requires that the outp=
ut be
>>> > > UTF-8, but Git processes a large amount of data, including file nam=
es,
>>> > > ref names, commit messages, author and committer identities, diff
>>> > > output, and other file contents, that are not restricted to UTF-8.
>>> >
>>> > This strikes me with a little bit of 'perfect as the enemy of good'
>>> > here. I'm sure there are ways to signal an encoding failure. I would,
>>> > however, caution against trying to provide diff output in JSON. That
>>> > just seems... odd. Maybe base64 it first? (I don't know -- I just
>>> > struggle to see the use-case here.)
>>>
>>> I understand JSON output would be useful, but it's also not useful to
>>> randomly fail to do git for-each-ref (for example) because someone has =
a
>>> non-UTF-8 ref, or to fail to do a git log because of encoding problems
>>
>>
>> I dont really follow your argument, and I find it weird how you are talk=
ing about a specific encoding of unicode instead of Unicode itself.
>>
>> It is possible to represent every binary string as Unicode encoded as UT=
F-8 (or any of the UTF encodings). It may not be bytewise equivalent with t=
he original, but why should that matter? There are a set of clear rules for=
 doing the required transformations, and there is a huge body of tooling to=
 do so. As long as you know the target encoding, you should be able to roun=
d trip data properly.
>>
>> IMO CBOR would just complicate what should be a relatively simple proble=
m to solve.
>>
>> cheers,
>> Yves
>>
>>
>>
>> --
>> perl -Mre=3Ddebug -e "/just|another|perl|hacker/"



Hi. I've been working with the code and trying to figure out how to do
this. I've also started work on a formal proposal. Two things have
come up that I wanted to discuss:

First, I'm questioning my approach of hacking pretty.c with a series
of 'if json' blocks. Would it be better to make a new file, json-log.,
and divorce myself from the pretty flow entirely? This would also go
hand in hand with changing from "--pretty=3Djson" to simply "--json"

Second, I see that someone is adding a --json flag to git status[1]. I
figure that argues for git log to use the --json flag. I don't think
that affects me other than making the case for this JSON output.

 ## References

 [1] Patrick Steinhardt, =E2=80=9CRe: [PATCH] diff: add --json output forma=
t,=E2=80=9D
message to git@vger.kernel.org, July=E2=80=AF29,=E2=80=AF2025.
https://public-inbox.org/git/pull.1937.git.1753856826464.gitgitgadget@gmail=
.com/

 Thanks,
 Ziroby Ron Romero
