From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 1/2] dir.c: fix uninitialized memory warning
Date: Fri, 17 Sep 2010 09:26:39 +1000
Message-ID: <AANLkTik1X0i-OYZCxokw-W3Kt+vEDtBvFeCwQU3q40ap@mail.gmail.com>
References: <1284670403-90716-1-git-send-email-patnotz@gmail.com>
	<1284670403-90716-2-git-send-email-patnotz@gmail.com>
	<AANLkTim4SiuX=aWLeYXKpgvD+Nh1trH8qgf3V36iVa9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pat Notz <patnotz@gmail.com>, git <git@vger.kernel.org>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 17 01:26:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OwNqp-00060k-Su
	for gcvg-git-2@lo.gmane.org; Fri, 17 Sep 2010 01:26:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753289Ab0IPX0m convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 16 Sep 2010 19:26:42 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:42425 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752425Ab0IPX0l convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Sep 2010 19:26:41 -0400
Received: by wwb39 with SMTP id 39so87909wwb.1
        for <git@vger.kernel.org>; Thu, 16 Sep 2010 16:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=m+ccGvsRapATE+uLKvQse8E/AA/GvPKI2jG1sMcwHDo=;
        b=mW3U3mbvpULQ/KlWFANNro0PGfXv3EBXj/tVs5sAndBm/6ARajd6DHwAJsxJKXFHM4
         CU7BoVsw3+5dIA4rjRe6QfN2Z3PHmqZrhRJxfALLJpw2Ul337vIJKJi9FzsRfqb9vaSm
         +o44LFGB45RiMa+0lCwNhZT/9/QRUVsTDofWM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=gxM73/4xzVujqjcNOW/Q2R0I0snJu5YM6sevcHOjEEdCxIyzyMXnvVrQOf0aSp+GzN
         AeZUUDKI/olNDIU1haS+9KN52cfokUvhmkoLJzsZM+TnclAQT0gpvc7O7vHcXNiQy3Vw
         CtCFTa1Y/Ovz3lO5WJl1dXUe7QTh/CtdH8ErY=
Received: by 10.216.238.37 with SMTP id z37mr44075weq.26.1284679599923; Thu,
 16 Sep 2010 16:26:39 -0700 (PDT)
Received: by 10.216.171.134 with HTTP; Thu, 16 Sep 2010 16:26:39 -0700 (PDT)
In-Reply-To: <AANLkTim4SiuX=aWLeYXKpgvD+Nh1trH8qgf3V36iVa9w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156363>

2010/9/17 =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>:
> On Thu, Sep 16, 2010 at 20:53, Pat Notz <patnotz@gmail.com> wrote:
>> GCC 4.4.4 on MacOS warns about potential use of uninitialized memory=
=2E
>>
>> Signed-off-by: Pat Notz <patnotz@gmail.com>
>> ---
>> =C2=A0dir.c | =C2=A0 =C2=A02 +-
>> =C2=A01 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/dir.c b/dir.c
>> index 133f472..d1e5e5e 100644
>> --- a/dir.c
>> +++ b/dir.c
>> @@ -232,7 +232,7 @@ int add_excludes_from_file_to_list(const char *f=
name,
>> =C2=A0{
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct stat st;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0int fd, i;
>> - =C2=A0 =C2=A0 =C2=A0 size_t size;
>> + =C2=A0 =C2=A0 =C2=A0 size_t size =3D 0;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0char *buf, *entry;
>
> What does the GCC warning say exactl? I.e. what line does it complain
> about?
>
> Maybe this is a logic error introduced in v1.7.0-rc0~25^2? I haven't
> checked.

I don't see any case that "size" can be used uninitialized. Maybe the
compiler was confused by

if (!check_index ||
    (buf =3D read_skip_worktree_file_from_index(fname, &size)) =3D=3D N=
ULL)
        return -1;

I wouldn't hurt though to initialize it early, even just to stop the
compiler from complaining.
--=20
Duy
