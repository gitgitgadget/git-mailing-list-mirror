Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0C729E110
	for <git@vger.kernel.org>; Tue, 17 Feb 2026 09:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771319784; cv=pass; b=egzTsXBAe/EAD5fJu4dMq62m2HVpkdpBCUAJ14Vw8rqWulvmY4f+H67T6z/XolMIK2ZcB0mnAoTj7yZjcGLew17K9nXkYB3W/UtK5yAtVnRvAPWreR7qgNuAVLH9wiWhST/qNm277B+LnINdhU4yshhF7HRRjpsvDG5cJLVRCGg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771319784; c=relaxed/simple;
	bh=Qr+KrYh8zfGk/7Q23yKGIsVxlB/8vPWxxbLkpDs/btQ=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sovefk+FLz5btrn+NloxqymeJpxTGy00H23hMCFCsE/1jSIs/NXTx7/rYSth8Rqe5Z4N6ZmEnGlB5tLAOZRxG2gvlT7XX2aABGoSYXPKlhdEO9Rxyn+dSjnlFednKOqncED+Z5ZyVk6/+NXw9oyiPe0cJp7gZJvZ0K4zHa90pok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DpfamYFJ; arc=pass smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DpfamYFJ"
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-5fae34a2163so2354717137.0
        for <git@vger.kernel.org>; Tue, 17 Feb 2026 01:16:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771319782; cv=none;
        d=google.com; s=arc-20240605;
        b=f6Le/jEl2nklPpYimnfFbbjllYlBz+4qc9QQ1OeNAYi1qXan3tMzNKaetunqazI5Zg
         I9Mhuah+zteGkjDeXxepBrAa40LoZCEiuYW0o1GjC2e/ewEiIjv5gjVogvDo3YLinaf6
         uqTCcERLSx86Wx2jIhxiEFBYSsVeJIMoDfEfQQZgnm3y10BS0/GJpbRQ3NF7B9GDG22j
         g4geizbazDqetF3j2IFHPtcnSPiCvbHNasvnTVAeeCJrvo1/wN8Cb7oQBpAZs1khQk1Y
         IT/7iz0W8jPrXirVXtKEIO2nx1MjutJlxgJodtkbwx5ghKvHfZiXIFC+UyM1h4ldbYCV
         UcGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=PwsLNl/oyCSVrkjbM1WHUCqSSnlIRsJ4+6AE+6iQkgY=;
        fh=ty73qu/mjp6olkAb0/G4VGZeH6SWOLNBs8YQa03/qaY=;
        b=RB2m9lQJwZipLeTGW7cYvsH9pvSo7zrKxH4td0V5lCXJOVApeOon7+NpvJq7bRaUYb
         +XK7ifMWvtXehLD37abAgjrH07lcUnhrTciSostiFJSKBezzCmycyey/vb/cmwOtAVpZ
         cCnHryHUsbFhDkrOmlCpyANeWNMvESz1HXHigZAshN+xx5VKbBaiPoBbqa4tqfu30NZP
         HSH6xDNGk1yhZtudbj5dBK/xE+AkDdvIXx7DIIS49B+pMQt8WdRM9ZTCnAzu9BmEEp0n
         i3GNnWNVKWJnKjnWhoBZMR9wlvhJpbYh8LtezOOeDzZhPAxK/cO6BQQJS6FWSBSdjPyl
         fG0g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771319782; x=1771924582; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=PwsLNl/oyCSVrkjbM1WHUCqSSnlIRsJ4+6AE+6iQkgY=;
        b=DpfamYFJxXu478YGUZcpbK5m4959dOa9a5hItvbnqEVh3LPcsAy23jCjKIgUcKO5qB
         vAPVIy5O+GRPRmbQI1xO+Z4Bto/Uu41NusFrp2SdXNiyjxV18k82MClA9PU+8pZQCj0H
         H1VdiZZhwTcFBOhaL7pxCsHpSyNc6Ttf1/e+Q73joDsuM5m9BjlOFRAI9EmRLEv1tsR3
         GOkXlm1GbnQKYGTzUs3yux/0w+K+58uuQOqytG7XgMxzkHYQqlCgWG6AVOxQ5JtsAAmA
         klB/xQkxQ9Uim7RKV5bXfpMKzOWU5BNmjRQSlKRiv+4DdXCPxTbDZ4T6+kUzcoe02AFU
         Nxvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771319782; x=1771924582;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PwsLNl/oyCSVrkjbM1WHUCqSSnlIRsJ4+6AE+6iQkgY=;
        b=EgL5f/qFiK0j83GacJH0iofPXlNxCoydRRjWTaEvtT/mfnlPJe4Wq6Ry38nyWp6euM
         sxIHs7/SNPJZLQvlz+H4Di2rdv9/oIxWZq67jKHhPBgdpWziQ586Dkax+jJJnNXbE1YX
         nxrRs+i5YOxRz7U8CEb7bvOi3HyQA4ODtOXsJOp6TwTIObgxlnUzes9SFAfbm3tBV8RK
         KxQPjHYfndprdF6qoxV2qTUiHrIHwYI9S/z/dw/h9R2QbNEOzqyZV2NbpRnWdJIbS4bT
         3/nmmp/dGT3kr3NE3Lc9vkYhAwgYD6LtZB1vfxpDr32PR9YmodekJtor5tMBenWYy6Fn
         Gxfw==
X-Gm-Message-State: AOJu0YzL7vJd3enW40PtikS/s9haBUu5NIYx2wcnf2BBD3IPjQg9unIX
	Y7WqOEKHc+Sw/4OG4xfyFILoSzbLf+P1cvoIzoMIC1WskcaTIXvy/hMyx+HxK2/QtfzgMf+W5xw
	wWkWWruOjESphlBuK923POi/Rrwu+vV4=
X-Gm-Gg: AZuq6aI9S+JH41PfhyfDy5V92gY7k1pcYih6vm9f26g6xaSZ0Ag84lwKN8QK9M8Redy
	QSbG/TXyb6pLBxRsIfvQplxv3UoWu1cmJ3V3LP3L8WMB18R6LOaEJqAtc7Np2UdtHz80V4uSZQ7
	BHlM8Vhywu6DaNSD2gIO5Fjz1TO1h3ue6aMC5NQMlTw5+O4gx04dS7F2KmEtdwN2r0sKJPhq9Rs
	anb9y+qG3IwRbpyRwArC6jKcrF99EiKS63YsD+RhOFs1PvkmeSQA+kjoX5ESBZGGHfXuEOfPUk2
	59Nu1evjBwaKqGOm9urk4iBmnSpLBSDGtp0jsXW2gg==
X-Received: by 2002:a05:6102:b14:b0:5f1:5c43:936a with SMTP id
 ada2fe7eead31-5fe1ae11154mr5346567137.25.1771319782446; Tue, 17 Feb 2026
 01:16:22 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 17 Feb 2026 04:16:21 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 17 Feb 2026 04:16:21 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <aZQXnwc_90cwPaZ6@pks.im>
References: <20260214-kn-alternate-ref-dir-v6-0-86a82c77cf59@gmail.com>
 <20260214-kn-alternate-ref-dir-v6-3-86a82c77cf59@gmail.com> <aZQXnwc_90cwPaZ6@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 17 Feb 2026 04:16:21 -0500
X-Gm-Features: AaiRm53L81LPDqEpG2f_7YUsHUtge9sZExo6VQgBAlaABsF1k8ILZZaFZFofFR8
Message-ID: <CAOLa=ZRxFBy3cbTxbnAVWM7cbAt1duVKkXN4wmi+r+XLaOfU6Q@mail.gmail.com>
Subject: Re: [PATCH v6 3/6] refs: receive and use the reference storage payload
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>, 
	gitster@pobox.com
Content-Type: multipart/mixed; boundary="0000000000006abb9c064b01867f"

--0000000000006abb9c064b01867f
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Sat, Feb 14, 2026 at 11:34:16PM +0100, Karthik Nayak wrote:
>> diff --git a/refs.c b/refs.c
>> index 77b93d655b..11d028232b 100644
>> --- a/refs.c
>> +++ b/refs.c
>> @@ -3425,3 +3426,40 @@ const char *ref_transaction_error_msg(enum ref_transaction_error err)
>>  		return "unknown failure";
>>  	}
>>  }
>> +
>> +void refs_compute_filesystem_location(const char *gitdir, const char *payload,
>> +				      bool *is_worktree, struct strbuf *refdir,
>> +				      struct strbuf *ref_common_dir)
>> +{
>> +	struct strbuf sb = STRBUF_INIT;
>> +
>> +	*is_worktree = get_common_dir_noenv(ref_common_dir, gitdir);
>> +
>> +	if (!payload) {
>> +		/*
>> +		 * We can use the 'gitdir' as the 'refdir' without appending the
>> +		 * worktree path, as the 'gitdir' here is already the worktree
>> +		 * path and is different from 'commondir' denoted by 'ref_common_dir'.
>> +		 */
>> +		strbuf_addstr(refdir, gitdir);
>> +		return;
>> +	}
>> +
>> +	if (!is_absolute_path(payload)) {
>> +		strbuf_addf(&sb, "%s/%s", ref_common_dir->buf, payload);
>> +		strbuf_realpath(ref_common_dir, sb.buf, 1);
>> +	} else {
>> +		strbuf_realpath(ref_common_dir, payload, 1);
>> +	}
>> +
>> +	strbuf_addbuf(refdir, ref_common_dir);
>> +
>> +	if (*is_worktree) {
>> +		const char *wt_id = strrchr(gitdir, '/');
>> +		if (!wt_id)
>> +			BUG("worktree path does not contain slash ");
>
> There's a trailing space in the error message here.
>
> Patrick

Oops, will fix.

--0000000000006abb9c064b01867f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 70f03c1b05ab769d_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1tVU1lUVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNHI0Qy93S1ZNNC9sTytRYlIxakJXSDNjWVZlK0hBTgpsZ2pkdnVndDNS
MkhRcXcrNW9STENEYzVteVh1NjhpWVFDOFphekRBMkRvanZNWi95NzF5ejRENlEvdExNclFJCnE5
a1A2Y002T3FTbE9DTUpjUnhjZ08rRDJLRUwxRjFVZmtqZlc3Yi9nK0dQQlBPYjhiYXdSbTROL3dY
UGhXV2IKbENoZC84U0hBVWdib2owODNYTzhueWN1WVhoa1BLZHJ6cjNwRU9XSDdBY3IzbW9BaG1p
ZzZoSDd3M3REZmo1cwo2WmhxNG4vc0FiOGxhNitBeWMyMGp6aUJYUlFtOEI3Tk5KTFNsb0Z2ckor
T1BQclE3V09KMkxnNC92em15b0ptCndOTVREN0hpT3ZOVnhneU92UVM1QStoTnRzR2MzbE9wYnFJ
OGFJbEEvTnZ0cGpYTHByT2VGOVRSMzJ1YlJHVlAKODRBZmRjTS9EaHptQ3NwSC96Vm9sT1JpTmNn
RStjdjh5a1NCRGtjcG03ckw0a3pKOFEyckw4cDZqWEtIN2grRwpVbU5rc0N4STlIVlh6V09uM1Z2
MlNvYWNvM3JZWWlGMTdsckxFZk9aaEpwSDVQazJ1Mm1OS3AwK09hcFJHV2F1Cno5aXBDaDVLTW5i
eHU2ald6SjRaNjkyamNXMTROT3V1bk1JK01Haz0KPWgwbmEKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000006abb9c064b01867f--
