Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E2F1E98EF
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 22:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751408304; cv=none; b=Z95sOxqNMEkAOlG4fSPKT51/+2Iqm7Tu+fmuknGyAtwNR7MOx585cOXb+6H0sME1ZfNErM/FjcTsaGi+CTIXSR+odVQqiYRTlRSlKunPSVwK+h195jqiLaX5C9kfvPpBr/Ou6aCz4lMjOXWlsEECjPsmEyshLVJcVzBWH5Ovn8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751408304; c=relaxed/simple;
	bh=9EP7VsKEdvuzq+viHV+5MrY7ECKoBirdiZ8GigOWymk=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=clZJJ+B4/KyaxgBC/ymrevcE7SZP4OXgw498w+AxFTmLsXzJh2/GcicRs4YZo7ovtLXLSs4ToABJTtjyzCijGGdAZLH2eCqnjq1i6/e3wCI8KL5YB9YWNG+bs4B100MkDCGTe4Y82VJ27IlJ9UqkjU8fNHue1jhMAgXksw7zhgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C9MdEm5U; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C9MdEm5U"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6fac7147cb8so102143886d6.1
        for <git@vger.kernel.org>; Tue, 01 Jul 2025 15:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751408302; x=1752013102; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c8k5zUoxpsSocvSfptA8TzexxNyxHOo+9WfAmtdfmh4=;
        b=C9MdEm5U0POaX+Bq0/E4jyZ4jj/jVUDo9VhrU7rOBqzIYM1bCKafhhoFl5dkkL97zF
         vbnA4YYqr9PN9UGbtKhE9nTmEofApRRwjZacFfnW5KDxh797srJRf2Hoora/q9nG3WRb
         7E/izb2jRJA0hqgFLa/H6l/LezGDSJQc0BtZJIFOMBD1MfjGDQJevach4eCR09qFvh9Q
         05+GhHzU2iM2dJZSOnOyefoi+VI9AQjgP8FfgXqlJBxvY0GFioVsJl1cunkyI+yJD21v
         /3ctKqBTBKEQkJcgnZUCSN69aoIsBUupv9kvro0dW6ul7bPbfXv/1r1cJSoCJtnzgwTx
         uqTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751408302; x=1752013102;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c8k5zUoxpsSocvSfptA8TzexxNyxHOo+9WfAmtdfmh4=;
        b=klY+czWSDGE0YPiLsQJ36ZPcAk7UceA5emDNKyVpLxprxTVeo0gzt4n56Q+HYb2SKg
         KWsH9vXQhUmVhB9YQSmlL1tz+bAzZ+4BKJgIQelsXezjUzMDDupRRZGbZCKs8cQrjRjA
         9BPmIUiJHJtUUQCygeCYvZRB+gZOFM0tikkOy/SLZPlu6jGE5GMxvZsdIqRNDtUHHJBr
         thNOFRwPIgmExTpJ/1/RGkgexQVh/RHmW/Er+Xi3G+bOMKUwUaSadLhmBz0xFZbFP8Kp
         ftOxzkQi9Zq2Q8F6UO56BYK03wvZDOc4I3pCR79cfvzAcCLoDKW+c0kMOy1chLL6oQfU
         C4bQ==
X-Gm-Message-State: AOJu0Yzd0LOfrWCdEeV1ptp7twTTkqLoRdZj1iG5eRrHxcF2HVnYaGJx
	ssDXauD6TU+13yFgcC/CclrFAwxoZWkD1+kOyinSBlI+2YWhLsoTbqgv
X-Gm-Gg: ASbGncu2hJpMFt5cF3/Ck/TWHGCxL1RyTIEL+45rvUcAulrH1U3BRv8/qexrFCOFKsL
	InNkfdXUthrngQTZnwHgAISDAdEzSILFgKEe1Knr52lHNJ9ZEbp5OoX8VGR2JHdthNezYWPL4TD
	clEOjLNriRXyj5hv5LLKTSitB39OClMxO8ro0y8XAfszrWR8hcOm0/aDFNK93XEURtdCtX+SBPy
	WOEfGZ+lOaFHUrIm7mxKzuIDzsYoq9LlETXm1a/JLRRnB5nH9LrassTDwSSqLIVZ5w4ROeK/4xG
	o2ynPmA06H7eeXjHEQtQw/YzAS3z5/nhur0bIqP6h60HY7Wx6zAHJL9SzjRMSXJFNMjjKd+2okO
	4+R9UW9+PkNNZ0kzx0kk=
X-Google-Smtp-Source: AGHT+IE+sadGk/EkByIERi7OpHW3NU/UApFbHQIoGSV8uz9mvZCjktlJyE16/R2ihGaf4xDWVV9pIA==
X-Received: by 2002:a05:6214:2aac:b0:6fb:15d3:7f3d with SMTP id 6a1803df08f44-702b1b3e6efmr3751766d6.13.1751408302037;
        Tue, 01 Jul 2025 15:18:22 -0700 (PDT)
Received: from smtpclient.apple ([2804:14c:32:934a:f589:722d:abae:afdf])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7010b230d44sm20863566d6.106.2025.07.01.15.18.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Jul 2025 15:18:21 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [GSoC RFC PATCH v2 0/7] repo-info: add new command for retrieving
 repository info
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <223c7cbd-610e-49e2-90e2-5914cbc0f1d7@gmail.com>
Date: Tue, 1 Jul 2025 19:18:07 -0300
Cc: git@vger.kernel.org,
 ps@pks.im,
 karthik.188@gmail.com,
 ben.knoble@gmail.com,
 gitster@pobox.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <EB2B7A97-B9C4-4F7E-BD27-688C6303DA1C@gmail.com>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250619225751.99699-1-lucasseikioshiro@gmail.com>
 <af27af92-73d5-4f0a-84f4-9c91de6ab6e6@gmail.com>
 <652FDA35-C20D-4F27-A22A-025CA08EB013@gmail.com>
 <223c7cbd-610e-49e2-90e2-5914cbc0f1d7@gmail.com>
To: phillip.wood@dunelm.org.uk
X-Mailer: Apple Mail (2.3826.600.51.1.1)


> The reason git uses NUL termination for other commands is to prevent =
breaking the output when values contain newlines. The output format I'm =
suggesting is
>=20
>    <key><LF><value><NUL>
>=20
> so the output for "path.git-dir" written as a C string would be
>=20
>    "path.git-dir\n/home/phil/src/git/.git\0"
>=20
> The value can safely contain newlines because it is terminated by =
'\0'. The reason that "git config --list -z" exists is to provide an =
unambiguous output format as config values can contain newlines.

OK!

I can't see any downsides in this format. I'll use it in v3!

> If this command is going to return "$GIT_DIR" and "$GIT_WORK_TREE" =
then I don't see why it should not be able to provide other paths.

Hmmm... I never used `git rev-parse --git-path`, but after inspecting =
it,
it seems to have special cases for:

- grafts file
- index file
- objects directory
- hooks directory

What about adding them all to the `git repo-info` under the `path` =
category?
Currently, these are the fields that I plan to add:

- git-dir
- common-dir
- toplevel-dir
- superproject-working-tree

> Those combined with "git var" and "git config" are all repository =
settings. Having a unified interface to them would be an improvement on =
the status quo where users have to know which command to call to query =
different settings.

Fair! By now, I'm focusing on rev-parse, but it seems to make sense.

> Best Wishes

Thanks again for your extensive review!

