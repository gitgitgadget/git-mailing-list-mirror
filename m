From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [1.8.0] use 'stage' term consistently
Date: Sun, 6 May 2012 12:21:28 +0200
Message-ID: <201205061221.29592.jnareb@gmail.com>
References: <CAMP44s1qqpTxRvjEH32MNqzUeNhgZ1gB+fu=cgvxnSbMB6oBGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Scott Chacon <schacon@gmail.com>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Matthieu Moy <matthieu.moy@imag.fr>,
	Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 06 12:21:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQyay-0002oZ-Rj
	for gcvg-git-2@plane.gmane.org; Sun, 06 May 2012 12:21:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753182Ab2EFKVf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 May 2012 06:21:35 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:42642 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752973Ab2EFKVe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2012 06:21:34 -0400
Received: by werb10 with SMTP id b10so720084wer.19
        for <git@vger.kernel.org>; Sun, 06 May 2012 03:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=A5FmOYGPQlvcfDGHAlzVyCDIKXyV+hq2hKR/v6uoXIQ=;
        b=HzDVj3WvikrVEnr6UnSpqXj/hAf62g2+65Me+4DbvmmwfYaavw7wMsYktHmVPHJ0Fq
         Dfj1UVEgh/rlzkGKOV7SuKGpY3uhb9vwz0JqIlH5yCCtf+XoTxQIIWO4hSryCzKEc0XK
         PStbujtkYkPDp7cj+cKHQYVigfvjDxNerKhZ6Fp5C8z0dSCbLUsDmU0R9A9PiimLlHPy
         BrqR8MLTEgNtHCnetLDEm8zqq1wxzlxbyYBKVV8xNuYSY4ghI1HlsrTJLrtSr0x7EIfk
         /9AmIB19gwMn+okj+o80TS9IRdVXmbKHxV85xLJIRxEq+w7RXXhRIqhq0K4Fl8qi5B2+
         MZIQ==
Received: by 10.216.27.200 with SMTP id e50mr2365785wea.23.1336299693122;
        Sun, 06 May 2012 03:21:33 -0700 (PDT)
Received: from [192.168.1.13] (evc230.neoplus.adsl.tpnet.pl. [83.20.200.230])
        by mx.google.com with ESMTPS id fn2sm20174310wib.0.2012.05.06.03.21.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 06 May 2012 03:21:32 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <CAMP44s1qqpTxRvjEH32MNqzUeNhgZ1gB+fu=cgvxnSbMB6oBGA@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197161>

On Sat, 5 May 2012, Felipe Contreras wrote:

> Proposal:
> 
> Avoid the terms 'cache' and 'index' in favor of 'stage'.
[...]
> Rationale:
> 
> First of all, this discussion _always_ keeps coming back, so its clear
> something needs to be done, and in the last big discussion the
> consensus was that 'stage' was the best option. In summary:
> 
> cache: a 'cache' is a place for easier access; a squirrel caches nuts
> so it doesn't have to go looking for them in the future when it might
> be much more difficult. Git porcelain is not using the staging area
> for easier future access; it's not a cache.

Actually Git porcelain does use 'the index' as a cache (computing),
i.e. as a place to store redundant information (stat data, sha-1
for trees with DIRC dircache extension) for faster access.

But is not all it does...
 

Nb. 'the index' started as dircache at the very begining, and this 
historical legacy shows through in a few places (including 
documentation and plumbing error messages).

> index: an 'index' is a guide of pointers to something else; a book
> index has a list of entries so the reader can locate information
> easily without having to go through the whole book. Git porcelain is
> not using the staging area to find out entries quicker; it's not an
> index.

Actually 'the index' is index in that sense; it stores _references_
from filename to file contents, using SHA-1 identifier of a file/tree 
contents in place of page number in the book index.  The SHA-1 
identifier of object which is stored in database of repository, not the 
index itself.

But it is not all it does...

> stage: a 'stage' is a special area designated for convenience in order
> for some activity to take place; an orator would prepare a stage in
> order for her speak to be successful, otherwise many people might not
> be able to hear, or see her.  Git porcelain is using the staging area
> precisly as a special area to be separated from the working directory
> for convenience.

True, 'the index' serves a staging area to build a commit, or to resolve 
a merge conflict.

But from above comments you can see that it is not all it does...

> The term 'stage' is a good noun itself, but also 'staging area', it
> has a good verb; 'to stage', and a nice past-participle; 'staged'.

Anyway another issue to resolve is '--cached' and '--index' command line 
options, as described in gitcli(7) manpage:

  Many commands that can work on files in the working tree
  and/or in the index can take `--cached` and/or `--index`
  options.  Sometimes people incorrectly think that, because
  the index was originally called cache, these two are
  synonyms.  They are *not* -- these two options mean very
  different things.

   * The `--cached` option is used to ask a command that
     usually works on files in the working tree to *only* work
     with the index.  For example, `git grep`, when used
     without a commit to specify from which commit to look for
     strings in, usually works on files in the working tree,
     but with the `--cached` option, it looks for strings in
     the index.

   * The `--index` option is used to ask a command that
     usually works on files in the working tree to *also*
     affect the index.  For example, `git stash apply` usually
     merges changes recorded in a stash to the working tree,
     but with the `--index` option, it also merges changes to
     the index as well.

You can use '--staged' in place of '--cached', but what about '--index'?
How do you replace it?


BTW. here is the list of porcelain commands that use those command
line options:

  Command         --cached        --index
  ----------------------------------------
  git-apply           X               X
  git-diff            X
  git-grep            X
  git-ls-files        X
  git-rm              X
  git-stash^*                         X
  git-submodule^#     X


  Footnotes
  .........
  [*] "git stash pop" and "git stash apply" subcommands
  [#] "git submodule status" and "git submodule summary" subcommands

-- 
Jakub Narebski
Poland
