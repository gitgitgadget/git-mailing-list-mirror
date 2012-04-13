From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 4/4] completion: improve 'git --exec-path' completion
Date: Sat, 14 Apr 2012 02:35:04 +0300
Message-ID: <CAMP44s0R7imiem4uoBggkjjJ4z5+MXVYUroe_23JE8McMCk2sQ@mail.gmail.com>
References: <1334274603-3277-1-git-send-email-felipe.contreras@gmail.com>
	<1334274603-3277-5-git-send-email-felipe.contreras@gmail.com>
	<20120413060845.GA15610@burratino>
	<20120413180436.GA2387@burratino>
	<20120413183048.GB2387@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 14 01:35:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIq1K-0007qq-Eo
	for gcvg-git-2@plane.gmane.org; Sat, 14 Apr 2012 01:35:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757321Ab2DMXfH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Apr 2012 19:35:07 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:62782 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757263Ab2DMXfF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Apr 2012 19:35:05 -0400
Received: by eekc41 with SMTP id c41so902113eek.19
        for <git@vger.kernel.org>; Fri, 13 Apr 2012 16:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=cnd3ChYm1coTWKCQirXIY42VjNrj3AU3oZ1rZBOUZPc=;
        b=wQB6LKPUzhK8bRwiC1oi0qibzAwqJWd1GWu2FFdVoXdBlRO9ROFwKAG/LQ7sSsIee4
         Y3/onY3iXwcqkD6ZeCrtzpOV4APg96UoIcbDnvywmHt0zDxKrJe6xKiCpzYbiX8v6X98
         /MxXEiHBeQy5uIy10wTQhR7ExBo06kQqa1WXubcwORpGunv9irdfbOPtj89uin+gUXyI
         u4exqN2XShX3y1L0udI6x8YFiI4AFUicevhwo/UAzcOvXr3b94JSStXCQL/E7N5B4leT
         jmHsaHmGFjBx33yCwJhXLrjo1t7wm4N/UZMH4a/5mmmsBpf8Xvcl3Olh6FV4+fP/xP/z
         Um8Q==
Received: by 10.14.182.194 with SMTP id o42mr530979eem.50.1334360104486; Fri,
 13 Apr 2012 16:35:04 -0700 (PDT)
Received: by 10.213.19.67 with HTTP; Fri, 13 Apr 2012 16:35:04 -0700 (PDT)
In-Reply-To: <20120413183048.GB2387@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195456>

On Fri, Apr 13, 2012 at 9:30 PM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Jonathan Nieder wrote:
>
>> In other words, how about something like this? =C2=A0Tests left as a=
n exercise
>> to the interested reader.
>
> ... and here's a simpler way to spell it.
>
> -- >8 --
> Subject: completion: do not add trailing space when completing --exec=
-path
>
> --exec-path looks like to the completion script like an unambiguous
> successful completion, but it is wrong. =C2=A0The user could be tryin=
g to
> do
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git --exec-path; # print name of helper di=
rectory
>
> or
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git --exec-path=3D/path/to/alternative/hel=
per/dir <subcommand>
>
> so the most helpful thing to do is to leave out the trailing space an=
d
> leave it to the operator to type an equal sign or carriage return
> according to the situation.
>
> Reported-by: Felipe Contreras <felipe.contreras@gmail.com>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
> =C2=A0contrib/completion/git-completion.bash | =C2=A0 =C2=A01 +
> =C2=A01 file changed, 1 insertion(+)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/complet=
ion/git-completion.bash
> index 31f714da..d2109897 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -2639,6 +2639,7 @@ _git ()
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0--bare
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0--version
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0--exec-path
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 --exec-path=3D
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0--html-path
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0--work-tree=3D
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0--namespace=3D
> --
> 1.7.10

I don't understand, the commit message doesn't match what the patch
actually does. In fact, this is the exact patch I sent, is it not?

--=20
=46elipe Contreras
