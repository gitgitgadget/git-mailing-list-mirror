Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F18113CA81
	for <git@vger.kernel.org>; Tue, 23 Jul 2024 06:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721714589; cv=none; b=a19LKCvw+kiqmuO9qebAHYtYPO6qRVn7Q5rcnzM02rd64BAvLG7MhIc9KdUJ7tu6PWF9qE0WG/zeFwL19nknyb8HnLk1/QnNBuEn7NQ9K0amEOWXla2tRL5UVZ3RTbPhDTd5KdqPlICuGuJXcKkGKjOcbdWDZAXmlR24nJNzEP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721714589; c=relaxed/simple;
	bh=mxQicDvvpbledY8H7tLm4pwNoLW8CnZDCWm6MUB6nes=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qjdoCl4/Ort7++yxqJv+nEgFcqLESoeewVcbykTzKp89bYrbew5Ry0+wYdU9ekNIWslUXANsOVy8yiP7MCjLAsAVLVjarmrnGjN3BwmDU5NpWgVrMJ/5KAyrcQr3v0knm2AyBc87H6vN8d4uAvOTt1+DvHQrlXcI76Z2q3WKrjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NDlCN1Qa; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NDlCN1Qa"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5a22f09d976so6191569a12.1
        for <git@vger.kernel.org>; Mon, 22 Jul 2024 23:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721714586; x=1722319386; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mxQicDvvpbledY8H7tLm4pwNoLW8CnZDCWm6MUB6nes=;
        b=NDlCN1QanLT/6ANCtZ/3nfEeCqtUssrUIwOLleGvB+FX7pXC5JuZG9Mjr4ZThadI1L
         kkTdFlcAsZTIw3U4Vo+7YftYCLjyPtCZv1hU9KQCTVjN5+OzGHrf2+Dm76MFe/WR/ZGG
         vImNFefnTkWPXtcpFCcVVAzcDQxop802Z4Nb2Wmm0PHvCQ08MpuqlOaJNTlpd3Wet3xs
         zorVQmLFQku7O/8d/58tjZkZJlOCuaq2QXTSm/qZKSEMDPQoNsgGLzL+wsPI8eSy9Sjj
         RPXfe6u1SqMf/Drr+o049i4UvqWmImj8nwhSBiPxAknOW/5SVQhAAV8/yKRbiy4E0rnS
         VEMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721714586; x=1722319386;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mxQicDvvpbledY8H7tLm4pwNoLW8CnZDCWm6MUB6nes=;
        b=QF5JZ0A6VEKjvAML1Lc+12BfuRHxJ+PKr/lJq+OzIyW0kJA5nX+tBjaLyH3z+osH8c
         d8evBvv2wpX8FZ40fUJ3OSLo79mHrtnlj5e6IXtCkZ+5rHlYKezWKiLjWLfpSGIEjxi4
         bMlJOmX8gOD2UU4qtHn6wZZOUPNspPBcPX9GV61gn/U7uMR1c/MYHWacYrz1ryxCHJIi
         X7Wa54nxzg9i70Su7SCYlDCDMJCsiG4w5w2rJr0ByLzEQXOTSOyqmx3aorHLNkCHowYS
         7qyiqX2o5eCm2Sqd15OSysooo6fkIt/dgs68T38tWCmOm0ih6fjbHBrseQ7UJpGRQN1T
         qOWQ==
X-Gm-Message-State: AOJu0YzHR8+plH8uuaxVt4aPasZxUovffHxBG/1G4VHA9NVnMm92PqcV
	/0/iH2rJFaI/TpAGlVrlH/gChqdCLDFqfDlJTec2s9JcrI+TVlR4TSgvpBpRDb2WBXykmMmRwUD
	Lycpu8yCLsd1PDTgRRQTxeMKPX5gRd88M
X-Google-Smtp-Source: AGHT+IENrnpiGYds1oc9/7vZU14GeJcCIc6XlXrGqowccBtciG+08CtZEs+GZuY7NH+6VqZpMT0bnVGzgHzlekFkygs=
X-Received: by 2002:a17:907:97d0:b0:a7a:8d57:b37a with SMTP id
 a640c23a62f3a-a7a94280cf6mr108355066b.20.1721714586011; Mon, 22 Jul 2024
 23:03:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+J6zkRxnvnybM3vnPXX2YwpW1k-as03+A8kxiJoA8GrA4FSMg@mail.gmail.com>
 <CA+J6zkQaV9o7eUaD2bshH7zEmF115BbYv_uCFctySQNMgGQc+g@mail.gmail.com>
 <CA+J6zkRzM33MbMr4-U56M1SFLykx029+SzEeo8vBicBd9Xs8RQ@mail.gmail.com>
 <CA+J6zkSFCUYLRTRE0Gwug4-fF9f9-YbfRz_atArmMLLCtQDr1g@mail.gmail.com>
 <CA+J6zkSxcogPXdAdr7VL0B3MnQxQNYwOT5Kw2iK_YfPLW7CMcg@mail.gmail.com>
 <CA+J6zkTyVDJcOoZC-thRAOYNudVWB1wgye0Ezj3o1AO_5HOS6A@mail.gmail.com> <CA+J6zkQ7W=3+aqAHwzXzVM4-mZ9XpCkAfmP-GZ7T4i+i2Gi9aQ@mail.gmail.com>
In-Reply-To: <CA+J6zkQ7W=3+aqAHwzXzVM4-mZ9XpCkAfmP-GZ7T4i+i2Gi9aQ@mail.gmail.com>
From: Chandra Pratap <chandrapratap3519@gmail.com>
Date: Tue, 23 Jul 2024 11:32:54 +0530
Message-ID: <CA+J6zkRxpnQ0E-KK8-rRDfDJar=9TwmG18ZkiA+zcxaavwPoqA@mail.gmail.com>
Subject: Re: [GSoC] Blog: move and improve reftable tests in the unit testing framework
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"

Hello everyone, here is my blog post for the eighth week of GSoC's
official Coding period:
https://chand-ra.github.io/2024/07/21/Coding-Period-Week-8.html
Please let me know if you have any sort of feedback.
Posts for the rest of the weeks can be found here: https://chand-ra.github.io/
