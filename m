Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37AFF272E7A
	for <git@vger.kernel.org>; Wed, 14 May 2025 12:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747227101; cv=none; b=YrWijCibYKl3LXa7oq0tr9jk6MWcEyxuPJYxs3itXWsEh4DqaGhuTE275lDASp107UKiFMtijDNbbwfog4RZZ24mjEtznlImoJJ4UmGll6cjxgPzw8MBdh9fJ4BSQDyIczQjlca9NaVD47Ei6+3KbcqTNzRCIKZ0NcaiwB+4LmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747227101; c=relaxed/simple;
	bh=fOnOhuMn9S+LCFvhVbYUAxFhNWfhtj1HkEIHyI4DkRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pqLrNeDRcLDnuNUJrsJfCxs8BEUQu9Y2x0D4aqXXuj8AQcYAO5kqQzttB5ue96E0i9+ND5Z/NZapBO2qMKV60Xz051+u7N9He3xY1K1Yq8CAcTHrclQt9sZPL2MflfGp15W0cEWNc1nV2za9xr2EkEpHp/FgQfUTfSCXe3IzuKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f6oavvZ2; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f6oavvZ2"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6f0ad74483fso75367986d6.1
        for <git@vger.kernel.org>; Wed, 14 May 2025 05:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747227099; x=1747831899; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=flGYQm0vXn0MfgRUsKaBWaBDGmn2t3WtMrjOqySHjs8=;
        b=f6oavvZ2AwtpovD46E0R/PR462XOrde6/Iy3TINrlkVGeILi1b+8TF7W7F52IjNMm1
         f7O7jM7FxIQggGn1EaFWOFIFlI8H3Svjbk5wu4s0wJXIVSxY9Wo+YlORe9mUqGvJpfZD
         jMfL9ft46dYFBnUa1+oAx1NGZ5Wlmfw1TNRoWF+7+QTueA6MAUUqOFCDbURO3KpxXv6R
         NdaAqB5vwBP5g5/el4P9Glp2C/iM6x3pzbiHRZj3lHv2d+PNizUbib3yDBXKjp7weajw
         ooww3pkMISt2idFtAkQcLISVgwGlCmMmXAaNvjNoWD5TZZ7ZTTkFrr4Rvp/EL4xZ6CxZ
         ekvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747227099; x=1747831899;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=flGYQm0vXn0MfgRUsKaBWaBDGmn2t3WtMrjOqySHjs8=;
        b=tKq0UhC24+AfOkhnUUeMt6N8L45Clufl+Ad4OSn9oSzo7UWVUh5AuunpbmVvQfsDw/
         4OQk0J/8zlPQ0/eMTUBLQBXVVf4EMydM0alf4Ln4ft8TPp3VoGXH1Pb39S9XksBKAL+m
         pTQh3ZP627Y/tCg0Us6TLPVoyOklE+EYKfNey/yMe9OwuZqSzaQe8cyQsp+TROC9tu4l
         VumTTndROIJsDiaQC8tQjOthvF5CfA3SAbvNUl0f98fTLCXL0YQvt+5e9xwDhKKYgkqo
         ns3a6NMULlq27ABOIx4GafSmHLo9Yzs5PT+mlcuQC1Te/1XHsfxcuPoQ6+ITty946zjt
         zibA==
X-Gm-Message-State: AOJu0YxP0w3ApKH/4LtmoCNxzn/hRfcSTaMxY7Z5wINozLWdTxwOtV/C
	3CFK1p73ww3hOFkNu08QGeTR7v5noe8E4hzBhJ5Ivvgaxaip+Wa5mUYohQ==
X-Gm-Gg: ASbGncuvmva+Q9ltyHGGYsAJxvKyrATHrEyw3vn0XuJo/0cMLjMw5yZ8Jlv8qH33wKQ
	B3Q1sXsFGKKF7TN0wD2HcpE2KIYIc8sqtxRb1W4+kqjxa2mmxM/lvO28xfOoVQMhJ3Z8L38MWU5
	XB//uFzbmN0Y5UdcYOMktdpKagMQ2N0fnN9oeO3BAkxoFq3jpGvMuhbFuONx/VmrjoUM5/Pk9z2
	kGwfX3c93ZAu/1V16Tx3kPAFQGpu9ONux1sNw7aFGa+bKozKAI75+sACToWSBw2wcvnzjOrSAsw
	nXoZDYXHQ+CpCGkNGwlCMPvxf6+ffGm1zDMGtptDTfXOJJLBnbyS/HhZFQ==
X-Google-Smtp-Source: AGHT+IH7RaxQPe2HT3r6ZMZFFts9GgZKLvNXPC4y3zCylURATLBNAQcZnYCtz8d9l47e98G5FOPgTw==
X-Received: by 2002:a17:903:41c5:b0:21f:1bd:efd4 with SMTP id d9443c01a7336-231980d04a3mr49456165ad.19.1747227087883;
        Wed, 14 May 2025 05:51:27 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22fc75469d3sm98273595ad.41.2025.05.14.05.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 05:51:27 -0700 (PDT)
Date: Wed, 14 May 2025 20:51:59 +0800
From: shejialuo <shejialuo@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4 1/3] packed-backend: fsck should warn when
 "packed-refs" file is empty
Message-ID: <aCSR7wju99Eszv8d@ArchLinux>
References: <aCMnrwkoJ2WyqGZT@ArchLinux>
 <aCMn_Ktrg4GY8jHe@ArchLinux>
 <xmqqplgch3r2.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqplgch3r2.fsf@gitster.g>

On Tue, May 13, 2025 at 09:30:57AM -0700, Junio C Hamano wrote:
> shejialuo <shejialuo@gmail.com> writes:
> 
> > During fsck, an empty "packed-refs" gives an error; this is unwarranted.
> > The runtime code paths would accept an empty "packed-refs" file, such as
> > "create_snapshot" would simply return the "snapshot" without checking
> > the content of "packed-refs".
> 
> Perhaps "unwarranted" is now too strong a word; we still want to
> consider it an anomaly (that is why emptyPackedRefsFile warning is
> introduced after all). I think the problem description you want to
> here in the above pragraph is that fsck giving an error and runtime
> completely silent is inconsistent.  
> 
>     Side note: and you'd probably want to say what "an error"
>     reported here is.  The problem, if I understand correctly, is
>     that the code assumes the file won't be empty and instead has at
>     least one line in it (even when there are no refs packed, there
>     is the file header line) and insists that all lines must be well
>     terminated---if we tolerate an empty file, of course such a
>     check will fail, as there is no terminating LF in a file with 0
>     lines in it.
> 

Good idea, I will improve the commit message.

> And because versions of Git that are not too ancient never wrote an
> empty packed-refs file, and often having an empty file there is/was
> a sign of a filesystem-level issue, the way we want resolve this
> inconsistency is not make everybody totally silent but notice and
> report the anomaly.
> 

That's right. I should talk about this problem.

> > But we need to consider the fsck message type carefully, it is not
> > appropriate that we use "FSCK_ERROR". This is because we would
> > definitely break the compatibility. Let's create a "FSCK_INFO" message
> > id EMPTY_PACKED_REFS_FILE" to indicate that "packed-refs" is empty.
> 
> OK.
> 
> > Signed-off-by: shejialuo <shejialuo@gmail.com>
> > ---
> >  Documentation/fsck-msgids.adoc |  6 ++++++
> >  fsck.h                         |  1 +
> >  refs/packed-backend.c          |  9 +++++++++
> >  t/t0602-reffiles-fsck.sh       | 17 +++++++++++++++++
> >  4 files changed, 33 insertions(+)
> >
> > diff --git a/Documentation/fsck-msgids.adoc b/Documentation/fsck-msgids.adoc
> > index 9601fff228..0ba4f9a27e 100644
> > --- a/Documentation/fsck-msgids.adoc
> > +++ b/Documentation/fsck-msgids.adoc
> > @@ -59,6 +59,12 @@
> >  `emptyName`::
> >  	(WARN) A path contains an empty name.
> >  
> > +`emptyPackedRefsFile`::
> > +	(INFO) "packed-refs" file is empty. Report to the
> > +	git@vger.kernel.org mailing list if you see this error. As only
> > +	very early versions of Git would create such an empty
> > +	"packed_refs" file, we might tighten this rule in the future.
> 
> I am not too happy to see "Report to ..." and everything after that
> here, primarily because it takes one extra step for the user to find
> it out when they see such an informational message.  There are other
> existing error classes, like refMissingNewline, etc., that have the
> same problem.  One thing to make it easier for the users to report
> is to put it in the error/info messages themselves, but I think it
> is OK to make such a clean-up (including the existing offenders)
> after the dust settles from this topic.
> 

That's right. Actually we introduce redirection here. I think I will
improve this in the next release cycle. I'll add this into my TODO list.
