From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH v2] git submodule foreach: Skip eval for more than one argument
Date: Fri, 27 Sep 2013 12:47:35 +0200
Message-ID: <CALKQrgfT1ijSx7hmtFRE7=Wm1LCtVH4ceeSQfuFF7Qswa+wRpg@mail.gmail.com>
References: <alpine.DEB.2.00.1309261605330.20647@dr-wily.mit.edu>
	<CALKQrgfhUEE+E5KsAWbP_zj6tozk+V=qvNU1PX9Z73Vu8unTiQ@mail.gmail.com>
	<alpine.DEB.2.00.1309270606290.20647@dr-wily.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Git mailing list <git@vger.kernel.org>
To: Anders Kaseorg <andersk@mit.edu>
X-From: git-owner@vger.kernel.org Fri Sep 27 12:47:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VPVaM-0008Jq-9y
	for gcvg-git-2@plane.gmane.org; Fri, 27 Sep 2013 12:47:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751319Ab3I0Krn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Sep 2013 06:47:43 -0400
Received: from mail12.copyleft.no ([188.94.218.224]:46956 "EHLO
	mail12.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750946Ab3I0Krl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Sep 2013 06:47:41 -0400
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail12.copyleft.no with esmtp (Exim 4.76)
	(envelope-from <johan@herland.net>)
	id 1VPVaF-0004hy-Jj
	for git@vger.kernel.org; Fri, 27 Sep 2013 12:47:39 +0200
Received: from mail-pd0-f171.google.com ([209.85.192.171])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1VPVaF-000Bmd-3B
	for git@vger.kernel.org; Fri, 27 Sep 2013 12:47:39 +0200
Received: by mail-pd0-f171.google.com with SMTP id g10so2436454pdj.2
        for <git@vger.kernel.org>; Fri, 27 Sep 2013 03:47:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=Pb2w8AVo+p7OCeFMtIslh7JvIw4Yw1rxEmMLfFVFXkM=;
        b=LZsGtpc69p/JBN16lTKze31er7O/VV2YmWkeOTFvFI38TuTJVVSGNJ22EuCO7cOemw
         oQydmC+DrL0LpdKWSBqlBb3mrwl6PzYthot251SqUR209lxB1VIC7SBZEKyBOHzSJtMu
         XzmaAarbdg6Jbq/aj7RgW6xUxSfLUKL0ArlIB8ZFZAOaG1HCmJ8UhutbbUwmzDfkB2Jb
         hUDL7FjyWCYpk9fV8sSQLTc+fi8+q+UIhaY8GDM9bUJGQZAeY7Xndpj916aRMzFQPCKw
         Sy1neh1yt6uLlxMF2i9KgClTZLfz2CzoEbyy6pVTHPHz+/q/QVh/FfrGHXmkSvJsZZhd
         f5qw==
X-Received: by 10.68.26.130 with SMTP id l2mr6539485pbg.134.1380278855128;
 Fri, 27 Sep 2013 03:47:35 -0700 (PDT)
Received: by 10.70.24.226 with HTTP; Fri, 27 Sep 2013 03:47:35 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1309270606290.20647@dr-wily.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235453>

On Fri, Sep 27, 2013 at 12:23 PM, Anders Kaseorg <andersk@mit.edu> wrot=
e:
> =E2=80=98eval "$@"=E2=80=99 created an extra layer of shell interpret=
ation, which was
> probably not expected by a user who passed multiple arguments to git
> submodule foreach:
>
> $ git grep "'"
> [searches for single quotes]
> $ git submodule foreach git grep "'"
> Entering '[submodule]'
> /usr/lib/git-core/git-submodule: 1: eval: Syntax error: Unterminated =
quoted string
> Stopping at '[submodule]'; script returned non-zero status.
>
> To fix this, if the user passed more than one argument, just execute
> "$@" directly instead of passing it to eval.
>
> Signed-off-by: Anders Kaseorg <andersk@mit.edu>

Acked-by: Johan Herland <johan@herland.net>

> On Fri, 27 Sep 2013, Johan Herland wrote:
>> 2. If we are unlucky there might be existing users that work around =
the
>> existing behavior by adding an extra level of quoting (i.e. doing th=
e
>> equivalent of git submodule foreach git grep "\'" in your example
>> above). Will their workaround break as a result of your change? Is t=
hat
>> acceptable?
>
> Anyone adding an extra level of quoting ought to realize that they sh=
ould
> be passing a single argument to submodule foreach, so that the reason=
 for
> the extra quoting is clear:
>   git submodule foreach "git grep \'"
> will not break.  If someone is actually doing
>   git submodule foreach git grep "\'"
> then this will change in behavior.  I think this change is important.
>
> (One could even imagine someone feeding untrusted input to
>   git submodule foreach git grep "$variable"
> which, without my patch, results in a nonobvious shell code injection
> vulnerability.)
>
> I considered an alternative fix where the first argument is always
> shell-evaulated and any others are not (i.e. cmd=3D$1 && shift && eva=
l
> "$cmd \"\$@\""), which is potentially more useful in case the command
> needs to use $path.  But that may be too confusing, and this way has =
some
> precedent (e.g. perl=E2=80=99s system()).

Ok. I have nothing to add.

=2E..Johan

--=20
Johan Herland, <johan@herland.net>
www.herland.net
