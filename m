Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99F31D14EC
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 10:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728298481; cv=none; b=LrQXAH1U88DCble6donBatRWllMbykbqBFgc3aHNal0BYIVlPZQEPX73Y2YniCboHDCe7psChjQhWjJjg6UJMx5PkjFBLeSZK2xv9W+ZN7/PgY2OTknYu06aBg19oNHWMRQtOV99w2OK2XsjOhGzdXPiDDsW49tjfSmVPhBLY5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728298481; c=relaxed/simple;
	bh=poei6eOb/rpS4EfNYQKnKHxnew7FD0WaDd/jgyVRxwk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Fzg0UazeQ39tQrhemxsPOipYXLJevNvIK0yTcsSV2VwSSZws+rbrkEtPz+0Gqo1sZN68gEXMW4qlPUD+l1L/ppfOE4oW/ifW0UIUYq/qXHCMp7kYmmCEqzm2K+PXXWYg/g5tT8+apRdhzYkJq2Q+m3rlsiuN7gA53vacw/pPNXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DmNXx0Do; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DmNXx0Do"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42cb0f28bfbso38720745e9.1
        for <git@vger.kernel.org>; Mon, 07 Oct 2024 03:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728298478; x=1728903278; darn=vger.kernel.org;
        h=mime-version:user-agent:disposition-notification-to:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=poei6eOb/rpS4EfNYQKnKHxnew7FD0WaDd/jgyVRxwk=;
        b=DmNXx0Do2vlpAwggAZ/BvPGZti+wuPm2RSc29nM1di+rwhuWsADl6Riq7vyu5Pcig/
         mSjTCx4UaYw06Ac0gSBLzBFHPiRoa3WoYBgJ11WOcEjM5XdTrPKLbaRavTyPP77ZOEgF
         owAxMet+XaT25ifSPKs6ZZdvKJy3VC2WXqQ2RyRa+BGrLbcpTNqOBBxKEag0EXIVkE7Y
         fr41K6+Cjkq+RjsNDgp+wFm1LXnpSJYkkbkS5xD4jBIEHDjzBAL7T/hutBJDtu+AyXX1
         TKi5uVcwDqHTWU7b74X7yz15xSl0RtBJYIqGXC/56pt0b66lftpG+NqWpq1AztcyqwGY
         ZU5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728298478; x=1728903278;
        h=mime-version:user-agent:disposition-notification-to:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=poei6eOb/rpS4EfNYQKnKHxnew7FD0WaDd/jgyVRxwk=;
        b=NZwKrc1Z1aOMcwqh4KAmLybLIuzSJ/IXj0LVCggzwXre1R3ucxv3N/YXFzBhj45fkp
         XPmv73CQk35L00laZJ8HN3ujR3GXBe5SQcusi/TUdSLmM2Ka/vC4xILmlshq+WwCnYkO
         JV5iSQEhSP1ohdbaS+N1BMAibLxhZNx6j/9RHuRUvpWKVn5elJPbjFe0ePUyr0xTjrPk
         dtXc0jHDtmV3kq21Xiot9yvFKCCkb/cUJ54xzk9HXAem0Iu70pP2do7p4o6FriPw9Jx5
         8xKWiUxaLGNUT3AQWjDDaQ+0HoLSvtD8KQSy9lYf7lA7fnvA5VMH4UPogpC42uRHJxcS
         ERUg==
X-Gm-Message-State: AOJu0YwjPAxnW9jXUDF/i+slKuO0DSNwUcxrS0rDZuezaW6l6AwJJ1VC
	tO9nkGEnMbZo+Ij8dB2nRFb0aIoVFNBeqnQI0mmbyU2bUib9Wg0=
X-Google-Smtp-Source: AGHT+IEYnVM/fdJlgh6CzMsKVJIczJ02qGsi8Z31gVaVFGhfSqTZOJPl64O0USrBCW9Mh2BLYcMskQ==
X-Received: by 2002:a05:6000:10a:b0:37c:c4f8:5e06 with SMTP id ffacd0b85a97d-37d0e6f26ffmr7082106f8f.20.1728298477964;
        Mon, 07 Oct 2024 03:54:37 -0700 (PDT)
Received: from ?IPv6:2001:8e0:3bcd:3801:111f:310d:9548:6f88? (2001-8e0-3bcd-3801-111f-310d-9548-6f88.bbcs.ip6.as8758.net. [2001:8e0:3bcd:3801:111f:310d:9548:6f88])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f86b4acddsm88609655e9.44.2024.10.07.03.54.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 03:54:37 -0700 (PDT)
Message-ID: <867f42bea10de470532d2f30eacceafa2b03d8de.camel@gmail.com>
Subject: Re: Bug: `git init` with hook `reference-transaction` running `git
 rev-parse --git-dir` fails
From: Gabriel =?ISO-8859-1?Q?N=FCtzi?= <gnuetzi@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>
Date: Mon, 07 Oct 2024 12:54:36 +0200
In-Reply-To: <ZwOVy4FltrEjxHn_@pks.im>
References: <0084cc18b6d90ba14849a7f788939f4a1d0d61c9.camel@gmail.com>
	 <ZwOVy4FltrEjxHn_@pks.im>
Autocrypt: addr=gnuetzi@gmail.com; prefer-encrypt=mutual;
 keydata=mDMEZkXiuBYJKwYBBAHaRw8BAQdAGuoC79ZXUA/zkkAgeLEElUIBjYsvKXPlkbWqF5RcZ
 q+0N0dhYnJpZWwgTsO8dHppIChFZDI1NTE5L0N1cnZlMjU1MTkpIDxnbnVldHppQGdtYWlsLmNvbT
 6IkwQTFgoAOxYhBPJPUqh3/IpkCoNuHfnjsP+dTnqBBQJmReK4AhsDBQsJCAcCAiICBhUKCQgLAgQ
 WAgMBAh4HAheAAAoJEPnjsP+dTnqBOsoBAMzBqtykviO+gsSRXCRLsoy2qtxZbZjR/ES9zZLTobhn
 AQDZJiTrILQTFNHNJ26NLVDM+Av+cjgeOezlCEcAa/N0Aw==
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-R0U6TTtXYk6wR7KTc6LS"
User-Agent: Evolution 3.52.4 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-R0U6TTtXYk6wR7KTc6LS
Content-Type: multipart/alternative; boundary="=-r+piPHaMgldTy71z8t/q"

--=-r+piPHaMgldTy71z8t/q
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Patrick,

Thanks for clarifications!
Could it work if for (2) -> call the reference-transaction hook after the H=
EAD has been initialized, meaning that Git would internally cache the
different reference transactions and then call the hooks in one go at once =
after the creation of the repo, such that it is initialized properly?
This might be probably a more elaborate change which introduces too many te=
chnicalities?

Gabriel

-----Original Message----- =20
**From**: Patrick Steinhardt <[ps@pks.im](mailto:Patrick%20Steinhardt%20%3c=
ps@pks.im%3e)> =20
**To**: Gabriel N=C3=BCtzi <[gnuetzi@gmail.com](mailto:Gabriel%20%3d%3fISO-=
8859-1%3fQ%3fN%3dFCtzi%3f%3d%20%3cgnuetzi@gmail.com%3e)> =20
**Cc**: [git@vger.kernel.org](mailto:git@vger.kernel.org), Karthik Nayak <[=
karthik.188@gmail.com](mailto:Karthik%20Nayak%20%3ckarthik.188@gmail.com%3e=
)> =20
**Subject**: Re: Bug: `git init` with hook `reference-transaction` running =
`git rev-parse --git-dir` fails =20
**Date**: 10/07/2024 10:03:30 AM

On Fri, Sep 20, 2024 at 12:07:53PM +0200, Gabriel N=C3=BCtzi wrote:

> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.
>=20
> What did you do before the bug happened? (Steps to reproduce your
> issue)
>=20
> I set `git config --global core.hooksPath ~/myhooks` and placed a
> `reference-transaction` hook in `~/myhooks/reference-transaction`
> with the content:
>=20
> ```shell
> #!/usr/bin/env bash
>=20
> set -e
> echo "$GIT_DIR"
> git rev-parse --absolute-git-dir
> ```
>=20
> then I ran
>=20
> ```shell
> mkdir ~/test && cd test
> git init
> ```
>=20
> What did you expect to happen? (Expected behavior)
>=20
> The Git repo `~/test` should have been initialized (and the hook
> `reference-transaction` would have passed successfully.)
>=20
>=20
> What happened instead? (Actual behavior)
>=20
> The hook `reference-transaction` crashes since `git rev-parse --
> absolute-git-dir` with
> ```
> failed: not a git repository: ...
> ```
>=20
> What's different between what you expected and what actually happened?
>=20
> The documentation says that `git rev-parse --absolute-git-dir` inside
> the `reference-transaction` hooks read "$GIT_DIR" if defined (which is
> defined!) so the `reference-transaction` should have passed. I assume
> that hooks should be executed on properly initialized repositories,
> right? Therefore I do not understand why `git rev-parse --absolute-git-
> dir` fails -> Bug?
>=20
> Anything else you want to add:
>=20
> This came up with `Githooks` hooks manager
> [https://github.com/gabyx/Githooks](https://github.com/gabyx/Githooks)=C2=
=A0where we use this command
> to locate the current Git dir...
>=20
> Please review the rest of the bug report below.
> You can delete any lines you don't wish to share.


Thanks for your bug report, and sorry for taking so long to respond. =20
Reproducing the observed behaviour is quite simple:

=C2=A0=C2=A0=C2=A0 test_expect_success 'git-init with global hook' ' =20
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 test_when_finished "rm -rf hooks=
 repo" && =20
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mkdir hooks && =20
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 write_script hooks/reference-tra=
nsaction <<-EOF && =20
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 git rev-parse --absolute-git-dir=
 >>"$(pwd)/reftx-logs" =20
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 EOF =20
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 test_config --global core.hooksP=
ath "$(pwd)/hooks" && =20
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 git init repo =20
=C2=A0=C2=A0=C2=A0 '

This breakage is new in Git v2.46 and comes from the patch series that =20
introduces support for symbolic refs in the reftx hook via a8ae923f85 =20
(refs: support symrefs in 'reference-transaction' hook, 2024-05-07) . =20
Before that change we didn't execute the hook for "HEAD" in the first =20
place, now we do.

Now the question is whether this is a bug or not. When the reftx hook =20
executes the first time it is when we are creating the "HEAD" ref in =20
the repo. Consequently, that file did not yet exist beforehand. And as =20
Git only considers something a repository when the "HEAD" file exists it =
=20
rightfully complains that this is not a valid Git repository when you =20
ask it to resolve the repo paths. So conceptually, the behaviour here is =
=20
correct.

There are two ways we could fix this that I can think of:

=C2=A0 - We can create a dummy "HEAD" file with invalid contents such that =
we =20
=C2=A0=C2=A0=C2=A0 do have a proper Git repository when creating "HEAD". It=
 feels like =20
=C2=A0=C2=A0=C2=A0 a bit of a hack though, but we play similar games in git=
-clone(1).

=C2=A0 - We can skip execution of the "reference-transaction" hook during =
=20
=C2=A0=C2=A0=C2=A0 initialization of the repository. But this would make us=
 miss some =20
=C2=A0=C2=A0=C2=A0 ref updates, which feels conceptually wrong.

I'd rule out (2), but (1) could be feasible if we label this a bug. I'm =
=20
not a 100% sure whether we should, as you could also argue that this is =
=20
reflecting the actual state of the repo. I'd be happy to hear arguments =
=20
in either direction.

Also Cc'd Karthik, the author of the menitoned change.

Patrick

--=-r+piPHaMgldTy71z8t/q
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<p>Hi Patrick,</p>
<p>Thanks for clarifications!
Could it work if for (2) -&gt; call the reference-transaction hook after th=
e HEAD has been initialized, meaning that Git would internally cache the
different reference transactions and then call the hooks in one go at once =
after the creation of the repo, such that it is initialized properly?
This might be probably a more elaborate change which introduces too many te=
chnicalities?</p>
<p>Gabriel</p>
<p>-----Original Message-----<br />
<strong>From</strong>: Patrick Steinhardt &lt;<a href=3D"mailto:Patrick%20S=
teinhardt%20%3cps@pks.im%3e">ps@pks.im</a>&gt;<br />
<strong>To</strong>: Gabriel N=C3=BCtzi &lt;<a href=3D"mailto:Gabriel%20%3d=
%3fISO-8859-1%3fQ%3fN%3dFCtzi%3f%3d%20%3cgnuetzi@gmail.com%3e">gnuetzi@gmai=
l.com</a>&gt;<br />
<strong>Cc</strong>: <a href=3D"mailto:git@vger.kernel.org">git@vger.kernel=
.org</a>, Karthik Nayak &lt;<a href=3D"mailto:Karthik%20Nayak%20%3ckarthik.=
188@gmail.com%3e">karthik.188@gmail.com</a>&gt;<br />
<strong>Subject</strong>: Re: Bug: <code>git init</code> with hook <code>re=
ference-transaction</code> running <code>git rev-parse --git-dir</code> fai=
ls<br />
<strong>Date</strong>: 10/07/2024 10:03:30 AM</p>
<p>On Fri, Sep 20, 2024 at 12:07:53PM +0200, Gabriel N=C3=BCtzi wrote:</p>
<blockquote type=3D"cite">
<p>Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.</p>
<p>What did you do before the bug happened? (Steps to reproduce your
issue)</p>
<p>I set <code>git config --global core.hooksPath ~/myhooks</code> and plac=
ed a
<code>reference-transaction</code> hook in <code>~/myhooks/reference-transa=
ction</code>
with the content:</p>
<pre><code class=3D"language-shell">#!/usr/bin/env bash

set -e
echo &quot;$GIT_DIR&quot;
git rev-parse --absolute-git-dir
</code></pre>
<p>then I ran</p>
<pre><code class=3D"language-shell">mkdir ~/test &amp;&amp; cd test
git init
</code></pre>
<p>What did you expect to happen? (Expected behavior)</p>
<p>The Git repo <code>~/test</code> should have been initialized (and the h=
ook
<code>reference-transaction</code> would have passed successfully.)</p>
<p>What happened instead? (Actual behavior)</p>
<p>The hook <code>reference-transaction</code> crashes since <code>git rev-=
parse -- absolute-git-dir</code> with</p>
<pre><code>failed: not a git repository: ...
</code></pre>
<p>What's different between what you expected and what actually happened?</=
p>
<p>The documentation says that <code>git rev-parse --absolute-git-dir</code=
> inside
the <code>reference-transaction</code> hooks read &quot;$GIT_DIR&quot; if d=
efined (which is
defined!) so the <code>reference-transaction</code> should have passed. I a=
ssume
that hooks should be executed on properly initialized repositories,
right? Therefore I do not understand why <code>git rev-parse --absolute-git=
- dir</code> fails -&gt; Bug?</p>
<p>Anything else you want to add:</p>
<p>This came up with <code>Githooks</code> hooks manager
<a href=3D"https://github.com/gabyx/Githooks">https://github.com/gabyx/Gith=
ooks</a>=C2=A0where we use this command
to locate the current Git dir...</p>
<p>Please review the rest of the bug report below.
You can delete any lines you don't wish to share.</p>
</blockquote>
<p>Thanks for your bug report, and sorry for taking so long to respond.<br =
/>
Reproducing the observed behaviour is quite simple:</p>
<p>=C2=A0=C2=A0=C2=A0 test_expect_success 'git-init with global hook' '<br =
/>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 test_when_finished &quot;rm -rf =
hooks repo&quot; &amp;&amp;<br />
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mkdir hooks &amp;&amp;<br />
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 write_script hooks/reference-tra=
nsaction &lt;&lt;-EOF &amp;&amp;<br />
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 git rev-parse --absolute-git-dir=
 &gt;&gt;&quot;$(pwd)/reftx-logs&quot;<br />
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 EOF<br />
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 test_config --global core.hooksP=
ath &quot;$(pwd)/hooks&quot; &amp;&amp;<br />
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 git init repo<br />
=C2=A0=C2=A0=C2=A0 '</p>
<p>This breakage is new in Git v2.46 and comes from the patch series that<b=
r />
introduces support for symbolic refs in the reftx hook via a8ae923f85<br />
(refs: support symrefs in 'reference-transaction' hook, 2024-05-07) .<br />
Before that change we didn't execute the hook for &quot;HEAD&quot; in the f=
irst<br />
place, now we do.</p>
<p>Now the question is whether this is a bug or not. When the reftx hook<br=
 />
executes the first time it is when we are creating the &quot;HEAD&quot; ref=
 in<br />
the repo. Consequently, that file did not yet exist beforehand. And as<br /=
>
Git only considers something a repository when the &quot;HEAD&quot; file ex=
ists it<br />
rightfully complains that this is not a valid Git repository when you<br />
ask it to resolve the repo paths. So conceptually, the behaviour here is<br=
 />
correct.</p>
<p>There are two ways we could fix this that I can think of:</p>
<p>=C2=A0 - We can create a dummy &quot;HEAD&quot; file with invalid conten=
ts such that we<br />
=C2=A0=C2=A0=C2=A0 do have a proper Git repository when creating &quot;HEAD=
&quot;. It feels like<br />
=C2=A0=C2=A0=C2=A0 a bit of a hack though, but we play similar games in git=
-clone(1).</p>
<p>=C2=A0 - We can skip execution of the &quot;reference-transaction&quot; =
hook during<br />
=C2=A0=C2=A0=C2=A0 initialization of the repository. But this would make us=
 miss some<br />
=C2=A0=C2=A0=C2=A0 ref updates, which feels conceptually wrong.</p>
<p>I'd rule out (2), but (1) could be feasible if we label this a bug. I'm<=
br />
not a 100% sure whether we should, as you could also argue that this is<br =
/>
reflecting the actual state of the repo. I'd be happy to hear arguments<br =
/>
in either direction.</p>
<p>Also Cc'd Karthik, the author of the menitoned change.</p>
<p>Patrick</p>

--=-r+piPHaMgldTy71z8t/q--

--=-R0U6TTtXYk6wR7KTc6LS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTyT1Kod/yKZAqDbh3547D/nU56gQUCZwO97AAKCRD547D/nU56
ga9BAP4x8UxQAHkvRT4LtFJOjxLBTap9keD1nCoqiXpFcj18xwD8Dx1awF4ht2dw
Pd+JUZE8pynqbXwNiRFamEz9SeOESgU=
=2lj6
-----END PGP SIGNATURE-----

--=-R0U6TTtXYk6wR7KTc6LS--
