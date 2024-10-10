Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D2A194082
	for <git@vger.kernel.org>; Thu, 10 Oct 2024 17:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728581193; cv=none; b=k7drY1ophFnLHhpC4jgckh1HGpNr6p1LbEbiunumb60CleF69RftS3UaNS6AB35tfrl2yxSfL7wGOwAct/evFYCOd7X5Kkgr4S/XUVXWWloSI6CWlLnhbZPSKwDsyitL80dDI28UgOcpcevlRmg8EUCnDAuPG4yi4R1zn+Hu9ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728581193; c=relaxed/simple;
	bh=gaO5v82mn+oYArgxx1o10nagyPXoR/8PsPwVnyTvKAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oO+MnervWSFzOwv9b8BeKPxYdRwvsf6v8zFWhUbrdrfxln4i/nRaU1SFypmv0Mt0fCUV6jU7o3Ca7SORdiF7qlWrpOfFARV8lL4y4sUURTdqeE/2tNWBudkSBgYLwhklyhyc5JMDCno0SPvSpOJOCFXh0zoYuLRWDB0xNlHKEkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fTut+1I8; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fTut+1I8"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7e9ff6fb4c6so1476620a12.3
        for <git@vger.kernel.org>; Thu, 10 Oct 2024 10:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728581191; x=1729185991; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ndv4iq5broYEeCiaO29JRxsFcHzBfKTnEGIT0LwAtrc=;
        b=fTut+1I8zxVtB5qSz5ixYI3GlHOnyWBDW/c7VOt/Cd/rdUmp7XwXrllbO6OEZf4uSs
         aC/7HtMZ3Dq6SgLwpOamOdbXnsxkeR+4ieWxagG482NypJLm4H1uKSC0cTzKwCE4o0gf
         ubPYIRkM3UK6Rg2L1A1K2/DhSoYEzUp8CjmPMcDZpjy5oQ+s4SQIjPjsyH8dBPOGBAui
         46g/cW1yeqgUW2DPYFdgsLmbHa1p3eYURHhpIvhgkrcqiezkD6cIFT2ng8x6ANUo6dQa
         hGdMg0gBldkxPQMoPOW5NvgL5zscAAgosaYE0EUdREmOaxojp8Ch7RCa+8Hpll+VfuYb
         mERw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728581191; x=1729185991;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ndv4iq5broYEeCiaO29JRxsFcHzBfKTnEGIT0LwAtrc=;
        b=HQzU5sOSeT7OkDPIaCXLCjQlMlFixu2DlpVnuQSyvbzW5trgVwrcD6efVhr330GH4C
         6TR2joJgx+4sQS3h+eGiWqimg34O0RfcFz9BwBdUGYjncrPSRd4x31CHxEJT4wI4HmUz
         2uoO4Si7NmU3EHxMo663KIGR1BOATeORQh14Xyox2/Iy9uj+uvNBICvY/3jmNrihRTiL
         af1YNgyWp/Ku8oUWcgLIg9obxVk0UU38HPkvKGq3fQpyaVG2Bl9Ksq/8/p7PJjT8aqn6
         DFweJGJBmzYz0l835P2SoM6GcA9WYmaYZvqH318TvBiai7nCX0poTB7fFZo5c8v1cJfW
         CWZw==
X-Gm-Message-State: AOJu0YzqMjgx9NojpxyZ5LBhzNt1aTtnfQFgQfua3uNqGGxjqbjjJdSc
	UuJDjqb//f0zV+FxaRf2Shro8aXsjBk0K9RsHGMi06jpIQEh4h3ju5RJpg==
X-Google-Smtp-Source: AGHT+IHzElJImIx8V10ZziLTu692URm4t87lO5uvY4uuPNcFDh5WVM7uk4ml96veLFemAFNLSXUjSA==
X-Received: by 2002:a05:6a21:4006:b0:1d3:e4e:ff55 with SMTP id adf61e73a8af0-1d8a3be37bbmr13300853637.7.1728581191167;
        Thu, 10 Oct 2024 10:26:31 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ea448fb7c9sm1071073a12.35.2024.10.10.10.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 10:26:30 -0700 (PDT)
Date: Fri, 11 Oct 2024 01:26:41 +0800
From: shejialuo <shejialuo@gmail.com>
To: Caleb White <cdwhite3@pm.me>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3 1/3] worktree: refactor infer_backlink() to use *strbuf
Message-ID: <ZwgOURNkNhg8BsaU@ArchLinux>
References: <20241007-wt_relative_paths-v3-0-622cf18c45eb@pm.me>
 <20241007-wt_relative_paths-v3-1-622cf18c45eb@pm.me>
 <Zwf4PT-vaLX35ELL@ArchLinux>
 <e1RptKNShhPZHXDhBkQBaCNCmKBKik4nQzRShqtgVfjcH7vBWpuLYV60PSHaJ0diX-oG3XiKHc7IebhIZM4eSkeYdQQZ_QYK2ixxsK-XwrE=@pm.me>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1RptKNShhPZHXDhBkQBaCNCmKBKik4nQzRShqtgVfjcH7vBWpuLYV60PSHaJ0diX-oG3XiKHc7IebhIZM4eSkeYdQQZ_QYK2ixxsK-XwrE=@pm.me>

On Thu, Oct 10, 2024 at 04:41:03PM +0000, Caleb White wrote:

[snip]

> > > @@ -658,17 +657,18 @@ static char *infer_backlink(const char gitfile)
> > > id++; / advance past '/' to point at <id> */
> > > if (!*id)
> > > goto error;
> > > - strbuf_git_common_path(&inferred, the_repository, "worktrees/%s", id);
> > > - if (!is_directory(inferred.buf))
> > > + strbuf_reset(inferred);
> > 
> 
> > 
> 
> > Question here: should we use `strbuf_reset` here? I want to know the
> > reason why you design this. Is the caller's responsibility to clear the
> > "inferred" when calling this function?
> 
> Yes we should, sure it is the caller's responsibility but this just helps
> prevent bugs. There's plenty of functions that reset the strbuf that's
> passed to the function before modifying it.
> 

Yes, that make senses.

[snip]

> > We have two signals to indicate the success. I think it's a bad idea to
> > use "inferred.buf.len". Let me give you an example here:
> 
> I don't see a problem with this---the two "signals" are guaranteed to
> always be in sync (either the return is 1 and len is > 0, or return is
> 0 and len is 0). Having the boolean return gives you flexibility in how
> you can call the function (if it can be placed inside an if condition).
> 

Yes, there is nothing wrong with this. But we also introduce a burden here,
when we need to change/refactor `infer_backlink`, the developer should
have the knowledge "when the return is 1 and len is >0 or return is 0
and len is 0".

If so, why not just return "infer_backlink.len"?

> > struct strbuf inferred_backlink = STRBUF_INIT;
> > inferred_backlink = infer_backlink(realdotgit.buf);
> > 
> 
> > // What if I wrongly use the following statements?
> > strbuf_addstr(&inferred_backlink, "foo");
> > 
> 
> > if (inferred_backlink.buf.len) {
> > 
> 
> > }
> 
> I'm sorry, but this example doesn't make sense. This will fail to compile
> for several reasons:
> - infer_backlink() requires two args
> - you cannot assign an `int` to a `struct strbuf`
> - even if inferred_backlink became an int then the strbuf_addstr()
>   would fail because you can't pass an `int*` to a `struct strbuf*`
> - `inferred_backlink.buf.len` doesn't exist, it's `inferred_backlink.len`
>   (probably just a typo)
> 

I am sorry for this, I gave a wrong example here, it should be the
following (I copied the wrong line in the previous email):

    struct strbuf inferred_backlink = STRBUF_INIT;
    infer_backlink(realdotgit.buf, &inferred_backlink);

    // What if I wronly use the following statements?
    strbuf_addstr(&inferred_backlink, "foo");

    if (inferred_backlink.len) {
        ...
    }

Actually, I am not against your way. Instead, you should mention why you
choose "inferred_backlink.len" as the signal in the commit message.
That's the main reason why I think we may add some comments here. The
caller may do not know we should use "inferred_backlink.len" to indicate
that we have successfully found the inferred backlink especially there
is already a return code in the function.

> > If you insist using "inferred_backlink.buf.len" as the result, this
> > function should return `void`. And you should add some comments for this
> > function.
> 
> I can add comments, and I can change the return type to `void` if there's
> consensus, but I really don't see any issue with leaving it as-is.
> 

I agree with you that this function is NOT harmful. Actually, I do not
think using "void" as the return type is a good idea. If we decide to
use two signals, let's leave it as-is. Some comments should be enough.

> > > - if (inferred_backlink && fspathcmp(backlink, inferred_backlink)) {
> > > - free(backlink);
> > > - backlink = inferred_backlink;
> > > - inferred_backlink = NULL;
> > > + if (inferred_backlink.len && fspathcmp(backlink.buf, inferred_backlink.buf)) {
> > > + strbuf_swap(&backlink, &inferred_backlink);
> > > }
> > 
> 
> > 
> 
> > For single line statement after "if", we should not use `{`.
> 
> The brackets were introduced by the patch that my series depends on.
> I can remove them, but perhaps it would be better to address that
> on the dependent patch?
> 

The original patch has three lines. So it should use `{`. After your
change, it only has one line, isn't it?

You could refer to this to see the code style.

  https://github.com/git/git/blob/master/Documentation/CodingGuidelines

> Best,

Thanks,
Jialuo
