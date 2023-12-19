Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CEEF37D1D
	for <git@vger.kernel.org>; Tue, 19 Dec 2023 17:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DWB4mKFj"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a233a60f8feso368479766b.0
        for <git@vger.kernel.org>; Tue, 19 Dec 2023 09:25:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703006730; x=1703611530; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cLVlQuBPZj0dUNvQERf80urR5YkOVWNm2TpBKPJMhkk=;
        b=DWB4mKFjZ+Z1qp3UEFEzsndB8LICr8RU2wEnzq4MyHDlFdupcrPGGmGOj/AQn63U7k
         mqrakUVi57EORqp9ZA1q8Z4v5f0fDZkzBLUoofHBJdpomQYSI0M5Tqkrj3OW90CximAk
         iLpTmvUvUUXZaVYgnKTmJfx43OntfZT/r4J3xt2UzbdJETSje8EMI1yhSoaqGE9X2fbd
         dO/L9bH5o+LVrpCKVogqOPtI52/9nzVClWX2OT9daGx6XAV3D/ym5Lstqv8BW0CUqk3/
         3KlLDNVRL/xXJ6DDnpbQ3qk4TgCdtQNzh6rIfyrEYMAk7RBRwFI4BrljCmBkfe8D9PXd
         HfdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703006730; x=1703611530;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cLVlQuBPZj0dUNvQERf80urR5YkOVWNm2TpBKPJMhkk=;
        b=RWoaHBBVVVpW8EcCVfgHMP2nfTrbit3gCQ4ovOXn6ZO/8Jz8aM4jaQwgmCNIxML/du
         V0JWAPYMjiZJ/ugax3hZw1JwR60rt2mSmuqQxnNmTYf78ZJE73l9AA/EUso1OdpzisgM
         rrxfJH6QDy4MbAEaKP3siWLSx6XcT4QiPhoTtY05rhqRj+3/39W2JIpexqZL0FDWTnMx
         AdQuUvAIzykr+sP2blZGKe4f7nhNVz1d/hvVbsgVmLkxlJPkh9Q4W3hn24TRCKagC2Uz
         IzuhXzZSI9iqwGA7IEEeTsbJeRBXIltYPZHqajlAUQs1KIhmaG9KA5+x7sDjKrQPNr1j
         PJqQ==
X-Gm-Message-State: AOJu0YxlZfGKu97MWIH1JFrzH/dND8llQ9uZK2eKA9FXfniSeGKdiyup
	vA4edpliyWKKxSZMLFkNmoS/JCJ3eGuD4Lo9qXJrG4ZGu7E=
X-Google-Smtp-Source: AGHT+IF2HMuYmafHzkj0365GAZ+uOfvrifqhs6jaHwbQ9aZ82awWpEDYTf3cjHiaTF+M/RYKqhP241FomzVEQpbXeJY=
X-Received: by 2002:a17:907:968c:b0:9ff:5b5c:12a6 with SMTP id
 hd12-20020a170907968c00b009ff5b5c12a6mr10463333ejc.40.1703006729445; Tue, 19
 Dec 2023 09:25:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPMMpohbQK+3o46iiY+0o=vS+UC_HBB=CxsNT_hAb5dDz+514Q@mail.gmail.com>
In-Reply-To: <CAPMMpohbQK+3o46iiY+0o=vS+UC_HBB=CxsNT_hAb5dDz+514Q@mail.gmail.com>
From: Mike Castle <dalgoda@gmail.com>
Date: Tue, 19 Dec 2023 09:25:18 -0800
Message-ID: <CA+t9iMyrLAekwQHNky4w9nWD6WwxidxwfSmbqCpSRnkJgoQ0LA@mail.gmail.com>
Subject: Re: Is --minimal ever not the right thing?
To: Tao Klerks <tao@klerks.biz>
Cc: git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

I believe that the diff algorithms available are the same one's in GNU
diff.  From https://www.gnu.org/software/diffutils/manual/html_node/diff-Performance.html:
"""
The way that GNU diff determines which lines have changed always comes
up with a near-minimal set of differences. Usually it is good enough
for practical purposes. If the diff output is large, you might want
diff to use a modified algorithm that sometimes produces a smaller set
of differences. The --minimal (-d) option does this; however, it can
also cause diff to run more slowly than usual, so it is not the
default behavior.
"""

Since it has been that way decades before git even existed, I suspect
(but do not know) that, yes, analysis has been performed, and it makes
sense to keep the current default.

Then again, in the decades sense, the entire stack from hardware to
compilers has improved, and maybe it does deserve a revisit.  You
could check whatever email archives is used for diffutils and see if
there has been any discussion on it recently (say, last 5 years?).

As you pointed out, you can set it yourself and see what happens over time.

Cheers,
mrc
