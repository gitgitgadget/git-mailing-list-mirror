Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423C61EA7C
	for <git@vger.kernel.org>; Thu, 15 Feb 2024 18:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708023414; cv=none; b=qxFGvZEGVyldC88Aa2hcBdd6xDwcUC/YSFrHMShZMQxf3IXAlC2l/7k6+snE/iK1f55jYx3u0whABfN8UoYp5GAifl+XHlURe/WliQKkctLzXE4Ue/+jM6SnYQxE9+24I5cglN+c5Nbf64XOWhnNxawHnxLgembOqA6T7nrYbK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708023414; c=relaxed/simple;
	bh=hmwM0zMk4JEH4I+vJZb+bmI1zRsqQ7ob2M1SwEQ1d0c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bda6xXrd07Jph1SxtNQ8TIuZKckoks0He/UCb8hybb++NeNogevC94XRpRHAZXsKlftdu9O6cgalUsV94sLodd8ap5PQMaZJ1pynHW4JR9OFmtbhR3slC3nm1lgqJixvkbSrSfbjPbA4D4UvrE7ZQsKp40++vHcVhpMbVKuvmS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kvwXBq9U; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kvwXBq9U"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-55a5e7fa471so1691718a12.1
        for <git@vger.kernel.org>; Thu, 15 Feb 2024 10:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708023411; x=1708628211; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hmwM0zMk4JEH4I+vJZb+bmI1zRsqQ7ob2M1SwEQ1d0c=;
        b=kvwXBq9UjWj4+vHU8F80mxQG1UoiVkK1QGyDFhHryZAMls/z3ICml+F67vnmtY/mzH
         idCFIWO+n3KsH8jcqyx+SaWnddgitLLA8Th1Cf1AAC+1jUzh6tXEDbIBQ5hIJmqGBwLA
         rdyM9OJgvtffPAXbWwO5l1NihY4/AYN0euxaYHHq2gJFCWPo4sRYhgOO0W/pQiBlAULt
         u/F+sdDuOqfZeTvMQ8I7xa7UAeX4THBaUY29iQn0kidXUxGHt5JQ9XZlyRQEXZYc7MLe
         khiPazoLYHNpSfwimgggcgbYzVoRF2HR6mQHKFuI453VpkQ88gFQBD4ayZWFR9QwhdIT
         sHEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708023411; x=1708628211;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hmwM0zMk4JEH4I+vJZb+bmI1zRsqQ7ob2M1SwEQ1d0c=;
        b=UWvnJRCwYlPdxb2S9JXL/ywwJFGIE00e6M5uzAZLC5+26GAxnKrj4Ah3SNvnV/DxQW
         y9UatSniHsEbdJX/k+A5XMShSHXejR7r4Geo3mikHrzPYcMhQgoMBFw8vM4PM6pWa+Ot
         KkgLErJH0MI5AVCotKFbJUUE1hcAzX9D7vlxB1Lz42JvkYY4/YCRBdYrr3mMLFihggoR
         eIn0pKzDHWwfHFOQZjh6eC5xov8mnQkA0AtruWQsT4JDQwxc2Ql0WCXOBywn5nGB3MCC
         dmnRJV20wduxQ+//kkrwgljkCMemWF/9h+DtqbKKjo1mNqdpndC9grXq3HlcDW4GtEGg
         SYkg==
X-Gm-Message-State: AOJu0Yz+UMmC/j9AYadWfHI2OoWGBZnuxjkxU9IlYJYdijpDf8H9exUm
	I7MbaxeSx6VO10A7tAu2QGWfk8bEYHen3cgneI9D5H+iOnFOVfFsEpa2OxgWTqV+UlNaTcj7vqy
	mZ3gM81y0F3yAYf55GScQDB8cCkM=
X-Google-Smtp-Source: AGHT+IHljYF41l+EMvA84Lim9H+tG6hCBQ9g3jsv99c7qbrxNraKGulerJobE2ppGz+A6HqFJeNke8ROaxbAMnO11Yg=
X-Received: by 2002:aa7:ce03:0:b0:561:1917:eb9e with SMTP id
 d3-20020aa7ce03000000b005611917eb9emr1998124edv.35.1708023411269; Thu, 15 Feb
 2024 10:56:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240215094243.147057-1-gitter.spiros@gmail.com> <xmqqcysxskd9.fsf@gitster.g>
In-Reply-To: <xmqqcysxskd9.fsf@gitster.g>
From: Elia Pinto <gitter.spiros@gmail.com>
Date: Thu, 15 Feb 2024 19:56:40 +0100
Message-ID: <CA+EOSBktLGnzi+DjOTVv9_cVNsM_fjEKiF9kWnaYrGtvGJ-Kdg@mail.gmail.com>
Subject: Re: [PATCH] use C99 declaration of variable in for() loop
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Il giorno gio 15 feb 2024 alle ore 18:33 Junio C Hamano
<gitster@pobox.com> ha scritto:
>
> Elia Pinto <gitter.spiros@gmail.com> writes:
>
> > With the exception of cbtree.c, which would need initial
> > reworking to remove the usage of goto, it expands the
> > use of variable scope reduction in for loops as
> > permitted by the C99 standard, which was first introduced
> > in the git codebase with commit 44ba10d6.
>
> Thanks, but ...
>
> Our test balloon may have proven that nobody will be inconvenienced,
> and it does mean we can be liberal using it when we add new code or
> update existing loops "while at it", but I personally do not think
> such a code churn is very welcome.

Thank you for your reply. I can understand that, clearly. However,
this means that extensive code
refactoring contributions are never welcome. I am not saying this is a
problem, but just an observation.

Best
