From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: git subtree as a solution to partial cloning?
Date: Mon, 25 May 2009 13:54:12 -0400
Message-ID: <32541b130905251054k44bdb218sde8837e87d8e8e69@mail.gmail.com>
References: <8873ae500905250021p20e7096dwf5bc71c36c4047b@mail.gmail.com> 
	<32541b130905250059n7b31cc1bk688e5f4bfaf83142@mail.gmail.com> 
	<8873ae500905250233t52dce5b5v8ca88b9921a88437@mail.gmail.com> 
	<32541b130905250850h75f905e0t84287f897600187f@mail.gmail.com> 
	<8873ae500905251035v64084e83wa1a89a562d20224a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Alexander Gavrilov <angavrilov@gmail.com>
To: Asger Ottar Alstrup <asger@area9.dk>
X-From: git-owner@vger.kernel.org Mon May 25 19:54:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8eNn-0005WD-Ph
	for gcvg-git-2@gmane.org; Mon, 25 May 2009 19:54:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752950AbZEYRyg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 May 2009 13:54:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752823AbZEYRyf
	(ORCPT <rfc822;git-outgoing>); Mon, 25 May 2009 13:54:35 -0400
Received: from mail-gx0-f166.google.com ([209.85.217.166]:55688 "EHLO
	mail-gx0-f166.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752099AbZEYRye convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 May 2009 13:54:34 -0400
Received: by gxk10 with SMTP id 10so5778359gxk.13
        for <git@vger.kernel.org>; Mon, 25 May 2009 10:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=fglI1Z4hDXjH/s62nvO90FzZ5yInbzuYayN8yMqPr3o=;
        b=x5YzA5X89kfLnxDECXgBbizTBrT2LOn0fOo5UMs4eYv8vWUdhchx0gvHedyrSZUtQz
         j00TST7RygEMpcZMWhehqs84ffN5rHm0dvr2iMAq9H24+8X6B1g8DKO4G6AFGhRljni5
         8o5TynAS3SttO7xoprQjxKJdq/9AwoYLyPqmo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=mlpAUe/Ufv3ba5NiqV21nAJLDB7yDx3uOxCkcGb6Ifc9MOjYZBnMJrob/8kMcM72TB
         Zz5s7SmZrxSXp/34gIDRVDPIHnWuXDF9A4oE4KcpNCyb/ajKqw607bJJZ1MpBnAzRo+v
         nn5sxpZ4UEDsBmqOb/moBzHAvCYH9Rylt8BOs=
Received: by 10.151.134.2 with SMTP id l2mr14773836ybn.105.1243274072110; Mon, 
	25 May 2009 10:54:32 -0700 (PDT)
In-Reply-To: <8873ae500905251035v64084e83wa1a89a562d20224a@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119945>

On Mon, May 25, 2009 at 1:35 PM, Asger Ottar Alstrup <asger@area9.dk> w=
rote:
> On Mon, May 25, 2009 at 5:50 PM, Avery Pennarun <apenwarr@gmail.com> =
wrote:
>> On Mon, May 25, 2009 at 5:33 AM, Asger Ottar Alstrup <asger@area9.dk=
> wrote:
>>> No, that is unfortunately not so easy. If we could, I suppose we co=
uld
>>> use submodules instead.
>>
>> Your only option may be to use git filter-branch then. =A0It lets yo=
u do
>> pretty much anything you want, although merging it back together aga=
in
>> could be entertaining. =A0(Making it correctly mergeable is by far t=
he
>> trickiest part of git-subtree.)
>
> OK, so git subtree is not usable as it is for this. Instead, it seems
> a new system has to be developed which would be similar to git subtre=
e
> in spirit, except that it worked at a file-level. Of course, the git
> merge subtree strategy can not be used, so merging has to be done
> differently.

That sounds about right.

> So a poor mans system could work like this:
>
> - A reduced repository is defined by a list of paths in a file, I
> guess with a format similar to .gitignore

Are you sure you want to define the list with exclusions instead of
inclusions?  I don't really know your use case.

Anyway, if you're using git filter-branch, it'll be up to you to fix
the index to contain the list of files you want. (See man
git-filter-branch)

> - To extract: A copy of the original repository is made. This copy is
> reduced using git filter-branch. Is there some way of turning a
> .gitignore syntax file into a concrete list of files? Also, can this
> entire step be done in one step without the copy? Having to copy the
> entire project first seems excessive. Will filter-branch preserve
> and/or prune pack files intelligently?

You probably need to read about the differences between git trees,
blobs, and commits.  You're not actually "copying" anything; you're
just creating some new directory structures that contain the
*existing* blobs.  And of course the existing blobs are in your
existing packs.

This is a pretty good introduction:
http://eagain.net/articles/git-for-computer-scientists/

> - To merge from the reduced to the original: The very simple version
> is just to copy all the files from the reduced repository into a
> checkout of the original repository, and then merge. This would not
> support removal (or renaming) of files, but that might be ok in my
> setup. If this needs to be more intelligent, the list of files in the
> reduced repository could be compared with the list of paths that was
> used to reduce it originally. This can be used to detect removals and
> additions of files.

Yes.  In the slightly fancier version of this, you could just do all
your merges from subset->main and never from main->subset, and then a
simple "git merge subset" would handle the above comparison,
additions, and removals for you.

> - To merge from the original to the reduced: First merge the other
> way, and then extract again.

Yes.

> I am new to git, so please excuse me if this design is mentally unsou=
nd.

Well, you're getting pretty far out there:

- git subtree is already an experimental tool that hasn't been
accepted by most people;

- you're doing something similar to git subtree, but even more complica=
ted;

- git is known to work badly with large files, and you have a bunch of
large files;

- git is intended to manage entire repositories at a time, and you
want a partial checkout;

- git is intended to download the entire history at once, and you (I
think) only want part of it.

By the time you're this far out, maybe what you want isn't git at all.
 svn would work fine with this arrangement, and people who want
partial checkouts would rarely benefit from git's distributedness
anyway, I expect.

Have fun,

Avery
