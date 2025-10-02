Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96ADD270542
	for <git@vger.kernel.org>; Thu,  2 Oct 2025 19:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759432642; cv=none; b=KCVnXH8P+fHFFAGq3U8kQ6CLj1kgmB7t4ZvWP7fIcXozuSZdSlUqF5bbgSwzYHRs0iMOGunRafd7kNJLuUEPLTPrHlFgSbJt4I68aAJb+osZzzVviOnEhxk8g/7naqIxo9JpyakMP3HB1b5j3y49EOY0vn9/5ULEbEjsJJdpu+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759432642; c=relaxed/simple;
	bh=lzwB14SCw6N0bTDgbv9Eebs84kVrdrfeh/Xh/l2Yxds=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NfNZOhBs4Jer+XkBIz94XQ72xUC+EgcPDydFMc+aXcFRspQPyq1AcN4HEvafq42UaGxv+ei7U2KcJ/pQZplmxjeUaQR685MFhyuAyZYAffb81beAsgvptmhnLqxU/QKb2S51UxKWP4WxxppQWJ/HPmLUt5OOGGVxPTCJlbNaOTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xmpp9hqo; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xmpp9hqo"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-36453927ffaso13142111fa.2
        for <git@vger.kernel.org>; Thu, 02 Oct 2025 12:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759432636; x=1760037436; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xUvFevm3Xa7VHqen5T4QTk3fzbwZQ+xjgCEyhXekwRw=;
        b=Xmpp9hqohPIgVBwHG5BTfxW4g07Nvb0FLmUibccuLzJcV69oKg8p4mvF6qOKhDCHqZ
         TTh5HvItxQo88YMK1uBjyVbaK6+Vxi2WoIp+nU0TWsS9wGbrebVfhFgjLfp612ExtJnd
         GplWdEDJYw/BaSLFGQO/U0mvaQ28R7Z/K2TGF/5s9rCPVTWSChsiWLV2KMxseVHKx78+
         cdRFi9tsg4t9Pdxy4ZiJmFKdD6vCwmMqharvLp9eBDArrAmDHZSpsiUTi9rn+smezcAN
         RxF1eKREMVIccLnYwh2V0QDuWtBSVh3qd9NxTefr/O7VYfbujkLmueI84GsTUFd7RBIF
         KBkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759432636; x=1760037436;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xUvFevm3Xa7VHqen5T4QTk3fzbwZQ+xjgCEyhXekwRw=;
        b=JRF6PNy0rwn+DRNYYKMebUssGYBZb2jc5egNRtWQHoQWzLZlM46XO+BmGGMdJ5Q6Qy
         8Ss3DAKOyW/l9IPGEHTvETUos+kUxLtpDJ3dR9G3/IkSMs0B0JlH+hvsPvh+wHMiRMbm
         72i/wl5HcQy3H9eYd6dhqWrvmqtxFdWYq8Jh03uPdqS0VNstcD5YK3f1Dkoag2wrOHQV
         UGktZIn7KbZEIqsfAog8wYqIlNZNDe9JKqDUyqA5uaAhNfvWneibLmIPIkvU2LxN+XGW
         zBX+SqpOpKTVSy/GEDoCXKT8GovMpQPhZdnjhDoetTLpDeAH3a6ZVkg3peFJpHZ+Ykj7
         USoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyzFcbuR+au4jZC8/HYKrE6omi6HI1FevSWRYr/+Obd6as9XShppdH/ro7Y7eyTVMJrao=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdHFBrSiXv1ScR/KY9K1Zzx+yrFz0TJNt3iMh5mFR8EkpVCHDS
	6gT9ssPOIjBxlUzp8aBaDTtVXJBzbCp8WOORj6M2CgNktiTSQ+BPXsntWmrRCXw9yrtQczzaY+L
	gwhjDDnlVBFRifwmt/RG9DfiYiy/G6jY=
X-Gm-Gg: ASbGncsj17JmfyI7G1Vq3KXfLYdMfDnArX6sPRxKl9xdFDD5mlZCXpq7T2Y+yoIj+Bb
	K8k7ObSfNQoFc5ythEW4+GqXT6TWTLBbIyxvV/q0uNd/Ko8yvlNFlzNCLjqdTOvvjv+lNQNBo8p
	WNu7RaicUhz+RbUGZo8xo4u05FICyv3vEfsLfqT0rBQXdSprrmpOstLHQqsjiYLEkuBCmA8YKHI
	26LZrvKgf38JnYdziNS67lO/N7XqP2Z
X-Google-Smtp-Source: AGHT+IEGxrO0z0OG87GCCegbG2cNdMoo0eWTfR735J8QJ83Mnp6/yxY4yBC5G2wqgNUC/kMwya/WtwDLYNWSKDu8Usc=
X-Received: by 2002:a2e:a904:0:b0:362:b98f:edec with SMTP id
 38308e7fff4ca-374c37da0bfmr838831fa.23.1759432636395; Thu, 02 Oct 2025
 12:17:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2065.git.git.1759341748.gitgitgadget@gmail.com> <xmqqecrmyz9j.fsf@gitster.g>
In-Reply-To: <xmqqecrmyz9j.fsf@gitster.g>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Thu, 2 Oct 2025 13:17:04 -0600
X-Gm-Features: AS18NWCZRRGbTycL3gSKtbR_7XfFDcgWaYgsYIpz0BxFxsyC9hh37kVuRrvrC_8
Message-ID: <CAH=ZcbCJjuKtVGmFv0xHTHt8XaAVPwh-Cjyba0jTaQMH7Dkh2Q@mail.gmail.com>
Subject: Re: [PATCH 0/3] Makefile update libgit.a: Include xdiff and reftable
 in libgit.a
To: Junio C Hamano <gitster@pobox.com>
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 1, 2025 at 5:32=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > The Rust compiler only needs to know how to link against libgit.a in 2 =
cases
> > that I can think of:
> >
> >  * Rust unit tests
> >  * Rust defining the main function
> >
> > Otherwise Rust can be compiled without linking, and then Makefile and M=
eson
> > can use Cargo's produced static lib files to build Git.
>
> It is a bit unclear why two (or three) are so much more hassle than
> one, but OK.  Allowing both build systems to agree on the same set
> of artifacts is very much desirable, and if meson based build rolls
> everything into a single library archive, the the other one should
> do the same.
>
> Of course we could run "ar" ourselves and combine the three into a
> single library archive, but as an approach, what you have here is a
> perfectly fine, and more preferable, way to achieve the goal of
> ending up with a single archive file.

In order for Cargo to tell the Rust compiler how to link against the C
archives they need to be specified in the build.rs file for each
crate. That would look something like this:
tree gitcore/
gitcore/
=E2=94=9C=E2=94=80=E2=94=80 build.rs
=E2=94=9C=E2=94=80=E2=94=80 Cargo.toml
=E2=94=94=E2=94=80=E2=94=80 src
    =E2=94=9C=E2=94=80=E2=94=80 do_that.rs
    =E2=94=9C=E2=94=80=E2=94=80 do_this.rs
    =E2=94=94=E2=94=80=E2=94=80 lib.rs

Where gitcore/build.rs would look something like this:
fn main() {
    ...
    println!("cargo:rustc-link-search=3Dnative=3D{}", git_build_dir);
    println!("cargo:rustc-link-lib=3Dstatic=3Dgit");
    if let Some(built_with_makefile) =3D std::env::var("BUILT_WITH_MAKEFILE=
") {
        println!("cargo:rustc-link-search=3Dnative=3D{}",
git_build_dir.join("xdiff"));
        println!("cargo:rustc-link-lib=3Dstatic=3Dxdiff");
        println!("cargo:rustc-link-search=3Dnative=3D{}",
git_build_dir.join("reftable"));
        println!("cargo:rustc-link-lib=3Dstatic=3Dreftable");
    }
}

But `cargo build` is invoked by a shell script by both Makefile and
Meson, and build.rs would need to have an environment variable set.
Something like BUILT_WITH_MAKEFILE for only when build_rust.sh is
invoked by makefile and then you'd have to remember to update both
Makefile and every build.rs if the library files produced by Makefile
are ever changed. It seems a lot cleaner to hardcode just libgit.a and
leave it up to the build systems to ensure that everything inside that
static library contains everything that is needed.

> This topic, however, especially its first step, had caused rather
> unpleasant textual conflicts when merged to 'seen' (I didn't check
> which other topic was the most heavily conflicting, though).  I may
> attempt to get a clean merge again tomorrow, but due to time
> pressure, tonight's 'seen' was done without these patches merged.

I wonder if Patrick's approach would cause fewer merge conflicts. If I
add xdiff and reftable objects to LIB_OBJS directly then I don't need
to bother with the move commit.
