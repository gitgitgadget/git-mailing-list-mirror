Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C653B54656
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 18:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723746205; cv=none; b=UNQjEx92YAkPtX47ooRFVgRrQpQtkK6ESFVR29L7e+G1HUeaPKVKE7NwNE2QqILivzLjnWMgUqoFX8AhF0Ogk6QYi073y890nh5frxRbY/HACWzVc4jwIExNjBaqG+sFPFm3K7g7+WzuCwBOrcnBFdyyNOrYDRWjXxwPPHK1jPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723746205; c=relaxed/simple;
	bh=OiV4Sv5tcl+vd1mzNVwT7FQSxUOIXUBFLgGAh6Z5XeQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UAJvXBDimrezrGSxGy5rZ9/9iH5MDw3WrRaCC5S6G3iRWiNmrIFn9jq044QFY4stdAQLX4JC3rwrS/269up0Sz3JJqp3BFytsNA508bZaCv4FPzx1/IE4A6EAUusV3sFgepRj9zMSFFm2SUnuwgWRSpzvpEBgwBN9oGxGI63ZnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SIPVDLJK; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SIPVDLJK"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a7a9185e1c0so102818566b.1
        for <git@vger.kernel.org>; Thu, 15 Aug 2024 11:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723746202; x=1724351002; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OiV4Sv5tcl+vd1mzNVwT7FQSxUOIXUBFLgGAh6Z5XeQ=;
        b=SIPVDLJK6i0Fev90S8qmwfy+bejJquWj0Hebq/dMIdgztT/RQg/2g/ql5YxPsWdeMv
         UcMHOf4hRysjJi9xN12HFz3i81v6a5mUPgRRQv4SRoftqOv9ouht8I0HFhemE+lKkbcH
         1QRGvASvoFwlUToc3UGcQJWEeKlvlwDQfC0+yah4h52Ck0WQ4Ixt8ej69JMsQX4hAASq
         1U4qJKaxR1QRsxpqxiNyGExOVl2bJtvee6vL4CXWSrCRExXRGu3Nv9XwT0n1Mg5OCDG9
         H/R68ODuCck2RkXg/ryr+eqiCMVZrRN4epRq8PVuz/T/HFA5ID4EspW4pHCo4uJTcUG+
         V7YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723746202; x=1724351002;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OiV4Sv5tcl+vd1mzNVwT7FQSxUOIXUBFLgGAh6Z5XeQ=;
        b=LO2TSc3NrVv8yShQPNHjrWbl1nscQ35B5CJwTyJC16+BrLhdJvf83Uyx+pznk2YBPj
         WCakhXzol2QxzrIgFhLLqCEpSYLWdqAC7yntJJPlsp1r1z4hnk55GkJ30h1jYG78ya83
         r4tCAn7tiswYOgrOgaLDmz/u7KArd6OS+BiXsHrSTSBzPz5hUFJjP7FCSgCvSb3wd5ro
         OdQ06otmBVu0aeDvikDkfqivQxSLCXrtr8uOjUKDlBvfoNJ1eJxpZAYjyqIU+U7uEyuM
         mI2fdV4ZudmTUD8Up3VafJWkBdRtQRhw3Z/TotQ1TS4fmSpKa4KoCdRTIu1kAwp/DoFQ
         Ji3g==
X-Gm-Message-State: AOJu0YxqrG+TXf24Uo218/wbhSGL0lZrxohfnTX2wZc5HQKzJ/S5v+rO
	D9qE7YMJy0vPUCMzfI3k9ttqVfybEtdyO4W/Ktjm+OOGmLwYEStsp9KEPvfZC1Vpx8SffJbYjF2
	T2eFeM2IKHw3kdFygKY4wTayu9+o=
X-Google-Smtp-Source: AGHT+IGaZ/VC0JT/eI3Dx4fckbmvtml5DjziY1+cgvza0bvHSofPlw2fAvnPelG4OtUB0P9RzZAQqAIzZ2sBV82ewHM=
X-Received: by 2002:a17:907:97cf:b0:a6f:59dc:4ece with SMTP id
 a640c23a62f3a-a83928a4023mr25882566b.2.1723746201805; Thu, 15 Aug 2024
 11:23:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814121122.4642-1-chandrapratap3519@gmail.com>
 <20240814121122.4642-3-chandrapratap3519@gmail.com> <Zr3NGugrgjrJlPUO@tanuki>
In-Reply-To: <Zr3NGugrgjrJlPUO@tanuki>
From: Chandra Pratap <chandrapratap3519@gmail.com>
Date: Thu, 15 Aug 2024 23:52:55 +0530
Message-ID: <CA+J6zkT-aXhB7p-iBxVErAJ4jYtk9t98YGuCWgu82LX_3WUvyg@mail.gmail.com>
Subject: Re: [PATCH 02/10] t-reftable-block: release used block reader
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 15 Aug 2024 at 15:10, Patrick Steinhardt <ps@pks.im> wrote:
>
> On Wed, Aug 14, 2024 at 05:33:10PM +0530, Chandra Pratap wrote:
> > Used block readers must be released using block_reader_release() to
> > prevent the occurence of a memory leak. Make test_block_read_write()
> > conform to this statement.
>
> Interesting. Didn't the old tests run with the leak checker enabled?

I think not, I was able to find this error due to the GitHub CI.
