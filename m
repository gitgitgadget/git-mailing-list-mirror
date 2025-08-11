Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3EB92BE7C3
	for <git@vger.kernel.org>; Mon, 11 Aug 2025 11:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754911179; cv=none; b=ZHUdX1T+nAq86ggYDB/22NFfFsPB+oa6nLGnBiuqtb34kvTxPFDu31FIbTTwQvOBnLdpAQvF8Piq89cxZrGUJ/f6tNCepruqua+2AUKzJ35RJJnPKpMgVrIUclVdsyR29NQVNIlCkBwb4jGbXZsZ8Uk5vXfeUtmmb3FoLJ03ulU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754911179; c=relaxed/simple;
	bh=YsmECTbHGR9R+y+mH/PNvwSOMAgPUH0Ew/8pAQapYzU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=bZFitxMOHOhb+8vJnJj1EkmiKNsShxE+BkovZtiwcKxLh/xUd/u2EqGoKnnhPZ1uwTmHid9PcYv3mptd+wfmAArAaeLI2UKxW8E4eAS0kv6WEkqVxvxOLM2KqQ3moBVgQYCtMLNgX4V1FxBHV1a8YaIhgSrq3+UXUGwggiv9SBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MpK4Bms3; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MpK4Bms3"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4b07d777d5bso48423821cf.2
        for <git@vger.kernel.org>; Mon, 11 Aug 2025 04:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754911175; x=1755515975; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YsmECTbHGR9R+y+mH/PNvwSOMAgPUH0Ew/8pAQapYzU=;
        b=MpK4Bms39WN2GdbpZqe1ybt2RC/qwr9DrVkZd0WNQyU8iTu7KBHEmc2E64udTA24vl
         KT1uYSOXivYs3VmRP6FxyDYMN3v6pOSOcuUMuFXyXDBFqmorbBlZJj9jUGFFbeWPhbV7
         L1n9K42MC72PNkA4ay3/XfEYP7khmO8oYxwuII8l3AAma5hbZxOMj9zppgc60djyxu2y
         CiuYvtJhN8T60Ie8RDKVcY+nF+M2tcE620Qno9e6px3Q+UCS/9W4w31Qw2DUhBq4ydLG
         NIcLbLsTjNU3saP0t6AtJZ4Eu1B7E3H62X/YVK00o6X5CirbATjDrMuTazasFWFcPMTC
         9YwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754911175; x=1755515975;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YsmECTbHGR9R+y+mH/PNvwSOMAgPUH0Ew/8pAQapYzU=;
        b=jkLViRA1yQLPYOAfJ4EfDaUj4b23GqRHyaXKiQ29KQn77Sl4QcUTXFQ/aUallLL8p7
         YTCIgA/ZY3aBkauhs/V/JEqJZJHhSpqtftW2k0xCEAontHKl715fGjivRRx2l60CCl7l
         YsTdPw6taeHMKNQg37lBmkDSbrAvP/YgyoPS/Ijc8QHKzZmNp/uznfbQ0kTwBw5xLEKK
         cvnvGBH7hLkG94MqZL3g0XZhrkiubt25fhCDBjS2H1Nt2/1wMvpELZ2YpBo1XNcicEDR
         BqPH0zu8waKBoVh866IzrAK7PK/OQM8GmKAnXSgogY5PjCoxTxDk5ZAUVJBT1g3td/nu
         /Ycw==
X-Gm-Message-State: AOJu0YxFpgtiW06WVWPFSMnx/BTmfEYxvnA04UFGSh9yOF+vPhKDouKf
	uE45SwwjAY1H1nAXGWfjADYZbmbpF+sp1us/Mwk7Mr9ubC/4Ad0eEfv15TRL31s8Yubja3hOBSc
	TSqOa0Cy5QGhUTVY/SGl1IwZCh+i3EpXCCJSU3iU=
X-Gm-Gg: ASbGncso59PZbgVIhedqXKnxMWho1MNLfKTf1kAJznb1EU5ralEAJMp0oU0yd1EFeSw
	AJa+U2RfYsSS4JdbQVbvBk7YDvtt8bkdTIeVS1Swfv5gB1Yu1Cow0FnzupLp+BwD+9PZHtYb+xo
	cG7mDO/0omy/vtOspr99UXn45N0ubriVoN2ksugIikiAZX0pFqOpBpCGaY+/xCjLr9oiW76fcLy
	1e6e/rQqUufg+PN59g=
X-Google-Smtp-Source: AGHT+IFLBEmqphrgPJcdAjv+XSqww+qbbqn6E9a83MU34W4rVb7z1K7I74FTIm8O8oFxZ9UbWAUPzc3v0QKR/tTuhNs=
X-Received: by 2002:a05:622a:14b:b0:4b0:da5c:e250 with SMTP id
 d75a77b69052e-4b0da5ce62dmr43667501cf.59.1754911175076; Mon, 11 Aug 2025
 04:19:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Muhammad Fahri Muharram <mfahrim7@gmail.com>
Date: Mon, 11 Aug 2025 18:19:24 +0700
X-Gm-Features: Ac12FXxBMbiz2Sw7-cXRwczR1Vo71lecHxxHSznZqeMO-DQswVTbbngUqBisQk0
Message-ID: <CACEVnOLzZkR_oELBFg2Wfu83cos8VRCNprx3Vad_wtDncFPQtw@mail.gmail.com>
Subject: [BUG] git credential url field ordering/documentation issue
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In git credential source code, whenever an url field is encountered it
will call credential_from_url_1 which will then call credential_clear
on the credential struct.
https://github.com/git/git/blob/master/credential.c#L625

This means the credential struct is cleared whenever a url= line is
processed, but the documentation does not mention that the url field
must be placed before other fields to avoid wiping them.

This causes confusing behaviour:

$ printf "host=github.com\nusername=A\nprotocol=https" | git credential approve
$ printf "username=A\nurl=https://github.com" | git credential fill
Password for 'https://SeeStarz@github.com':
protocol=https
host=github.com
username=SeeStarz
password=
$ printf "url=https://github.com\nusername=A" | git credential fill
protocol=https
host=github.com
username=A
password=B

On the second command, due to username being wiped, git credential
fill defaults to using ~/.gitconfig which in my case uses the username
SeeStarz.
The expected behaviour is that both invocations of git credential fill
show username=A and password=B.
Please consider clarifying this behavior in the documentation or
adjusting the implementation to avoid this surprising side effect.

Thank you.
