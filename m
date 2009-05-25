From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: git subtree as a solution to partial cloning?
Date: Mon, 25 May 2009 15:18:50 -0400
Message-ID: <32541b130905251218w10e43b85v489f6018366058d4@mail.gmail.com>
References: <8873ae500905250021p20e7096dwf5bc71c36c4047b@mail.gmail.com> 
	<32541b130905250059n7b31cc1bk688e5f4bfaf83142@mail.gmail.com> 
	<8873ae500905250233t52dce5b5v8ca88b9921a88437@mail.gmail.com> 
	<32541b130905250850h75f905e0t84287f897600187f@mail.gmail.com> 
	<8873ae500905251035v64084e83wa1a89a562d20224a@mail.gmail.com> 
	<32541b130905251054k44bdb218sde8837e87d8e8e69@mail.gmail.com> 
	<8873ae500905251128h1921895dp6ef227e0e0bbec49@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Alexander Gavrilov <angavrilov@gmail.com>
To: Asger Ottar Alstrup <asger@area9.dk>
X-From: git-owner@vger.kernel.org Mon May 25 21:19:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8fhu-0004p0-Qy
	for gcvg-git-2@gmane.org; Mon, 25 May 2009 21:19:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753363AbZEYTTL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 May 2009 15:19:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752563AbZEYTTK
	(ORCPT <rfc822;git-outgoing>); Mon, 25 May 2009 15:19:10 -0400
Received: from yx-out-2324.google.com ([74.125.44.28]:35990 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752538AbZEYTTI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 May 2009 15:19:08 -0400
Received: by yx-out-2324.google.com with SMTP id 3so1950448yxj.1
        for <git@vger.kernel.org>; Mon, 25 May 2009 12:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=oUY8gDM3KsPcZuatCnf1cZv9IoMYxqpzMqO8+5ZlWOA=;
        b=kUtuBpUH7QOza6eg544kf6q6ksFb5pseOnq3uXDdxKygB2K+UUud6LA0mAlEVQWAVy
         qyV9aGfLPIaGarh5OB8nP3cOCd/D2UcFqz/4QhG7dwF3JtYm2G8VJCHFF5egJ8HesHtq
         shEBSgkGBByZsbkuSrxX4XKAiE6mVzHpx0bJ8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=rfTKPyjahBaCkgf/h1G94dfvFeESfGgB3rH/aKRKYa2I0Dz2yQ4HK44BGbLiUpDnZn
         vGFYiJSZw6qVCbqQLDM3GWQwRMOUOeOsjeJPplzMA5w2j7WF+xe5l9uMlGF0LJcdvXRa
         pJ1ly0LqN9kPtqS07id2ZIFAgggFPQ5X70214=
Received: by 10.151.134.2 with SMTP id l2mr14920735ybn.105.1243279150086; Mon, 
	25 May 2009 12:19:10 -0700 (PDT)
In-Reply-To: <8873ae500905251128h1921895dp6ef227e0e0bbec49@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119956>

On Mon, May 25, 2009 at 2:28 PM, Asger Ottar Alstrup <asger@area9.dk> w=
rote:
> On Mon, May 25, 2009 at 7:54 PM, Avery Pennarun <apenwarr@gmail.com> =
wrote:
>> On Mon, May 25, 2009 at 1:35 PM, Asger Ottar Alstrup <asger@area9.dk=
> wrote:
>>> So a poor mans system could work like this:
>>>
>>> - A reduced repository is defined by a list of paths in a file, I
>>> guess with a format similar to .gitignore
>>
>> Are you sure you want to define the list with exclusions instead of
>> inclusions? =A0I don't really know your use case.
>
> Since the .gitignore format supports !, I believe that should not mak=
e
> much of a difference.
>
>> Anyway, if you're using git filter-branch, it'll be up to you to fix
>> the index to contain the list of files you want. (See man
>> git-filter-branch)
>
> Yes, sure, and that is why I asked whether there is some tool in git
> that can give a list of concrete files surviving a .gitignore list of
> patterns.

Well, the problem here is with the definition of "concrete file."  If
you're using git filter-branch --index-filter (which is much faster
than --tree-filter), then your trees won't be checked out at all.  And
thus there is the open question of exactly what list of files you want
to use.  It's unlikely that any existing tool will do it exactly the
way you want (although I could be wrong).

In any case, what you'd probably do is something like git ls-files
--cached | perlscript, where your perlscript does whatever you want to
the file list.

> Thanks. OK, I see now that filter-branch will not destroy the origina=
l
> repository. That is not at all obvious from reading the man page, whe=
n
> the very first sentence says that it will rewrite history. But the
> main point of this exercise is to reduce the size of the reduced
> repository so that it can be transferred effectively. So after
> filter-branch, I guess I would run clone afterwards to make the new,
> smaller repository, and then the question becomes: Will clone reuse
> and prune packs intelligently?

filter-branch will destroy the history of the current branch.  But if
you make a new branch first, you'll be okay.

You seem to be giving the concept of "packs" a bit too much weight.
Packs are just groups of objects.  AFAIK, cloning and fetching
generally produces entirely new packs for each client.

clone is quite intelligent; in fact, if you clone the repository on
your local machine, it's so intelligent that it'll hardlink the packs
instead of copying them and it'll take virtually no space at all!

But you don't need to copy the whole repository unless you want to.
You can retrieve just the one, stripped-down branch from a client with
something like this:

   mkdir myproj
   cd myproj
   git init
   git fetch server:whatever.git my-stripped-down-branchname
   git checkout -b master FETCH_HEAD

Have fun,

Avery
