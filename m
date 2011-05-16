From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Bikeshedding advice on the ab/i18n-scripts series
Date: Mon, 16 May 2011 22:53:44 +0200
Message-ID: <BANLkTimtofA7xVBW-W+20zqUt98GLSPHdw@mail.gmail.com>
References: <BANLkTi==pxyy7OeZT0mn33iJHrc5R7vHBw@mail.gmail.com>
	<7vboz2l6h1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Erik Faye-Lund <kusmabite@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 16 22:53:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QM4nW-0004Vv-KL
	for gcvg-git-2@lo.gmane.org; Mon, 16 May 2011 22:53:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755727Ab1EPUxq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 May 2011 16:53:46 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:46080 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752303Ab1EPUxp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 May 2011 16:53:45 -0400
Received: by fxm17 with SMTP id 17so3361897fxm.19
        for <git@vger.kernel.org>; Mon, 16 May 2011 13:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=NzYjYcTQ7kn+5XgzQvZWSH+19hk1rWrN/P3IDG9+8Nc=;
        b=ECaUJIKVigjVZyyKyQb+3iLQqFjYVQtbBwU+ihi6LeUJM7wYh9RH+qfj8XbpoWnv1o
         bNVtTpNTcenfsX3JFScrAkSVZNpCPQzR81ih6KK1BQOEEWHfBwqLml08gAfv3hD3fJsz
         ILT6ZiAfhPAGK6gKRdDXz6baNnx0doL0Sk7Lg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=MGCpMWzAr15s41KHKc/dQiAxW7RHouQ87LNEG1hmw4LvqZ4z7CZxSXx2SRK2S5XkwW
         x7ypDNBU2KxrKzKH8IrlOwYNFsS8ch+IDft2HL27GDdLyvf+hpmluNooMf/THPSN0EJj
         0wbj39gXB+eKhgev+Q6+DgzUDTJ3u7lbjxiqw=
Received: by 10.223.59.81 with SMTP id k17mr1103031fah.94.1305579224359; Mon,
 16 May 2011 13:53:44 -0700 (PDT)
Received: by 10.223.117.72 with HTTP; Mon, 16 May 2011 13:53:44 -0700 (PDT)
In-Reply-To: <7vboz2l6h1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173758>

On Mon, May 16, 2011 at 22:45, Junio C Hamano <gitster@pobox.com> wrote=
:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> Oh, and for all the convertion of:
>>
>> =C2=A0 =C2=A0 echo >&2 "$(gettext "foobar")"
>>
>> I've already done:
>>
>> =C2=A0 =C2=A0 (
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 gettext "foobar" &&
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 echo
>> =C2=A0 =C2=A0 ) >&2
>
> Sorry, but what problem are you trying to solve? =C2=A0The output fro=
m
>
> =C2=A0 =C2=A0$ gettext "foobar"
>
> may have 0, 1 or more LF at the end, but wouldn't
>
> =C2=A0 =C2=A0echo >&2 "$(gettext "foobar")"
>
> terminate with a single LF in any case?
>
> Ahh, perhaps I was the one who said something stupid like:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0echo >&2 "$(cmd)"
>
> should be equivalent to
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0cmd >&2
>
> which is not the case when output from cmd does not end with a single=
 LF
> (i.e. either an incomplete line, or with trailing blank lines).
>
> Sorry, if that is what you are trying to address, please let me take =
that
> back.

Yeah, you said:

    >> +  echo >&2 "$(eval_gettext "Warning: fetch updated the current
branch head.
    >> +Warning: fast-forwarding your working tree from
    >> +Warning: commit \$orig_head.")"
    >
    > echo "$(...)"
    >
    > sounds quite wasteful and harder to read than necessary.
    > The same also happens in later patches.

    A very good point.  Just letting eval_gettext write out to >&2 shou=
ld be
    both sufficient and inifinitely more readable.

    -- http://www.spinics.net/lists/git/msg157376.html

Which is why I rewrote all the relevant patches to look like:

    diff --git a/git-pull.sh b/git-pull.sh
    index 06dcd81..a10b129 100755
    --- a/git-pull.sh
    +++ b/git-pull.sh
    @@ -217,9 +217,12 @@ then
            # $orig_head commit, but we are merging into $curr_head.
            # First update the working tree to match $curr_head.

    -       echo >&2 "Warning: fetch updated the current branch head."
    -       echo >&2 "Warning: fast-forwarding your working tree from"
    -       echo >&2 "Warning: commit $orig_head."
    +       (
    +               eval_gettext "Warning: fetch updated the current
branch head.
    +Warning: fast-forwarding your working tree from
    +Warning: commit \$orig_head." &&
    +               echo
    +       ) >&2
            git update-index -q --refresh
            git read-tree -u -m "$orig_head" "$curr_head" ||
                    die "$(eval_gettext "Cannot fast-forward your worki=
ng tree.

I wrote them using echo "$(gettext "foo")" initially because I thought
bending over backwards like this was silly.

You want me to go and change it back now?
