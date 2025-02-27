Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F87A270EC9
	for <git@vger.kernel.org>; Thu, 27 Feb 2025 22:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740694734; cv=none; b=gPsJfsUzrlOLOsifRGmT8NlfJOZf5j2ypJzhvjo5K3h0IMQecMUlisZLcz1kIarBLBR2LrbUC0RyemLp49/4tWrA1cvPe2Ii8+MEGCbBIXj7B/0j0up1aZz9scArPwCKfEJwvVnv1DbK2BAiKU1xS2nzw3No+FVqrfD1E8BuVek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740694734; c=relaxed/simple;
	bh=TuzxwdoEJsodMPjLt1G9Mz5pw3iNNzZLmgS6HjkC6/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PwDDJFoVHTPG0ouWMKHAsFme/WDTthTZuhta/P55+2cEv9Vy+YsQoshki0jKK1Wf/U+J/n9BAjaAnYfxDwKCN3jqNUttclrMQ9oWVveHBCJHWB754h6YKBonlCSFgY/dnsm8fKQiNDU/0mmaJrel+NX2VcxW4wH0sK55rFKxGxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l2sZ2Wyl; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l2sZ2Wyl"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-72726e4f96cso767835a34.0
        for <git@vger.kernel.org>; Thu, 27 Feb 2025 14:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740694732; x=1741299532; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kpoVEgdB5zU6jd47ALVT4ru7s5Y+CFDnYkxVrvTRwus=;
        b=l2sZ2Wyl2Aqa8CpqGHqx0LYiaKSg94X28zOxwO8E7084ZidnHNzfTkhB4jhbiO3vW4
         5UuVacWCSYnxzlf05WSRPfSEEbv7+hfXtuzFCA4tEV8JOQgYL6E1qbSKZ0JPaNcsbOCs
         v+GRo0l0eqtTZSThFer+dimfXMBNWphMBDJVqoBQpmmEhCoGH2IxSZvidfn0TbZlXGSn
         xOVSWRpE5b0bCDSeLRECV5Tr+e7gYmm3LK2IG5G0tfWhnrKXyQk8C3eEzBBrEOCN5pTG
         hGrU3bOqW5tUTEt6Xf7UsbFn0ZrxfPpNW9JRSxUAbbKsWdmS3Km3YDLTjfB+ybYnaHv2
         nx+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740694732; x=1741299532;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kpoVEgdB5zU6jd47ALVT4ru7s5Y+CFDnYkxVrvTRwus=;
        b=cUErbduTuY1Jz/yIqhG8x2nVjJYJOzaNqTRlo6bfMxi3XpQnNElSfJ4Ti0C2ovqzTs
         rx2gVOLO8vWz7k0WVNMlXZFRQyLX7FZAK0v3mbKxqwxwRvtezS1cnLzDhkaFNU7sMYzz
         Q7Bpp0Iea67Zszfv3G6+NupcgEp8NhtOaINiErpYwn0/kf1u3zbCEaRhB5fISRPSDLQq
         dUeGlNuORVMjr3frNCFik0TLjbGFq8wlxgVWRp69Gr2I8XSEZdwWii423rrzyzwtaIJj
         gVGeMfJe27Ge592+iDzD2+GiXnLussFxZloWJgYvs0b/MuT0kkragouMkvvO3j/dVbMZ
         pmlw==
X-Gm-Message-State: AOJu0YwpvPAX3mzdGYZ8dzCp4O2OlFSMqlSGrN40aKh6eqSqrEV8lKXD
	xLmhO5u2X+Mo56y8Yt+tS7t81czC/KztEzV3mHRB0QZigyuJdPDQ
X-Gm-Gg: ASbGncuTaL3BlJ8d+LLKY5b5rrpX9NZHhl4nqS8WFFPjR9G1nmu973PGzWTat3jM/hA
	X9bizO0kEJ8wbADvKe8qGM4Zu4xXHtMaCHJrhwr3DEZu/sL2C01ktLZFlg5Mf6PjwcDZfIMzpuy
	h2mBcbXlYF0DJdGIzCxYs1vNSXY8o6xwcuW0IF8vFfK3xE1CEvalGZzyt8wkc6YjVMEkdwHVpsd
	e8s92GzHwaOpghqSHHeeXtwGELE1tUvhDKt7YZ4SG8QDy9EdBFuSnJfkwSbcSwB44oYuBxo9x6f
	bPKI5jW1DWoOqlfpWr4=
X-Google-Smtp-Source: AGHT+IHHS8WzP/91O5n3S3VDZCOBHU0knFTc3roxbMP+jrV5opXZvZLTd0Mb8NGJPppGLAzUT9kQDg==
X-Received: by 2002:a05:6830:44aa:b0:727:2f0c:916a with SMTP id 46e09a7af769-728b82a1849mr561373a34.16.1740694732233;
        Thu, 27 Feb 2025 14:18:52 -0800 (PST)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 46e09a7af769-728afd8b3e4sm408392a34.59.2025.02.27.14.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 14:18:51 -0800 (PST)
Date: Thu, 27 Feb 2025 16:15:36 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, ps@pks.im, karthik.188@gmail.com, 
	phillip.wood123@gmail.com, Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 2/3] builtin: introduce diff-pairs command
Message-ID: <wxr2memiox7l4ljz4wozxlxtkd2qms7crzsztb2vim6f5jjw4s@jm5retwyxhib>
References: <20250212041825.2455031-1-jltobler@gmail.com>
 <20250225233925.1345086-1-jltobler@gmail.com>
 <20250225233925.1345086-3-jltobler@gmail.com>
 <xmqqjz9cd0nl.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqjz9cd0nl.fsf@gitster.g>

On 25/02/26 10:24AM, Junio C Hamano wrote:
> Justin Tobler <jltobler@gmail.com> writes:
> 
> > +static void flush_diff_queue(struct diff_options *options)
> > +{
> > +	/*
> > +	 * If rename detection is not requested, use rename information from the
> > +	 * raw diff formatted input. Setting found_follow ensures diffcore_std()
> > +	 * does not mess with rename information already present in queued
> > +	 * filepairs.
> > +	 */
> > +	if (!options->detect_rename)
> > +		options->found_follow = 1;
> 
> An ugly design decision that may be suboptimal from maintainability
> point of view.
> 
> The parts of diffcore_std() that --follow wants to bypass may happen
> to be the same as the parts that this new caller wants to bypass,
> but who guarantees that they will stay that way in the future?

Good point. When invoking diffcore_std(), we really just need to be able
to skip diff_resolve_rename_copy() as that is what is updating the diff
filepair statuses. In the next version, instead of relying on
`found_follow`, I think I'll introduce a new diff_options field,
`skip_resolving_statuses` for this specific purpose.

> > +	while (1) {
> > +		struct object_id oid_a, oid_b;
> > +		struct diff_filepair *pair;
> > +		unsigned mode_a, mode_b;
> > +		const char *p;
> > +		char status;
> > +
> > +		if (strbuf_getline_nul(&meta, stdin) == EOF)
> > +			break;
> 
> There should be a variant of this function that takes delimiter
> parameter.  By declaring an int variable that is initialized to '\0'
> (because you only deal with "-z" input) and passing that delimiter
> variable to strbuf_getwholeline() would future-proof this code path.
> 
> How builtin/update-ref.c:update_refs_stdin() works may be inspiring.

Makes sense, I'll swap to using strbuf_getwholeline() with a defined
line terminator variable in the next version. This way it can help make
supporting the "normal" raw diff format as input easier in the future.

> > +test_expect_success 'diff-pairs recreates --raw' '
> > +	git diff-tree -r -M -C -C -z base new >expect &&
> > +	git diff-tree -r -M -C -C -z base new |
> > +	git diff-pairs --raw -z >actual &&
> > +	test_cmp expect actual
> > +'
> 
> Amusing ;-)  But a very obvious and important thing to test.
> I would have fed <expect to diff-pairs for this test, though.

Will adjust in the next version.

> Other than that, nicely done.

Thanks for the review!
-Justin
