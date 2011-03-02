From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: Re: [RFC] git blame-tree
Date: Wed, 2 Mar 2011 19:39:20 +0100
Message-ID: <AANLkTi=m_WTohMfJZxTqObRT3rhhtxo=QfnDJCHO=U0K@mail.gmail.com>
References: <20110302164031.GA18233@sigill.intra.peff.net>
	<20110302171653.GA18957@sigill.intra.peff.net>
	<AANLkTim4fKO=Lb0dY0DzRu1QqC8NHPoF8iveYQ2E6OBH@mail.gmail.com>
	<20110302180722.GA20287@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 02 19:39:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuqxN-00046X-DN
	for gcvg-git-2@lo.gmane.org; Wed, 02 Mar 2011 19:39:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756198Ab1CBSjW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Mar 2011 13:39:22 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:54672 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753984Ab1CBSjV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Mar 2011 13:39:21 -0500
Received: by vxi39 with SMTP id 39so240204vxi.19
        for <git@vger.kernel.org>; Wed, 02 Mar 2011 10:39:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=3TpZYQ1hnuffrN5HWa1hYR8ZBiYbQ2RxZV1JH/jkVGw=;
        b=vZFxg3s4ij88D5vJyM4iCl/dT2QydJLZ8VouIkK/UmHwgIMjB+62viHn1WOe3uRF2v
         J9OIIynvAMiWr/Rnx8sCv8Qg/XGCNe4PBGc0woW54SiLnSrcMSl9I/UojBYpgcTuubUQ
         m40IaTTuf/KzfiOIvXlrQCEmTJZlm1BYqtZpw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=hFKVlPs90g/IHRG1qH4/kSZXYt2x0UeMIIEkNbD6UF8u43u4ZStEAGDF1bxVicFNO1
         EAIrV2GiELjDgWbOVU6v7hhfrSYLWXbiU1QXfKMxsbgYbxto7q8a0YYP3Wo419XKScy2
         ASEsfEJsC8REsiYK1hoHcNdEqCttWwCT9tkdM=
Received: by 10.220.168.13 with SMTP id s13mr49973vcy.0.1299091160464; Wed, 02
 Mar 2011 10:39:20 -0800 (PST)
Received: by 10.220.61.140 with HTTP; Wed, 2 Mar 2011 10:39:20 -0800 (PST)
In-Reply-To: <20110302180722.GA20287@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168334>

On Wed, Mar 2, 2011 at 7:07 PM, Jeff King <peff@peff.net> wrote:
> On Wed, Mar 02, 2011 at 06:51:57PM +0100, Piotr Krukowiecki wrote:
>
>> On Wed, Mar 2, 2011 at 6:16 PM, Jeff King <peff@peff.net> wrote:
>> > I considered making it a special mode of "git blame" when blame is=
 fed a
>> > directory instead of a file. But the implementations aren't shared=
 at
>> > all (nor do I think they need to be; blame-tree is _way_ simpler).=
 And I
>>
>> git blame dir/file.c
>> =A0 "Show what revision and author last modified each line of a file=
"
>>
>> git blame dir/
>> =A0 "Show what revision and author last modified each file"
>
> Right, I think we are agreeing.
>
>> This makes sense to me (the user). =A0I don't understand the
>> implementation thing. I don't see a difference between those two
>> commands. Even more, if I'm educated =A0Unix user I might know
>> directories are also files.
>
> I mean the implementations are very different, so there was not much
> point in putting the code into builtin/blame.c.

Ah, ok.


>> > didn't want to steal that concept in case somebody can think of a =
more
>> > content-level way of blaming a whole tree that makes sense (obviou=
sly
>> > just showing the concatenation of the blames of each file is one w=
ay,
>> > but I don't know how useful that would be). If we want to go that =
way,
>> > we can always catch the special case in blame and just exec blame-=
tree.
>>
>> Still can be in git-blame command, no?
>
> Right. What I meant was that we don't have to make the decision now. =
If
> people like blame-tree, we can later magically turn:
>
> =A0git blame dir
>
> into "git blame-tree dir". So I think we are just agreeing.

I hope nobody likes "blame-dir" :)


>> > The initial set of interesting files we come up with is gotten by
>> > looking at the tree of the first pending object after parsing the =
rev
>> > options (defaulting to HEAD). Which sounds a little flaky to me, b=
ut
>> > does what you want in practice. I'd be curious if somebody can com=
e up
>> > with a counterexample where the ability to manually specify the so=
urce
>> > tree would be more useful.
>>
>> Same argument as for normal blame: I want to know who modified files=
 at
>> the state of commit X (if I understand the question correctly).
>
> Yeah, that's what it does now. Specifically I was wondering about mor=
e
> elaborate examples, like:
>
> =A0git blame-tree dir branch1 branch2
>
> It will traverse using both branch1 and branch2, but get the initial
> list of files from branch1. I guess we could also union those trees o=
r
> something.

I'd expect this to be something like union. Currently I can only think =
about
following case:

Some files were changed in branch1, some in branch2, some in both.
Show me how the files are changed. For example:
  file1 changed in branch1 in commit1
  file2 changed in branch2 in commit2
  file3 changed in branch1 in commit3 and in branch2 in commit4

If file was not changed since branch creation then don't show it (optio=
nally).

But maybe this is more like a diff or log than a blame. Maybe there's a=
lready
such mode - I could not find it.


$ git init
Initialized empty Git repository in /tmp/a/.git/
$ echo a > a
$ echo b > b
$ echo c > c
$ git add .
$ git commit -a -m new
[master (root-commit) af5d319] new
 3 files changed, 3 insertions(+), 0 deletions(-)
 create mode 100644 a
 create mode 100644 b
 create mode 100644 c
$ git branch branch1
$ echo trunk1 > a
$ git commit -a -m trunk1
[master 2dc7f47] trunk1
 1 files changed, 1 insertions(+), 1 deletions(-)
$ echo trunk2 > b
$ git commit -a -m trunk1
[master 736fcd2] trunk1
 1 files changed, 1 insertions(+), 1 deletions(-)
$ git checkout branch1
Switched to branch 'branch1'
$ echo branch1 > c
$ git commit -a -m branch1
[branch1 52e371d] branch1
 1 files changed, 1 insertions(+), 1 deletions(-)
$ echo branch2 > b
$ git commit -a -m branch2
[branch1 9fed07c] branch2
 1 files changed, 1 insertions(+), 1 deletions(-)
$ git diff --stat branch1 master
 a |    2 +-
 b |    2 +-
 c |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)


I would like to see output like this:
 a   2dc7f47  (master)
 b   736fcd2  (master)
 b   9fed07c  (branch1)
 c   52e371d  (branch1)


Not sure how useful it would be. Just an idea.


> But I expect most calls to be:
>
> =A0git blame-tree dir commit
>
> and that's it.

Me too.


--=20
Piotrek
