Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A391FA2
	for <git@vger.kernel.org>; Thu, 21 Mar 2024 02:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710986687; cv=none; b=uNaeNLRvcpHXMeOn9wHGbwI4dNvUCaxP24YUyppoDSWPqLHE6AstPffLLrt+NlFvz21/+QoS2GaCSpEwbB3Yz9DllE7qXwzlKcJjV9nH3bobq4VgTXWAIvxbuog3QCpAeLNVu4jDcyo9t7EXNdqr/AioBHQrvnem9+oEzl2333k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710986687; c=relaxed/simple;
	bh=3P2Rs9W4hvB13SPTQdhTR2r2nXgFM8sgBy2JhYB5tzs=;
	h=MIME-Version:From:To:In-Reply-To:Cc:Subject:Message-ID:Date:
	 Content-Type; b=N2P9yw18AkMWuBw7GlRUGKg28VaTBb4UoSe2bLVTXh9hqIcWRikOW/LdqKjDg4T9YcypLb29o2Q1xruTGRP7/sRa+NGooC5fv68+pW8/P+WuYeBxschqwJyqkc2gT04bA1fvfPNUlcCJFUtEIsdQCROrPEnjCS5Qd2+3vzfx9Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UQlb5MF+; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UQlb5MF+"
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-7e0c7acdd23so88461241.3
        for <git@vger.kernel.org>; Wed, 20 Mar 2024 19:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710986684; x=1711591484; darn=vger.kernel.org;
        h=content-transfer-encoding:date:message-id:subject:cc:in-reply-to:to
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=D3+SKL8ma2IUHQdy4oF9zzswh1pioRlfGCRi9voPtYg=;
        b=UQlb5MF+7WVOFM3tiGdYb0Vc1w/gxnoe2Ou6IQLRU5bhjKjmGWFIJscr+um3LWXG8f
         P3pphibcQIgxaoBFJpURRg4j4x6mjzERBPzg4tswKi43488z+opWPd3MRElfGxxVSZ0Y
         GqMfpKPsbiUXwtK2IQvkTfYOopz7cFGGvh6sn/nWJqGB3YXfixOm5F0xvMG2fk9T+I7Q
         jds6hFaGfJU3V8r9ltBhBKqc/OvF9vUC/+QM6zxC5yhBJ+yBrA42Jm8xuOwUQn8CmHiQ
         sJKiY9VxuqRG8oLprS9PNNVWrvHUMuGNdNqWj9wwCnAzOk8Lrz7/9aGLHVwBuU03jvyu
         oRlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710986684; x=1711591484;
        h=content-transfer-encoding:date:message-id:subject:cc:in-reply-to:to
         :from:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D3+SKL8ma2IUHQdy4oF9zzswh1pioRlfGCRi9voPtYg=;
        b=LZ2la2yJa8iPh3LD9eveY8zaW8zUXk6erg4fd4z8TmwaQOJKpWXmgAuDeOr6Ltk5Nl
         3Iq0qfzksyS3A4yq9XugCj67cJdQ2hvk2l0zTjW5P+2+AoN4Gra4f9fHMooOd//mVkue
         3vIR3QZXNHPb005XavVlWyewV/dFlGkhYMxGABl3cy6myJR5C03SPfecw64YhuKLgj3r
         tfhUuQZZihJBEZ7wjplYjPDYJqmchWaHK3sQWIxJmPVrnVxzNTQOVsw8yD5Pb8L1TVGE
         Qzy7gX6CU3oQFXPAOEg2M6rSFYKOEz1iAxib5VZ7X9fXpJYQy6UFKanZorkKYliopJ92
         ekpg==
X-Gm-Message-State: AOJu0YxC/yWLs4iOeKXUzQu29lcImlrNWswgDALdQxgGVx8PPHO7rJyH
	IQsgqQ8fbGaZ1Cw/4KaVxTnq+iqXD28O/dSZETWhkCErUMXXZd5LnYrSBppNaz8=
X-Google-Smtp-Source: AGHT+IEI2CsPFIlUHxz1bk7pdFj6Bxxk1guoxOc0cYw7LlDvrwku9C95lp/27zGm4B6XlfSQSmWxYw==
X-Received: by 2002:a05:6122:4b0c:b0:4d4:4ef8:2fb5 with SMTP id fc12-20020a0561224b0c00b004d44ef82fb5mr560787vkb.13.1710986684038;
        Wed, 20 Mar 2024 19:04:44 -0700 (PDT)
Received: from zivdesk (047-034-027-162.res.spectrum.com. [47.34.27.162])
        by smtp.gmail.com with ESMTPSA id p15-20020a05620a22ef00b00789fa594de5sm3858208qki.80.2024.03.20.19.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 19:04:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Brian Lyles" <brianmlyles@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
In-Reply-To: <xmqqfrwke57g.fsf@gitster.g>
Cc: <git@vger.kernel.org>, <phillip.wood123@gmail.com>, 
	"=?utf-8?Q?Jean-No=C3=ABl_AVILA?=" <jn.avila@free.fr>
Subject: Re: What's cooking in git.git (Mar 2024, #05; Tue, 19)
Message-ID: <17bea552bb182325.70b1dd9aae081c6e.203dcd72f6563036@zivdesk>
Date: Thu, 21 Mar 2024 02:04:43 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 8:36=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:

> "Brian Lyles" <brianmlyles@gmail.com> writes:
>=20
>> I think some more official process could be beneficial. As it is, I'm
>> wholly unaware of the current process for creating release notes for
>> git. Do the maintainers simply review merged changes and write release
>> notes as part of cutting a release?
>=20
> A few things.  There is only one maintainer.

Got it -- that certainly provides some good context.

> [...] There are development
> community members, who act as contributors and as reviewers.  The
> maintainer manages how the 'master' branch and other integration
> branches advance, and a part of it is to update the release notes.

From looking at the history of "master", it looks like you take batches
of merges and update the patch notes as part of merging each batch in.
Also good to understand.
=20
> Documentation/howto/maintain-git.txt outlines the workflow the
> current maintainer has adopted, and it has a brief mention on the
> "What's cooking" report.  These days, entries in the the release
> notes for each topic merged are mostly copied from "What's cooking"
> but currently, as the "howto/maintain-git" document describes,
> summarizing and maintaining these topic descriptions is done by the
> maintainer.

So presumably, a contributor that wanted to see the "final form" of the
release notes for their patch would need to keep an eye on "What's
cooking" and/or 'next' and raise any concerns to the list at that point?=20

> In the message you responded to, I was wondering if we can
> distribute the load even further to have original author of each
> topic write the initial draft of the one-paragraph description of
> the topic that will go in "What's cooking".

I definitely think that it makes sense for the original author to write
*something*.

> [...] Two obvious downsides
> are that having people write about their own work would may make the
> result harder to read, as they inevitably are biased by the
> importance of their own work ;-)

Yes, this is certainly a possibility. That said, one big advantage of
incorporating this as part of the patch submission (one way or another)
might be that more people will see and have a chance to review the
release notes as part of their normal review of the patch.

> [...] and having many people write
> different entries may lose the consistent voice across topics being
> described, but the distribution of burden is certainly attractive.

It seems that this is not much different from maintaining a consistent
voice across commit messages. Those expectations are well documented,
and commit messages are reviewed thoroughly as part of patch review. I
expect that we could see similar success for the release notes.

>> This way, the
>> contributor of a series is responsible for creating the changelog entry
>> (or entries) rather than the maintainer, which can help avoid
>> inaccuracies from a maintainer with less familiarity trying to
>> summarize.
>=20
> It however cuts both ways.
>=20
> Trying to coming up with a summary from what I can read from the
> discussion and the log messages is a good opportunity to find what
> is still unclear in the log messages of the commits in the topic.
> Not all contributors can write a good summary of their own work in a
> way that are suitable for the audience of the release notes.  Also
> you would want to encourage the maintainer to familiarize with the
> topics to be able to summarize them, instead of keeping them in the
> dark by doing the release notes entries yourself.

I do see the benefit here, and if the maintainer wants to continue
accepting that burden, power to them ;). I certainly would not want
contributor-authored release notes to replace the maintainer being
familiar with ongoing changes.

That said, it would seem that we could have our cake and eat it too --
the maintainer may still choose to familiarize themself with the topics
however they wish, and simply validate the release notes instead of
needing to write them from scratch. Though perhaps in practice, it is
difficult to do so without some additional bias as well.

In any case, for what it's worth: as a contributor, I would certainly be
willing to take on some additional burden as part of submitting a patch
to ensure that my patch is well represented in the release notes. If it
happens to reduce the burden on the maintainer as well, even better!

--=20
Thank you,
Brian Lyles
