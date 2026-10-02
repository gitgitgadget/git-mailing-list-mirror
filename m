Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420FD3DDDB1
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 19:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790968052; cv=none; b=SjdZH+ZlWmSw6BWlEUVY+f7xk9x+75gXBpY0uc0xvlqDl8OrxrsaKzXEeuQIzevtGtLrYdMPfswpsF+pvWZbAMUr82UtGz/qUOAW5IMu3s9OE0DUNCy9UOEepFeZB0iMWW0RUZnUi0NBbAFR4HT3Ya3/Kh9WpR2QBd+ioatD88s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790968052; c=relaxed/simple;
	bh=FTkycQNqGrr7JMZfPTbnP6WDZav9W2+clMGrtHLhmS4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ty7Qm5Q48YpRdXyihgqpY/wVzOH7tKdaVvhu7R1SVRwb2VlajW1pQM7DEh5XuZdX7k0acwp00pfDc2l38B4L7MvEkLDMEdnUuxAMO3dwDk9d4EPqwvDrbk1T515Dgzpo4d+U1JVbMG0KCLf+lY/r4vcreHOUmTvtndoWmyLAuEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=ilJpgY3o; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Do9/ZdQL; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="ilJpgY3o";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Do9/ZdQL"
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 35FE3140008E
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 15:07:29 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Fri, 02 Oct 2026 15:07:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790968047;
	 x=1791054447; bh=AMuw54D85QHRDZWMelzgl6fiiM17vfMg3gISfpHit0c=; b=
	ilJpgY3obpg+nr6koFBKCrx42d72TNzKwCjM1uzF5ZTVcB+rb7a1GJ65w8qWRsVk
	1S6XzPrrcspQi0oWCSWZYX9GF8eQxGncDqPUmzxHnHygtjnQfTrhglBXTth7U1zq
	072YAHCHeBqJYPKNz3tR9WSC+HKQbHCnH4PE6PGAJVpKjT2KqYyrky70aOVtTxGw
	Tu0/TU9bA8N8IcwuBvQwtQx8ArxduhUpYG9AGdld4qs2Q8VJT/cib0l/u65pUmaU
	k3MrDAotkG4fsx0djdjj/tiOv/7UsB+OD84FybSntQ5IHp40mBvRwRPlFa9Hme79
	pa8d1eyGM6eYZ0XWV/MPrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790968047; x=
	1791054447; bh=AMuw54D85QHRDZWMelzgl6fiiM17vfMg3gISfpHit0c=; b=D
	o9/ZdQL437+0enlbBl10PHLl+fw1WHj6ngLiXGZ8c4lbzTCaxGctxlY+Eh8ScZzj
	zQjCYddrkLMdI3X+niLwURggaQwliTzylLEucKYZXvfUIPr1x85I8KhhcBoHVJXl
	FFuHQB4lK1Kof3el9ZfvMHH6LwY8CHxOddh6FVK75gXB7fU4PkvTL22lpQvoz8E0
	06oDVBSSYwHg6Fz+GdF4yBQqQI77dRHlmWHYnpcTN216dGGTgaB6xnpFsx9/Ekpp
	WoTGLgvPZlJasC0k8TZOtL8ehmqrsuw243z54rMe7abiriMxgW0SXe1QMiHTwYel
	TOKKbEhS0MxgE0w+PRzjQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1790968047; d=fastmail.com;
	mf=PGtyaXN0b2ZmZXJoYXVnc2Jha2tAZmFzdG1haWwuY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:gXQpF8D5yR5jc5l1KQhfsEXhj7yXgF4l8bAWXoWiaUCa2n1
	HDhw4tGx8A9xjZS6xJoQlChU+grlbOvUhiqI7Lr1w1GD5A7anLlpQF4GxoyCaR2V
	rOd81DoqQtFA4H2fc/TEKyc25oA1TuZMg+fkiJBrNXnQPsScedekmMcIPYqW/gtG
	ydMNR5DjaLXbpdLZNB5Cw3uogeuhkRzNha6ScgmbGM0hWBuhiyBxssHpG85OfeeB
	PSurQLGc7yYZZnMJ75GQrzGq2my5YWpP/EqzGW7pBhpFhxn8n5lBHTCEIpJS5+GI
	Cfde6IVtNRB4ZkYz+zSg7DYGX/Jx32efvrX4Krw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:9MJubjwAeNn+EcISQrPT7B2xJp/ubY62dcw+F4qYc+8=:FTkycQNqGrr7JMZfPTbnP6WDZav9W2+clMGrtHLhmS4=;
X-ME-Sender: <xms:7QDAajHSDw2KEOZ1CPPjtKeyvbDeIjmf7gQz86fdtRFqA6PXoVmR4o4>
    <xme:7QDAarJYT-Xcnr8I5uSLktLi5YNdzhLdm4EOkEd7zNNT1UUyGXz4IuhoFG0mpRhhg
    TNJyDy8933ocsmy4OFQ2tXTiu0eSEM9CXZekIRNoQqlHp70yItU>
X-ME-Proxy-Cause: dmFkZTEcuIOWychFRFr61433tTKRSMne7X9Djrse0PwVu1lV1cIR4yEG1AX2MwPvf3f8y7
    IO9fJW5781Rykb0qRBj5Nl3gbCqYsqD0b/RecnUmePwtkrVRwlv6s7xNgz4HAOYzSXxD5S
    gmIunmh+C7D5RbIgpdFtn3L87H6BxJy8Rp4yYi7/ftTyN2LmOReC9sVIoTnO3AWFqla/eu
    0KuEmHvgLnMy5X07uRpiz1LSlij0UZM0DqDtS9pK6Uzv2OxczGsK6nFPbf4Gq/C4ymlLRD
    MrSL30tUgpyPR47QFY6n45ImBWCpEwCSC0wM4+phdgEpIrT1X4VkXkPgk86esHo9+8x/Ce
    Ll5gD82YHnfj8huzKgPZn1u1XszGRiHQiXZGtSuZ2ySrXEor2XsGgztbYzL4UvUmTlw+1r
    xIp/bJCDZZrk4e2gNvwcjZP6XTlZdxzyxl1CxqceuWeCEfrkJ6jTc4vp4uiTORL/AJVNTr
    F22Yq9rcVCbpbIvG02f1gD/9rL6eDMqFrCfpEX5YZ5VIz82WCrRmJz5bLkPy7LzrqlerRA
    /xuzgajc7AhFLtC6THanORGs+OE1uA2UVEQFalJeGmoZSsMFwMYeHJwMCcj0YqgLUEUbov
    fIbAAOOgxSTKoW8ayyYeb85HLt2QKAuIv7UwOdhb2PsKFUmSv9Frx/LnpNVg
X-ME-Proxy: <xmx:7gDAakBS3qabwFzFQmqjDnN_gFik8Yvwrfut7mX1dCoE0GflNq93Bg>
    <xmx:7gDAauQIWQahrqDDUQhTER33-XSO8ns2GJ6dPhvNtMkP-RXL8Bv4gg>
    <xmx:7gDAaqocdwZYwFNl8Q0EcGOr-8qaJdvAUkwTQSa_bDdZ_gSECu7z6w>
    <xmx:7gDAaoxxwafvfr1jzTKHWFTsN1ybe6ekUKMI6diVgw4V93YSMPD_Uw>
    <xmx:7wDAav-gbX3UmwvSzMaUH30h9JXyTCoEk5pQO5Jwg6PPU-TNPJJlHl5g>
Feedback-ID: i83a1424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id A3C8222C009A; Fri,  2 Oct 2026 15:07:25 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AAUWAJQF6URs
Date: Fri, 02 Oct 2026 21:07:05 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>
Message-Id: <30249b7b-b6f7-4065-9a83-db93d69ad0f1@app.fastmail.com>
In-Reply-To: <xmqqtsn4xd17.fsf@gitster.g>
References: <CV_format-patch_learn_--range-diff-notes.c57@msgid.xyz>
 <V3_CV_format-patch_learn_--range-diff-notes.d39@m5gid.xyz>
 <V3_simplify_params.d3a@m5gid.xyz> <xmqqtsn4xd17.fsf@gitster.g>
Subject: Re: [PATCH v3 1/2] format-patch: simplify get_notes_arg parameters
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 2, 2026, at 19:28, Junio C Hamano wrote:
> kristofferhaugsbakk@fastmail.com writes:
>
>> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>>
>> git-format-patch(1) passes on the notes behavior that it is using for
>> the patches to git-range-diff(1). In turn you get the same Git notes
>> displayed in the range diff as the ones you used to generate the
>> patches. And that makes sense in most cases.
>>
>> However, I often make notes between series versions that mostly prepe=
nd
>> ...
>> something like an alias set up with it. But why spend code closing
>> that door? There is no usability upside to erroring out.
>
> This is somewhat shared with the next step, but the commit message
> includes a lengthy narrative of the author's thought process ("An
> off/on switch is enough for this behavior...", "But now we are faced
> with a problem...", "Well, we can't. Therefore we need...").
>
> Can we strip out the conversational journey?  The log message should
> be a concise, permanent technical reference explaining the problem
> (range diff notes inherit patch notes, which may contain irrelevant
> iteration changelogs) and the solution (the new options and the
> .override flag).

Sure.

>
>> diff --git a/Documentation/git-format-patch.adoc b/Documentation/git-=
format-patch.adoc
>> index 191f64b77d1..5907f299a8d 100644
>> --- a/Documentation/git-format-patch.adoc
>> +++ b/Documentation/git-format-patch.adoc
>> @@ -378,6 +378,21 @@ case is to show comparison with an older iterati=
on of the same
>>  topic and the tool should find more correspondence between the two
>>  sets of patches.
>>
>> +`--range-diff-notes=3D<ref>`::
>> +`--no-range-diff-notes`::
>> +	Used with `--range-diff`, tweak what notes to display in the
>> +	range diff.
>> ++
>> +The default behavior is to display the same notes in the range diff =
as
>> +on the patches; see `--notes`. But you can use these options to use a
>> +different list of notes. For example, say you have given three notes
>> +refs to `--notes`. At this point those same three notes will be
>> +displayed in the range diff. But then you pass
>> +`--range-diff-notes=3D<ref>`. Now the range diff will only display
>> +_<ref>_. You can of course pass more refs to this option, just like
>> +`--notes`. And you can also turn off all range diff notes with
>> +`--no-range-diff-notes`.
>
> Very chatty and colloquial.  A technical reference manual should be
> concise and direct.  Here is my attempt to condense it down to make
> it more readable:
>
>   By default, '--range-diff' displays the same notes as the patches
>   (see '--notes').  Use '--range-diff-notes=3D<ref>' to specify a
>   different notes ref for the range diff. This option can be given
>   multiple times to show notes from multiple refs.  Use
>   '--no-range-diff-notes' to disable notes in the range diff.

Fine. The only thing I was concerned about was someone jumping to the
conclusion that the `--range-diff-notes=3D<ref>` would be additive to the
`--notes` options. But this says =E2=80=9Cdifferent notes ref=E2=80=9D w=
hich clearly
means that the intent is to discard the `--notes` for the range diff.

I think that version of yours is better.

>[snip]
>> +static int rdiff_notes_cb(const struct option *option,
>> +		       const char *arg,
>> +		       int unset)
>> +{
>> +	struct rdiff_notes *rdiff_notes =3D option->value;
>> +
>> +	rdiff_notes->override =3D 1;
>> +
>> +	/*
>> +	 * The rest is the same as
>> +	 * parse-options-cb.c:parse_opt_string_list
>> +	 */
>
> Hmph, I wonder if it is more future-proof to wrap the string-list
> callback like so ...
>
>         static int rdiff_notes_cb(const struct option *option,
>                                const char *arg,
>                                int unset)
>         {
>                 struct option opt =3D *option;
>                 struct rdiff_notes *rdiff_notes =3D opt.value;
>
>                 rdiff_notes->override =3D 1;
>                 opt.value =3D &rdiff_notes->notes;
>                 return parse_opt_string_list(&opt, arg, unset);
>         }
>
> ... than copying and letting the code drift apart.

Obviously better.
