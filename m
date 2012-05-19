From: Carsten Mattner <carstenmattner@googlemail.com>
Subject: Re: git-completion with bash alias
Date: Sat, 19 May 2012 09:48:47 +0200
Message-ID: <CACY+Hvr79p4c1Caw=vrJ0293tz3Hub+RK4XuL1Ue-JAmt8Odxw@mail.gmail.com>
References: <CACY+Hvqd6L7gWgDBvjPmLPsfA2o1CVKuqkDZ_j7XYf=WjuwvKQ@mail.gmail.com>
	<20120519004147.GE765@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat May 19 09:49:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SVePr-0006w0-JV
	for gcvg-git-2@plane.gmane.org; Sat, 19 May 2012 09:49:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758547Ab2ESHst convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 May 2012 03:48:49 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:55288 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758362Ab2ESHss convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 May 2012 03:48:48 -0400
Received: by obbtb18 with SMTP id tb18so5046969obb.19
        for <git@vger.kernel.org>; Sat, 19 May 2012 00:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=O/0nIK4AcQ9l3TIEF19vDbbEq0clj5R4rUbDeGOeov4=;
        b=dvTrxggb4JGRiaFtuV2EP3rV4ju8SCDPupHyaFpyTDfFv1xfzuwZtQg2KAGtYsIO7V
         CCIxUa/agzaJORno0VSMGj5Xjr1ZH9J15x6OngXn+fp1D4S2WrVYsenYX1vijso1prZ1
         tgbXO+c8azv2iS/y4i2i8RF4Z45ElZNKylLiFTCqR7fAm/rake5ABCSPh2GHe8A+GjH9
         +59jaSoLUbzWkfKjYRJEJe+/DS/e1r9NZLEE6C6kfgkXrtp2f2bUvTuqVQsGKplUYIrA
         UK53TCzpIIfGaFxjHjbxqH0dHRCRqG5r6hhkQ2PAQ2tHNjkJhbvRNwj6mX9bN3+DiAip
         z09A==
Received: by 10.50.156.228 with SMTP id wh4mr182659igb.47.1337413727773; Sat,
 19 May 2012 00:48:47 -0700 (PDT)
Received: by 10.50.6.231 with HTTP; Sat, 19 May 2012 00:48:47 -0700 (PDT)
In-Reply-To: <20120519004147.GE765@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198023>

On Sat, May 19, 2012 at 2:41 AM, Jeff King <peff@peff.net> wrote:
> On Fri, May 18, 2012 at 01:35:24PM +0200, Carsten Mattner wrote:
>
>> Completion works when used as "git checkout foo" but fails with
>> "bash: [: 1: unary operator expected" when trying to complete
>> via a single character shell alias like "alias g=3Dgit" as in
>> "g checkout foo".
>>
>> git version 1.7.10.2.548.g9de9681
>
> Hmm. Are you invoking the completion like:
>
> =A0complete -F _git g

Is that supposed to be enough to get it working?

> ? That used to work, but was broken by the recent 6b179ad (completion=
:
> add new __git_complete helper, 2012-05-14).
>
> The "new" way seems to be:
>
> =A0__git_complete g _git

=46ound that in 6b179adf in next and it worked.
I used to have this
complete -o bashdefault -o default -o nospace -F _git g \
  2>/dev/null || complete -o default -o nospace -F _git g

> but that function is explicitly labeled as "not public". It looks lik=
e
> there was a follow-on patch that was discussed to make a public versi=
on,
> but it got dropped.
>
> I'm not sure if this regression is intentional, or if the "old" way e=
ven
> worked reliably (I seem to recall people running into issues with
> _get_comp_words_by_ref not being called properly sometimes, but I don=
't
> remember the details). So it's not clear to me if the right way forwa=
rd
> is fixing "complete -F _git" to work again, or if that way is just
> broken, and a public version of __git_complete is the right path.
>
> Felipe, can you comment?
>
> -Peff
