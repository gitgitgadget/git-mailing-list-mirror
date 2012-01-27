From: David Barr <davidbarr@google.com>
Subject: Re: Git svn migration does not work because fatal git checkout
 updating paths is incompatible with switching branches
Date: Fri, 27 Jan 2012 15:34:14 +1100
Message-ID: <CAFfmPPPCuGmgomqjPj_5NogPpiq+tfGSe8mjtqwc_nkWq6Ea0Q@mail.gmail.com>
References: <4F20442A.1080005@gmx.de>
	<1327518563.31804.82.camel@centaur.lab.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Christine Bauers <c.bauers@gmx.de>, git@vger.kernel.org
To: =?ISO-8859-1?Q?Carlos_Mart=EDn_Nieto?= <cmn@elego.de>
X-From: git-owner@vger.kernel.org Fri Jan 27 05:34:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RqdWM-0004cG-3K
	for gcvg-git-2@lo.gmane.org; Fri, 27 Jan 2012 05:34:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752218Ab2A0EeQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 Jan 2012 23:34:16 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:50220 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751759Ab2A0EeP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Jan 2012 23:34:15 -0500
Received: by yhoo21 with SMTP id o21so619758yho.19
        for <git@vger.kernel.org>; Thu, 26 Jan 2012 20:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:x-system-of-record:content-type:content-transfer-encoding;
        bh=AeJWTCcKr6qDoKDKGiRONXYRH6Y6btVKPdsNl6VPITM=;
        b=OUeIHQVWXEfUSmN6QjqaBkKac7Sv3+8gdfWMvUx+yU3v/mfD32EqWc3mzCmrkLd3J+
         HVXmblPSl1IBI7HqRfzeCtuqVbw+ujf3JBcrZ+B7ahKRziikQ7SX/Hs2/72jqSAC3s9g
         JncZxtX6LxY0qUb3caBq4Yb6G8SICpCoXV7pM=
Received: by 10.236.191.134 with SMTP id g6mr7294756yhn.95.1327638854897;
        Thu, 26 Jan 2012 20:34:14 -0800 (PST)
Received: by 10.236.191.134 with SMTP id g6mr7294747yhn.95.1327638854808; Thu,
 26 Jan 2012 20:34:14 -0800 (PST)
Received: by 10.101.144.22 with HTTP; Thu, 26 Jan 2012 20:34:14 -0800 (PST)
In-Reply-To: <1327518563.31804.82.camel@centaur.lab.cmartin.tk>
X-System-Of-Record: true
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189187>

Hi,

A lot of work has occurred on the version of svn-fe within the git tree=
=2E
Jonathan Nieder is the nominal maintainer of that effort.
He has just requested that the most stable set of changes be merged.

--
David Barr

=46rom Jonathan's pull request:

Junio, please pull

 git://repo.or.cz/git/jrn.git svn-fe

to get the following changes since commit
ec014eac0e9e6f30cbbca616090fa2ecf74797e7:

 Git 1.7.5 (2011-04-23 23:36:32 -0700)

up to c5bcbcdcfa1e2a1977497cb3a342c0365c8d78d6:

 vcs-svn: reset first_commit_done in fast_export_init (2011-06-23
10:04:36 -0500)

On Thu, Jan 26, 2012 at 6:09 AM, Carlos Mart=EDn Nieto <cmn@elego.de> w=
rote:
> On Wed, 2012-01-25 at 19:04 +0100, Christine Bauers wrote:
>> Hi there,
>>
>> I=B4m trying to migrate a repository from svn to git which branches =
and
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
>> =C2=BBsubproject=AB
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
>
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
> =A0 cmn
