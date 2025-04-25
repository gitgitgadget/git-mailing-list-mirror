Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9879E1B87F0
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 18:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745604911; cv=none; b=pTwRacwuyHZ++kVG3/D83kk0w9KHr/w+UFjGVV/LJ/BTBNkLZsiZgihKN0DSXIlnC/bv2ZRFXxwCvl0SKDpinZXMIJvwwwfI04k+nKGuUKnFdimz6oO74BEvhZDpfsTp+cCqWNgSeuMeyflU1wu6WQhl5TFiBGvs+m+yLdDNCqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745604911; c=relaxed/simple;
	bh=AdEkrfidJiySxp+XM5uGfa4vmrFl1Sp8AxKhNVwJOrU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=mJQMmlTaDmLFSZjfSx9m8ob1Z73Zr/UloA500H2Hjktk23aQoLkrn8KCmng41HBE/6r5yYvzuR6xH7/YwJRrpsxpyoosSsWN2j4vhgLGVx0ZEllRbTigih0BjUb2kwpSrFeM6PPjcmfSp6cxI/Y1IMZk3UvbnaGd+DOjT3KENdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=applied.co; spf=pass smtp.mailfrom=applied.co; dkim=pass (2048-bit key) header.d=applied.co header.i=@applied.co header.b=TMi/30We; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=applied.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=applied.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=applied.co header.i=@applied.co header.b="TMi/30We"
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-227d6b530d8so30212145ad.3
        for <git@vger.kernel.org>; Fri, 25 Apr 2025 11:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=applied.co; s=google; t=1745604906; x=1746209706; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JGN6gtlrpebqsXwY/vhYnnKQNmvM/1X436JeC6TaSIE=;
        b=TMi/30WeUllFTZvb310/+r2HqXJiFUE9JzyE54VoIfV0+veIj79nQdYs/aLmVnVa7O
         aCIOibXE2AjsdTKDxDKpU1eSvofxIakfZUKLwkOFIXiGYTaXvBSyJIGaN6UlKzQ555Cv
         uUXIUk/frIWWplUPw91UDeDM+zruoxXit9wCkgW7fFt0xfUF5HQdXAZRaxZQA5vH+tye
         4ViAAqBz4SrMQNlus1VzzRRwIqe6g7d7s81MuRU048PVq0PtySr7yVYulwaAJ9TPFADF
         6qs3Mw2b+/m9HhPInpUOJrt4B4PfOHOAGhO1hOTarRXO2f1iMG6grs+TZxAvdYZbAvxT
         3r2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745604906; x=1746209706;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JGN6gtlrpebqsXwY/vhYnnKQNmvM/1X436JeC6TaSIE=;
        b=NNcydWSSxGr2bGdLofZYPozd3TguxTYUh49PTNeZKf6jLFN9EjgrbnaF1RCV2zKxpI
         UZT7cvABWzyBfbaZ9d/ncP5JzgQyvVwWN77VObQCk+ha1CkHTyjaPjaUjvXIMyjoK224
         u148WtQ0P9T5/YFK3P/rWlHG5NM1ZczgxdwPar/l4aKE8iZoDcf+z6ux2+qh2dzvl49Y
         jkMJAcchp7xB2poAgExFJKmypYQtUDP5V95cJbfq4UCd5gefvy6KRezICHfKlORPU9dP
         Ualiety2UcJX5zYpRYFgzeEZ5ZRLTkK+wZF51/v5xyGW9du8R2aG4CFCncynXqzPWim7
         qD0w==
X-Gm-Message-State: AOJu0Yy98HaUpbV2KLIChvDGCwk0tKQOeFCK+MNJUV0a34UwzDTw3PvS
	hGzU8Bi1i+VTJsRGCPbUlq5avO1dz4IJAV5GD3nz/LXqRfsR2uClMIQKJ4GDo5wZmZxnw3ymKiZ
	wVj6otoGN8fDiUVMRCRpl94pVynuOKHSq8JvJdNNi10kavRlUKTCBmg==
X-Gm-Gg: ASbGnctr7IYRyWhPrm8QmyaewBGEXOh8tf76hIpqk3zL9v+Vxviht8oHVROvvW5IjUu
	85rPoXm0y0XKjT1AxYKCQ9mYBII7dqKPS1giQ1E+Mn2FZ/SnRmnt+KsycCVbBSDSNy+VeYBknEd
	kxHoHCTS5+jV2f1qK/jKkshwATpAAdNg==
X-Google-Smtp-Source: AGHT+IFrIV6GuITY5uoIZOHwLb76Qlzh6AYO1Bkttfak0agrKv7uoT5PzEhM6WDDHuagt8Dqir18oEiNd6j4BLjw6jg=
X-Received: by 2002:a17:903:187:b0:224:c47:cbd with SMTP id
 d9443c01a7336-22dbf157b05mr50595055ad.0.1745604906018; Fri, 25 Apr 2025
 11:15:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Nik Garza <nikolas@applied.co>
Date: Fri, 25 Apr 2025 11:14:53 -0700
X-Gm-Features: ATxdqUEX3FdhDkHnfwpLunzziEH-UjHz4Vu0OwY6y7F8iGmy1A4_459p7EwtpZ4
Message-ID: <CA+ODqj2s68nPWzd1KHH3vUm3SiFHuf2b=+hmNuWesi-bo3c8_g@mail.gmail.com>
Subject: bug report - BUG: builtin/pack-objects.c:4310: should_include_obj
 should only be called on existing objects
To: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000057996506339e50df"

--00000000000057996506339e50df
Content-Type: multipart/alternative; boundary="00000000000057996406339e50dd"

--00000000000057996406339e50dd
Content-Type: text/plain; charset="UTF-8"

reporting the attached bug:



-- 

*Nikolas Garza*

Software Engineer

nikolas@applied.co

(209) 499-1193

Applied Intuition, Inc. <https://applied.co/>

--00000000000057996406339e50dd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>reporting=C2=A0the attached bug:</div><div><br></div>=
<div><br></div><div><br></div><span class=3D"gmail_signature_prefix">-- </s=
pan><br><div dir=3D"ltr" class=3D"gmail_signature" data-smartmail=3D"gmail_=
signature"><div dir=3D"ltr"><p style=3D"line-height:1.38;margin-top:0pt;mar=
gin-bottom:0pt"><font color=3D"#222222" face=3D"Helvetica Neue, sans-serif"=
><span style=3D"font-size:10.6667px"><b>Nikolas Garza</b></span></font></p>=
<p style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"><span style=
=3D"font-size:8pt;font-family:&quot;Helvetica Neue&quot;,sans-serif;color:r=
gb(153,153,153);background-color:transparent;vertical-align:baseline">Softw=
are Engineer<span>	</span></span></p><p dir=3D"ltr" style=3D"line-height:1.=
38;margin-top:0pt;margin-bottom:0pt"><a href=3D"mailto:nikolas@applied.co" =
target=3D"_blank">nikolas@applied.co</a></p><p dir=3D"ltr" style=3D"line-he=
ight:1.38;margin-top:0pt;margin-bottom:0pt"><span style=3D"font-size:8pt;fo=
nt-family:&quot;Helvetica Neue&quot;,sans-serif;color:rgb(153,153,153);back=
ground-color:transparent;vertical-align:baseline">(209) 499-1193</span><spa=
n style=3D"font-size:8pt;font-family:&quot;Helvetica Neue&quot;,sans-serif;=
color:rgb(153,153,153);background-color:transparent;vertical-align:baseline=
"><span>	</span></span><span style=3D"font-size:8pt;font-family:&quot;Helve=
tica Neue&quot;,sans-serif;color:rgb(153,153,153);background-color:transpar=
ent;vertical-align:baseline"><span>	</span></span></p><p dir=3D"ltr" style=
=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"><a href=3D"https://a=
pplied.co/" target=3D"_blank"><span style=3D"font-size:8pt;font-family:&quo=
t;Helvetica Neue&quot;,sans-serif;color:rgb(17,85,204);background-color:tra=
nsparent;vertical-align:baseline">Applied Intuition, Inc.</span></a></p><di=
v><br></div></div></div></div>

--00000000000057996406339e50dd--
--00000000000057996506339e50df
Content-Type: text/plain; charset="US-ASCII"; name="git-bugreport-2025-04-24-1725.txt"
Content-Disposition: attachment; 
	filename="git-bugreport-2025-04-24-1725.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_m9x42lbe0>
X-Attachment-Id: f_m9x42lbe0

VGhhbmsgeW91IGZvciBmaWxsaW5nIG91dCBhIEdpdCBidWcgcmVwb3J0IQpQbGVhc2UgYW5zd2Vy
IHRoZSBmb2xsb3dpbmcgcXVlc3Rpb25zIHRvIGhlbHAgdXMgdW5kZXJzdGFuZCB5b3VyIGlzc3Vl
LgoKQ29udGludWFsbHkgaGl0dGluZyBhIG9hY2stb2JqZWN0cyBlcnJvciB3aGVuIGZldGNoaW5n
IHRhZ3MgaW4gbXkgcmVwby4gVGhpcyBvY2N1cnMgaW4gQ0kgZHVyaW5nIGNyaXRpY2FsIGpvYnMu
IFRoZSBpc3N1ZXMgaXMgZmxha3kgYnV0IGxlYWRzIHRvIGFuIHVucmVsaWFibGUgc3lzdGVtLgoK
VGhlIEVycm9yOgoKRVJST1I6IEZhaWxlZCB0byBmZXRjaCBnaXQgdGFncyBmcm9tIG9yaWdpbiEK
CVN0ZG91dDoKCVN0ZGVycjoKQlVHOiBidWlsdGluL3BhY2stb2JqZWN0cy5jOjQzMTA6IHNob3Vs
ZF9pbmNsdWRlX29iaiBzaG91bGQgb25seSBiZSBjYWxsZWQgb24gZXhpc3Rpbmcgb2JqZWN0cwpl
cnJvcjogcGFjay1vYmplY3RzIGRpZWQgb2Ygc2lnbmFsIDYKZmF0YWw6IGNvdWxkIG5vdCBmaW5p
c2ggcGFjay1vYmplY3RzIHRvIHJlcGFjayBsb2NhbCBsaW5rcwpmYXRhbDogaW5kZXgtcGFjayBm
YWlsZWQKCgpXaGF0IGRpZCB5b3UgZG8gYmVmb3JlIHRoZSBidWcgaGFwcGVuZWQ/IChTdGVwcyB0
byByZXByb2R1Y2UgeW91ciBpc3N1ZSkKCnJhbiB0aGUgZm9sbG93aW5nOgoKZ2l0IGZldGNoIG9y
aWdpbiByZWZzL3RhZ3MvPHZlcnNpb24taWRlbnRpZmllZD4uKnJlZnMvdGFncy88dmVyc2lvbi1p
ZGVudGlmaWVyLioKCldoYXQgZGlkIHlvdSBleHBlY3QgdG8gaGFwcGVuPyAoRXhwZWN0ZWQgYmVo
YXZpb3IpCgp0YWdzIHRvIGJlIGZldGNoZWQgdG8gdGhlIENJIG1hY2hpbmUgcnVubmluZyB0aGlz
IGNvbW1hbmQgCgpXaGF0IGhhcHBlbmVkIGluc3RlYWQ/IChBY3R1YWwgYmVoYXZpb3IpCgplcnJv
ciBhYm92ZSB3YXMgdGhyb3duIGNhdXNpbmcgdGhlIGpvYiB0byBmYWlsCgpXaGF0J3MgZGlmZmVy
ZW50IGJldHdlZW4gd2hhdCB5b3UgZXhwZWN0ZWQgYW5kIHdoYXQgYWN0dWFsbHkgaGFwcGVuZWQ/
CgpwcmV0dHkgc2ltcGxlLi4ud2UgZXhwZWN0IHRoZSBmZXRjaCB0byB3b3JrIGFzIGV4cGVjdGVk
CgpBbnl0aGluZyBlbHNlIHlvdSB3YW50IHRvIGFkZDoKCndlIGFyZSBwcmV0dHkgc3VyZSByZXRy
aWVzIHdpbGwgcmVzb3ZsZSB0aGUgaXNzdWUgYnV0IHRoYXQgc2hvdWxkbid0IGJuZSBuZWNlc3Nh
cnkuIAoKd2UgdXBncmFkZWQgZ2l0IGZyb20gdmVyc2lvbiAyLjQ3LjAgLT4gMi40OS4wIGFuZCB0
aGVuIHN0YXJ0ZWQgc2VlaW5nIHRoZSBpc3N1ZSBzbyB3ZSBiZWxpZXZlIHRoaXMgaXMgYSBsb3cg
bGV2ZWwgZ2l0IGlzc3VlIGl0c2VsZiBhbmQgbm90IG91ciB1c2Ugb2YgZ2l0IGluIG91ciByZXBv
CgpQbGVhc2UgcmV2aWV3IHRoZSByZXN0IG9mIHRoZSBidWcgcmVwb3J0IGJlbG93LgpZb3UgY2Fu
IGRlbGV0ZSBhbnkgbGluZXMgeW91IGRvbid0IHdpc2ggdG8gc2hhcmUuCgoKW1N5c3RlbSBJbmZv
XQpnaXQgdmVyc2lvbjoKZ2l0IHZlcnNpb24gMi40OS4wCmNwdTogeDg2XzY0Cm5vIGNvbW1pdCBh
c3NvY2lhdGVkIHdpdGggdGhpcyBidWlsZApzaXplb2YtbG9uZzogOApzaXplb2Ytc2l6ZV90OiA4
CnNoZWxsLXBhdGg6IC9iaW4vc2gKbGliY3VybDogOC41LjAKemxpYjogMS4zCnVuYW1lOiBMaW51
eCA1LjE1LjAtMTM0LWdlbmVyaWMgIzE0NX4yMC4wNC4xLVVidW50dSBTTVAgTW9uIEZlYiAxNyAx
MzoyNzoxNiBVVEMgMjAyNSB4ODZfNjQKY29tcGlsZXIgaW5mbzogZ251YzogMTMuMwpsaWJjIGlu
Zm86IGdsaWJjOiAyLjM5CiRTSEVMTCAodHlwaWNhbGx5LCBpbnRlcmFjdGl2ZSBzaGVsbCk6IDx1
bnNldD4KCgpbRW5hYmxlZCBIb29rc10KcG9zdC1jaGVja291dApwb3N0LWNvbW1pdApwb3N0LW1l
cmdlCnByZS1jb21taXQKcHJlLXB1c2gK
--00000000000057996506339e50df--
