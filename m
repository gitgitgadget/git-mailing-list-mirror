From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH/RFC v7 1/2] Add infrastructure for translating Git with 
	gettext
Date: Sat, 5 Jun 2010 19:47:24 +0000
Message-ID: <AANLkTimeaQeCoGREwwaOdaW6c9WTUNZF9oLfNZy7DVo3@mail.gmail.com>
References: <1275704035-6552-1-git-send-email-avarab@gmail.com>
	<1275704035-6552-2-git-send-email-avarab@gmail.com>
	<20100605025702.GA2019@progeny.tock>
	<AANLkTil541q0RtZsEmnLOtUNxfltvcFCGxpxR-myhyDl@mail.gmail.com>
	<20100605033626.GA2252@progeny.tock>
	<AANLkTimHZdT3vfuUyG1cnanE3WLrhDGqqw5JyYfza6wD@mail.gmail.com>
	<20100605192717.GB5273@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 05 21:47:33 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKzL9-0004QP-VA
	for gcvg-git-2@lo.gmane.org; Sat, 05 Jun 2010 21:47:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756903Ab0FETr0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 5 Jun 2010 15:47:26 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:36444 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756854Ab0FETr0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 Jun 2010 15:47:26 -0400
Received: by iwn37 with SMTP id 37so2144915iwn.19
        for <git@vger.kernel.org>; Sat, 05 Jun 2010 12:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=5JErp6XG5N+p3dOzeo+2zihg27BZmds37uZkJm9PlqE=;
        b=hVIaKlWsd8zUZBvDFh5Z5Ev6Q7COq0+iPO4Hzd/MEi60byZnULrlVMnhJraK5K2mCP
         D6mqfv0w38nCa3ki/jC8bm6Ru12O6aI0Diuz3vMG2p+PxrzaODFKT3rrHMYRy5C/D0ht
         KourmwLwJ0sX+AO2jrpTPMDKtMSdJfkzMHP2o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=uN4P+kgxT3h3CsgIW9aYZvCShOVqUk32oerXSJ8VIcatGJotyzQY7aZf9znpgwIEiI
         ag5jD6VsOXVa8buX9n+ZDAcBGSrc0mPuIBeK5omcu1oqKpZTJLP7xHKIfw1epH2Ax2U6
         cUv/5Kpj+baw0gaTaI3MxQmEyblBLJ0YxPaVM=
Received: by 10.231.178.132 with SMTP id bm4mr15088012ibb.62.1275767244460; 
	Sat, 05 Jun 2010 12:47:24 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Sat, 5 Jun 2010 12:47:24 -0700 (PDT)
In-Reply-To: <20100605192717.GB5273@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148490>

On Sat, Jun 5, 2010 at 19:27, Jonathan Nieder <jrnieder@gmail.com> wrot=
e:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> IMO trying to plan in advance what we should and shouldn't translate
>> is a bit premature.
>>
>> I think it's better to just add glue so that everything can be
>> translated, then we can try decide later if some arbitrary subset
>> shouldn't have translations (even for human readable error messages)
>> and act appropriately.
>
> Certainly there is no need to commit to decisions that will have no
> observable effect. =C2=A0However, setlocale()
>
> =C2=A0- takes some small amount of time (probably negligible);
>
> =C2=A0- changes the semantics of regular expression matching
> =C2=A0 (this affects =E2=80=98git grep=E2=80=99, =E2=80=98git diff=E2=
=80=99's search for a function
> =C2=A0 header, and http-backend=E2=80=99s service-command regexps);
>
> =C2=A0- changes the human language used for strerror().
>
> We could avoid these issues by turning translations off by default an=
d
> calling it experimental, which might be the right thing to do anyway.
>
> Alternatively we can make some choice and stick to it (e.g., all git
> commands use setlocale(), or just the translated ones, or whatever).
> I just want to ensure it is a conscious choice.

What I'm trying to do is to make Git follow the semantics that
localized programs that use gettext traditionally do.

Everything that's translated on my desktop does pretty much what this
patch series does, i.e. calls setlocale() very early in main() so that
everything's translated and locale aware. Including strerror()
invocations and locale-aware functions like grep.

Whether it's the default or not doesn't really matter to me. Normal
users are going to get Git via their OS, and those turn on l10n
support as a matter of policy if it's available.

But since the semantics of Git will be the same unless users
explicitly request translations (by setting the LC_* variables in
their OS) I didn't see a reason not to enable it by default.
