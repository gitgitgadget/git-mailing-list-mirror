From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3] completion: add new _GIT_complete helper
Date: Sat, 5 May 2012 19:20:38 +0200
Message-ID: <CAMP44s2NRMxuvQXk4RyqFYR=oQw_vrJhmbdwtXsrg=eHhGBS2w@mail.gmail.com>
References: <1336231400-6878-1-git-send-email-felipe.contreras@gmail.com>
	<20120505155423.GA14684@burratino>
	<CAMP44s1dhAjKt3mxVmg2+0qp-QTyjYb1knhxf+m177Cg2ZBC1Q@mail.gmail.com>
	<20120505164736.GC14684@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 05 19:20:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQiey-0008TZ-Dt
	for gcvg-git-2@plane.gmane.org; Sat, 05 May 2012 19:20:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757306Ab2EERUk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 5 May 2012 13:20:40 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:41974 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757177Ab2EERUj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 May 2012 13:20:39 -0400
Received: by werb10 with SMTP id b10so507049wer.19
        for <git@vger.kernel.org>; Sat, 05 May 2012 10:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=lAy7FRxa5fU6b6aMGIG/+qbb/EfOtFRakjXkaMVWtPc=;
        b=Gkw93IhZwRCUAILMNEy9WZqdkge9ea68xMwC3Ii0x11BglqPR0+2OWk0Xm5tS23ks4
         UHyy71v1RxgE0Xpn3At0qGRf4ITSr21MprUoCRgVLAjZBlAh58VjFE18wiPCA95v5qPe
         UfONpDUwvdoPzSx1Jp3w+HyyNVTglS2y5s77azhYVnbbcQ9MbBl87IhXMiTh0FEZFMe0
         lndq0gkg4bgs6ynKZtuxCvQOkMnjbVz5/bZkdswK8euAGVcizFpDpkOSCPF9tmP/oZW8
         NZlM/Sjxoyr2DjC7BtlWRQPd/zo2rqWwAKGp49TNKsVd/76MAUsmtNNLBi+oJjUE1lJC
         BCzg==
Received: by 10.180.75.241 with SMTP id f17mr22227784wiw.11.1336238438089;
 Sat, 05 May 2012 10:20:38 -0700 (PDT)
Received: by 10.216.124.197 with HTTP; Sat, 5 May 2012 10:20:38 -0700 (PDT)
In-Reply-To: <20120505164736.GC14684@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197127>

On Sat, May 5, 2012 at 6:47 PM, Jonathan Nieder <jrnieder@gmail.com> wr=
ote:
> Felipe Contreras wrote:
>> On Sat, May 5, 2012 at 5:54 PM, Jonathan Nieder <jrnieder@gmail.com>=
 wrote:
>
>>> Following a convention similar to the bash-completion project's
>>> proposed future convention doesn't really help compatibility. =C2=A0=
If we
>>> want to be able to include this function in that project without
>>> change some day, we'd have to call it _BC_git_complete. :)
>>
>> No, that's for bash-completion's functions, this is a git bash
>> completion function.
>
> Please read again. =C2=A0"If we want to be able to include this ...".=
 =C2=A0I
> assume we do not, but that would be the reason to follow their
> convention to the letter.

We don't know what is their convention, so we can't possibly follow it
to the letter. From the looks of it, they want _BC_* for *their*
public APIs, we shouldn't be using that:

http://article.gmane.org/gmane.comp.shells.bash.completion.devel/3158

> [...]
>> But wasn't you the one that suggested we follow the bash-completion'=
s
>> guidelines, or that was only when the guidelines happened to match
>> your preference?
>
> Sorry for the lack of clarity before. =C2=A0I like to hope that "Beca=
use
> Jonathan said so" is _never_ the only justification for putting up
> with a technical change you disagree with.

And I'd like to think that when you filibuster a discussion there's a
good reason for it.

> In this instance, my
> personal justification was "Because our completion scripts are alread=
y
> using this convention, which happens to come from bash-completion's
> guidelines and here are the reasons behind those".

I see, so the bash-completion guidelines was not the main point, that
was just extra sauce?

Then it would follow that if the bash-completion guidelines were
different, that wouldn't change your main argument, because the
reasons would be the same. But when I argued that there were no such
bash-completion guidelines you didn't just drop this side-argument,
you pressed on it and even included the bash-completion mailing list.
So all the discussion about the existence of these guidelines was
pointless?

I am going to refrain from expressing what I think of this.

> Also, I think you have misunderstood me. =C2=A0I was asking G=C3=A1bo=
r for input
> because you were proposing changing a convention and I thought G=C3=A1=
bor
> had been maintaining the completion scripts. =C2=A0I was not trying t=
o say
> "Please don't do this".
>
> I was not inviting you to argue with me.

Then I'm going to ignore your arguments about bash-completion guideline=
s.

This is what I propose:

1) We name the new function __git_complete; this would be a temporary
name, the function would not be meant to be public
2) We discuss later what would be the namespace for public functions,
and rename, or add wrappers for them (e.g. _GIT_ps1, _GIT_complete)
3) We standardize the odd functions: __gitdir -> __git_dir

Cheers.

--=20
=46elipe Contreras
