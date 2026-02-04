Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DAC3A7834
	for <git@vger.kernel.org>; Wed,  4 Feb 2026 09:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770197499; cv=pass; b=srtBolW9fjYpWQyCM0CzcyKuz7LaoiFAtXKBXU2lG3JjE2kWDekQI4Dd/n3P8a51h68+tZV2wuByWomS1PUdPbJwlE/3Mpej1OtS5Jkd0STJBvLVslc5TfYKc2TSIZVq4vArafKEniI5dY5ILZQbMecWAYktdwjCK1/N0ypiy2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770197499; c=relaxed/simple;
	bh=JAYi36UMtkDA71Cs/PVT8okfkMfNc3Qy36Bb4rj1lms=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=rJvda/0IjJ+odWqtUFEdgCuyO/epl/AwqAvmaWXN4HBMxa9H0o8ycB/Qp2RA84YSa5drJQUQKk+0wvQmGkTLjlxN7RDgSb/RSVX8NxWplIG5qkQuG5/kaQT3M706c1J3gKCSbwP3ulspXZLRLumYlmJYxh/FB0lilZ/Y9DpjbYk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PG5UCPqY; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PG5UCPqY"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-64942ebf1a3so6054719d50.3
        for <git@vger.kernel.org>; Wed, 04 Feb 2026 01:31:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770197498; cv=none;
        d=google.com; s=arc-20240605;
        b=ben0WmGEDsmtG8Q6MMn8/LAv/joN8Q53nb1ZrFQHLeVplLN/cUZJy/YBGdpafMucFS
         joXYXHP9pQoFcP60DafLIuSkmv1TCat9lK9Jm8WPXFF6RMsb0O7Jy3KJ3xuB7L3fuqza
         A1V3n9wh+7Eg91t0KwiMnHSQiAUkt8kjdMLJ0cllhOAabJOGuMjUmPklQFX94D3vczK7
         Ho3+2+gxXryi7TUEKzqi2yh6QnH5xT2HrmeQSChUrx331ntMK35FSncGxnESM7RXlHn6
         d5mFK7hntjs/NC0xufan8j4isS99Uka++HCjUTU4vVSgb+eJEdAkPZj9dzNu6w0z/FgL
         d5rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=WbrdpCMmvmr4w+OLK58YuHckW1U5f8Y/Pwx1TdwnTRA=;
        fh=HzzSnR4Rwro+v40uPs620AuPWprvsOw9+XSrcVIPbqo=;
        b=CNkBIohLA7G7Q/AxyHOU6e2Znegd6YkZkOw8Ytiy5Swi6PQH+DURdB+VRO2KemzgU5
         wNcTo/M/J/OFta5YzjKXRUhrn5tiONEU7ahM3o1uUDm6KtIWlvb65hm+TtSW4TQZ87Nm
         Cc6+w8d2bs+vvcafyhsFqSFTzGfALacegxz76LH0U8fwuJOu6esN7XQYb7sQleVQJxQZ
         szREkb991+AWfbADlJiIcrWza01JJsmnNYLUu7xW+o+ndC2DzRPb7r6f96hFXUkFT/kQ
         rRk+oA5oUy1LVPWiGIyX7fskfkTV0LvOiR9Zq5b+e5Qrok+ap7sGVBo581isJye5Sa1Q
         10Wg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770197498; x=1770802298; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WbrdpCMmvmr4w+OLK58YuHckW1U5f8Y/Pwx1TdwnTRA=;
        b=PG5UCPqYi3zYt9WHAXT1ZHEdm7Hno6K5vMqQaxz5QM1fux5CpjFjOCe4m9cgTX+yMb
         VxZFcnrig+JR3yvPc/KR3bbMCwwjq8R+GBy3v93oq8be8cC3tTw1RQFDm0SvZGOjVzZN
         85aH/fby/tPI6h+VoYTm0tipQk7S1/oO4IIzTcWY6/r9sep5sH3omnn3dM3UiUSLRXQg
         9LxGyTnWuOOZ56kDZba2YLBMAVfZS/bu8Ge8bhKyUsd0PUR19+pmWsR05JhtSVvSFim0
         EKgCjhWrehtcrQRtWwsTghCN1mrmb+/5UPswP66pEI5lLL3jG1KKIohWNkMIl3BOKWU3
         WFNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770197498; x=1770802298;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WbrdpCMmvmr4w+OLK58YuHckW1U5f8Y/Pwx1TdwnTRA=;
        b=uYoLu17QuTtpLQuYlxscfi9sN7THd2pN5rC9lFhhTwEldVReiQtWsfn3FuMaN6+SW7
         15lZctAjRHNVe8PyC18iN3E4xeIw4Q2X5R8VgXjiqy4d46DqsFK9NdOqCgU7VOfzNQmq
         QAqbT337Ti8EAfu7i9JNBHf2IFWzFZQ+q8NlaajhLNjRO3a+AzXOgMzxmbBiLW6B6axl
         hUoi2a5EvusIIfLSWbKiniQgQcpDvUY9BUs3GiiHokJuuIWtFh3Z8KCsRFWNnVJhKXMz
         z3fOwbj+xSB9nkGzpzjie5q1zvYHxnx3qNQ+mGyTSiy+ZaLGNFxlk0bRhEmpDfMaGZTm
         o+nw==
X-Gm-Message-State: AOJu0YxX7iokVsmssi40qHTjD9/jsmry3oDs8w0RX+9zujuLMuyo8R/z
	5yESexnA0cSPdro4kbY7bvMDRQK1a0CNd1NxHf9Uz2+cOg/PuxFuc6giS0xN2Xr4trQySfKjRkQ
	/YuW3BsU9CXwqshSZ33wnqZsYejH8d1w=
X-Gm-Gg: AZuq6aLT0xIL46D5F/UYC/+7KN1x6NPreBaIl3fcBQm5XF/kOvXEuO86VqXgwYYc8sb
	SOGF6v53FRmulPvsWk/gWfTUY2tNzR3z848yRwAwfmS1umqn2s1MCEyNsnP63umKsit95f6vD/N
	OlbMLunTk5bWfSXSQyqAywXRed0Yux0ThjgB5JFNSHrtKLFkdwpsCdUiqlPtCCct6lgtaNMdc5i
	KrPpWKedJNC92ExUNA+ySfUxOdieHyLtPdGMW6d0ewANWADzOKCIl9y263h9Peg/WOP1uEKma06
	eL9IO0s0owm3ZZe1W/uJzqoKnhath57wAO4u9X2KN1zBKshdYmuBX7WVHNpyqTp+Zht18nR0kat
	a6XmTSg==
X-Received: by 2002:a05:690e:d4e:b0:649:67da:4a01 with SMTP id
 956f58d0204a3-649db48d152mr2101960d50.54.1770197498383; Wed, 04 Feb 2026
 01:31:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jiang Xin <worldhello.net@gmail.com>
Date: Wed, 4 Feb 2026 17:31:27 +0800
X-Gm-Features: AZwV_QgwZj4XYLdceBE7ixLjVysEG2BNIeCiBsWz_Glfdqi6OBl4qQ1mZUUof0U
Message-ID: <CANYiYbFhshDwfttKWYGDfO+K1qAz3ptVHuuHrWXhD2oYBF7baQ@mail.gmail.com>
Subject: [RFC] Introducing AI Agents to Git Localization
To: Alexander Shopov <ash@kambanaria.org>, Mikel Forcada <mikel.forcada@gmail.com>, 
	Ralf Thielow <ralf.thielow@gmail.com>, =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, Dimitriy Ryazantcev <DJm00n@mail.ru>, 
	Peter Krefting <peter@softwolves.pp.se>, Emir SARI <bitigchi@me.com>, Arkadii Yakovets <ark@cho.red>, 
	=?UTF-8?B?VsWpIFRp4bq/biBIxrBuZw==?= <newcomerminecraft@gmail.com>, 
	Teng Long <dyroneteng@gmail.com>, Yi-Jyun Pan <pan93412@gmail.com>, 
	Jordi Mas <jmas@softcatala.org>, =?UTF-8?Q?Matthias_R=C3=BCster?= <matthias.ruester@gmail.com>, 
	Phillip Szelat <phillip.szelat@gmail.com>, =?UTF-8?Q?S=C3=A9bastien_Helleu?= <flashcode@flashtux.org>, 
	insolor <insolor@gmail.com>, Kateryna Golovanova <kate@kgthreads.com>, 
	=?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>, 
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= <pclouds@gmail.com>, 
	Ray Chen <oldsharp@gmail.com>, =?UTF-8?B?5L6d5LqR?= <lilydjwg@gmail.com>, 
	Fangyi Zhou <me@fangyi.io>, Jiang Xin <worldhello.net@gmail.com>, 
	Franklin Weng <franklin@goodhorse.idv.tw>
Cc: Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Dear Git l10n team members,

Two commits have been introduced in the next branch of the git-po
repository to better support AI-assisted workflows for Git l10n
translation and quality checking:

 - https://github.com/git-l10n/git-po/commits/next/

Before submitting patches upstream, I invite the community to test
using AI agents for day-to-day Git l10n tasks.

To get started, work on the next branch:

    git clone git@github.com:git-l10n/git-po.git
    git checkout -b next origin/next

Please try using AI coding tools to update translations in po/XX.po or
review historical translations, following the prompts below:

 - "Refer to @po/README.md to update translations in po/XX.po."
 - "Refer to @po/README.md to review all translations in po/XX.po."

--
Jiang Xin
