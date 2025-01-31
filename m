Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1F715F330
	for <git@vger.kernel.org>; Fri, 31 Jan 2025 13:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738330068; cv=none; b=loQqxoc51tatDTLkZtnFmbiGOCtalz7hfAXy3BPH/U/9VZi68+FxQ5TC97cFmjeGyJIvdXNdqaJi7WZVCxqcsxhLuunxRPdydyv0hfgyogAyZn/fCWVOf7obmi1dwupZ8KUyRP+9SKqZqJQDOFD/0/zXs1BnEslX8TLGRCHAyhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738330068; c=relaxed/simple;
	bh=I1d4vR6wnOBvAiWZQdlgz2B7mWdsD83MAxDBcLDsZj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KIqNO3N8eWeNee3QdrGgQnDRXxnvN/axUWqjDDh3l7VnYgokQ5Tr+6kw0mnNuowwsL7jzXycBJ5EUCt6ejJ5upqRRYQZqOyZPaodiiKioCnoqGseA/ZeAxMU8Kbx6AahT3m+Ikn0r2BvWK+fVMVZmZSrcbBOmKunnNGscA0mREI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J1ZtkN1Y; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J1ZtkN1Y"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2166f1e589cso48889745ad.3
        for <git@vger.kernel.org>; Fri, 31 Jan 2025 05:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738330067; x=1738934867; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lG/PihDlUL+1cbbFdc/u7AgUQdNiJcaqnuQRnHUs0BI=;
        b=J1ZtkN1YXGIMH0J1/p2vBlbIqg8u0mFtolz1C+62Adrt+V87yfqlO1s6U+e3q9uNT0
         0/1nRCyKMCZ+YVLICMu1CQgsnca2vNmdi0O+/fqfwX37BLy5xMMuPfVkUh87fqOM5M4V
         Ckt5fqaeNqwB9eTExhT1WHQF+EFgsuG6oXSyehFLZmhRNWgUhLDLZ4AmzHYjaLAEI4GI
         f+ZaJAoMPkeeiMjbmr2yUL8uyQFoKc68XMCpGraSw2f2nHvVaO8JnM3Guz0o2YQsRqob
         vmOCzUWxSf8WSYK//gbvKpeDGNBMYvTqfM3WVvitA9DSh+2qHAfUKP+0EnhckCv+0GeF
         ze7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738330067; x=1738934867;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lG/PihDlUL+1cbbFdc/u7AgUQdNiJcaqnuQRnHUs0BI=;
        b=olB/ykjOeSTxr+uh/oqD4QVi2LSeUKzwWf/xeXCpNyYEAVI5L1quVtV7km1Sed3VKd
         33VoZTm5o1eoGvwiEDAG8qFel+GDhkL+DHmGbvXhCZQz1W75jeUy1aaVBNHcPKd/CYlz
         4Wmq55Ns+kIN+6u/LoFP90yUnwFKEYMTBU4epqRNxw2+VPf5dQByIPvxc8Wxupx2Ix3e
         g6H68Jt6+M8DUeOfVSFh3QhnK5YVqvVjf1rkIFASsUi/RbV1vsoORtq1uzvlUFxYdsIP
         +V9ML4g9mS41HlK1FI4O826haXzeFO5lMVj1WUahmt3B5T2KMYaO8EwuUUkdiDeWjoBN
         qt+w==
X-Gm-Message-State: AOJu0Ywp5aYVqCcWqlM7tm0QPYlH2hfhHd0AighU72DMja+fZCfFRF/C
	xbb1IfL2MRdih+mLELq+Xt+/fNX7LFrfIg/JO2iXU0karsqOI/Ak
X-Gm-Gg: ASbGncscGed3mvJ3awlHEH/uoiPxDcHGKZkh/TCH59wEKdtfWUiG8dG/U3kVPzOanlL
	C2COi5hyJ4x6mZGxAuR1CbeSUe4faiOUWuxZdg0w0+5UGEqBo8ep1naQt727ogCD6MacwbQWHWC
	6FfPLCDdnj9Rbxh0IOXzcPTXIerNUwc4i4ayyBEO9GJBSqUTne7B8g6LF8a9lCQ0cST8Zw+v9Lg
	THOvj+F/rtAsYTrptgOHAlQ1A/pVlI6f8YmbUnx1peemScIaZ56d2VtabV0OblopRgJ7A==
X-Google-Smtp-Source: AGHT+IG/7AQtagq08Qt3+sEqsoiAZvqGC2mG7OEwmrtImjO0AiGaSeMw0u5uuH0mCFQesxZMGlojWQ==
X-Received: by 2002:a17:902:d501:b0:216:4cc0:aa4e with SMTP id d9443c01a7336-21dd7de492cmr153936145ad.47.1738330066672;
        Fri, 31 Jan 2025 05:27:46 -0800 (PST)
Received: from localhost ([2604:5040:11:69e::e973])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-21de31f5cd9sm29960125ad.58.2025.01.31.05.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2025 05:27:45 -0800 (PST)
Date: Fri, 31 Jan 2025 21:29:20 +0800
From: shejialuo <shejialuo@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 2/8] builtin/refs: get worktrees without reading head
 info
Message-ID: <Z5zQMCRETczMQMxj@ArchLinux>
References: <Z5r6ZnLH3Ee8IQnN@ArchLinux>
 <Z5r679AyETgMO5Ge@ArchLinux>
 <xmqq5xlwfa9u.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq5xlwfa9u.fsf@gitster.g>

On Thu, Jan 30, 2025 at 10:04:45AM -0800, Junio C Hamano wrote:
> shejialuo <shejialuo@gmail.com> writes:
> 
> > Although this behavior has no harm for the program, it will
> > short-circuit the program. When the users execute "git refs verify" or
> > "git fsck", we don't want to simply die the program but rather show the
> > warnings or errors as many as possible to info the users.
> 
> "info" is not a verb; "inform"?
> 

Let me improve this in the next version.

> I can understand what you want to say with "show the warnings or
> errors as many as possible", but giving errors on the same issue
> many times is not what you meant

Yes, this is correct.

> ---rather, you want the checker to
> keep going and discover errors in many _other things_, after it
> finds a single error in "HEAD".
> 

I think this is a misunderstanding. Let me explain more to you.

1. If the content of the "HEAD" is not correct, we won't detect the
current directory as valid git repository.
2. If the referent of the "HEAD" is not in the "packed-refs", the
referent must be a loose ref or don't exist. In this situation, because
we will never touch the packed backend.
3. If the referent of the "HEAD" is in the "packed-refs", it will call
"create_snapshot" to create the snapshot. In this function, it would
call "verify_buffer_safe" to check the following things:
   1. Check the correctness of th header.
   2. Check via "verify_buffer_safe" method
   So, even the referent entry is not correct in the "packed-refs", the
   program won't die. But the above two cases will let the program die.

I want to say we cannot find any error in "HEAD" at now as above
described. From my perspective, we should retain the paragraph:

> Although this behavior has no harm for the program...

But we should change the statement

> we don't want to simply die the program but rather show the
> warnings or errors as many as possible to info the users. So, we should
> avoid reading the head info.

to

    We should avoid reading the head information, which may execute the
    read operation in packed backend with stricter checks to die the
    program. Instead, we should continue to check other parts of the
    "packed-refs" file completely.

> With one reservation.  We still want to diagnose a broken "HEAD", so
> I'd probably strike this sentence out, and add a statement that says
> we still check the contents of "HEAD" elsewhere as a substitute at
> the end of the proposed commit log message, if I were writing it,
> after explaining the use of get_worktrees_without_reading_head()
> you did in the following two paragraphs (both of which read well).

I want to say that we cannot check the content of the "HEAD" itself. If
the content of "HEAD" is not correct, we cannot detect the current
directory as a valid git repository. So, there is no need to say "we
will check the contents of 'HEAD' else where".

I think the misunderstanding is that you think that if the "HEAD" is not
correct, the program will die but actually it is not.

Thanks,
Jialuo
