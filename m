From: Asger Ottar Alstrup <asger@area9.dk>
Subject: Re: git subtree as a solution to partial cloning?
Date: Mon, 25 May 2009 20:28:18 +0200
Message-ID: <8873ae500905251128h1921895dp6ef227e0e0bbec49@mail.gmail.com>
References: <8873ae500905250021p20e7096dwf5bc71c36c4047b@mail.gmail.com>
	 <32541b130905250059n7b31cc1bk688e5f4bfaf83142@mail.gmail.com>
	 <8873ae500905250233t52dce5b5v8ca88b9921a88437@mail.gmail.com>
	 <32541b130905250850h75f905e0t84287f897600187f@mail.gmail.com>
	 <8873ae500905251035v64084e83wa1a89a562d20224a@mail.gmail.com>
	 <32541b130905251054k44bdb218sde8837e87d8e8e69@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Alexander Gavrilov <angavrilov@gmail.com>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 25 20:28:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8euS-0001gE-Os
	for gcvg-git-2@gmane.org; Mon, 25 May 2009 20:28:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751373AbZEYS2U convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 May 2009 14:28:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751310AbZEYS2T
	(ORCPT <rfc822;git-outgoing>); Mon, 25 May 2009 14:28:19 -0400
Received: from mail-bw0-f222.google.com ([209.85.218.222]:51815 "EHLO
	mail-bw0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751046AbZEYS2S convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 May 2009 14:28:18 -0400
Received: by bwz22 with SMTP id 22so3277202bwz.37
        for <git@vger.kernel.org>; Mon, 25 May 2009 11:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=tVQJxeLa++vYFLasUN5uzYuTXv3oLMCT9wX8cLqZ1sE=;
        b=lTeOpQhHwseLXKuIEMiRVg4i51ibCgbR1K7M0Ld+oHL77b2juLYixXhoOSAeuDCipH
         XHcwBI4dUVDuVMd6IARV0F4NrTDDRRpol27v2KGtX7niVlSlVfC1OI70tVuw5VdW1JGS
         F0c7MUtGcyy6TNlGRnfsRr/lXlZrcYpvPtJwo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=X5iKMailYyav7OpUaemLY3+Vi1p1JiW1AC4XtC5tFItUP+VdvH6WVlATEI7VWlWbyV
         039r4IDxJBnMXSEH6LDyDLcVXnHlVLI96LVSC/aadPQuutFJ+YgKmEOVDghZ2D2BeMi5
         p/bvdW8Nbaqau8wIwUG65zW6pHi88WbuGXoAw=
Received: by 10.223.110.3 with SMTP id l3mr3834384fap.48.1243276098123; Mon, 
	25 May 2009 11:28:18 -0700 (PDT)
In-Reply-To: <32541b130905251054k44bdb218sde8837e87d8e8e69@mail.gmail.com>
X-Google-Sender-Auth: 0ad0a99a5f618742
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119946>

On Mon, May 25, 2009 at 7:54 PM, Avery Pennarun <apenwarr@gmail.com> wr=
ote:
> On Mon, May 25, 2009 at 1:35 PM, Asger Ottar Alstrup <asger@area9.dk>=
 wrote:
>> So a poor mans system could work like this:
>>
>> - A reduced repository is defined by a list of paths in a file, I
>> guess with a format similar to .gitignore
>
> Are you sure you want to define the list with exclusions instead of
> inclusions? =A0I don't really know your use case.

Since the .gitignore format supports !, I believe that should not make
much of a difference.

> Anyway, if you're using git filter-branch, it'll be up to you to fix
> the index to contain the list of files you want. (See man
> git-filter-branch)

Yes, sure, and that is why I asked whether there is some tool in git
that can give a list of concrete files surviving a .gitignore list of
patterns.

>> - To extract: A copy of the original repository is made. This copy i=
s
>> reduced using git filter-branch. Is there some way of turning a
>> .gitignore syntax file into a concrete list of files? Also, can this
>> entire step be done in one step without the copy? Having to copy the
>> entire project first seems excessive. Will filter-branch preserve
>> and/or prune pack files intelligently?
>
> You probably need to read about the differences between git trees,
> blobs, and commits. =A0You're not actually "copying" anything; you're
> just creating some new directory structures that contain the
> *existing* blobs. =A0And of course the existing blobs are in your
> existing packs.

Thanks. OK, I see now that filter-branch will not destroy the original
repository. That is not at all obvious from reading the man page, when
the very first sentence says that it will rewrite history. But the
main point of this exercise is to reduce the size of the reduced
repository so that it can be transferred effectively. So after
filter-branch, I guess I would run clone afterwards to make the new,
smaller repository, and then the question becomes: Will clone reuse
and prune packs intelligently?

> Well, you're getting pretty far out there:
>
> - git is known to work badly with large files, and you have a bunch o=
f
> large files;

As far as I know, git has most of the hooks needed to tune this. There
are still some weak areas where big files are read into memory
multiple times, but I have seen that people are already working on
this.

> - git is intended to manage entire repositories at a time, and you
> want a partial checkout;

The beauty of the subtree-inspired approach is of course that the
users of the reduced repositories WILL in fact be working on an entire
repository. The files are luckily fairly independent in THEIR
workflow. Also, if the mirror-sync proposal gets implemented, one
important part of the distribution piece is also solved: In effect,
these systems combined would give us a kind of narrow-clone.

> - git is intended to download the entire history at once, and you (I
> think) only want part of it.

I do need the entire history for the reduced files.

> By the time you're this far out, maybe what you want isn't git at all=
=2E
> =A0svn would work fine with this arrangement, and people who want
> partial checkouts would rarely benefit from git's distributedness
> anyway, I expect.

In my use case, some people will need to work on the full repository,
and they obviously will have the network and the machines to handle
this. I am currently thinking these people would use something like
glusterfs until mirrorsync is able to solve the problem for us.

However, there is a large group of users that do not need this, but
they DO need the entire history of the files they are interested in.
Subversion does not provide this. Also, Subversion is simply too slow
to handle the kind of files we need to work with. Also, we have run
tests on the kind of files we have, and the delta compression that git
uses is very effective for compression the pdf and openoffice
documents we use. The big files we have are primarily image files, and
obviously they do not compress very well. Fortunately, they do not
change much either.

While git might not currently be designed to support this use case, it
still seems like the best system to base this on. Yes, it will need
some work before we can use it for our needs, but it seems it is still
less work than what is needed to get other systems to support our
needs.

I appreciate your comments. They are very helpful.

Regards,
Asger
