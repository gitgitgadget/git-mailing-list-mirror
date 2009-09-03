From: Daniele Segato <daniele.bilug@gmail.com>
Subject: Re: git-svn-Cloning repository with complicate nesting
Date: Thu, 3 Sep 2009 18:17:07 +0200
Message-ID: <9accb4400909030917y2e8d4c97tef1320c05d4c4e1c@mail.gmail.com>
References: <9accb4400908270132vaccc4eegb58e2f0ee8de0797@mail.gmail.com>
	 <4A9FD34A.7020101@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Thu Sep 03 18:17:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MjEzs-0003K8-4g
	for gcvg-git-2@lo.gmane.org; Thu, 03 Sep 2009 18:17:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755945AbZICQRJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Sep 2009 12:17:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755897AbZICQRI
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Sep 2009 12:17:08 -0400
Received: from mail-fx0-f217.google.com ([209.85.220.217]:61930 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755834AbZICQRH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Sep 2009 12:17:07 -0400
Received: by fxm17 with SMTP id 17so54186fxm.37
        for <git@vger.kernel.org>; Thu, 03 Sep 2009 09:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=DeiwAjxpcz4IEB5qhpijXKQk75VXsPxy+avL+v/w1Z8=;
        b=qgfQpjkyf5F5VmBNLGG52hBo1jL+StUypAW/hSQroZFtDpATjpmBwykX6RJE2wyjCZ
         IUhzhbjJGj7Vx1EAkls2aWsCwGw+MoimqExod2NzSN6sgW39/D5BenEFvsB1W8UH429c
         8j7i7JnlUbgyXcFKqQN/uY5b/K93TJ7fN/J+0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=T4hrIoBXOvfBcnrZw1v/hblvIbPE9Bd5Gy82+geHXtWsn+GhUElBJ9vzviXNZyj4Zf
         GFwGn8duvOyHliHta2JyarXzg3rbQwPU1OiV7mh2sa00/auVZG3+uZs8xlPt+NDfsLwg
         czezVId0hjfKYzYnHB89FQ1uvf4DaV0zoaMpk=
Received: by 10.223.143.79 with SMTP id t15mr4211898fau.6.1251994627833; Thu, 
	03 Sep 2009 09:17:07 -0700 (PDT)
In-Reply-To: <4A9FD34A.7020101@xiplink.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127660>

On Thu, Sep 3, 2009 at 4:31 PM, Marc Branchaud<marcnarc@xiplink.com> wr=
ote:
> Hi Daniele,

Hi Marc and thank you for your reply.

> I think you're stuck. =C2=A0Someone who knows git-svn better than I m=
ight be able to figure out a solution (I haven't played with using wild=
cards in the middle of branches refspecs), but as far as I can tell git=
-svn can't support your repository's structure.
>
> The fundamental problem is that the BRANCHES/ hierarchy isn't consist=
ent. =C2=A0git-svn expects the directories under a 'branches' path to b=
e branch names. =C2=A0In your case, you can't specify a configuration t=
hat covers your whole repository.

yes..
and developers should be smart enought to keep consistency on their
own.. unfurtunately they oftern aren't

> So I think git-svn would need to be modified to support your situatio=
n.

I'm not feeling that lucky but I would be happy about it. :-)

> One possible approach is to make git-svn smart about what it consider=
s a branch's name. =C2=A0In theory, what you'd like is to just specify

> To do this, git-svn could track the current 'trunk' directory structu=
re (just the top-level contents of the root should suffice). =C2=A0Then=
 when it detects a new path under BRANCHES it could search through that=
 path until it finds the same 'trunk' directory structure, and then use=
 the path as the full branch name.

> When a commit creates a new branch:

> git-svn sees that the commit is to a new path under branches/ and loo=
ks through branches/some/ and branches/some/path/ to find the trunk's c=
ontents, deciding in this case that 'some/path' is the branch's name.
>
> Anyway, this is just an idea of how things might work. =C2=A0There ar=
e probably some corner-cases that could make this a bit tricky to imple=
ment...

hum...
It could be an idea but I don't know how hard could it be to check it:
how much deep inside the tree should Git search for branch? what if
there are branches that are completely differents?

may be the user could create and pass a "branch model" to git svn to
make it able to decide what is a branch and what isn't.

I think there are many options

In my case It would have worked defining a structure like:
BRANCHES/*/root -> remote/svn/branch/*
BRANCHES/*/*/root -> remote/svn/branch/*/*

But it would be better with something like:
BRANCHES/\([^\/]+\)/root -> remote/svn/branch/$1
BRANCHES/\([^\/]+\)/\([^\/]+\)/root -> remote/svn/branch/$1/$2

like a grouped regex.

every branch not matching the regex will be skipped..
only an idea.. It couln't work in every situation but it would allow a
greater degree of freedom in the configuration.

I don't know if Git developers are interested in thinking on some
features like this.. it sound like an SVN-only hack to me.

Regards,
Daniele
