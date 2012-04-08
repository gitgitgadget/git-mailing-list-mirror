From: "Yi, EungJun" <semtlenori@gmail.com>
Subject: Re: In tree object, Must the
Date: Mon, 9 Apr 2012 00:22:59 +0900
Message-ID: <CAFT+Tg8K9H4hnjJcXBtM931MpeRDC8V1OV-uns1F9+sAWwf8VQ@mail.gmail.com>
References: <CAFT+Tg-+s5=pFNwY7ZMxem4z6YHu53kyOs0B_rkmphq=mEtpTg@mail.gmail.com>
	<1333891217.7419.5.camel@centaur.lab.cmartin.tk>
Reply-To: semtlenori@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?Carlos_Mart=EDn_Nieto?= <cmn@elego.de>
X-From: git-owner@vger.kernel.org Sun Apr 08 17:23:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SGtxL-0002NW-Nn
	for gcvg-git-2@plane.gmane.org; Sun, 08 Apr 2012 17:23:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755644Ab2DHPXA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Apr 2012 11:23:00 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:50890 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755561Ab2DHPW7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Apr 2012 11:22:59 -0400
Received: by obbtb18 with SMTP id tb18so4911823obb.19
        for <git@vger.kernel.org>; Sun, 08 Apr 2012 08:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        bh=bzQtppojN1Z6d55oTnCQsV2xAMdj0K9aNY8GiTaba10=;
        b=Mwd6tAqlMbikBC3lDVc5oH0QqcF0GF1MSle7tGRibeRqn2PeRZi9HT+Sp4dyn0Y23o
         WrnzLdwB9s1ZghXISc6FMdyvhymrwhSZiguoBrb0FxG6BEiL7TqFKW5MvKUrLZkx9U9a
         NFTHudqIWWBJTE5GzvzCSOx0A42yPadwZZICLbKmB+G491xN08K6BhDE+WUlasQbFPwN
         u4h+tE4vcnaBFH2ENdVBQMudg3AsBhvHS9IK+Zd/8Xcgch9Om4EAP5+uHuc/0nH3i007
         HSP7YY6J+rOS8QCIjSKfWA3OVryL2aEltHXThYdOME0JrWoWCPhm9QgGZ/zENYkcoNk5
         ihew==
Received: by 10.60.32.210 with SMTP id l18mr6137709oei.1.1333898579230; Sun,
 08 Apr 2012 08:22:59 -0700 (PDT)
Received: by 10.182.53.98 with HTTP; Sun, 8 Apr 2012 08:22:59 -0700 (PDT)
In-Reply-To: <1333891217.7419.5.camel@centaur.lab.cmartin.tk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195004>

You are right. I tried to clone a repository which has a unordered
tree object and all you said happened, as below.

$ git ls-tree HEAD
100644 blob a6ccb8dec6b21e9d3e0b716d3a0915262a8c4474	b
100644 blob a3df8f3749f855a2d905d92f11590a9c18a1bcbb	a
100644 blob 424907d3fe9f1fa4b2e3a0bb65ab99780d9acfba	c
$ git show -- b
$ git show -- a
$ git fsck
error in tree 3f5a56e992a01f2e500bed57360f3961323b9d6e: not properly so=
rted
error in tree a94e7dc2820eb4d0ef308fac1a32b3715e82dc76: not properly so=
rted

I want to allow users to clone the git repository created by my impleme=
ntation,
but before I have to sort tree objects. Thanks to you, I know that now.

And your suggestion to use node-gitteh is also thankful,
but I want pure js implementation without libgit2.

2012=EB=85=84 4=EC=9B=94 8=EC=9D=BC =EC=98=A4=ED=9B=84 10:20, Carlos Ma=
rt=C3=ADn Nieto <cmn@elego.de>=EB=8B=98=EC=9D=98 =EB=A7=90:
> On Sun, 2012-04-08 at 12:43 +0900, Yi, EungJun wrote:
>> Hello,
>>
>> I'm implementing Git using node.js, and I have a question while I
>> write some code to store tree object.
>>
>> Tree object looks a table consists of three fields: blob's mode, nam=
e
>> and id, as below.
>>
>> e.g.)
>> $ git cat-file -p 45799547
>> 100644 blob cd242b1e5bb403500feb49a1aa656c21c6c0be69 =C2=A0Makefile
>> 100644 blob bf382321749577d52bd2fbf2281df0510b4bad31 =C2=A0README.md
>> 100644 blob 5441bb48428611a3cb140d8192d39484fcf3b742 =C2=A0fsutil.js
>> 100644 blob 0af680a5c0dd4482b09aa7f8e837234bed0b7cfa =C2=A0package.j=
son
>> 040000 tree 39a4d45669addfb1e8f0a499deebc5b97b4edfa0 =C2=A0test
>>
>> It seems that the table is stored in order by blob's name.
>
> Yes, the entries in the tree are alpha-sorted. The exception are tree=
s,
> where you have to pretend that there is a trailing slash. In other
> words, the order is the same as you'd see in the index (as there, the
> test/ directory in your example would be stored with a slash and the
> name of the subdirs and files in it.
>
>>
>> If it is true, what happens if it is not ordered?
>
> fsck complains for one.
>
>>
>> Does that cause any troubles to users to use a git repository create=
d
>> and managed by my Git implementation?
>
> How does your implementation store things? You haven't said (maybe
> hinted that you may be writing trees with the wrong order). Depending=
 on
> the particular implementation of whatever is reading the git reposito=
ry,
> it might not be able to find an entry in your tree, as it's wrongly
> sorted, but that depends on the exact implementation and possibly luc=
k.
>
> Do you need to write this in pure js? There are some bindings for
> node.js[0] already for libgit2 so you don't need to redo the low-leve=
l
> work.
>
> Cheers,
> =C2=A0 cmn
>
> [0] https://github.com/libgit2/node-gitteh
>
