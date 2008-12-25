From: "Emily Ren" <lingyan.ren@gmail.com>
Subject: Re: Questions about repo and git submodule
Date: Thu, 25 Dec 2008 14:28:06 +0800
Message-ID: <856bfe0e0812242228o6a428702i296dc87c76cf9dba@mail.gmail.com>
References: <856bfe0e0812230601m1765b483pe62c7902849e9cea@mail.gmail.com>
	 <20081223152951.GB27865@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailinglist" <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Dec 25 07:32:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LFjlh-000264-9A
	for gcvg-git-2@gmane.org; Thu, 25 Dec 2008 07:32:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751428AbYLYG2K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Dec 2008 01:28:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751151AbYLYG2J
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Dec 2008 01:28:09 -0500
Received: from yw-out-2324.google.com ([74.125.46.28]:63041 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750948AbYLYG2I (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Dec 2008 01:28:08 -0500
Received: by yw-out-2324.google.com with SMTP id 9so1101811ywe.1
        for <git@vger.kernel.org>; Wed, 24 Dec 2008 22:28:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=Jm/yme2z07MehtUkpDtG1vjauLuZqbTLie0zjD8sLZE=;
        b=pIHf+JlKt4PQBt/BhbkW2LYSe9tJU/ZvP0rN1m6wauGZ4U2nTqP0Jy3O461s4gmalj
         hM2ej3DhEgRDvHTTUZNceog0QZ5eFjwHkXD/0TiIStNxZvPfY5ajNZW6xW5XlZ29wo/N
         v7lWGNb0iIXcnmGF7lTzQeq/QezX6EvDgfY9I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=gW7jkQHvuEbcl733Pyus8dz7LzBb1bJ7F8bOcPYTuC/u0hUhueMiFSevWFg71d2UEW
         lhiTW/PoLlY9NqEWd7CDv4s9NMxb0wTJuDv3zww/EcjLRmQFBnB0yGqF2g4B+4vINlUi
         hXv0eGMlVCJVGawGZCt9mI9JYBcdfdy431odg=
Received: by 10.151.7.4 with SMTP id k4mr12501197ybi.226.1230186486859;
        Wed, 24 Dec 2008 22:28:06 -0800 (PST)
Received: by 10.150.143.3 with HTTP; Wed, 24 Dec 2008 22:28:06 -0800 (PST)
In-Reply-To: <20081223152951.GB27865@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103891>

Hi Shawn,

Merry Christmas !

Thank you for your guide ! I've created git repository with submodules
with a simple script successfully.

Now I have another question,  since my android repo will always sync
up from android.git.kernel.org, my git repository needs to be updated
accordingly.  Is there a tool I can use to sync up from repo to git
repositoy ?

Thanks,
Emily

On Tue, Dec 23, 2008 at 11:29 PM, Shawn O. Pearce <spearce@spearce.org> wrote:
> Emily Ren <lingyan.ren@gmail.com> wrote:
>>
>> I have some questions about android repo and git submodule.
>>
>> I created a repo repository with below commands:
>> 1.  repo init -u git://android.git.kernel.org/platform/manifest.git
>> 2.  repo initialized in /android
>>
>> 1. The android dir is not a git repository,
>
> Correct, it is not a git repository.  The repo tool does not use
> git submodules.  The top level of a repo client has a ".repo/"
> directory with metadata, not a ".git/" directory.  The table of
> contents (the subprojects) is stored in XML files under ".repo/".
>
> <aside>
> I actually fought against the XML format for repo's manifest, but
> others felt it was suitable.  And then walked away from the project
> after Android open-sourced its code tree.  Leaving me to maintain it.
> I see a file format simplification in the future for repo.
> </aside>
>
>> if other people clone my
>> android code, how does it work?
>
> Sadly this isn't supported correctly.  You can't initialize one
> repo client from another, even though you can git clone one git
> repository from any other.  Its a bug in repo's design.  The data
> under ".repo/projects/" isn't laid out correctly to permit reuse
> of one repo client to initialize another.
>
> Its something I keep meaning to fix, but its going to take some
> real effort.
>
> In the mean time, there is a "--mirror" flag to repo init
> which can be used to clone everything into bare repositories.
> Those bare repositories can be published for others to repo init
> from, though you need to customize the manifest.git:default.xml
> so that the embedded URL refers back to your server and not
> android.git.kernel.org.  Yet another thing I want to fix.
>
>> 2. I want to make android dir to be a git repository, is it workable
>> that I create submodule for each subdirectory in another directory? Is
>> there a script for it?
>
> You might be able to do something like this:
>
>        cd /android
>        git init
>        repo forall -c 'cd /android && git submodule add `pwd`'
>
> Also, you might want to consider asking questions related to repo
> on the repo-discuss@googlegroups.com mailing list.  There's a lot
> more repo users there than on the git mailing list, and they have
> started to come up with their own "tips n tricks".
>
> --
> Shawn.
>
