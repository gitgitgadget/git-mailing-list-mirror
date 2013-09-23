From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 0/7] Support for Ruby
Date: Sun, 22 Sep 2013 17:00:44 -0700
Message-ID: <CAPc5daWa0BPXdrYqek=WzixVVfh0DvHhxjtOh2LW6bgR0MAOPw@mail.gmail.com>
References: <1379789295-18519-1-git-send-email-felipe.contreras@gmail.com>
 <20130921212904.GA235845@vauxhall.crustytoothpaste.net> <CAMP44s3Shdg40go-WyGV8QKwEGoXg8hvEe8tetMyxvx5Sb7evw@mail.gmail.com>
 <20130921235647.GC235845@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Mon Sep 23 02:01:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VNtaS-0005yc-By
	for gcvg-git-2@plane.gmane.org; Mon, 23 Sep 2013 02:01:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752399Ab3IWABI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Sep 2013 20:01:08 -0400
Received: from mail-la0-f45.google.com ([209.85.215.45]:41259 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752562Ab3IWABG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Sep 2013 20:01:06 -0400
Received: by mail-la0-f45.google.com with SMTP id eh20so1927381lab.4
        for <git@vger.kernel.org>; Sun, 22 Sep 2013 17:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=r/t8dFdjUqYXhp/Agpsr+RQrJWSvhc1IxayV8pMk0ko=;
        b=E2f0+7a/DItGVqIfK4YHd6koXPEq5Ceyn/QOfoQKB9YGx7pWsc4ugG1k4wx9JIJksz
         TYFttFbS2miinXed+orPzW7e3afP7UZZ9sr+SojM7g6UOLyCAD5toLIoM5C1R/TkRTAX
         pvXx+dQeIsoTZ8dUcii6gWxdpvGLzBs1EVclQM+BTzwBN0kG+G4jVQ3np7vTHwthN88r
         njV1KitqpMN0TTfEGvc+Exr0FEz9xFei0iLW6CdBxN/J5kgJvudHvoOoCm3UUiK0I5x5
         J+PJ++rkPFylvsNwXe1+c+/yBTECBzgfqslxqKQheVnZOgHzUBA3J2GyGTXwe1yYZzUk
         rjDA==
X-Received: by 10.112.53.130 with SMTP id b2mr17374851lbp.6.1379894464271;
 Sun, 22 Sep 2013 17:01:04 -0700 (PDT)
Received: by 10.112.142.4 with HTTP; Sun, 22 Sep 2013 17:00:44 -0700 (PDT)
In-Reply-To: <20130921235647.GC235845@vauxhall.crustytoothpaste.net>
X-Google-Sender-Auth: zG-T5eOvbZ7O_zG6BeqaY0yhmII
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235174>

[on vacaion, with only gmail webmail UI; please excuse me if this message comes
out badly formatted or gets dropped by vger.kernel.org]

On Sat, Sep 21, 2013 at 4:56 PM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> On Sat, Sep 21, 2013 at 05:52:05PM -0500, Felipe Contreras wrote:
>> On Sat, Sep 21, 2013 at 4:29 PM, brian m. carlson
>> <sandals@crustytoothpaste.net> wrote:
>> > As Junio has also pointed out in the past, there are people who aren't
>> > able to use Ruby in the same way that they are Perl and Python.  If it's
>> > announced now, Git 2.0 might be a good time to start accepting Ruby
>> > scripts, as that will give people time to plan for its inclusion.

In the very beginning, the codebase and development community of Git was
very small. In order to give usability and also easy availability of minimally
sufficient features, we used shell and Perl for quicker turn-around and
implementation and included these Porcelain scripts written in higher level
languages in the same package as the core Git.

We should look at use of shell and Perl as necessary evil in that context,
not as an enabler for people who do not want to write in C. It is no longer
2005 and the "enabler" side has a much more suited project for it these days.

Namely, it is better served by various language-binding efforts around libgit2.
Binding that takes advantage of each specific language is better done over
there, I think. Cf. http://www.youtube.com/watch?v=4ZWqr6iih3s

If anything, I think the core side should be focused on three things
(in addition
to bug-fixes, of course) in the longer term:

 - Defining and implementing necessary improvements to the core on-file and
   on-the-wire data structures and the protocols to serve as the canonical
   implementation.

 - Moving away from higher-level scripting languages such as shell and Perl.
   Recent "clean --interactive" may have added some code that could be
   reused for a rewrite of "add -i" (which I think is in Perl), for example.
   The minimum "You need to have these to use Git" should be made more
   portable by doing *less* in shell or Perl, not by adding more in the higher-
   level languages, and certainly not by adding other languages, be it Ruby or
   Lua.

 - Giving solid interface to the outside world, e.g. remote-helpers, credential-
   helpers API, and let the users and developers that want to use them do their
   own projects, without adding things to contrib/.

In other words, now the Git user and developer community are strong
and thriving,
we should strive to make the core smaller, not larger, and encourage people to
form more third party communities that specialise in the areas the
participant of
these communities are stronger than those who are involved in the core
(e.g. like
myself, Peff, Nico, Jonathan, etc.). For programs that talk remote-helper or
credential-helper protocols, for example, it is wasteful to have them
in our contrib/
and have the changes to them go through my tree, with the same coding style
standard applied to the core, which would in the longer term only add
unnecessary overhead to what they want to do and what their effort supply the
users with.

For that, defining a good inter-system interface boundary is essential
on the core
side, but we do not need to (and I do not want to see us on the core side doing)
design and implement the other side that talks to us, which people may write in
their favorite higher-level languages.

We define a reasonably robust object & history transfer mechanism over SSH
connection with set of necessary hooks to customize what happens when a push
and a fetch is requested, and Sitaram built Gitolite totally outside
the core. I think
that is the kind of thing we want to see *more* in this community. Was it better
if we defined in the core how "hosting" service is to be done and implemented
one ourselves? I do not think so. Similarly for Michael Haggerty's iMerge, which
was done outside the core.
