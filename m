From: Christine Bauers <c.bauers@gmx.de>
Subject: Re: Git svn migration does not work because fatal git checkout updating
 paths is incompatible with switching branches
Date: Thu, 26 Jan 2012 09:50:35 +0100
Message-ID: <4F2113DB.5030401@gmx.de>
References: <4F20442A.1080005@gmx.de> <1327518563.31804.82.camel@centaur.lab.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?Q2FybG9zIE1hcnTDrW4gTmlldG8=?= <cmn@elego.de>
X-From: git-owner@vger.kernel.org Thu Jan 26 09:50:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RqL2Z-0003DD-S1
	for gcvg-git-2@lo.gmane.org; Thu, 26 Jan 2012 09:50:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751553Ab2AZIui convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 Jan 2012 03:50:38 -0500
Received: from mailout-de.gmx.net ([213.165.64.22]:50456 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751154Ab2AZIuh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jan 2012 03:50:37 -0500
Received: (qmail invoked by alias); 26 Jan 2012 08:50:36 -0000
Received: from p4FFE0ECE.dip.t-dialin.net (EHLO [192.168.1.39]) [79.254.14.206]
  by mail.gmx.net (mp006) with SMTP; 26 Jan 2012 09:50:36 +0100
X-Authenticated: #35902447
X-Provags-ID: V01U2FsdGVkX19oXq5Ua8JolnLD821gr9bDX1gNMFb/FeTLXNcgXO
	+7po9GBhD8C3Ui
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:9.0) Gecko/20111222 Thunderbird/9.0.1
In-Reply-To: <1327518563.31804.82.camel@centaur.lab.cmartin.tk>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189145>

Am 25.01.2012 20:09, schrieb Carlos Mart=C3=ADn Nieto:
> On Wed, 2012-01-25 at 19:04 +0100, Christine Bauers wrote:
>> Hi there,
>>
>> I=C2=B4m trying to migrate a repository from svn to git which branch=
es and
>> tags with the following migration script:
>>
>> git svn clone --no-metadata --stdlayout --A ../users.txt
>> svn://host/svn/project/subproject subproject
>>
>> cd subproject
>> git config svn.authorsfile ../../users.txt
>> git svn fetch
>>
>> git checkout -b branch1 remotes/branch1
>> git checkout -b branch2 remotes/branch2
>> git checkout -b branch3 remotes/branch3
>>
>> git checkout -b src_v1 remotes/tags/src
>> git checkout master
>> git tag src src_v1
>> git branch -D src_v1
>>
>> git checkout -b WebContent_v1 remotes/tags/WebContent
>> git checkout master
>> git tag WebContent WebContent_v1
>> git branch -D WebContent_v1
>>
>> and get the follwoing errors:
>>
>> W: Ignoring error from SVN, path probably does not exist: (160013):
>> Filesystem has no item: Datei nicht gefunden: Revision 8966, Pfad
>> =C3=82=C2=BBsubproject=C2=AB
>> W: Do not be alarmed at the above message git-svn is just searching
>> aggressively for old history.
>> This may take a while on large repositories
>> fatal: git checkout: updating paths is incompatible with switching b=
ranches.
>> Did you intend to checkout 'remotes/branch1' which can not be resolv=
ed
>> as commit?
>> fatal: git checkout: updating paths is incompatible with switching b=
ranches.
>> Did you intend to checkout 'remotes/branch2 which can not be resolve=
d as
>> commit?
>> fatal: git checkout: updating paths is incompatible with switching b=
ranches.
>> Did you intend to checkout 'remotes/branch3' which can not be resolv=
ed
>> as commit?
>> fatal: git checkout: updating paths is incompatible with switching b=
ranches.
>> Did you intend to checkout 'remotes/tags/src' which can not be resol=
ved
>> as commit?
>> error: pathspec 'master' did not match any file(s) known to git.
>> fatal: Failed to resolve 'src_v1' as a valid ref.
>> error: branch 'src_v1' not found.
>> fatal: git checkout: updating paths is incompatible with switching b=
ranches.
>> Did you intend to checkout 'remotes/tags/WebContent' which can not b=
e
>> resolved as commit?
>> error: pathspec 'master' did not match any file(s) known to git.
>> fatal: Failed to resolve 'WebContent_v1' as a valid ref.
>> error: branch 'WebContent_v1' not found.
>>
>> How do I solve this problem?
> First try to figure out where the problem happens. It could be that
> git-svn isn't recognising the branches properly, or that the layout
> isn't what it expects or any number of things.
>
> What layout does the repo have? Does it correspond to what git-svn is
> expecting? All those error messages come from the fact that you're
> telling git some starting points that it can't find. Make sure those
> exist and they have the name you're giving. What does `git branch -a`
> say? You're presumably not giving us the real names, so we can't tell=
 if
> there are problems there.
>
> If you're looking to migrate completely, something like
> svn-dump-fast-export ( https://github.com/barrbrain/svn-dump-fast-exp=
ort
> ) might get you there better.
>
>     cmn


Thanks for your answer. I would say the problem happens while cloning t=
he project, because git branch -a and git branch -r says nothing. The q=
uestion is why aren=C2=B4t there any branches? Here is the structure of=
 the project:


marketplace

     braches

         lyth_dev

         meinbestand_suche

         umkreis_suche

     tags

         src

         WebContent

     trunk

         src

         WebContent

     trunk_112233

         src

         WebContent

And here again the script:


git svn clone --no-metadata --stdlayout --A ../users.txt svn://host/svn=
/projects/marketplace marketplace

cd marketplace

git config svn.authorsfile ../../users.txt

git svn fetch

#Checkout Branches

git checkout -b lyth_dev remotes/lyth_dev

git checkout -b meinbestand_suche remotes/meinbestand_suche

git checkout -b umkreis_suche remotes/umkreis_suche


#Checkout der tags

git checkout -b src_v1 remotes/tags/src

git checkout master

git tag src src_v1

git branch -D src_v1

git checkout -b WebContent_v1 remotes/tags/WebContent

git checkout master

git tag WebContent WebContent_v1

git branch -D WebContent_v1

Is there something wrong with this script? Or does the errors maybe occ=
urs because there is a trunk_112233. The log file says the following:

Initialized empty Git repository in c:/project/marketplace/.git/
Checked through r8445
Checked through r8545
Checked through r8645
Checked through r8745
Checked through r8845
Checked through r8945
Checked through r8968
Checked through r8968

And that=C2=B4s all. It says nothing about references.

Do you have any ideas?

Thanks
