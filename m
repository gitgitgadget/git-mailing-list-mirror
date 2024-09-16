Received: from aib29agh122.zrh1.oracleemaildelivery.com (aib29agh122.zrh1.oracleemaildelivery.com [192.29.178.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D4213B588
	for <git@vger.kernel.org>; Mon, 16 Sep 2024 19:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726515929; cv=none; b=Eyk11qr0Ls0r7yiPFk2PCTD/DaobYsAToQsrVknukf1Df/KwfKWrBXCPGgUUF5LEsA2F5sf2rDzaut7rOJoUq5wm0tA/o9Z+Lbgt1VnqAnTmdGGo/SN4cPPVYRJUhGU8fF3CVQOfAxD4BeMJnQkPAUR4re9eelcdJk+5XEQAeY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726515929; c=relaxed/simple;
	bh=A/XxUI29UTsCd0azGJxqJRd6WpyAwsZ0TlZ7+PeVLbM=;
	h=MIME-version:Content-type:Date:Message-id:Subject:Cc:To:From:
	 References:In-reply-to; b=gzlpMYq0UpOMt7eX0QBGJSXc2bjAtOdiHeGifAkRpr/RvdgESKJPtgJ2vBFHkMlLlTUMPmvG3OY4yLjcdpUlrhDtBN+I9s6Hag1XzTiBteCpgZ+T23ouBlJGhcUZACpyyD8r216nF8cOhHypVm4mj8CVoSIvY7Dv3HxfUydATIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=ZuGE0ajh; arc=none smtp.client-ip=192.29.178.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="ZuGE0ajh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=ehteJcCB8VQ5ka9apudExUW0zsMComgGmmPgCEP62Lo=;
 b=ZuGE0ajhKHnoIA9WklaF8BGvvYEDMCELzsAY6frLdzFXOH7kEDOAnrAQSBVfsmk6qeaA7fpM+M0g
   mROyw5wJC0z4ECmyH2dXHhDxDMOzTxMJM9ScPBrBEpSpl3doO+lF7fGmfjiic/DvGUlZW12S/vzy
   xOS6HbQISW4C5r4cqqye37MhjK8f4QMJNN1VTpEC3bLM9ICDoxgetjIrC0HDEY4yGSVmZDjm0GM3
   E6G+98TNACyTOkFLo9qxOXHLya8AQWdut8VdGU1nyIP+zybHSHHHKgBwc6535CCOMOJZw2wlQEzA
   pCoM4NhEQ4EXrwG7BXIY3VrNbKOTiV85e5KRnA==
Received: by omta-ad1-fd1-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20240709 64bit (built Jul  9
 2024))
 with ESMTPS id <0SJX00IDQ87IL130@omta-ad1-fd1-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Mon, 16 Sep 2024 19:45:18 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: quoted-printable
Content-type: text/plain; charset=UTF-8
Date: Mon, 16 Sep 2024 21:44:47 +0200
Message-id: <D47YSXC0GSIW.MN2MW7IR9GMW@ferdinandy.com>
Subject: Re: [PATCH v3] set-head: no update without change and better output
 for --auto
Cc: <git@vger.kernel.org>, "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
 =?utf-8?q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= <avarab@gmail.com>,
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
 "Patrick Steinhardt" <ps@pks.im>, "Christian Schlack" <christian@backhub.co>,
 "Jeff King" <peff@peff.net>
To: "Junio C Hamano" <gitster@pobox.com>
From: "Bence Ferdinandy" <bence@ferdinandy.com>
References: <20240915221055.904107-1-bence@ferdinandy.com>
 <xmqq5xqvo37s.fsf@gitster.g>
In-reply-to: <xmqq5xqvo37s.fsf@gitster.g>
Reporting-Meta:
 AAGxtyyzQCAALGhrz9TEz3fkvbC5uSN0WuwgHYMtZdmrupWB/jO/uj4S7FJVyuIj
 RIBrLe6KCGri3kQ692rogsZe3LTvY+MhfCKKS81UNRpr+LkZoHe4AHFKUH2AFyDi
 PiAurLCP4qIRAbwXB5fV1sddcWjxXRtxdGshh2h2WNBPqgI0zPDzC3vUp8tnPtlR
 LfZZzXr10jhxJOXrK6GfR7YTxKTKDkgeNNYI3uJsgjwtTmjm1ee+r2/h/8zqZG8d
 xXBcnu3dc++L2g12qPQxnkiloKUFOQhzbZ4sQRsunPPty/LVhI82EXRSqqPeC/N4
 oKxHh5HQzRLaESfUzVTAjEFTc0OpY3nabmu9B2JJh1WgF+WvJ/WJBXGQ1Bdlb/Rb
 tl3DcpfpYXggiK6RQJt1Hs7vBPMQmqbLFxQE0S+Vw8rVhER+Nufo3L0CPr93zupW
 j79pGmdVhmZtuJNlsYie46sv8LvGjs2pURSEsFtTg5KBIm8mmOnspc8=


On Mon Sep 16, 2024 at 20:36, Junio C Hamano <gitster@pobox.com> wrote:
> The message I am responding to is sent as the first message to start
> a brand-new thread, but for future reference, it makes it easier for
> everybody involved if you sent a new iteration of a patch (or a
> patch series) as a reply/follow-up to the last round.

Sorry about that, I've only ever used git-send-email on sourcehut before, w=
here
they ask you _not_ to use --in-reply-to because of their UI and got used it=
...
I'll do that next time!

>
> If it is too cumbersome to do for any reason, as an alternative, you
> can give a reference to previous rounds as URLs to the list archive,
> i.e.
>
>  (v1) https://lore.kernel.org/git/20240910203129.2251090-1-bence@ferdinan=
dy.com/
>  (v2) https://lore.kernel.org/git/20240910203835.2288291-1-bence@ferdinan=
dy.com/

Tbf, I did put this in the commit notes :)

>
> > Currently, even if there is no actual change to remote/HEAD calling
> > remote set-head will overwrite the appropriate file and if set to --aut=
o
> > will also print a message saying "remote/HEAD set to branch", which
> > implies something was changed.
> >
> > Change the behaviour of remote set-head so that the reference is only
> > updated if it actually needs to change.
>
> I sense a patch with a racy TOCTOU change coming ;-)

It seems that indeed :(

[snip]

> I am not quite sure what the discussion concluded "should be not",
> though.  In a message from you
>
>   https://lore.kernel.org/git/D43G2CGX2N7L.ZRETD4HLIH0E@ferdinandy.com/
>
> what we agreed was that "git fetch" does not need a new option, but
> we also agreed that it would be a good idea for "git fetch" to
> create, refs/remotes/$remote/HEAD when it does not exist without
> being told.
>
> I take it that you still want to see such a change to "git fetch"
> eventually happen, but decided to tackle the other half of the
> original two-patch series first with this patch?

Yes, but it did also turn up, that calling `git remote set-head --auto`
directly from `git fetch` as I did in the original RFC requires the user to
authenticate twice, which is not the best UX. So now I'm hammering away at
adding a "set_head" directly to fetch (I've sort-of figured it out already,=
 but
it is definitely more involved than this one, EDIT: since reading below abo=
ut
racyness, maybe this one is actually more complicated :D)). It's just that =
now
I can handle the two patches independently.


>
> >  static int set_head(int argc, const char **argv, const char *prefix)
> >  {
> > -	int i, opt_a =3D 0, opt_d =3D 0, result =3D 0;
> > -	struct strbuf buf =3D STRBUF_INIT, buf2 =3D STRBUF_INIT;
> > +	int i, opt_a =3D 0, opt_d =3D 0, is_ref_changed =3D 0, result =3D 0;
>
> Shall we simply call it ref_changed instead, so that I do not have
> to wonder which is better between has_ref_changed and is_ref_changed? ;-)

Makes sense :)

>
> > +	struct strbuf buf =3D STRBUF_INIT, buf2 =3D STRBUF_INIT, buf3 =3D STR=
BUF_INIT;
> >  	char *head_name =3D NULL;
> > =20
> >  	struct option options[] =3D {
> > @@ -1440,13 +1440,19 @@ static int set_head(int argc, const char **argv=
, const char *prefix)
> > =20
> >  	if (head_name) {
> >  		strbuf_addf(&buf2, "refs/remotes/%s/%s", argv[0], head_name);
>
> > +		refs_read_symbolic_ref(get_main_ref_store(the_repository),buf.buf,&b=
uf3);
> > +		is_ref_changed =3D strcmp(buf2.buf,buf3.buf);
> >  		/* make sure it's valid */
> >  		if (!refs_ref_exists(get_main_ref_store(the_repository), buf2.buf))
> >  			result |=3D error(_("Not a valid ref: %s"), buf2.buf);
> > -		else if (refs_update_symref(get_main_ref_store(the_repository), buf.=
buf, buf2.buf, "remote set-head"))
> > +		else if (is_ref_changed && refs_update_symref(get_main_ref_store(the=
_repository), buf.buf, buf2.buf, "remote set-head"))
> >  			result |=3D error(_("Could not setup %s"), buf.buf);
>
> Two and a half small issues:
>
>  - Do not omit " " after "," and avoid overlong lines by folding
>    lines at an appropriate place (usually after an operator at
>    higher point in parse tree, i.e. after "is_ref_changed &&").
>
>  - This is inherently racy, isn't it?  We read the _current_ value.
>    After we do so, but before we write _our_ value, another process
>    may update it, so we'd end up overwriting the value they wrote.

Honestly, I've just sort of assumed git in general protects against paralle=
l
writes, but I guess I'm wrong :D We'd need to block writes to the reference
while we're doing this, but I'm not quite sure how to achieve that.

>
>  - To compute is_ref_changed, we look at buf3.buf but what happens
>    if such a ref does not exist, exists but is not a symbolic ref,
>    or is a hierarchy under which other refs hang (e.g., a funny ref
>    "refs/remotes/origin/HEAD/main" exists)?  Does the strcmp()
>    compare a valid buf2.buf and an uninitialized junk in buf3.buf
>    and give a random result?  Shouldn't the code checking the return
>    value from the refs_read_symbolic_ref() call, and if we did so,
>    would we learn enough to tell among the cases where (1) it is a
>    symref, (2) it is a regular ref, (3) no such ref exists, and (4)
>    the refs layer hit an error to prevent us from giving one of the
>    previous 3 answers?
>
> If we really wanted to resolve the raciness, I think we need to
> enhance the set of values that create_symref() can optionally return
> to its callers so that the caller can tell what the old value was.
>
> I am not sure offhand how involved such an update would be, though.

Hmm, so there's a lot to unpack for me here. Is create_symref already atomi=
c so
if it could give back the previous value we could decide based on that what=
 to
print (and forget about not writing the ref when there's no need)? Anyhow, =
I'll
explore this part of the code and see if I can understand what's going on.

[snip]

> Quoting the values we obtained from the environment or the user may
> be nicer, e.g.
>
>     'refs/remotes/origin/HEAD' is now set to 'main'.
>     'refs/remotes/origin/HEAD' is unchanged and points at 'main'.

Ack. I also gather from this that we should be a bit more verbose rather th=
an
trying to make it easy to parse.

I also forgot to free up buf3, which I'll do for the next round.

>
> This is a tangent outside the immediate topic of this patch, but I
> wonder if we need "--quiet" mode.

Even with the planned changed to fetch, if one want to be completely
up-to-date, they'd be running fetch and remote set-head and since the forme=
r
has a quiet I think it would make sense. At least: adding it would be more
straight forward than solving raciness :D

Best,
Bence





--=20
bence.ferdinandy.com

