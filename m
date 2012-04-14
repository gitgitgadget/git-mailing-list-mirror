From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3 1/5] completion: simplify __gitcomp_1
Date: Sun, 15 Apr 2012 01:54:56 +0300
Message-ID: <CAMP44s3qXnONLh_=gO4_9DK2=bx0tLBTTAb4WenYh5k2QPQL-g@mail.gmail.com>
References: <1334439784-6460-1-git-send-email-felipe.contreras@gmail.com>
	<1334439784-6460-2-git-send-email-felipe.contreras@gmail.com>
	<87obqueyas.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Sun Apr 15 00:55:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJBs0-0004II-8H
	for gcvg-git-2@plane.gmane.org; Sun, 15 Apr 2012 00:55:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752417Ab2DNWy6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Apr 2012 18:54:58 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:45991 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751992Ab2DNWy5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 Apr 2012 18:54:57 -0400
Received: by eekc41 with SMTP id c41so1027424eek.19
        for <git@vger.kernel.org>; Sat, 14 Apr 2012 15:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=qTsilh+DzAbb6wb7fB5Eu9H8Umiit4EzY80aFUUiVJ4=;
        b=hqDKddRaFLCNosimBlRKF8szPAnC+WyUCiCWYwg7xxAJcS3QcofVRNdVurB+WLWQZy
         BqCND/EQ6h6ElxYYM8qq0XPvqrO87LKOQie3+kEdrUvt4HIbj/ppw1nuHl/ST8yN7KnB
         wZ0t/m+zQBXbAi6nQ8ZY6RRZ2NmFKW1qqUOBe6XP13BQgubDXFfxz3lW/jNoSKYiHzbB
         SMfSCBP04MnNd1ttBps2nsKOcTbNEjmbdA2bl2OF8DJAWLT+PSjGTVxplJFNINJpK/8+
         UkhwToYcFBzfGb7QZRulwwbK8G15OPGFaBrC40LiJJV4L+3fvX7J1XmIK6dsZHMA4/1c
         8amg==
Received: by 10.14.182.194 with SMTP id o42mr910742eem.50.1334444096188; Sat,
 14 Apr 2012 15:54:56 -0700 (PDT)
Received: by 10.213.19.67 with HTTP; Sat, 14 Apr 2012 15:54:56 -0700 (PDT)
In-Reply-To: <87obqueyas.fsf@thomas.inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195528>

On Sun, Apr 15, 2012 at 1:36 AM, Thomas Rast <trast@inf.ethz.ch> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> =C2=A0# __gitcomp_1 requires 2 arguments
>> =C2=A0__gitcomp_1 ()
>> =C2=A0{
>> - =C2=A0 =C2=A0 local c IFS=3D' '$'\t'$'\n'
>> + =C2=A0 =C2=A0 local c s IFS=3D' '$'\t'$'\n'
>> =C2=A0 =C2=A0 =C2=A0 for c in $1; do
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case "$c$2" in
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 --*=3D*) printf %s$'\n' =
"$c$2" ;;
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *.) =C2=A0 =C2=A0printf =
%s$'\n' "$c$2" ;;
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *) =C2=A0 =C2=A0 printf =
%s$'\n' "$c$2 " ;;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 --*=3D* | *.) s=3D"" ;;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *) =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0s=3D" " ;;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 esac
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 echo "$c$2$s"
>> =C2=A0 =C2=A0 =C2=A0 done
>> =C2=A0}
>
> Sorry for not noticing earlier, but...
>
> I did a double take at the change to 'echo'. =C2=A0I'm guessing from =
the
> patch that $c$2$s is never just '-e' or some other option taken by th=
e
> bash version[1] of echo. =C2=A0But can you be sure? =C2=A0Do you know=
 off hand
> whether '-nbogus' complains, treats the -n as usual and prints 'bogus=
',
> or echoes '-nbogus'[2]? =C2=A0Are you sure future bash versions won't=
 break
> this?

That doesn't make any sense to me. If you want that, you should do
'eval "echo $foo"', and even if you do 'eval "echo \"$foo\""', that
would be avoided.

> Also, I can't help but complain about your commit messages (again).

Well, we can start a discussion about how "simplify __gitcomp_1" does
not explain sufficiently that this is indeed a simplification of
__gitcomp_1, but from previous experiences you don't really want to
discuss, you just want to be right, and me to follow orders.

Personally, I don't see why every modified line needs an ode.

> 1. the refactoring of the partial command: printf %s$'\n' "$c$2
> 2. the change to echo

Or

1. simplifying __gitcomp_1

> Footnotes:
> [1] =C2=A0POSIX states that echo "shall not support any options" and =
"shall
> not recognize the -- argument", but we have printfs all over the code
> base because option support is extremely inconsistent

This is a *bash* completion script.

If you *need* an essay for a commit message for a patch that
essentially does nothing but simplify some code, I'll just drop it;
it's not worth my effort.

Cheers.

--=20
=46elipe Contreras
