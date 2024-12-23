Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB7C166307
	for <git@vger.kernel.org>; Mon, 23 Dec 2024 12:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734955438; cv=none; b=X8geUF8Wjm4Si8wf6DzE/6UrXS4zpT1slnzz4qHdzc7Dv0tuGmk896VNIVkTliViFa3+2Sw40unyhP0JSQa1QQx08NRTMk5Skc0t3LuYLVcUykU68IpPjqviRhHizZGszcSM1AU2ZTWDLs/8+yUNGrjHWV1LUz0dbKbPhYA4jS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734955438; c=relaxed/simple;
	bh=AYbY0+VT/pFyd+Gnzn5EcXtei1wURxlnqU8VhTJxrv4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=Kg9DNCIorWi2UNphIbIQVgDtgx89JFDqRG+5MvfJE54XG/EEMamJPZJtpfE3+JCrT7wQuEHshXTX+Xdtlm+DkKNqeqivPNFUXmu1NZK30wn5vuzmrbmL+K8M7fZ92PMgV1vCkh/IlC7QmDC6NBiIPdIQZ7jGfiSz4j5th5nWigY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WsQTSmvT; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WsQTSmvT"
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-844ce6d0716so333958839f.1
        for <git@vger.kernel.org>; Mon, 23 Dec 2024 04:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734955436; x=1735560236; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AYbY0+VT/pFyd+Gnzn5EcXtei1wURxlnqU8VhTJxrv4=;
        b=WsQTSmvTXlrTZsF/6YK0YI4jw7mhRzK6PilrztrK3HTp6kY7zC2umnkHcE2rHFBlLK
         V3RILEf2IoHtORt8llv0if9ou7eNTgQ0yKnKFZR12xggeBddU6yv6hwT4wFPiiANw2PP
         kNdjZGHOXOPxi62BgHsz1cyZx994x59DuECA9h2M1hyUMQot2kvFHXzZAtho1IJzU3qo
         +zSmRXNgwyHx4cVCj+kVASTspZYRZR2PV1DxcCDeHyEJxcuwwuIh/n97i5/dERcxe1N1
         +omHLazPJ7Q1x9fJddrS1b1emdGmoJhEcb3s74EjdiZ4C4p0gkUvteEvMif6iNfZffge
         Lnew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734955436; x=1735560236;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AYbY0+VT/pFyd+Gnzn5EcXtei1wURxlnqU8VhTJxrv4=;
        b=lA8edYSKXyXfNdNnqxVXLd9OKPwQIH4+lMZTACMvNSHGrWADuda1CUaXFf2Kqw3EC6
         5hZTiCkSok/eYgQAZLHOld4TWEOlDjTIrLaVBoKQsXi2uLAMwHNhorXwya9HjVq0MogS
         c5+adGeJgvZdydIpEjSgDI9pGuKscTm052BIwjFwnA391/irDq7I1h80uRa53tmsX09i
         v+uQDXG2/jP2m7JetqM39gIWty+RUYyQzgndtddo07hEus1H3MHqx/Gn+bbv3zdLnZbn
         HO9xh3PfDX3wv/jGDZypi7DZmq2h3NZfShGz+Pp6qpTf2Wj+bXpr6UZtVNdWYP8VxeiR
         +aFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUeTPp4pDKG9J5T3vaZFJ7YjLAG79VOf/NY47E0/eXN3P/ihrgmPrryiC4hL21auEIKdpk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxobcjtvTZzipNai/byicjQdmDLJYIaQmUwaV62OCDFYyAMnJvJ
	CTBBVLjlTcy/8N8+rGZQyaBbPTR3zWSkqYU4/vfBrLEySgwu6KspOpmdeI+TftakX7MM7+ieWIl
	OdezXGkiQvFcCTkuHt3lsmRK3nq1s/Q==
X-Gm-Gg: ASbGncuObfcuVmh6qyv5InotEsTFwDTBFHNRdbC1CToqB3YjmWfo8fA8swUIGojf4sn
	rGgy6+Bs5yFKEOKeKBpzynpTRxIkqu4TTC6UmPgg=
X-Google-Smtp-Source: AGHT+IGdnNgFQzZ9fUntiRopWfwbwgNsq0D+jcF1wvKrvJnJlCcBnwNi6wmTANykYAX/cyfvBlQd/pn4TY+3RSztZbo=
X-Received: by 2002:a05:6e02:19ca:b0:3a7:e7bd:9f09 with SMTP id
 e9e14a558f8ab-3c2d1e7df64mr104820995ab.5.1734955435865; Mon, 23 Dec 2024
 04:03:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMmT1pKVMB6ZUbsEdB0RqbWERauGVqgo_RbXj4j9+csXLHCStw@mail.gmail.com>
 <CAMmT1pJnZxxD3wFikiDRCqZZMxO8P6EgVHe9mJEsfA8PK4-OfA@mail.gmail.com>
In-Reply-To: <CAMmT1pJnZxxD3wFikiDRCqZZMxO8P6EgVHe9mJEsfA8PK4-OfA@mail.gmail.com>
From: Krishnamurthy Ganesh B <ganeshsurfs@gmail.com>
Date: Mon, 23 Dec 2024 17:33:44 +0530
Message-ID: <CAMmT1pJ0ReaX+g2_gFQ2oLUrzhR5wCXGvCj_WwDMXcfG2DNG_g@mail.gmail.com>
Subject: [bug] encryption of metadata in .git metadata file inside .git folder
To: "git-security@googlegroups.com" <git-security@googlegroups.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

hello,

greetings.

i am raising a git security red flag on the.git metadata files storing
git logs, commits, and other metadata inside .git folder not encrypted
using a two way salt or some other way like using a key for a two way
encryption or some method of software encryption internally if /
because the .git folder metadata is not encrypted.

this has been raised to github before but will be raised again via
hackerone security bug and to gitlab and altassian and other git
repository source users if they are using their own internal modified
sources.

most of the errors like these will be directly closed.

https://kondukto.io/blog/git-scm-affected-by-cve-2024-32002

https://socradar.io/critical-security-updates-for-git-scm-cve-2024-32002-cve-2024-32004-lead-to-rce/

https://stackoverflow.com/questions/45578579/what-file-metadata-is-preserved-by-git

even packages like git-crypt do not encrypt metadata.
https://github.com/AGWA/git-crypt

have a nice day.

regards,
ganesh k
