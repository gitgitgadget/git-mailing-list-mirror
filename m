Received: from aib29agh123.zrh1.oracleemaildelivery.com (aib29agh123.zrh1.oracleemaildelivery.com [192.29.178.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D773BBC1
	for <git@vger.kernel.org>; Fri, 20 Sep 2024 13:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726840301; cv=none; b=iMYGwdXva5by8jT8lcLWaat0ewi2VMMHwvJigfMLRp9TJvLkAUxLXS3Y6Wil13Y/gQad8lQKjRzWvye5eEmJj19aJ7GjI6ZOh97lg3r59R400V0R1jQd7NjtTOZ83whTfpvDTpgVN2VsaELpvvNuFEvRuTDHb483MqrcDrwgy34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726840301; c=relaxed/simple;
	bh=Q3L+EJPq2vzbSot8YfwI5mcn+g76BLzGS+6T/zW+X2Y=;
	h=MIME-version:Content-type:Date:Message-id:Subject:Cc:To:From:
	 References:In-reply-to; b=NKs8EWEXBApXKxqVXMLkTA3wjKYJIh3TbjMiNl4J8aWzEUMzKr2xzwXkYlvZ6BA984qnE8oaLvdGtU+NgUIcBq06GQ5M3qZV2BTBqvteYsp0+gRa/vfIDFwIZvbt2JMR/I3FSRWbpEAUQMFfGX7BdOtSV6Dhc4/BSLhQq3RHulQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=F4KqD+MF; arc=none smtp.client-ip=192.29.178.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="F4KqD+MF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=VlcwDRguLcxEOxExMaGLQnE/QkEHH7oos9aj/XsA8Yk=;
 b=F4KqD+MF/bJuLbO2gM5qC8L/CCPd0+5/yF+hr+cyunKJAhRbYhuhFEIWsan3EeBYNvilNPbfbMB9
   +x5pzKArEudcyDFr6uaOo5naXBj05QoQ2rNIWDL7EGXC6fc+kD8dMUppvGoEYP+CLq/Eewxrv8sA
   MGJI30a/Cfnj+ZoNTTCaXajTdGxhIzJtsiCSCkj8pYz2QcHsOsSx/5qBRKsm2lcLMCx0wWCstDQa
   rxotbCWX/g9euDZPE8vRkGwKr4KSRe/zVfc11tz/y8epecpH0cv6rojJmMuZmJ2qNQZdD82o8I+o
   K9KFTpbzcWv13GMJGGxN4Gxw7ERwcDgBVa4SsA==
Received: by omta-ad1-fd1-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20240709 64bit (built Jul  9
 2024))
 with ESMTPS id <0SK4001BL6HV71F0@omta-ad1-fd1-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Fri, 20 Sep 2024 13:51:31 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: quoted-printable
Content-type: text/plain; charset=UTF-8
Date: Fri, 20 Sep 2024 15:50:51 +0200
Message-id: <D4B5S3TNZTQI.3GI68VA0NFGJS@ferdinandy.com>
Subject: Re: [PATCH v3 2/2] fetch: set remote/HEAD if it does not exist
Cc: <git@vger.kernel.org>, "Taylor Blau" <me@ttaylorr.com>,
 "Patrick Steinhardt" <ps@pks.im>,
 =?utf-8?q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
 "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: "Junio C Hamano" <gitster@pobox.com>
From: "Bence Ferdinandy" <bence@ferdinandy.com>
References: <D43G2CGX2N7L.ZRETD4HLIH0E@ferdinandy.com>
 <20240919121335.298856-1-bence@ferdinandy.com>
 <20240919121335.298856-3-bence@ferdinandy.com> <xmqqjzf744zg.fsf@gitster.g>
In-reply-to: <xmqqjzf744zg.fsf@gitster.g>
Reporting-Meta:
 AAG8YHN0ObWb1rmxWaC3CvRooobslnS7A48EFo8Il/UslBmn2tnvQUaAFsecjceX
 fP8EEI2Eh50bhZjLtuipUyWse+fonbXxOZoda9PmFW0aKg9H8cDFhc7kSQAeHsU/
 Qelb5Y2IlWpNjLE960fIRFg9i6bUSSc+8l1nioqPE04qNBH/vVarGMgms6adPLGy
 WqmL5gKyuCBBUIC5q8KAFMwJEcJxtym1XQNDMYY0NSIwnY3qrB4D+zQOwiQO40dG
 aqNvBTtcmE7We7vlN6N4zGfefpgR+rz4yQTJEUbJ3kNORBzR01D7jWUXSW/MKQ5q
 Wn7cR+f6i2ANUz+rN2y1caB4ZPHJaxoqUe15QR+gdAN2QG1pVxyS1DaNSAj42+/n
 eZ+/co75/UJxS/yhrLCVibBeW0wP4RRySJckEGfeRpfCcWKcoJv1jwwBujvuQXNg
 lR9AGEBrgxprfua1d0yr+lDEKSTGnHTVACImTLt08OF+u0kZbfBH9OVP


On Fri Sep 20, 2024 at 01:07, Junio C Hamano <gitster@pobox.com> wrote:
> Bence Ferdinandy <bence@ferdinandy.com> writes:
>
> > If the user has remote/HEAD set already and it looks like it has change=
d
> > on the server, then print a message, otherwise set it if we can.
> >
> > Signed-off-by: Bence Ferdinandy <bence@ferdinandy.com>
> > ---
> >
> > Notes:
> >     v3: - does not rely on remote set-head anymore so it only authentic=
ates
> >         once
> >         - uses the new REF_CREATE_ONLY to atomically check if the ref e=
xists
> >           and only write it if it doesn't
> >         - in all other cases the maximum it does is print a warning
>
> Except for one thing, I can tell from the above that the design is
> sensible without looking at the actual patch.  Nicely described.
>
> The "one thing" is what to do if you normally do *not* keep track of
> the remote-tracking refs for this particular remote.
>
> If I am only fetching refs (or HEAD) in FETCH_HEAD for immediate
> consumtion by doing "git pull bence HEAD" with something like
>
>     [remote "bence"]
> 	 URL =3D http://github.com/bence/git
>
> (with no other configuration under remote.bence.* hierarchy), I do
> not think I want the code to create refs/remotes/bence/HEAD, with
> no other remote-tracking refs in the same hierarchy, even if it finds
> no existing refs/remotes/bence/HEAD there.  For that, I suspect that=20
> you'd need to see if the pointee of refs/remotes/bence/HEAD either
> already exists or this fetch is about to create it, or something
> like that, before deciding to create a ref with the REF_CREATE_ONLY
> flag.

I'll take another look at this.

>
> If you are doing so already in the code (I haven't started reading
> it yet at this moment), you should mention it in your proposed log
> message, so discount my earlier "Nicely described" a bit ;-).

:D

>
> Let's see what actually happens in the code now.
>
> > +static const char *abbrev_ref(const char *name, const char *prefix)
> > +{
> > +	skip_prefix(name, prefix, &name);
> > +	return name;
> > +}
> > +#define abbrev_branch(name) abbrev_ref((name), "refs/heads/")
>
> We do not call the act of optionally skipping prefix "abbreviate" in
> this project (object names are abbreviated but that is done by
> chomping the later bytes of a long name).
>
> I suspect that a caller of either of these two functions are
> inherently buggy in that they _optionally_ skip the prefix so they
> do the same thing for "refs/heads/main" and "main" but not
> "heads/main".  The callsites may need to be inspected to see how
> they should deal with cases where skip_prefix() did *not* see
> anything to skip.

I copied this verbatim from builtin/remote.c
https://github.com/git/git/blob/master/builtin/remote.c#L267 so it looked l=
ike
a safe bet T_T I'm not 100% sure, but I think there's no use case where you
pass a ref directly to remote except for set_head, but there it's not used,=
 so
it looks safe?

That being said, I can change the name(s) to not use abbrev here, especiall=
y if
you have a good suggestion. Maybe strip_prefix_ref/branch? Again in fetch, =
we
(should) know what type of refs we're calling it on, so should be safe?

>
> > +static inline int set_head(const struct ref *remote_refs)
>
> Drop "inline".  You do not want to inline this much code if there
> are many callers, and if you have only one caller, the compiler
> would inline it into the sole caller if it is the more efficient
> thing to do.

Ack.

>
> > +{
> > +	int result, ref_changed =3D 0;
> > +	struct strbuf b_head =3D STRBUF_INIT, b_remote_head =3D STRBUF_INIT, =
b_local_head =3D STRBUF_INIT, b_prefix =3D STRBUF_INIT;
> > +	const char *remote =3D gtransport->remote->name;
> > +	char * head_name =3D NULL;
> > +	struct ref *ref, *matches;
> > +	struct ref *fetch_map =3D NULL, **fetch_map_tail =3D &fetch_map;
> > +	struct refspec_item refspec =3D {
> > +		.force =3D 0,
> > +		.pattern =3D 1,
> > +		.src =3D (char *) "refs/heads/*",
> > +		.dst =3D (char *) "refs/heads/*",
> > +	};
> > +	struct string_list heads =3D STRING_LIST_INIT_DUP;
> > +
> > +	get_fetch_map(remote_refs, &refspec, &fetch_map_tail, 0);
> > +	matches =3D guess_remote_head(find_ref_by_name(remote_refs, "HEAD"),
> > +				    fetch_map, 1);
> > +	for (ref =3D matches; ref; ref =3D ref->next)
> > +		string_list_append(&heads, abbrev_branch(ref->name));
> > +
> > +
> > +	if (!heads.nr)
> > +		result =3D 1;
> > +	else if (heads.nr > 1) {
> > +		result =3D 1;
> > +	} else
> > +		head_name =3D xstrdup(heads.items[0].string);
> > +	if (head_name) {
> > +		strbuf_addf(&b_head, "refs/remotes/%s/HEAD", remote);
> > +		strbuf_addf(&b_remote_head, "refs/remotes/%s/%s", remote, head_name)=
;
> > +		strbuf_addf(&b_prefix, "refs/remotes/%s/", remote);
> > +		if (!refs_read_symbolic_ref(get_main_ref_store(the_repository),b_hea=
d.buf,&b_local_head)) {
>
> Overly long lines around here cannot be sanely reviewed on my
> terminal, so I'll stop here for now. =20
>
> Do not omit SP after ",", as that is the least effective way to
> shorten overly long lines.  Instead, consider introducing a
> one-time-use temporary variables with meaningful name, e.g.
>
> 		struct ref_store *store =3D get_main_ref_store(the_repository);
>                =20
>                 strbuf_addf(&b_head, "refs/remotes/%s/HEAD", remote);
> 		...
> 		if (!refs_read_symbolic_ref(store, b_head.buf, &current)) {
>     			/* it's current value is in "current" */
> 			...


Ah, yeah terribly sorry about this, I've gotten so used to automatic
formatters, that I just didn't take a second look. I'll be more careful in =
the
next round.

--=20
bence.ferdinandy.com

