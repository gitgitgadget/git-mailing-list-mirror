Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF8E1D4161
	for <git@vger.kernel.org>; Fri, 18 Oct 2024 14:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729261273; cv=none; b=J72IHYXBUpHWqkMXF9/pSpTS6xhOc29/nj+tRzo08h9Lpw1Fk4YS5nbJCBujp54lmJRFaYuI9sXnIZJGFnh0CAqEudi1m4WsVhBEIxAuet2vW4J24BoShS/nHl7ywQPtmEWiTJmuZirFuh1Mfkib4dqY7FHH1K/ungge91xDGM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729261273; c=relaxed/simple;
	bh=lTtPPd7FCUYomd0PADIHFkmP5cLpLt0qkJWtze/nv30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UZuZiMk4+zVL1VP7vbtfatSLlKP85DVnGLTBCdbRTJgpMEYfw5xJCI/C65EUYnhS8nwZAJHvkoxYIbU9tzkmLG8fhbbqzxcaNTDezI0aqLOr3sn0V0jrDvQ5jBAh7U/EswqjGoCPI2IuTxXlBdf4cMWEaCKFmBfphJRnZdFvedU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DwvnJEVE; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DwvnJEVE"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20c7edf2872so25552375ad.1
        for <git@vger.kernel.org>; Fri, 18 Oct 2024 07:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729261271; x=1729866071; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QbQSr7d1gLzWgFk5wYrlP5ZQ7VlyH796JOR6NQ00BTE=;
        b=DwvnJEVERg7c8/mGSQIHw5U/v73YPvUW/ZV6c6+C12DqXHo6/93WoDAoQ0gv7xqUA4
         9VCxCTrTnHeha/ISljW4xCjo7GPKtidtONBImb7laOIY8KFBvOZeXyfUj4hDSjwisXZo
         EGZkKDkg3a0kXibcZ+a5EdNhBju5lCYwmvC74MJ33sOAUiz3iyTckhSqQmlNFfHN3H+J
         SQd/QMadQSaGbpKHORWoSzJXyK/7TkXnuL4kqefocGtbm4dLZd4x0K9guQLaf2KuEvol
         0wbW9wMqkEncYZw9tBTyrRKx1H88kAHiJdLXoaLL/9JjSHdbNOwD1VP2+aWC+BoVYosD
         3cfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729261271; x=1729866071;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QbQSr7d1gLzWgFk5wYrlP5ZQ7VlyH796JOR6NQ00BTE=;
        b=pV0HvZ6b/7idLBykhgYcb2eyDxuL0C2BXh4WLlUbaStw5EgvsZJFXdPrQetcHLndWJ
         f7Q7KAFbSVGQqUz/isr2iMjn2hD+njmGAdVU6IPkcJmaSWW2vz+ErneLutOJXhgS6NCA
         GRT08uMaHAPoHpaDe87uGCC2KcB9g049bfvPBUEGudjWIP7UxfXh6CwKepwVq/puJhBc
         vm2Ssu1iwsW1sDyxg35zsC0uau8S3l20fVVvAkdeCeZWD3waGwzqe6VoJJsxNqGSsheW
         ehRiN2DHcvhB83UBcPzb8gDv7T1ipb5ECcXzwp9YLMvVpsGeDHfHKIE9ifbxrMUHTYpo
         /B6A==
X-Gm-Message-State: AOJu0YwrhyuIwEFlsUTAZXiQtMq5lugsSGzfR+XhCi400cgucAV7hkaR
	VgKZCcC81qJuAi//YMzIPNsfOaM2kTdxhOpV4drxsrLADv/uGNay
X-Google-Smtp-Source: AGHT+IELSfEnu2ERr5wb/roEYtboZRBK6P/1VOHF63wDpZOy9w9yXEazSnxBDWIGZ98pg9diVCgAGA==
X-Received: by 2002:a17:902:daca:b0:205:8763:6c2d with SMTP id d9443c01a7336-20e5c10c9a5mr39178205ad.9.1729261271177;
        Fri, 18 Oct 2024 07:21:11 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e5a925fd0sm12943125ad.300.2024.10.18.07.21.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 07:21:10 -0700 (PDT)
Date: Fri, 18 Oct 2024 22:21:11 +0800
From: shejialuo <shejialuo@gmail.com>
To: Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] object-name: don't allow @ as a branch name
Message-ID: <ZxJu13wpSiJ_kDdB@ArchLinux>
References: <cover.1728331771.git.code@khaugsbakk.name>
 <ZwUxdz_HobRGF9yq@ArchLinux>
 <3af78a3c-afb9-4ce7-aea0-a5bbddd4f34a@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3af78a3c-afb9-4ce7-aea0-a5bbddd4f34a@app.fastmail.com>

On Tue, Oct 08, 2024 at 04:19:10PM +0200, Kristoffer Haugsbakk wrote:
> On Tue, Oct 8, 2024, at 15:19, shejialuo wrote:
> > On Mon, Oct 07, 2024 at 10:15:16PM +0200, Kristoffer Haugsbakk wrote:
> >
> > [snip]
> >
> >>   §2 Disallow `HEAD` as a branch name
> >> 
> >> This was done later in 2017:
> >> 
> >> https://lore.kernel.org/git/20171114114259.8937-1-kaartic.sivaraam@gmail.com/
> >> 
> >>   §2 `refs/heads/@` is apparently disallowed by git-refs(1)
> >> 
> >> See `t/t1508-at-combinations.sh`:
> >> 
> >> ```
> >> error: refs/heads/@: badRefName: invalid refname format
> >> ```
> >> 
> >
> > It's true that using "git refs verify" will report "refs/heads/@" is a
> > bad refname.
> >
> > From the man page of the "git-check-ref-format(1)", it is clear that
> >
> >     9. They cannot be the single character @.
> >
> > Because I am interesting in this patch which is highly relevant with my
> > recent work, so I try somethings here and find some interesting results
> > as below shows.
> >
> >     $ git check-ref-format refs/heads/@
> >     $ echo $? # will be 0
> >     # git check-ref-format --allow-onelevel @
> >     # echo $? # will be 1
> >
> > The reason why "git refs verify" will report this error is that in the
> > code implementation, I have to iterate every file in the filesystem. So
> > it's convenient for me to do the following:
> >
> >     if (check_refname_format(iter->basename, REFNAME_ALLOW_ONELEVEL)) {
> >         ret = fsck_report(...);
> >     }
> >
> > Because I specify "REFNAME_ALLOW_ONELEVEL" here, so it will follow the
> > "git check-ref-format --allow-onelevel" command thus reporting an error
> > to the user.
> >
> > I am curious why "git check-ref-format refs/heads/@" will succeed, so I
> > try to use "git symbolic-ref" and "git update-ref" to verify to test the
> > behavior.
> >
> >     $ git symbolic-ref refs/heads/@ refs/heads/master
> >     error: cannot lock ref 'refs/heads/@': unable to resolve reference 
> > 'refs/heads/@': reference broken
> >     $ git update-ref refs/heads/@ refs/heads/master
> >     fatal: update_ref failed for ref 'refs/heads/@': cannot lock ref 
> > 'refs/heads/@': unable to resolve reference 'refs/heads/@': reference 
> > broken
> >
> > So, we are not consistent here. I guess the reason why "git
> > check-ref-format refs/heads/@" will succeed is that we allow user create
> > this kind of branch.
> >
> > If we decide to not allow user to create such refs. We should also
> > change the behavior of the "check_refname_format" function. (I am not
> > familiar with the internal implementation, this is my guess)
> >
> > Thanks,
> > Jialuo
> 
> Thanks for the careful analysis.

Please ignore the above analysis which is not true. (Today I am writing
code for my work). Currently, we truly allow "refs/heads/@" as the refname.
And also for "git check-ref-format", "git update-ref" and "git symbolic-ref"

When I did the experiments above, I forgot to clear the state which
makes the "git update-ref" and "git symbolic-ref" fail. So, there are
some faults in "git refs verify". I will fix in my current work.

So, if we decide to not allow "refs/heads/@", we should also update "git
check-ref-format", "git update-ref" and "git symbolic-ref" to align with
this behavior.

Thanks,
Jialuo
