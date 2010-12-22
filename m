From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 36/47] rev-parse: prints --git-dir relative to user's cwd
Date: Wed, 22 Dec 2010 14:05:28 +0700
Message-ID: <AANLkTi=DPrQirbp3mOfQkU3Dx_eYmp1inVYx-GqqD9V5@mail.gmail.com>
References: <1290785563-15339-1-git-send-email-pclouds@gmail.com>
 <1290785563-15339-37-git-send-email-pclouds@gmail.com> <7vvd2m605f.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 22 08:08:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PVIoJ-0001nU-Sl
	for gcvg-git-2@lo.gmane.org; Wed, 22 Dec 2010 08:08:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751981Ab0LVHGA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Dec 2010 02:06:00 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:49788 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751386Ab0LVHF7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Dec 2010 02:05:59 -0500
Received: by wwa36 with SMTP id 36so4975130wwa.1
        for <git@vger.kernel.org>; Tue, 21 Dec 2010 23:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=AHK7wvk5Zqie4BmrxA7LSkD74kolInBJMRLhyHMwX3M=;
        b=J+dCEedGy6BJThIiZfkwQwa7hfcLogPS3enQNIxx9dYJLlZoXqwf9f9shMCV8VwsmV
         cslXwuMzuyLGxAD9/963yz8SRP+469l0WajIP0yEJArAeyD5E3AG2sNxY2Xtz6Ays0dT
         26Gdsfi0Kq9X79LE77+yuxBT6jEOlH+nMQotQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=c9keLA4Tr7Vx4tdlut5lgbJ8ajRxG8NSplgGpDI1tBgWGiPNzg3F1bFwCnbXBAlweo
         x2IWjLmd5M6PTBHbEGloUIKEPs/HAv1c2M1OGx6ROE5wdMfy8WDcQdohMBpWdxNUspYN
         bBj+sdH22Cv7FoG6w7NuENusSdl3FqHRVQpGY=
Received: by 10.216.142.101 with SMTP id h79mr7278778wej.49.1293001558490;
 Tue, 21 Dec 2010 23:05:58 -0800 (PST)
Received: by 10.216.158.83 with HTTP; Tue, 21 Dec 2010 23:05:28 -0800 (PST)
In-Reply-To: <7vvd2m605f.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164073>

2010/12/22 Junio C Hamano <gitster@pobox.com>:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =C2=A0<pclouds@gmail.com> w=
rites:
>
>> git_dir variable in environment.c is relative to git's cwd, not user=
's
>> cwd. Convert the relative path (actualy by making it absolute path)
>> before printing out.
>>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gm=
ail.com>
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> ---
>> =C2=A0builtin/rev-parse.c | =C2=A0 =C2=A06 +++++-
>> =C2=A01 files changed, 5 insertions(+), 1 deletions(-)
>>
>> diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
>> index a5a1c86..65c287b 100644
>> --- a/builtin/rev-parse.c
>> +++ b/builtin/rev-parse.c
>> @@ -647,7 +647,11 @@ int cmd_rev_parse(int argc, const char **argv, =
const char *prefix)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 static char cwd[PATH_MAX];
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int len;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (gitdir) {
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 puts(gitdir=
);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (is_abso=
lute_path(gitdir) || !prefix) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 puts(gitdir);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 continue;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 puts(make_a=
bsolute_path(gitdir));
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continu=
e;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!prefix) {
>
> I do not quite understand this change. =C2=A0I can obtain GIT_DIR in =
a relative
> form without this patch already:
>
> =C2=A0 =C2=A0$ cd t/
> =C2=A0 =C2=A0$ git --git-dir=3D../.git rev-parse --git-dir HEAD
> =C2=A0 =C2=A0../.git
> =C2=A0 =C2=A0c7511731675da8b50c0d5243aa04a98c8a5ee316
>
> Could we please have a new test case to demonstrate what is broken wi=
thout
> this patch?
>

Um.. GIT_DIR can be changed by set_git_dir() inside
setup_directory_gently() and be relative to git's internal (movable)
cwd. The current code won't fall to that code path because GIT_DIR is
made absolute in most cases. A few cases we keep GIT_DIR relative,
we're sure cwd is not moved, or $GIT_DIR is not set and handled by
rev-parse code.

I reverted the patch and ran "make test". Passed. When an attempt to
make $GIT_DIR relative to worktree as much as possible happens, this
may be needed. But for now, I'm OK if you take this patch out. I'll
put it back on when I make such an attempt.
--=20
Duy
