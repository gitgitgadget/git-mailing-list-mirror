From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [RFC PATCH] git-p4: add option to store files in Git LFS on import
Date: Sun, 30 Aug 2015 12:18:29 +0200
Message-ID: <9951C805-DFBF-47AC-B215-B9C657D4A852@gmail.com>
References: <1440764691-62254-1-git-send-email-larsxschneider@gmail.com> <CAE5ih7-TfLqwye8YpmZz90AVjYGQ8m0sF6GLKnG9pjvV8cTSjw@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Users <git@vger.kernel.org>, technoweenie@github.com
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Sun Aug 30 12:18:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZVzh8-0001Tu-8N
	for gcvg-git-2@plane.gmane.org; Sun, 30 Aug 2015 12:18:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753341AbbH3KSe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Aug 2015 06:18:34 -0400
Received: from mail-wi0-f179.google.com ([209.85.212.179]:37217 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753105AbbH3KSd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 30 Aug 2015 06:18:33 -0400
Received: by wicfv10 with SMTP id fv10so46229187wic.0
        for <git@vger.kernel.org>; Sun, 30 Aug 2015 03:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=JFrg9/fgvCW3nLHg6QW90uSIm0VhDG9eQu8TrwIiksU=;
        b=Dvvz/9IwA7XjLdOnCj/DHu7T3CXhkk8unhAtuoYGV02K/syeQTFjuuorAlgxm2W37E
         bH8AXTICqChmCdivDYrLfV98mJLMbbKZTJJDuXIAuRFWkFrOYiJFg+mr+ZRsd7JgXe+0
         EMM0j/mJY8H2qq0z82YTHfh0c0+F/+Jv0S6vbRl+JI9hOpTdoskig7Kj0zBb1jD6hp/6
         ihakJ6ujtkwnNWbI7Q4oLNIvIoLj3LD7FztslsldNYxrBjCtwwo+0YgwBKAm1G81L6Nc
         FZRw4qVtALNbrhgcJX6TNUMIrs9P1BoTHYSol9y3IB6b7CUpzJ6pzC1pK24Sb5aRh1dE
         gbPQ==
X-Received: by 10.194.90.70 with SMTP id bu6mr21062342wjb.149.1440929912690;
        Sun, 30 Aug 2015 03:18:32 -0700 (PDT)
Received: from farjyzgg12.ads.autodesk.com (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id wo2sm16745219wjb.2.2015.08.30.03.18.31
        (version=TLS1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 30 Aug 2015 03:18:31 -0700 (PDT)
In-Reply-To: <CAE5ih7-TfLqwye8YpmZz90AVjYGQ8m0sF6GLKnG9pjvV8cTSjw@mail.gmail.com>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276816>

Thanks for your feedback!=20

I like the =93handle big files=94 plugin kind of idea. However, I wonde=
r if it makes sense to put more and more stuff into git-p4.py (>3000 LO=
C already). What do you think about splitting git-p4 into multiple file=
s?

Regarding Python 3:=20
Would you drop Python 2 support or do you want to support Python 2/3 in=
 parallel? I would prefer the former=85

- Lars

On 30 Aug 2015, at 10:49, Luke Diamand <luke@diamand.org> wrote:

> On 28 August 2015 at 13:24,  <larsxschneider@gmail.com> wrote:
>> From: Lars Schneider <larsxschneider@gmail.com>
>>=20
>> I am migrating huge Perforce repositories including history to Git. =
Some of them contain large files that would blow up the resulting Git r=
epositories. This patch adds an option to store these files in Git LFS =
[1] on git-p4 clone.
>=20
> I'm a bit worried by this. LFS isn't the only way to handle large
> files in git - there's also git annex (which I've used in a similar
> situation) and obviously random homebrew solutions. We're going to en=
d
> up with git-p4 sprouting ever increasing numbers of
> --use-XXX-if-size-exceeds options. On the other hand, having it
> integrated into git-p4 is quite nice as it saves a lot of messing
> around.
>=20
> Would it be possible as a start to have (within git-p4) a generic
> spot-big-files-and-handle-them-differently patch, and a second patch
> to add specific LFS support? That then means that other schemes would
> be a lot easier to add in future.
>=20
> Some other comments inline.
>=20
>>=20
>> In order to run the unit tests you need to install the Git LFS exten=
sion [2].
>>=20
>> Known limitations:
>> The option "use-lfs-if-size-exceeds" looks at the uncompressed file =
size. Sometimes huge XML files are tiny if compressed. I wonder if ther=
e is an easy way to learn about the size of a file in a git pack file. =
I assume compressing it is the only way to know.
>>=20
>> Feedback is highly appreciated.
>>=20
>> Thank you,
>> Lars
>>=20
>>=20
>> [1] https://git-lfs.github.com/
>> [2] https://github.com/github/git-lfs/releases/
>>=20
>> Lars Schneider (1):
>>  git-p4: add option to store files in Git LFS on import
>>=20
>> Documentation/git-p4.txt |  12 ++
>> git-p4.py                |  94 ++++++++++++++--
>> t/t9822-git-p4-lfs.sh    | 277 +++++++++++++++++++++++++++++++++++++=
++++++++++
>> 3 files changed, 374 insertions(+), 9 deletions(-)
>> create mode 100755 t/t9822-git-p4-lfs.sh
>>=20
>> --
>> 1.9.5 (Apple Git-50.3)
>=20
> Can you switch to a newer git - this one's quite old now so if there
> are regressions introduced later, you won't know about them!
