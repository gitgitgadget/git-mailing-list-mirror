From: Jonas Fonseca <jonas.fonseca@gmail.com>
Subject: Re: [JGIT] Request for help
Date: Fri, 4 Sep 2009 14:50:58 -0400
Message-ID: <2c6b72b30909041150g6374be2ci4d36bd8ab0824a8d@mail.gmail.com>
References: <585278.66341.qm@web27802.mail.ukl.yahoo.com> <658028.86274.qm@web27804.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Douglas Campos <douglas@theros.info>, git@vger.kernel.org,
	Gabe McArthur <gabriel.mcarthur@gmail.com>
To: Mark Struberg <struberg@yahoo.de>
X-From: git-owner@vger.kernel.org Fri Sep 04 20:51:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mjdsl-0002Mp-Fc
	for gcvg-git-2@lo.gmane.org; Fri, 04 Sep 2009 20:51:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757216AbZIDSvT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2009 14:51:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757187AbZIDSvS
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Sep 2009 14:51:18 -0400
Received: from mail-iw0-f175.google.com ([209.85.223.175]:36073 "EHLO
	mail-iw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754109AbZIDSvS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Sep 2009 14:51:18 -0400
Received: by iwn5 with SMTP id 5so321048iwn.4
        for <git@vger.kernel.org>; Fri, 04 Sep 2009 11:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=i1KyTI8T6Mx3dsFMuRlYTKcSzowE1sw6oASV8+DnboU=;
        b=KibLcSGwnBtSoBSyReD6c619fstGSymaNyYUYfJ2P3HOsbpYIm0eYfAABcKJSNNksl
         Ts1qDdPRQttFfBQqqNu+HjqBQQF182J/DYrXus4cjvGz6w7arXO3Y9HIXnikQkbN1oe1
         hJs4JyhXpKX22EN70hjD9HWT+bOdLHs5BTPrU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=D0aoCmJZRTxX9126rrZSXxq6mndczViIjr547/cN5K6STODwvlEEJjdYcLv4zD4er0
         FSeKspCWmqXr+aWQoIEJROquKD1+aURPTHfUMB1am9j5jR2E53u54RZ65BT/pRYMZuyV
         ifm/y+DNbHigw05FyrJjhhd954z1WvlSx52jg=
Received: by 10.231.4.75 with SMTP id 11mr10160411ibq.25.1252090280452; Fri, 
	04 Sep 2009 11:51:20 -0700 (PDT)
In-Reply-To: <658028.86274.qm@web27804.mail.ukl.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127757>

On Fri, Sep 4, 2009 at 13:28, Mark Struberg<struberg@yahoo.de> wrote:
> Hi!
>
> Work has been done at
>
> http://github.com/sonatype/JGit/tree/mavenize
>
> Please feel free to pull/fork and share your changes! I'd be happy to pull it in.

IMO, there are a lot of things that can be squashed together and
cleaned up. I know that you advocated for incremental introduction,
but it seems wrong to for example add a file and then completely
reformat it a few commits later. The same thing with the .gitignore
fixes in step 5.

Some comments ... Some of them I initially entered in github's
codereview, but I ended up writing it all here.

Commit: "mavenizing step 1: moved over the initial poms from Jasons branch"

 * Please always add an empty line between the subject and the body
   of the commit message. Like this:

  mavenizing step 1: moved over the initial poms from Jasons branch

  Signed-off-by: Mark Struberg >struberg@yahoo.de>

 * The .gitignore pattern could be further limited to "target/" ...
but you seem to change this to /target later.

In org.spearce.jgit/pom.xml:

    * The use of maven-surefire-plugin should be removed. This module
does not have any tests.

    * Shouldn't we retain the original ${groupId}:${artifactId} naming
convention, being org.spearce:jgit?

In org.spearce.jgit.test/pom.xml:

    * Dependency on jsch is unecessary since it is derived from
org.spearce.jgit.

    * Maybe name as org.spearce:jgit-test?

In org.spearce.jgit.pgm/pom.xml:

    * Maybe name as org.spearce:jgit-pgm?

Commit: "mavenizing step 2: move the core libs from src to src/main/java"

 * Please also add an empty line to this commit message.

 * You might as well squash the whitespace fixes into the first commit.

Commit: "mavenizing step 3: moving all core tests into the core module"

 * The commit message wrongly states:
    org.spearce.jgit.test/tst/ -> org.spearce.jgit/src/test/java/tst/
   Should be:
    org.spearce.jgit.test/tst/ -> org.spearce.jgit/src/test/java/

Commit: "mavenizing step 4: moving some license files and META-INF"

 * Shouldn't the commit message rather say "remove JSch"?
   Then the moving of META-INF can be put in its own commit.

 * The new NOTICE file has a few typos and the info could fit into the README

Then I got a bit lost in a huge reformatting.

-- 
Jonas Fonseca
