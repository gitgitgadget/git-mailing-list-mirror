Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371D045BFA
	for <git@vger.kernel.org>; Mon, 19 Feb 2024 21:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708378833; cv=none; b=oWsVrOE7QPoOVegC4Or6S0lDhztFOzPRilob6m+cmVIZsBndjPfcmurAQLZZePKOpI3nZhOZ7dF/5lr106CH1vFFl60kT4ELoU4B5Mhcqw3jYg3nqMKSrlq9GretlScKOlGHShkaRRVY1V4BKrGvvjzvPeHaXei3KghpCL2PGfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708378833; c=relaxed/simple;
	bh=4kG0FqKPy9mRLzU7fqm3kM0bZwwg/59Ig0jpPFuu4vY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HIosTMqBiFWG7sDW/TOLBxZG+Oh4o2vJTudceXoTwyuEC0j6uJe1WWp/i2iZNqeV5wnDjsAHp4TWuXNlF/HA9KEn6sg9tAfroZB8SjAfKkgm3I9z/zOStQaTLT82iRmoAW4DKZMD0Jmx+zTCKHxDb8hbKl6v3AjTIyg6A2+WgVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jocN1Cuq; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jocN1Cuq"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a3e5d82ad86so230952366b.2
        for <git@vger.kernel.org>; Mon, 19 Feb 2024 13:40:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708378830; x=1708983630; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4kG0FqKPy9mRLzU7fqm3kM0bZwwg/59Ig0jpPFuu4vY=;
        b=jocN1CuqKfS+tDwmyAGtPT55uB+fIAoOHeT6EGzor/q+cf95o9dyhqISEMGq4EaTEw
         0RnGHQQlRk9Ri9XEc54mnRHK8XC6khnlWdT7y0EdiCW0xvglKsjATy314YnMNP8Lcvi6
         Nwj8nmBYc7d4SNzx2yWjxZr94/MQ+beXzElXKcJ8zOyu5FNI3KBiTnoZ99+KpucLThgu
         u+Xvv+OBxmhohQjzR+u9ePD/vJKbZ0aK960P2tZ+OMMiyKSTbKagekWnPoZuHBOG9uec
         hOPYV5lyORBSPGYAa7GP0vhUsyfcOroeae6SheHE0f7ctV+yFf74wwmcDGfExcwoqr0M
         gqEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708378830; x=1708983630;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4kG0FqKPy9mRLzU7fqm3kM0bZwwg/59Ig0jpPFuu4vY=;
        b=ngFOhb8pESA/cFXPiHYMNonFDPMLHKESes12gwTbXa/LqSAb4VWEP/I0HR0DJBsMve
         goq4VQU4sats7Ek25zhoSEVqewQY9S4yRtDMY143nL6lzT9LTiSTbfq4ZTx3xZWleKDJ
         fgarhe07uEwOUJbFgD1QKGmKWWtkMxCeEWB14D2JOEekL1hP+22iyF1LeerC7BVIMbtp
         zm/4IhujBWkvyvF5okgxG6Wz9dyO3fHn2ythwaMu4brXacqgMhiSLQWoTDFLZWYrXJvk
         ry+SD6RJhw7ufA7CyQIOCRY1fV9vDHo9Wknrah/6mvF4BT2Pc5DjVfX8nyxFHMVx9r6y
         axDw==
X-Gm-Message-State: AOJu0Yz/rPg0K/HMG9YpDI08KdVP9u9qES+Wg+fAjlKcPZpzwXe/C+Cx
	r4hkN9CHEE4JLI2Esk597Zh2+1KEVbEpY5ENd1WRUr/cnDVlFuDK0cshorpHWoNO1lacTHtpmub
	On0iqiG/wJJ+ZcUO+gGoAxeM+L6I=
X-Google-Smtp-Source: AGHT+IHE231Pi46ilIVgSsYdYpjgmCoSJ7ze+uvgtMrOMbq7g+ivfvfDrhmgnFujGUX8h28Nm7Wig3VP+k0di0a7+oY=
X-Received: by 2002:a17:906:f884:b0:a3e:401f:8278 with SMTP id
 lg4-20020a170906f88400b00a3e401f8278mr5071278ejb.11.1708378830309; Mon, 19
 Feb 2024 13:40:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1632.v4.git.1707196348.gitgitgadget@gmail.com> <pull.1632.v5.git.1708124950.gitgitgadget@gmail.com>
In-Reply-To: <pull.1632.v5.git.1708124950.gitgitgadget@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 19 Feb 2024 22:40:18 +0100
Message-ID: <CAP8UFD1GaiG2spkd29DjTQomR+Kku8pFJAnat91mXUo2hgLEqQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/9] Enrich Trailer API
To: Linus Arver via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>, 
	Junio C Hamano <gitster@pobox.com>, Emily Shaffer <nasamuffin@google.com>, 
	Josh Steadmon <steadmon@google.com>, "Randall S. Becker" <rsbecker@nexbridge.com>, 
	Kristoffer Haugsbakk <code@khaugsbakk.name>, Linus Arver <linusa@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 17, 2024 at 12:09=E2=80=AFAM Linus Arver via GitGitGadget
<gitgitgadget@gmail.com> wrote:

> In summary this series breaks up "process_trailers()" into smaller pieces=
,
> exposing many of the parts relevant to trailer-related processing in
> trailer.h. This will force us to eventually introduce unit tests for thes=
e
> API functions, but that is a good thing for API stability. We also perfor=
m
> some preparatory refactors in order to help us unify the trailer formatti=
ng
> machinery toward the end of this series.

I took another look and suggested some improvements to commit messages.

Thanks!
