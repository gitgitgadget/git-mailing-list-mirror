Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC03D1B1D5E
	for <git@vger.kernel.org>; Wed, 21 Aug 2024 14:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724250066; cv=none; b=WcAJq4mxVWJNMjXosIju4BeChfLXFIRhQ3m9wZ2xr84osHwqPyafZJBYDnfSSiwSw8HfOsbt6Pj4LQ3VGkQhcNwQeqb2gA+7bxlwEDhnvRv8QT+eL+3FcTK9UcMoE5XK8C+PORt93/hrM0ga+WwKA3K7qkhhBFtQBLoDPzJr6wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724250066; c=relaxed/simple;
	bh=ItdQY5+Sv0Ui6sc2WwLuijYMTMgjHptyflQlYLoIlGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pmOgSVhWuPEES0nOICi/qvYMlxqMDulabTvR6WQNdfK06x2qAEVD+8McXbQbXstYjQzTwaEMrvEr/bPCtae/67CKSrK2HS70wgs5AyQW4Mv5WQMUsuzIdaTPv/DO8+S7Z2Le5asWfOI/hJsjlu9IhKWTXTywY8NH9UyRMv0jKYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R5EvgzpP; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R5EvgzpP"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7cd895682fcso301910a12.0
        for <git@vger.kernel.org>; Wed, 21 Aug 2024 07:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724250064; x=1724854864; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iyxgRuSaArbv6/4+0hs/ufvCRvM7ugIcNdMESbUTnHE=;
        b=R5EvgzpPMt5PQumkZOPllOPkvCBMZrg2wXx54XOTNTelysX9wim10LC0O4VdB1gUln
         7ebs30gxDwKgUURrNaFDCZOXTlEStvTeCKqg64tTxTHONSd1zUz1EzK0p9xaszV3SEub
         QanQF5OQ8NkRG4wJRh4RNHX1axpB66klf+30pjqHr4eHqriyI8lm3LQQ74GqwBrt0E39
         jUv5LJWCZYhuERSivfANPVQoAWCBbou5+zVB+w1BazQrRkqF3777tyIAgyLWUZpTDh2J
         IrZKmpPc3P0hlZSLJFQ6k9zuSLnI7jfGyn0muxUoqK6VknW6hUlViMTLdD9norEyaMBY
         JFcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724250064; x=1724854864;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iyxgRuSaArbv6/4+0hs/ufvCRvM7ugIcNdMESbUTnHE=;
        b=As4MhaoyP8qPeAYAW0juXDwF8811tk+8OQiGWU5u/kO24m7+GlqrZLvd9QXrqeTNAg
         Nms/XM9IAS2VHwgU6X4YgucT8jVcknAZYqoz5x70CgyVMTW4kYwQ2/NDGdXt/baB6mzM
         OKGQMC0xjrn9ljtV1v3s1/40jGslNgtiA0MwVcv2kqpwaFR936LRy8kojkxRX8jMEwwZ
         wfsyToDstv87aigCvH8LikXbO3z2KulC1WBRMCXONACPHWCDWsvgft41eHoCKitG3X8c
         jJewngzXSwPTvK7Lbu9/hUsh9ZJO6wuBUQ4ZFyh1XP87exelBSQaQBIffusme5Rbr4EK
         QoYQ==
X-Gm-Message-State: AOJu0YzwnRDunfOk1xUcFYZMRiDyeKRoibLFnU2GLATlg+es/Hk53lGz
	/WDjf+pzjiljB7Evebt5F/oa014F1KpxSyjXmcW/dsKLQsjubmZ0
X-Google-Smtp-Source: AGHT+IEZooaMMePPFf7cYFSSFB4mxitCsGR86xBg+JLryA8lDI5U4whwERA5XKOMmsQmA438nqMaLg==
X-Received: by 2002:a05:6a20:9f47:b0:1c2:8af6:31c2 with SMTP id adf61e73a8af0-1cad83a024cmr3353410637.44.1724250063774;
        Wed, 21 Aug 2024 07:21:03 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c6b636b07fsm11272792a12.86.2024.08.21.07.21.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 07:21:03 -0700 (PDT)
Date: Wed, 21 Aug 2024 22:21:47 +0800
From: shejialuo <shejialuo@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v1 2/4] ref: add regular ref content check for files
 backend
Message-ID: <ZsX3-yU52X2fe6JT@ArchLinux>
References: <ZsIMc6cJ-kzMzW_8@ArchLinux>
 <ZsIM2DRDbJsvNjAM@ArchLinux>
 <xmqqed6j9m24.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqed6j9m24.fsf@gitster.g>

On Tue, Aug 20, 2024 at 09:49:23AM -0700, Junio C Hamano wrote:
> shejialuo <shejialuo@gmail.com> writes:
> 
> > We implicitly reply on "git-fsck(1)" to check the consistency of regular
> 
> "reply" -> "rely", I think.

I will fix in the next version.

> > refs. However, when parsing the regular refs for files backend, we allow
> > the ref content to end with no newline or contain some garbages. We
> > should warn the user about above situations.
> 
> Hmph, should we?  
>

I am very sorry about this. Actually, I should not use "should". I don't
give compelling reasons here why we need to introduce such checks. I
just told the reviewer "we should warn". I will try to avoid above
mistakes where I didn't give enough motivation.

> What does the name-to-object-name-mapping layer (aka "get_oid" API)
> do when they see such a file in the $GIT_DIR/refs/ hierarchy?  If
> they are treated as valid ref in the "normal" code path, it needs a
> strong justification to tighten the rules retroactively, much
> stronger than "Our current code, and any of our older versions,
> would have written such a file as a loose ref with our code."
> 

Let me first talk about what will happen when we use the following
command:

  $ git checkout bad-branch

I use "gdb" to find the following call sequence:

  "cmd_checkout" -> "checkout_main" -> "parse_branchname_arg" ->
  ... -> "get_oid_basic" -> "repo_dwim_ref" -> ... ->
  "parse_loose_ref_contents" -> "parse_oid_hex_algop" ->
  "get_oid_hex_algop"

I dive into the "object-name.c::get_oid_basic" function. If we pass the
actually "oid", it will call the "get_oid_hex_algop" directly.
Otherwise, it will execute the following code:

  if (!len && reflog_len)
      refs_found = ...;
  else if (reflog_len)
      refs_found = ...
  else
      refs_found = repo_dwim_ref(r, str, len, oid, &real_ref, !fatal);

  if (!refs_found)
      return -1;

As we can see, when there is no corresponding refs found by calling
"repo_dwim_ref" function, "get_oid_basic" function will return -1. And
here we could have one important conclusion:

  The "get_oid_basic" function relies on "repo_dwim_ref" function to
  parse the ref and get the pointee "oid". So, it uses the interfaces
  provided by ref backend.

Next, we look at what will "parse_loose_ref_contents" do for regular
refs.

  int parse_loose_ref_contents(...)
  {
      ...
      if (parse_oid_hex_algop(buf, oid, *p, algop) ||
         (*p != '\0' && !isspace(*p))) {
            *type |= REF_ISBROKEN;
            *failure_errno = EINVAL;
            return -1;
      }
      return 0;
  }

Let's continue to see what "parse_oid_hex_algop" will do:

  int parse_oid_hex_algop(...)
  {
      int ret = get_oid_hex_algop(hex, oid, algop);
      if (!ret) {
          *end = hex + algop->hexsz;
      }
      return ret;
  }

If the result of "get_oid_hex_algop" is successful. We will set the
"end" pointer here. The "get_oid_hex_algop" will eventually call the
"get_hash_hex_algop" function

  static int get_hash_hex_algop(...)
  {
      int i;
      for (i = 0; i < algop->rawsz; i++) {
          int val = hex2chr(hex);
          if (val < 0)
              return -1;
          *hash+= = val;
          hex += 2;
      }
      return 0;
  }

This function will convert the hex to char by the raw size of the
algorithm. And by the following code, we could conclude the following
things:

1. "41053a9084501db79c72b14e8a5a0b67de3f91ae" is correct, because it
will be parsed successfully by "get_hash_hex_algop" and "*p == '\0'".
2. "41053a9084501db79c72b14e8a5a0b67de3f91aef" is not correct, it will
be parsed successfully by "get_hash_hex_algop" but "*p != '\0'"
and "isspace(*p)" is false. So the check in "parse_loose_ref_contents"
cannot be passed.
3. "1053a9084501db79c72b14e8a5a0b67de3f91a" is not correct, it cannot be
parsed successfully by "get_hash_hex_algop".
4. "41053a9084501db79c72b14e8a5a0b67de3f91ae garbage" is correct,
because it will be parsed successfully by "get_hash_hex_algop" and
"isspace(*p)" is true.

By the above discussion, I could answer you comments one by one.

> If the content is short (e.g., in SHA-1 repository it only has 39
> hexdigit) even if that may be sufficient to uniquely name the
> object, we should warn about it, of course.

When the content is short, although it may be sufficient to identify the
object, we should still report an error here. This is because we care
about the ref. As we can see from above discussion, the "object-name.c"
totally relies on the interfaces provided by the ref backend. And
"get_hash_hex_algop" is unhappy about this situation. And eventually the
"object-name.c::get_oid_basic" will be unhappy, return -1.

> A file that has 64-hexdigit with a terminating LF at the end may be
> a valid file to be in $GIT_DIR/refs/ hierarchy in a SHA-256
> repository, but such a file in a SHA-1 repository should also be
> subject to a warning, as it could be a sign that somebody screwed up
> object format conversion.

I agree with this idea. But in this implementation, we want to reuse the
"parse_loose_ref_contents" to check the consistency of the regular refs.
If we are in a SHA-1 repository, "parse_loose_ref_contents" will be
unhappy about this. However, I don't think we need to provide user that
"the content is 64-hexdigit ...". We just report "bad ref content" to
the user. This will also indicate the user something is wrong, you need
to check the ref database.

> But a file that has only 40-hexdigit without a terminating LF at the
> end?  Or a file that has 40-hexdigit followed by a CRLF instead of
> LF?  Or a file that has the identical content as a valid ref on its
> first line, but has extra stuff on its second and subsequent lines?

This is the core problem why we want to introduce more strict check.
Because in the current "parse_loose_ref_contents" function, as long as
the next byte of the end of the hex is '\0', spaces, LF, CRLF. We could
know that the content of the ref is OK.

But in my view, we should warn the user about this situation. This is
because in the original code, we do not check the ref strictly for files
backend. And I think at current, the normal user should not interact
with the git database. If there are some garbages we found in the ref
database, I guess this could be a sign for the user: "Watch out! there
may be something wrong".

> "What are we protecting us from with this tightening?" is the
> question we should be asking ourselves, when evaluating each of
> these new rules that fsck used not to care about.

That's a hard question, really. I find it hard to know what should we
do? The motivation is hard to describe. But I think this reply could
make thing more clear here.

Thanks,
Jialuo
