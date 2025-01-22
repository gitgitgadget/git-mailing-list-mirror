Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E337423DE
	for <git@vger.kernel.org>; Wed, 22 Jan 2025 00:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737504119; cv=none; b=XlA97xqtFqzkc28Xgej3Zsa2ib3AbbCBso30TFlkKGAQSiIfy9+7NC4fDFt15UplIt15aH7Bm9hYxcWuABecKKvv7lxbsUcP75Hodc/tZCxk+k7aNqxx/YJuHv6GEQE3wFEKm4s2P9xv7J5EFLhjE3LZr+QaEtWUIhRmQT0W264=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737504119; c=relaxed/simple;
	bh=bsWYZc2SdEeeG95E90ZtWPzh+7s3fH5miwPLlEdnjvo=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ptTDy5PqnoXvA4DifbwC3yQao0ZHQBOYhmRyrPxL6m5jEw5U15Bkc3oYthpQ0RwyYT4thmFfN/TFhvBecbIahZP98xIPfc6C1+N9zsaMGuxjRHXagEx8EkSZviTiDhR5xmN6OAArMWmbvhMiyg50kqJjjKvUR1SHGUC3G8V5rbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Kxv9JJuT; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Kxv9JJuT"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-215740b7fb8so85595ad.0
        for <git@vger.kernel.org>; Tue, 21 Jan 2025 16:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737504117; x=1738108917; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jf9AhULirCVMuO4fex7Zv5/TaTh/2EZqZ2TFlLkSxaY=;
        b=Kxv9JJuTYMq3QaVmJd8WlS6MvK/wxpPEc4jmGtrUM+QbC20958oQNAjpvI0uvSyEcE
         aoxcti9lMCicmqUHsnKgtszxcGeQn8+p07D785mtMJ9CJuIupRDO9bxzdS7HU5vxKdRt
         3zygaF70NUlSbuQMoRolxIWQkmq4Vi0HcTT0z2XrqS71XvEH7rn9oiKLWbirLcpiPPHB
         B579AHIXFj2jEb+hII91Uwu+KqRhq+K7dgtNEn1QZRnn/EJfdaB2WivlCCT3oXoktfLF
         Ki++fiYgRwH2hTUGGDIAou/ZYXfdLOa+434q/U38JpwKN+D5dw0P14sRKi9AAaMAhMzK
         iBKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737504117; x=1738108917;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jf9AhULirCVMuO4fex7Zv5/TaTh/2EZqZ2TFlLkSxaY=;
        b=AkJPbTRvEtBa9givvPjxdL/8TlMEqv6KhJWlzXWAc+ihbVmAJa3GM8TrKUovFeuwWu
         gukzBcySFrhX6pZCeUKQWTxO3zLW+3IlrbcCCV/Xp7IVAXOZRwRe3Z6R6m2mDMk2rSz0
         mCkYk1h+AWOoBJlHyo7ziRhDZdE6d8Wdo7NsiDgxuIi1lf4koNYbgohnHlzGJyMADAL0
         BNkfGwFpeqHxCI5VgFuOKSsVTDiRtlOwAnBbOrxHaA8gwiI6Z9riBwSD965FvmzGqnlg
         BsfnbCBqORkrAKnOPPkhLkvULqalmUzMVLPjHg80tHcGI0lDZN2Y6qYzgCG7AArAVwHw
         TdOw==
X-Forwarded-Encrypted: i=1; AJvYcCWJxJ3DbfcgIvGZ9o1/Yd2U7WLRIotgI6wQoVjVNpQz4GOTaIMG478auxDdBP/Bps0FZ7E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkOHo6U1NXHwuNugNaqT/1f6urAgfeRADEZ1G2ilnGLkbZ9IMy
	AagVTX8RgpilWP+N1IOWAVjE6jgO6yjkyuQcV+l08X/KnRTfdW3EGhc/JVfmDw==
X-Gm-Gg: ASbGncvyrT3hs+xZJOZ5aRdqpzS30zN6aXHbGCFHhZgW7cyo8zQBP8M9xT+4FAOd41b
	is9PCuPnJay+RSh9uL0cXl4iChHTvVJAy1UvihEkMSYoO6WuRFcdXR/SgLWxeze9ABJzvoOATik
	rOQVqg7WJIZDzayOYJKIJ+6LuY85kuH7FhM2lb8ujXwbtF97M7RJXHQ/+FsXHpW1Xpicie+65dH
	11K1aVQVY1Qw1LvC3isT5CpaT/Wq3Lm/OZq+rhZ6KYccWJIhpnlSqYCuN+Mgd5kWGT5
X-Google-Smtp-Source: AGHT+IGl3aEBoAIG0twpa4grgngCX2vprbOmf3KKXkqo1PNuzQ89Rt6AmEI1pLT/FpN2mzB49N8KiQ==
X-Received: by 2002:a17:903:1204:b0:21b:c941:b55 with SMTP id d9443c01a7336-21d83b8cfecmr1188485ad.14.1737504116888;
        Tue, 21 Jan 2025 16:01:56 -0800 (PST)
Received: from google.com ([2620:15c:2d3:204:16d0:c948:f6ad:1381])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f7e6b71eabsm98668a91.38.2025.01.21.16.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 16:01:56 -0800 (PST)
Date: Tue, 21 Jan 2025 16:01:51 -0800
From: Josh Steadmon <steadmon@google.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org, 
	calvinwan@google.com, nasamuffin@google.com, emrass@google.com, gitster@pobox.com, 
	mh@glandium.org, ps@pks.im, sunshine@sunshineco.com, phillip.wood123@gmail.com, 
	allred.sean@gmail.com
Subject: Re: [PATCH v6 4/5] libgit: add higher-level libgit crate
Message-ID: <kcjc4a27e7qs42asw2wa3v5zqvro5jiufoqys3qwru7ykpovcl@s2nuwvahjf6s>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, 
	"brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org, calvinwan@google.com, nasamuffin@google.com, 
	emrass@google.com, gitster@pobox.com, mh@glandium.org, ps@pks.im, 
	sunshine@sunshineco.com, phillip.wood123@gmail.com, allred.sean@gmail.com
References: <cover.1723054623.git.steadmon@google.com>
 <cover.1736971328.git.steadmon@google.com>
 <65166ea0c077665c350a1a7b00dc3175be889d55.1736971328.git.steadmon@google.com>
 <Z47jgK-oMjFRSslr@tapette.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z47jgK-oMjFRSslr@tapette.crustytoothpaste.net>

On 2025.01.21 00:00, brian m. carlson wrote:
> On 2025-01-15 at 20:05:43, Josh Steadmon wrote:
> > From: Calvin Wan <calvinwan@google.com>
> > diff --git a/contrib/libgit-rs/Cargo.lock b/contrib/libgit-rs/Cargo.lock
> > new file mode 100644
> > index 0000000000..a30c7c8d33
> > --- /dev/null
> > +++ b/contrib/libgit-rs/Cargo.lock
> > @@ -0,0 +1,77 @@
> > +# This file is automatically @generated by Cargo.
> > +# It is not intended for manual editing.
> > +version = 3
> > +
> > +[[package]]
> > +name = "autocfg"
> > +version = "1.4.0"
> > +source = "registry+https://github.com/rust-lang/crates.io-index"
> > +checksum = "ace50bade8e6234aa140d9a2f552bbee1db4d353f69b8217bc503490fc1a9f26"
> > +
> > +[[package]]
> > +name = "cc"
> > +version = "1.1.15"
> > +source = "registry+https://github.com/rust-lang/crates.io-index"
> > +checksum = "57b6a275aa2903740dc87da01c62040406b8812552e97129a63ea8850a17c6e6"
> > +dependencies = [
> > + "shlex",
> > +]
> > +
> > +[[package]]
> > +name = "libc"
> > +version = "0.2.158"
> > +source = "registry+https://github.com/rust-lang/crates.io-index"
> > +checksum = "d8adc4bb1803a324070e64a98ae98f38934d91957a99cfb3a43dcbc01bc56439"
> > +
> > +[[package]]
> > +name = "libgit"
> > +version = "0.1.0"
> > +dependencies = [
> > + "autocfg",
> > + "libgit-sys",
> > +]
> > +
> > +[[package]]
> > +name = "libgit-sys"
> > +version = "0.1.0"
> > +dependencies = [
> > + "autocfg",
> > + "libz-sys",
> > + "make-cmd",
> > +]
> > +
> > +[[package]]
> > +name = "libz-sys"
> > +version = "1.1.20"
> > +source = "registry+https://github.com/rust-lang/crates.io-index"
> > +checksum = "d2d16453e800a8cf6dd2fc3eb4bc99b786a9b90c663b8559a5b1a041bf89e472"
> > +dependencies = [
> > + "cc",
> > + "libc",
> > + "pkg-config",
> > + "vcpkg",
> > +]
> > +
> > +[[package]]
> > +name = "make-cmd"
> > +version = "0.1.0"
> > +source = "registry+https://github.com/rust-lang/crates.io-index"
> > +checksum = "a8ca8afbe8af1785e09636acb5a41e08a765f5f0340568716c18a8700ba3c0d3"
> > +
> > +[[package]]
> > +name = "pkg-config"
> > +version = "0.3.30"
> > +source = "registry+https://github.com/rust-lang/crates.io-index"
> > +checksum = "d231b230927b5e4ad203db57bbcbee2802f6bce620b1e4a9024a07d94e2907ec"
> > +
> > +[[package]]
> > +name = "shlex"
> > +version = "1.3.0"
> > +source = "registry+https://github.com/rust-lang/crates.io-index"
> > +checksum = "0fda2ff0d084019ba4d7c6f371c95d8fd75ce3524c3cb8fb653a3023f6323e64"
> > +
> > +[[package]]
> > +name = "vcpkg"
> > +version = "0.2.15"
> > +source = "registry+https://github.com/rust-lang/crates.io-index"
> > +checksum = "accd4ea62f7bb7a82fe23066fb0957d48ef677f6eeb8215f372f52e48bb32426"
> 
> There are two possibilities here.  The first is to check in the
> Cargo.lock, in which case all users will have to use these versions.
> That produces a more stable and reliable approach, but it has some
> downsides.
> 
> Say, for instance, that a cool new platform or architecture is added to
> libc and we'd like to support it, but that version of libc requires a
> newer version of Rust.  We then would have to hold off supporting that
> new platform due to compatibility reasons.  But if we omitted the
> Cargo.lock, users could install any version that meets their needs.
> 
> I believe Rust just got the ability to install only versions that honour
> the rust-version directive in 1.84, whereas older versions will try to
> use the latest version, even if that fails.  So I think it's okay for
> now to use Cargo.lock, because that means that things will be better out
> of the box for users on older Rust.  But we may want to drop it once
> 1.84 is older than our supported version.

OK, I'll add a TODO comment in Cargo.toml.


> > diff --git a/contrib/libgit-rs/src/lib.rs b/contrib/libgit-rs/src/lib.rs
> > new file mode 100644
> > index 0000000000..27b6fd63f1
> > --- /dev/null
> > +++ b/contrib/libgit-rs/src/lib.rs
> > @@ -0,0 +1,95 @@
> > +use std::ffi::{c_void, CStr, CString};
> > +use std::path::Path;
> > +
> > +#[cfg(has_std__ffi__c_char)]
> > +use std::ffi::{c_char, c_int};
> > +
> > +#[cfg(not(has_std__ffi__c_char))]
> > +#[allow(non_camel_case_types)]
> > +pub type c_char = i8;
> > +
> > +#[cfg(not(has_std__ffi__c_char))]
> > +#[allow(non_camel_case_types)]
> > +pub type c_int = i32;
> 
> By making these `pub`, you're exporting them.  We probably do not want
> to do that, since they are not part of our API.

Fixed for V7.


> If we need them more generally in the code, let's put them in a module
> called `ffi` or such that's `pub(crate)`, and then use them from there.

Hmm, I guess we'd need to do that for libgit-sys as well? Or maybe not,
since they're part of the API and thus we should just keep the current
`pub type ...` setup?

> > +use libgit_sys::*;
> > +
> > +pub struct ConfigSet(*mut libgit_config_set);
> > +impl ConfigSet {
> 
> I would suggest we place these in a module, such as `config`.  We should
> expect to have a lot more things in our crate in the future and putting
> a little thought into this now will make it easier for users in the
> future.

ACK, will do for V7.


> I'd also, of course, suggest documentation comments, since if we ever
> upload this to crates.io, people are overwhelmingly going to read only
> the docs and not the source, and right now we've said nothing about how
> this works or should work.

ACK.


> > +#[cfg(test)]
> > +mod tests {
> > +    use super::*;
> > +
> > +    #[test]
> > +    fn load_configs_via_configset() {
> > +        let mut cs = ConfigSet::new();
> > +        cs.add_files(&[
> > +            Path::new("testdata/config1"),
> > +            Path::new("testdata/config2"),
> > +            Path::new("testdata/config3"),
> > +        ]);
> > +        // ConfigSet retrieves correct value
> > +        assert_eq!(cs.get_int("trace2.eventTarget"), Some(1));
> > +        // ConfigSet respects last config value set
> > +        assert_eq!(cs.get_int("trace2.eventNesting"), Some(3));
> > +        // ConfigSet returns None for missing key
> > +        assert_eq!(cs.get_string("foo.bar"), None);
> > +    }
> > +}
> 
> I am, of course, delighted to see tests.  This is a nice improvement in
> our code that we can take advantage of, and we can test both the C code
> and Rust code at the same time.  And if, in the future, we decide that
> we'd like to implement a Rust-based version of this API to replace the C
> one, we've already written tests.

Thanks for the review and advice (both for this round and all the
previous ones), it's much appreciated.

> -- 
> brian m. carlson (they/them or he/him)
> Toronto, Ontario, CA


