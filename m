Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF17E487BF
	for <git@vger.kernel.org>; Tue,  8 Oct 2024 18:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728412269; cv=none; b=B7wdWIPlFbsOMylC8ew8Pv36phoMJ8InUYiPX9nXvbNqlkagILzCsZd+AnM+g24ntZCDQiyCAwyhhfCAxcJ8xC9r4HVWfVMOGsg1RSM3aGzLCAgxgxnaeWuOpxGSmSh5MXPrOZvyyW+Ef4ns0St8T4ZC7hI+oG5ZecXh5RJ7nxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728412269; c=relaxed/simple;
	bh=nGTN5NtIsm7zHKlSKuSfiIia+8heoR1s0IfWw8ywKyw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=RNw7kiTLl+1ua4eFue+ccaJlRU6bkch4B5hK7QE0qLsrMy05JHzWQA0GXR2d169pNOw2VA9cVYb8Lod3VJUkstTO/DAmZM8SCRisBZWavh0nRNVB4o19LoGUabSa/fHPffUSJbf8yvzO3W0DA3lUiuZKZVD6j3rvrmyuEZ90BYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FbRsOqhy; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FbRsOqhy"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5398e3f43f3so6927368e87.2
        for <git@vger.kernel.org>; Tue, 08 Oct 2024 11:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728412266; x=1729017066; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nM0FE5DoFomo60eIBRL1vuwA76xh3Cbq8uoxZFyrPFo=;
        b=FbRsOqhy/sruWwIEvFjsc2lds4Z5Y6JkjcstzC+px1+Hjr5PM6jvixFo1RmyH4VQJP
         to6uNaOaq0MTxj3eEbPV4C4ZmF6RM+CE1/LEpnKLRyImwpPz1UboF/ONylS4wVrNIRWj
         S9AD+vEwjzkClOCBweB7hJN3JPtnOtVnW+TWJKcxJ1alQ2VwROsOO9NI0bciewr/tL3l
         QzWKB3zyKHRCK+U/5WGRYlK/CkQVPPGiHZYiY+azsBWN8wcuVjPFGSNlrWNNlMDhCMob
         YvTw/6nPPNL6uVzXPQHb5A44NuYDmnSxYosoY24URLBa/iLHZWsczejvWlVBsLXeJTor
         YRnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728412266; x=1729017066;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nM0FE5DoFomo60eIBRL1vuwA76xh3Cbq8uoxZFyrPFo=;
        b=UfX3qQWhCzMD2jg1Ojf4HnFi+ztgPcdCAmxtRjKyeF3KdFYAPYSF7V8HqZq6ry7lcQ
         8tglx4nEu2UFwJbwSC6yDbetfoZ/JwTbd5tdzYWadjyrN6ITiPXILO2sPYqi7dyBHOCa
         IEZf05M7l69B0ZE6WdGEMclzLP6dXWf9/x8vz6BRN7YGy7swDsO5lQB6cIt4kNEhdbbf
         qxQZx6SnJbMEkLuww1l0xT9C/GsIOJvefXxZXoMt1yE0j5OGCGHRZRpk0b35axw2RllJ
         MmZSwiw5ENpTsAWO3sCDqB5Pn4R2icxoUDsD/6cHwndlfyeC9gw7ER82jMq9oQ/rqolK
         Lo1g==
X-Gm-Message-State: AOJu0Yzs7ldO3Rntauhdr1UAAGy4KRhfNLDq0RKiX5ST0h9lZxKUhSHr
	smLWmuxb0PnQ2hmbEUq+C/M4Yc2ni/RarVucFRGhNLWW7XWRiF4/3dxBJq3MOgFFEhX0XGrsPmm
	z8h0D/V/hoXGWaxWFEMo9YZSc28c0
X-Google-Smtp-Source: AGHT+IHnZli9jyaold18ow5JBklt/39q4Nl1/bhixvYw/3/aTlfT1jmpcJzjB2gD6X8REoDwOBJ18AWoju43F4oruXM=
X-Received: by 2002:a05:6512:ac7:b0:539:8f68:e032 with SMTP id
 2adb3069b0e04-539ab9e421cmr7327173e87.43.1728412265471; Tue, 08 Oct 2024
 11:31:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Spencer Fretwell <spencer.fretwell@gmail.com>
Date: Tue, 8 Oct 2024 12:30:53 -0600
Message-ID: <CABa71ByU_9g_6OgJ9PsoQ99oyMspucTBqO-RkB_2W4smTr2RNw@mail.gmail.com>
Subject: Verbose Commit Ignore Line Fails via CRLF Line Endings
To: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000001c08cc0623fb579b"

--0000000000001c08cc0623fb579b
Content-Type: text/plain; charset="UTF-8"

gc -v produces CRLF file which does not ignore verbose description.

OSX + git-annex (pre-commit hook disabled just in case)
using subl -w (sublime text 4) as editor, which indicated the change
in line endings
- committing as Unix fixes the issue (workaround, tedious)
- leaving as Windows is the issue

see attached bugreport

--0000000000001c08cc0623fb579b
Content-Type: text/plain; charset="US-ASCII"; name="git-bugreport-2024-10-08-1220.txt"
Content-Disposition: attachment; 
	filename="git-bugreport-2024-10-08-1220.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_m20rxyxr0>
X-Attachment-Id: f_m20rxyxr0

VGhhbmsgeW91IGZvciBmaWxsaW5nIG91dCBhIEdpdCBidWcgcmVwb3J0IQpQbGVhc2UgYW5zd2Vy
IHRoZSBmb2xsb3dpbmcgcXVlc3Rpb25zIHRvIGhlbHAgdXMgdW5kZXJzdGFuZCB5b3VyIGlzc3Vl
LgoKV2hhdCBkaWQgeW91IGRvIGJlZm9yZSB0aGUgYnVnIGhhcHBlbmVkPyAoU3RlcHMgdG8gcmVw
cm9kdWNlIHlvdXIgaXNzdWUpCgotIGdjIC12CgpXaGF0IGRpZCB5b3UgZXhwZWN0IHRvIGhhcHBl
bj8gKEV4cGVjdGVkIGJlaGF2aW9yKQoKLSBsaW5lIGVuZGluZ3MgcmVzcGVjdCBPUwotIGdjIHdp
dGhvdXQgLXYgdXNlcyBVbml4IGxpbmUgZW5kaW5ncwotIGxpbmUgZW5kaW5nIGlzIHZpc2libGUg
aW4gc3VibGltZSAoZWRpdG9yID0gc3VibCAtdykKCldoYXQgaGFwcGVuZWQgaW5zdGVhZD8gKEFj
dHVhbCBiZWhhdmlvcikKCi0gZ2MgLXYgdXNlcyBDUkxGIChXaW5kb3dzKSBsaW5lIGVuZGluZ3MK
LSBhcyBzZWVuIGluIHN1YmxpbWUgKGVkaXRvciA9IHN1YmwgLXcpCgpXaGF0J3MgZGlmZmVyZW50
IGJldHdlZW4gd2hhdCB5b3UgZXhwZWN0ZWQgYW5kIHdoYXQgYWN0dWFsbHkgaGFwcGVuZWQ/Cgot
IHVzZSBvZiBDUkxGIGlzIGxlYXZpbmcgdmVyYm9zZSBvdXRwdXQgaW4gY29tbWl0IG1lc3NhZ2UK
CkFueXRoaW5nIGVsc2UgeW91IHdhbnQgdG8gYWRkOgoKUGxlYXNlIHJldmlldyB0aGUgcmVzdCBv
ZiB0aGUgYnVnIHJlcG9ydCBiZWxvdy4KWW91IGNhbiBkZWxldGUgYW55IGxpbmVzIHlvdSBkb24n
dCB3aXNoIHRvIHNoYXJlLgoKCltTeXN0ZW0gSW5mb10KZ2l0IHZlcnNpb246CmdpdCB2ZXJzaW9u
IDIuNDYuMgpjcHU6IGFybTY0Cm5vIGNvbW1pdCBhc3NvY2lhdGVkIHdpdGggdGhpcyBidWlsZApz
aXplb2YtbG9uZzogOApzaXplb2Ytc2l6ZV90OiA4CnNoZWxsLXBhdGg6IC9iaW4vc2gKZmVhdHVy
ZTogZnNtb25pdG9yLS1kYWVtb24KbGliY3VybDogOC40LjAKemxpYjogMS4yLjEyCnVuYW1lOiBE
YXJ3aW4gMjMuNi4wIERhcndpbiBLZXJuZWwgVmVyc2lvbiAyMy42LjA6IE1vbiBKdWwgMjkgMjE6
MTM6MDQgUERUIDIwMjQ7IHJvb3Q6eG51LTEwMDYzLjE0MS4yfjEvUkVMRUFTRV9BUk02NF9UNjAy
MCBhcm02NApjb21waWxlciBpbmZvOiBjbGFuZzogMTUuMC4wIChjbGFuZy0xNTAwLjMuOS40KQps
aWJjIGluZm86IG5vIGxpYmMgaW5mb3JtYXRpb24gYXZhaWxhYmxlCiRTSEVMTCAodHlwaWNhbGx5
LCBpbnRlcmFjdGl2ZSBzaGVsbCk6IC9iaW4venNoCgoKW0VuYWJsZWQgSG9va3NdCnBvc3QtY2hl
Y2tvdXQKcG9zdC1tZXJnZQpwb3N0LXJlY2VpdmU=
--0000000000001c08cc0623fb579b--
