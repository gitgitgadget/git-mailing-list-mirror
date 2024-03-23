Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E923A1A3
	for <git@vger.kernel.org>; Sat, 23 Mar 2024 17:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711215375; cv=none; b=Nl2ylRbyqVpSulAIpRYjhAJN0loOXgJGZAEUt/JrmUs3KUpc+VSmuU36mcZK0qWhCrwMCpsrsGTcHloZzmiRUFIZ0/Zx9gkg2bS9PXn5dSHv3iR/W7MBtq0nk0Lm7pldZKew8hzAlZmZ6e2oNzopIcM1scu/ml+VXV14iQG82yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711215375; c=relaxed/simple;
	bh=/FCQ6l0kvi/N+otum66EOV279kMuzOnC7xEF+oezCQc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RILtFnKvL2B2bxjnGt13FZoG9vrvRjiYi3z/DDVyQb8hD/6fxXd+HlvEnY8fSu3VN1Eld+XUXuQvjDLL8nCYEoKomd/4zCdaY8osiLnzHnN3JxvomN5QhfsaT6NilOf6FZq35lSQET26BZT6GOCVeoh7zpUXqgFkEjNwGeHMuBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=VdW05IfF; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="VdW05IfF"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id D7C9921ABB;
	Sat, 23 Mar 2024 13:36:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=/FCQ6l0kvi/N+otum66EOV279kMuzOnC7xEF+o
	ezCQc=; b=VdW05IfF+xBBA04MFDQLBRhaUU/dfdiNpZVevihPUkIaUGX53K4WMq
	8BYz5auChqc1SIvAwrFGwz8/sS41/mVoC9vzslReEnwHCIx8sB8mIKl3gvVLPXVZ
	2XbA2GDrsKb6ZxL+hj+6a3iHzebCWXywRmMLSae3fUvvKxY3xH3CQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id D00A321ABA;
	Sat, 23 Mar 2024 13:36:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5BC0B21AB9;
	Sat, 23 Mar 2024 13:36:03 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Max Gautier <mg@max.gautier.name>
Cc: git@vger.kernel.org,  Hans Jerry Illikainen <hji@dyntopia.com>
Subject: Re: [PATCH] editorconfig: add Makefiles to "text files"
In-Reply-To: <Zf77gyA28KsZdOUs@framework> (Max Gautier's message of "Sat, 23
	Mar 2024 16:55:47 +0100")
References: <20240322221813.13019-1-mg@max.gautier.name>
	<xmqqo7b5zy84.fsf@gitster.g> <Zf77gyA28KsZdOUs@framework>
Date: Sat, 23 Mar 2024 10:36:01 -0700
Message-ID: <xmqqr0g0yhoe.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 D232130A-E93B-11EE-B996-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Max Gautier <mg@max.gautier.name> writes:

>>  * Among the files we ship (i.e. "git ls-tree -r HEAD") and edit
>>    with editors that honor .editorconfig settings, are there any
>>    file that we do not want tab indentation other than *.py?
>
> $ git ls-tree -r HEAD | cut -f 2 | \
> ...
>       2 png
> ...

As I expected ;-) We do not have all that many kinds.  Some like
image files are not even meant to be edited as text and the usual
"editor"s people use to edit them are probably unaware of what we
write in the .editorconfig file.

> Not sure which one among those don't want the same tab-indent settings
> though.

That is the other important question.  What I was hoping to hear was
that other than Python there are not be any kind that are edited by
editorconfig-aware editors.  But that unfortunately is not what we
are hearing.

>>  * Does .editorconfig file allow possibly conflicting setting, with
>>    a reliable conflict resolution rules?
>
> Yeah it does: https://spec.editorconfig.org/#id8
> TL;DR:
> - from top to bottom, last matching section wins
> - if multiple .editorconfig are found (up until one with the root key or
>   in /) closest to the file wins.
>> 
>> What I am trying to get at is if it is possible to make something
>> along this line to work:
>> 
>>     [*]
>> 	charset = utf-8
>> 	insert_final_newline = true
>> 	indent_style = tab
>> 	tab_width = 8
>>     [*.py]
>> 	indent_style = space
>> 	indet_size = 4
>> 
>> I am assuming, without knowing, that the conflict resolution rule
>> may be "for the same setting, the last match wins" so by default we
>> always use "indent_style = tab", but if we are talking about a Python
>> script, it is overruled with "indent_style = space".
>
> So it looks like it's possible, if we also add judiciously .editorconfig
> in subdirectory where we have other files which don't want the same
> settings, probably:

That is much less than ideal---I was hoping that we can do this
with just one file.  My reading of that spec is that in the same
file it would be the last one wins, so something line what I gave
you above should work more-or-less as-is?

Also I am not sure if there is any reason why ...

> - po/
> - t/
> - contrib/
> - .github/
> - ...
>
> Not sure if that's easier than adding stuff to the to the root config
> though.

... t/*.sh should use rules different from those that apply to
check-builtins.sh at the root level, or contrib/mw-to-git/*.perl
should use Perl rules different from those that apply to
perl/Git.pm.  So I think "we need per-directory customization" is a
red herring.

The real potential downside of the approach to use a single default
fallback set of rules with "match everything" is that types that we
did not tweak the editor rules for are suddenly and uniformly
subjected to a rule that may not match the contents.  We currently
do not do anything to .yml or .md so we do not force them to be in
any consistent layout---even if all contributors use editorconfig
aware editor to edit them, they will produce inconsistent result.
If we enforce "everybody indent with tab unless explicitly set
differently like we do for .py", these contributors consistently use
tab indent on .yml or .md, which may not be a suitable convention
for the material.  My quick look says that .github/**/*.yml wants
two-space indentation, and .md are fine with any indentation so
enforcing tab indent consistently may be better than not enforcing
any indent at all.

So, my gut feeling is that forcing "everybody uses tab indent by
default, and file types with specific needs should opt out just like
we do for Python" may initially give us a bit of friction (e.g., We
may find .github/**/*.yml would want different rules, so we would
add "[*.yml]" section just like we have "[*.py]" section), but would
make the rule coverage more complete and more clear.  We would give
a .yml file some rule to follow, which may initially be wrong but we
can fix with explicit rule.

So I dunno.  If the Makefile snippet were the last type of files we
would ever add to .editorconfig, I think the patch under discussion
is a good progress, but if we share the vision of "more complete and
clear rule coverage", it is going in the opposite direction.

Let me take your patch as-is, but leave it #leftoverbits to at least
see the feasibility of switching to "everything falls under the
default set of rules, and specific needs are dealt with exceptions"
model.

Thanks.

