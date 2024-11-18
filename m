Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A13419924E
	for <git@vger.kernel.org>; Mon, 18 Nov 2024 14:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731938578; cv=none; b=k1UiKd/ZAK+wdsDK1rTRzwnlR/IdVZ7BDZVkf2HG1cDW9IfheyfbB3A3OuHqwFVbYGIwjx6dFg7tGHvoHNlhFdiutw5lG7brkTwDr3jziyM+sL/zO21Z41ODp8CyIkjyPALNR+fAneOZ0DmFH/FB8T838pNsiXtgIjxUZW1TcIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731938578; c=relaxed/simple;
	bh=rVb4xIqaXpw14u/pq6NjGN2+ZQuz7j8ZyxGDymuBzJA=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WCHJSFpqzmSOwAk17AZPiqFESIDJb7J8bCSLi8wBZ52joUbKo5w1ZlrAwawUfb2L49ojx8Vlmi8pHtsKjcxpr50q8Wowf9dTZNnXTLMESpYn4Rzeg2Yt80bWVAgazE6fO/msH581pypcgZAijqgLBL43KB2RPn7xzUp8gUe5pEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M3zn+i2M; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M3zn+i2M"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-513de426746so1968855e0c.3
        for <git@vger.kernel.org>; Mon, 18 Nov 2024 06:02:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731938576; x=1732543376; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=UOPzgo27dq7lnmadf8YEbMUPvRUxWt/F44dwIPJz2CM=;
        b=M3zn+i2Mb7DKuANix3pd2URMEpweFvNwRlVt0/0IvigmURwnz7vEafshPUJ2X8+djA
         L3/JbIADeKIBgg7eCiFBqsIdiEj4VezYNcZ73aCPf0Q/6bEUq0ym6z1M327xEY99fFad
         WioCOwvGqIg7EZsTm+limTIAq0vaubv3O+4AKa9++PvpRcD+dX1ErtEANolzo3/oHjiq
         Cwm6P0WUT8r8wt4uqFspo01Gob3i0KUcKQplNdv8xUGzJ0q+f8jjF1Cqj5vRywWVt5cs
         v01K96jijkCpKytWqrHYLxfFAP6wOyKgSYk6AsoW0nVTUlHZSnQ5/ah86Yen91ZR0go2
         h1ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731938576; x=1732543376;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UOPzgo27dq7lnmadf8YEbMUPvRUxWt/F44dwIPJz2CM=;
        b=DdLW/A9uLBikM6mBd9sJPHuTkym+64gzhCPvmT3BfCOT3I2FdR2CTj1/R0GQQx01Ky
         K4lj6efzR/41exURNfN7/ATPLCTeEt85V0MQI/1bKfEee1naMu+5j10CfHjF+FczjG3V
         ZjlKDvx9angPLjeqLFH2c+K/y+Tyt+57R5I+bzyvK+YnAu/PZBskUcTpn3xFy2xkR8HU
         IshWmJEGve88kYrd4HVSoOwDsgDqSZhN9U8g9aQviHK+IPTUp+PVtBzsKCsN3xkIiqUA
         40bQw/xkQrCezEcpnzTfMsawVdnbcT2nG0ogfzV7OWHFXzo7C718rDo7cZInTnC25bhE
         w5Mw==
X-Forwarded-Encrypted: i=1; AJvYcCW4Kd/upCjoZXThi2TkbIIokOrFcXt+lCxaxtJsn3QxMNv85zE1+4PN0GHkEDXGGnl/D4U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5Tw3AgOSJsnnpR6itYAEcagEjGDCWCgcXghuEcGsQIR4trRUg
	IVN6M6+cRy6Z20cg3ld70PVX9Di3n4dPhlfIFrazp7rWj7CQc9VizNu2EPxbgfqbDdiNq4avyBX
	fDU858KieE9F463HllaMh5TH/aig=
X-Google-Smtp-Source: AGHT+IEG/Nw+9JIL4Gv3keP9b20tQYECw2pzdHguKv1Io5au5sQ78CBsEU1A2CguOtWz5F6tw+sh7eps2TOiDnxWfgg=
X-Received: by 2002:a05:6122:468c:b0:50d:57df:1522 with SMTP id
 71dfb90a1353d-51478596855mr10789086e0c.6.1731938575958; Mon, 18 Nov 2024
 06:02:55 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 18 Nov 2024 14:02:54 +0000
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <7782652b97545f95c83aef08786c70384e5cfa52.1731047193.git.ps@pks.im>
References: <cover.1729677003.git.ps@pks.im> <cover.1731047193.git.ps@pks.im> <7782652b97545f95c83aef08786c70384e5cfa52.1731047193.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 18 Nov 2024 14:02:54 +0000
Message-ID: <CAOLa=ZQEmzZpH2SLXNgcPLD=CThQgwW4THUiDuPMaOkZWfp_LA@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] reftable/stack: stop using `fsync_component()` directly
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>, Eric Sunshine <sunshine@sunshineco.com>, 
	Justin Tobler <jltobler@gmail.com>
Content-Type: multipart/mixed; boundary="00000000000097f1cf0627305f3a"

--00000000000097f1cf0627305f3a
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

[snip]

> @@ -43,17 +42,28 @@ static int stack_filename(struct reftable_buf *dest, struct reftable_stack *st,
>  	return 0;
>  }
>
> -static ssize_t reftable_fd_write(void *arg, const void *data, size_t sz)
> +static int stack_fsync(const struct reftable_write_options *opts, int fd)
>  {
> -	int *fdp = (int *)arg;
> -	return write_in_full(*fdp, data, sz);
> +	if (opts->fsync)
> +		return opts->fsync(fd);
> +	return fsync(fd);
>  }
>
> -static int reftable_fd_flush(void *arg)
> +struct fd_writer {
> +	const struct reftable_write_options *opts;
> +	int fd;
> +};
> +
> +static ssize_t fd_writer_write(void *arg, const void *data, size_t sz)
>  {
> -	int *fdp = (int *)arg;
> +	struct fd_writer *writer = arg;
> +	return write_in_full(writer->fd, data, sz);

Tangent: eventually we'd also want to get rid of `write_in_full` no?
Since it is also an internal Git implementation.

The patch itself looks good to me.

[snip]

- Karthik

--00000000000097f1cf0627305f3a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 9a349bae443b7a67_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1jN1NRMFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMFFQQy85K2hxaXlNZ25lWEZzZCszUmwxZ04vbThnYQp4Vk5HQUN4UmlD
SjFyL3M3RzJnUzRVSXd4QzR0Mlcyc3ZjZXNWeUtzZ3FvcXpjeERKb0QvZXpzd1FWQVVUVlo2ClAw
R3RtS1VCUEdZaUtTenFya3pDRnFoMHJEdnc5TWdEWTNhdVpaYWFZdWR6TXYxczhLR3pvWGF4Vy9x
c2owVWgKR0NHdDlGTVZGOUFzbkYwWDFtdUFjRDhMUXlsaHI1eU1Pd05Qdk80cTZvTzNBVHhLVktV
TFRtUGY1bjRNWlVmTwo5VUNqVTVLaHVkUmFaSTNYQXBSR1VQRHZaV1BiZGFSUFNmKzc2NzhpNW5Q
cFN4VVhrVWdmWUtRVG5kSmdtRUNVClB6MzkvNFczN0c5OTNSWmNDSUtVV2k4aGRiWk9EeFFCQzZm
Rmh6T1hhWmlQeEFNMlJtOGxWYkxTMElUWDNDbFkKL0ZhQXNpOWt6cnZxSlZNeGZrQTM1NUZTZnJz
U3VienllVlR2NWhONi9SNXdkR0N1WmRKOWdadkF6OWZuTmRiUApCMUhyS0VyQytUVzM1ZVMvekJN
M0F0a2RiSzNYZlZhUFdNbFdSY0xnU2dhSUlLNUQzWlZmUWE1NU1nQ1lDOTJRCmp4cnY2aWVhNi9G
V0xseGw0Um1oZGRPNUJqQVAvK3NVL0krblpXUT0KPUJFWVIKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000097f1cf0627305f3a--
