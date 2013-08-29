From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Officially start moving to the term 'staging area'
Date: Thu, 29 Aug 2013 13:01:29 -0500
Message-ID: <20130829180129.GA4880@nysa>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	Miles Bader <miles@gnu.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Philip Oakley <philipoakley@iee.org>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Scott Chacon <schacon@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 29 20:06:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VF6bt-0003aJ-Lo
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 20:06:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755974Ab3H2SGT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 14:06:19 -0400
Received: from mail-oa0-f47.google.com ([209.85.219.47]:50448 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752769Ab3H2SGS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Aug 2013 14:06:18 -0400
Received: by mail-oa0-f47.google.com with SMTP id g12so1046788oah.6
        for <git@vger.kernel.org>; Thu, 29 Aug 2013 11:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=nMLa5+59fKEzwuRGdbQwckrN6JUjAILn7wRaH2NxUwU=;
        b=zwsJDU/oBtj/JD5KoyJ/DPNhgPEXvVFv6RpLr/ibjkBsInFvp+BpQPB2gnfU3RSNgq
         pf0tdSrfgO0bySLJzLLfJ3b3Du2Mi5rDHvPt+otZq5HgzEPLjEXC+0ZL0G/R/kDdztFH
         7Dv3hZRYXa98xuJnop0QkaborawPX7QOmPkyM7w0OjgYwNJ/HKHfCHGoaM+LpAVWGFU3
         UaxP1xcB21kRYqnJP3RosImJsfCfXCWsDZljkOfSQg2EJqEh0OrLQ9JwCIK223dyKSJg
         PSd/h5o187hfPvpPd0TyP3FI4JcJjWw7vzTx6xWhiwZSu8gyMNGf0o9k6AsBJysOq4l2
         1OWw==
X-Received: by 10.60.51.7 with SMTP id g7mr3620443oeo.6.1377799577620;
        Thu, 29 Aug 2013 11:06:17 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id s9sm29332358obu.4.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 29 Aug 2013 11:06:16 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233295>

Hi,

It has been discussed many times in the past that 'index' is not an
appropriate description for what the high-level user does with it, and
it has been agreed that 'staging area' is the best term.

The term 'staging area' is more intuitive for newcomers which are more
familiar with English than with Git, and it seems to be a
straightforward mental notion for people with different mother tongues.

In fact it is so intuitive that it's used already in a lot online
documentation, and the people that do teach Git professionally use this
term, because it's easier for many kinds of audiences to grasp.

The meaning of the words 'cache' and 'index' doesn't represent correctly
the mental model of the high-level user:

cache: a 'cache' is a place for easier access; a squirrel caches nuts
so it doesn't have to go looking for them in the future when it might
be much more difficult. Git porcelain is not using the staging area
for easier future access; it's not a cache.

index: an 'index' is a guide of pointers to something else; a book
index has a list of entries so the reader can locate information
easily without having to go through the whole book. Git porcelain is
not using the staging area to find out entries quicker; it's not an
index.

stage: a 'stage' is a special area designated for convenience in order
for some activity to take place; an orator would prepare a stage in
order for her speak to be successful, otherwise many people might not
be able to hear, or see her. Git porcelain is using the staging area
precisely as a special area to be separated from the working directory
for convenience.

The term 'stage' is a good noun itself, but also 'staging area', it
has a good verb; 'to stage', and a nice past-participle; 'staged'.

The first step in moving Git towards this term, is first to add --stage
options for every command that uses --index or --cache. However, there's
a problem with the 'git apply' command, because it treats --index and
--cache differently. Different solutions were proposed, including a
special --stage-only option, however, I think the best solution is a
--[no-]work option to specify if the working directory should be touched
or not, so --index becomes --staged, and --cached becomes --staged
--no-work.

In addition, the 'git stage' command can be extended so the staging area
can be brought closer to the user, like other important Git concepts,
like 'git branch, 'git tag', and 'git remote'. For example, the command
'git stage edit' (which allows the user to edit directly the diff from
HEAD to the staging area) can have a home, where previously there was no
place. It would become natural then to do 'git stage diff', and then
'git stage edit' (to edit the previous diff).

After adding the new --stage options and making sure no functionality is
lost, they can become the recommended ones in the documentation,
eventually, the old ones get deprecated, and eventually obsoleted.

Also, the documentation would need to be updated to replace many
instances of 'the index', with 'the staging area' in porcelain commands.

Moreover, the --stage and --work options also make sense for 'git
reset', and after these options are added, the complicated table to
explain the different behaviors between --soft, --mixed, and --hard
becomes so simple it's not needed any more:

      working stage HEAD target             working stage HEAD
      ----------------------------------------------------
       A       B     C    D     --no-stage  A       B     D
				--stage     A       D     D
				--work      D       D     D

      working stage HEAD target             working stage HEAD
      ----------------------------------------------------
       A       B     C    C     --no-stage  A       B     C
				--stage     A       C     C
				--work      C       C     C

      working stage HEAD target             working stage HEAD
      ----------------------------------------------------
       B       B     C    D     --no-stage  B       B     D
				--stage     B       D     D
				--work      D       D     D

      working stage HEAD target             working stage HEAD
      ----------------------------------------------------
       B       B     C    C     --no-stage  B       B     C
				--stage     B       C     C
				--work      C       C     C

      working stage HEAD target             working stage HEAD
      ----------------------------------------------------
       B       C     C    D     --no-stage  B       C     D
				--stage     B       D     D
				--work      D       D     D

      working stage HEAD target             working stage HEAD
      ----------------------------------------------------
       B       C     C    C     --no-stage  B       C     C
				--stage     B       C     C
				--work      C       C     C

It might be possible to do 'git reset --no-stage --work', to reset the
working directory, but leave the staging area alone.

For more reference about the previous discussions:

http://thread.gmane.org/gmane.comp.version-control.git/197111
http://thread.gmane.org/gmane.comp.version-control.git/166675
http://thread.gmane.org/gmane.comp.version-control.git/115666

-- 
Felipe Contreras
