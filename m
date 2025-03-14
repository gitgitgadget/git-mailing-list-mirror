Received: from mail-qv1-f98.google.com (mail-qv1-f98.google.com [209.85.219.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767BB17D2
	for <git@vger.kernel.org>; Fri, 14 Mar 2025 19:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741981262; cv=none; b=O3Y/OdpNe/H0jnz7LU4HVYWkpMYDYJln6ZQl+67Qa1VT7CXSqnZqtfgG0wLrFyNMXin1AYgCv3Rtldv80XeskR8EO+o7XxrVu6eTXj5Qa5ynf4qgxZ3X1Bnqd40Ou6AU5ETledUqQjepslgRzoJbzpsnbf2c3DsuekUqRtHR5GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741981262; c=relaxed/simple;
	bh=qNwdTwP0P8d5kaRLmIaq+K/MHOqcQkA/v6mohBxIof4=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=PZt2tIrfk0goOcc9h1JP4q7jWcII11CvEp7ITPZSRDi99g/P+bHWGdKOISiGyEHvEJbWb8dQ2JGBbXxiydemAHjAs4gw1yUIb+99tXSFYsZMetdxT0MTVJ29CFalT5REan97nvZnRc0DEjBfv5vxMLWjTE3c8BrWsAEeNyTeAw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mandelberg.org; spf=pass smtp.mailfrom=mandelberg.org; dkim=permerror (0-bit key) header.d=mandelberg.org header.i=@mandelberg.org header.b=t4qght+z; dkim=pass (2048-bit key) header.d=mandelberg.org header.i=@mandelberg.org header.b=s2U6Hjlm; arc=none smtp.client-ip=209.85.219.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mandelberg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelberg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=mandelberg.org header.i=@mandelberg.org header.b="t4qght+z";
	dkim=pass (2048-bit key) header.d=mandelberg.org header.i=@mandelberg.org header.b="s2U6Hjlm"
Received: by mail-qv1-f98.google.com with SMTP id 6a1803df08f44-6e8f06e13a4so31620386d6.0
        for <git@vger.kernel.org>; Fri, 14 Mar 2025 12:41:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741981259; x=1742586059;
        h=content-transfer-encoding:message-id:references:in-reply-to:subject
         :cc:to:from:date:mime-version:dkim-signature:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2R6jN0AT9W5HnTIg7HmBvXviyP+aC77tZOigL3gAE28=;
        b=K7+vFgmO3LgW3W78uXPeB5wXuY4jljqoykP7A0P3MpZvxXCF3/bxZblwApHhweGuGC
         sUVlixmrm4IIfYVyDOCXguWJwAbT6ye3fRdw34+nq67IYlXOVqJ1p9s3KvxZjW7dNDbj
         TZuSUicXJqI27RfToFkFNkUask6YY7pSHxMamysTpBeh44/n9WhhnCjFlq/WBDRw/Ska
         +70mrpkC2aJ1/f6BPGcp9xcu9s8dTB6ghS/P/RKSDWimMPlxCuh7JNPq12bPVbpAuHEi
         H+knTlNrsuDxiwxuPzWaa4uVbCsTtUKbgEC7DJixnnVqwyKJ9pKXxvQcH9eNJtH5yMjh
         s88g==
X-Gm-Message-State: AOJu0YwNsgET0G3IAkU3EYUQSvgX8KB0iiB/VE9nJaBV9uZ5cm5/oWxd
	JZ1dsjiT6JLIksevkJxZmJV2+3IkSZ5Tn7kL3UovxCNWtvpVltyDcFm6W2AH4W2rJKGNFaiT3ka
	qh3XqvHRrcRVKFHLMHz7ydhxkGyNlP5xKnx+vT190OdYtI/Oz
X-Gm-Gg: ASbGncudkMcu7cUJWMFF/53qdkSDoOthTMPW19Duwm8A9PZx+YrRDEd69TepUx+RkMc
	4k0YwN3yfbLF2BjyPiAh0qvVjIodugzq60v+jNrxXkUtTgtRhPK/sw9KriAxnpQIuzXixq/VFvY
	CDsAgT7ueDAsAuTdZMwHXQQYyeTmKKj42QRjRTaQAsI0QPb/0NlGDZXI6+t/QF7fDG1+B3Y6hNi
	ML8HMmrH3+q+QdSwBOu8VfVguLdHPrDa0OzvHZt97DDvqlWRM0VRCOC8/1ZFrx+pB3l/LUjj5HR
	9qU2Qv/mwkStR1pZIqYuQquRkuq5dL0yahjFrPXE
X-Google-Smtp-Source: AGHT+IGH/uNQQRP+569kmPUg9msMwRoZt6YM+w+C9SbGjjyoSeqQC2Gkwt1tbj3A2m4eAb0XOv8zNg4OgMH9
X-Received: by 2002:a05:6214:3116:b0:6e4:5971:135d with SMTP id 6a1803df08f44-6eaddfd8f12mr125781856d6.18.1741981259051;
        Fri, 14 Mar 2025 12:40:59 -0700 (PDT)
Received: from mail-outbound-e14cf917.virgo.mandelberg.org ([2600:4040:52f1:f606::8])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-6eade103e7asm2024366d6.7.2025.03.14.12.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 12:40:59 -0700 (PDT)
X-Relaying-Domain: mandelberg.org
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/simple;
 d=mandelberg.org; i=@mandelberg.org; q=dns/txt;
 s=mail-outbound-e14cf917-597d7abb; t=1741981258; h=mime-version : date
 : from : to : cc : subject : in-reply-to : references : message-id :
 content-type : content-transfer-encoding : from;
 bh=qNwdTwP0P8d5kaRLmIaq+K/MHOqcQkA/v6mohBxIof4=;
 b=t4qght+zPWnGiuGUaYY/XLM9dfA0xQEsdDspH+C73fbV1kFHB84Q6q/hzgYO6PVfvPn9V
 yEy+xoD3uWv66DPAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mandelberg.org;
 i=@mandelberg.org; q=dns/txt; s=mail-outbound-e14cf917-e56dad1c;
 t=1741981258; h=mime-version : date : from : to : cc : subject :
 in-reply-to : references : message-id : content-type :
 content-transfer-encoding : from;
 bh=qNwdTwP0P8d5kaRLmIaq+K/MHOqcQkA/v6mohBxIof4=;
 b=s2U6HjlmmfO4ZyB8rONdXwBZUnTMbRSdpKW7Mz27MFOgceGXOmD2UwMGvOoy6+sw2HIHv
 aE/juUlR/T685C7AcfmwpaZeA6Mtlr9eu/hqU7IAbMksMjXh85lqpBhXuHXQGpVKvgAlR7k
 z3VfXr4KM+35ZPg9bQeQ5FPapJshtHoKV7EoNjFArtbWD868QC3KNHYIekelpw/rpVb5LAB
 A4B0GpIXyGE5ACB6jRBPVQumdpKo3wONv+3qVnOmPSg1gVAqxK5fHugOrHxnQfkgviwQqNa
 fS9jrydVqjJ3RY3aR0CCfIeS51VFXKJKqx/Q4Rawv1sx2TcVc8H+fYMLR5gA==
Received: from webmail.mandelberg.org (mail-web-d031b246.virgo.mandelberg.org [10.0.6.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X448 server-signature ECDSA (secp384r1) server-digest SHA384)
	(No client certificate requested)
	by mail-outbound-e14cf917.virgo.mandelberg.org (Postfix) with ESMTPSA id 4ZDvqZ30DqzySJ;
	Fri, 14 Mar 2025 19:40:58 +0000 (UTC)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 14 Mar 2025 15:40:58 -0400
From: David Mandelberg <david@mandelberg.org>
To: David Mandelberg via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Jacob Keller <jacob.keller@gmail.com>, Junio C
 Hamano <gitster@pobox.com>, david@mandelberg.org
Subject: [PATCH v3 0/2] completion: fix bugs with slashes in remote names
In-Reply-To: <pull.1901.git.git.1740901525.gitgitgadget@gmail.com>
References: <pull.1901.git.git.1740901525.gitgitgadget@gmail.com>
Message-ID: <1587533591c81d38977e62165784f8eb@mandelberg.org>
X-Sender: david@mandelberg.org
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

It's been a bit over a week since the last version of this, with some
discussion, but I don't think any requests for changes. So here's an
updated version with the minor performance change I mentioned in
https://lore.kernel.org/git/fa70c8336f836ebb5b9c196fe291d357@mandelberg.org/

David Mandelberg (2):
  completion: add helper to count path components
  completion: fix bugs with slashes in remote names

 contrib/completion/git-completion.bash |  49 +++++-
 t/t9902-completion.sh                  | 206 ++++++++++++++++++++++---
 2 files changed, 226 insertions(+), 29 deletions(-)

-- 
2.47.2
