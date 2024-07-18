Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08AC8C06
	for <git@vger.kernel.org>; Thu, 18 Jul 2024 19:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721329868; cv=none; b=WnXCxgBZd4wle8vPQPsayNqF7Q2sqNZBU7Ao3FzCk390RbilJqizGxJE61V0hlwSXy0xkJUEwAWnI/6SQBD4K7B9bCKDWbBvNDM/PYgzkF1SzXy87F8XQajuD7CBxby824EhNzwuKQCuuEwWWK6aLYS1eCdxZs2hKhuRRehP+Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721329868; c=relaxed/simple;
	bh=XEOPrg2dvpfGN0x0U9lnGcfYdehp4c9ccjnBa9y0UCU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=giOwsA4ofDpEQQq9mSLnr6E/qRvB2Ls8h6QHrPZdFP7qHb6Z7PTzoxCXgx9rczOntBAwIv4od922aaMCVnSxgAovAp6ZwQGtl3u17E8QwxAM7gCx/gKLeLNKrIOoVFOHD3YeVAiVKY/4Ru+3MzVz5C8WIRaAyWmCoXptS6Ib6JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ASYjXFQ9; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ASYjXFQ9"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6510c0c8e29so11531227b3.0
        for <git@vger.kernel.org>; Thu, 18 Jul 2024 12:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721329866; x=1721934666; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Sz414l20AWdyBcF95XgYxzaJCJj7r6j6mL3t2HZn55Y=;
        b=ASYjXFQ9+spTYI6R6LJV2Jne/F+FXRsjQWYjkKEvbkz26FyNAhUPO9+RlowzdLwTRD
         WvbJ+vkJP55mfOqFiWp80HehbMFg6/y2lC5JOZ8RPy9fqihHPDzS6q4hje4XqCA0+g21
         C8JvGS85mO/YdfZRz5kbglpYlRqJs7OyT5QEXQB5jV7JnBTkADAoaYE55EXrmCIYno6C
         zLOgW7DqnR6A+sJ87aP8ffY81oIjPxViuBEqmU3BlYnJYJHHlzSJnl2XpHRb4mNhXTdm
         DBoreRfqrp80TIlbrZvsGsKhXnMwEdhUNa24pxX4YJQQJIawQTtCGeC6jE5C3ugbcoM3
         JCTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721329866; x=1721934666;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Sz414l20AWdyBcF95XgYxzaJCJj7r6j6mL3t2HZn55Y=;
        b=oWGYB8JQFzTMlYk44p7bT8G8Z+CGUPoMT4I12hav5Pt+g25H7vFx0kjsYSe8lvjBAn
         p6TjEJRJti3cBajzdjFexAXaZxc3ziUZZqi+198CUzFfSsxOJzTusF3Bosil5A2zAenE
         VJ1EHOKTmd3oXmxGoibToGR2Km01na4FoCgoyBMqqT0kKhcV+jtWaHPzg07qQhERyLNA
         NcgkhHUcMb4+StUKqhLJZbVWZlSSebVx2acWI1KB3YzznSwtGW0VrPqy4n4/hOK62vD2
         EYgTbLWdV9oIDrbR+vrpR0jvc0ifn/OeAQqRYlgHU/iLyeS0J6dGPFVq+weUisMUmJX/
         6vZg==
X-Gm-Message-State: AOJu0YztIMPvAGamemfkp3kMZASIsnJlBAf1QR5b7ESO6N9COG+lcJHz
	g2z70FytU4Wdt77aAna5Gw56L9wL2ld++gF7vC8Oj2veqUahSlE8DRd0MEdBnNx8c6X/yPUU2x8
	iEXDPUd9lAzGq5tVfE2hP0l0pcxOhKw==
X-Google-Smtp-Source: AGHT+IGGzAn1YB24GAAT6U+oTez+/FRwEXwiKwukV31Xhw1KqK2jHcWiFrCN9I2mED2Wm+p5Uz0G6dc58cH0gVlhloE=
X-Received: by 2002:a0d:c881:0:b0:65f:7765:9687 with SMTP id
 00721157ae682-664fe83e787mr66142287b3.11.1721329865837; Thu, 18 Jul 2024
 12:11:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jeffrey Barish <jeffbarish73@gmail.com>
Date: Thu, 18 Jul 2024 13:10:54 -0600
Message-ID: <CAKjFfK_vcD-36LqYDMfEEjMARGQKFMQbKH7GqUPzrEjU-_HuQw@mail.gmail.com>
Subject: Bug
To: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000031edb2061d8a57d0"

--00000000000031edb2061d8a57d0
Content-Type: multipart/alternative; boundary="00000000000031edb0061d8a57ce"

--00000000000031edb0061d8a57ce
Content-Type: text/plain; charset="UTF-8"

-- 
Jeffrey Barish

--00000000000031edb0061d8a57ce
Content-Type: text/html; charset="UTF-8"

<div dir="ltr"><br clear="all"><div><br></div><span class="gmail_signature_prefix">-- </span><br><div dir="ltr" class="gmail_signature" data-smartmail="gmail_signature"><div dir="ltr">Jeffrey Barish</div></div></div>

--00000000000031edb0061d8a57ce--
--00000000000031edb2061d8a57d0
Content-Type: text/plain; charset="US-ASCII"; name="git-bugreport-2024-07-18-1259.txt"
Content-Disposition: attachment; 
	filename="git-bugreport-2024-07-18-1259.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_lyrnbpea0>
X-Attachment-Id: f_lyrnbpea0

VGhhbmsgeW91IGZvciBmaWxsaW5nIG91dCBhIEdpdCBidWcgcmVwb3J0IQpQbGVhc2UgYW5zd2Vy
IHRoZSBmb2xsb3dpbmcgcXVlc3Rpb25zIHRvIGhlbHAgdXMgdW5kZXJzdGFuZCB5b3VyIGlzc3Vl
LgoKV2hhdCBkaWQgeW91IGRvIGJlZm9yZSB0aGUgYnVnIGhhcHBlbmVkPyAoU3RlcHMgdG8gcmVw
cm9kdWNlIHlvdXIgaXNzdWUpCgpJIGRpZDoKPGNyZWF0ZSBhIG5ldyByZXBvc2l0b3J5PgpnaXQg
aW5pdApnaXQgYWRkIC4KZ2l0IGNvbW1pdCAtbSAiSW5pdGlhbCBjb21taXQiCmdpdCByZW1vdGUg
YWRkIG9yaWdpbiBodHRwczovL2dpdGh1Yi5jb20vamVmZmJhcmlzaC93YXgKZ2l0IHB1c2ggLXUg
b3JpZ2luIG1hc3RlcgoKV2hhdCBkaWQgeW91IGV4cGVjdCB0byBoYXBwZW4/IChFeHBlY3RlZCBi
ZWhhdmlvcikKCkkgZXhwZWN0ZWQgbXkgZmlsZXMgdG8gZ2V0IHB1c2hlZCB0byBteSByZXBvc2l0
b3J5LgoKV2hhdCBoYXBwZW5lZCBpbnN0ZWFkPyAoQWN0dWFsIGJlaGF2aW9yKQoKSSBnb3QgYSBw
b3B1cCB3aW5kb3cgZGVtYW5kaW5nIGEgcGFzc3dvcmQgZm9yIGEgdXNlcm5hbWUgdGhhdCBhcHBl
YXJzIHRvIGJlIGEgcmFuZG9tIHN0cmluZyBvZiBjaGFyYWN0ZXJzLgoKV2hhdCdzIGRpZmZlcmVu
dCBiZXR3ZWVuIHdoYXQgeW91IGV4cGVjdGVkIGFuZCB3aGF0IGFjdHVhbGx5IGhhcHBlbmVkPwoK
VGhlIGZpbGVzIHNob3VsZCBiZSB0cmFuc2ZlcnJlZCwgb3IsIGF0IHdvcnN0LCBJIHNob3VsZCBn
ZXQgYSByZXF1ZXN0IGZvciBhIHBhc3N3b3JkIGZvciB1c2VybmFtZSBqZWZmYmFyaXNoCgpBbnl0
aGluZyBlbHNlIHlvdSB3YW50IHRvIGFkZDoKCkkgYW0gcHJlcGFyZWQgdG8gZGVsZXRlIG15IGFj
Y291bnQgYW5kIHN0YXJ0IG92ZXIsIGJ1dCBJIGRvIG5vdCBzZWUgYSB3YXkgdG8gZG8gdGhhdC4g
SW4gYW55IGNhc2UsIEkgd29uZGVyIHdoZXRoZXIgdGhlcmUgaXMgYSBiZXR0ZXIgc29sdXRpb24u
CgpQbGVhc2UgcmV2aWV3IHRoZSByZXN0IG9mIHRoZSBidWcgcmVwb3J0IGJlbG93LgpZb3UgY2Fu
IGRlbGV0ZSBhbnkgbGluZXMgeW91IGRvbid0IHdpc2ggdG8gc2hhcmUuCgoKW1N5c3RlbSBJbmZv
XQpnaXQgdmVyc2lvbjoKZ2l0IHZlcnNpb24gMi40My4wCmNwdTogeDg2XzY0Cm5vIGNvbW1pdCBh
c3NvY2lhdGVkIHdpdGggdGhpcyBidWlsZApzaXplb2YtbG9uZzogOApzaXplb2Ytc2l6ZV90OiA4
CnNoZWxsLXBhdGg6IC9iaW4vc2gKdW5hbWU6IExpbnV4IDYuOC4wLTM4LWdlbmVyaWMgIzM4LVVi
dW50dSBTTVAgUFJFRU1QVF9EWU5BTUlDIEZyaSBKdW4gIDcgMTU6MjU6MDEgVVRDIDIwMjQgeDg2
XzY0CmNvbXBpbGVyIGluZm86IGdudWM6IDEzLjIKbGliYyBpbmZvOiBnbGliYzogMi4zOQokU0hF
TEwgKHR5cGljYWxseSwgaW50ZXJhY3RpdmUgc2hlbGwpOiAvYmluL2Jhc2gKCgpbRW5hYmxlZCBI
b29rc10K
--00000000000031edb2061d8a57d0--
