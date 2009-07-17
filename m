From: Changsheng Jiang <jiangzuoyan@gmail.com>
Subject: Re: how to fetch a new svn branch after clone?
Date: Fri, 17 Jul 2009 10:25:38 +0800
Message-ID: <eafc0afe0907161925j331ad90cx708bd3f1663c4c71@mail.gmail.com>
References: <eafc0afe0907160830m29e2f3d3jf5c0e9db29cace54@mail.gmail.com> 
	<4A5F8CDA.5080202@xiplink.com> <eafc0afe0907161900k35b2dff1u5a2bfc574bb93231@mail.gmail.com> 
	<6786ed4f0907161918t5d4489a5uf1c315b07f850e2e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Allen Johnson <akjohnson78@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 17 04:26:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRd9F-0003bG-1P
	for gcvg-git-2@gmane.org; Fri, 17 Jul 2009 04:26:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933989AbZGQC0C convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 16 Jul 2009 22:26:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933982AbZGQC0B
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Jul 2009 22:26:01 -0400
Received: from mail-vw0-f200.google.com ([209.85.212.200]:46764 "EHLO
	mail-vw0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933980AbZGQC0A convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Jul 2009 22:26:00 -0400
Received: by vwj38 with SMTP id 38so575613vwj.33
        for <git@vger.kernel.org>; Thu, 16 Jul 2009 19:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=sqUKu0bI9SlAHLUKWITBa5rLea8Gu1F8I/P8JutFWAQ=;
        b=u4WJzbt6vyQtyqDRzpkpaVWe14r1XwheAUwGJp9snWYGY0WqfCLuvWadvXjKuDgjqu
         gx+Wn7NyfPRNUA8fgdI7rnpzo4AHgLN1VvRcnsav5IsnC9A1BCclU4mH6O/SHWl/WSCJ
         5VUTatRkcsFIHVH7A6ZWyEyqY64YnLTRxD3L0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=BMoCR1vS1Vt8X53VODvU9l9xeERT1UeJk9eFyw6mJde0BePrG+u44ga4fifisWpQpa
         B3nIaXIboE0BYKcWX/J8ZXvcTvZtT7Ksrb0mg33dBP5nl64JtH/qh9LS2ngqk8kxZdgF
         oDIxIn61uDbrwN6onMzbxsPbMGBuOfwC4SCks=
Received: by 10.220.72.194 with SMTP id n2mr818105vcj.36.1247797558081; Thu, 
	16 Jul 2009 19:25:58 -0700 (PDT)
In-Reply-To: <6786ed4f0907161918t5d4489a5uf1c315b07f850e2e@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123441>

Thank Allen.

I deleted some branches in local git repository, since it's no need to
track every one's branch.

And after that, ''git svn fetch'' report error like this:

error: invalid object a0eb1d6f18d20c0b9f30062cd981e9b668aac75f
fatal: git-write-tree: error building trees
write-tree: command returned error: 128

Is it wrong to delete some svn branches in git by "git branch -r -d bra=
nch_name"

                                                      Changsheng Jiang



On Fri, Jul 17, 2009 at 10:18, Allen Johnson<akjohnson78@gmail.com> wro=
te:
> This setup works for me:
>
> # create branch directly in svn
> svn copy svn://hostname/project/trunk
> svn://hostname/project/branches/test -m "test"
>
> # update your local git repository
> git svn fetch
>
> # verify you have the branch by listing all remote branches
> git branch -r
>
> # you should see "test" in the list, now checkout that branch and do =
some work
> git checkout -b local-test test
>
> # perform some commits on that branch then sync with svn
> git commit ...
> git svn rebase
> git svn dcommit
>
> Hope that works for you.
>
> Allen
>
> On Thu, Jul 16, 2009 at 10:00 PM, Changsheng Jiang<jiangzuoyan@gmail.=
com> wrote:
>> Thank Marc.
>>
>> You are right, it should be the latter case with url
>> http://www.example.com/project/branches/test
>>
>> But "git svn clone" has already added these lines to .git/config
>>
>> [svn-remote "svn"]
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0url =3D https://xxx.xxxx.com/svn/xxx
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0fetch =3D trunk:refs/remotes/trunk
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0branches =3D branches/*:refs/remotes/*
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0tags =3D tags/*:refs/remotes/tags/*
>>
>> And it still can not fetch new branch.
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Changsheng Jiang
>>
>> On Fri, Jul 17, 2009 at 04:26, Marc Branchaud<marcnarc@xiplink.com> =
wrote:
>>> The latest 1.6.4-rc1 contains patches to git-svn for it to support =
more than one branch URL in an svn repository.
>>>
>>> However, before I describe that, can you confirm whether your new b=
ranch is in fact named
>>>
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0http://svn.example.com/project/test
>>>
>>> or is it really
>>>
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0http://svn.example.com/project/test/<bra=
nchname>
>>>
>>> Because if it's the former then I'm not sure if git-svn can handle =
your new branch. =C2=A0The problem is that even though the branch is na=
med 'test' it's a sibling to the 'branches' 'tags' and 'trunk' paths in=
 the repository. =C2=A0For git-svn to pick up branches, you point it at=
 the path *containing* the branch names. =C2=A0In the former case, to p=
ick up project/test as the 'test' branch you'd have to point git-svn at=
 the project directory, and that would cause it to also pick up project=
/tags, project/branches, and project/trunk as other branches (named 'ta=
gs', 'branches' and 'trunk').
>>>
>>> However, in the latter (test/<branchname>) case, with 1.6.4, I *thi=
nk* git-svn will pick up the new branches under test if you add a new '=
branches' line to the svn-remote's section in your .git/config file. =C2=
=A0Something like
>>>
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0branches =3D test/*:refs/remotes/*
>>>
>>> might let you see the new branches. =C2=A0The reason I can't be mor=
e certain is that if you've done a 'git svn fetch' since the branch was=
 created then git-svn might not pick up the branch-creation commits lat=
er. =C2=A0Unfortunately I don't know git-svn well enough to say for cer=
tain.
>>>
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0M.
>>>
>>>
>>> Changsheng Jiang wrote:
>>>> Hi list,
>>>>
>>>> I know how to clone a svn repository with all branches and tags at=
 the
>>>> initial step, but I find no answers of how to fetch a new svn bran=
ch
>>>> after clone.
>>>>
>>>> For example, this
>>>>
>>>> git svn clone http://svn.example.com/project -T trunk -b branches =
-t tags
>>>>
>>>> will clone all branches. but that clone, the svn repository has a =
new
>>>> branch test with url http://svn.example.com/project/test, how to c=
lone
>>>> it as the initial step?
>>>>
>>>> Thanks.
>>>>
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Changsheng Jiang
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe git" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info=
=2Ehtml
>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.h=
tml
>>
>
