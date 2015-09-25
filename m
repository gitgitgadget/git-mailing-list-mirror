From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: git-p4: t9819 failing
Date: Fri, 25 Sep 2015 11:29:37 +0200
Message-ID: <AFE58E7F-88FA-4DF8-9372-B2B0D1E0E2AC@gmail.com>
References: <CAE5ih79t+62XUKsj9cnkJCCv4WPhUgQZQ6hF39Nx0ky+WFi-sw@mail.gmail.com> <954B65C2-1CF8-4F63-B2DE-F15200553046@gmail.com> <CAE5ih78x+jnW3+4d5q5dJidt4LXWV=hMgJTEfsC2dUBLout1Aw@mail.gmail.com> <F37BA8D8-6845-4C47-BBE2-3313685FD16F@gmail.com> <CAE5ih78m9RbD=s_12ckA+yzRP=fuiruF=kasUSFZEjUZZA21UQ@mail.gmail.com> <CAE5ih7-f3V2YSWW7FO-MxB6BPu7WjB93jDDFs5mKkzz2wDX0yA@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Users <git@vger.kernel.org>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Fri Sep 25 11:30:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZfPKH-0006Bf-Ce
	for gcvg-git-2@plane.gmane.org; Fri, 25 Sep 2015 11:29:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756018AbbIYJ3n convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Sep 2015 05:29:43 -0400
Received: from mail-wi0-f176.google.com ([209.85.212.176]:36332 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756010AbbIYJ3l convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Sep 2015 05:29:41 -0400
Received: by wicgb1 with SMTP id gb1so12156504wic.1
        for <git@vger.kernel.org>; Fri, 25 Sep 2015 02:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=wVMcXEj8oAT50poQ9ETNjvQCqctZ0Nkdgr+g3TGfwBE=;
        b=DXIFiTtv/gi50ObvC6Gt3Q8NyERY5nHsWRBDBUYiwZTBX0AbESWyMZ0QBQw39ZwsLb
         np+K441Xf51bRYbvCdDOFs3VAygIVin2ieC7FLhixfEedpYBsszCNMpOFGjsIKsPVwCK
         dqKToIKyQr6h1zplJ8o5wsn8j4GObvWf9cTzuf/4SQNXdvYyRHIsC4SgPFwuetlkZ254
         VT6rfUCATcoR0pfuP1coGgsAZO9/S0hsQeP7uduhFqb/xLeIYBLmzU9kXRJwULg+HNpw
         W431tqPudfJKwaLjC9tMM+PgThi2iKqjjjYr0S+ZT/mAMAAip2K87wPTwRhQT7oohwXM
         ihJA==
X-Received: by 10.180.8.232 with SMTP id u8mr2387192wia.10.1443173380129;
        Fri, 25 Sep 2015 02:29:40 -0700 (PDT)
Received: from slxbook3.fritz.box (dslb-188-102-071-165.188.102.pools.vodafone-ip.de. [188.102.71.165])
        by smtp.gmail.com with ESMTPSA id ex17sm2274645wid.23.2015.09.25.02.29.39
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 25 Sep 2015 02:29:39 -0700 (PDT)
In-Reply-To: <CAE5ih7-f3V2YSWW7FO-MxB6BPu7WjB93jDDFs5mKkzz2wDX0yA@mail.gmail.com>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278655>

Good catch. The case-handling test is actually fine. There was a bug in=
 my implementation!

If you do this:
git p4 clone //depot/something/...

Then git p4 generates a directory =93something=94 and clones into that =
(similar to Git). Since I set =93cloneDirectory=94 to the current worki=
ng directory that logic never kicked in. Therefore the depot was cloned=
 into the current working directory instead of a new directory =93somet=
hing=94 and the test broke.

Thanks,
Lars

On 24 Sep 2015, at 22:29, Luke Diamand <luke@diamand.org> wrote:

> OK, slight correction there - it now doesn't crash getting the disk
> usage, but I think it still needs to be updated following the other
> changes to case-handling.
>=20
> Luke
>=20
> On 24 September 2015 at 08:45, Luke Diamand <luke@diamand.org> wrote:
>> On 23 September 2015 at 13:28, Lars Schneider <larsxschneider@gmail.=
com> wrote:
>>>=20
>>>> Here's the last bit of the crash dump from git-p4 I get:
>>>>=20
>>>> File "/home/ldiamand/git/git/git-p4", line 2580, in streamP4FilesC=
bSelf
>>>>   self.streamP4FilesCb(entry)
>>>> File "/home/ldiamand/git/git/git-p4", line 2497, in streamP4FilesC=
b
>>>>   required_bytes =3D int((4 * int(self.stream_file["fileSize"])) -
>>>> calcDiskFree(self.cloneDestination))
>>>> File "/home/ldiamand/git/git/git-p4", line 116, in calcDiskFree
>>>>   st =3D os.statvfs(dirname)
>>>> OSError: [Errno 2] No such file or directory: 'lc'
>>>>=20
>>>> Luke
>>> Confirmed. What do you think about this fix?
>>=20
>> Works for me!
>>=20
>>=20
>>=20
>>>=20
>>> Thank you,
>>> Lars
>>>=20
>>> ---
>>> git-p4.py | 1 +
>>> 1 file changed, 1 insertion(+)
>>>=20
>>> diff --git a/git-p4.py b/git-p4.py
>>> index 1d1bb87..66c0a4e 100755
>>> --- a/git-p4.py
>>> +++ b/git-p4.py
>>> @@ -3478,6 +3478,7 @@ class P4Clone(P4Sync):
>>>=20
>>>         print "Importing from %s into %s" % (', '.join(depotPaths),=
 self.cloneDestination)
>>>=20
>>> +        self.cloneDestination =3D os.path.abspath(self.cloneDestin=
ation)
>>>         if not os.path.exists(self.cloneDestination):
>>>             os.makedirs(self.cloneDestination)
>>>         chdir(self.cloneDestination)
>>> --
