Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5459225417
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 23:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774999086; cv=none; b=M4U9KvIlSN9Vp53iY3BsGYJUzsgO7NLqDq/3zou/qRFJGBUHYE7G5xwW/2EmiShzXZU1TIdh0xI3sincCCRW01y1I7Z5h7SyJkD3lXIvrnwkxDBovm69i9xziJIwX+Lz+p6efz8vxF6cnT70JCifPHI6d7OL8wzehhr2p4q1IYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774999086; c=relaxed/simple;
	bh=weVYSHhTW/LBIyMqqxKEhVqUDdfTUwtMyqLTXI6kuCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WHxpApnfJe2nifMNFeyIeKXpuB89x3SJQoJ1Br78qKl8ZpcezNMcsrHiqLH+YyRt8eI16EOE+voSZaOEVWD/UjI/L1ejhY3rJgGZcxgyR46a/H1Gh2B/410J5lSUxjmXHKZ0dmktLr5GXjAxYyhpIRY3fPVoUz6f3+O2IJsn0nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aaoCzHDQ; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aaoCzHDQ"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-463f00cda04so3572644b6e.2
        for <git@vger.kernel.org>; Tue, 31 Mar 2026 16:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774999084; x=1775603884; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=79hz3YAAY2x193rhbeu54o2gesJ5vc7WxpPTih85nWE=;
        b=aaoCzHDQJf7IRrq43PqVpS4UxvGI8G+1BOKMx9pk7gdbYU4h6uuPJNfgyRy1fOvHQU
         fVwEqZQCqMah0MWkghR9A5fN1JU37DJMRRXe5WlZ2S3x7PfwllesUhYiC8NcsrxhLHig
         f7xz+3ak9VE7Mu8chL0QDivqeNrfy1lli6EbxJ4EBrQzo2gg1ePzLuPEiLEJoufIov0q
         yFG2OSBBD5KxQCqGHjKC3/P0iE0Hv6O6L10tXp7anvanqZA441MFvrKAPs+1klFz0P9b
         7ZKvwgozbUXjkT1Hu/gBQVdEjWEJqzbKXvoATkCn5upncTP4z7O20qP5L9qiMZS/nCtv
         vngw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774999084; x=1775603884;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=79hz3YAAY2x193rhbeu54o2gesJ5vc7WxpPTih85nWE=;
        b=gsLCRax8rTqvQvGZm/qg4tTkh3dH1/iev/SoEGPmkK1nJPZxoy0qkwWJlW8UWSFaBB
         4d38MlVC1yNJK6DMySb4UnbGwAWR4KkAQ239OXiX5Gv4LsTQDZy3lLX3RfzAAqpKYuW3
         AEKynRtNdzu5Aty5ExJTTNAe8lXQ7iEUvqcvNT7lO34XmLurqShhverumXP5WuSnVSDC
         tSuXOL/VuHM4usiUkHfa0IPDb6BmkJGTRKHliQxkeU5VAqze2nNoghGhbwWT7R3hZbM/
         1otu0fVri/SlyJfOIey0hT4s2EcBAZhXq9JkMxafy/ypJnrJyrqix7UJ1ziNjnYtyYgb
         cWFQ==
X-Gm-Message-State: AOJu0YzPBMvEPCXK99bqphqX/0agXGSN2QR889lAZ6JY0WxZlEwdX9hp
	UJQfXMsXks2isLxPrD+M+5fNJDXXs5MDK6BNrEfWJJmVXpxA37gD4O93
X-Gm-Gg: ATEYQzwskUi5obF2xQOsWKJrkUVtW4jiM0vNCa3XecbFmNN7iSFsrlkN1+S6m5hLPib
	2xjaYB3Q9kKj+n6qKu9cBWFR4+oBf16GPoqf1nv3ZWXv2YONREajXCfOx2ARsYlgesUxA3L5hA2
	Yn7EVDEZyu3LzFn77Bm2443GygDMLiZuA+lYNedZ8007WdfBEutiq23K03gzkQfXWwLyBU7NlUF
	PgKds3ianBpdJepZ73lCfgonkTUood5uZdCn7HI0sz//Mhh2G7oFsNSrYCir67dPmeN2XB28/XB
	g2CUrCFh3x2EpmICLkUEmz+rphHkHAEgTrIxAFguc3rIUJQEydWJc/dwu38hoO9MnIkWUnLaVWB
	nGh0v/TlIFOPWwQXf7pMsfuH5fG46kRmnjIDfdWF1vCPbNeMes4HMZP7olrDtH6gnsubfDfdF8v
	lK2oOwqkkIVnogsz7Y
X-Received: by 2002:a05:6808:4f68:b0:463:cf6b:982a with SMTP id 5614622812f47-46ae0044ca5mr706709b6e.22.1774999083545;
        Tue, 31 Mar 2026 16:18:03 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-46a9fef82absm7568400b6e.8.2026.03.31.16.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 16:18:02 -0700 (PDT)
Date: Tue, 31 Mar 2026 18:18:02 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com
Subject: Re: [PATCH v2 0/5] fast-import: extend signed object handling modes
Message-ID: <acxVmFy9gYITrgcl@denethor>
References: <20260326191414.3783974-1-jltobler@gmail.com>
 <xmqqtstvwsxe.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqtstvwsxe.fsf@gitster.g>

On 26/03/31 03:11PM, Junio C Hamano wrote:
> Justin Tobler <jltobler@gmail.com> writes:
> 
> > Changes since V1:
> > - Added a prepatory patch which unifies how unsupported signing modes
> >   are handled for git-fast-export(1). Now they are treated like any
> >   other unknown signing mode. Unsupported signing modes for
> >   '--signed-tags' in git-fast-import(1) are left alone because this
> >   series progressively adds support for all these currently unsupported
> >   modes.
> 
> Even though you have this inter-iteration change log (which is very
> good), as the cover letter is not sent as a reply to the cover
> letter of the previous iteration, the mailing list archive
> 
>   https://lore.kernel.org/git/20260326191414.3783974-1-jltobler@gmail.com/
> 
> does not help us navigate to the previous iteration
> 
>   https://lore.kernel.org/git/20260324215513.764739-1-jltobler@gmail.com/
> 
> very easily (I found the above URL by cheating---I looked at notes/amlog
> for a commit from previous iteration jt/fast-import-signed-modes@{1}---but
> that is not for everybody).

Apologies, I should have payed more attention when sending. Thanks for
linking the previous iteration.

> Looks like I was the only one who was interested enough to comment
> on the patches over these two iterations, which is a bit sad, but I
> think the patches are fairly cleanly done and are ready for 'next'.
> 
> Let me mark the topic as such in the "What's cooking" report.

Thanks,
-Justin
