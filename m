Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FF819D898
	for <git@vger.kernel.org>; Thu,  2 Jan 2025 15:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735832274; cv=none; b=YAR+zyB5tRDTDAQa20a9jp+clqbU8UO0nw8+r7W5OIXDCp+3x1hKnky8szyky2iaFtYspenyZ9qeMKA4Up1phdZqvyaXQL1CbAi7J+NECpe47HPIH+jLjFGo1Q3RcEdhb/J1bxbpFCatZvYbieOuN82GjHqT5BgyjOTRpZkKMvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735832274; c=relaxed/simple;
	bh=DjnRCkx/wi75n3wrxSEj5NJrkWL4TuRfxJA89eDmmjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k4sEZpOktFgT4K2uzywHf+aRYLSbt7jopwYxm7nMO0HXA1Y3wZcMPl/zZ4d8l0CzU/3lVaAsPxHPT6p3lfEmoGr/NU3TzndrDPdvoZ6fH7sHJqW7b/TT3nVXJIoFCQZzNy63DglZaToqoIuQeYpda+bcF7aRoERsjUDi7mQiKvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ikGl3wU7; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ikGl3wU7"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2f42992f608so12631428a91.0
        for <git@vger.kernel.org>; Thu, 02 Jan 2025 07:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735832272; x=1736437072; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4/bkri4I0kk65aXs30r8FhJGuR/9/bY5ZPTMh41OfT8=;
        b=ikGl3wU7Z/OKDPC8aCPbTcTRDcDC7413zA68vnYkHK+wgXhWgmOiwP39HY+nZ+fhUJ
         ZZKpCI31iKiwt+KyLHebORJfnG1NB46qSCzcTGQmVYStMOK+KPe4Fn10nHligG2ndMea
         EkZtz2SymP1xE5tAO7abaHgZnXZbQ48KP7F6ummEUpTDD4EuZnPplTE2OMdVys24hQOT
         yNMp6p0rKkfscey9PGhErm/PbUXlH0u+BbUxDbtiJhNWB7nIoZPPAJ2fgNfaddVykd4/
         ksj7QNenvK5F4talA04w8fsVjwfGA9hlNhe63NugGoE5oHpQYVC6B+eNv8nzioW4dXOX
         Mz/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735832272; x=1736437072;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4/bkri4I0kk65aXs30r8FhJGuR/9/bY5ZPTMh41OfT8=;
        b=iZCVC0VWDFXpnvDGmCsrTHaajixvLUs41oxtrNlHcd3l/H3lQEItlreGPGSUeJ6OiA
         UDht0Rf3diQFZgEvhKHaZAfqWNmulitv4XBcqvbah+6UolkqXMyGTRpTBpVg63iu8F2G
         maLnjYIpwaCJAO55Q7BpY2XOvEZBNqvCLCipj28qJCQfKpT9m88gaLEZVJW7dQgdkIgo
         Zyg2IaLBLUb8opiy01cEsrd5LuGG2gvpe2E6ws1VsIC79EQbwqCVcTm/yUW6kDChZlBZ
         DBJXsM+cWAZWY2NTES8YcTnHhnkUHbe+K+2e6nSCyzhygb8Bmjo3WQKQVCpuTeTjxeWB
         dQ/Q==
X-Gm-Message-State: AOJu0YzdlyD4akbA7cxPaqHelDdlBiDsD5F7fsWFaio/4QbUGtbUNHx2
	dYVkf6UPR2oZl4g15HU0dW+ISLDBY+L0ivL1gCjBr5k77ZmFc4W5/PJRrdGz
X-Gm-Gg: ASbGncvQi/3VsHmI2aYr0qGYBv7qFaRp9J0JAeKNTDr6wpiT6BKXKj5+RAc6Mw5iYar
	m+/kwmYgPk1RIk72gcJWuB75jRHtN9PYGgDI9qXFw++cLI7h3NiG4a17Z/E3WSY5SilKsnmylam
	NxqzgnIUnJt7TDNSdfdp2v7e1KkgeSEouhPqw15ilWdHJy3F9qYhbuZYvuzGmAnle4nhVx0wbIE
	7xwcxIf20iXwTrWSp/n8VL/14QzTmQwj1CxeTnmHWfCHie96EMqexvYzBZaWaXRhyRLAUHkklnG
	OuQexqJ7lwPg5Ku3pQ==
X-Google-Smtp-Source: AGHT+IFCyhfusuyW7z5w3OF+p4ZE4uN3K4urYxbhPTD8ogEJgTcTvVgUDYNHwNqVE10uR+zepwH64A==
X-Received: by 2002:a17:90b:5251:b0:2ee:9b09:7d3d with SMTP id 98e67ed59e1d1-2f452e4cf19mr69246141a91.19.1735832271965;
        Thu, 02 Jan 2025 07:37:51 -0800 (PST)
Received: from google.com (56.166.125.34.bc.googleusercontent.com. [34.125.166.56])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f4fe30f5f3sm1914595a91.47.2025.01.02.07.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2025 07:37:51 -0800 (PST)
Date: Thu, 2 Jan 2025 16:37:49 +0100
From: Jonathan Nieder <jrnieder@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Toon Claes <toon@iotcl.com>,
	Andy Koppe <andy.koppe@gmail.com>
Subject: Re: [PATCH v2 11/12] t/Makefile: make "check-meson" work with Dash
Message-ID: <Z3ayzUEfW1xd4Up0@google.com>
References: <20241227-b4-pks-meson-docs-v2-0-f61e63edbfa1@pks.im>
 <20241227-b4-pks-meson-docs-v2-11-f61e63edbfa1@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241227-b4-pks-meson-docs-v2-11-f61e63edbfa1@pks.im>

Hi,

Patrick Steinhardt wrote:

> The "check-meson" target uses process substitution to check whether
> extracted contents from "meson.build" match expected contents. Process
> substitution is unportable though and thus the target will fail when
> using for example Dash.
>
> Fix this by writing data into a temporary directory.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  t/.gitignore |  1 +
>  t/Makefile   | 12 +++++++-----
>  2 files changed, 8 insertions(+), 5 deletions(-)

Without this, I get the error described in
https://lore.kernel.org/git/CAHWeT-boK3x6mup11boEinNDQiAxxf0vwvZkxsGRc_GRvXYA8g@mail.gmail.com/
('/bin/sh: 10: Syntax error: "(" unexpected'), and with this, the
build in the Debian buildd environment succeeds.

Tested-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks for fixing it.

Sincerely,
Jonathan
