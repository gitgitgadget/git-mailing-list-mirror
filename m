Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B19374173
	for <git@vger.kernel.org>; Fri, 16 Jan 2026 11:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768562577; cv=none; b=rJOBAfv1Z5NkmqZc1vGt+bL+fsOgvWvr4RGaJd2wSWxfG6/420CZ7lyJae25yzRFHxlkCSgGGfJGjJoRp9rMHh6Y7OUCv09FekYD3yKFoaB4+1MaBsdE/S6Wec97LdX4wV3m7xFqmuaKnZefWXfCBrgBT8K6TLY33j9sw4mtbeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768562577; c=relaxed/simple;
	bh=4dzjtJzv0S5lvt28PaQyFhEEr31Agwjxyby7X8F79SQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=u3djAkRkBQ9+xVwBevWVyMAl5zQGiICemBqoqpyB//cahhwGSlBE3F8R5g0Gw0ahfOtCgYrQYuJ5v6InO6V0MPBc+S42FguZ05kj8mojb0AxRh7IQo3SpiSQ/nhPNtAKj9nrVBpRjJBErsG5p4bP2wAMr9RfRmIJhVVAmkrKSzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T/xP9nTm; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T/xP9nTm"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-78fba1a1b1eso29846087b3.1
        for <git@vger.kernel.org>; Fri, 16 Jan 2026 03:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768562571; x=1769167371; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aJGXCtw8pcPGC2vD7ei/G3lTqOBW4wxen5om2wjmJuw=;
        b=T/xP9nTmmfgkuUtE0tY/O4NsY7cNSK0R+86DQXLLk0lOE4aJifL4PQxB7MmyfR/eu0
         MUlbn19t1+BItRDfY2kDWc8YydANgiV/7S3I6LgMZJMfYZNpJGTy2lWKjMorXXC09RfJ
         qC1PuSCANnL0H6g5IONgrEIfRODniDzlv/YsO209jel8D6ykTVWpe/smtkQcJfmMepQx
         tLvw7IwSmAnLwilDpoLIrZvIMSs5xsEw0OsOTJDWDLctgS4JVLUNrdF0I2yp8uiRhDzt
         YPqaiea1+QhkbDi6k3CdYhFM86OlDb+//nLISIekdzq9L7latRfEJsUJJkiRjkD4U1Ne
         yQHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768562571; x=1769167371;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aJGXCtw8pcPGC2vD7ei/G3lTqOBW4wxen5om2wjmJuw=;
        b=iK3Gjz0WCGMsv4EJMvmq5lse2xRFNECajhC8QzvhR5+JnC95d0InONAzf3SqJhE3lh
         4IfTOxba3WBw/Rcvftgf7mRWBhXKKIkP7SQ/txlkllD5I3AHHIAkUpypJnH0wdxqhWbY
         eox83l7OV2dXO9+qQZoijF2+i2WdOgwWDFv6nP5HNG4I2b5W8D7FS89zp/28AdmcjCHR
         j0CgvwEOSNKAYLqCZqRDcDlD9vFVkPt6Ag3LpoHTAHF7gDjErzu6QdtgZipTUQZ+kKfX
         ZMpEG+S0K3/NpZRMJZ9UQkg8YG+RQXHwkV7sJYzfgiSVUV9R3Cq45XQh5dEdMGPM80XG
         BfOw==
X-Gm-Message-State: AOJu0YwO+TYhx/O7+K0C04ZnW4+7Q0yw0sFizZXS3co/QU5nOrDFYkQ5
	h6RWB7MqpTbWXpZBVGi6gpu0y5pC2kfoohTdwXa+3RCoNkUlGuYRHcgkODelUPcQkQk7cAYaKol
	Wg6gmX29Z2XgKSDboEQzs6+IYphLpCOY7BCo8
X-Gm-Gg: AY/fxX7h/uh0LSqZYY9w28xilZpo3hH+D1hP2ZnPy9ZtyKI00DvIhjBoX6cDqnoFsbu
	EvtPbaCrzMs+bxjoLiJrAEZloTcdO968z6+1JEbbvWKi6SfZTaKaWFpagYlJdZ4PB1S5eEljKaR
	XTy5pm2XtSZQG5vpSKkodupaOvUHml/YCBQMbx+WQ/zWck4xe7CokOPdLC63UjYmrrq1/xI9P/f
	eqMSHayNTmXUkm1V7Am4ZrVRlpC+xCWeK44mP8xh6kLIhFgNGzvUCeNUrrCvwMCviXNYfsX
X-Received: by 2002:a05:690c:6287:b0:78e:7aad:f4e8 with SMTP id
 00721157ae682-793b34eb82cmr46078307b3.18.1768562570944; Fri, 16 Jan 2026
 03:22:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?Q?Oskar_Jask=C3=B3lski?= <oskarrro90@gmail.com>
Date: Fri, 16 Jan 2026 12:22:39 +0100
X-Gm-Features: AZwV_Qj-4zaeQJifPHMyfE6Hi_QG-t0QXJLds_IpmJzHK_-9bohv3sc6CNKvtgk
Message-ID: <CAFp-0Pz_BdZwA4Pn=jUxvYu1prj0F85q+3GWSW-G6LF=cSHn8A@mail.gmail.com>
Subject: README update proposition
To: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000ce38d506487f8f92"

--000000000000ce38d506487f8f92
Content-Type: multipart/alternative; boundary="000000000000ce38d306487f8f90"

--000000000000ce38d306487f8f90
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello everyone!

Is it possible to apply the attached patch? I was trying to "build" git-gui=
,
but I was seeing the Tcl/Tk for the first time.. Now I know that `Tk` is
used to generate the GUI, and `Tcl` is the scripting language used by `Tk`.
The `wish` command is used to execute the `Tk` code.

I was thinking that I have to install all three dependencies but it turned
out that I need just to install one `tcl/tk` package.

Greetings,
Oskar Jask=C3=B3lski

--000000000000ce38d306487f8f90
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hello everyone!=C2=A0<br><br>Is it possib=
le to apply the attached patch? I was trying to &quot;build&quot; git-gui,<=
div>but I was seeing the Tcl/Tk for the first time.. Now I know that `Tk` i=
s used to generate the GUI, and `Tcl` is the scripting language used by `Tk=
`. The=C2=A0`wish` command is used to execute the `Tk` code.<br><br>I was t=
hinking that I have to install all three dependencies but it turned out tha=
t I need just to install one `tcl/tk` package.<br><br>Greetings,<br>Oskar J=
ask=C3=B3lski</div></div>
</div>

--000000000000ce38d306487f8f90--
--000000000000ce38d506487f8f92
Content-Type: application/octet-stream; 
	name="0001-git-gui-update-README-to-clarify-Tcl-Tk-dependencies.patch"
Content-Disposition: attachment; 
	filename="0001-git-gui-update-README-to-clarify-Tcl-Tk-dependencies.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mkgsfve30>
X-Attachment-Id: f_mkgsfve30

RnJvbSAzYzQyMmY2NjQwMzI5ODlhMjMwYmEzZjQzMDM0ODVjY2ZhMDM0NjYwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiA9P1VURi04P3E/T3NrYXI9MjBKYXNrPUMzPUIzbHNraT89IDxv
c2thcnJybzkwQGdtYWlsLmNvbT4KRGF0ZTogRnJpLCAxNiBKYW4gMjAyNiAxMjowODoyMSArMDEw
MApTdWJqZWN0OiBbUEFUQ0hdIGdpdC1ndWk6IHVwZGF0ZSBSRUFETUUgdG8gY2xhcmlmeSBUY2wv
VGsgZGVwZW5kZW5jaWVzIGFuZAogYnVpbGQgcHJvY2VzcwpNSU1FLVZlcnNpb246IDEuMApDb250
ZW50LVR5cGU6IHRleHQvcGxhaW47IGNoYXJzZXQ9VVRGLTgKQ29udGVudC1UcmFuc2Zlci1FbmNv
ZGluZzogOGJpdAoKU2lnbmVkLW9mZi1ieTogT3NrYXIgSmFza8OzbHNraSA8b3NrYXJycm85MEBn
bWFpbC5jb20+Ci0tLQogUkVBRE1FLm1kIHwgMTkgKysrKysrKysrKysrLS0tLS0tLQogMSBmaWxl
IGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEv
UkVBRE1FLm1kIGIvUkVBRE1FLm1kCmluZGV4IDk0OGU5MjUuLjBlZmUxYmIgMTAwNjQ0Ci0tLSBh
L1JFQURNRS5tZAorKysgYi9SRUFETUUubWQKQEAgLTE2LDE1ICsxNiwyMCBAQCBzdGFuZGFyZCBH
aXQgaW5zdGFsbGF0aW9uLgogWW91IG5lZWQgdG8gaGF2ZSB0aGUgZm9sbG93aW5nIGRlcGVuZGVu
Y2llcyBpbnN0YWxsZWQgYmVmb3JlIHlvdSBiZWdpbjoKIAogLSBHaXQKLS0gVGNsCi0tIFRrCi0t
IHdpc2gKLS0gR2l0ayAobmVlZGVkIGZvciBicm93c2luZyBoaXN0b3J5KQorLSB3aXNoIChUY2wv
VGsgcnVudGltZSByZXF1aXJlZCB0byBydW4gdGhlIEdpdCBHVUkpCistIEdpdGsgKG9wdGlvbmFs
LCBuZWVkZWQgZm9yIGJyb3dzaW5nIGhpc3RvcnkpCiAtIG1zZ2ZtdAogCi1Nb3N0IG9mIEdpdCBH
VUkgaXMgd3JpdHRlbiBpbiBUY2wsIHNvIHRoZXJlIGlzIG5vIGNvbXBpbGF0aW9uIGludm9sdmVk
LiBTdGlsbCwKLXNvbWUgdGhpbmdzIGRvIG5lZWQgdG8gYmUgZG9uZSAobW9zdGx5IHNvbWUgc3Vi
c3RpdHV0aW9ucyksIHNvIHlvdSBkbyBuZWVkIHRvCi0iYnVpbGQiIGl0LgorR2l0IEdVSSBpcyBp
bXBsZW1lbnRlZCBpbiBUY2wvVGsgYW5kIGlzIGV4ZWN1dGVkIGFzIGEgc2NyaXB0IHZpYSB0aGUg
YHdpc2hgCitydW50aW1lLiBJZiBgd2lzaGAgaXMgYXZhaWxhYmxlIGluIHlvdXIgUEFUSCwgbm8g
c2VwYXJhdGUgVGNsIG9yIFRrIGluc3RhbGxhdGlvbgoraXMgcmVxdWlyZWQuCisKK09uIG1vc3Qg
c3lzdGVtcywgYHdpc2hgIGlzIHByb3ZpZGVkIGJ5IHRoZSBzeXN0ZW0gVGNsL1RrIHBhY2thZ2Uu
IElmIGl0IGlzIG5vdAorYXZhaWxhYmxlLCBzZWUgaHR0cHM6Ly93d3cudGNsLWxhbmcub3JnL3Nv
ZnR3YXJlL3RjbHRrLyBmb3IgaW5zdGFsbGF0aW9uCitvcHRpb25zLgorCitUaGVyZSBpcyBubyBj
b21waWxhdGlvbiBpbnZvbHZlZC4gVGhlIGJ1aWxkIHN0ZXAgb25seSBwZXJmb3JtcyBtaW5vcgor
c3Vic3RpdHV0aW9ucy4KIAogWW91IGNhbiBidWlsZCBHaXQgR1VJIHVzaW5nOgogCi0tIAoyLjQz
LjAKCg==
--000000000000ce38d506487f8f92--
