From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] git-svn: un-break "git svn rebase" when log.abbrevCommit=true
Date: Sun, 29 Jan 2012 04:12:18 +0100
Message-ID: <CACBZZX4_54LNqiEEA1BVvJFcLh_o=_ErHWGZMxSHTV2yTqte_Q@mail.gmail.com>
References: <1327803073-7000-1-git-send-email-avarab@gmail.com> <20120129025914.GA5981@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 29 04:12:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RrLC8-0002VD-LG
	for gcvg-git-2@plane.gmane.org; Sun, 29 Jan 2012 04:12:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752732Ab2A2DMk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 28 Jan 2012 22:12:40 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:52892 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752208Ab2A2DMj convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jan 2012 22:12:39 -0500
Received: by lagu2 with SMTP id u2so1642121lag.19
        for <git@vger.kernel.org>; Sat, 28 Jan 2012 19:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=d5Zq2w4nv+C7mrdoYoqJqsak/2uS6nHeYuocY8BoWYI=;
        b=ZhIoA1N1u+C7UJWPwosrLT63oPoDPxFchfPQV/K9KiF5ejF72/HGqB85c2yv+J3yX0
         58tg/w6ZL8kVLnompJIasXFYUebh+70YmBftsOwihTMFoKUMz50p6hLdrtK3mITftIVc
         l5gu6nwZ0AsqkCQUyRrE0N8aDupSdHWr4+VtQ=
Received: by 10.152.148.228 with SMTP id tv4mr6627024lab.9.1327806758133; Sat,
 28 Jan 2012 19:12:38 -0800 (PST)
Received: by 10.112.30.67 with HTTP; Sat, 28 Jan 2012 19:12:18 -0800 (PST)
In-Reply-To: <20120129025914.GA5981@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189276>

On Sun, Jan 29, 2012 at 03:59, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> --- a/git-svn.perl
>> +++ b/git-svn.perl
>> @@ -1879,7 +1879,8 @@ sub cmt_sha2rev_batch {
>> =C2=A0sub working_head_info {
>> =C2=A0 =C2=A0 =C2=A0 my ($head, $refs) =3D @_;
>> =C2=A0 =C2=A0 =C2=A0 my @args =3D qw/log --no-color --no-decorate --=
first-parent
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 --p=
retty=3Dmedium/;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 --p=
retty=3Dmedium --no-abbrev-commit --no-decorate/;
>> +
>
> Oh, dear. =C2=A0Wouldn't
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0my @args =3D qw/rev-list --first-parent --=
pretty=3Dmedium/;
>
> be simpler and more robust as a quick fix?
>
> Of course something that takes plain rev-list --first-parent output
> and pipes it through to cat-file --batch might be more intuitive, but
> rev-list --pretty should at least work. ;-)

That sounds like a better fix. I forgot that rev-list could emulate
git-log like that.
