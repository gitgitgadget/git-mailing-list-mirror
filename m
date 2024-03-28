Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFBD3D988
	for <git@vger.kernel.org>; Thu, 28 Mar 2024 17:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711645818; cv=none; b=V7k3IXVDxXTxtASBKquINmqz45rLHyfIh/W/UyjDhkjzGYmhrYO+Ilz0SfFxaYElfvSY/jK1kQWox+mW9EmKrNt7IkO1IvoKkwyKaDdFUukkA7thjVd9YZbsPBmEq/F0UptFtIRhkqU91r/zj5ZEIPbg1pHoEMeaKYOgXeOX/EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711645818; c=relaxed/simple;
	bh=P+pGMA2XMKxLsgVolh3b5c4K2VgaQj7elSXzJ+s99YI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p/wbkkksVuNq37i96iQd4dQA9JGwgzH5kExdw16+2bff7sy8++8dhyI/zT9W/iJMEObx3kv080VBj1zhTGw6c4OEtBz3IHpIsZHy5J2pkGs1QQvR4Gsu6dgxVDUp5f51k+gn25vWlfjMrlxcuFsBAS8o2Ls6LpbnkBXKoBE2yEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WE9UJSHl; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WE9UJSHl"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a46ba938de0so170857866b.3
        for <git@vger.kernel.org>; Thu, 28 Mar 2024 10:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711645815; x=1712250615; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OS+19GUtaN/6LkXDt1z167ZyT51HnytPc0pWRtbosOk=;
        b=WE9UJSHl2nXdtNSnYBSLKbRegbOUmqmxwzVNxMkHWIZwf0A36vz6J0cWsaGmvrdfrY
         nGcuo0KX+amMtFEn5+PXGIKSv/hHO3YhzLDawlAJkHpbyBAIyhFqByRbgOp3VWPNNCLq
         J5USdQWDhrGS+IeQVC0/+v9pRHgnZnHkMOcottk0cqhMkd1xch4Ql5G+gc2AvR8CdoVC
         okI00Z8W/ViwSO55Irf5SytYz2dLuBTmoGHcG0exk1xmncPigXEPeJEJE75Oo1m89xXZ
         fAic7z5ZB7eGZeutdEmrLr2siqXF6NVI39MTGWjFThOXnh68n4QMl2GnLp78kdm5IOV/
         kAjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711645815; x=1712250615;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OS+19GUtaN/6LkXDt1z167ZyT51HnytPc0pWRtbosOk=;
        b=MPQpUDJU+P8eyrxl2etAbraZw/dj3Q/azT6fTiEUXNL4jwk+frzp6SVVUj0Zn5vVKD
         6SpYzShTI8Pgw/bySElXVpwKd3q+Emutdinfq1Vz6ydq+u0pmGq2UtQLXV7j19wz7oX3
         hnQdk6T8uuM7nMhNg68Q1Xzh1zFsS80Vl7P8nbjy/zH1ViRpqEmkD/OARaH7bgM7CzOa
         sEKDK2xILM5LdTO0hRQQl4mg6McCL0ONsEtPTKWGhRDw1lTkvqC8WKja3nHC64kFlcK5
         UqgPnMnwqByw8LLy0ilryuBG784+PhKwDU9FbNgmVfOgnLEdex+GBDExxLs9+U2ekU/4
         aMyA==
X-Gm-Message-State: AOJu0YzuO2pSYE8ICSIbo00xsgMs+34JBQGZxuQoiqq1UtF5w5HLDoW7
	MyGP7usUTAOTw8edI/ccJ/Z4JQMfHrlmYi0qNtqQBCaBbLfIPXbkCoGjsqokGOHzSZ3lO07W2ZR
	XLo5uDUn+RAEf3kURyjnwKtqfRms=
X-Google-Smtp-Source: AGHT+IEe2Hny6tuIr385I4Ut2gYRxNYvrCv3mJNt5O0pBjlIqU5X/theGQFrcUnbUrnA6ZYAm9INv6k4s3fNPDMFnyQ=
X-Received: by 2002:a17:907:940a:b0:a4e:196a:3457 with SMTP id
 dk10-20020a170907940a00b00a4e196a3457mr2402695ejc.10.1711645814693; Thu, 28
 Mar 2024 10:10:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHfn=+snXChcPFiEgxvK=XFCq2uVMKQTyfrN9RNfAod18d0V=Q@mail.gmail.com>
 <xmqqo7ayuwpi.fsf@gitster.g>
In-Reply-To: <xmqqo7ayuwpi.fsf@gitster.g>
From: Eugenio Bargiacchi <svalorzen@gmail.com>
Date: Thu, 28 Mar 2024 18:10:03 +0100
Message-ID: <CAHfn=+sJotET-x7wZWZH0p4znR=o909qyV6wSDq_D0+VivT67w@mail.gmail.com>
Subject: Re: Better visual separation of hunks in `git add -p`
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Thank you for the suggestion, it already helps a bit.

The problem only using indentations as a visual separator, for me, is
that if the code snipped already has indentations, then the ones added
by 'git add' do not really stand up, and instead become part of a very
long uninterrupted stream of text. In addition to this, given that the
snippet is colored, the result is a very bright and flashy wall of
text that can be a bit much to sift through (were it all the same
color it would be worse though). Being able to break up the hunks
visually with some whitespace would really go a long way.

In any case, for now I'll try to pick up the most obnoxious colors for
the prompt that I can :) Hopefully in the future this will be an
available option for difficult people like me.

On Thu, 28 Mar 2024 at 17:50, Junio C Hamano <gitster@pobox.com> wrote:
>
> Eugenio Bargiacchi <svalorzen@gmail.com> writes:
>
> > I'm looking for a way to print some sort of separator between hunks
> > when running `git add -p`, as I have a bit of trouble detecting when
> > the previous hunk begins and the current one starts. Being able to
> > print an empty line or a couple lines filled with "=======" would
> > really help me out.
>
> Hmph, my hope when I designed that particular UI was that the
> command prompt for the previous interaction followed by the hunk
> header of the current hunk would give us clear enough separation.
>
> For example, after answering "n" to the prompt for the previous
> hunk, we'd see
>
>     ...
>     +   (merge bff85a338c bl/doc-key-val-sep-fix later to maint).
>     +
>       * Other code cleanup, docfix, build fix, etc.
>         (merge f0e578c69c rs/use-xstrncmpz later to maint).
>         (merge 83e6eb7d7a ba/credential-test-clean-fix later to maint).
>     (1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,?]? n
>     @@ -233,3 +245,6 @@ Fixes since v2.44
>         (merge 781fb7b4c2 as/option-names-in-messages later to maint).
>         (merge 51d41dc243 jk/doc-remote-helpers-markup-fix later to maint).
>         (merge e1aaf309db pb/ci-win-artifact-names-fix later to maint).
>     +   (merge ad538c61da jc/index-pack-fsck-levels later to maint).
>     +   (merge 67471bc704 ja/doc-formatting-fix later to maint).
>     ...
>     (2/2) Stage this hunk [y,n,q,a,d,K,g,/,e,?]?
>
> The '@' (the first character of the hunk header line for the current
> hunk) and "(1/2" are surrounded by lines that begin with a space,
> and the hope was that it was sufficient "separator" already.
>
> These days (long after I stopped mucking with the interactive add
> code actively), the prompt line is painted in prompt_color (you can
> tweak it with the color.interactive.prompt configuration variable,
> it defaults to BOLD BLUE) while the first part of the hunk header
> line is painted in the fraginfo color (default CYAN), which should
> give you even more visual distinction.
>
> Perhaps
>
>     [color "interactive"]
>         prompt = bold red reverse
>
> would be sufficient?  I dunno.
>
