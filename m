Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D21918E751
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 11:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728474950; cv=none; b=luoLmYgS0FHVnfk9IIPUQcMmezvkcnFTyjYzcQnzaeaFIxJd2oqkwCPGVxpyCsBBC1xnlnpXHcEPL3srMQpuMEs1MAmVD9+I72Ke68vyTrGmaPg6YG8vgEv/tnJvPfIWV3YL2inHbYgXj6h/2/KHZ5ClX7RfH8a3BE8mN5tIwlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728474950; c=relaxed/simple;
	bh=1tf6aaoxOejpffNv5lD2l6SuH+ees+DE/+yAdDdMVf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bTcrfV9wLbYujDwOTFxmfObjLiVn5fOiuZ59ETaALseWT5mAziGbrzUFt4drmbCxU9Be8orcuIogq+x4TxzqBbm7GbIfmmKYnZgwdX1LoA3tgaDfvnl9+DN08ylDMroPiGfJZzgc4CgGvSY8HazWgetQ1d32zdJhsEk5RlJq5Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GGaUsYTW; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GGaUsYTW"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-71e029efecdso2771868b3a.3
        for <git@vger.kernel.org>; Wed, 09 Oct 2024 04:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728474948; x=1729079748; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4652OVbMzw/UNSdvsLTIx98geuwZJr/nIj1CaD4AsTg=;
        b=GGaUsYTWcOLcHJHu49fQsWVB1d1q02PgA+9oX3HHbI+p+PwKSfasiXI2wBJCZtY/5/
         7Va5NvQUCZDoKSTYjlb4W6zBEEPD2nQZlCbLEi6/Pk/xDQlUJOVjjvAY6RTD0GvhqqdR
         pAbFVkZafPV5EVPO+7BE77jGkdLJUisjkZuOJkYpBqTaMCmioKHaYHEk8RZ8bC2SbbIi
         KhMYZcJQS89V6bcE5gzubYeqMkK57VKdBUYf1P5mfSd4c2+V6ljBpXr84EfFPzRt+7rb
         86FYzjvLrANlL9Cas07SRXb1xMrY71CTZP+3TrVc6ObhNWibDhBdgV0LP5oP93WMJH4S
         jQbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728474948; x=1729079748;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4652OVbMzw/UNSdvsLTIx98geuwZJr/nIj1CaD4AsTg=;
        b=T1yTLkTaZl3yU39mw7tqpO72J6QgfgdM9fROKrGXa2JWx7bUoCz6mdE6ifumxhOHyv
         R5JLXSyvD+ps0j3Hk27gWaYbiIl7DumYM6kEj5NF55LGq8N0JgxgNg+k0oNVHgfUBksD
         CP7C1rDudDI/8Wxa62V92Ndr2tjZQXa1N7UjGnKD193QX8v6YFmNQKBFMMRP7xB8eND0
         1f1UsBc9t6yTbWdKXcvZaWJVC8K7gVijy7zykYF4uZwglnePiqYnB4Rf45/fqQGw+MeD
         j2XP1U570Uf4B7Ql3NonUewUuKlRtEMeAGh2dBzIauQoM94Yvk+zj6MbTTXcYW6ZswBn
         6C1g==
X-Forwarded-Encrypted: i=1; AJvYcCUbMRHYrmakWZcKjKJyS0u+vMXHX+VqaNwM0vvGbGgDM0WLwP76iNKh9orPFD8dB+SK5ZU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbGxrdQuDNQWcG1A9LhF4ttOfDDBhBCdDDiai1VK2yBTsVPOsN
	2OQmMBSN8GXWtSCD3C0an1IIm/S6x3J0YcXCcULsrYaRA5lY8quy
X-Google-Smtp-Source: AGHT+IGvqtl+GXrLbR7/yWuGxco5OIlfaKLDdPQDiAicPXqycf3EMF4xxbpJoueI86s1131w6hlELw==
X-Received: by 2002:a05:6a00:b46:b0:71d:ffef:c15e with SMTP id d2e1a72fcca58-71e1db7539dmr3218969b3a.12.1728474948373;
        Wed, 09 Oct 2024 04:55:48 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0d6af99sm7620036b3a.184.2024.10.09.04.55.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 04:55:47 -0700 (PDT)
Date: Wed, 9 Oct 2024 19:55:56 +0800
From: shejialuo <shejialuo@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v5 3/9] ref: port git-fsck(1) regular refs check for
 files backend
Message-ID: <ZwZvTKG625P_ncl7@ArchLinux>
References: <Zvj-DgHqtC30KjJe@ArchLinux>
 <Zvj-osCNDMrUQv83@ArchLinux>
 <CAOLa=ZQ3Gytt4Lsttxws3DWqbjteJS8mXvZSPzDwBJi_ALS03Q@mail.gmail.com>
 <ZwUkZuCtYu7niuFM@ArchLinux>
 <xmqq5xq232wa.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq5xq232wa.fsf@gitster.g>

On Tue, Oct 08, 2024 at 10:44:53AM -0700, Junio C Hamano wrote:
> shejialuo <shejialuo@gmail.com> writes:
> 
> > On Tue, Oct 08, 2024 at 12:43:20AM -0700, Karthik Nayak wrote:
> >> shejialuo <shejialuo@gmail.com> writes:
> >> 
> >> [snip]
> >> 
> >> > +	if (strbuf_read_file(&ref_content, iter->path.buf, 0) < 0) {
> >> > +		ret = fsck_report_ref(o, &report,
> >> > +				      FSCK_MSG_BAD_REF_CONTENT,
> >> > +				      "cannot read ref file");
> >> > +		goto cleanup;
> >> > +	}
> >> > +
> >> 
> >> Shouldn't we use `die_errno` here instead? I mean, this is not really a
> >> bad ref content issue. If we don't want to die here, it would still
> >> probably be nice to get the actual issue using `strerror` instead and
> >> use that instead of the generic message we have here.
> >> 
> >
> > Well, I think I need to dive into the "open" system call here. Actually,
> > we have two opinions now. Junio thought that we should use
> > "fsck_report_ref" to report. Karthik, Patrick and I thought that we
> > should report using "*errno" because this is a general error.
> 
> What do you mean by "a general error"?  It is true that we failed to
> read a ref file, so even if it is an I/O error, I'd think it is OK
> to report it as an error while reading one particular ref.

Make sense.

> Giving more information is a separate issue.  If fsck_report_ref()
> can be extended to take something like
> 
>     "cannot read ref file '%s': (%s)", iter->path.buf, strerror(errno)
> 
> that would give the user necessary information.

At current, the `fsck_report_ref` can do this. I think I used
`fsck_report_ref` function badly in this case.

> And I agree with half-of what Karthik said, i.e., we do not want to
> die here if this is meant to run as a part of "git fsck".

Yes, we should not die the program. Instead, we need to continuously
check other refs.

> I may have said this before, but quite frankly, the API into the
> fsck_report_ref() function is misdesigned.  If the single constant
> string "cannot read ref file" cnanot give more information than
> FSCK_MSG_BAD_REF_CONTENT, the parameter has no value.
> 
> The fsck.c:report() function, which is the main function to report
> fsck's findings before fsck_report_ref() was introduced, did not
> have such a problem, as it allowed "const char *fmt, ..." at the
> end.  Is it too late to fix the fsck_report_ref()?

I agree that if the FSCK message id could explain the error well, there
is no need for us to provide extra message. But, I want to say the
`fsck_report_ref` is not misdesigned here. It is just the same as the
"fsck.c::report" function which has "const char *fmt, ..." at the end
like the following shows:

    int fsck_report_ref(struct fsck_options *options,
                        struct fsck_ref_report *report,
                        enum fsck_msg_id msg_id,
                        const char *fmt, ...)

And I do think "fsck.c::report" function also has the above problems.
Let me give you some examples here in "fsck.c":

    report(options, tree_oid, OBJ_TREE,
           FSCK_MSG_BAD_FILEMODE,
           "contains bad file modes");

    report(options, tree_oid, OBJ_TREE,
           FSCK_MSG_DUPLICATE_ENTRIES,
           "contains duplicate file entries");

    ...

So, I want to say there is no difference between "fsck_ref_report" and
"fsck.c::report". When I refactored the code in GSoC journey, the main
problem is that we should reuse the original "fsck.c::report" code
instead of writing redundant codes.

The final result is I extract a new function "fsck_vreport" here (I
leverage the original "fsck.c::report" function) which will be called by
"fsck_ref_report" and "fsck.c::report".

    static int fsck_vreport(struct fsck_options *options,
                            void *fsck_report,
                            enum fsck_msg_id msg_id,
                            const char *fmt, va_list ap)

From my perspective, if we decide to refactor, we should allow the user
call the followings:

    fsck_ref_report(..., FSCK_MSG_BAD_REF_CONTENT, NULL);
    report(..., FSCK_MSG_DUPLICATE_ENTRIES, NULL);

So, we should check whether `fmt` is NULL in the `fsck_vreport`
function to make sure that if FSCK message is good enough to explain
what happens, we should not pass any message.

> Thanks.

Thanks,
Jialuo
