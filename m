Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD8A1A0B08
	for <git@vger.kernel.org>; Tue,  3 Jun 2025 20:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748983066; cv=none; b=b20qma/7HTZ+4SHcvV9R6rasOalAg1JAym36kYpK8bN6Wso4kOmeEiZrLOJfoRfEk5SFeeMsvVDJCDepF86jzDoxwQrlxuUBqDda2qBbxjs/uLBq7bAb6ij9eQbHys+b+k2Kbazbmt5A8nJr47hB2VONxARIdXlYyLARsDpF/1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748983066; c=relaxed/simple;
	bh=GnBsDnp1k3UiG4hxRb3vfgHH9uUylRV4+1KBhLGq7E8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iag+51GhAzhMy5GbNpLEm4aAjUXMB1y3rIq5xJ1C3uPHcVqItynkXXhtEFdpo0L2DlowmABLGlNTTgrWpClslgqUUeYcYQbEnNZw86JAEDQpvEyNxI/jenytXCmWf9o9oIohrxQgzquw/n9TDYaLo2PSdd0wncdc+ZXEQC0JkZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BJpUiteg; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BJpUiteg"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-addda47ebeaso446175766b.1
        for <git@vger.kernel.org>; Tue, 03 Jun 2025 13:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748983063; x=1749587863; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EYWr+un1sGVXNw+yuwbohxWiMzzmDJtyw0pteGh/EhY=;
        b=BJpUitegjByrwiNsiJ1/UKhUZRebADO2Eb0cXShqfV5ffVJFxf3vueVPI834/6bVTJ
         +i+7FMbJOfdobrboawPMDAsTr8TwOvBDh1RwSB1pzGUEldvmBo1TPfKXFxe8kAsQ40Xt
         ZDlEMf78dcPY8BCxZboVA/27cKJhBNkDaOarqJnofapCmzgtuGzh/50PrErw23reM8fc
         lGWTEvJ+e2p2v2mQRNR5CWfO8pfWT3fDGv679w4OviO1PIQWZT9SLIat49HNeLuWwfCl
         9ntY2qpCO+jmb9LOps5vEJHRE1rUAsf8puPQZhKeTXQjIdeG3a6Ggpl3yFAk9Tv1HEXx
         WipQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748983063; x=1749587863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EYWr+un1sGVXNw+yuwbohxWiMzzmDJtyw0pteGh/EhY=;
        b=qCdmYs+rqYqbirlBrbkUthRUZjDMdSwGHwGkWXy6UmPleJzso/qSZK5YL+xYECa7Fo
         dzN8J3R2mR/ESPa41/8XT6YeMvH/unXwnF9RzSpfxjo7O10EiZPtuiR6KmxwBm/G672Q
         ijKzOs6Y6eQbYCADf6s0/AmcPGWyGVFKLank3tSofdkZcVw/JSFlUdhh/DIoPIe5kpva
         4HhddHoSmsFGidIsQAKmXt0PU8adXmdf9fYC8frnZBJoJBIgCKgympxMGWwbrrtR4tMA
         DE3L/+jpp6Xnp0Mmnk/FaNo4XCiX1xYslpwUiq6niDP35vA4PPtqXPlMi2ulkXpJTF2p
         UbmQ==
X-Forwarded-Encrypted: i=1; AJvYcCW54llVer1nFXaSYrtb4iS4Zmt8WgP5V3wpqmAiJGZEugjLXLpO5geI//0ofCrfEalp/Ps=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo9/joz2zZwd/lbR/2L76r+PNlandrFNegIYU3LeADYsoAkmdB
	oHEuXYP96xi8ZNa7IZBlOL738Gk8hqAdPkFQ7reCy8BrqdeFPkYd3MVaB6i9cwWusOsvN238DqR
	HgdmVvvih7ZSCCv2NtuGELlJZgoBXhrI=
X-Gm-Gg: ASbGnctbR8apuyIcFArwj0SGDq5Nvfaw4IKo9YjpPnsh/OTmGzgvySjlWwCSuLA9hn4
	f94HTLoKz1QtdSIoOyHdbIiobQ4bq7qhd90hAa8UmYIZi1WOTTx1kWgwNMp+75ODohdsPYDvkRO
	idJjjvflpslCzh2o7QlN62uKE8HAmSA+vkz2C82oXRXkrkLGj5o6X8aO7dhS19iBCOmA==
X-Google-Smtp-Source: AGHT+IFxHjAeM+ubAwzMSYGANrvKK9/tMQM5ZBxITd1nmyVMSbQSUp8C2SKnuJEkcL+ixzw/3JPO1x89tqyccKFne5k=
X-Received: by 2002:a17:907:7f8a:b0:ad8:9e80:6ba3 with SMTP id
 a640c23a62f3a-addf8cca365mr807866b.7.1748983062813; Tue, 03 Jun 2025 13:37:42
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c59ae2c0c7c8420ec1c5bedb87f28c7f5b573a60.1748122397.git.code@khaugsbakk.name>
 <66e92d69-8372-47cf-a350-95365f72ca1c@gmail.com> <xmqq5xhmvuol.fsf@gitster.g>
In-Reply-To: <xmqq5xhmvuol.fsf@gitster.g>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Tue, 3 Jun 2025 16:37:31 -0400
X-Gm-Features: AX0GCFv8eE3bduhtVU7iY8ILAAaQfvgRmQl0uklgydR_DIMl2WvCJ-gD41zerGY
Message-ID: <CALnO6CDgcQCuhxcJLH-XwxB85mxqokxsf04CU4yseTy-=XUWLQ@mail.gmail.com>
Subject: Re: [PATCH] notes: remove trailing whitespace from editor template
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>, kristofferhaugsbakk@fastmail.com, 
	git@vger.kernel.org, Kristoffer Haugsbakk <code@khaugsbakk.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 27, 2025 at 1:31=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Phillip Wood <phillip.wood123@gmail.com> writes:
>
> > Hi Kristoffer
> >
> > On 24/05/2025 22:35, kristofferhaugsbakk@fastmail.com wrote:
> >> diff --git a/builtin/notes.c b/builtin/notes.c
> >> index a3f433ca4c0..ca4782eca19 100644
> >> --- a/builtin/notes.c
> >> +++ b/builtin/notes.c
> >> @@ -180,6 +180,8 @@ static void write_commented_object(int fd, const s=
truct object_id *object)
> >>      if (strbuf_read(&buf, show.out, 0) < 0)
> >>              die_errno(_("could not read 'show' output"));
> >>      strbuf_add_commented_lines(&cbuf, buf.buf, buf.len, comment_line_=
str);
> >> +    /* strip trailing whitespace introduced by blank lines */
> >> +    strbuf_stripspace(&cbuf, NULL);
> >
> > It doesn't make any difference at the moment but I'd be happier if we
> > stripped the trailing space from the commit message before commenting
> > it out.
>
> Yes.  I had the same thought.  If Kristof does not like the fact
> that one automated source of information consistently indents its
> output lines, even an empty one, and if users may have legitimate
> reason to place in the final output a trailing whitespace in the
> comment, it is better for the patch not to close the door to the
> others.
>
> In this case I am not all that sympathetic to the idea of the patch.
> The consistently indented lines makes it more clear from which line
> to which line came from a commit log message; running stripspace
> would break them into paragraph pieces.  These editors that complain
> probaly can be fixed?

My editor doesn't complain, but it does highlight trailing whitespace
at my behest, and it tends to be an eyesore (on purpose: that way I
clean it up). Perhaps Kistoffer is coming from a similar place?

>
> Alternatively, if it bothers users of certain editing environments
> too much, perhaps the indent code in the output phase of "git show"
> should lose the indents for empty lines uniformly, shoudln't it?  It
> probably should be a fairly isolated change, like the way how the
> expand_tabs_in_log bit is handled in pretty.c; give another bit and
> teach pp_handle_indent to return when that bit is set and the
> payload it was asked to show with indentation is empty, or something
> like that.

I think this suggestion would also help folks who "git commit -v,"
which IIRC is also indented in the template.

>
> > Should that be " \$"? What you've got seems to work with dash but I'm
> > not sure if it is POSIX compliant or not.
>
> "2.6 Word Expansions" ends with this sentence:
>
>     If a '$' that is neither within single-quotes nor escaped by a
>     <backslash> is immediately followed by a <space>, <tab>, or a
>     <newline>, or is not followed by any character, the '$' shall be
>     treated as a literal character.
>
> Taken together with "2.2.3 Double-Quotes", I'd read it as blessing a
> lone '$' at the end of double-quoted string as a literal dollar sign.
>
> Thanks.
>


--=20
D. Ben Knoble
