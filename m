Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755CB40099B
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 14:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.232.247.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786114051; cv=none; b=hFdenB6rvapY/73aKAtHtN/0E8GSi0vLjCmLONtAu/NwiRiHS30lFDIXM4UAqlcabVGgXhxtpT/MThM/UxLwV7bdyY7XrnPviffpfC19oWaWbae/GRldsPRYWF9P+C2Ota+KhQdmAYy67m1+56SMXKgf2k5rJdolUDhBw4COzTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786114051; c=relaxed/simple;
	bh=d3h+cCRW9ig1TM+kMeQs9muCg/+nEng4oV5Q4c1J0gI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DvMmObX2Xac/TmR1MZgKEKLbCG//EuhGP70YGgfPSWxgMLbHIJnKXMwl8v4pkN6SOZlb1Gu3ONGyoltZtuYR3VWiXxCzRgZ2lE4JwfgpzpzxSQoA/z+VZxFCkD4cL2Kiw/012KRBOIxN5RdKIkzNzM9zNYMOSWDqvN1Ft4C2O+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi; spf=pass smtp.mailfrom=utu.fi; dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b=NgmXzxkS; arc=none smtp.client-ip=130.232.247.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b="NgmXzxkS"
Received: from smtp-03.utu.fi (smtp-03.utu.fi [130.232.207.30])
	by fortymile.utu.fi  with ESMTPS id 677EW1jm009005-677EW1jo009005
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Fri, 7 Aug 2026 17:32:01 +0300
Received: from ex19-06.utu.fi ([130.232.247.46])
	by smtp-03.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <taahol@utu.fi>)
	id 1wsLc9-00EK9s-8s;
	Fri, 07 Aug 2026 17:32:01 +0300
Received: from localhost (86.50.95.90) by ex19-06.utu.fi (130.232.247.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 7 Aug
 2026 17:32:01 +0300
Received: from localhost (localhost [local])
	by localhost (OpenSMTPD) with ESMTPA id 5db319cd;
	Fri, 7 Aug 2026 14:32:00 +0000 (UTC)
Date: Fri, 7 Aug 2026 17:32:00 +0300
From: Tuomas Ahola <taahol@utu.fi>
To: Harald Nordgren <haraldnordgren@gmail.com>
CC: Phillip Wood <phillip.wood123@gmail.com>, Junio C Hamano
	<gitster@pobox.com>, <git@vger.kernel.org>, Matt Hunter <m@lfurio.us>,
	Patrick Steinhardt <ps@pks.im>, "D . Ben Knoble" <ben.knoble@gmail.com>
Subject: Re: [PATCH v10 3/5] history: add squash subcommand to fold a
 range
Message-ID: <20260807143200.my1sI%taahol@utu.fi>
In-Reply-To: <CAHwyqnW-py0QZNWUikzYO3yyqrYWdZcHQ+axW41GMv94hHh0nw@mail.gmail.com>
References: <6b5b2c93f2e3e55bf456b86a8be61f5f85137a2c.1784536024.git.gitgitgadget@gmail.com>
 <cover.1785750108.git.phillip.wood@dunelm.org.uk>
 <CAHwyqnX8Api2VWqaDt4vgnG5P9RHGkK2Bhhi4dVAu7Qrh908rw@mail.gmail.com>
 <xmqqqzkevx62.fsf@gitster.g>
 <CAHwyqnXJLQ_naFb1RRQWS3eft0FXL7ripviSA15Zy5D6nvHGAQ@mail.gmail.com>
 <CAHwyqnW-py0QZNWUikzYO3yyqrYWdZcHQ+axW41GMv94hHh0nw@mail.gmail.com>
User-Agent: s-nail v14.9.22
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: ex19-12.utu.fi (130.232.247.52) To ex19-06.utu.fi
 (130.232.247.46)
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWkhZXkguLT4lWFxYWFhYWFBeUVxfSFhISFlbSBwJCQAHBCgdHB1GDgFIWUhaXEgACRoJBAwGBxoMDxoNBigP
 BQkBBEYLBwVIWEhaSFlcSFlbWEZaW1pGWlhfRltYSFBIWEhYSF1IWEhYSFhIWlhICg0GRgMGBwoEDSgPBQkBBEYLBwVIWEhZUUgPARwoHg8NGkYDDRoGDQRGBxoPSFhI
 WV9IDwEcGxwNGigYBwoHEEYLBwVIWEhZWUgFKAQOHRoBB0YdG0hYSFFIGBsoGAMbRgEFSFg=
X-FEAS-Client-IP: 130.232.207.30
X-FE-Last-Public-Client-IP: 130.232.207.30
X-FE-Policy-ID: 3:5:2:SYSTEM
X-FE-Hostname: fortymile.utu.fi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=date:from:to:cc:subject:message-id:references:mime-version:content-type;
 bh=IBoufXYF+1Vu0J0wFTnLCD1uOknJxJ/wtpvsQWOtb0o=;
 b=NgmXzxkSpHR3Otf0Xn9ZPl7AgWzcMnESyHHpNaaiV/wfZ8hr9HWsnFq3nhl3HDsk4cTlR4/rLMvO
	bdQpm9TLUuTIQXF0WE/EnM8DsKMKQlejqYxPJ5XIf2EyF+KEpSMIR+qZH7aRS35u7FR9GH6xlr2v
	BsccSuN/hD5WxrqenfNiQVEPgmdqACRkzn+BDNBKqV4azsNVC+fY20l6V1kIoyKToACSB+qmRqF6
	AxJIwJZpfW1aUC+VSgi/ypOpM3ENncaZdPRgbNOeSn7bjYGjJETTkBBAYKe6sJK1cF2W1+KnvjI7
	4s9IJzbOEfFQt7wPKrXalA4LIDpUx237EkU2kg==

Harald Nordgren <haraldnordgren@gmail.com> wrote:

> Btw, I have now twice seen this message from Google when using Reply
> All, which sends to Phillip's reply-to email, whereas mails are
> actually sent from phillip.wood123@gmail.com:
> 
> "Your message wasn't delivered to phillip.wood@dunlem.org.uk because
> the domain dunlem.org.uk couldn't be found
> 
> DNS Error: DNS type 'mx' lookup of dunlem.org.uk responded with code
> NXDOMAIN Domain name not found: dunlem.org.uk For more information, go
> to https://support.google.com/mail/?p=BadRcptDomain"
> 
> 
> Harald
> 

There is a typo in the domain---should be dunelm, not dunlem.

--Tuomas
