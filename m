Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8761CA80
	for <git@vger.kernel.org>; Fri, 31 May 2024 20:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717188230; cv=none; b=RV3+pk8vnLdXA3pcXYCGExstqC8g+Wjb+JifsSu7wb5v9AIeruHgvmRLR9Irm6zKJ9nGBfFYBpSbP87IcRbaqUt6bJ3VWry4ZA0845JgCAu8JBdHqh41Nexn8IkMqbYDsuLaAuKfCoYa6RS96lX6U5dYDEEQSnJaIwSBdybA7yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717188230; c=relaxed/simple;
	bh=fA6m96IKF5ccceZMR/MbKO3jjU0hlFmlGmM5kjxINdg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aa/NYcj3h7hKtQ7LEaNPzvxmBgTuQIf8QFqBnWyAIJe9SGhz7KLtCwAR2CPqPIhe5EXuoQW4I5d6LCEMTwVvNCzHBbf08r1VXfqctrjd156NEHza4416iXO2VggUqhSTgpDh0J1FJ3AARzeHpNrAZcxHp+fbJczggJN90YtM6s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L7d3fzrD; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L7d3fzrD"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42101a2ac2cso14621975e9.0
        for <git@vger.kernel.org>; Fri, 31 May 2024 13:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717188227; x=1717793027; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d1bVS2YTUFJ/D+p1tNs0VOfeGnx5fRpIkdxKLkZqIqw=;
        b=L7d3fzrDd2006wjmMBR2/cQlp/HXRA9YkQRc7+0tf63Km+o6QqhWyIDM44YlV5RZXZ
         k0w1HcKA0SxydxI4FErxi6j7jy66YJdwP3KoHOaTPasjm5MrRvikMSyLqdonzFipPb30
         BBSGG6LEeLHt0imk2yorMOlMILMeqhgwZT6+rmgUDlgNIRFUiNdBP2wAfolMBXXfdTWq
         fxSbURK2sM0pABLbLZGdhiwk6mSFuDguFVchg6dnkQY+T+fDB0g5WP6MJ/kaB1qkyg8S
         4Ebz5IdLawxoIWXfFAfCcemZ0Set+PqCKrGP45Qe2mBRme1dhRtjU/neboIUZbbjPZB2
         IUyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717188227; x=1717793027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d1bVS2YTUFJ/D+p1tNs0VOfeGnx5fRpIkdxKLkZqIqw=;
        b=kc0BfIlunddWYUmGvzzt9uf2EzbSXX7NRqjGaFwtV9Of5V6pjEp/YJhGe2yvCLrK1M
         oTptch5StsXqmXx3FLDGo2ZN6c4NpdXriavH4pTlAGW3v5Wz5Rz16rBa94Qb46XLiz+1
         UV3o3iPaWAcjFXnFWbliEHaKqDF0lToRzF5boReZ5T3RB8HrAeDLxmB4Q1te5zhR1eZL
         SnUISYrq35AXDd0gv+gEb3lpcxaL9OMdpRJjzecCJAr/Y9JoK8JjCm8xH0ftvt5wowhC
         CfeJLycbwVKXJfOb93rFY5ndSnRlemEbIX+hEvyl3aSQpmLsyGlIrf865NiF+4LXrrMA
         CoaQ==
X-Gm-Message-State: AOJu0YwUynJ2usCn9oijSpII4m/PTEzAs8jzoOnFQE1whV+Llu2RoFCZ
	fL8DWAwuKVYYA305cA+DkowoHHFZp8WHgLZLHAjdHA1RqnrWjjUmZ6vogbCYPikRTJeFiPdADlv
	DF8fYrC69vOxz8IYznYHpV/o5aFeT5p9I
X-Google-Smtp-Source: AGHT+IGWAp9vwHI07x/rKThWpxT8NxSpAIbej66tHInhBGhE23qtwb32wdA6CfQPQBWMR2rsq+QVzRiYQEsZvseCUjk=
X-Received: by 2002:a05:600c:4eca:b0:420:1067:d698 with SMTP id
 5b1f17b1804b1-4212e08b875mr21544215e9.23.1717188226529; Fri, 31 May 2024
 13:43:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20221012135114.294680-1-christian.couder@gmail.com>
 <20240515132543.851987-1-christian.couder@gmail.com> <20240515132543.851987-4-christian.couder@gmail.com>
 <xmqqv83fvw7p.fsf@gitster.g> <CAP8UFD1JZ7eJzrTk1YPrfy1XLAnnLvukABOJE69-JbqVWtL1AQ@mail.gmail.com>
 <xmqqjzjikhdz.fsf@gitster.g> <CAP8UFD1_aHwbhF12v-miCTWEbbgjtpjTCmkRmFHu4Vusezq6dA@mail.gmail.com>
 <xmqq34q27wzg.fsf@gitster.g>
In-Reply-To: <xmqq34q27wzg.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Fri, 31 May 2024 22:43:33 +0200
Message-ID: <CAP8UFD18Y=NhnnzcHoBOiO7bu_VrxnHOeLgUeqiADQPcgtMW=A@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] upload-pack: allow configuring a missing-action
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, John Cai <johncai86@gmail.com>, 
	Patrick Steinhardt <ps@pks.im>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2024 at 5:54=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Christian Couder <christian.couder@gmail.com> writes:

> > "it would be nice if there was a capability for the client to say
> > that it would like the server to give it information about the
> > promisor that it could use, so that the user doesn't have to pass all
> > the "remote.my_promisor.XXX" config options on the command like."
> >
> > and by saying that this could be added later.
>
> Can such an update happen transparently, or does it need changes to
> end-user experience?  It is of dubious value to leave the initial
> series be incomplete if the latter is the case.

I think adding the capability could happen transparently. I think the
capability should be a generic one about the server suggesting some
config options and perhaps some command line options, and the client
agreeing (or not) to setting the config options and using the command
line options that the server suggests. Of course the important thing
when implementing this capability is to properly limit the config and
command line options (and perhaps their values) that the client
accepts to set and use. But I think it could be a generic capability
that could be extended to other options in the future. That's why I
think it could be a separate patch series.

> >> Without knowing that, it cannot safely decide that it does not
> >> have to send objects that can be obtained from X to C.
> >
> > In the above command C is asking for a partial clone, as it uses a
> > --filter option. This means that C knows very well that it might not
> > get from S all the objects needed for a complete object graph.
>
> Hmph.  If C asks a partial clone and S is willing to be the promisor
> for C, S is essentially saying that it will serve C any objects on
> demand that are reachable from any object it served C in the past,
> forever, no?  It might not get from S initially all the objects, but
> if it wants later, S promises to let C have them.

This promise is not broken, as S can still get the missing objects
from X and then pass them to C. There is even the following test case
in the patch that shows that it works when uploadpack.missingAction is
unset (and thus default to "error" which is the same as how things
currently work):

+test_expect_success "fetch without uploadpack.missingAction=3Dallow
-promisor" '
+       git -C server config --unset uploadpack.missingAction &&
+
+       # Clone from server to create a client
+       GIT_NO_LAZY_FETCH=3D0 git clone -c remote.server2.promisor=3Dtrue \
+               -c remote.server2.fetch=3D"+refs/heads/*:refs/remotes/serve=
r2/*" \
+               -c remote.server2.url=3D"file://$(pwd)/server2" \
+               --no-local --filter=3D"blob:limit=3D5k" server client &&
+       test_when_finished "rm -rf client" &&
+
+       # Check that the largest object is not missing on the server anymor=
e
+       check_missing_objects server 0 ""
+'

The only difference with the case when uploadpack.missingAction is set
to "allow-promisor" is that then C gets the missing objects directly
from X without S getting them first. This is why there is:

+       # Check that the largest object is still missing on the server
+       check_missing_objects server 1 "$oid"

at the end of the test case when uploadpack.missingAction is set to
"allow-promisor". This is to check that S didn't get the missing
object (which means that the missing object went directly from X to
C).

So S keeps its promise to let C have any object through S if C wants.
It's just that having large objects through S (instead of directly
from X) is not a good idea because it copies the large objects to S
first which uses up space (and memory and CPU when creating packfiles)
on S while the objects are already on X where disk space is probably
cheaper (and where less CPU and memory will be used to send the
objects).

> > Again when using a regular partial clone omitting the same set of
> > objects, C also requests some objects that S doesn't have.  And
> > this is not considered an issue or something irresponsible. It
> > already works like this.
>
> "S doesn't have" is because S has pruned objects that it shouldn't
> have in order to keep the promise it made earlier to C, right?  If
> that is the case, I would very much say S is being irresponsible in
> that case.

Yes, S has pruned some objects, but these objects have been moved to X
first and S has access to X, so S can still get the objects. So I
don't understand why you say S shouldn't have pruned them and S is
irresponsible. S is still capable of fulfilling the promise it made.

And even if S was not capable of directly fulfilling the promise it
made, it would still not be clear to me that S is irresponsible, as S
and X can be seen as a single entity from the client point of view,
and S and X together would still be capable of fulfilling the promise
that was made to C.

When bundle-uri is used, for example, the server is not fulfilling the
promise alone. It needs the bundle server to work properly for the
client to get everything. When using Git LFS, the server is not
fulfilling the promise alone either. For things to work properly both
the Git server and the LFS server have to work together.

So if it's Ok for other features to require an additional server to
fulfill the promise, why is it not Ok in the case of S + X?

> > And then C still has the possibility to configure X as a
> > promisor remote and get missing objects from there. So why is it Ok
> > when it's done in several steps but not in one?
>
> You are right that S can decide to unilaterally break the promise it
> made C, so this update is not making it any worse than giving users
> a broken implementation of promisor remotes.  I wouldn't call it OK,
> though.

I don't understand why you compare this to a "broken" implementation
of promisor remotes. What could then be a non-broken one that would
store large blobs on a separate server in your opinion? I am really
interested in answers to this question. It's not a rhetorical one.

> If somebody identifies that even without this series, S can lead to
> repository corruption at C by pruning objects it does need to keep
> its promise to C,

Objects are not pruned if you consider S + X instead of just S. It's
the same as when people are using Git LFS or bundle-uri. Nothing is
really pruned on the server side, no promise is broken. Some objects
are just moved to a separate server that is sometimes called to
provide some objects on top of those the Git server still sends.

> the next action I expect from healthy project is
> to try coming up with a mechanism to make it less likely that such a
> pruning happens by accident

When people managing server S decide to move some objects to X and make S
access X, it's not accidental pruning. But maybe you are talking
about the case when uploadpack.missingAction is set to "allow-any"
instead of "allow-promisor"?

> (e.g., by noticing allowAnySHA1InWant as
> a sign that the repository has promised others to serve anything
> that used to be reachable from anything it historically served,
> disabling repack "-d" and instead send the currently unreachable
> objects to an archived pack, and something equally silly like that).
> It certainly is not to add a new mechanism to make it even easier to
> configure S to break promised it made to C.

This new mechanism has some important benefits. Yes, there are risks,
but it's our opinion at GitLab, with some data from GitLab servers
(see the link I previously sent to a GitLab issue) to back it up, that
the rewards are well worth the added risks.

I agree that ideally a Git server should be able to handle every kind
of object very well, but that's unfortunately not the case. Git LFS
has some drawbacks, bundle-uri also has some drawbacks, but there are
reasons why they exist. Multiple promisor remote is a solution that
already exists in Git too. Yes, it also has some drawbacks, but they
are in many ways similar to those of bundle-uri and Git LFS. Yes, this
patch is making multiple promisor remotes easier to use, but it
doesn't fundamentally change the risks associated with using multiple
promisor remotes.
