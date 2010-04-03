From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: nd/setup
Date: Sat, 3 Apr 2010 16:39:05 +0200
Message-ID: <z2gfcaeb9bf1004030739q9575b629p44c4461e90c37d40@mail.gmail.com>
References: <7vaatmckmi.fsf@alter.siamese.dyndns.org>
	 <j2wfcaeb9bf1004020423nc5b7a73cq2278d41d1675dc8f@mail.gmail.com>
	 <20100403050057.GA20525@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 03 16:39:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ny4VT-0007kD-NR
	for gcvg-git-2@lo.gmane.org; Sat, 03 Apr 2010 16:39:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752895Ab0DCOjJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 3 Apr 2010 10:39:09 -0400
Received: from mail-ew0-f220.google.com ([209.85.219.220]:44921 "EHLO
	mail-ew0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752339Ab0DCOjI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 Apr 2010 10:39:08 -0400
Received: by ewy20 with SMTP id 20so766565ewy.1
        for <git@vger.kernel.org>; Sat, 03 Apr 2010 07:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=fFkunaf5kEvv6/TyYHxx2a/h4IWm8wE+GAsEEk95d9A=;
        b=u+LlyTnt1ITL6GeA+xJOpR2APcjit+lqJJqHahogp0zjO6C26YLwdTkyo/+Lkk3yB7
         J0hHNSSYF/k+24HzxdJRVylE3oDYRbjET5zPYQX7EAArb5ZUT4ndoyPBq+wKkHXLvXtl
         IT/Id3lVDfibwX9ye/gVOPUK6YsQgzInRnxkE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=V44ZiHWr/q8uRIVjgjXG7ZLGxMvkmsn0VZ/C90mXISXod4lOz4iHgpgC+cuHFBBeRC
         nIA+7Jg63cgDDopzuNi0cEvs003ohi1gnin2QHDO49HyC0W2o4dzArIWjaURXFLbjjno
         0ckNTEdr9XWBI3EEM4NckjsLV+dfHeAhDYEjs=
Received: by 10.213.105.130 with HTTP; Sat, 3 Apr 2010 07:39:05 -0700 (PDT)
In-Reply-To: <20100403050057.GA20525@progeny.tock>
Received: by 10.213.45.212 with SMTP id g20mr352095ebf.61.1270305545612; Sat, 
	03 Apr 2010 07:39:05 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143889>

On Sat, Apr 3, 2010 at 7:00 AM, Jonathan Nieder <jrnieder@gmail.com> wr=
ote:
> Nguyen Thai Ngoc Duy wrote:
>
>> I haven't forgotten the "git init" with alias bug Jonathan found. Ju=
st
>> a little busy with other stuff.
>
> You already fixed it, I think. ;-)

Hmm.. so I do forget something. I still miss some of your good tests th=
ough.

> -- %< --
> Subject: Revert "help: use RUN_SETUP_GENTLY"
>
> Commit 717b8850580ecb9009505f71ea43ecda51ac1f0e taught =E2=80=98git h=
elp=E2=80=99
> to unconditionally looks for a git directory, with the justification:
>
> =C2=A0 =C2=A0So the sooner we set up gitdir, the less trouble we may =
have to
> =C2=A0 =C2=A0deal with.
>
> In the case of =E2=80=98git help -a=E2=80=99, that is not quite true.=
 =C2=A0In automount
> setups like that which prompted v1.6.0-rc0~121^2~1 (Add support for
> GIT_CEILING_DIRECTORIES, 2008-05-19), if GIT_CEILING_DIRECTORIES is
> unset, then probing for the Git directory can take a long time. =C2=A0=
Thus
> unnecessarily searching for a git directory can slow down =E2=80=98gi=
t help -a=E2=80=99
> (and thus bash completion).
>
> =E2=80=98git help=E2=80=99 does not use RUN_SETUP or USE_PAGER, and n=
either option
> parsing nor producing output for plain =E2=80=98git help=E2=80=99 or =
=E2=80=98git help -a=E2=80=99
> requires access to the git configuration. =C2=A0Therefore it is safe =
to not
> search for the git directory early in this case.
>
> Also add some comments to document the requirements this places on
> list_commands() and list_common_cmds_help().
>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>

Didn't notice it. Looks good. I will replace the "help: use
RUN_SETUP_GENTLY" commit with this patch next time, if you don't mind.
--=20
Duy
