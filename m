Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1BE4C433F5
	for <git@archiver.kernel.org>; Tue, 28 Dec 2021 05:13:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbhL1FNV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Dec 2021 00:13:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbhL1FNV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Dec 2021 00:13:21 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C5EC06173E
        for <git@vger.kernel.org>; Mon, 27 Dec 2021 21:13:20 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id 200so15078590pgg.3
        for <git@vger.kernel.org>; Mon, 27 Dec 2021 21:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=moDm8fiQSa5OhJXpQFE2phpiE7cjCaRIwayChoyCdlM=;
        b=Fl+AEALX1/+OiK+nUHv341c77DIwRrtcXm3HWJnv2D8j/HbtBhlztm8irUOJSOLJrE
         nH651wLWi4b9YkFbvQ/fz8kHW1agpm4/fljiz2jGTP2yit2IVqwnZtPegyXbSKlE8BES
         XUIDMYWcWy3/pWQcm/HrMkJKSrChYTDxHwmxUkM6qPkPKkljvNzGFpN0ZZkae+MhJtEl
         YCMi6K/vBZxAVTQjpyQ0He05E58rMGscRTGYpIiHEI8zjJkxtIi0gyatUNH3XIiFGJwI
         yG9zoriNFIytzBGnO67wHx/vPLdQXUwxTCuxQdCV9MhRhRdzvYl+nnS1P/Zdqv35bVIE
         pAcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=moDm8fiQSa5OhJXpQFE2phpiE7cjCaRIwayChoyCdlM=;
        b=EuP7JdvYuasaR9cx3o5+ilAK/K9Vyz3Y3SOTt0ht6xI8PI5dalEmfThD55QTi46Z1c
         AzUOfEpIICdF5OcS7v7I98EPTDdlJJ4EeKQ+LYMSF/AEdRgSlVouGQ73ifGMNkTCOHlX
         8TvPzvZLdyk2eXAw8ZlQeheALrRrX0EW7Jc2uOaMYk8n0wyNqTExxZ2j3mALFLuKKudc
         8YyZ2obUqpxtvzAnD0DE+Mwuc+KM3SV3fb7D4mTQbArbb6YJ7lW8L0wP8ZjkLjN2co6c
         uCTigCUYzntPiUD0/+YyjhRTVReH3SLf8D8lkImubtnYDiC5DEHiQO5xuCKQt2Ie/u+h
         5hoQ==
X-Gm-Message-State: AOAM532QLZ5HyEU+nBJpIGCc4QTcPoiM+7G4ToNOXNEoTKQxXegrAiMJ
        Z1zzOVM95Fqk8TBcRKk2VKA=
X-Google-Smtp-Source: ABdhPJx/NkqPbYnGFJHxvsjpxjDeE3bVRVgnzhOg4hYwKR0wF2S+Y2DFZdz+CYWOW1hvaUWF0fwmVg==
X-Received: by 2002:a63:b914:: with SMTP id z20mr18224241pge.496.1640668400332;
        Mon, 27 Dec 2021 21:13:20 -0800 (PST)
Received: from smtpclient.apple ([2601:642:4700:fe2:dd0e:5339:f7f2:99d7])
        by smtp.gmail.com with ESMTPSA id x11sm16971224pjq.52.2021.12.27.21.13.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Dec 2021 21:13:19 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Re: [PATCH] name-rev: deprecate --stdin in favor of --annotate-text
From:   John Cai <johncai86@gmail.com>
In-Reply-To: <xmqqpmphx1yh.fsf@gitster.g>
Date:   Mon, 27 Dec 2021 21:13:18 -0800
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Transfer-Encoding: quoted-printable
Message-Id: <028044FB-5CFC-49DF-BCFC-51AF1806619A@gmail.com>
References: <pull.1171.git.git.1640492910432.gitgitgadget@gmail.com>
 <xmqqpmphx1yh.fsf@gitster.g>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3693.40.0.1.81)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



> On Dec 27, 2021, at 11:49 AM, Junio C Hamano <gitster@pobox.com> =
wrote:
>=20
> "John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:
>=20
> As name-rev is Dscho's brainchild, I think it is benefitial to ask =
input
> from him, so I added an address to the CC: list.
>=20
>> From: John Cai <johncai86@gmail.com>
>>=20
>> Introduce a --annotate-text that is functionally equivalent of =
--stdin.
>> --stdin does not behave as --stdin in other subcommands, such as
>> pack-objects whereby it takes one argument per line. Since --stdin =
can
>> be a confusing and misleading name, rename it to --annotate-text.
>>=20
>> This change adds a warning to --stdin warning that it will be removed =
in
>> the future.
>=20
> I know I've suggested the name, but 'text' in --annotate-text is a
> low value word in an option name where every byte is precious.
> "Annotate" is very good to convey what is done to the object of the
> verb, but "text" stresses the wrong thing (we do not annotate
> binary,o we annotate text) without saying where the text comes from
> (i.e.  standard input).  Perhaps "--annotate-stdin" would be a much
> better name.
>=20
> I agree that letting "--stdin" to deviate so much from an emulation
> of "xargs git name-rev" was indeed a mistake that caused the
> confusion that led to the other thread.  If the mode had a better
> name from the day 1, the thread would have been avoided.
>=20
> What I am not sure about is how much this transition would hurt
> existing users and scripts.
>=20
>> +	For example:
>> ++
>> +----------
>> +$ cat sample.txt
>> +
>> +An abbreviated revision 2ae0a9cb82 will not be substituted.
>> +The full name after substitution is =
2ae0a9cb8298185a94e5998086f380a355dd8907,
>> +while its tree object is 70d105cc79e63b81cfdcb08a15297c23e60b07ad
>> +
>> +$ git name-rev --annotate-text < sample.txt
>=20
> Lose SP between the redirection operator '<' and its file =
'sample.txt'.
>=20
>> +
>> +An abbreviated revision 2ae0a9cb82 will not be substituted.
>> +The full name after substitution is =
2ae0a9cb8298185a94e5998086f380a355dd8907
>> +(master),
>> +while its tree object is 70d105cc79e63b81cfdcb08a15297c23e60b07ad
>> +
>> +$ git name-rev --name-only --annotate-text < sample.txt
>=20
> Ditto.
>=20
>> +	if (transform_stdin) {
>> +		warning("--stdin is deprecated. Please use =
--annotate-text instead, "
>> +					"which is functionally =
equivalent.\n"
>> +					"This option will be removed in =
a future release.");
>> +		annotate_text =3D 1;
>=20
> I guess that is sensible.  To squelch the warning, they can switch
> to the new option.
>=20
>> +	}
>> +
>> +	if (all + annotate_text + !!argc > 1) {
>> 		error("Specify either a list, or --all, not both!");
>> 		usage_with_options(name_rev_usage, opts);
>> 	}
>> -	if (all || transform_stdin)
>> +	if (all || annotate_text)
>> 		cutoff =3D 0;
>>=20
>> 	for (; argc; argc--, argv++) {
>> @@ -613,7 +622,7 @@ int cmd_name_rev(int argc, const char **argv, =
const char *prefix)
>> 	for_each_ref(name_ref, &data);
>> 	name_tips();
>>=20
>> -	if (transform_stdin) {
>> +	if (annotate_text) {
>> 		char buffer[2048];
>>=20
>> 		while (!feof(stdin)) {
>=20
> Not a suggestion to change anything in this patch, but just an
> observation.
>=20
> - If the mode is useful enough for many users, certainly somebody
>   would have rewritten this loop to lift the line-length limit, but
>   nobody noticed and complained about this 2k limit for the past 17
>   years.  I am not sure if that is an indication that nobody uses
>   the option in its current form.

Would this also mean that deprecating --stdin wouldn=E2=80=99t be =
**too** disruptive to existing users and scripts?

> - A low hanging fruit, if we do not go full strbuf_getline(), at
>   least we should narrow the scope of buffer[] array.
>=20

