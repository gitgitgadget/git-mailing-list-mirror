Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8A8233139
	for <git@vger.kernel.org>; Mon,  9 Dec 2024 16:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733760245; cv=none; b=S37qIMg8hm923DL7QsbzU+x9UblZbc5CXTB0K+XG5MTTWiNCl6HxUvU6QXfMnTc+ZXW7VLEdczPKKnYR7HuZLKZbIEYa2sDMpOu6hFsxL0cQcB3Ly1AK3OytzG3qJVqIF1u1o+zusgiNRfJTi4vXFNV7LO1+KznLNK2ebtaXFLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733760245; c=relaxed/simple;
	bh=jaDhGpWpgcDQ5xGFiAow3ARvPn9eOBy3H/k2K2vIc10=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=jF6UEoPq6oRROFp70561EGwtjWKD7mBOJfPJbHUbcWKOyjjDx4mCBDjh0HyVEeAirQcQQZT1BoKM9f3Btgzk7qTyUdaeG7LoDGJAz8kZQ4dY0+v8/ysjG66ZxkDyYAOj/A/ZfaS+kT3cvECBxq3SGMWTd94drVD3/NNfjUMIurU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A+AW/DT7; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A+AW/DT7"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5d0ac27b412so5745242a12.1
        for <git@vger.kernel.org>; Mon, 09 Dec 2024 08:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733760242; x=1734365042; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hlHrtxQXhGrqRO92CFXgWh/2q8sPUFFN7G+a8YjV/A8=;
        b=A+AW/DT7yhWOWf452JSig5N7REeGjk8PJMwMInCsjHlKh7fPCaaQnJEOPz0h4i7Eu8
         HVT9RjE5fXlUe0hskfe6YIn5FJTWPwirbjh2RZNf6d1sgOR08ZiwzYCj+Ulfy2Bplrx4
         e/mW+TLL+N4BwHqQENOvTe2/vM65POTHtts5Ri9qeLYWrnrk6/c8Us1c8aqaF68YYIOM
         U96SWCysRZlnTXKLL2b3A7Gu4rB4vkWmHnrxPSxEqn3RBjpBSM0E2N2rl4v680n/ZJe0
         WkSTUCL2ZWqAJG2BFTqeeHS8I0R/VJ2HjFIkiunD6oSO1IJgZzZJLZjQnAfSXIMJHW5Y
         UkSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733760242; x=1734365042;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hlHrtxQXhGrqRO92CFXgWh/2q8sPUFFN7G+a8YjV/A8=;
        b=gKdbtCrA2VYd0/CJQ+HUGOO2nuqBicF5wmfUm9nY2jn9HRhjPUQNM20ex9Ux81fWMi
         YQQWnJO+fpcRHuegLKCAnx2SdzbbLItBQ/vqAVm/q7qPswPB7lbGCBRRqguxwWoEhHPo
         0zhz9Xkghahg8xiCfOULSbm9JeF3ReyJkxmuOYmFN8/ZjLK1U7nv3LOVKpGhBwbXL4IA
         tNKF/WVPfa3Uow/vIZSVOszEGM/PGOkJDK8VNqIrOwZTQr1gESZ77GLFzEkQh9SbuhSb
         0ahUQGGRKs3g4TPBZEjoJWDwqU+yUbdNH50TLtJwS4KIMD+4R7WeuJpMeW4ueho2pZxL
         mKmw==
X-Gm-Message-State: AOJu0YxAl3h9b+WPiFEOxSjmJLXA/vFXlKNfZ3J4XFr5Kot9RWgchUgY
	mZvX+23hzUuarxavhwLjjcQACGZSZMEk0K8vlpakQHYQySmL5nnqg4zBbBB2hN5ggqunjs2Thah
	zy7qO+z+/3cDJJ15NVJdbmY1M8cSzSA==
X-Gm-Gg: ASbGncuvNTe7zb+Z2H6/uylnc3Jow2i9gKnvfygGjvsxfS0o3ObeqH61vk2/bDHJm4J
	lLtsoqci+K+VWKInTYdtU50RMzpY=
X-Google-Smtp-Source: AGHT+IFOs/obhN2p2EcNFQSs+iw/aOOM5oYOZu5dNq5iWhbvt6Pz7RuAhATjdGQduMT7eiw/Wog5KaIg6u9NKfesu6w=
X-Received: by 2002:a05:6402:3490:b0:5d0:e410:468b with SMTP id
 4fb4d7f45d1cf-5d418506153mr1454841a12.2.1733760241782; Mon, 09 Dec 2024
 08:04:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Sergey Ivanov <icegood1980@gmail.com>
Date: Mon, 9 Dec 2024 18:03:49 +0200
Message-ID: <CAJCbrz5_8nCWSsb2PYGmQoYDKE2vH5kURx9ePabPjosbJsMH_g@mail.gmail.com>
Subject: git credentials store: removed line when token expired
To: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000568ed00628d883d2"

--000000000000568ed00628d883d2
Content-Type: multipart/alternative; boundary="000000000000568ecf0628d883d0"

--000000000000568ecf0628d883d0
Content-Type: text/plain; charset="UTF-8"

see attached

-- 
Kind regards,
Sergey Ivanov

--000000000000568ecf0628d883d0
Content-Type: text/html; charset="UTF-8"

<div dir="ltr"><div>see attached</div><div><br></div><span class="gmail_signature_prefix">-- </span><br><div dir="ltr" class="gmail_signature" data-smartmail="gmail_signature">Kind regards,<br>Sergey Ivanov</div></div>

--000000000000568ecf0628d883d0--
--000000000000568ed00628d883d2
Content-Type: text/plain; charset="US-ASCII"; name="git-bugreport-2024-12-09-1755.txt"
Content-Disposition: attachment; 
	filename="git-bugreport-2024-12-09-1755.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_m4h82hys0>
X-Attachment-Id: f_m4h82hys0

VGhhbmsgeW91IGZvciBmaWxsaW5nIG91dCBhIEdpdCBidWcgcmVwb3J0IQpQbGVhc2UgYW5zd2Vy
IHRoZSBmb2xsb3dpbmcgcXVlc3Rpb25zIHRvIGhlbHAgdXMgdW5kZXJzdGFuZCB5b3VyIGlzc3Vl
LgoKV2hhdCBkaWQgeW91IGRvIGJlZm9yZSB0aGUgYnVnIGhhcHBlbmVkPyAoU3RlcHMgdG8gcmVw
cm9kdWNlIHlvdXIgaXNzdWUpCjEpIE15IHJlbW90ZSB0b2tlbiB0byBnaXQgcmVwbyB3YXMgZXhw
aXJlZAoyKSBJIGhhdmUgZ2l0IGNvbmZpZyAtLWdsb2JhbCBjcmVkZW50aWFsLmhlbHBlcgpzdG9y
ZQphbmQgaGFkIGxpbmUgd2l0aCBnaXZlbiB1cmwgYWRkZWQgaGVyZQpXaGF0IGRpZCB5b3UgZXhw
ZWN0IHRvIGhhcHBlbj8gKEV4cGVjdGVkIGJlaGF2aW9yKQpHaXQgd2lsbCBzYXkgdGhhdCB0b2tl
biBpcyBub3Qgd29ya2luZwphbmQgd2lsbCBOT1QgdG91Y2ggY3JlZGVudGlhbHMgZmlsZS4KCldo
YXQgaGFwcGVuZWQgaW5zdGVhZD8gKEFjdHVhbCBiZWhhdmlvcikKR2l0IHJlbW92ZXMgd2hvbGUg
dXJrIGZyb20gZ2l0LWNyZWRlbnRpYWxzCmFuZCBzYXlzICdub3QgdG9rZW4nCgpXaGF0J3MgZGlm
ZmVyZW50IGJldHdlZW4gd2hhdCB5b3UgZXhwZWN0ZWQgYW5kIHdoYXQgYWN0dWFsbHkgaGFwcGVu
ZWQ/Ckkgd2FudCBtYW51YWxseSBjaGFuZ2UgdG9rZW4gb25seSwgbm9lIHdob2xlIFVSSyBmb3Jt
YXQgb2Ygd2hpY2ggaQpjb25zdGFudGx5IGZvcmdldHRpbmcKCkFueXRoaW5nIGVsc2UgeW91IHdh
bnQgdG8gYWRkOgoKUGxlYXNlIHJldmlldyB0aGUgcmVzdCBvZiB0aGUgYnVnIHJlcG9ydCBiZWxv
dy4KWW91IGNhbiBkZWxldGUgYW55IGxpbmVzIHlvdSBkb24ndCB3aXNoIHRvIHNoYXJlLgoKCltT
eXN0ZW0gSW5mb10KZ2l0IHZlcnNpb246CmdpdCB2ZXJzaW9uIDIuMzQuMQpjcHU6IHg4Nl82NApu
byBjb21taXQgYXNzb2NpYXRlZCB3aXRoIHRoaXMgYnVpbGQKc2l6ZW9mLWxvbmc6IDgKc2l6ZW9m
LXNpemVfdDogOApzaGVsbC1wYXRoOiAvYmluL3NoCnVuYW1lOiBMaW51eCA2LjguMC00OS1nZW5l
cmljICM0OX4yMi4wNC4xLVVidW50dSBTTVAgUFJFRU1QVF9EWU5BTUlDIFdlZCBOb3YgIDYgMTc6
NDI6MTUgVVRDIDIgeDg2XzY0CmNvbXBpbGVyIGluZm86IGdudWM6IDExLjQKbGliYyBpbmZvOiBn
bGliYzogMi4zNQokU0hFTEwgKHR5cGljYWxseSwgaW50ZXJhY3RpdmUgc2hlbGwpOiAvYmluL2Jh
c2gKCgpbRW5hYmxlZCBIb29rc10KcHJlLWF1dG8tZ2MK
--000000000000568ed00628d883d2--
