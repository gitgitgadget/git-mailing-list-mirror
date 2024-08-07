Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CC51553A1
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 23:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723072492; cv=none; b=XMqoUo4rp/tUvzV2La2knDQaCsRqUJPa5OVnejBhDJUb60Wsmm6rfnvUiXlI9amJp0Ol9hxHydzzH+gW9IIEXjTkbT7sSlDRepx5k7PKY74Jy8pgQAGifDXm74U+6QLEGWOa0KErPkh45qHETHSxL5C50IUcAlUTfNpjWal20Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723072492; c=relaxed/simple;
	bh=Pb+PNP0Is44CDQSf1arw7jCdlhjZtrvznQvG/cTk1gM=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UNn8wpK6j5Z9+pMxhWWnBYXhudxmOVLtQKW0jTb1FQYPNZsoHg+eKiq9FaTCVU+dk3f5xbwYn/662PFKTaKZa4mej/DOPWO9UoPGoihhjN6FlcPAkxpk9FPoT84JNG8Zp4OyJ+tZRrz3rPP1uCJKpVABEkvNs6SGItr63Lsd2Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J+KIt6LN; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J+KIt6LN"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-70d1fb6c108so333530b3a.3
        for <git@vger.kernel.org>; Wed, 07 Aug 2024 16:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723072489; x=1723677289; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zt0kNR/7bfiibviAvRs5R3Zqoqo9WdXTGqzloU3NXEQ=;
        b=J+KIt6LNdMMRH9LUKKMB9NSXOPksMKkiA+rTvKHydGepTQNWzy/xNF5tAAYSV8M+w+
         o3SKiykEGLNr6+y8f6pZFaoMndKAXHu63t7ftmaqNKGIFFKDahNZmZ+w2axeLLChU7R8
         peDrqdWqyLYOO4FDrh1gWJAKBEk7B7ZCDRf/mVAPP7MCCQXVlSbIUXpY4GZk30L5S2cY
         HIka55wlxGRb6YQsWvAH3hsdixdcfHcYh1bM2UtKgTXzI5+8JRGHHpwQrcwM0sL98OUE
         irVYeV4vzHeMVsEuGYVDYme43+cwyz9TEDp2qTBNt1cHJXZ+mT9Ivx5cpNBfdRL2QOeA
         ZW5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723072489; x=1723677289;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zt0kNR/7bfiibviAvRs5R3Zqoqo9WdXTGqzloU3NXEQ=;
        b=ivkdca1c4onI//e9Rzr87S/tbe2b8WKexn4KSr+fqoCM9u2p4lal2TYJr6XGKpKHqd
         IAGps1z8vFg5348INVtz/OSajxYrZnlcMN4CyVfnoyvW2TddxcOuaaVv+CrG60uY13y6
         9uZ2gJmYKWjuQ19D3fyuaUzMJUE/loCcjykqMBscXDl8zaczEPQhT6IhCUP40SVS8Aad
         Eytf4fPdY0ln/cWcwbhILM3wgJgKr+sNqw5NiCnjCW22dKBE90in2S0WXicY2Sj9M8I5
         /PNLEby0/NcpKrYizguEYECu2mpXdJKD3b8u5lbKKsgeFtx3VfTvxOkIR8sLivX+28mp
         qtyA==
X-Forwarded-Encrypted: i=1; AJvYcCUWUwTL8PVduzVONydEZgO5jhFBW1bjrw3Us8WyBe8PStebIbQrcLOfh4wR7puNR/UVLnunKYS1EnCrNO3ljmHiWYan
X-Gm-Message-State: AOJu0YzWnuYYg/BW+9I/XAPClgfeDlsdlARzyjuCV/ZrlvpaU7DxL6eh
	HIxhUDlcXdkl32hGwAfNr+LdXZY7o0+l0Ew2KhUVCq5QihdRWgC//rRp5iGytg==
X-Google-Smtp-Source: AGHT+IE+gBinY08+EWVMYEi9AxS52KchekXIFY0s6vsvcJML8v6a0Ox8Ywq8o7gMp89XmB9N/sGLWg==
X-Received: by 2002:a05:6a00:91db:b0:70a:f65e:b13d with SMTP id d2e1a72fcca58-710cae8cf88mr239344b3a.27.1723072488932;
        Wed, 07 Aug 2024 16:14:48 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:c023:b8:a8df:17c3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710cb20a098sm39618b3a.40.2024.08.07.16.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 16:14:48 -0700 (PDT)
Date: Wed, 7 Aug 2024 16:14:43 -0700
From: Josh Steadmon <steadmon@google.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org, 
	calvinwan@google.com, spectral@google.com, emilyshaffer@google.com, emrass@google.com, 
	rsbecker@nexbridge.com
Subject: Re: [RFC PATCH 4/6] contrib/cgit-rs: add repo initialization and
 config access
Message-ID: <2p3fkcw2iie53ojnqybhyxhzwsyhkm6qhreip7emeftkjprqrw@r6drczjhy7hu>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, 
	"brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org, calvinwan@google.com, spectral@google.com, 
	emilyshaffer@google.com, emrass@google.com, rsbecker@nexbridge.com
References: <cover.1723054623.git.steadmon@google.com>
 <b84a8210a05c2358dc29f24a56adcbeaa90c8654.1723054623.git.steadmon@google.com>
 <ZrPmmBqK3IIiQutV@tapette.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrPmmBqK3IIiQutV@tapette.crustytoothpaste.net>

On 2024.08.07 21:26, brian m. carlson wrote:
> On 2024-08-07 at 18:21:29, Josh Steadmon wrote:
> > diff --git a/contrib/cgit-rs/src/lib.rs b/contrib/cgit-rs/src/lib.rs
> > index dc46e7ff42..df350e758f 100644
> > --- a/contrib/cgit-rs/src/lib.rs
> > +++ b/contrib/cgit-rs/src/lib.rs
> > @@ -1,6 +1,17 @@
> > -use libc::c_char;
> > +use libc::{c_char, c_int};
> >  
> >  extern "C" {
> > +    pub fn libgit_setup_git_directory() -> *const c_char;
> > +
> > +    // From config.c
> > +    pub fn libgit_config_get_int(key: *const c_char, dest: *mut c_int) ->c_int;
> > +
> > +    // From repository.c
> > +    pub fn libgit_initialize_the_repository();
> > +
> > +    // From parse.c
> > +    pub fn libgit_parse_maybe_bool(val: *const c_char) -> c_int;
> > +
> >      // From version.c
> >      pub fn libgit_user_agent() -> *const c_char;
> >      pub fn libgit_user_agent_sanitized() -> *const c_char;
> 
> I think it would be helpful if we didn't expose the raw C API in Rust.
> Nobody is going to want to write code that uses that in Rust.
> 
> If we _do_ expose that, it should be in a separate cgit-sys crate, which
> is the customary naming, that exposes only that and then we can offer
> nicer wrappers around it.

Yeah, that's a known NEEDSWORK that I forgot to mention in the cover
letter. I'm also going to get in touch soon with the gitoxide &
libgit2-rs folks to see if there's any joint work that we can do in
terms of defining nicer Rust APIs.

Semi-relatedly, I was wondering if you might be able to answer a cargo /
crates.io question: for a crate such as cgit-rs, which is not located in
the root of its VCS repo, will cargo balk at downloading the full
git.git worktree? Our build.rs expects the full Git source to be
available at "../.." relative to the crate root. We've currently only
tested consuming cgit-rs in JJ via a local path rather than through
crates.io.

libgit2-rs avoids this issue by including the C source of libgit2 as a
submodule, but I'd prefer for cgit-rs to live in the git.git repo if at
all possible.

> > diff --git a/contrib/cgit-rs/src/main.rs b/contrib/cgit-rs/src/main.rs
> > index 1794e3f43e..c5f8644fca 100644
> > --- a/contrib/cgit-rs/src/main.rs
> > +++ b/contrib/cgit-rs/src/main.rs
> > @@ -1,4 +1,4 @@
> > -use std::ffi::CStr;
> > +use std::ffi::{CStr, CString};
> >  
> >  fn main() {
> >      println!("Let's print some strings provided by Git");
> > @@ -7,4 +7,25 @@ fn main() {
> >      println!("git_user_agent() = {:?}", c_str);
> >      println!("git_user_agent_sanitized() = {:?}",
> >          unsafe { CStr::from_ptr(cgit::libgit_user_agent_sanitized()) });
> > +
> > +    println!("\nNow try passing args");
> > +    let test_arg = CString::new("test_arg").unwrap();
> > +    println!("git_parse_maybe_bool(...) = {:?}",
> > +        unsafe { cgit::libgit_parse_maybe_bool(test_arg.as_ptr()) });
> > +
> > +    println!("\nCan we get an int out of our config??");
> > +    unsafe {
> > +        cgit::libgit_initialize_the_repository();
> > +        cgit::libgit_setup_git_directory();
> > +        let mut val: libc::c_int = 0;
> > +        let key = CString::new("trace2.eventNesting").unwrap();
> > +        cgit::libgit_config_get_int(
> > +            key.as_ptr(),
> > +            &mut val as *mut i32
> > +        );
> > +        println!(
> > +            "git_config_get_int(\"trace2.eventNesting\") -> {:?}",
> > +            val
> > +        );
> > +    };
> >  }
> 
> It seems like this code wants to be a set of tests and maybe it would
> be helpful to write it as a few instead.  For example, we can assume
> that our user-agent starts with `git/` assuming it hasn't been
> overridden, so maybe we could write that as a test, or at least that we
> got a valid C string.

Agreed.

> -- 
> brian m. carlson (they/them or he/him)
> Toronto, Ontario, CA


