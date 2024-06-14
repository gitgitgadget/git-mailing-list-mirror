Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED6E15E5CB
	for <git@vger.kernel.org>; Fri, 14 Jun 2024 15:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718378595; cv=none; b=NqKlBlhKkNmhKs461Z5Hc2EhaFzD/AexLEpETbyFocJ4hAB+i4KOpJFRsq5r3ufuwVsZ2X0kuI/M/SIOlKNkZW+FYsfBj/O5m67KD8F9/I9L6x2/GCoJ2MpPmsh5mn6ZfiF+J5yDF3O8KvdW0bSozadoaKUnii0nzrpMWStczLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718378595; c=relaxed/simple;
	bh=GIfGTDTR1PHPV+7AYJoEaH3j55uHTfKCMynmhm9Con4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CtMJINtnmBX4NoqyMseGbpawhL3cVVtuvO4ZIrkjSfyNBKH5kR54MonLmbg7cXfQHyQ/Bplb6niqs6ZjK058ziMlqxbwysmjFQLhh/K/4s4+eQ6v4eae4IpNZ0E05SwCK1TLNHDIL98HaakXZzwcFnebvOMkFptRvi7pZDVWWd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=oGUZ3DqC; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="oGUZ3DqC"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 44BCB322EC;
	Fri, 14 Jun 2024 11:23:07 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=GIfGTDTR1PHPV+7AYJoEaH3j55uHTfKCMynmhm
	9Con4=; b=oGUZ3DqCsF6kdABN2TibxifYEujh3TRQna12gPP/+hN1v0ywOEhvp5
	z1UT6/ypgNUnxouJzkp6jxQkXAJgx8Ps7jtviWUXY7jV+hOa/5jW7tG+kqsvm3WU
	QFi48tOZh+DcWsaOXb6zYTCnwKZeVoGrIIGsq7wIp/vUSYbyoMizk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 37C85322EB;
	Fri, 14 Jun 2024 11:23:07 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 002A3322E9;
	Fri, 14 Jun 2024 11:23:04 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Karthik Nayak
 <karthik.188@gmail.com>,  Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [GSoC][PATCH v2 7/7] fsck: add ref content check for files backend
In-Reply-To: <ZmvTI73P2fQ6AkOp@ArchLinux> (shejialuo@gmail.com's message of
	"Fri, 14 Jun 2024 13:20:35 +0800")
References: <20240530122753.1114818-1-shejialuo@gmail.com>
	<20240612085349.710785-1-shejialuo@gmail.com>
	<20240612085349.710785-8-shejialuo@gmail.com>
	<xmqqr0d0iqey.fsf@gitster.g> <ZmvTI73P2fQ6AkOp@ArchLinux>
Date: Fri, 14 Jun 2024 08:23:03 -0700
Message-ID: <xmqqo783im5k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 FF03134A-2A61-11EF-9435-5B6DE52EC81B-77302942!pb-smtp1.pobox.com

shejialuo <shejialuo@gmail.com> writes:

>> > +static int files_fsck_symref(struct fsck_refs_options *o,
>> > +			     struct strbuf *refname,
>> > +			     struct strbuf *path)
>> 
>> This does not take things like HEAD or refs/remotes/origin/HEAD to
>> validate.  Instead, the caller is responsible for either doing a
>> readlink on a symbolic link, or reading a textual symref and
>> stripping "ref: " prefix from it, before calling this function.
>> The "refname" parameter is not HEAD or refs/remotes/origin/HEAD but
>> the pointee of the symref.
>> 
>> So I'd imagine that renaming it to fsck_symref_target or along that
>> line to clarify that we are not checking the symref, but the target
>> of a symref, would be a good idea.
>
> That's not correct. The "refname" parameter is EXACTLY the symref
> itself.

Yeah, but the story is the same.  We are not really checking
anything about the symref (i.e. the thing in "refname") being funny.
We are checking what is in "path" (like "does it exist?") and the
"refname" is there only for reporting purposes (i.e. "we have a
symbolic ref REFNAME, that points at PATH which is a wrong thing").

>> > +{
>> > +	struct stat st;
>> > +	int ret = 0;
>> > +
>> > +	if (lstat(path->buf, &st) < 0) {
>> > +		ret = fsck_refs_report(o, refname->buf,
>> > +				       FSCK_MSG_DANGLING_SYMREF,
>> > +				       "point to non-existent ref");
>> > +		goto out;
>> > +	}
>> 
>> Is that an error?  Just like being on an unborn branch is not an
>> error, it could be argued that a symref that points at a branch yet
>> to be born wouldn't be an error, either, no?
>> 
>
> The reason why I choose "danglingSymref" and warn severity is that I let
> the code be align with "git checkout". When we use "git checkout" for a
> dangling symref. It would produce the following output:
>
>   $ git checkout branch-3
>   warning: ignoring dangling symref refs/heads/branch-3
>   error: pathspec 'branch-3' did not match any file(s) known to git
>
> So I prefer to warn severity.

If you do this from that situation, 

    $ git branch branch-3 master

what happens is that the pointee of branch-3 is created at the
commit pointed at by 'master'.  No error.  No warnings.

In a freshly created respository, HEAD is a dangling symbolic ref,
and that is not an error.  You can create a root commit from there
just fine.

If there is anything that needs improvement in your example, it is
that "checkout branch-3" should be taught to either (1) not warn
about dangling symbolic link and just give the error, which is in
line with how "git checkout HEAD" in a freshly created repository
behaves, or (2) just like unborn 'master' pointed at by 'HEAD' is
perfectly happy to be checked out, allow the unborn 'branch-3' to be
pointed at by 'HEAD', and arrange the first commit (which will be a
root commit) you create in that state to be pointed by the ref
'branch-3' points at.

So from all of these reasons, I do not think missing target should
be treated as any error worthy event.  Not even warning.

On the other hand, the target of the symref in "path" must be
checked, even if it does not currently exist, for its validity, the
same way an existing ref gets checked (lives inside refs/, passes
check-ref-format, etc.).

> I intentionally ignored the "escape" situation. Actually, the path could
> be either absolute or relative. It may be a little complicated. I will
> find a way to support this in the next version.

Yes, if this wants to claim to be part of "FSCK", it should catch
all the errors the regular runtime would complain about, and
"escape" thing is one of the first things that you need to get
right.  Whatever refs.c:read_ref_internal() for S_ISLNK(st.st_mode)
case takes as legit should be considered legit, the "fallback - read
through the symlink as if it were a non-symlink" case probably wants
to be warned.  refs.c:resolve_ref_unsafe(), which is used at the low
level from object-name.c:get_oid_basic() via refs.c:repo_dwim_ref(),
has further checks to see if a refname that a symref resolves to is
valid and the runtime sanity relies on these checks.

Thanks.

