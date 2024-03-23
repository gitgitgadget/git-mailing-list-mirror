Received: from 7of9.schinagl.nl (7of9.schinagl.nl [185.238.129.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95CBA31
	for <git@vger.kernel.org>; Sat, 23 Mar 2024 02:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.238.129.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711159211; cv=none; b=GXyqm93bdqvEo6zQOEn/QtUw+cFWyunpLpLqcWieRvPondlYqQqwijPcDFgvLRy0KhZP1S1gIRz8y5lUA/I0Ix62MdRU07Dt7FNY0lgYVn3MctaCdZ5zmhKHwuwpftghFyLQuLUqn4493c8nijG3JEQCPQnV1+7B3FLZMoKgF2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711159211; c=relaxed/simple;
	bh=9PdsIR8I5IlNLMxCAKHT+1SxKCIqfsiALMnDWJtE40w=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=D9wOdtVpj1ENvrOPC94THkx4MrhBwZTXft8C131t0ojrKocb/JaawMrOcBaGUD2wgvbksnJh2hxxLKUEayWu0ue8hW1MNgzpzzSUJvkaZ+U/+1I6bifUVM7Dv2e+TFIWjdAIvZyA9YcLj7zLRUBA+Obfb1MRG/BXn/1B0mWSxLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schinagl.nl; spf=pass smtp.mailfrom=schinagl.nl; dkim=pass (1024-bit key) header.d=schinagl.nl header.i=@schinagl.nl header.b=pn/cNHea; dkim=pass (1024-bit key) header.d=schinagl.nl header.i=@schinagl.nl header.b=CSwlhvz9; arc=none smtp.client-ip=185.238.129.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schinagl.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schinagl.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=schinagl.nl header.i=@schinagl.nl header.b="pn/cNHea";
	dkim=pass (1024-bit key) header.d=schinagl.nl header.i=@schinagl.nl header.b="CSwlhvz9"
Received: from localhost (7of9.are-b.org [127.0.0.1])
	by 7of9.schinagl.nl (Postfix) with ESMTP id 2079819FD8D9;
	Sat, 23 Mar 2024 02:59:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=schinagl.nl; s=7of9;
	t=1711159199; bh=9PdsIR8I5IlNLMxCAKHT+1SxKCIqfsiALMnDWJtE40w=;
	h=Date:From:To:CC:Subject:In-Reply-To:References;
	b=pn/cNHeax4Fdg7saYCgsDetKcougpXduUROOTxain4U07paBVlDgNPEuc41QVsmiH
	 Mt/FevsoLTcDi1DuMoFYSpeTALIJaQviWQczuYD/u6F0zyDLUmV7zwoIuEramhdEyF
	 o4zlqInios/AglmV6fSPNO3Crgs8ZHQOoqUe+oYg=
X-Virus-Scanned: amavisd-new at schinagl.nl
Received: from 7of9.schinagl.nl ([127.0.0.1])
	by localhost (7of9.schinagl.nl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id OV8bKuajsGMT; Sat, 23 Mar 2024 02:59:57 +0100 (CET)
Received: from [127.0.0.1] (unknown [10.2.12.100])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by 7of9.schinagl.nl (Postfix) with ESMTPSA id B859A19FD8D1;
	Sat, 23 Mar 2024 02:59:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=schinagl.nl; s=7of9;
	t=1711159197; bh=9PdsIR8I5IlNLMxCAKHT+1SxKCIqfsiALMnDWJtE40w=;
	h=Date:From:To:CC:Subject:In-Reply-To:References;
	b=CSwlhvz9r8DWLd+FWwWsSJlLGg6B8/vDz85QF+FTn6WO5p14oPDKiuo+sQoEqeKiW
	 T+IvL+DkBR2x4d/l5d8fipdFMnPSBL9s9mZUM2ZTwxHmuAiw+GfKOdzFdSUe7m3YRP
	 QlRTz32FM+1KvI22asF2TBsyx+p/BxiwQ8eJpisY=
Date: Sat, 23 Mar 2024 02:59:59 +0100
From: Olliver Schinagl <oliver@schinagl.nl>
To: Junio C Hamano <gitster@pobox.com>
CC: git@vger.kernel.org
Subject: Re: Allow git bisect to auto-skip
User-Agent: K-9 Mail for Android
In-Reply-To: <xmqqwmptzyny.fsf@gitster.g>
References: <3d835c4b-d026-4c6a-b68e-6989a7a2065f@schinagl.nl> <xmqqwmptzyny.fsf@gitster.g>
Message-ID: <CC68481D-E993-49F2-8941-8F5FA080B139@schinagl.nl>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hey Junio,

On March 22, 2024 11:31:29=E2=80=AFp=2Em=2E GMT+01:00, Junio C Hamano <git=
ster@pobox=2Ecom> wrote:
>Olliver Schinagl <oliver@schinagl=2Enl> writes:
>
>> In some cases, we know a commit will always break bisect=2E This is bad
>> and evil but sometimes needed=2E
>> =2E=2E=2E
>> git commit -m 'copy old to new' -m 'GIT_SKIP_BISECT'
>> =2E=2E=2E
>
>If "I want a bisect to skip any commit that has 'Skip Me' in its
>subject" is the case, perhaps your "git bisect run" script can say
>
>    #!/bin/sh
>
>    case "$(git show -s --oneline)" in
>    *"Skip Me"*) exit 125 ;;
>    esac
>
>    =2E=2E=2E your test script body comes here =2E=2E=2E
>    if test successful
>    then
>        exit 0
>    else
>        exit 1
>    fi
>

This is a nice way to wrap got bisect, but from a UX point of view, having=
 native support from the got client would be much nicer=2E E=2Eg=2E the use=
r doesn't have to learn about special scripts=2E I'd argue, if we can do it=
 the same way everywhere (I=2Ee=2E shipping such a script as part of the go=
t distro), why not handle it nativily=2E

The magic word could be a default with an override in the gitconfig=2E

>The _clue_ to mark a commit to be skipped does not have to be
>hardcoded commit title=2E  It often is discovered that a commit
>breaks bisection after the fact and it is not feasible to rebase
>all the history after the commit=2E  Maybe an approach more suitable
>in such a situation would attach a note to such untestable commits
>after the fact, and check if such a note is attached at the
>beginning of "git bisect run" script and exit with 125=2E
>
>And a new "git bisect --skip-when <condition>" option can be added to
>manual bisection process=2E  The <condition> part would contain
>something like
>
>    case "$(git show -s --oneline)" in
>    *"Skip Me"*) exit 125 ;;
>    esac
>
>taken from the above illustration=2E
>

I've read the notes solution from 13 years ago ;) and I do like the elegan=
ce=2E But I think there's two cases=2E One during the fact, when you know t=
his will be an issue andere in deed ons after the fact=2E

I'll admit, I was oblivious by git notes, and will read up on it now=2E Al=
ways using a note for this feature does make sense, as its part of the repo=
sitory=2E


>But I am not sure what end result you are trying to achieve, so the
>above are random collection of ideas=2E  Turning them into a patch is
>left as an exercise to readers=2E

In the end, is it (internally) even possible for got bisect to check this,=
 and would a patch that handles this 'behind the scenes' be accepted, witho=
ut the user having to install special tooling (scripts)?

Having said that, on a different note is 'git copy' feasable? E=2Eg=2E git=
 CP old new, where both files share the same history?

Olliver
