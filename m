Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902BE12E52
	for <git@vger.kernel.org>; Wed, 20 Mar 2024 22:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710973858; cv=none; b=IWJJhMtpFaXMrcjXROCnteuFoUzZrEFUGlXDm4OOY3yC4KFpUBsgRNkkoWf6cGaTrd9eWah+bRJOuBZz1iT1BL2AWlAGdwHwP/tyvwq2ybo8x26NL5nfgHetjmWWf2B2q2A3JvmlpTrOPrrVxXn3LltlBDnwR89iAsfgXxaCGEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710973858; c=relaxed/simple;
	bh=oLf8qtcZkdzHcrdj+9vR2Fw1xm2xh1tUwd965W/ORP0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=L2t2BbKfnxm8YiUkgK/u2dB6a9TcJ42wSYq6msj+i4fR4gPmK0/i6zDw+Fw9ixbfrGMMtuFlE/t6uxQc+/xBGR6l5FJMOpfXT+CQN+kW3krdTYkL6NnDbX4ltuyQn/BxjAvxL5LkCIa6v8CwvplwFikwkS8pf2xix7YNE//mjuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iZ+wgNuR; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iZ+wgNuR"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dc6dcd9124bso306455276.1
        for <git@vger.kernel.org>; Wed, 20 Mar 2024 15:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710973855; x=1711578655; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=L542t1TK5avEA7tDRbsQDkvaK0Qf6RtiXC5hHKHTNPk=;
        b=iZ+wgNuRX3pgD2TpfWLMArrw23h38ggZnE/8t8BL/5wp0O2Dxof7ed6PY9K+WDhGk9
         g6z33+5w2x6htShQbNhgwkwMEXNlWXcz9vG+vPlS4Izl0BJ+WKEvG5ruz8Gpksbqo9n7
         YjwJXwvD0GtxeIaoQfESji1gGkUV5P+GQOn1dW+dRNWlAro7wmwhp2enhtJry3cn0kpc
         qRR/A3cZJxonFigUqDhUXfyaHk8wZlF2y1GRyKIyyIl6w7FRb4vesGT9V8QVHVR2yBVK
         qBEtyz11KAyUq4eqA2RjI4gzqjqReS9wUC3euL/ObXHNCOFFbWBgqe8S07jBl0AXFIoR
         MyKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710973855; x=1711578655;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L542t1TK5avEA7tDRbsQDkvaK0Qf6RtiXC5hHKHTNPk=;
        b=kEzYq5hOEb9mn2oLUpkFTc+iq603rQuTH07yavraLVt0qzH1ivCZGB9ZM7xQ31MEaq
         e0p7q6udJ3MjMttpTYLWoWpEQOLupU0flFjcodEQ3Tz8Gr2X6IfK7G6iwWvEjsUZAbca
         9J/KMJK1D/THmvQwxvcvJDJAmVUGz0bhlpK1xKy1ApsmBSlfzCl+qZR4J+CVCi+6XDQe
         SmVCrB9bav3BVbjEgbBF0Y3dzwdrprCz+v0LGGiLnei9eWl20gwLFZUruZ5yEVOm8odo
         uoO7Cxr0RRtwrtj7c+Yrb7sr8n2tPA5NGDbYB5ep45FthAFhIECGUrKrboGddJWL2AUl
         G85Q==
X-Gm-Message-State: AOJu0Yysk1yLzLQiN+L1282cRZWEq8JKRuRbh2atHKr6YB9TlnJEEhjM
	sSZsoXvQzpxQ12gf70cu34fuqW40MTPc7dV0LLdN+6NzHGjW/6BF399SwAp6cA+aJEPtKttMbI0
	UwPxQEtMh3LkVpY1hqihVQVQw/lmrFCndzfo=
X-Google-Smtp-Source: AGHT+IFyoMWqcjLRezXyD79HlKp/wBXGjVfpTUWecqCSWmUj6U90+W+YzYCHgo5qHbYxnNsC5h4XPaWKVdmzH+0+yOE=
X-Received: by 2002:a5b:b8b:0:b0:dcc:2f94:591a with SMTP id
 l11-20020a5b0b8b000000b00dcc2f94591amr229088ybq.12.1710973854740; Wed, 20 Mar
 2024 15:30:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Akhil Surapuram <surapuramakhil@gmail.com>
Date: Wed, 20 Mar 2024 18:30:43 -0400
Message-ID: <CA+m=7Rz3rpnJpt_w6dQWd3=7AaHxYgzU2+ynCo0KQ6r_0oitJA@mail.gmail.com>
Subject: Git Bug - while working with different remotes and different branch
 name on local and remote
To: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000d52dc306141f2457"

--000000000000d52dc306141f2457
Content-Type: multipart/alternative; boundary="000000000000d52dc106141f2455"

--000000000000d52dc106141f2455
Content-Type: text/plain; charset="UTF-8"

- PFA

-- 
Regards,
*Akhil Surapuram*
*https://www.linkedin.com/in/surapuramakhil/
<https://www.linkedin.com/in/surapuramakhil/>*

--000000000000d52dc106141f2455
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">- PFA <br clear=3D"all"><div><br><span class=3D"gmail_sign=
ature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature" data=
-smartmail=3D"gmail_signature"><div dir=3D"ltr"><div><div dir=3D"ltr"><div>=
<div dir=3D"ltr"><div>Regards,</div><div><b><font color=3D"#444444" size=3D=
"4">Akhil Surapuram</font></b></div><div><font color=3D"#444444" size=3D"4"=
><b><a href=3D"https://www.linkedin.com/in/surapuramakhil/" target=3D"_blan=
k">https://www.linkedin.com/in/surapuramakhil/</a></b><br></font></div></di=
v></div></div></div></div></div></div></div>

--000000000000d52dc106141f2455--
--000000000000d52dc306141f2457
Content-Type: text/plain; charset="US-ASCII"; name="git-bugreport-2024-03-20-1819.txt"
Content-Disposition: attachment; 
	filename="git-bugreport-2024-03-20-1819.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_lu0dmuin0>
X-Attachment-Id: f_lu0dmuin0

VGhhbmsgeW91IGZvciBmaWxsaW5nIG91dCBhIEdpdCBidWcgcmVwb3J0IQpQbGVhc2UgYW5zd2Vy
IHRoZSBmb2xsb3dpbmcgcXVlc3Rpb25zIHRvIGhlbHAgdXMgdW5kZXJzdGFuZCB5b3VyIGlzc3Vl
LgoKV2hhdCBkaWQgeW91IGRvIGJlZm9yZSB0aGUgYnVnIGhhcHBlbmVkPyAoU3RlcHMgdG8gcmVw
cm9kdWNlIHlvdXIgaXNzdWUpCgphZGRlZCB0d28gcmVtdG9lIG9mIGEgcHJvamVjdC4gb25lIGlz
IHNvdXJjZSBhbmQgb3RoZXIgaXMgZm9ya2VkCmNyZWF0ZWQgYSBicmFuY2ggd2l0aCB0aGlzIG5h
bWluZyBjb25lY3Rpb24gPHJlbW90ZS1uYW1lPi08YnJhbmNoX25hbWU+LiBJIHVzZSBfIGluc3Rl
YWQgb2YgLSBmb3Igc3BhY2VzIGluIGJyYW5jaCBuYW1lcy4KbXkgYnJhbmNoIG5hbWUgaXMgbG9j
YWwgaXMgZGlmZmVyZW50IGZyb20gbXkgYnJhbmNoIG5hbWUgaXMgcmVtb3RlLgpJIGRpZCBnaXQg
cHVzaCB1c2luZyB0aGUgY29tbWFkIHdoaWNoIHNldHMgdXBzdHJlYW0gCgpnaXQgcHVzaCAtdSBy
ZW1vdGVfbmFtZSBsb2NhbF9icmFuY2g6cmVtb3RlX2JyYW5jaAoKcHVzaCB3b3Jrcy4gYnV0IGl0
IGZvcmdldCB0byB1c2UgcmVtZWJlcmVkIGNvbmZpZ3MgZm9yIG5leHQgcHVzaC4KCldoYXQgZGlk
IHlvdSBleHBlY3QgdG8gaGFwcGVuPyAoRXhwZWN0ZWQgYmVoYXZpb3IpCgppdCBzaG91ZCByZW1l
bWJlciBteSBjb25maWdzIGFuZCB3aGVuIGkgcGVyZm9ybSBnaXQgcHVzaCBpdCBzaG91bGQgYXV0
b21hdGljYWxseSBwdXNoIHRvIGNvbmZpZ3VyZWQgcmVtb3RlLgoKV2hhdCBoYXBwZW5lZCBpbnN0
ZWFkPyAoQWN0dWFsIGJlaGF2aW9yKQoKaXQgdGhyb3dzIGVycm9yLiBJIGhhdmUgYXR0YWNoZWQg
ZXJyb3IgYWxvbmcgd2l0aCBlc3NlbnRpYWwgZGVidWcgaW5mb3JtYXRpb24KCihiYXNlKSBha2hp
bHN1cmFwdXJhbUBBa2hpbHMtTWFjQm9vay1Qcm8gaW5jdWJhdG9yLWFuc3dlciAlIGdpdCBwdXNo
CmZhdGFsOiBUaGUgdXBzdHJlYW0gYnJhbmNoIG9mIHlvdXIgY3VycmVudCBicmFuY2ggZG9lcyBu
b3QgbWF0Y2gKdGhlIG5hbWUgb2YgeW91ciBjdXJyZW50IGJyYW5jaC4gIFRvIHB1c2ggdG8gdGhl
IHVwc3RyZWFtIGJyYW5jaApvbiB0aGUgcmVtb3RlLCB1c2UKCiAgICBnaXQgcHVzaCBha2hpbC1h
bnN3ZXIgSEVBRDp0YWdfcmVsYXRpb25zX3JlZmFjdG9yCgpUbyBwdXNoIHRvIHRoZSBicmFuY2gg
b2YgdGhlIHNhbWUgbmFtZSBvbiB0aGUgcmVtb3RlLCB1c2UKCiAgICBnaXQgcHVzaCBha2hpbC1h
bnN3ZXIgSEVBRAoKVG8gY2hvb3NlIGVpdGhlciBvcHRpb24gcGVybWFuZW50bHksIHNlZSBwdXNo
LmRlZmF1bHQgaW4gJ2dpdCBoZWxwIGNvbmZpZycuCgpUbyBhdm9pZCBhdXRvbWF0aWNhbGx5IGNv
bmZpZ3VyaW5nIGFuIHVwc3RyZWFtIGJyYW5jaCB3aGVuIGl0cyBuYW1lCndvbid0IG1hdGNoIHRo
ZSBsb2NhbCBicmFuY2gsIHNlZSBvcHRpb24gJ3NpbXBsZScgb2YgYnJhbmNoLmF1dG9TZXR1cE1l
cmdlCmluICdnaXQgaGVscCBjb25maWcnLgoKKGJhc2UpIGFraGlsc3VyYXB1cmFtQEFraGlscy1N
YWNCb29rLVBybyBpbmN1YmF0b3ItYW5zd2VyICUgZ2l0IHJldi1wYXJzZSAtLWFiYnJldi1yZWYg
LS1zeW1ib2xpYy1mdWxsLW5hbWUgQHt1cHN0cmVhbX0KYWtoaWwtYW5zd2VyL3RhZ19yZWxhdGlv
bnNfcmVmYWN0b3IKKGJhc2UpIGFraGlsc3VyYXB1cmFtQEFraGlscy1NYWNCb29rLVBybyBpbmN1
YmF0b3ItYW5zd2VyICUgZ2l0IHN0YXR1cwpPbiBicmFuY2ggYWtoaWwtdGFnX3JlbGF0aW9uc19y
ZWZhY3RvcgpZb3VyIGJyYW5jaCBpcyB1cCB0byBkYXRlIHdpdGggJ2FraGlsLWFuc3dlci90YWdf
cmVsYXRpb25zX3JlZmFjdG9yJy4KClVudHJhY2tlZCBmaWxlczoKICAodXNlICJnaXQgYWRkIDxm
aWxlPi4uLiIgdG8gaW5jbHVkZSBpbiB3aGF0IHdpbGwgYmUgY29tbWl0dGVkKQogICAgICAgIC5n
aXQtYnVncmVwb3J0LTIwMjQtMDMtMjAtMTgxOS50eHQuc3dwCiAgICAgICAgZ2l0LWJ1Z3JlcG9y
dC0yMDI0LTAzLTIwLTE4MTkudHh0Cgpub3RoaW5nIGFkZGVkIHRvIGNvbW1pdCBidXQgdW50cmFj
a2VkIGZpbGVzIHByZXNlbnQgKHVzZSAiZ2l0IGFkZCIgdG8gdHJhY2spCihiYXNlKSBha2hpbHN1
cmFwdXJhbUBBa2hpbHMtTWFjQm9vay1Qcm8gaW5jdWJhdG9yLWFuc3dlciAlIAoKV2hhdCdzIGRp
ZmZlcmVudCBiZXR3ZWVuIHdoYXQgeW91IGV4cGVjdGVkIGFuZCB3aGF0IGFjdHVhbGx5IGhhcHBl
bmVkPwoKQW55dGhpbmcgZWxzZSB5b3Ugd2FudCB0byBhZGQ6CgpQbGVhc2UgcmV2aWV3IHRoZSBy
ZXN0IG9mIHRoZSBidWcgcmVwb3J0IGJlbG93LgpZb3UgY2FuIGRlbGV0ZSBhbnkgbGluZXMgeW91
IGRvbid0IHdpc2ggdG8gc2hhcmUuCgoKW1N5c3RlbSBJbmZvXQpnaXQgdmVyc2lvbjoKZ2l0IHZl
cnNpb24gMi4zOS4zIChBcHBsZSBHaXQtMTQ2KQpjcHU6IGFybTY0Cm5vIGNvbW1pdCBhc3NvY2lh
dGVkIHdpdGggdGhpcyBidWlsZApzaXplb2YtbG9uZzogOApzaXplb2Ytc2l6ZV90OiA4CnNoZWxs
LXBhdGg6IC9iaW4vc2gKZmVhdHVyZTogZnNtb25pdG9yLS1kYWVtb24KdW5hbWU6IERhcndpbiAy
My4zLjAgRGFyd2luIEtlcm5lbCBWZXJzaW9uIDIzLjMuMDogV2VkIERlYyAyMCAyMTozMDo1OSBQ
U1QgMjAyMzsgcm9vdDp4bnUtMTAwMDIuODEuNX43L1JFTEVBU0VfQVJNNjRfVDYwMzAgYXJtNjQK
Y29tcGlsZXIgaW5mbzogY2xhbmc6IDE1LjAuMCAoY2xhbmctMTUwMC4zLjkuNCkKbGliYyBpbmZv
OiBubyBsaWJjIGluZm9ybWF0aW9uIGF2YWlsYWJsZQokU0hFTEwgKHR5cGljYWxseSwgaW50ZXJh
Y3RpdmUgc2hlbGwpOiAvYmluL3pzaAoKCltFbmFibGVkIEhvb2tzXQo=
--000000000000d52dc306141f2457--
