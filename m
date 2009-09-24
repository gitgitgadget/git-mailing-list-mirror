From: Deon George <deon.george@gmail.com>
Subject: Re: Feature Enhancement Idea.
Date: Thu, 24 Sep 2009 15:52:05 +1000
Message-ID: <5b5e291e0909232252q3231afe4t95d01339ee531964@mail.gmail.com>
References: <5b5e291e0909222317q47ae36d4la470f17ec3902124@mail.gmail.com>
	 <7vab0lh1an.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 24 07:55:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MqhIX-0005rT-Ou
	for gcvg-git-2@lo.gmane.org; Thu, 24 Sep 2009 07:55:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752638AbZIXFwG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Sep 2009 01:52:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752518AbZIXFwE
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Sep 2009 01:52:04 -0400
Received: from mail-px0-f194.google.com ([209.85.216.194]:60048 "EHLO
	mail-px0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751865AbZIXFwC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Sep 2009 01:52:02 -0400
Received: by pxi32 with SMTP id 32so1293157pxi.4
        for <git@vger.kernel.org>; Wed, 23 Sep 2009 22:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=BcjZxDfjYOWY4gVGKoHArP6FVYVtHK/VMwf6HG38qIE=;
        b=jWArTE+Xb2/C5FUOe4f5TKqXNXdt+xO8PhwI1skFUl4BPbInQyTrHguSq5BiN3Xzc8
         urkP9v5rMAJDnhLwdeAcxb3ZLnwoLFmiva8qfqMR5SX3y9ecfbzg/mINOTd0GR4NU3hz
         U9EvYqRNhctSNbuXR3E6fD9X6srxKfk4yofMA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=DJRRbwBA7CKmjev6Lgrz58BDNVhTEyy2vu0QmWmaftw7WF0aLO3EPMYaMHc/E3ff2A
         n3it6UiVlBY3Kwxoxps+ILMjKeXMBpRSHyXmFn2Ed/MQpss26Wd28877FXEnD3oh1WOA
         EtVnmwCyTBMzIJljLK0eF+FWHdTk1GwtEL2PE=
Received: by 10.140.148.14 with SMTP id v14mr186199rvd.26.1253771526198; Wed, 
	23 Sep 2009 22:52:06 -0700 (PDT)
In-Reply-To: <7vab0lh1an.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129017>

Junio C Hamano wrote:

> I think the primary scenario your itch comes from is (I am writing this
> down to make sure I understand where you are trying to go):
>
>  - you would want to build your changes on top of somebody else's code;

Yes - more correctly, I want to enhance an application, where I am (or
different person - it doesnt matter) is responsible for that code.
Thus I want to source code manage my enhancement, and (for whatever
reason), the other components of the application dont want my part in
their "base".

>  - while doing so it is often more convenient if you do not have to think
>    about which pieces of changes should go to upstream, and which other
>    pieces of changes should stay local;

Not strictly true, but yes - I am aware that my modules might be
completely autonomous to the base code (thus I source control manage
everything that my module requires), or I discover bugs in the base
code, that I believe upstream should have. There may also be a case,
where I want to modify some code in the base, but I know that it
shouldnt never be included in the base code (and thus I would need my
commit to be stored in my SCM, not the base's SCM) - eg: Modifying a
Makefile...

So while I would commit to a layer, I should make a conscious decision
of where the commit should go (I own the commit work, or I want to
send the commit upstream as a contribution enhancement/fix) - because
the default assumption may be wrong.

>
>  - git allows you to do this with topic branch workflow, with selective
>    adding with "add -p", stashing and branch switching.

I dont know about topic branches "git add -p"? (I havent got that
advanced yet, looks like I need to do some more research on the
features of GIT :)

> Am I following you Ok so far?

Yes, but one more important criteria - my working tree is made up of
files (or content) managed in more than once source control management
repository - I use an SCM to manage and track changes, and I use
multiple repository because any one owner of one repository may not
want the code from another as part of their "base". IE: It could be I
write a custom driver for a widget device, that Linus doesnt want that
code in the base kernel (for whatever reason) and I maintain that part
of the code, or (in my case), I want to maintain (and encourage others
to contribute) to a module (or set of modules) for an existing web
application framework.

Additionally, each layer should be able to switch between its own
branches (ie: My driver 1.0 works well with kernel "N", now Linus
publishes "N+1", I want to switch that (base) layer to "N+1" and
test/fix my module to work with that release - and then commit/tag it
as such - ie: my driver (now 1.1) works with "N+1"). Further a bug is
now found in my 1.0 driver, so I want to switch back the kernel layer
to "N", and my driver layer to 1.0, make the fix, and release
1.0.1)... Kinda get the idea Im working towards...?

Additionally, it should not necessarily be "one base" and "my layer",
it may be multiple layers (and hence multiple repositories), but all
layers make up an application with multiple features, each
individually source control managed. Each layer would have a
dependency to another (otherwise they could be developed in their own
repository entirely - and the dependency may be needed to be know for
merge conflict resolution (where do the conflicts need to be
commited), when pulling from the upstream owners of that layer)

Thus, when I package up my module - it shouldnt include the base
(since the base may already be installed), and the base developers
want to keep their application more like a framework - so they are
responsible for the core workings of the code, and the module
developers are responsible for their components.

To achieve what I want today, I think I would need to have:

master
master-mycontribs (branched from master, and merged from master)
mymodule (branched from master-mycontribs and merge from there - this
is pushed to my SCM repository)
mymodule-working (where I test and commit - and merge back to my module)

(this comes stuck, when I want to switch master to a previous version...)

And thus, the diff between "master" and "master-mycontribs", are my
contributions to go upstream. The diff between "master" and "mymodule"
is what I would package to make my module as an enhancement to anyone
already using "master" (at release "N").

If upstream accepts my enhancements, then "master" =
"master-mycontribs" (and master is now release "N+1"), and the next
release of my module (1.2) would still be the diff between
"master-mycontribs" and "mymodule" (but would be excluding my code
that I added to master-mycontribs (since master now equals that),
because the end user who is already running N+1 has those
enhancements.

I'll research git "topics" and see if that does what I am dreaming of :)

...deon
