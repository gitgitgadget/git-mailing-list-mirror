Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9AA849C
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 08:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728290652; cv=none; b=W+60zZR0UnbnDjz3xepoOUN+VnNlW+It9cb+L0pCJFXaRiqNvdAJCDHxSzLZFkXbmeaoXerUp01FuZtjrGK0igpm2bAUo8IZ39RNS3GExVeisrVqROcEBh+knw5sf9Acx0xupCuQpyNmpghLAIGBcoqQ1EL3zmvN3aaO67AYTwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728290652; c=relaxed/simple;
	bh=oPItPD8g6ASfFpXoTfmPRt5yQld1CNO44MgzoX3yTJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UWNUkaCLQOdU71QnxdsDlLd24KjKEEAHKWMrzbKj9DVqpuJe+ktxFf7akkBxw6ioeduexhYX3l9X9H5ZbvFLQkx4pq+xxAh6jaQ+IZ396edmXv0Q426nrcqB7IA2ey5IxTgM0AqkjfLnzHlvoav9AikBnhNOJ90JasLcZtuLCUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A24toxFk; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A24toxFk"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2e0b93157caso3660232a91.0
        for <git@vger.kernel.org>; Mon, 07 Oct 2024 01:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728290650; x=1728895450; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1l5MZtoAcbsvhhRAdjj50JDLleAYM8vCjxlwYXCCwOo=;
        b=A24toxFkP59ktQ9+91HuTJp51CJBw83XGB4FmvH3SyymFgBGWaEx9MzRUfOHUN3uLy
         WUms0kroJ9Hzy7aWMfnxOM50B4O77XG/qlx7sUVbUxwHelZwONapB6kV9Y5VECxOrD3P
         uH8GKCEzWDDr0YoIVIk9FSAiY8Chww/L2h1tCxnY9pYi9eaGuxGzxfTPhwE8Yq19l/ox
         suZFDhQiFUVuDz21II9SCEoUpP83pdeHTDc+Cfmz1F8SmgxJLUMR0Y4QDHuttARCAm+0
         Dcm+rTBzxT6fEFcOal66qvzehlaI2nN75wQR89ygZS3GmpQiPRYEjNfOvvxUDSImRifZ
         cxCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728290650; x=1728895450;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1l5MZtoAcbsvhhRAdjj50JDLleAYM8vCjxlwYXCCwOo=;
        b=BfaxqeYvp2L3gi41c+hwfTBftfTvr/SgTulahTlh04CkIltqp+0LExA0xr24z3Ef+h
         0GS0sTtzF2r5oNuS73LIsUGaNRLnQR3cIIfyBJ4dVBHPq9L0A4+PK7c7YcKXt3dQxTlg
         xFYjt+LGx/LASeD70nk2w/qESZwVWF4zfuEggjn+VRU3fNoGDB++0BbgrBW1aH0kSmO3
         1ZUHD/2kiYke4TFGKtroIr1vOXlM4LRrY8naxS/5n4X7DtHRY4KwZldnZdxblWMe4YjR
         609jGZbZP3/3dtUq3DdCLMfBMLVUE4O4S+2yJ2hZlwGoj9/DJ/ZEDWiX6pGSqE2rqAfe
         +G5w==
X-Gm-Message-State: AOJu0Yx2xFwa16VzKkOwATGhHBBEKZbBd6UZS13DxC50H+JqHKohQbj6
	iyrf2Vw8s+0xjyG7oR1p+9A4uALtZYLjSA9sCvo2gfsxBmQASwVgHciDuU9Q
X-Google-Smtp-Source: AGHT+IE2BspTW78PmsfH9jYPM7oLjakwUExpIUmEYiJjcaBq1lnyI9yGTO4+j3wTx4bJN+QMtCHcEQ==
X-Received: by 2002:a17:90b:3850:b0:2e0:8bf7:4f0f with SMTP id 98e67ed59e1d1-2e1b38a1a20mr22887379a91.5.1728290650335;
        Mon, 07 Oct 2024 01:44:10 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e1e8247befsm6699299a91.0.2024.10.07.01.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 01:44:09 -0700 (PDT)
Date: Mon, 7 Oct 2024 16:44:16 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 4/9] ref: add more strict checks for regular refs
Message-ID: <ZwOfYGi21oa302sS@ArchLinux>
References: <Zvj-DgHqtC30KjJe@ArchLinux>
 <Zvj-sBX-0AFsuFDC@ArchLinux>
 <ZwOGnQSqmwALK-9z@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwOGnQSqmwALK-9z@pks.im>

On Mon, Oct 07, 2024 at 08:58:37AM +0200, Patrick Steinhardt wrote:
> On Sun, Sep 29, 2024 at 03:16:00PM +0800, shejialuo wrote:
> > diff --git a/Documentation/fsck-msgids.txt b/Documentation/fsck-msgids.txt
> > index 22c385ea22..e310b5bce9 100644
> > --- a/Documentation/fsck-msgids.txt
> > +++ b/Documentation/fsck-msgids.txt
> > @@ -179,6 +179,14 @@
> >  `unknownType`::
> >  	(ERROR) Found an unknown object type.
> >  
> > +`unofficialFormattedRef`::
> > +	(INFO) The content of a loose ref file is not in the official
> > +	format such as not having a LF at the end or having trailing
> > +	garbage. As valid implementations of Git never created such a
> > +	loose ref file, it may become an error in the future. Report
> > +	to the git@vger.kernel.org mailing list if you see this error,
> > +	as we need to know what tools created such a file.
> > +
> 
> I find "unofficial" to be a tad weird. Do we rather want to say
> something like "badRefTrailingGarbage"?
> 

Well, I will answer this question just in below question together.

> > @@ -3541,6 +3546,21 @@ static int files_fsck_refs_content(struct ref_store *ref_store,
> >  		goto cleanup;
> >  	}
> >  
> > +	if (!(type & REF_ISSYMREF)) {
> > +		if (!*trailing) {
> > +			ret = fsck_report_ref(o, &report,
> > +					      FSCK_MSG_UNOFFICIAL_FORMATTED_REF,
> > +					      "misses LF at the end");
> > +			goto cleanup;
> > +		}
> > +		if (*trailing != '\n' || *(trailing + 1)) {
> > +			ret = fsck_report_ref(o, &report,
> > +					      FSCK_MSG_UNOFFICIAL_FORMATTED_REF,
> > +					      "has trailing garbage: '%s'", trailing);
> > +			goto cleanup;
> > +		}
> > +	}
> > +
> 
> I think we should discern these two error cases and provide different
> message IDs.
> 

Actually, in the previous versions, I have mapped one message id to one
error case. But, in the v4, Junio asked a question

  Not limited to this patch, but isn't fsck_report_ref() misdesigned,
  or is it just they are used poorly in these patches?  In these two
  callsites, the message string parameter does not give any more
  information than what the FSCK_MSG_* enum gives.

  That is what I meant by "misdesigned"---if one message enum always
  corresponds to one human-readable message, there is not much point
  in forcing callers to supply both, is there?

In my opinion, we should have only one case here for trailing garbage
and not end with a newline. When writing the code, I chose the name
"unofficialFormattedRef" for the following reason:

  1. If we use two message ids here, for every message id, we need write
  to info the user "please report this to git mailing list".

  2. If we decide to make this as an error. We could just classify them
  into "badRefContent" message category.

  3. The semantic is correct here, they are truly curious formatted
  refs, and eventually we will give the info to the user what is
  curious.

So, I think we should not always map one message to one error case.

> Patrick

Thanks,
Jialuo
