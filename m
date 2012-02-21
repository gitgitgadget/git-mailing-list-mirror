From: =?ISO-8859-1?Q?Philip_J=E4genstedt?= <philip@foolip.org>
Subject: Re: [PATCH] completion: remote set-* <name> and <branch>
Date: Tue, 21 Feb 2012 22:29:33 +0100
Message-ID: <CAKHWUkZjQYnf=LwS_RC-E_7gV73AzbWjxs33E5-FL25s6_qX4g@mail.gmail.com>
References: <1329571973-20796-1-git-send-email-philip@foolip.org> <7vvcn2lyw6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?ISO-8859-1?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Teemu Likonen <tlikonen@iki.fi>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 21 22:30:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RzxHc-0002S5-HK
	for gcvg-git-2@plane.gmane.org; Tue, 21 Feb 2012 22:30:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754175Ab2BUV3z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Feb 2012 16:29:55 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:59360 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752693Ab2BUV3y convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Feb 2012 16:29:54 -0500
Received: by vcge1 with SMTP id e1so4562737vcg.19
        for <git@vger.kernel.org>; Tue, 21 Feb 2012 13:29:53 -0800 (PST)
Received-SPF: pass (google.com: domain of philip@foolip.org designates 10.220.232.10 as permitted sender) client-ip=10.220.232.10;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of philip@foolip.org designates 10.220.232.10 as permitted sender) smtp.mail=philip@foolip.org
Received: from mr.google.com ([10.220.232.10])
        by 10.220.232.10 with SMTP id js10mr15316199vcb.53.1329859793591 (num_hops = 1);
        Tue, 21 Feb 2012 13:29:53 -0800 (PST)
Received: by 10.220.232.10 with SMTP id js10mr12258821vcb.53.1329859793234;
 Tue, 21 Feb 2012 13:29:53 -0800 (PST)
Received: by 10.52.178.193 with HTTP; Tue, 21 Feb 2012 13:29:33 -0800 (PST)
In-Reply-To: <7vvcn2lyw6.fsf@alter.siamese.dyndns.org>
X-Gm-Message-State: ALoCoQmmC4SMxxZTASMnlxDr+dMdNsiBcQwYQzz/wsQ215kJ1jj/jpt9JoyukexeJ8jmskqL42Xp
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191187>

On Mon, Feb 20, 2012 at 08:58, Junio C Hamano <gitster@pobox.com> wrote=
:
> Philip J=E4genstedt <philip@foolip.org> writes:
>
>> Complete <name> only for set-url. For set-branches and
>> set-head, complete <name> and <branch> over the network,
>> like e.g. git pull already does.
>>
>> Signed-off-by: Philip J=E4genstedt <philip@foolip.org>
>
> You addressed your patch to Shawn, who originally wrote this, but
>
> "git shortlog -n -s --no-merges --since=3D9.months pu contrib/complet=
ion"
>
> indicates that he no longer is involved in enhancing this script, and=
 it
> has seen actions primarily from three people I Cc'ed this message to.

Thanks. Perhaps git-completion.bash should not say "Send all patches
to the current maintainer" and simply defer to SubmittingPatches?

>> =A0contrib/completion/git-completion.bash | =A0 12 +++++++++---
>> =A01 file changed, 9 insertions(+), 3 deletions(-)
>>
>> diff --git a/contrib/completion/git-completion.bash b/contrib/comple=
tion/git-completion.bash
>> index 1505cff..8e7abb6 100755
>> --- a/contrib/completion/git-completion.bash
>> +++ b/contrib/completion/git-completion.bash
>> @@ -738,6 +738,9 @@ __git_complete_remote_or_refspec ()
>> =A0{
>> =A0 =A0 =A0 local cur_=3D"$cur" cmd=3D"${words[1]}"
>> =A0 =A0 =A0 local i c=3D2 remote=3D"" pfx=3D"" lhs=3D1 no_complete_r=
efspec=3D0
>> + =A0 =A0 if [ "$cmd" =3D "remote" ]; then
>> + =A0 =A0 =A0 =A0 =A0 =A0 c=3D$((++c))
>> + =A0 =A0 fi
>
> I don't know about others, but auto-incrementing a variable and assig=
ning
> the result to the same variable, while not wrong at all, hurts my bra=
in.
>
> =A0 =A0 =A0 =A0c=3D$(($c + 1))
>
> is far more readable and does not suggest there is any funky magic
> involved. =A0Also it is a good habit to get into not to omit $ from
> variables inside arithmetic substitution, even though bash allows it =
and
> this script is meant to be consumed only by shells that understand th=
is
> bash-ism.
>
> I do not know offhand if zsh groks it, but the point is that you do n=
ot
> have to worry about it if you write "$(($c+1))" instead of "$((c+1))"=
=2E

CodingGuidlines suggests to follow local convention, which was
"c=3D$((++c))". This file also uses "++n", "i++" and "((i++))". I will
send a v2 patch that normalizes these, open to discussion of course.

--=20
Philip J=E4genstedt
