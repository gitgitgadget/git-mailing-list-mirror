Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFF22BD11
	for <git@vger.kernel.org>; Sun, 23 Nov 2025 02:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763865054; cv=none; b=G6/6EHo9lxTWL0txTDr6M1u1Oko7NC9JfQiT/ufJeSyvFeY+0xYV/6ViUusa5K4/FAyVPZfl3y6oubO6ArdPU+RBYJCV1ce2dkuILOjMdblbcCnMETb0GDrw+hPndkEmiqRIjNe3zXPh3B/UlZ2usmyxiTeYiPYy2DpswGwLbOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763865054; c=relaxed/simple;
	bh=mc5S6kGHfWesbWKhJJp/yJ+fFBS0/Q0Y+F3HvfNoDlk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VUU8/LHSNt/eZE9kp6ZyO0ZZv4kM4m715uHWmWP93id7J5oonmXoY7CNvwNCgEy0F6XCZ5sO7n77pknsuzdBHbWSasXqpkKmviSwakH64sJvVesxx1rOnqvr5c9dEVjGsAH7ms65SHTXpOCkPJZ9vmq7H1rA/PcLNV4thPbKQJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ah93xSCX; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ah93xSCX"
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-9490cbf951fso121380839f.1
        for <git@vger.kernel.org>; Sat, 22 Nov 2025 18:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763865051; x=1764469851; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cuV4Pco30+zQB/eWwkhWsDTnW+h83r+Sl6S1OB2M8bY=;
        b=ah93xSCXIB8nCO9ygWw9iUIjhIbV4wuxWc2rMxnckpQMc0p7KAoW60u940kl8tAZzI
         Kf7RcC3alr2X1WlyTg2MVn1ImXgMt34OWj6BccV5WSYbi+yPVgPM9zmBf8BNnT1TJxdZ
         3jzpAhUicXPxbFX32PJzGFKactj+wGkRRlsOZCU14zRr2JcNLgRRxvtaUfq/rnGAcUxW
         ZU6z6Czq0fpszWs72VpF/t/tmcFwcP50AQkkuFJ4/weldL8pb/UlzGlBFu2IO3g9bsmA
         izq4e0NK4J6VoKmNRetx/jMlgkyA9W8T2lSI5P7c9EksnXBWJK5I2R4Q99PSH2ltR2aM
         Wduw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763865051; x=1764469851;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cuV4Pco30+zQB/eWwkhWsDTnW+h83r+Sl6S1OB2M8bY=;
        b=tg6kmEaByznagsq0oOr/WaLSylHVUle7bJp0HSKjeOF2NTxhxvGfjcvsgRibhUYqkL
         nfjagafTvbelToC+/+KL5kTGrsK2D0VWI9lGujj5kZl2DgO+82vAkBhV8NfTQHupxogj
         H6yi8f2F+XocXnfSFnFmK2teiK644Ixi5XuYMGkLd+EVxKB4SxbEWfUwBrOToYzO0nHo
         HLS2KO81EHwv/9/I7m8rUKnkiXrNo81vZ+Ecvs0uSGnTo83IDyD78jLIxq7pwjwBITiI
         Mr99ib4UWEcoSkTAuwkvxsS6y+r8jSDS6EWmfymLbmYZNQcfycBXykG+UKr4OTA5WJqJ
         QBAw==
X-Forwarded-Encrypted: i=1; AJvYcCUE6+ubxp4iSkICxIJNscttJaF8s13bpKLURqddDUiOjMVribmTZ4ZIyFTcqNCly6IZQbE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9uYWp0CvK6SsknyuZNnbGLCbFBrfNrRsqnUzNi4TMN+t9QWM3
	s4RjiDk004mQtYmzjESkYke2yA6wNDv72eowbNlSWMu5wyd+sVPJ8FL9A9YrvlbRgQlsKpYml8o
	a66/eDy767Ng+g3+5/K5OITSFqPDummk=
X-Gm-Gg: ASbGncubyGZ9QHOUcKnKQipls4TJ5NWgfGl98Nn2nKjLs1nFhoXiuzTChVwVPWbiDoA
	8CHgq1Ey5yYJvtbByARDqWiq7Px6dy147J7+nn47lRiF+UuqFd2bOxggJSZo0IAnlX+ufTmuiEp
	qf6CEXVWeEdFxINizy+zAL3fkLVWD7lVxBGoUAjIQykelqc0zdVeK91mUiQsrdBnmBMNUVkxgCc
	6WDQxXSQu0fUSZ5dd2nDLAtiFemoZ/E/AwvgDSyzK2cWgzG92Jd2UilRyYl1E2QJL33f62RufUt
	xqcDgVeKb2ri9BoqnJqZj+/tini2
X-Google-Smtp-Source: AGHT+IEWhd9Amn3LOrRqD+7yNJwWrJstJkH6EvehVBLeVxOSC6iWGgo3tQEMUgElX1CSe2TDfZrpHPGJ6eirQrTQj+U=
X-Received: by 2002:a05:6638:c42:b0:5b7:3d5d:53c9 with SMTP id
 8926c6da1cb9f-5b967a11523mr3977207173.7.1763865051381; Sat, 22 Nov 2025
 18:30:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819-b4-pks-history-builtin-v1-0-9b77c32688fe@pks.im>
 <20251027-b4-pks-history-builtin-v6-0-407dd3f57ad3@pks.im>
 <CABPp-BGLrVv=maEqhs=j9MmST-F=K=XN6gGqmd9Hox5QRDMiHg@mail.gmail.com>
 <xmqqbjkw78jj.fsf@gitster.g> <CABPp-BG+2+vanKAS-cwAD2XZxwx=PPcu5OG58ys+8O7rfZEhug@mail.gmail.com>
 <xmqq7bvk77lr.fsf@gitster.g> <CABPp-BEyMFiRdHoseTaYG9rUFO6Ta=dBG88CGRb3CfNf8aSAkg@mail.gmail.com>
 <3fb47b15-ed43-4137-95f8-cee97ab5e44c@gmail.com>
In-Reply-To: <3fb47b15-ed43-4137-95f8-cee97ab5e44c@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Sat, 22 Nov 2025 18:30:39 -0800
X-Gm-Features: AWmQ_bnf505UsHYB2ZiHMNBSXF04tDN7CFR385f44vXQzk63jFGrHARa6oEIsIk
Message-ID: <CABPp-BG-tLuydXkctsitFzozEq-=A+qTf2qOe1vYm+NeRnWsOA@mail.gmail.com>
Subject: Re: [PATCH v6 00/11] Introduce git-history(1) command for easy
 history editing
To: phillip.wood@dunelm.org.uk
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, 
	"D. Ben Knoble" <ben.knoble@gmail.com>, Sergey Organov <sorganov@gmail.com>, 
	=?UTF-8?Q?Jean=2DNo=C3=ABl_AVILA?= <jn.avila@free.fr>, 
	Martin von Zweigbergk <martinvonz@gmail.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Karthik Nayak <karthik.188@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 21, 2025 at 6:31=E2=80=AFAM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
>
[...]
> > So, you are referring to the single branch, HEAD-centric piece of the
> > feedback.  The funny thing there is that operating on a more limited
> > case, without checking and verifying that you are indeed in the more
> > limited case (and erroring out if not), risks painting us into a
> > corner or providing some really buggy behavior when we aren't actually
> > in that case.  To me, it opens a can of worms and makes the problem
> > scope bigger instead of smaller.  Funnily enough, the single branch
> > thing is also the one piece of this that I think could be solved by a
> > fairly small change in the reroll (and I pointed out how in the
> > comments), so the limited view really didn't buy anything here IMO.
>
> I can't find that comment. Are you referring to reusing more of the
> replay machinery?

Yeah, what's needed is the equivalent of running "git replay --onto
${NEW_COMMIT_ID} --ancestry-path ^${OLD_COMMIT_ID} --branches", as
noted in more detail over at
https://lore.kernel.org/git/CABPp-BEm1QBP+CuSOn5FaE3XJVFg+Qbfzdp560u00ZERbN=
m6qQ@mail.gmail.com/
.

> If so we have the problem that the user gives a single
> commit to "git history" so we don't have a handy revision range to pass
> to the replay machinery unless we assume we're rewriting an ancestor of
> HEAD or we go and find all the branches descended from the commit the
> user gave us.

The range is included in the command above: "--ancestry-path
^${OLD_COMMIT_ID} --branches"

And because of this, we don't even really need to "find" all the
branches as a separate step, it's just part of the same revision walk
for rewriting commits.

Whereas if we do want to only handle a single branch as the current
implementation does, then we *need* to do an extra revision walk to
ensure that the commit is not also part of any other branch and error
out if it is, because disconnecting the histories would be very
counterintuitive in most cases.  If users really do want to disconnect
histories of two branches sharing a commit, we should require the user
to provide some flag to explicitly specify such to signal that it is
okay for us to bypass such a check and just rewrite one branch.  Such
a check is missing from the current code.

> Long term we should certainly do the latter but depending
> on how much work it is to implement that we may want to go with the
> single branch case at first

I showed the implementation of the latter, and it's actually (much)
less code than what's already in this series; see the
replay_descendants() function I posted at the same link above.

My replay-edit work used a just slightly modified form of that
function, because editing a commit and replaying all commits from all
branches that reached the OLD_COMMIT_ID, to now be replayed on top of
NEW_COMMIT_ID, is exactly what was needed there too.  (If you're
curious about the modifications: I had an extra --brief-stats option
because I found it nice to provide some user feedback about what was
updated, and I pulled the "--branches" portion of the command from a
${GIT_DIR}/REPLAY_EDIT file, because that allowed me to give users the
opportunity to disconnect histories via some mechanism that would put
a single branch name in that file instead of "--branches".)

> > The other problems are independent of whether you try to limit the
> > scope initially in such a manner:
> >
> > Are the testcases and the code requiring something for the feature
> > (ensuring the index and worktree are preserved) doing something that
> > is incompatible with the capabilities given to the user (allowing them
> > to edit the patch while splitting, so that they stage stuff that
> > wasn't part of the original commit)?  Or...is it assumed that the
> > split commits always "sum" to the changes in the original commit,
> > meaning the "other" patch immediately undoes those extra changes?
>
> Yes that's what's implemented. I think that makes sense for the "split"
> command. Often when splitting a commit one needs to make small changes
> to the diff in order for the result to compile but you still want the
> same end state from the sum of the split commits.

Makes sense; thanks for confirming.  I just didn't realize this was
the case while reviewing the patches until my response above.

> > I'm also worried about extended header handling for the edited
> > (reworded or split) commits.  That seems to have been overlooked in
> > this series, despite the fact that in early versions extended headers
> > were explicitly called out for the remainder of the commits being
> > replayed/rebased, so it seems interesting that they weren't considered
> > for the commits explicitly being edited.
>
> What headers does it make sense to copy when splitting a commit? When
> rewording it is more likely that copying the extended headers is what
> the user wants but the example of the "encoding" header you gave does
> not make sense to me as we re-encode the commit message and author data
> when the user edit's the message so we're not preserving the original
> encoding.

I agree that when rewording we probably want to copy most extended
headers, but you make a good point about encoding.  For splitting, I
agree it's less clear, and I'm not sure I know the answer.  But I
expected the topic to at least be discussed and mentioned in the
relevant commit messages.  It appears to have been silently
overlooked, and I'm worried it's the kind of topic that doesn't come
up often, meaning that if we don't discuss now and just pick whatever
behavior we get from implementation side-effects, then people will
come back in a year or two and point out we got it buggy but it's too
late to change it.

> > And I'm a bit surprised that the original commit message for a split
> > commit is automatically associated with the second commit; if I had
> > been forced to choose, I would have assumed it should be associated
> > with the first.
>
> I don't think it is safe to assume either - we should prompt the user to
> edit the message when creating both commits and seed the editor with the
> original message.

That sounds like a better solution to me for that particular issue,
and probably wouldn't be hard to implement.
