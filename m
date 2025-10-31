Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B958A17E4
	for <git@vger.kernel.org>; Fri, 31 Oct 2025 08:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761897802; cv=none; b=UDGIi9xPLV/+WfoXZYYTQTGsJC8rsDtRU0ReN/CTtC2I83VdT2jUZNhM+bvuB+mDH63bVwOMuRJABCENkKIaYSmFUwIGI2+FPP+mEJWie4zlnDBvUQ9QsSlqV1ivedkk6+/UOEyUA4jH+yjVq58HTV0e8jLr7qAaS0o4hxKa5JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761897802; c=relaxed/simple;
	bh=U+FwJRQOLm1xgARnASNZQSde/deWtoauiqtLnycNyx4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Td7jGPNdC5qtf1RdqSTHJEqIWVWaBVcr3a9qMI/9VcAAS21v8pX5Fq5UiHbtv6x8+yD7jiolOoKaiSXedgHH7wA7MesN6LAlGkgzqt9GR1I0R3hhQFcgdtBk6/YdZkkTQKAm0aO8DMvAg6twwJZU//TU+LJdw5EZj+gYKpfhPkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mAePF5dM; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mAePF5dM"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-63c11011e01so2743912a12.2
        for <git@vger.kernel.org>; Fri, 31 Oct 2025 01:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761897799; x=1762502599; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8+fhXhHdu4X5KMnJxokZKh15Tj5zddkQghj6QlBQr+4=;
        b=mAePF5dMZy7XvPwF0kFy8BfnAsifEPfdV+3N5DhMtmdr1NQ5WM0KcMknPwqbjhAPiV
         mYfIlAAIzJN8pQVgwwL5tNnCcj6RFOrtAjuCxyJUDPLjZlF7zLKIRJ+5NmomZwJyxv2I
         iSHilWD8rVFaLiLFRUO3ORMBrbGlT+IYJTIJel3bISf9hRhOF1nS1tOS1ySCZCoVamr9
         oqF4GRqnivjgZv4HcEAoBW/ZmCRyHUBX/qNvl37gbZmF9MZfwiLxtOiK/jNqxx6x1Kj0
         wVal+V4xw0sLktunWhv1hhr+qY38eXlAYLjAY3dJuyXLNDgUn0hkC54GYJyWSGZwk3uf
         Llgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761897799; x=1762502599;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8+fhXhHdu4X5KMnJxokZKh15Tj5zddkQghj6QlBQr+4=;
        b=LAKZ/SWlQiJZDoZYW1EMUIxaAppjpZX2mODUBPFJUhMprHPxTVglCJlbeg9rT/eboi
         BID8/wDD+NHHqqvD4cp75UuUiSrJg3UQTbphw/3t9xx+34UmfMFFY0XbuDRdtS5cS6zU
         1JV7+J8qCbrTR0q8EfkbRMr8/E6z0SemU46Rx1FOgouNktqXrTIHNxuuoQ2oKXB/2+CT
         0ubn23hJDaE9IKYS20/9qpPdESdpeAYr7TO4AsJtcEpSEzTxt+Ux6Ylmi6B4qtNPthPJ
         /1LNjOrG+P3sy4223Zbyj4MtUQosvkRYRkObskeb1LH1ilKNm/jkYQpX70rq40othuo9
         HeMg==
X-Gm-Message-State: AOJu0Yy44G61yJOb+ly9x/cpGYx4AhZ7gEQ/WrqbwffSub/eHzkh3qyN
	CGmcxvmIC30GZg5Qxxs42HZifMZcqnduZiPW+OLDU9Z/l33K7li6aAX9rF787i36A29b1Tu8r7+
	HJyOfKWixhLPXo6aD1jyHaoadYWKbBqxWVUI28QOYMw==
X-Gm-Gg: ASbGncsyErdhb/JerbDEG+EOLlt0Dad3w28Y+MCUHbnSA6eW7VvEQj3ntz1G88/nPZA
	mAaGk0KlRYt5HNsD9QOJex74wzF6yj2L6tzymUrp5MToP8F/n/Zrf7oi0Jvf5sNeplOllWYQIzI
	vjo8iDaU01edonWHMbQt4G5/zRs01Pxk6RHfqeh/FSu37kR7FzBsAXRU0aNiF/1RPG2qoQ0nGLw
	QbIBfJZIrz1f0/XgF3iTMRmadMUdDO6ov6RNNmrsUBM+SEHDUTf3/4VdzMqfBg/tEVKjMBHPyNy
	pfG5UESj3EmEKde3N4sgTBzNzDoEZNsAgWgKXPLNypJgly3959kaKzhKszgV3Obd6F2m0sDjhVJ
	Uk3vSUaSKbHGXacI=
X-Google-Smtp-Source: AGHT+IE7jCMO+iKJEhawibGbOq1LqmxKaS6lS8fAaYMz1p2Ao2IqF7dLGCug27SNZhd0vBbPbK7I1MmyHXN7vkDjrH4=
X-Received: by 2002:a05:6402:3514:b0:639:1ee3:4e83 with SMTP id
 4fb4d7f45d1cf-64076f7cb1emr2005491a12.8.1761897798732; Fri, 31 Oct 2025
 01:03:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Remke Schuurmans <r.schuurmans@gmail.com>
Date: Fri, 31 Oct 2025 09:02:51 +0100
X-Gm-Features: AWmQ_blZa7DCSZ4232-IhLNnxpi_i7sQZbiXMErOLmgEfl2aFCbMr2taDMbmrTg
Message-ID: <CALnivwfp+WTN3VKY1LQ+04OX0nwPSfKx4zyZDsCDeXg8ubEPqg@mail.gmail.com>
Subject: git whatchanged
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

'git whatchanged' is nominated for removal.
If you still use this command, please add an extra
option, '--i-still-use-this', on the command line
and let us know you still use it by sending an e-mail
to <git@vger.kernel.org>.  Thanks.
fatal: refusing to run without --i-still-use-thi

;) I still use this one.

with kind regards,
Remke Schuurmans
The Netherlands
