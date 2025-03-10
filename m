Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80EE54437C
	for <git@vger.kernel.org>; Mon, 10 Mar 2025 21:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741643107; cv=none; b=l+r9E4QRRY2Thd73TrphW1UC6WO58X0P4TRPDh38ySw5FP5+jErGvTNHNhNoYAslVmf5yWae+oAebaIXgaeTtiVkXalj/LNKGK2m50AhlpUzuAGi03AHDSwLWMLk98hQF9ZaC5a2FBKnbfGYP5MswiHusUDrwoB9cDhCzp4/6yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741643107; c=relaxed/simple;
	bh=Gkvbw4/YE9zKFXTx5DdC1m1l517q/7r780a5MhpKvrM=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mGX00UnJ1TRSeHxxWUMb+9E8xQjn44osLsGGy6Qqb93tNrty/7eIJX+d9UauPzY+EEUXi9jHkSNQhHXUtOpKgK38sBq1e550TcNCGqQyXLGEv65i10ZgdBvQe+0dE+IFaa66B+GewVN0cQ3BO6kbwHVWMzXfy2kcTBFZRGec6dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZWSPpf9x; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZWSPpf9x"
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-86d2fba8647so4379344241.0
        for <git@vger.kernel.org>; Mon, 10 Mar 2025 14:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741643104; x=1742247904; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=By1xJhhQnXUqnAdCbu5ZB+Ybdl2GtIP/2euAELng64w=;
        b=ZWSPpf9xg3/WI+48nYq3s8mo24vYYkrQ+0EUBIoOPkcpq6W/geg/h9/7GnoRrXEFF7
         bOC8mVFiBKVoZkmnFZR+H2wIN/JJ8jlp1KNClv/NG/5P4Bq6y2vmssNaE5V/wzrrCKCd
         NvmZPH/j9MPdnQzh0C86h9++ETmqmvaZ7O4aBexroXWu3p9h0S+G9MVjVl39j0sGMi9x
         JUNmBBNf9N208OUO70u4GYOAs3/tWS5gHqVxU5H8EGLqO7jEvMU8IUyawmQ2GxCB2wyk
         HahdboOuia6sCLRE5n/GXIjCF8j9o1pWVvaTNl1HWSvzubuVQz9YH97YCQWuxT/uOd33
         CpQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741643104; x=1742247904;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=By1xJhhQnXUqnAdCbu5ZB+Ybdl2GtIP/2euAELng64w=;
        b=N4RdClKs+AqmWtaDZkjITzGP0333ch+Vpx1mphkdg4auw9jr2QDJRKbS5aAB8zYxoY
         fQNIQoytdeLx1Topf1PcpIjIR+SH/5p/xAaxVTdbpxdDsyMURBexx/q/sQKXquuPFEVZ
         qHTVFjfL8maTJAa+ViuWNaGg82auLaqJfc+lOyFoV66SXfFlmGW1qjY3/yuRGIrexDGE
         jgynUft66bcS2lbQwuDbtx7YUwwiR05zXUI5KzmwPss0R2/2jb3KKyA5nNvsAxT2w9j0
         /fbtXY3YooJyvUvKhfR0KHOF3TmFmmkcgCfCQj8i2TWPCrxeQuiEZEiJRG/jffYd5BsN
         jv6A==
X-Forwarded-Encrypted: i=1; AJvYcCXxrYP5amsys+yt0l2oTqg1dEzZBjzi9wVltWinR0CgWapXA64M6ABpAMJ2Xan4vWY3NK4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcDSCkAJvwqAUF0EpqzKFKwbH8fs+2rlqccE2Z5sptE7ypyrzZ
	fUkVzmfavmNeVpLwyvFXXIj2r7gTynTe+UDBr7tazmuHnZ7HGSqBcdwfdcs84FlnTMgrvXxomAz
	H4uQYuAAuCBeEYrMRlkDmSZDiVk2rhVJV
X-Gm-Gg: ASbGncuR3YtuTHVeL0Siyr5QFNm5hdjNZvwQnZuhW8zZckYIhw0D2xf4oWH81llUA39
	g6zTf3sPXJCJavt3VK6Kvia3+Dg4IeL3WXxJk7c3vfMAgWfiOTnXgCNaxmLSTtaxyae3ElCrGv1
	ZxLtjaiZo8eb/h3HN61/tm/nW0YDF2zuncudkydr8y2HE9ueEYOgIkaseyH5c8
X-Google-Smtp-Source: AGHT+IHmnxUWiVRL6+UMNIMfJlNxXiiCa3EozqGcVqWO15lZXnXb/ez7lEwIUPso60YlQQinYq2fcp8uNQ/KDlpJXsE=
X-Received: by 2002:a05:6102:f09:b0:4bb:d062:452 with SMTP id
 ada2fe7eead31-4c34d1f6846mr1478960137.3.1741643104200; Mon, 10 Mar 2025
 14:45:04 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 10 Mar 2025 14:45:03 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <CA+rGoLfTJSHQZTvNBgfcMmGjJwqak+wGHh9PRhHfqHSxB2p6-g@mail.gmail.com>
References: <CA+rGoLc69R8qgbkYQiKoc2uweDwD10mxZXYFSY8xFs5eKSRVkA@mail.gmail.com>
 <CABGrwBDLO9=FCjUW_LfJ_RZ95bRXWHFFNvdJfOuiYocGXdj3Mg@mail.gmail.com>
 <xmqqo6ybb48p.fsf@gitster.g> <CA+rGoLfTJSHQZTvNBgfcMmGjJwqak+wGHh9PRhHfqHSxB2p6-g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 10 Mar 2025 14:45:03 -0700
X-Gm-Features: AQ5f1JrCtENhZFbmI0QfoLPFOiKFaQEeuiw5c7gbpL86IQczuNlg94eOarFyjbg
Message-ID: <CAOLa=ZTVOBNMLHE0Wa=vpYdcy56V+S1QdQM1Rk8XWQye32tL0g@mail.gmail.com>
Subject: Re: [GSoC] Microproject: Updating Documentation
To: JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com>, Junio C Hamano <gitster@pobox.com>
Cc: Mahendra Dani <danimahendra0904@gmail.com>, git@vger.kernel.org, nasamuffin@google.com
Content-Type: multipart/mixed; boundary="0000000000008d474f063003e267"

--0000000000008d474f063003e267
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com> writes:

> Hey Junio and Mahendra, Thanks for your responses, they=E2=80=99ve been s=
uper
> helpful in guiding me as a new contributor!
>
> On Sun, Mar 9, 2025 at 2:59=E2=80=AFAM Junio C Hamano <gitster@pobox.com>=
 wrote:
>>
>> Mahendra Dani <danimahendra0904@gmail.com> writes:
>>
>> > I'd suggest trying to submit a microproject listed in [1]. Further,
>> > please go through the General Microproject Information[2] and
>> > MyFirstContribution[3].
>>
>
> I've gone through the links posted by Mahendra and read the micro
> projects list too.
> I've also explored that we as students can have our own idea as long
> as it doesn't get too involved.
> These emails actually cleared up a lot about how microprojects are evalua=
ted
>
>> All good suggestions, but we also welcome students who try to
>> scratch their own itch, as long as it is small enough to be suitable
>> as a microproject material.  And it is fine to ask if doing X
>> qualifies as a microproject or if it is too involved.
>>
>> The primary objective for a micro-project is to get used to the
>> workflow, i.e. working with the community mainly via this mailing
>> list, how you explain your changes in your proposed commit log
>> message, how to work with those who gave you reviews, how your
>> updated submission should look like, etc., etc.  Given that, it is
>> rare that anything is too trivial as a microproject material, but
>> you would not want to choose something too involved, as it would
>> slow you down in learning the procedure, which is the main focus on
>> the microproject period.
>>
>
> This really helps set expectations as learning the workflow is my main
> goal here, so I=E2=80=99ve picked small fixes that I think will help me g=
et
> familiar with the process.
>
>> Another thing I noticed in the original message that is worth
>> reacting is that you do not need to ask for permission to start
>> working on anything around here.  "Am I allowed to do X for my
>> microproject" is not the question you want to ask; rather "I see
>> document X says A, B, and C, but A is outdated and I think it is
>> better to phrase it like D.  Would it be a suitable microproject
>> material?" is something we can work with. Answers may depend on the
>> nature of A, B, C, and D and would range from "nah, A is fine and D
>> is not better because ...; don't do it" to "great, yes A may have
>> been suitable a decade ago, but no longer relevant, and D would be a
>> great addition", to "Yeah, I agree that A is not great, but D is not
>> all that better, how about E?", to "Yes that is a great suggestion,
>> but wouldn't it may be a bit too much as a microproject".
>>
>
> Got it, I=E2=80=99ll focus on being specific about what I see and what I=
=E2=80=99d change.
> Here=E2=80=99s what I found in "MyFirstContribution.adoc" and "config.h" =
my
> proposed fixes:
>
> 1. Outdated Function Signature in Documentation In the "Adding a New
> Command" section
> (https://github.com/git/git/blob/master/Documentation/MyFirstContribution=
.adoc#adding-a-new-command),
> the signature for cmd_psuh() is:
> int cmd_psuh(int argc, const char **argv, const char *prefix);
> But the current Git codebase (builtin.h) expects:
> int cmd_psuh(int argc, const char **argv, const char *prefix, struct
> repository *repo);
> This mismatch caused compilation errors when I tried following the tutori=
al.
> Proposed Fix: Update the signature in the doc to include struct
> repository *repo.
>

Yes, this would be nice for users who try to follow the guide.

> 2. Unused Parameters Handling Not Documented The tutorial code doesn=E2=
=80=99t
> mention that unused parameters (argc, argv, etc.) will trigger
> compiler warnings. The current Git codebase uses the UNUSED macro
> (e.g., as seen in cmd_check_ref_format in builtin/check-ref-format.c)
> to handle this, but the doc skips this detail.
> Proposed Fix: Add a note in the doc explaining how to use the UNUSED
> macro for unused arguments, and update the example code snippet to
> reflect this.
>

This seems worthwhile too!

> 3. Incorrect Config Function Reference In the "Implementation" section
> (https://github.com/git/git/blob/master/Documentation/MyFirstContribution=
.adoc#implementation),
> it mentions git_config(...), but config.c doesn=E2=80=99t define it.
> I had to use repo_config(...) instead, which isn=E2=80=99t documented her=
e.
> Proposed Fix: Update the doc to use repo_config(...) and explain its usag=
e.
> Additional Note: I can also edit the config files to appropriately
> correct the git_config() function if needed, but I=E2=80=99d require some
> guidance as to not mess up other programs while doing this as I
> believe config.c/config.h is used by a lot of other files too.

I think for new commands and also for new users, it is not worthwhile to
get into how the `USE_THE_REPOSITORY_VARIABLE` macro works.

So I think it'd be best to modify the documentation to use
'repo_config()' as you suggested here.

> 4. Outdated Reference Link The doc points to a GitHub repo
> (https://github.com/nasamuffin/git/tree/psuh) as a reference
> implementation,
> but it=E2=80=99s not updated to the latest Git version, which confused me=
 when
> I tried following it.
> Proposed Fix: Update the link to a maintained branch or clarify its statu=
s.

This is a bit hard, since this is linked to an external repository.
Generally the code referred to in this document doesn't seldom change,
so I think the easiest way to update this would be to raise a PR to
Emily's repository with the update, so the link could stay the same.
CC'd Emily in this email.

I also see some more potential fixes to the documentation, which you
could also overtake (if you wish too :))
- Remove git-mentoring@googlegroups.com [1].
- Rename 'Documentation/git-psuh.txt' -> 'Documentation/git-psuh.adoc'.

[1]: https://public-inbox.org/git/CAJoAoZnk88ZFZFdEtUxMnUa1OZiXYOgcw8DSbB+A=
0LzyCPFugg@mail.gmail.com/

>> To solicit such productive reaction from others, you'd need to be a
>> bit more specific than "I see flaws and want to improve".
>>
>
> I seek feedback as to if this mail is well specified or do I need to
> improve in any parameters.
> I also seek feedback in terms of my understanding with Git workflow
> and also with my understanding with Git codebase. Any feedback will be
> great for me.
>

I think the changes you suggested would be great to have. Looking
forward to the patche[s].

>> Thanks, and good luck with your microproject selection.
>
> Thanks again,
> Jay

Thanks for fixing documentation, it is very important to keep them
updated!

Karthik

--0000000000008d474f063003e267
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: b8d4ca07deb4d39e_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1mUFhWNFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mejBUREFDbERDWWNWS3g3NERqWXZaVE5tNGFlMXB3Ugp1RlRhYng5cTJ2
KzkyTEI4L2pWZjl6UXUvZElMcW4wWkdhSzIwUGZOSXp1K2hEd3FwdVFvZHhPcDc3NGM2NkRxCkxh
SUk3dWkzdjc5TjlqTVJ0bnVYVkUwOGhwaHZWeVhrWWxHYWJ4M0dJQ3owZ3ZBL1RCVStOZ3p3Sytm
czM1VW4KRXpXT21kcTNGbkYwUXg0K083YnZ1SXY2Z1pxMGY0RWhSNDZTUms2VEFseTVUZGxWajRZ
b29QdGFoS1BVTjllKwpnU2U5NHVWc3haLzJqUmRoYjZ1RU5UTk9wUFBzT01PUjVrSVkvOXBNV2Fn
emVFby9vdjd4ekd5T3VMbkd3YWYyCmdidlVPYXFjUkVjTm5ybEZyRmIwVVhOUk9sM2xKNHk1OHht
RjV5d241RloxMVhuMVNnd1MzZHVpNjRBOGlRaGYKemhzVHNrNjd1VVNHdkh6M2lLNkpFb0NUZnlJ
Z0xWNXhGRStiYy9tWmVJeXEvemMzaHZQc1h2QjErY2ZkTDdtRwpSeXI5TGRRN3djRzZoZzArcEdn
a3pveTNKcUdreVNEbDZkeVZKZXU1N3UzWlZMaDhnQ1JFRHl4aDFHSU1jcHFLCk9NVHlWanRvTldr
bFVoT0E0bjN1Z2t4dUlPbjR0TUZ6M1FZNldzTT0KPWRqdkQKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000008d474f063003e267--
