From: Pat Notz <patnotz@gmail.com>
Subject: Re: [PATCH 1/2] dir.c: fix uninitialized memory warning
Date: Thu, 16 Sep 2010 18:32:13 -0600
Message-ID: <AANLkTin52McRcJcNocSGMxA7PUCiygSwQTHc1SWcMeOk@mail.gmail.com>
References: <1284670403-90716-1-git-send-email-patnotz@gmail.com>
 <1284670403-90716-2-git-send-email-patnotz@gmail.com> <AANLkTim4SiuX=aWLeYXKpgvD+Nh1trH8qgf3V36iVa9w@mail.gmail.com>
 <AANLkTik1X0i-OYZCxokw-W3Kt+vEDtBvFeCwQU3q40ap@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	git <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 17 02:32:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OwOsc-0000rf-QJ
	for gcvg-git-2@lo.gmane.org; Fri, 17 Sep 2010 02:32:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754753Ab0IQAcg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 16 Sep 2010 20:32:36 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:60878 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754107Ab0IQAcf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Sep 2010 20:32:35 -0400
Received: by bwz11 with SMTP id 11so2158538bwz.19
        for <git@vger.kernel.org>; Thu, 16 Sep 2010 17:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=xX9GIQ0CcvxV0WFQUTB7szPOpIoivgloeXGwNyKh12M=;
        b=NrnpB2XJxugy2wawWZyrpj7iwU2BVSTT7bKJj3q4TfY/loeHLCSoYHl+L9tJbzCUws
         7d/fXnpzKOSGC9P8rJHTVKqOPPrwF9w2KeslV0mUj2tY1GjVzeAhfchdtlNawMEDWnb9
         jHW2p/1SQ3WqQXHinnj6WlGUiYO6dQQm77Eno=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=sUfTPVN3oj1FGiEJbG2EuykvcQyHA6AQHFOa2BQRBvn0/gsqwUx31jGF3E/3+zvQkC
         jtB71ZnZshtQ+CCoUhdL8LD2B3/xBTOBU6ub4OcqviPkkunXaGj90Kohp25tGOdZj9gZ
         Q0RcTufCjHN8F0O1rnJ+QUu9LvTeoAEgYhK2Q=
Received: by 10.239.187.72 with SMTP id k8mr207804hbh.150.1284683553203; Thu,
 16 Sep 2010 17:32:33 -0700 (PDT)
Received: by 10.239.185.65 with HTTP; Thu, 16 Sep 2010 17:32:13 -0700 (PDT)
In-Reply-To: <AANLkTik1X0i-OYZCxokw-W3Kt+vEDtBvFeCwQU3q40ap@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156364>

On Thu, Sep 16, 2010 at 5:26 PM, Nguyen Thai Ngoc Duy <pclouds@gmail.co=
m> wrote:
> 2010/9/17 =C6var Arnfj=F6r=F0 Bjarmason <avarab@gmail.com>:
>> On Thu, Sep 16, 2010 at 20:53, Pat Notz <patnotz@gmail.com> wrote:
>>> GCC 4.4.4 on MacOS warns about potential use of uninitialized memor=
y.
>>>
>>> Signed-off-by: Pat Notz <patnotz@gmail.com>
>>> ---
>>> =A0dir.c | =A0 =A02 +-
>>> =A01 files changed, 1 insertions(+), 1 deletions(-)
>>>
>>> diff --git a/dir.c b/dir.c
>>> index 133f472..d1e5e5e 100644
>>> --- a/dir.c
>>> +++ b/dir.c
>>> @@ -232,7 +232,7 @@ int add_excludes_from_file_to_list(const char *=
fname,
>>> =A0{
>>> =A0 =A0 =A0 =A0struct stat st;
>>> =A0 =A0 =A0 =A0int fd, i;
>>> - =A0 =A0 =A0 size_t size;
>>> + =A0 =A0 =A0 size_t size =3D 0;
>>> =A0 =A0 =A0 =A0char *buf, *entry;
>>
>> What does the GCC warning say exactl? I.e. what line does it complai=
n
>> about?

Here's the output:

make V=3D1 -j2 all
gcc -o dir.o -c   -g -O2 -Wall -I. -I/opt/local/include
-DUSE_ST_TIMESPEC  -DSHA1_HEADER=3D'<openssl/sha.h>'  -DNO_MEMMEM  dir.=
c
dir.c: In function 'add_excludes_from_file_to_list':
dir.c:235: warning: 'size' may be used uninitialized in this function


>>
>> Maybe this is a logic error introduced in v1.7.0-rc0~25^2? I haven't
>> checked.
>
> I don't see any case that "size" can be used uninitialized. Maybe the
> compiler was confused by
>
> if (!check_index ||
> =A0 =A0(buf =3D read_skip_worktree_file_from_index(fname, &size)) =3D=
=3D NULL)
> =A0 =A0 =A0 =A0return -1;
>

No, line 245: if(size=3D=3D0)

> I wouldn't hurt though to initialize it early, even just to stop the
> compiler from complaining.
> --
> Duy
>
