From: Brian Bourn <ba.bourn@gmail.com>
Subject: [RFC] [GSoC] Draft of Proposal for GSoC
Date: Thu, 20 Mar 2014 14:15:29 -0400
Message-ID: <CAM+=D-BWCt9kNSUUQ19ZcPykb6j-tuEr=igBz0ukEk2TA3vWkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: peff@peff.net
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 20 19:22:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQhc2-00065u-7R
	for gcvg-git-2@plane.gmane.org; Thu, 20 Mar 2014 19:22:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933787AbaCTSWg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2014 14:22:36 -0400
Received: from mail-qa0-f44.google.com ([209.85.216.44]:58979 "EHLO
	mail-qa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933560AbaCTSWf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2014 14:22:35 -0400
Received: by mail-qa0-f44.google.com with SMTP id f11so1317473qae.31
        for <git@vger.kernel.org>; Thu, 20 Mar 2014 11:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=uQzuU9jAeEqUPnTs0+WYbq9yzzD8LZLLFzRfo4TuJVM=;
        b=puRDF8HPF7XkxbOrBAuPAgATj41hwZcWajch/aKUqoHT66CARcVuNcezedwtLbktkJ
         isNSyLlENAnYviFxOzi5bDNEC3JAA9z3Wuqz449zoCGtiidH0dX1wA85/FDxYdPKcjxp
         WDeRdbTIiFX0GTIT7rhXT/VrD3E7Mt/Lj/4v775FTN2bJxZbyKKNGDIxBAd30Yvw8sPN
         aTugEXuuOTi25OVPZrbuyw/Dka+cPg9WB76PhHfyfpJAkeNoi3koOJwv+1eBkY3ACuIM
         KNzufktrMQ9Y9vJpzCv3AY+GMRGQadIpHasVqXD+souD7BeoGZM2yOSpICAOYIa9aUYa
         Qkxg==
X-Received: by 10.140.97.137 with SMTP id m9mr11224065qge.95.1395339329947;
 Thu, 20 Mar 2014 11:15:29 -0700 (PDT)
Received: by 10.96.86.38 with HTTP; Thu, 20 Mar 2014 11:15:29 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244568>

Hi all,

This is a first draft of my Proposal for GSoC, I'd love feedback about
what I might be missing and any other files I should read regarding
this, so far I have read most of tag.c, branch.c,
builtin/for-each-ref.c, parse-options.c. once again I hope I can get
the same amount of helpful feedback as when I submitted my
Microproject.

My name is Brian Bourn, I'm currently a computer engineering student
at Columbia university in the city of New York.  I've used git since
my freshman year however this past week has been my first time
attempting to contribute to the project, and I loved it. I'd
particularly like to tackle Unifying git branch -l, git tag -l, and
git for-each-ref.  This functionality seems like an important update
to me as it will simplify usage of git throughout three different
commands, a noble pursuit which is not contained in any other project.

Going through the annals of the listserve thus far I've found a few
discussions which provide some insight towards this process as well as
some experimental patches that never seem to have made it
through[1][2][3][4]

I would start by beginning a deprecation plan for git branch -l very
similar to the one Junio presents in [5], moving -create-reflog to -g,

Following this I would begin the real work of the project which would
involve moving the following flag operations into a standard library
say 'list-options.h'

--contains [6]
--merged [7]
--no-merged[8]
--format
This Library would build these options for later interpretation by parse_options

Next I would implement these flags in the three files so that they are
uniform and the same formatting and list capabilities can be used on
all three. The formatting option will be especially useful for branch
and tag as it will allow users to better understand what is in each
ref that they grab.

For the most part I haven't finalized my weekly schedule but a basic
breakdown would be

Start-Midterm
Begin deprecation of -l
Spend some time reading *.c files even deeper
Build Library(dedicate Minimum one week per function moved)

Midterm-finish
Implement the list flags
Implement the format flags
(if time is left over, add some formatting)

Additionally I am thinking about adding some more formatting tools
such as numbering outputs. What do you all think of this?


[1]http://git.661346.n2.nabble.com/More-formatting-with-git-tag-l-tt6739049.html

[2]http://git.661346.n2.nabble.com/RFC-branch-list-branches-by-single-remote-tt6645679.html#a6725483

[3]http://git.661346.n2.nabble.com/RFC-PATCH-tag-make-list-exclude-lt-pattern-gt-tt7270451.html#a7338712

 [4]http://git.661346.n2.nabble.com/RFC-branch-list-branches-by-single-remote-tt6645679.html#a6728878

[5]http://git.661346.n2.nabble.com/RFC-PATCH-0-2-RFC-POC-patterns-for-branch-list-tt6309233.html

[6]https://github.com/git/git/blob/master/builtin/branch.c#L817

[7] https://github.com/git/git/blob/master/builtin/branch.c#L849

[8] https://github.com/git/git/blob/master/builtin/branch.c#L843

Regards,
Brian Bourn
