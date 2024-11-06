Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27E418D649
	for <git@vger.kernel.org>; Wed,  6 Nov 2024 02:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730860840; cv=none; b=RSodLQue33IXULO1vWgS+O03e8rSWClAflFnpVEKVaqFGThjvM5KerYvB8A5Eiga2EKKCkJX6+uxMDR5PhqJ+VN8cCVUtBpcd3vGvL99rH7HmAaM/aVBK33ACKAl6n3aD7PObklWjB5JRrmxIexuH7KFLYiHhM6LXBKhGnAqOiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730860840; c=relaxed/simple;
	bh=eTVh7y3DB+flylbUeM9mtDwQvBGCagxdXxsWffSss0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UsCTfzTy7x+27I+v0npXGVeBN57rIjVB3vl1tocS1nYBVW493PmkQDISiOgsh/VZps1l79FCJgPMpbGUFRO4Zuky+11p9YtdXOkCzxDnJnJ+OVoqDPAPjkSQhNa+K6mSg5KyLyEljskpEhPeVJiA+rBbbC/5uSSYQl8Uny3Zlng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FaX/+QVQ; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FaX/+QVQ"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20cdda5cfb6so60724575ad.3
        for <git@vger.kernel.org>; Tue, 05 Nov 2024 18:40:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730860837; x=1731465637; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+UedZEkPBsKTLUuEn4WLM7Pl13ew6GOFwlZkuBJGWgM=;
        b=FaX/+QVQ3zowYkwVAWDqVI1tsHLS3aqhETjJtA3SMRu4KsFFZ4LUQHwpCucSv4wNqt
         FCaa0tT0VRkDzo6KfGyom87Yjxja00OoB23S4yQBaH/3O3TXkMPpZsec2Qe5M+RjxRMT
         Mp956uxu/Ftaas7OXSZO6weFT2CoaRxrSVGmUspDC0NO5qb+wjq16V1/jrf+4E1N4Jnb
         HMKx9B5QtQzCr41WAJ23HS9UlDLsolQsI0s/K9Vt1I0BCZ1K56nN+qhHHdGRfEG79bXC
         p6Hai1OH8ZGQkCejOsdDkRrKNaqD3wFB5yThnI9o9Oh2alQMgq+f8E6UlVm7cvf1PlzH
         ZARQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730860837; x=1731465637;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+UedZEkPBsKTLUuEn4WLM7Pl13ew6GOFwlZkuBJGWgM=;
        b=V4RROKzuuLqAUUG6eRKBex0nw/+rX4L2+UbmPwdMhpXF2v30kvy5gv7QbNrxnto7n0
         YvOX7mgZimJMofhlWlScLwYAzngAQFV6sM9RuifAOrUaza8LBhl3g9GPxit1BMrG5dce
         ifqgdLB4OlKT9UZZe7Q/022MDnKvOW7+FTePBmuKadfvlCO2fgqeHKWLWEwps6p69Aks
         or5wBTh+Ac3ngVrP7PWfhxtIG6BwkOyxEeTUBk1OenCafyHTwAOZB/YXb8yRqa/VD9ZM
         e0jEc+vhb4locVHUIZ4xIaqFCKKfxjH/3xkZJ7TvKkpreSoPT6fBrRfC8J9ysWRLWq+v
         wOTw==
X-Gm-Message-State: AOJu0YyxZ7cgM0/+whdXhNTpSaEhUsgg5hRpYI48TDeqB0ynPIDJ08w7
	pNZ9Vy3jwNrCY6oy74dyVxRA5q11VZQQUoR3MXbLX/EU9MVAPdW2
X-Google-Smtp-Source: AGHT+IFAAe2x8V28jYEITWBBp0iQpcOB6r8fECIGYBFoP1UFD3TIiSS2qtvtVe0UuPDWyaActTUopw==
X-Received: by 2002:a17:903:1ca:b0:211:ebd:e370 with SMTP id d9443c01a7336-2110ebde811mr295304135ad.25.1730860836734;
        Tue, 05 Nov 2024 18:40:36 -0800 (PST)
Received: from five231003 ([2405:201:c006:3236:43c1:69a9:7a27:f52e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e99a5a436fsm326392a91.37.2024.11.05.18.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 18:40:36 -0800 (PST)
Date: Wed, 6 Nov 2024 08:10:32 +0530
From: Kousik Sanagavarapu <five231003@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH] t6300: values containing ')' are broken in ref formats
Message-ID: <ZyrXIKU8Qn46Z0LF@five231003>
References: <20241105190235.13502-1-five231003@gmail.com>
 <xmqqikt1qhwt.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqikt1qhwt.fsf@gitster.g>

On Tue, Nov 05, 2024 at 05:18:10PM -0800, Junio C Hamano wrote:
> Kousik Sanagavarapu <five231003@gmail.com> writes:
> 
> > Document that values containing ')' in formats are not parsed correctly
> > in ref-filter.
> 
> The problem is probably lack of a way to quote such a closing
> parenthesis.

Yes correct.  We currently don't have a way to quote such strings in
"value" of "%(atom:someparam=value)"

> > However formats having a '(' instead in "value" will parse correctly
> > because in a general format string we also mark start of the format by
> > making note of '%(' instead of just '('.
> 
> So if you wanted to have a two-char sequence '%(' in value, you'd
> see a similar problem?  If so, it is not quite a "bug" or "not
> parsed correctly"---it is "because there is no way to include
> closing ')' in the value (e.g., by quoting), you cannot write such a
> string in the value part".
> 
> > This raises the question of what can be done to parse ')' in values of
> > the format correctly.  It seems to me like a clean solution would
> > involve a huge refactoring involving a large portion of ref-filter but I
> > maybe wrong.
> 
> Yes, so I wouldn't even call the current behaviour "bug".  The
> language is merely "limited" and the user cannot express certain
> values with it at all.
> 
> 
> Having said that, I just tried this
> 
>     $ git for-each-ref --format='%28%(refname)%29' refs/heads/master
>     (refs/heads/master)
> 
> So, if there is anything that needs "fixing", wouldn't it be
> documentation?
> 
> If I knew (or easily find out from "git for-each-ref --help") that
> hex escapes %XX can be used, I wouldn't have written any of what I
> said before "Having said that" in this response.

Hmm, but hex escapes do work as intended and the problem here is not the
')' outside the atom but within it.  To be more clear, let's take

	$ git for-each-ref --format="%(if:equals=refs/heads/step-1)start)%(refname)%(then)%(objectname:short)%(end)" refs/heads/

(Sorry for not wrapping the line above x<)

First let's notice the difference between what these two commands are
trying to do.  Your command asks to print all the refs matching
"refs/heads/master" in the format of (%(refname)) and since we support
escaping literals in the form of %xx, where xx is the hexcode of the
literal to be escaped during the parsing of the format, this would
obviously work as intended.

Now let's come to my command.  My command asks to print all the
abbreviated commit ids of the refs which compare equal to
"refs/heads/step-1)start" from all of "refs/heads/".  Now here, since
ref-filter parses the format string by making note of '%(' and ')', it
accidentally thinks that I want to compare equality with
"refs/heads/step-1" instead of "refs/heads/step-1)start", which I
actually wanted.  If my local repo contained both the "refs/heads/step1"
and "refs/heads/step1)start", wouldn't this be a bug?

So I do agree that it is a lack of quoting when entering the "value"
part of "%(atom:someparam=value)", but another part of me also thinks
that ref-filter should be intelligent enough while parsing the format
string to acknowledge where exactly the atom ends and which is the last
closing ')' and hence follows whatever I wrote below the "---" line,
till the script.

Also, I'm thinking the commit msg was not clear as it lead you (perhaps
someone else too when they visit this topic) to think about escape
literals while that not exactly is the problem I'm trying to get at.

Also if you think a change to the documentation would be more proper
than reflecting this with a test breakage, I'll do that.  My intention
with the test was that - in the future if we parse the "value" correctly
then that commit would also include a

s/test_expect_failure/test_expect_success

change.

Thanks!
