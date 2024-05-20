Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC461182DB
	for <git@vger.kernel.org>; Mon, 20 May 2024 08:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716193300; cv=none; b=OM20GPRRVqw+F0oniRml1u8JI0jF/iGZCz/7mk8DtMErsiq1LuKEGjlnlGKru4vkKRKaQSGzgGauTTxCWYH9dgkJ2BnBntjCYKSfo3XUwaa87GwmpKnma+FX0EGqr4F00obyxzCWm1yQFH7N2mDVUf8V/wHr/R1DytIqLWsp4rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716193300; c=relaxed/simple;
	bh=Ce1u2MsCNSZuozESCVl6DGuSpLyG92fy4ED1/ga6048=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Pkvz/76x6QH70Ynh6HoLe5CC1ANofL8x3DiIAJLDNULHTiFGzLk9tWGgkPhER2aTE/JpHbZUg5hR6kY3A/ae82fxC+FoIF6eKi/lG4BrzT84qMjq4gS/sAvZvVU4WHxJZmJjf2JssFkLNXtPKLn2e1gSd3jOpnWPu1yNjmWISXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X9WLDbVn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X9WLDbVn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716193297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jQFOWChAXEeHk1SB9o4vt7uqkdJE5pcStUPfxmMbQ9w=;
	b=X9WLDbVnd97DnEndMItrs5dyCjN8Z/iyErjOQOu3lb8at3M97o20jx3fqWzVqOsWrNDnCM
	yRyNI5Vi3m/vJFMnqYn2D5xq95Gw5sk7qjdLuc3dBg6GEwIILOhB/HwYnbIZeYcruOep3S
	BPuHpwcCt050JICAAzG/0jsmiyQTa98=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-578-Y6HOpVOOOnyHECvLHYaXGw-1; Mon, 20 May 2024 04:21:35 -0400
X-MC-Unique: Y6HOpVOOOnyHECvLHYaXGw-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a5a05c4e0efso691800466b.1
        for <git@vger.kernel.org>; Mon, 20 May 2024 01:21:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716193294; x=1716798094;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jQFOWChAXEeHk1SB9o4vt7uqkdJE5pcStUPfxmMbQ9w=;
        b=C/94z7uY+nb953riyVZCQ6V0v1pAcNKU7Q8hRu4ajPG9p3Oixh9dfOR+QsV1mw1RKr
         vQR7MF8T5/MVeLgwqajNeDI0HLvSE0W8P4jDs80jo4wFIQYVy+MZmKBdZBBaG2wJV4iV
         yVSfKcVXt2cdpD6gH4jUxHYLi4+o+sIhpS9QpEha0+jwKQ/Ls/yN3V69ia6vcwT36AjP
         k7F6pKA5dmYpnOyVeyoqjiDsgRAYzrcL1haNLSWvgNnAWEHl7lRaKKAuEq2X2FpSP2oa
         ipdvUQHFTKK5j8VtT4nNZ2wWyD/iEiGjPguB/Y0k6232OOloAnYNFrRejFFPLtgqGuoY
         mEZw==
X-Gm-Message-State: AOJu0YxKNcibJ2jcW4UJhy5C3G2oF8agmgnslvFC7Tha9v98UctwyMoi
	CWoNVjSbLW3ggvEcypjTzp1jzxS4U3xNPt88wFc/o9HtjjOIqhy3imysTYLcC+nug/5wV5wUuP+
	ty3WFKrc1BAmiPK8pPsyrJ5epIPPqWt88HIBBsIP23fCv2jvburSy/qxUIXayI7oLhMxD5wk2ES
	HfVyWXdbEDg4s/0GtMcB18Y0I0txblSqMEhqU=
X-Received: by 2002:a17:906:1406:b0:a5a:7a4e:7e80 with SMTP id a640c23a62f3a-a5a7a4e7effmr1466319966b.72.1716193294490;
        Mon, 20 May 2024 01:21:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEM4WaJPYEys3BFwEq31haPJGV1YyIExPg3ewlxPZF9NGul4h/sS6m4Zn252clpTR433Yk0EhMD33vYAvY24Bo=
X-Received: by 2002:a17:906:1406:b0:a5a:7a4e:7e80 with SMTP id
 a640c23a62f3a-a5a7a4e7effmr1466318266b.72.1716193294086; Mon, 20 May 2024
 01:21:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ondrej Pohorelsky <opohorel@redhat.com>
Date: Mon, 20 May 2024 10:21:23 +0200
Message-ID: <CA+B51BGonS2DDTBQ2RsipW4Cyg5pRv0U71RAN9M1pcPjACtJ4A@mail.gmail.com>
Subject: git-daemon doesn't work as expected in v2.45.1 and friends
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

during testing the newest security releases in RHEL and in Fedora, we
have encountered broken git-daemon behavior. In a nutshell, git client
refuses to clone locally hosted repositories because of detected
dubious ownership.

I'll paste part of the Fedora report [0] here:

```
Upon clone, git-daemon logs the following:

    [1482] Connection from ::1:45090
    [1482] Extended attribute "host": localhost
    [1482] Extended attribute "protocol": version=3D2
    [1482] Request upload-pack for '/test.git'
    fatal: detected dubious ownership in repository at '/var/lib/git/test.g=
it'
    To add an exception for this directory, call:
            git config --global --add safe.directory /var/lib/git/test.git


Reproducible: Always

Steps to Reproduce:
1. Create repository under /var/lib/git/test.git
2. Ensure git.socket systemd unit is started
3. Run git clone git://localhost/test.git
Actual Results:
git server refuses to read /var/lib/git/site.git because it detects dubious
ownership
```

Is there a way to make git-daemon hosted repositories safe to clone,
without specifying safe.directory in git config? AFAIK this is widely
used feature of Git not only by the end users, but also quite a lot of
tests rely on it.

[0]https://bugzilla.redhat.com/show_bug.cgi?id=3D2281530

Cheers,
Ond=C5=99ej Poho=C5=99elsk=C3=BD

