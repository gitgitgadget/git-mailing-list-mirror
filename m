Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6922A285418
	for <git@vger.kernel.org>; Tue,  9 Dec 2025 16:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765296209; cv=none; b=S+/Jee/lfAUmNC7iCfuTXfFKquD1O2rDA7EJ6QMx2DVCFgChykUZdiNwDD01QWPSV+y26h+bZOUk/QrWeANns8uuud3OJ3uB7BvHz78cpADXjKRu9SrUa/lJB5Tw+oGf1bMGlwwdUQHz1pqcpZTLFUoH1aHRZsfFvkrYonL2fwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765296209; c=relaxed/simple;
	bh=Uw9HUlgwDiKPRcubAYg2Mk0J6SWw+u7WH3zaXDtUitY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZfAKFrKPt52lWuOYuysVsBO/XxWAJSHdt5gJjYKz0NGcXuYu5z4j5dby68hN1YG20PR0BmyZYcdSmUlRWOmC0N7T3O9PYSM+y/ecnxwtKsC8LOZV1kETSUuZeMku06esyHWHpFS4I01OqfH8vqX0vVo6uLBRyFLrLUxaWapQM54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ewdNnqim; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ewdNnqim"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-477b198f4bcso50880085e9.3
        for <git@vger.kernel.org>; Tue, 09 Dec 2025 08:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765296206; x=1765901006; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=eM+FgVtc8awvQ6LhXr0zdgsT7fYkNCLu06cHj6DvpJA=;
        b=ewdNnqimtG6EXHiVh82qjqgH+CKG5wpRCdB0FrN8jae3Oer5UjTWng0dOEbdg/8dm7
         ksQ3Y6kqHfp2c0EKT4qHtWbnDQdSsCtP4G29Ugls3QcWoGb320CckV55y6RpwCGmVUn4
         zMzq47TBVQvKnQuHFqjBYQDScQ5lYx6KKTCuycxfWteZbCiLP+ZJQ92D2tLRZqWovvbg
         tcVe2z8Vh1RsSbCUIZHtR3s4wkUkg+ZQgT5chFScMb+rfMF4xfXniPNS1kwWpxn0EhaB
         4rTJUzCHtwfQyW56zbpDZs2OVjGkP80sYoXgYfXLdyBwTYgB4Gxp+hF76uN8REDH5/U7
         OG3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765296206; x=1765901006;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eM+FgVtc8awvQ6LhXr0zdgsT7fYkNCLu06cHj6DvpJA=;
        b=vbMFY+NZd4y9zPBqX8KTyllG+4LRCtj0seN9PrXWXTwK8I3E7R9zBsZQwUWP7C3sko
         N8NnPHpMkEbxMniQ6zP0/mwiIsi/HxqH/0khEaBOiblZuijbv0WVcsRMStPuSaRLi9Tk
         0vcYI+sBsKiuAMKmNfLocJwBMJC4o9MW+qxNRAGLb2P8s15nCpsM11Dp/puMPwBmxYSl
         0wJ9p5ll4ndGrS4lD6BKAx8f0C6hfiDV9WeLbGNenK4CeQs8U0pTkmE+bqKbmk6qNbyD
         KltRkXEpjbADwHS7iI4p7cWAI3e9da6GUXDOzeod1kB2jknulXv10PuXqLqHRCi8B61d
         jX2Q==
X-Gm-Message-State: AOJu0YyTNfts9bFituaax7lBXWBjFznx20T4SKhmJpkdPTib+0pu2q1r
	7WkwH9PwJlltYBBCV20dqSXinOQffVmfXWQw6cNW2SXec67kCprgi2dOzoeeyg==
X-Gm-Gg: ASbGncuAID4vHWkLxzHeSlbzSIdPTZbb6n4a+vhWT1rqDUaibevtW4lMf0dv6kWd0H5
	Tzehu/5jadSBIWpjM8PmA5leaeJmwTHMa+lT4JKYyLEhO1Sb39mNcT3UumrzhZ22pi9QUSO0bap
	svTJeS4Wl4+CElaITeaYwyjYIETQmx/0yfEsupX/vO+kEAIWWeUuramssICNwsHFIASRui6zOiS
	dtjKijTg67ujB1utRCpaRpJALpQgKvUsThtXPm7f9QDrS4uYW58Gjo8/smHONpKgti3b5WvH2vV
	bj2muyKO87d8IRC1c9yWyxmzpAK44COW3pHVXqC4p35Wr18dX6qhD7wEp+cs/mAeCJ61HwWkYDr
	xOkJHhLEgdWFIfrp+lWleKfHDTKaFRZ75CZs3q0mVrXnQC2DIdp9OBeE8laj3m5OFfm+y4dvxDi
	InXr4BXjeVceKgIJ3PIxoQx2/LfDOpFxTILwSTRSlXkWJCPIOOXcBzeYJ9QWvihXg=
X-Google-Smtp-Source: AGHT+IHCWTPmAQ139lJrLO97FzQ6jIK46lXFOgwIDRsN2zxO5GInVMIFKsdxOiVrdg+7mENnYYkuCA==
X-Received: by 2002:a05:600c:d2:b0:479:3a86:dc1e with SMTP id 5b1f17b1804b1-4793a86dcc6mr76633145e9.36.1765296205445;
        Tue, 09 Dec 2025 08:03:25 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:658:8901:ced:8495:73eb:ebd6? ([2a0a:ef40:658:8901:ced:8495:73eb:ebd6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7d331af5sm31058207f8f.31.2025.12.09.08.03.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Dec 2025 08:03:25 -0800 (PST)
Message-ID: <e4ac43f7-f42d-4353-959b-7ab91890b7ea@gmail.com>
Date: Tue, 9 Dec 2025 16:03:21 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: bug: `git pull --rebase` breaks in the presence of pushurls
To: Kartik Agaram <ak@akkartik.com>, Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
References: <896e4e13-5d2f-4c5c-ac32-2927dbff91a0@app.fastmail.com>
 <04cc0cc0-155e-422e-b723-b1115c918087@gmail.com> <xmqqa4zsliim.fsf@gitster.g>
 <67bcbcce-96cd-4bf9-826b-e52b3e09a5d5@app.fastmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <67bcbcce-96cd-4bf9-826b-e52b3e09a5d5@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09/12/2025 01:48, Kartik Agaram wrote:
> Should `git push` perhaps only update refs/remotes/origin/master if push to all pushurls succeeds (with the same result)? It seems like that would fix this issue. Does it not work in other scenarios?

While that would help in your example, I don't think that helps in 
general as there is no guarantee that any of the push urls refer to the 
same server as the pull url. If you set a single push url that pushes to 
mirror in your example then "git pull --rebase" still drops the local 
commit. I'm a bit confused by remote.pushDefault as if I set that to a 
url rather than a remote then it does not update any remote tracking 
refs. I had assumed it would behave the same as remote.<remote>.pushurl.

Thanks

Phillip


