Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF002E0B5B
	for <git@vger.kernel.org>; Fri,  5 Dec 2025 17:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764957196; cv=none; b=u9HlEVQN7VdvGXkZSQzwsUCrjFEZDLK6ILvGE8XL3cDPNBMg0oxOvrUpDulgmzO/MPw33xE9ekP304wbc2KDH04+S7604Dbq8XOB7pxRj0pzgoelIyNL1OGt85ExfDooQehfH9fndMG/gPatH05lAHCbP8cf8V13K4lnlZPwG6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764957196; c=relaxed/simple;
	bh=tryZP9yDlgcnkWtkW+ZwE4rolRv6AA3EFyIpKn4KvBA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bvB67fwyQeX0VUo8dsiqEoCY51L4+d8d3YFYlCPiuE2pEkh56SmaThRTkMcCd/RWvbHRXcSkp0Ly6dNHDG6N7f7NbYsTFXOU47nev/q6r0XLxNbHucZSVPRSR0Y50r8zytHNuJVTdVl35ohCR5BgDwPnZwyfeSVt+A6KXybSQ9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nqPJFohm; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nqPJFohm"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7ba55660769so2117650b3a.1
        for <git@vger.kernel.org>; Fri, 05 Dec 2025 09:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764957195; x=1765561995; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tryZP9yDlgcnkWtkW+ZwE4rolRv6AA3EFyIpKn4KvBA=;
        b=nqPJFohmPnTiZZEfnAIrkNFB6yCoO7VS23tr3VxI/Q7lmkFl0guwLbAk7FVmKyllze
         gdACyKhyYp5+GmT+237ukfzjX3LdtJPpa0n7bpYeBkEIBCjeHjSm4+1s6fV0UrHnZDyk
         JCpTxRVo5TWXUxqb6ewLXIwTA7cSn9AufH7v+5L6p2jML9RcWyF/SjWkBqehTAGuIfmc
         4hh2BDffzFJWPPw2GexL9vUGX27rqAaZY5gZ2ALIi7k09aHEC6PXXzGJBltm/0ADoiUv
         sfe3yzsvsQBg7pMp86fH7Yi4b8m4y09v4Ke0HKqWR7zY2grVrMOLgrZde78gbfhtviKe
         UvPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764957195; x=1765561995;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tryZP9yDlgcnkWtkW+ZwE4rolRv6AA3EFyIpKn4KvBA=;
        b=WTYNEGN+C5a4NNTLlJqwaNDvvPlhZrllpRNOo/33U6lg2fcxtkVWkQU16iyYsFr3DS
         xcmBeORufVr9TeisaQjYEmb0vLstmX0/arQssWD0AaV6+1Hi1ZSaFm5G4oJYeFtZ9kJw
         UOEV/yONidcYLMsx1F3orvWfYMkhXL5rDOnQtyL35hRXdh2Dr+qgBleiuJZXncOS5E2g
         9APTqqssm3tu2lxWIKZbzQS2Ot7pt2jN+CZqTOoapc9w5maiijw0BQCd25e/NrLvfCTX
         yorhHJ+HSIOKI1ihsjnx8OndIrlm3HXY2NNYgKrDOdYzsX00IBpUksZhceNkz/Rg5l/g
         xiWw==
X-Gm-Message-State: AOJu0Yx+R/3BqJ4tcrYiXBM3tpTiQx0hDIeJfSsViNgYtmY7lLlJI9Dt
	u7srsBhGIe+aFYYEaE9b3fAoYKnPaij/HxUVRXXYUsDzQhVJCyONjWJaa1z9vfpObiRz03nwBT7
	Vy0aru5ggBEYJkXIdVvotKHavGgWfpic=
X-Gm-Gg: ASbGnctzxGimliApw15k/exLCNXcdgqCoxY5bRrWYCZ8UzGr68N7VbARgkxI/nLL5Pj
	JhbZAmsTtdqpgZHLdzT5BKaX/ehVlHB6xyuLwt06CgYpk1H1uKMRUZJk/d5kZkuY1euO6SGFfCv
	nZuAG8FS/gJ96pd0dRXdbx2/vxi1X9+J/YiPtW0lYDSBIQoBh6qrVkINwhl8J9IQQJ5NW+Za4IO
	XYnZmI2qtnTNsMy0Ef+4ODNJk4ZhTxT69V9Pb3aulqp/j4OaSfuAvXF1SgPY9naFQpr
X-Google-Smtp-Source: AGHT+IGH3M/0qGxlEviq6fqDlW0vYB+FCh/CnzKyUCrgiljf2MEcPvC+xgLnXaLgK4ZQbfrkImboqe7A/cb9wDF2k+I=
X-Received: by 2002:a05:7022:6b95:b0:11b:95fe:beed with SMTP id
 a92af1059eb24-11df0c3d4f3mr7641765c88.38.1764957194590; Fri, 05 Dec 2025
 09:53:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAD=f0L_-b5d5qVdL0TASS5iA8rWQxianT4_2zmhMtwN8p_TYbw@mail.gmail.com>
 <0D20055E-51C1-4503-815D-F7B4CBBF4C1E@gmail.com>
In-Reply-To: <0D20055E-51C1-4503-815D-F7B4CBBF4C1E@gmail.com>
From: Bello Olamide <belkid98@gmail.com>
Date: Fri, 5 Dec 2025 18:53:15 +0100
X-Gm-Features: AWmQ_bkzLvP3p7SKnYD28UzjOnWUmxx261PJvAdmYOy7096HdE01813_hVhKHgU
Message-ID: <CAD=f0L_zYNYnhmMv+g7=gkSg6Eaf55nm0NrerNL0KGgf1tf=+A@mail.gmail.com>
Subject: Re: [Outreachy] Git Internship: Refactor in order to reduce Git's
 global state
To: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc: git@vger.kernel.org, Usman Akinyemi <usmanakinyemi202@gmail.com>, 
	Christain Couder <christian.couder@gmail.com>, Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 5 Dec 2025 at 10:28, Kaartic Sivaraam
<kaartic.sivaraam@gmail.com> wrote:
>
> Hi Olamide Bello,

Hello Sivaraam

>
> On 2 December 2025 3:10:15 pm IST, Bello Olamide <belkid98@gmail.com> wrote:
> >
> >I write to you with great joy, humility and gratitude to have been selected
> >as an Outreachy intern for the December 2025 - March 2026 Internship program.
> >Working on this renowned project gives me the privilege of working with,
> >and being guided by, some of the best and most impactful engineers.
> >
>
> Kudos on being selected! I hope you have a great learning experience :-)

Thank you

>
> If you need anything / have any doubts, always feel free to reach out to your mentors (or) one of the coordinators:
>
> - Christian Couder
> - Taylor Blau (in Cc)
> - Kaartic Sivaraam (myself)

Okay I will surely do that.
Thanks.

>
> Cheers,
> Sivaraam
>
> Sent from my Android device with K-9 Mail. Please excuse my brevity.
