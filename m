Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E41D13AD26
	for <git@vger.kernel.org>; Sat, 18 Oct 2025 01:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760749910; cv=none; b=WsYmrTa/1DijyH5zKPBXYOZ6sdNztioh2JBO2aJck3eJ76jS6gFOABT4Qe41ZCijormpQ7bNEmXEk9SL7vXy69h8s3n+f3E9UpPDeaitMJHlryg/nfbGqCA5j0uegIa0vyzB8mZQgS04WFfU/hcCJtlHi88V/MnGSNcr5obmj3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760749910; c=relaxed/simple;
	bh=7EXCYmCym9gwtgfucI7HGsXaNkfGaTzfT/iUDQvKOUk=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=X9do/8Lh9+ZwYjQYjc6S6k0GJKM8Z3z/UTz2ZLFed4r8wp04B8F8FsRcyPv2PIfuwD/Bvy9RdVxMUwNHdWpSAhu9eLg+Hs4pmwJaSeJJqxuIx2uQbEKLAukQ5enLFKr7EwgPKiMuSD4EIv1sN0C1h8PWQkvPiSBmw3V6VWzUDig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WX2Yh6TU; arc=none smtp.client-ip=209.85.215.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WX2Yh6TU"
Received: by mail-pg1-f193.google.com with SMTP id 41be03b00d2f7-b4755f37c3eso2079693a12.3
        for <git@vger.kernel.org>; Fri, 17 Oct 2025 18:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760749908; x=1761354708; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EpKzFd7XeeEOOZHUWH+FTC8W58VbvY/B4xkkSw2236k=;
        b=WX2Yh6TU7uJCTkpkiEXo/ETpkUyfp7qT1arFvQXK6oQv303uGsKlTu9HTHfuhO9UOF
         jBWbIZGQY2ki7oto5ocYlonTQUEDg691opAOy0bxC5k7HCPEl9ouwanMTNDAT4bnEwXX
         Fypd3q0w3WyiidDxgiVpHU1EQe5iLit5i8TBJcwNNaDnN2niOkEqj/Ks+mVmoX2/q5XL
         OVBhJPI3VxJT9NY64pLt3+6daUZ14SUrK6Y51IXThmIjEYqj0gCdAj8b+M+CoYEOb5Mw
         yiApPDU+8bXvkWThwKwUk+b32KCAoob0SJg6hjnRRTfuEqVrhqaSB9j7biiKoZqbKY9D
         d6qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760749908; x=1761354708;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EpKzFd7XeeEOOZHUWH+FTC8W58VbvY/B4xkkSw2236k=;
        b=Gqb5w93Dd/Ui7uwtYyBJ5Eg60bQ7sKXibLqea0BCTsLy0opYN+ubYXlNOueXZ7dHNG
         KjYc9j2oyWkEjadDg/CGmATQuBiYZniaMRHn3CZUruvHVYqLX61eIU+fK4XOjpGLeuX+
         Z83H0uIW0ySZ+8+fVqHncZcjy/ey0Dxl8ZoMZizFOSyuOpgLwSkySmW5NG9NUTbjrkki
         r0VpxAWF/Ns9D+ffFcEix/UlgUanHGFZwyuY6CJ7QkNOMOA9K9T9xKuIg0zf0iv5c2Ag
         4frTNAHPE0/AZRbJI0bSgEE0gZZnZKKEGl6rsH+0tQQwjZUxJ0JuBmS3cnuwHYk/hKfc
         I6xw==
X-Forwarded-Encrypted: i=1; AJvYcCW4h0Lr5zPSoYML6fCUmmAw6K38Ivkg6EBs0Mn5EQLhdEYA1Oapinm+NEnWuzrlPKRIFH0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyAQT9zutZ6T/8F/qETLkKueJ7JfBt/c7oFEVF9KaMBEPG+K80
	u0hXPRhfaytoIRjnytW2Cj2/4aUgl0q4TbFPTwPCY/Q3d0jOdFEnfq6sfCa7yNf/HrloTA==
X-Gm-Gg: ASbGncsxwYnZeCbjq20MxTqqHem80o5ChU/rvt0L1feYDNiL9GqQTunzxIkjy4xY636
	H0qV5eKxeP4DXHKVZ3B/87gYxcrC2dPKMrsSVw64FiWzva4rRVrXUl7DK/xYnv1qhIdv2sGqiSk
	1GQTYk2yak4X+9qjpNZjNmHkHzINcnClBI4YODDTzgqrJxUOOSumibrF/xKrkAwPE33fXu+VNXl
	7ejB4jdhor3w/CwVfSrNVv0R66CZDsvpV4k1B1XXOkmSqFk4uI3kQE8bFEcbAEIeyrqndahqYE8
	h7jr35Ub0sGGb0ThuWUJ95ZOLwzLFvtrXJQCWO0+qeSTm1G81wi1JJrciNic5gRxKErCLoiq4hS
	Ci01NrV2nQ5F/oeEoRu57DEheuECoMvMzJu786NBcwdCHVre9reIAnmOcxJm/qFmSGcrRSkWArC
	oQZCAzpbQdr9Je6r1Fe7/YxGCr9bVzzENoJMj5cYYXLr27vys=
X-Google-Smtp-Source: AGHT+IHcYe3wFFbRd9fXkCtfrxnKInRG2eiUOyGzQ/0bF3CQKraAYl6HvPIRa+aZbVYhnoZ+xxMAeg==
X-Received: by 2002:a17:903:2f86:b0:272:a900:c42b with SMTP id d9443c01a7336-290caf85185mr75049235ad.31.1760749908300;
        Fri, 17 Oct 2025 18:11:48 -0700 (PDT)
Received: from smtpclient.apple (n058152119060.netvigator.com. [58.152.119.60])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471feb99sm8348625ad.87.2025.10.17.18.11.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Oct 2025 18:11:48 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH] diff: stop output garbled message in dry run mode
From: Lidong Yan <yldhome2d2@gmail.com>
In-Reply-To: <xmqqh5vx1p0q.fsf@gitster.g>
Date: Sat, 18 Oct 2025 09:11:34 +0800
Cc: Lidong Yan via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <6C994C9C-0034-46D0-8112-FF88773B5CF5@gmail.com>
References: <pull.2071.git.git.1760671049113.gitgitgadget@gmail.com>
 <xmqqh5vx1p0q.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3826.700.81)

Junio C Hamano <gitster@pobox.com> writes:
>=20
> "Lidong Yan via GitGitGadget" <gitgitgadget@gmail.com> writes:
>=20
>> From: Lidong Yan <yldhome2d2@gmail.com>
>>=20
>> In dry run mode, diff_flush_patch() should not produce any output.
>> However, in commit b55e6d36eb (diff: ensure consistent diff behavior
>> with ignore options, 2025-08-08), only the output during the
>> comparison of two file contents was suppressed. For file deletions
>> or mode changes, diff_flush_patch() still produces output. In
>> run_extern_diff(), set quiet to true if in dry run mode. In
>> emit_diff_symbol_from_struct(), directly return if in dry run mode.
>=20
> The above makes it sound as if the dry-run mode was an inherent part
> of the diff machinery that existed even before b55e6d36 came, and
> b55e6d36 somehow broke it.  But that is not what you are telling us,
> I think.
>=20
> You may know what the "dry-run" mode is, but others don't.  You
> should tell the backstory a bit better to help them.  I am guessing
> that this patch is to fix a breakage introduced when the dry-run
> mode is added in b55e6d36 (diff: ensure consistent diff behavior
> with ignore options, 2025-08-08)?   If so, I would expect an
> explanation like ...
>=20
>    Earlier, b55e6d36 (diff: ensure consistent diff behavior with
>    ignore options, 2025-08-08) introduced "dry-run" mode to the
>    diff machinery so that content based diff filtering (like
>    ignoring space changes or those that match -I<regex>) can first
>    try to produce a patch without emitting any output to see if
>    under the given diff filtering condition we would get any output
>    lines, and a new helper function diff_flush_patch_quietly() was
>    introduced to use the mode to see an individual filepair needs
>    to be shown.
>=20
>    However, the solution was not complete.  IN SUCH AND SUCH CASES,
>    THIS BAD THING HAPPENED BECAUSE WE OVERLOOKED THIS AND THAT
>    CONDITION, AND AS A RESULT, DRY-RUN MODE WAS NOT QUIET.
>=20
>    To fix this, DO THIS AND THAT.  THIS WOULD AFFECT ONLY SUCH AND
>    SUCH CASES WITHOUT AFFECTING OTHER CODE PATHS LIKE DOING X AND Y.

Thanks for explaining how to describe a problem in commit message. Will =
rewrite
soon.

>=20
> ... is given to help readers understand what we wanted to do in the
> earlier commit, what we failed to do there and why, and what we can
> do at this point to clean up the mess without making further
> damange.
>=20
>> Signed-off-by: Lidong Yan <yldhome2d2@gmail.com>
>> ---
>>    diff: stop output garbled message in dry run mode
>>=20
>>    In dry run mode, diff_flush_patch() should not produce any output.
>>    However, in commit b55e6d36eb (diff: ensure consistent diff =
behavior
>>    with ignore options, 2025-08-08), only the output during the =
comparison
>>    of two file contents was suppressed. For file deletions or mode =
changes,
>>    diff_flush_patch() still produces output. In run_extern_diff(), =
set
>>    quiet to true if in dry run mode. In =
emit_diff_symbol_from_struct(),
>>    directly return if in dry run mode.
>=20
> The "below three-dash" space is a place to explain what does not
> have to be a part of the resulting commit but would help those who
> are reading the mailing list and reviewing.  Repeating the same
> thing as the proposed log message does not help readers.

I am using Github pull request for convenience. I think the bot repeat =
my
commit messages twice.

>=20
>> diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
>> index 55a06eadb3..25fa452656 100755
>> --- a/t/t4013-diff-various.sh
>> +++ b/t/t4013-diff-various.sh
>> @@ -661,6 +661,27 @@ test_expect_success 'diff -I<regex>: ignore =
matching file' '
>> test_grep ! "file1" actual
>> '
>>=20
>> +test_expect_success 'diff -I<regex>: ignore all content changes' '
>> + test_when_finished "git rm -f file1 file2" &&
>> + : >file1 &&
>> + git add file1 &&
>> + : >file2 &&
>> + git add file2 &&
>> +
>> + rm -f file1 file2 &&
>> + mkdir file2 &&
>> + test_diff_no_content_changes () {
>> + git diff $1 --ignore-blank-lines -I".*" >actual &&
>> + test_line_count =3D 2 actual &&
>> + test_grep "file1" actual &&
>> + test_grep "file2" actual &&
>> + test_grep ! "diff --git" actual
>> + } &&
>> + test_diff_no_content_changes "--raw" &&
>> + test_diff_no_content_changes "--name-only" &&
>> + test_diff_no_content_changes "--name-status"
>> +'
>=20
> Test that exercises "git diff -I<regex>" is in line with what the
> original b55e6d36eb wanted to address, but given that we saw a
> recent regression report like [*], I would have liked to see "git
> diff --quiet" in the test as well.

I will read Peff=E2=80=99s test and see if I should also add some =
similar tests

> * =
https://lore.kernel.org/git/CACJRbWjwOQwJB13CwTfvhV3p+Hbn4KrNM9AtBanGtUS4V=
_1MbQ@mail.gmail.com/
>=20

Thanks,
Lidong=
