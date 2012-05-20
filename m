From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 0/2] completion: backwards compatibility fix
Date: Sun, 20 May 2012 12:28:35 +0200
Message-ID: <CAMP44s2sJaW-n7EGTu+hNNkaEnGkk7wKDQD56bgq2=qeeFqWrw@mail.gmail.com>
References: <1337395295-29162-1-git-send-email-felipe.contreras@gmail.com>
	<CACY+HvqhJf6ywTaDgT5ie-3iBQAGwngTYPiCvKgw6mJB=1+fOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Carsten Mattner <carstenmattner@googlemail.com>
X-From: git-owner@vger.kernel.org Sun May 20 12:28:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SW3NU-0003Z9-1F
	for gcvg-git-2@plane.gmane.org; Sun, 20 May 2012 12:28:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752081Ab2ETK2h convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 May 2012 06:28:37 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:37192 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750745Ab2ETK2h convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 May 2012 06:28:37 -0400
Received: by lbbgm6 with SMTP id gm6so2885164lbb.19
        for <git@vger.kernel.org>; Sun, 20 May 2012 03:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=A3Of0kwUe15wHv6TJxxp64b7pAu0vTmGfQCChlKxAyM=;
        b=ofmPuAM0goO2GuzZZ2CheHsRi/efpWd1eJvZF8Qwc9tmu2ouApwurqO4oQfSEUW1Kn
         ZMUewkdzQzENo9TcgrWdM1aNbV8cusSThn3xsBeWDLwqnJ+oJJLk3MRpUd8J/yEFOqaQ
         6zsdotYBMEzCvWDmjIXgFdZoHfFcpgOszuJIri/VngEqHi+u+6bmJjZLtasSg3yQA1OA
         BGVaqRiO/4JSMABGxuAG8WbHP0HmT/LkR8YXLXrh8hBUAv2af0N5WGa2tvLsjwT/1M1Z
         L7Z2JQ3Was8XdzSiNdwf/WrQkLMHp17fuAMRlHT4pfcCtoOqdzD/BzUliENqG+fdMKA3
         sSPg==
Received: by 10.152.108.38 with SMTP id hh6mr16190138lab.28.1337509715296;
 Sun, 20 May 2012 03:28:35 -0700 (PDT)
Received: by 10.112.107.65 with HTTP; Sun, 20 May 2012 03:28:35 -0700 (PDT)
In-Reply-To: <CACY+HvqhJf6ywTaDgT5ie-3iBQAGwngTYPiCvKgw6mJB=1+fOg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198056>

On Sun, May 20, 2012 at 11:02 AM, Carsten Mattner
<carstenmattner@googlemail.com> wrote:
> On Sat, May 19, 2012 at 4:41 AM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> Hi,
>>
>> These two patches are meant to fix the backwards compatibility of _g=
it, and
>> _gitk. This also helps my zsh's wrapper.
>>
>> Felipe Contreras (2):
>> =C2=A0completion: rename _git and _gitk
>> =C2=A0completion: add support for backwards compatibilit
>>
>> =C2=A0contrib/completion/git-completion.bash | =C2=A0 22 +++++++++++=
++++++-----
>> =C2=A0t/t9902-completion.sh =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A02 +-
>> =C2=A02 files changed, 18 insertions(+), 6 deletions(-)
>>
>> --
>> 1.7.10.2
>>
>
> Thanks Felipe. With the 2 patches applied all the following
> completion definitions work.
>
> complete -o bashdefault -o default -o nospace -F _git g 2>/dev/null \
> =C2=A0 || complete -o default -o nospace -F _git g
> __git_complete g _git
> __git_complete g _main_git
>
> Ignoring backwards compatibility, which one would you suggest
> I use? Keep in mind that I originally copied the first
> long completion defintion from git-completion.bash a long time
> ago.

I would use '__git_complete g _git', but keep in mind that none of
these forms have a promise to stay. Eventually the final one would be
'_GIT_complete g _git' (hopefully), but if you want to be safe from
changes maybe the first (original) would be best; even though there's
no promise it won't break, we would probably try our best not to break
it (again).

BTW. If your system has the '-o bashdefault' option you probably don't
need the full form, just:
% complete -o bashdefault -o default -o nospace -F _git g

Or if your system doesn't:
% complete -o default -o nospace -F _git g

Cheers.

--=20
=46elipe Contreras
