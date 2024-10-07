Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7164C91
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 11:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728299824; cv=none; b=udE7JDb3REy3n6QTDu7gACkYY4L0JyqKvkE7gJsrvp96ydNbHyRhXs6bAtejHKeYv1lqR7lVHPq7+rWMyH6v6MmNWLS5eemtpoWsqPVVQo9Vc5q22JERlysAg2VRMd4mK3THv96ekVmNUSCETY2X5eU+CPC8IdNrAUpjrjUvAGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728299824; c=relaxed/simple;
	bh=bmREvKN1sE4Vm3vvg2FUqnuREJOB+VwkLfABAWfq/tA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fk1omUs2WKYkiXSRT3HG7hKovlL1eZblkvbG0lTwuxh9MQc2s6z6k36JyWUGdcrLoaFLLA+mcV5jhw874QCqNV3fU9D87IL6YL3nTxNK7I5E36oTv58qEoL5ICt0fnX1gPoOLBsZFWQ8GNHRg+6YtUP81mGr975OTIngnrr16Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZJfmfwmD; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZJfmfwmD"
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-4a3a2410ba2so2480504137.1
        for <git@vger.kernel.org>; Mon, 07 Oct 2024 04:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728299821; x=1728904621; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5jxX5dZs3tbwFC8oHxJB3rn+RqK8p0+ELH53rjw9VPo=;
        b=ZJfmfwmD6C+rDfu8PXtiaPrIAdtdQTNI4wA6FIRnyjNbmu07p0tcttwqkXQjo+WQ9T
         3kMvPW6U5d3l06fx2yEr2bu4OAIIlC3ONUtSB7L+HSrwzYtKneSUPM+P3zNAI6BNYYqp
         lw/8UE0NaGwHPSGpB1RylXNzntdbquv2T/pAY78ogO3d8D/c2NFFC9dNvWa0eAz80BDk
         7MADjH2KAP6V4rsIs1DRsPBPRUBRzG1rd438ouVpiKuD+T22gyaJUdSMlx6v0dzIx8qo
         f8+MlKqWu0vKt6dWbNepc4bpq3pg8jrs1c0NvGjHwByt8LkzAjE0wvhgL87Tkg5LKk0w
         7p3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728299821; x=1728904621;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5jxX5dZs3tbwFC8oHxJB3rn+RqK8p0+ELH53rjw9VPo=;
        b=HOQI88WabDvteJnRXRNI6q679SmkXBIgy8x2d4xBJkAjn+LpI76rhq0hEYklJ0IeIz
         fOW1Xu0A038ONnJBoiJfLCJcDyAYIc2FnBQUPZZQcTCw0e4731ALwWn35cl78zFDIfz9
         2zKHNjFXAV2bN6feVA8cRHjDGjaVR06tE/VJCRR5WfGflj+pRIEhBjvhdWJf3SmJ5LI2
         nGfDQjdY6TDunHMtXgYZJrxicyGwKXnUvRoL1Tz3ounwJhxrAxC9SM2jrIYGuwR9r+N1
         CE5XD3G505bFrwN5+Zs8DfDkoaTdJAqVv03vwWGpOybR3rqeb2HSnhgUP1zad4nI38PB
         kD4A==
X-Forwarded-Encrypted: i=1; AJvYcCXldcD5PWZ7ZsUHASpNMLUEj+98hGXZ78koKhM29EtpJ0XCh8ZGECdOATXWPrAgasbcmGY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsAVoV7ZK+5qzIOanDs7FKErH6f+MPymH9vBgrn9XuE5J/JF3N
	wF4HHchDpfcQeVrJTlCJNuSjsrY0zcksBf3+nNIo+voxlYhQsatQ/B2tfoX1I3p40faPtznbh0T
	uTtrjT8g2pR+kUQuwLBCpteQB/PE=
X-Google-Smtp-Source: AGHT+IGp5tc8DZNnFg8qIu5lFyHp8VcA79+K6MopT1Bt4DHD4SISPGhmPsvfVRN2GyQ3TO1A3bMdNjOvo8P6nnK4uK0=
X-Received: by 2002:a05:6102:4429:b0:4a2:89a1:133c with SMTP id
 ada2fe7eead31-4a3f4e0a084mr9145492137.4.1728299821431; Mon, 07 Oct 2024
 04:17:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1805.v5.git.git.1728298308.gitgitgadget@gmail.com>
 <pull.1805.v6.git.git.1728299466.gitgitgadget@gmail.com> <ZwPCDAjeQVf4VFc_@pks.im>
In-Reply-To: <ZwPCDAjeQVf4VFc_@pks.im>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Mon, 7 Oct 2024 11:16:49 +0000
Message-ID: <CAPSxiM8FpPyCgvRqrH1gEhZEskGRAeBO_2+_1FamTHaezr9+Cw@mail.gmail.com>
Subject: Re: [PATCH v6 0/2] [Outreachy][Patch v2] t3404: avoid losing exit
 status to pipes
To: Patrick Steinhardt <ps@pks.im>
Cc: Usman Akinyemi via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024 at 11:12=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Mon, Oct 07, 2024 at 11:11:04AM +0000, Usman Akinyemi via GitGitGadget=
 wrote:
> > Changes since v5:
> >
> >  * Remove spaces between redirect to conform with git style.
>
> Thanks, this version looks good to me now.
>
> Patrick

Thank you very much and I appreciate all the guidance from all
reviewers. I Learned a great lot of new things.
Going forward, what should be my next step? Can I work on other tasks
now or wait for this to be merged? Are there any other things also
expected from my side as an outreachy applicant ? Thank you  very
much.
