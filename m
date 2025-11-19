Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F144B2F6939
	for <git@vger.kernel.org>; Wed, 19 Nov 2025 23:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763595494; cv=none; b=iSiZLVD646lIgq5qz6/dC+jjPQZLY789XTb1Qjv3lco1xXEMz5hRpmi7wyLFzfA8FDBHoXrdq7/Rtq4BpMvv7jTq2i+Wyr3fnvPK+lceuOLblpwAAO7joqOAGVTTi4eN5DQ+voCOvuN/JnjtxkQIeiJI7t1KU6ck4fvGtmWKHTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763595494; c=relaxed/simple;
	bh=w/GFjDhp+WJdriUN6k01Re+fD1P24rIoT44XOnprS2o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=e0Kns6tyKzJuCilhcOVHE5VlAZiZV4MQfBvUkffirSas6woZGsvSOaMENXsN7FHIzNUXSA4/PhMuqR8BZDQDJv+jfi9sx46HMNAf2DxLS7lpneSahjWi4+DYzbEbiqnJNStYL4XA3Rah9VM6Buj5e5DWr7w0sxOj3IRvSxR3HtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lvzBO1tr; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lvzBO1tr"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-37b9728a353so2539291fa.0
        for <git@vger.kernel.org>; Wed, 19 Nov 2025 15:38:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763595490; x=1764200290; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XIIlrjDdI84i478ut6GrM+QnyicnIOCRhZ7I1NM297k=;
        b=lvzBO1trLv/hXj1GgUTZKB33aRQ7Pd66i5Pj53aY908AR9Jr28LZzrcCxt6dETODDN
         dpeTrsNSFVQCsXYaRzNN+Dn5RI7NQ0h0aMN2iymG25Mt8i50js2pIq1Z0ivr7AuBf81s
         rfI7AXsATLMKQRrtTr5p64uufxgB7vikAI/oJqwdJmsgwapqhcw5st8ZV9AQCFLs+0WV
         cP4N0YlXSPBErt5mtAwfWZ9TIeLRBx+Lp/DWSBt0s7Fe9b86nixFjWLaosWElL8LzTUh
         Xyo7cKPrGtHKIjzvVRYY+p3uVdB0KhClbZgJDjTEE6JS0V5qpmAh3u4GF86EiQtMb8A0
         q2YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763595490; x=1764200290;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XIIlrjDdI84i478ut6GrM+QnyicnIOCRhZ7I1NM297k=;
        b=TqTYsqgpJBY9WvI+0jqnLvv6XoGRQ5m+2CErpurHerhFdmTELD6P7CWJyeFqYPM0qb
         pinBbklPHbkdRU0tMTdhWcRWGya140uRC72yJDlSMH0mx/20fGanBuve8ymsm7DGyLYz
         HQMSPo4SBGexGm7pAc13dcmj0b73uJ2/HuwfNHW6ct2uJvXBZGQRhvXwAvnsoDVtcthz
         oGersKGuS0C0aAHRwCRXUlQqu8EZ0wvGBiLB49r7WAC6zOUQBfaKOByre3lw3UXxBkfT
         jYx0InsV/56U3m8VlW+dYNXE7uMwKmWrqijGN7hBfzumYrkvZ0kFkNUL4z8BTF5bEtXb
         WQjg==
X-Forwarded-Encrypted: i=1; AJvYcCXLeP+AivwX44L1RG+sXiR9KfgHJu3mfPJNakIsKbQQUxRAZpvpFrWG0WqBhK/5rcvqzyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzplCZCYb7/gsktdYo5yIXoMyWTRD61SVR/zxPvcaTNzAkRLaBo
	5p/2v2tXbIaq5KdS9kIxA+foqwD6iPJ72kqPVm4olv6e+9Iou7/84EubmsDGbZ7hi3UMqc1l/Nc
	L2+uP/1zf6kiUqSQakDGQFWXsnF62GvA=
X-Gm-Gg: ASbGnctM45zRg2VYBtJ/pWd3biymeVz695J+5FovvRJ64tpXUMFFaXPg9xs0QU+6/57
	62NYsZHQZLcwox52zLsT4f2nlSestAP914oZ5hrWTx1Z4yKlH9v8lxClw2T8ytdaye+yc8wGps7
	0miaI8/Lgj8xYxvTAHj8jQjTN78i1M/ZA+Phwy+8o3avdM5jA1g+Zw2IfF6XQwM8xL9G86hyR4x
	s7LlbPsT5Jk9ZLK9QIWPUD3pDa/lwPF3+XVH1iw8VLwHFNNNIF7H9hGToyxaZLQHJnD8Btl
X-Google-Smtp-Source: AGHT+IENTWqA6eC3wGPgmIGbXeoly3PaerU/LCrxF9CFA4yhVGsu1Zu/oE1L4I5BcvIHfKrrFzXgc/v3CZtL+SNzjJA=
X-Received: by 2002:a05:651c:3241:b0:37b:af3a:cb37 with SMTP id
 38308e7fff4ca-37cc7f07828mr1183311fa.0.1763595489763; Wed, 19 Nov 2025
 15:38:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027004404.2152927-1-sandals@crustytoothpaste.net>
 <xmqq7bvsjzlx.fsf@gitster.g> <xmqqpl9h9mgo.fsf@gitster.g> <aRudLpkRdRtCAoi3@fruit.crustytoothpaste.net>
 <xmqq4iqsgpu3.fsf@gitster.g> <aR5M65HDuGlTsR77@fruit.crustytoothpaste.net>
In-Reply-To: <aR5M65HDuGlTsR77@fruit.crustytoothpaste.net>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Wed, 19 Nov 2025 16:37:58 -0700
X-Gm-Features: AWmQ_blsG61nciwkiQcugzGUEhHR77bQXotUWs2tLdrIXhE6gsbXwnrRUE8dJ8s
Message-ID: <CAH=ZcbAmAqWMYXhYT3bX_Q8cEkV0ZcjEtM65YS7DXPJbs-L3Wg@mail.gmail.com>
Subject: Re: [PATCH 00/14] SHA-1/SHA-256 interoperability, part 2
To: "brian m. carlson" <sandals@crustytoothpaste.net>, Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, 
	Patrick Steinhardt <ps@pks.im>, Ezekiel Newren <ezekielnewren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 19, 2025 at 4:04=E2=80=AFPM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2025-11-18 at 00:13:40, Junio C Hamano wrote:
> > Thanks.
> >
> >     $ git log --oneline --first-parent -4 seen
> >     3f252ac9fe Merge branch 'ar/run-command-hook' into seen
> >     672cb7c62e ### CI
> >     3af201233b Merge branch 'bc/sha1-256-interop-02' into seen
> >     950efaac03 Merge branch 'cc/fast-import-strip-if-invalid' into seen
> >
> > It seems that 672cb7c62e (which is an empty commit on top of the
> > merge of v2 of this series) fails win+Meson
> >
> >   https://github.com/git/git/actions/runs/19447841443/job/55646336507#s=
tep:6:689
> >
> > but 950efaac03 (which is the merge before v2 of this series is
> > merged to 'seen') is happy with it.
> >
> >   https://github.com/git/git/actions/runs/19448271167/job/55647611566
> >
> > These two runs roughly corresponds to the with=3Dbad/without=3Dgood pai=
r
> > in the message you are reponding to, but with the v1 of this series.
>
> Yes, I think we'll need someone familiar with Windows to take a look at
> that.  The message doesn't indicate anything obvious and I don't have
> any Windows systems available to investigate.
>
> My guess is that it's something to do with the build.rs file, but I'm
> not certain.

This was a known issue, that I pointed out, before Patrick's
"Introduce Rust" series was merged in [1].

[1] https://lore.kernel.org/git/CAH=3DZcbBjL09Mk3AXBSgmZGvmFtU3Roc2P5rbQsZ-=
U5DBHYSs7w@mail.gmail.com/
