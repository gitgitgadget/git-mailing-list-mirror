Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3622D7DA9C
	for <git@vger.kernel.org>; Mon, 10 Feb 2025 10:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739182801; cv=none; b=QVEZgaQxTbZxaHt75P7Ug5L+8es/zeJEvWHvEFkoO8zqHoNCHizPoEmJk4Pc+36xdQNcRv47lC8rFpbIZmSVU3sWRW5cgC4jKXMLQbszuoDp1wTW7mO/HMULEHNCItI4KTWJpP0QG9nGcw109ED1cStbO+04BhDllMOcNoh72Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739182801; c=relaxed/simple;
	bh=qmkPRo6CfkaidXBm2VTI/n00vI318pjPoHvUpUK0B+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fLNlDn2W8e5sQJrwSsyVaEUvYHgsyW+zMynASJ3EtbywJKr/a6eki5eh1ikAVbZeeqxLlj0SODS2m1AgJXxkAsupFWx1wfFdvAaN2fdwVXKsIQvu/4537uEgKLsRVVzkNSYIj4+xcdlKG8rALgExltxh75BGBuKFF56ZIxUtkQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mtkKGrB8; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mtkKGrB8"
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-4ba86dee27bso910766137.3
        for <git@vger.kernel.org>; Mon, 10 Feb 2025 02:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739182799; x=1739787599; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qmkPRo6CfkaidXBm2VTI/n00vI318pjPoHvUpUK0B+I=;
        b=mtkKGrB8qS59dNRCDqLagZd5iabWzQoox6KB/4QAZ41mOAz/x0HAmTsdu5NrUuzxkN
         jdh6RjE7CBjxsYI3UrF5Sz6Us+lWCb1E48VFlg6Z9jkGVdhPYSzwfPGhvfohs9jQm74c
         pwDbkMWfdw1ArO1iVdFdSAKRFbP5tgXAb8i6744M/vapGvFkoGU1t9oY3vDQAci1DXuM
         +pG0dBooCj4LRXqgJMQsUjdwLJEcqboENRPra3A6exsJAmT81wvZgcYs6xkrj5wa/jDm
         3nntgUZSAjlD1TE/OK0jxrZ6mfVF7lFpS2t4yPBSaxF5FKutib6vfPAzwKE+vgslwQd1
         dscQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739182799; x=1739787599;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qmkPRo6CfkaidXBm2VTI/n00vI318pjPoHvUpUK0B+I=;
        b=Ll2K9MWnuM0oWA9qIH3T1O9ZoUz5RT/hcdQlqBHZFCEt/8udcspZq1KJ9EJJc9z7ZR
         0w6YbU2n3FcogZXcb4kDl1sgKTw+2hnBfvP7TfehSaKxRa0rgNzzBwvfohkeM5KrrX2H
         3S6Gpgt1ncp+7fpRHDmq07WNkbbSUSABpt4E24EN6MhRlvd1vBNjqr1Qh+YkhY2JH85/
         YzSCzJ/rjRYMV5yKwtuYFmXcPBSNg+d/L9PutCejNuoMzagJLWrsg68tKpLSUA9zKOen
         RcnA7V632nfN+lCr5cTU/kl5Lr7ICoRHwvPJ/eq020SgKnAHSTJWSZGH3D55Dn2z5bgp
         PGTA==
X-Gm-Message-State: AOJu0Yz4nUWeHhP/+Hw1PGWELb4e2mKlzrt4uyCH244/Dqf2awLOzUZJ
	CURO99Ys+ycW9L/pHSAyCVgViGNVfI4yIjB7sMutufBYZj73IeC4tqnQXd2cj0XtCLQ9PY6cm1u
	6DbuJhM8gio7BnCJZW4scsE7Y+CJGEl+D
X-Gm-Gg: ASbGncvGWb2VQYA/VPrvAULe6un5OiRjQw4ikPCWq5I7f+DS6o9KsfgPZMMe6z8Tvrn
	S4oB2VVxl7ySj9SA7cANBfcHYrGOnLW6Zvqrt1R6CHegrzPUjdinx6EGFCO61m1te4odPE3Z0fk
	JHQry9HOj6yFZBJHIioOhpLE3X
X-Google-Smtp-Source: AGHT+IHrd6vUXFWcYEYaxaIrol6L/jlgFUpoibAnYwi7ovIU6cl+8P0eiM4hP0rNIVjb3q3GvmM4YYud0gr4bwosZho=
X-Received: by 2002:a05:6102:38cc:b0:4bb:cdc0:5dd7 with SMTP id
 ada2fe7eead31-4bbcdc05ed4mr1320223137.16.1739182799098; Mon, 10 Feb 2025
 02:19:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALG+76eJL5dC3o+yq7zreoRDQan1MPgfNXB42k5f2iq2bZEbNw@mail.gmail.com>
 <534e8534-a9bd-428b-87f9-a512c9378b19@gmail.com>
In-Reply-To: <534e8534-a9bd-428b-87f9-a512c9378b19@gmail.com>
From: =?UTF-8?Q?Bj=C3=B6rn_Lindqvist?= <bjourne@gmail.com>
Date: Mon, 10 Feb 2025 11:19:47 +0100
X-Gm-Features: AWEUYZmM-GGXcjMl6rbkZWotzWvVcO02syyAnWbl8-ZG0pcUPM2rfdk6YNCDwaA
Message-ID: <CALG+76erpDGFinXsockB8=+GPEoEtd+xw=xVN1HCzv7=aFymoA@mail.gmail.com>
Subject: Re: git rebase --continue error message is misleading
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Den fre 13 dec. 2024 kl 15:38 skrev Phillip Wood <phillip.wood123@gmail.com=
>:
> On 09/12/2024 13:02, Bj=C3=B6rn Lindqvist wrote:
> > $ LANG=3DC git rebase --continue
> > hint: Waiting for your editor to close the file... error: cannot run
> > vi: No such file or directory
> > error: unable to start editor 'vi'
> > Please supply the message using either -m or -F option.
>
> This line comes from "git commit" whenever launch_editor() fails. I
> wonder if we'd be better to recommend that the user sets up a working
> editor instead. The message is certainly unhelpful when we run "git
> commit" from "git cherry-pick/merge/rebase/revert" where we want to seed
> the message that the user edits.

Here, I don't think assuming the user has vi installed is correct.

> I don't think that is a good idea when "git commit" is being run from
> "git rebase". In that case we want to preserve the original message and
> authorship and using '-F' or '-m' would not do that.

The error should tell you about that, I think. Right now I get:

LANG=3DC git commit
hint: Waiting for your editor to close the file... error: cannot run
vi: No such file or directory
error: unable to start editor 'vi'
Please supply the message using either -m or -F option.

The only solution I've found is git commit -m "blah".


--=20
mvh/best regards Bj=C3=B6rn Lindqvist
