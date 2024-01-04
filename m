Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AED2286B2
	for <git@vger.kernel.org>; Thu,  4 Jan 2024 17:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="SH17c5cl"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4281f6400feso12507191cf.1
        for <git@vger.kernel.org>; Thu, 04 Jan 2024 09:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1704389681; x=1704994481; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ujXauwv8NyLCYft/2ezqwZOzEzL9kmeiSsZxUSVECBA=;
        b=SH17c5claS6JlVN9pdLTnbX2dLVyc4ZtNFXFRP3h4CtBvWDlAjyNIX7gVzpnvksNWH
         Ehq1SUvf/kLLnMeA2qzCp5sLWYDcN1M4xn3Fc2wBdNLI5wB9tnED/JF0JF/A5ow2ifuk
         l9MLg7+PsbjHaYc8/UMmdC/H/lxO0rKWU8UebiRCuZRh3T9h62SGinvegDI0Ywx5qI4h
         6Bwy5h3J8HGVMGxlEtQdfnBdkeaPt5b6JMvPiww8v77NnTGlxF545OPFtM8EevBu0Xew
         YhMUvuvwoosS6WX8P9mUR2XZlpiSWX45drnl207+uy1q+p9GbfJt58CKBtfudk1hzwVd
         vOdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704389681; x=1704994481;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ujXauwv8NyLCYft/2ezqwZOzEzL9kmeiSsZxUSVECBA=;
        b=MXoTgcaHx/Apy0j+IABjJylhpc/lOXmTEe3hmfZPwTbTPPA0YD3HrJZU04u8taRUj9
         fr8pFuWcF80FIv8uSJrojXR/Gmr1I+pBSS7HmkChBNqte8ty/TIuOSKJOKn4Fn3FVqcT
         rB5bJ+mN3tjNW/ZHcO+ojfZ8FNb8TWvtcxqncOhPo0z47rDMSznAFXPFZiX6fjSEKs1p
         7snUytktgJTvD2nrEjF3Z/4jWxbUoBuUYSFD92Msmx20DkgkMznuSxL84bJdHAqkIM1f
         xac0b6UrzrMExl1dKn+1dmAIxaEvy6gR8HcrX16AEA2tcWdyrLDjAhr7CQH6dW5LnzOI
         fXJA==
X-Gm-Message-State: AOJu0YyMnh3bcoIuQSW6bsjCy7hEkj81+TRb8Rxcoj9wSDmgWWMyeHac
	8qXv0ctDGuDKgPwKuIzhJTOc8XPsbfWx1Q==
X-Google-Smtp-Source: AGHT+IHDD2pkknuzE0V290AuCUUZ0cVSQcKAQbC1+sfqh8ITF6d5ddmRwl8cb2kVbo7WEYXUZUjl4w==
X-Received: by 2002:a05:6214:528a:b0:67f:6ddb:58c4 with SMTP id kj10-20020a056214528a00b0067f6ddb58c4mr1163132qvb.45.1704389681060;
        Thu, 04 Jan 2024 09:34:41 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id kk9-20020a05622a2c0900b0042839736d9fsm1812908qtb.19.2024.01.04.09.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 09:34:40 -0800 (PST)
Date: Thu, 4 Jan 2024 12:34:39 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>,
	Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
	Stefan Haller <lists@haller-berlin.de>, git@vger.kernel.org
Subject: Re: Concurrent fetch commands
Message-ID: <ZZbsL8/2KfSITJv3@nand.local>
References: <c11ca0b3-aaf4-4a8d-80a1-3832954aa7aa@haller-berlin.de>
 <xmqqy1daffk8.fsf@gitster.g>
 <ZZUNxNciNb_xZveY@tanuki>
 <ZZUWmy3rTjpBsH-w@tanuki>
 <ZZU1TCyQdLqoLxPw@ugly>
 <ZZU5s4LKQF1NLgnC@tanuki>
 <ZZWOBObBmLW9Nid6@nand.local>
 <xmqqwmsq83v3.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqwmsq83v3.fsf@gitster.g>

On Wed, Jan 03, 2024 at 02:10:56PM -0800, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > ... I suppose the answer is that they expect
> > concurrent fetches to be tolerated, but that the contents of FETCH_HEAD
> > (and of course the remote references) are consistent at the end of all
> > of the fetches.
>
> What does it mean to be "consistent" in this case, though?  For the
> controlled form of multiple fetches performed by "git fetch --all",
> the answer is probably "as if we fetched sequentially from these
> remotes, one by one, and concatenated what these individual fetch
> invocations left in FETCH_HEAD".  But for an uncontrolled background
> fetch IDE and others perform behind user's back, it is unclear what
> it means, or for that matter, it is dubious if there is a reasonable
> definition for the word.

Yeah, on thinking on it more I tend to agree here.

> Nobody brought up the latter so far on this discussion thread, but
> mucking with the remote-tracking branches behind user's back means
> completely breaking the end-user expectation that --force-with-lease
> would do something useful even when it is not given the commit the
> user expects to see at the remote.  Perhaps those third-party tools
> that want to run "git fetch" in the background can learn from how
> "prefetch" task works to avoid the breakage they are inflicting on
> their users?

Probably so.

Thanks,
Taylor
