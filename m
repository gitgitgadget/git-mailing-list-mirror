Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455A534F486
	for <git@vger.kernel.org>; Tue, 28 Oct 2025 18:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761675583; cv=none; b=j9S0mkTud3AQKHoPz4OCnWneszNWtJyX3RANuC/n5cwCz3WU5co5tXUQraj3OeGFlOah3JehajDNyEAwClaspOCreRjMV31Kh57ZN6w3tUsKH1g82DyUKwhG11z7Awbd+Hgp94ckmbiWBtoscY8+U5mbzv2bWKbvDYuzNMKcJXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761675583; c=relaxed/simple;
	bh=jEMZfreHs2brbCC5X+JZdLCK3Sh7aFl7ZtD3St8XIrM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JLJhm2quJ4HTMrXrb672cBV5TLXo5rg4SUkVbWMcOFBqWqN5tQ/rRcpsQbWrZwXdk9U7s+YlC9ye6xZ4gL0YFV1Od14HCLzL0XBz7koigGCWG44s7xG2J7Xc4Dvyv+j970N+5fIWKeCYKewZwEtEcjwlKtWlfOLnWXRYD2NHJuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CM//RFuj; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CM//RFuj"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-36a448c8aa2so49810001fa.0
        for <git@vger.kernel.org>; Tue, 28 Oct 2025 11:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761675579; x=1762280379; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+hL+IE1yd5u4VDsgych4zUePlW0izkrGJc3wImgjac0=;
        b=CM//RFuj5laCoYxwVgjtCLsdH8TNZzhF9xBumfx55EeniEifPCRsiRk9K4MZd1XzCo
         aZACT2Dupf+xeCu4UgL1pTlgPiHcHtmtXylyihJ3fjNpbflr47+W6XwwEd7minNN1vy9
         k3q8HOO22kyuhbFO7+a7v5/NYM5dspIWS56GN1sDHYHtSqsNlv9k1oqkmMq2K6vxtoTK
         p1vgQUL2ypqmf0RUUZN+RnqNsRMhDmzezfVSV+khe6zpDRL9MWKyyPz5CVZuVw5WLVpE
         TsLn220yfNwd8mYiHQtuTQTgR5oIqyJxSUhgrvWje1hKjmxBZOKeIujKdpQukHbLwCqt
         4++g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761675579; x=1762280379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+hL+IE1yd5u4VDsgych4zUePlW0izkrGJc3wImgjac0=;
        b=GMeXSCCeXXjrVHBfcvrLrsfTO+GH8w881v/fSXaC3JloyKqLGUGavVVXq55tpwq3+7
         v7/5hBk/m+b8hHRToo3ZP6QyC4KKYxCZ5FJrxvLKatobZQkxUxgl9VZrhWAhhKBNnz22
         mX2K8aVV93Bw+vm8o/u5jZQ/Y3h0vu2CMuUUzXdrs/VSohZUKSAmhQYOMbJ/L0bTOZxf
         hYXI14SusPz6khvWRMjrR0r7ZIVloaWCbHyacIiFdV7uyQl5x6SlNDu+C70q/Mu+JgZN
         6hfmsGiYS3XaOOZdFuDfTrlQhRhkR485AOGAEeD0A6xneQE6g8z+eXrXKq+CWJIfAQaM
         IQUw==
X-Gm-Message-State: AOJu0YzdmPA2yKL7rlB67yLBpZxrljlPJznAqzBtoTSxDc6TQGCLvHXg
	fJP5Ob4EvGaYfZbuPRi8pxfPkuOnHNH0YDBScjcsRt9OfcBbphm/deVh1+72O9exbHCBrrSdNrE
	pzpU2b++oFTRo4lshzlCNB6HViWe1Wc4=
X-Gm-Gg: ASbGnctCbx7LIJIIf4LoRhar2xdkJgzDX61n/yoipfGa/3jCFKM5FDHsnOFfVZPcWxA
	flSx2smC0lh7l21crNYooEr/bYrN0H2U2pg/6QPjphuEkKOlF2QmuO8d6wAXZ5i/rBlq8pNd31o
	lCQwqpR5CAFRYQDSdcy4+f0y85mwF4nnJaHmzIP4nZrKnS/DWfB95xSf49CZVONLYGX1bVp+7F8
	wM6gLd/VX09RLkF4/go6ij1vmCqNfu0lw8W3YZOyHEWFYH7G8WPOcuPtwmrFw==
X-Google-Smtp-Source: AGHT+IH+DLiRzJn551nWtPvZohLPtRDh/nQXVvnmFlxomKgXh/GvypbRnyZ0jimnAuIk7S6bG3E30PO1SqvgvKuIkbY=
X-Received: by 2002:a05:651c:23d3:10b0:371:a1d1:7fd1 with SMTP id
 38308e7fff4ca-37a024043d6mr1045631fa.37.1761675579202; Tue, 28 Oct 2025
 11:19:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027004404.2152927-1-sandals@crustytoothpaste.net> <20251027004404.2152927-14-sandals@crustytoothpaste.net>
In-Reply-To: <20251027004404.2152927-14-sandals@crustytoothpaste.net>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Tue, 28 Oct 2025 12:19:27 -0600
X-Gm-Features: AWmQ_bnekcUYFjX7XJZ7aOxEIDXi8YNE_xZtScRcMtxxq6oMlhxJ89jnomGOpzY
Message-ID: <CAH=ZcbBUw0Rm-O=Xc8835dWKYbmK0L1eksONAzRUa0fgdppb5A@mail.gmail.com>
Subject: Re: [PATCH 13/14] rust: add a small wrapper around the hashfile code
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 26, 2025 at 6:44=E2=80=AFPM brian m. carlson
<sandals@crustytoothpaste.net> wrote:

> +use crate::hash::{HashAlgorithm, GIT_MAX_RAWSZ};
> +use std::ffi::CStr;
> +use std::io::{self, Write};
> +use std::os::raw::c_void;

std::os::raw has been deprecated, only std::ffi should be used.

> +/// A writer that can write files identified by their hash or containing=
 a trailing hash.
> +pub struct HashFile {
> +    ptr: *mut c_void,
> +    algo: HashAlgorithm,
> +}
> +
> +impl HashFile {
> +    /// Create a new HashFile.
> +    ///
> +    /// The hash used will be `algo`, its name should be in `name`, and =
an open file descriptor
> +    /// pointing to that file should be in `fd`.
> +    pub fn new(algo: HashAlgorithm, fd: i32, name: &CStr) -> HashFile {
> +        HashFile {
> +            ptr: unsafe { c::hashfd(algo.hash_algo_ptr(), fd, name.as_pt=
r()) },
> +            algo,
> +        }
> +    }

-    pub fn new(algo: HashAlgorithm, fd: i32, name: &CStr) -> HashFile {
-        HashFile {
+    pub fn new(algo: HashAlgorithm, fd: i32, name: &CStr) -> Self {
+        Self {

> +    /// Finalize this HashFile instance.
> +    ///
> +    /// Returns the hash computed over the data.
> +    pub fn finalize(self, component: u32, flags: u32) -> Vec<u8> {
> +        let mut result =3D vec![0u8; GIT_MAX_RAWSZ];
> +        unsafe { c::finalize_hashfile(self.ptr, result.as_mut_ptr(), com=
ponent, flags) };
> +        result.truncate(self.algo.raw_len());
> +        result
> +    }
> +}
> +
> +impl Write for HashFile {
> +    fn write(&mut self, data: &[u8]) -> io::Result<usize> {
> +        for chunk in data.chunks(u32::MAX as usize) {
> +            unsafe {
> +                c::hashwrite(
> +                    self.ptr,
> +                    chunk.as_ptr() as *const c_void,
> +                    chunk.len() as u32,
> +                )
> +            };
> +        }
> +        Ok(data.len())
> +    }
> +
> +    fn flush(&mut self) -> io::Result<()> {
> +        unsafe { c::hashflush(self.ptr) };
> +        Ok(())
> +    }
> +}

It's always nice to implement the _Write_ trait for any type that
consumes &[u8] slices. It makes it easy to use a plethora of standard
library functions.
