Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C781534F7
	for <git@vger.kernel.org>; Fri, 13 Dec 2024 16:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734108220; cv=none; b=kX0HClqElSU1QujFObOemFxpKIqXCFhka6u7WXvh9uQTlvR0PeiI1pD2m1771R9qLs3DurqzFnZzr3JWyo8QG4/juORcbUQlqhrp534DtEqkEYQZfdPPaVEvBecCOMomXTcpayr0N47hK+EVf3RJyO+gBb0m1tvGjJCRluCIZzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734108220; c=relaxed/simple;
	bh=/l3sBISJPM3nmuvOet3+afckRsxk1s/pGCD1/Sa/MvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DAJ9qlUfPBCNVSpWyV+LZojXSL4CBRWe3lKQEs8sJ9aPTYRLZa5QEFPttjL+lLkoaNoAW0ACvT5LQVs1BZH3WLGuqDqJvHoFLxlyUld3gHAGP2TU6ACyN9UW7o3yEWyjzOvE3SHIFlsPN+pQsm5mpOKINTe+kmuJd/Y6v9SeS0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nDSnFpZz; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nDSnFpZz"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-71e10e6a1ceso459952a34.0
        for <git@vger.kernel.org>; Fri, 13 Dec 2024 08:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734108218; x=1734713018; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7lbmZpOtJkpwgSzA0tCIi2boPQRqksYqfUdgzg5fZ08=;
        b=nDSnFpZzNgw4hsg2bCOGd354f7FfpEhPsfvVKOjnSBXCPbRgtz1KlGhdSet/lNBaht
         gBWfGdQmHUUcQY2c/gn+9zco2pcCm5Mt5HmgSFr5aYAH/4GM2Wxg9EgDIHMQLImaq0w1
         Zb5SyPKji32lFAybdbxvw3yqGvgfJuGqQV4qHpGwTgm2a58URl+XU4PSTOmp90Id1CDl
         Xj+TJTSP44hwLCQJ+Qq5G2KGzeTkQkahVxmjnwKraTIs85Mlf+oCrLLuJWwIqZOHsSdg
         1P0SbWDgAFSzRWx09QBEVLRBvuFLXAG/Nv3beLkmz883+abghFMA/Zuk6ieRgahfJnah
         fWYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734108218; x=1734713018;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7lbmZpOtJkpwgSzA0tCIi2boPQRqksYqfUdgzg5fZ08=;
        b=macAvbso7HsoN53YezkJnPeN015rWRZ0Z/HojfRHpRXGLgsjfY1LI+3MFW93V2M8gO
         CVxmDRawz6pWppuNi7Fv0+7M3DOG4LPp/jHeM58aItL3qHOpZsYConZH9gdbDNxBFR3A
         7O9AVpASwyZqHHwEdMURRa/d8vHt/H9n+7dx62W6zbTa0Zp1c//OTkqfoURZhZT2+Cu1
         yw5bZAtakkBr1GTBxf9nSQz1ZoAOTVzsJxGGgcVY9MfAgXyeyW0ijSTxIPR0tpThINay
         FutV5fq4Bq4Xp0THyDN0nRZBpXtdnKYg5OIIo/j/rYDTVd8nOqfRYwZn7Pgdt/vpsfjs
         j99g==
X-Gm-Message-State: AOJu0Yy9FqHqTtfEh9M1JThWhw46GUaEqyxuToE4i36PdBvMJ/joZVAZ
	QnVRUdcsHFTh+twA+VlZtLvgOD77EXpbozRtVXOqXHWU3gmMguhGnFzL/w==
X-Gm-Gg: ASbGncvoIF4zSKrUwTuUXdniN6ui3GQpFdyQ9L2RW6frI9a/Sp21de2N5TjoYdKkulI
	/5n92LpD2+VHI3PDlVeRhlQNlNT7aN0hdal2UeJiZ+6w/00cfl+Q8q1q/wZNb/e/KOZaxYEwuKI
	Ty7Our0qYxChf7O1vmJkSTxELDUhmLAzhdAxxspBAGcPNMcmP46ONUpBdEkYuO1OgZpjzm84y1L
	ffqjCrfbP9zhPAwGXlcmagzlPj6vxzgPE2SPT1DweneSWVYhw==
X-Google-Smtp-Source: AGHT+IGm3D1CZ8iEK1gIZXXPTpQcFgfn3Q7XJmA/7GXklkH3+rRvAsp4pOYy2YH+mUO63HII+G0Teg==
X-Received: by 2002:a05:6830:2649:b0:71d:e89e:9af5 with SMTP id 46e09a7af769-71e3b8928edmr1766762a34.16.1734108217751;
        Fri, 13 Dec 2024 08:43:37 -0800 (PST)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71e2c40d3afsm823438a34.36.2024.12.13.08.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 08:43:37 -0800 (PST)
Date: Fri, 13 Dec 2024 10:41:25 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, ps@pks.im
Subject: Re: [PATCH 0/3] batch blob diff generation
Message-ID: <7q5dse6hbvuqwlhfceqwockouyfvvuxaekegahgelnri6nkv7h@2ph2qdfaktx2>
References: <20241213042312.2890841-1-jltobler@gmail.com>
 <20241213081211.GA1443203@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241213081211.GA1443203@coredump.intra.peff.net>

On 24/12/13 03:12AM, Jeff King wrote:

> In the first example, I think just using "git diff" would work (though
> it is not a plumbing command). But the stdin example is what's
> interesting here anyway, since it can handle arbitrary inputs. So let's
> focus on that.
> 
> Feeding just blob ids has a big drawback: we don't have any context! So
> you get bogus filenames in the patch, no mode data, and so on.
> 
> Feeding the paths along with their commits, as you do on the second
> line, gives you those things from the lookup context. But it also has
> some problems. One, it's needlessly expensive; we have to traverse
> HEAD~5000, and then dig into its tree to find the blobs (which
> presumably you already did, since how else would you end up with those
> oids). And two, there are parsing ambiguities, since arbitrary revision
> names can contain spaces. E.g., are we looking for the file "README.md
> HEAD:README.md" in HEAD~5000?
> 
> So ideally we'd have an input format that encapsulates that extra
> context data and provides some mechanism for quoting. And it turns out
> we do: the --raw diff format.

I had not considered using the raw diff format as the input source. As
you pointed out, using blob IDs alone loses some of the useful context.
By using path-scoped revisions, we can still get this context, but at an
added cost of having to traverse the tree to get the underlying
information.

As you also mentioned, this is potentially wasteful if, for example, the
blobs diffs you are trying to generate are a subset of git-diff-tree(1)
output and thus the context is already known ahead of time. Which is
exactly what we are hoping to accomplish.

> If the program takes that format, then you can manually feed it two
> arbitrary blob oids if you have them (and put whatever you like for the
> mode/path context), like:
> 
>   git diff-blob --stdin <<\EOF
>   :100644 100644 88f126184c52bfe4859ec189d018872902e02a84 665ce5f5a83647619fba9157fa9b0141ae8b228b M	README.md
>   EOF
> 
> Or you can get the real context yourself (though it seems to me that
> this is a gap in what "cat-file --batch" should be able to do in a
> single process):
> 
>   git ls-tree HEAD~5000 README.md >out
>   read mode_a blob oid_a path <out
>   git ls-tree HEAD README.md >out
>   read mode_b blob oid_b path <out
>   printf ":$mode_a $mode_b $oid_a $oid_b M\tREADME.md" |
>   git diff-blob --stdin
> 
> But it also means you can use --raw output directly. So:
> 
>   git diff-tree --raw -r HEAD~5000 HEAD -- README.md |
>   git diff-blob --stdin
> 
> Now that command by itself doesn't look all that useful; you could have
> just asked for patches from diff-tree. But by splitting the two, you can
> filter the set of paths in between (for example, to omit some entries,
> or to batch a large diff into more manageable chunks for pagination,
> etc).

Yup, this is exactly what I'm hoping to achieve! As a single commit may
contain an unbounded number changes, being able to control diff
generation at the blob level is quite useful. Using the raw diff format
as input looks like a rather elegant solution and I think it makes
sense to use it here for the "--stdin" option over just reading two
blobs.

> The patch might look something like this:
> 
>   https://lore.kernel.org/git/20161201204042.6yslbyrg7l6ghhww@sigill.intra.peff.net/
> 
> :) That is what has been powering the diffs at github.com since 2016 or
> so. And continues to do so, as far as I know. I don't have access to
> their internal repository anymore, but I've continued to rebase the
> topic forward in my personal repo. You can fetch it from:
> 
>   https://github.com/peff/git jk/diff-pairs
> 
> in case that is helpful.

Thanks Peff! From looking at the mentioned thread and branch, it looks
like I'm basically trying to accomplish the same thing here. Just a bit
late to the conversation. :)

While the use-case is rather narrow, I think it would be nice to see
this functionality provided upstream. I see this as a means to faciliate
more fine-grained control of the blob diffs we actually want to compute
at a given time and it seems like it would be reasonable to expose as
part of the diff plumbing. I would certainly be interested in adapting
this series to instead use raw input from git-diff-tree(1) or trying to
revive the previous series if that is preferred. 

If there is interest in continuing, some lingering questions I have:

Being that the primary purpose of git-diff-blob(1) here is to handle
generating blob diffs as specified by stdin, is there any reason to have
a normal mode that accepts a blob pair as arguments? Or would it be best
to limit the input mechanism to stdin entirely? If the user wanted to
compute a single blob diff they could just use git-diff(1) already so
providing this as a part of git-diff-blob(1) is a bit redundant. Having
it as an option for the user does seem a bit more friendly though.

-Justin
