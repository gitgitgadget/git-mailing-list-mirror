Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DBC4A2047F
	for <e@80x24.org>; Mon,  7 Aug 2017 17:51:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751589AbdHGRvI (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Aug 2017 13:51:08 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:32853 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751505AbdHGRvH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2017 13:51:07 -0400
Received: by mail-wr0-f195.google.com with SMTP id y43so816654wrd.0
        for <git@vger.kernel.org>; Mon, 07 Aug 2017 10:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=FXfWs+C06hK7JEw2ZL//nV2kvzN968QTp+StKEhZORI=;
        b=uWFv4M51//sNnxppdztE8RnOt2S+REYW1lsJBGv7MPdDU6amCpMqRODFdYfMF6+VbV
         YmsU3htZME4gy3D3G3mONhlFfOjnRy5zYHKMDfZ5/8P5MUi/0dsOj9yn+nKsq5qcNUIX
         p9+cru0HThB+Ls6nzMWHj70+dhmL+OGP8b4XRnO4n3cmo+xT3UExIsMcXUelcJeb3dTg
         dX4EzXIKnrn11YdBbT/pH2QJkLuDhc2MCsAR62d/jhdoaaMK1bUicXBemt4rrrkv5+r5
         K3hGhkHZ+f3aEXkFokWPtNUBeZSt8GHo0MOA1Hkj07I7sh5ts+aoaM8lXng4pjThB1Qz
         r/5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=FXfWs+C06hK7JEw2ZL//nV2kvzN968QTp+StKEhZORI=;
        b=Csyx63OxxaebmSxCSFcC8OXqKlINJBUBNhI0yBPK/AsGVyvg/lQ3MXvNFIwVP7ICP6
         YmrETu6uA4nzVVjojy/DeDS2HZFuxy/ptCzu/JZf8bxcb2UwPc6pUNfsx+2TcP/zrLC3
         YFbfkDucaj72hrmbL7BorMfyJoZZOhWd0sooJYK3Fk6WuKCvAQhZRX/fsNoBHeujOpl6
         VY6oJhM80ce1F7rsanB3o+tq7vMNt0AcgZg1pHq2JqsO26FAQhkLsvOBQraaQBF35m87
         jkvQB5l6FquG3ekvElW7PpQ0SFNLqSPLsMgBtu8WT8EcKby1eh3CZOcjUOGgbD2gFlNt
         ZQRA==
X-Gm-Message-State: AHYfb5icgm1bEhvaL6XC29XkkwqnS/du89Mu9QPwdt+Bi+54vdXipQWP
        ttOgjIVXYWndJg==
X-Received: by 10.223.141.131 with SMTP id o3mr968195wrb.110.1502128266135;
        Mon, 07 Aug 2017 10:51:06 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id g17sm10210192wrc.28.2017.08.07.10.51.05
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 07 Aug 2017 10:51:05 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH for NEXT v3 2/2] sub-process: refactor handshake to common function
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20170807102136.30b23023@twelve2.svl.corp.google.com>
Date:   Mon, 7 Aug 2017 19:51:04 +0200
Cc:     git@vger.kernel.org, bmwill@google.com, gitster@pobox.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <2BEA5CEF-44C9-45DC-A462-579864790EDB@gmail.com>
References: <cover.1501092795.git.jonathantanmy@google.com> <20170724213810.29831-1-jonathantanmy@google.com> <cover.1501092795.git.jonathantanmy@google.com> <6327579311fdb941a11b6d452318777a3c42ee65.1501092795.git.jonathantanmy@google.com> <323E470B-994B-4AD8-9F30-588C2B97A845@gmail.com> <20170807102136.30b23023@twelve2.svl.corp.google.com>
To:     Jonathan Tan <jonathantanmy@google.com>, benpeart@microsoft.com
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 07 Aug 2017, at 19:21, Jonathan Tan <jonathantanmy@google.com> =
wrote:
>=20
> On Sun, 6 Aug 2017 21:58:24 +0200
> Lars Schneider <larsxschneider@gmail.com> wrote:
>=20
>>> +	struct cmd2process *entry =3D (struct cmd2process *)subprocess;
>>> +	return subprocess_handshake(subprocess, "git-filter", versions, =
NULL,
>>> +				    capabilities,
>>> +				    &entry->supported_capabilities);
>>=20
>> Wouldn't it make sense to add `supported_capabilities` to `struct =
subprocess_entry` ?
>=20
> The members of "struct subprocess_entry" are not supposed to be =
accessed
> directly, according to the documentation. If we relaxed that, then we
> could do this, but before that I think it's better to let the caller
> handle it.

@Ben: You wrote that " Members should not be accessed directly.":
=
https://github.com/git/git/commit/99605d62e8e7e568035dc953b24b79b3d52f0522=
#diff-c1655ad5d68943a3dc5bfae8c98466f2R22
Can you give me a hint why?

@Jonathan: What do you mean by "it's better to let the caller handle it"


>>>=20
>>> +static int handshake_version(struct child_process *process,
>>> +			     const char *welcome_prefix, int *versions,
>>=20
>> Maybe it would be less ambiguous if we call it `supported_versions` ?=20=

>=20
> I thought of that, but I think "supported_versions" is actually more
> ambiguous, since we don't know if these are versions supported by the
> server or client or both.

True! Maybe `versions_supported_by_git` to annoy people that hate=20
long variable names ;-)


>>> +			     int *chosen_version)
>>> +{
>>> +	int version_scratch;
>>> +	int i;
>>> +	char *line;
>>> +	const char *p;
>>> +
>>> +	if (!chosen_version)
>>> +		chosen_version =3D &version_scratch;
>>=20
>> I am not an C expert but wouldn't 'version_scratch' go out of scope =
as soon
>> as the function returns? Why don't you error here right away?
>=20
> It does, but so does chosen_version. This is meant to allow the caller
> to pass NULL to this function.

Hm. I think every protocol should be versioned otherwise we could run
into trouble in the long run.

TBH I wouldn't support NULL in that case in the first place. If you
want to support it then I think we should document it.


>>> +	if (packet_write_fmt_gently(process->in, "%s-client\n",
>>> +				    welcome_prefix))
>>> +		return error("Could not write client identification");
>>=20
>> Nit: Would it make sense to rename `welcome_prefix` to `client_id`?
>> Alternatively, could we rename the error messages to "welcome =
prefix"?
>=20
> I was retaining the existing terminology, but your suggestions seem
> reasonable. This might be best done in another patch once this series
> lands in master, though.

Yeah, sorry for my late review :-(


>>> +	for (i =3D 0; versions[i]; i++) {
>>> +		if (packet_write_fmt_gently(process->in, "version=3D%d\n",=

>>> +					    versions[i]))
>>> +			return error("Could not write requested =
version");
>>=20
>> Maybe: "Could not write supported versions"?
>=20
> Same as above - "supported" is ambiguous.
>=20
>>> +	}
>>> +	if (packet_flush_gently(process->in))
>>> +		return error("Could not write flush packet");
>>=20
>> I feel this error is too generic.
>> Maybe: "Could not finish writing supported versions"?
>=20
> That's reasonable. This is a rare error, though, and if it does occur, =
I
> think this message is more informative. But I'm OK either way.

My thinking is this: if I see an error then I want to roughly know what
went wrong and I want to have a good chance to find the error in the
source. The "Could not write flush packet" is technically correct but
it makes it harder to pinpoint the error in the source as we throw
it in several places.


>=20
>>> +
>>> +	if (!(line =3D packet_read_line(process->out, NULL)) ||
>>> +	    !skip_prefix(line, welcome_prefix, &p) ||
>>> +	    strcmp(p, "-server"))
>>> +		return error("Unexpected line '%s', expected %s-server",
>>> +			     line ? line : "<flush packet>", =
welcome_prefix);
>>> +	if (!(line =3D packet_read_line(process->out, NULL)) ||
>>> +	    !skip_prefix(line, "version=3D", &p) ||
>>> +	    strtol_i(p, 10, chosen_version))
>>=20
>> Maybe `strlen("version=3D")` would be more clear than 10?
>=20
> The 10 here is the base, not the length. If there's a better way to
> convert strings to integers, let me know.

Argh, of course! Sorry! To my defense: it was late last night :-)


>=20
>>> +		return error("Unexpected line '%s', expected version",
>>=20
>> Maybe "... expected version number" ?
>=20
> I'm fine either way.
>=20
>>> +static int handshake_capabilities(struct child_process *process,
>>> +				  struct subprocess_capability =
*capabilities,
>>> +				  unsigned int *supported_capabilities)
>>=20
>> I feel the naming could be misleading. I think ...
>> `capabilities` is really `supported_capabilities`=20
>> and=20
>> `supported_capabilities` is really `negiotated_capabilties` or =
`agreed_capabilites`
>=20
> These "supported capabilities" are those supported by both the client
> (Git) and the server (the process Git is invoking). I think it's =
better
> to use this term for the intersection of capabilities, rather than
> exclusively for the client or server.
>=20
>>> +	for (i =3D 0; capabilities[i].name; i++) {
>>> +		if (packet_write_fmt_gently(process->in, =
"capability=3D%s\n",
>>> +					    capabilities[i].name))
>>> +			return error("Could not write requested =
capability");
>>=20
>> I think this should be "Could not write supported capability", no?
>=20
> Same comment as above.
>=20
>>> +	}
>>> +	if (packet_flush_gently(process->in))
>>> +		return error("Could not write flush packet");
>>=20
>> Maybe " "Could not finish writing supported capability" ?
>=20
> Same comment as the one about writing flush packets above.
>=20
>>> +	while ((line =3D packet_read_line(process->out, NULL))) {
>>> +		const char *p;
>>> +		if (!skip_prefix(line, "capability=3D", &p))
>>> +			continue;
>>=20
>> Shouldn't we write an error in this case?
>=20
> I'm preserving the existing behavior.

You're right:
=
https://github.com/git/git/blob/4384e3cde2ce8ecd194202e171ae16333d241326/c=
onvert.c#L549-L550


- Lars=
