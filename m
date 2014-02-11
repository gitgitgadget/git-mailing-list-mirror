From: Johan Herland <johan@herland.net>
Subject: Re: git-note -C changes commit type?
Date: Wed, 12 Feb 2014 00:52:51 +0100
Message-ID: <CALKQrgcM7JpZCk4amjo_rwg5uuuWNg-5yd1NXB5p7EtrU9WBGg@mail.gmail.com>
References: <1392139407.12790.7.camel@kirk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git mailing list <git@vger.kernel.org>
To: Joachim Breitner <mail@joachim-breitner.de>
X-From: git-owner@vger.kernel.org Wed Feb 12 00:53:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WDN8T-0003YW-8T
	for gcvg-git-2@plane.gmane.org; Wed, 12 Feb 2014 00:53:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752136AbaBKXxA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Feb 2014 18:53:00 -0500
Received: from mail12.copyleft.no ([188.94.218.224]:34471 "EHLO
	mail12.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751585AbaBKXw7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Feb 2014 18:52:59 -0500
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail12.copyleft.no with esmtp (Exim 4.76)
	(envelope-from <johan@herland.net>)
	id 1WDN8K-0004QL-QL
	for git@vger.kernel.org; Wed, 12 Feb 2014 00:52:56 +0100
Received: from mail-pb0-f46.google.com ([209.85.160.46])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1WDN8J-0000Kl-SI
	for git@vger.kernel.org; Wed, 12 Feb 2014 00:52:56 +0100
Received: by mail-pb0-f46.google.com with SMTP id um1so8448863pbc.33
        for <git@vger.kernel.org>; Tue, 11 Feb 2014 15:52:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=BgODI9OObwyEOzbUUlSqJvjnQKtrATBFo+xwhUf507E=;
        b=WRX5Vu7TLEFTQ74bLVZ2GjQXOsdO9WT5hjaLshOiOM8tpTB+Qv1KXXy17DFWNpchPn
         VRRprC2WqbLmd29a2qyqZW0CJwtEvhGI1LuT3Negflk+DlHuxVT80se0ttyDdvfh91mg
         dEZhAyLm506BYf9IB7Jquv2eS+JZ47xW+YtiEpqk90oUhGLHVVh3VQJdqvR+RsYNhZOZ
         1a3b6+CfOGX49pFxNBrmGfIzHvfk1MgzlfFr0kSubnyUS33qMsedKcluzqppdz9DguBF
         PkTXVR+KzqHAyfKWby2ULWFepdywrY7M148qJdzESpNRx2l8UEJG8rJEpfz/Es4GKQPn
         /6wA==
X-Received: by 10.68.138.165 with SMTP id qr5mr48066677pbb.123.1392162771946;
 Tue, 11 Feb 2014 15:52:51 -0800 (PST)
Received: by 10.70.48.228 with HTTP; Tue, 11 Feb 2014 15:52:51 -0800 (PST)
In-Reply-To: <1392139407.12790.7.camel@kirk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241962>

On Tue, Feb 11, 2014 at 6:23 PM, Joachim Breitner
<mail@joachim-breitner.de> wrote:
> Hi,
>
> judging from the documentation I got the impression that I can pass any
> git object has to "git note -C <hash>" and it would stored as-is. But it
> seems the objects gets mangled somehow...

...well... the documentation does not say "any object", it actually
explicitly says "blob object"... ;)

> (I want to attach a commit object as a note, to reference the history of
> a feature before the final cleanup rebase. For that I turn the reflog
> into a series of commits, and the final commit is the one I want to
> store there.)
>
> $ mkdir foo
> $ cd foo/
> $ echo foo > a
> $ git init
> Initialisierte leeres Git-Repository in /tmp/foo/.git/
> $ git add a
> $ git commit -m 'A commit'
> [master (Basis-Commit) 3d7de37] A commit
>  1 file changed, 1 insertion(+)
>  create mode 100644 a
> $ echo foo2 > a
> $ git commit -m 'A commit 2' -a
> [master e1bfac4] A commit 2
>  1 file changed, 1 insertion(+), 1 deletion(-)
> $ git notes --ref history add -C 3d7de37 e1bfac4
> $ git ls-tree notes/history
> 100644 blob 5b73d5152e6207e3a2b67e57ca3a2cb94d12061e e1bfac434ebd3135a3784f6fc802f235098eebd0
>
> I was expecting 3d7de37 to be referenced here.
>
> Is that a bug, or is storing commits as notes not supported?

I guess it depends on your POV... The current documentation says "blob
object", and what actually happens (in builtin/notes.c) is that the
given object (3d7de37 in your example) is read into a strbuf (in
parse_reuse_arg()) and stored back into a note object (in
create_note()), without preserving the object type ("blob" type is
hardcoded). This means an incoming blob object (as documented) will be
preserved (i.e. reuse the same SHA-1), but for any other object type,
the object bits will be read, and stored back into a blob object. This
is why your commit (or any other non-blob) ends up with a different
SHA-1 when stored as a note: It is the same bytes, but in a blob
object instead of a commit object.

There is currently no way the "git notes" commands will allow you to
store the 3d7de37 commit object directly as a note. There is also
(AFAICS) no easy workaround (git fast-import could've been a
workaround if it did not already require the first N/notemodify
argument to be a blob object). The best alternative, off the top of my
head, would be to write your own program using the notes.h API to
manipulate the notes tree directly (or - suboptimally - use other
low-level Git operations to do the same).

However before you go there, let's take a step back, and look at what
the result would look like (if you were allowed to store a commit
object directly as a note):

You would have a notes ref "refs/notes/history" whose tree would
contain an entry named e1bfac434ebd3135a3784f6fc802f235098eebd0
pointing to a _commit_ (3d7de37...). Obviously, it would not make
sense to use refs/notes/history while displaying the commit log ("git
log --notes=history"), as the raw commit object would be shown in the
log. However, more fundamentally: a tree referring to a _commit_ is
usually how Git stores _submodule_ links (i.e. which revision of the
named submodule is to be used by this super-repo tree), and I'm (off
the top of my head) not at all sure that such a submodule link in a
notes tree is handled "sanely" by Git - or even that it makes sense at
all. For one, I'm not sure that Git requires (or even expects) the
commit object referenced by a tree to be present in the same object
DB. So if you share your notes, I don't know whether or not the
fetch/push machinery will include the commit object in the shared
notes... These are questions that should be answered before we decide
whether using commits directly as notes makes sense.

If we do figure out that storing commits as note objects is desirable
(and does not have too nasty side-effects), then I am not opposed to
fixing builtin/notes.c to preserve type of the object passed in -C.
Certainly, the current behavior for non-blobs (i.e. copy the object
bytes, but not the object type) is probably not useful to anyone...

That said, there may be other ways to solve your immediate problem:
Instead of storing the commit object directly as a note, you could
store the commit SHA-1 into a blob, and use that as the blob object.
That would also allow you to store multiple commits in the note for
e1bfac4 (in case you had several cleanup rebases leading to the final
commit), or you could store other kinds of metadata in the same note.
Or do you have a requirement that the reflog history (presumably
reachable from 3d7de37) need to be shared (or otherwise kept
reachable)? In that case, you might be better off using an explicit
ref to keep that history alive; e.g. you could create
refs/history/e1bfac4 to point to 3d7de37 ("git update-ref
refs/history/e1bfac4 3d7de37"), and keep everything
alive/reachable/shareable that way...


Hope this helps,

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
