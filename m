Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A60012B7F
	for <git@vger.kernel.org>; Thu, 25 Jul 2024 16:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721923409; cv=none; b=GLwZISD0QN7dZoN1+pmfA0T80DU7Za7cjkPnQea/u4WwtyxIQN+XflhHufI2JZqDMf/WeJsAt3Zu0fXEsHXwAFWJJcb1WRdbqxZD1TVkWL2/IWqCn4ybxiYWjxUVClAXomSQC0fWs1rMxbDWomlT6YFbD/a4nAh/Jx38uJTH4eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721923409; c=relaxed/simple;
	bh=JliCH8kSVovoxHaP5fxQvd29Z1PEu8CF7naukc/5FQo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TeUYtoXC2vTSHdoX1DAQKyuONBAiH3Amzoqw4+97sj8haFMDI3JZTcZnj+Y+9fKoVrAu1cb4xiW3kLOCVBe+qygzdogvSBmVKVL1Wde8uC8F+gvuWEorUk4LZK4KnwxUzclYDiFicJIGE27TEiCo2bS7cYCdWOT5bQ346sfpabA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mDgJVJDX; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=UZtdxct+; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mDgJVJDX; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=UZtdxct+; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mDgJVJDX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UZtdxct+";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mDgJVJDX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UZtdxct+"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A47121F7F1;
	Thu, 25 Jul 2024 16:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721923405; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ya8+rR8vqFqY/M/bMZP0avMJRUvzy+6YyenD7ijKF5w=;
	b=mDgJVJDX7fSZkob4yCIlS8S64h9R+D+roOGHQcCTSv8M0BBoK9f3KQgNpFiH7su4QLVWWk
	x1yMkJXtJyGfGBQ8SgAdJaDJcP/RwQ3Bby0A1KAlKONUIyIuO3LgLG5Ix47u2vrE8y15JA
	6GYQlLJ7Y+AvObBfhyE6mIlEzv0Js8U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721923405;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ya8+rR8vqFqY/M/bMZP0avMJRUvzy+6YyenD7ijKF5w=;
	b=UZtdxct+hHfE3Y1JgVrrGl0u/E5QgFnwMzREkZTTiX+nV6qgJqlD0AKta/uC72YLW5yiNe
	PVuAOpcG9tI0JVAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721923405; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ya8+rR8vqFqY/M/bMZP0avMJRUvzy+6YyenD7ijKF5w=;
	b=mDgJVJDX7fSZkob4yCIlS8S64h9R+D+roOGHQcCTSv8M0BBoK9f3KQgNpFiH7su4QLVWWk
	x1yMkJXtJyGfGBQ8SgAdJaDJcP/RwQ3Bby0A1KAlKONUIyIuO3LgLG5Ix47u2vrE8y15JA
	6GYQlLJ7Y+AvObBfhyE6mIlEzv0Js8U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721923405;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ya8+rR8vqFqY/M/bMZP0avMJRUvzy+6YyenD7ijKF5w=;
	b=UZtdxct+hHfE3Y1JgVrrGl0u/E5QgFnwMzREkZTTiX+nV6qgJqlD0AKta/uC72YLW5yiNe
	PVuAOpcG9tI0JVAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1E0841368A;
	Thu, 25 Jul 2024 16:03:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zuYxBE13omYgMwAAD6G6ig
	(envelope-from <ddiss@suse.de>); Thu, 25 Jul 2024 16:03:25 +0000
Date: Thu, 25 Jul 2024 18:03:22 +0200
From: David Disseldorp <ddiss@suse.de>
To: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
Cc: "Teng Long" <dyroneteng@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/2] t3301-notes: check editor isn't invoked for empty
 notes add
Message-ID: <20240725180322.5b6d3a0d.ddiss@suse.de>
In-Reply-To: <5fdccb84-1e60-477e-99d9-b22e3ef83f54@app.fastmail.com>
References: <20240725144548.3434-1-ddiss@suse.de>
	<20240725144548.3434-2-ddiss@suse.de>
	<5fdccb84-1e60-477e-99d9-b22e3ef83f54@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Level: 
X-Spamd-Result: default: False [-0.10 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -0.10

On Thu, 25 Jul 2024 17:52:25 +0200, Kristoffer Haugsbakk wrote:

> Hi
>=20
> On Thu, Jul 25, 2024, at 16:41, David Disseldorp wrote:
> > 90bc19b3ae ("notes.c: introduce '--separator=3D<paragraph-break>' optio=
n")
> > changed note_data.given logic such that it's no longer set if a zero
> > length file or blob object is provided. =20
>=20
> This project uses the `git show -s --pretty=3Dreference` format:
>=20
>     90bc19b3ae (notes.c: introduce '--separator=3D<paragraph-break>'
>     option, 2023-05-27)

Okay, will fix in a subsequent version.=20

> >  t/t3301-notes.sh | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
> > index 536bd11ff4..c0dbacc161 100755
> > --- a/t/t3301-notes.sh
> > +++ b/t/t3301-notes.sh
> > @@ -1557,4 +1557,9 @@ test_expect_success 'empty notes are displayed by
> > git log' '
> >  	test_cmp expect actual
> >  '
> >
> > +test_expect_success 'empty notes do not invoke the editor' '
> > +	test_commit 18th &&
> > +	GIT_EDITOR=3D"false" git notes add -C "$empty_blob" --allow-empty
> > +'
> > +
> >  test_done
> > --
> > 2.43.0 =20
>=20
> This test fails, obviously. Maybe you can reorder the patches so that
> both two patches pass the test suite?
>=20
> Introducing a regression test in one patch and then fixing the bug (and
> making the test pass) in the next patch is a style that some prefer. But
> I have received feedback before that it=E2=80=99s best to avoid that.

Makes sense, thanks for the feedback.
