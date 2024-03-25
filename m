Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073D6171099
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 09:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711360770; cv=none; b=A6eVZ9Nxrf/EBWs1cOjW+wvgie5RzX3dcMCELAizBDTKdelEeZlHpLBeABxv9tAXTlZmwQ8clbxprhJ9LcCseSyb2bTcrYSwpaA9bMGw1UO/Cq0qiVt8zhX22hW1D+yJSFb6xc0jfjZBSOQZTYpxRLTlF/pkuQBMlXmRp1u6cuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711360770; c=relaxed/simple;
	bh=wgn4JWMtEhgEr5XKDNWXqEfRtzCiWhm9sBak2kV7l7Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lGDbMTxub6+s/Hp3D2jEkcTM9w+mPi+v05K3WRQGGhGDuO6Qm5cCVvpGXnmFm4IJ1G5xramn3y8rwMNHdaCMqhe6OkGyn3kfcAAcpwaRMrBCCSGJgSZVrjlyVejFUTTVmhhLX6dD6dgdxecibrZYs0QsoxWKWcp32lkUG9ZtuLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LjcTnlXf; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LjcTnlXf"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-56c199469f3so400390a12.2
        for <git@vger.kernel.org>; Mon, 25 Mar 2024 02:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711360767; x=1711965567; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YjaxB13fLhkLb35U5wrmyK2s6iSgtQdQg6KcovooYfg=;
        b=LjcTnlXfZq4GkMlmuzw8By0EevKPqJRTI0jAe1IWSBYpy4D7m0BX45344BmNWGafuB
         aQix12QI0gjXe47KlykVDhrkggqlXralP7Y4J1sOXk3GEpk/umm5GLOReuf/hglNs0OE
         bMCauCm7R/7+C3347D5qD33zNu8sZXa0nIEGGbAhTT5/wmI7qpYOY7onxEotZyykcQY8
         tNTJAZ9xFaAqa9JUcVwTe83O+ozWHEM+EAYmwHGR3vrQ2udyjjlzezv670KsKpxh8lJJ
         zUrQMMUGifcXAGuAWRZpzr7r/NXjBt9f3us2nAtO+QRDKDqRYJAeypIBFJ8seZUR7rUw
         i2EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711360767; x=1711965567;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YjaxB13fLhkLb35U5wrmyK2s6iSgtQdQg6KcovooYfg=;
        b=DRtLBTu98OLpZhxBz1MNOVLEp/Ih3uUyTIh6aqBPFP33M6pK5OORsH9TdLEWkAWJ4J
         MRcAY0SfWMc4WgVutGM0Y7rmeurFR9uVCIuL9Ub/RpNRgPXXnahCU9iKpSsNAkrtoHZo
         LO8msO2t/0P6tYvv4lUP1jmD5vL0YuiUeLR0jBkT4zBEVlWmEiDd3a41AfxZxZLEtYnk
         RC1BO+CzuaHKN5+T3DK3nEyXEIkHCSEsHTxBQluvpaN0SUfgnf7YpRouI0v3DdOB07zc
         Hq6Bq4eKtSy3+4RaO3f7+WIEegGTebcr6jIdCc/LLL9fXJEWEE4izIn/9j13vQ2Kph8+
         1fNg==
X-Forwarded-Encrypted: i=1; AJvYcCVzgyYorWtCleSc+/EcVXaWjVBjEYOSCKkvVd48PAytdNqCh+zPZTGckJ4Bvqq/wlenuYTwB1rQzWAmeWagR3Y8tipi
X-Gm-Message-State: AOJu0Yy9oQ6ck1VLIBOP/pi1anPyWcSaFQAhkLC0Hlld/2z/4BmuCfUM
	Durzkoccw4i8JBreDXKko63oKeQr/duxb0640Y8KTutObXcXr/BXqqFA+w4XL1J6MijLO1joROY
	1Xu67MfaofwkZ9UWPVO6gWJZw8/5FdMsS
X-Google-Smtp-Source: AGHT+IFHEKD9eDsaQtmiZARvLpPTEit1AmklU0nmHjqmVAK8lEK1O/R8s6uedZ7hs+mZbICrPz0eE7janP1oeNWJm4c=
X-Received: by 2002:a17:907:7214:b0:a47:4efb:b0f5 with SMTP id
 dr20-20020a170907721400b00a474efbb0f5mr3293275ejc.67.1711360767048; Mon, 25
 Mar 2024 02:59:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1701.git.1711293246094.gitgitgadget@gmail.com>
 <xmqq4jcvtxtz.fsf@gitster.g> <97212b72-70d6-e55f-8b2a-04ede4321288@gmail.com> <xmqqfrwfp0hh.fsf@gitster.g>
In-Reply-To: <xmqqfrwfp0hh.fsf@gitster.g>
From: Chris Torek <chris.torek@gmail.com>
Date: Mon, 25 Mar 2024 02:59:15 -0700
Message-ID: <CAPx1GvcPEeC3HTdb4bUYASz-t=a7Z2MEUamB4QyO44y4MRy6Pw@mail.gmail.com>
Subject: Re: [PATCH] t/README: mention test files are make targets
To: Junio C Hamano <gitster@pobox.com>
Cc: Philippe Blain <levraiphilippeblain@gmail.com>, 
	Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 2:49=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
> As long as we do not use these $(T) files as an input to some other
> thing and list them as the dependencies, we are OK, though.

You could (maybe later / at need) stop listing them as `.PHONY` and
instead use:

    $(T)::
        sh -c ./$@

or similar, so that some $(T) *can* be an input. Note that this requires
using double-colon rules earlier to build the test.

I wouldn't do this without a pretty strong reason though.

Chris
