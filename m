From: "k wayne" <pleexed@gmail.com>
Subject: Project organisation and structure
Date: Wed, 17 Sep 2008 15:49:19 +0200
Message-ID: <bcf9fe2c0809170649x3f377c7erecc9f69a4a664d52@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 17 15:50:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfxQN-0007o2-8i
	for gcvg-git-2@gmane.org; Wed, 17 Sep 2008 15:50:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751634AbYIQNtW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Sep 2008 09:49:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751507AbYIQNtW
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Sep 2008 09:49:22 -0400
Received: from qb-out-0506.google.com ([72.14.204.224]:49938 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751366AbYIQNtV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Sep 2008 09:49:21 -0400
Received: by qb-out-0506.google.com with SMTP id f11so4720441qba.17
        for <git@vger.kernel.org>; Wed, 17 Sep 2008 06:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=qMVwhhne75EzUmhtffpX+hxxds3PVt49ALC/WSF6Owk=;
        b=m+j7saM5QrlHgnaT4eBEO/QStKmfymqhuryjUWhSu85cJOViMrSv3tEtyhrYVYlT73
         yhVvM/FBfZKIyd5VQkCSsD3EyE3kA1JhxA4ERcwXITE4LvfjDR2C1YjBNHsH9l28qPRc
         tmzvea6BFZ1SwDyY8ktQ7x4kCWoJJDNYLzpxc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=Yw4Wu/662qp/M3/CPKBR1dXHU9taSObF+q8ZVVSxrukGEc8Goe720VfRXr9uNcn2f4
         7TvpS9+CLYBrlqaKfY41kNmnvySOooeUVM3RZT7guiIVAJIbntJXQzrligV1LpL5mODf
         Vv8Uh+793G5dWzR+6g5u7bkBnZ2jcv431orWU=
Received: by 10.141.123.4 with SMTP id a4mr6512204rvn.172.1221659360323;
        Wed, 17 Sep 2008 06:49:20 -0700 (PDT)
Received: by 10.141.116.12 with HTTP; Wed, 17 Sep 2008 06:49:19 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96113>

Hello,
I'm new to git, and I hope this is the right mailinglist for what I'm
going to ask; it was the only one I found on http://git.or.cz. Sorry
if it's not or my question is remarkably stupid. I've read the git
documentation, of course, but it wasn't always easy to wrap my head
around all the concepts, so I might have missed an obvious solution to
my problem.

Currently, I've got a tree of self-written C++ source code for which I
don't use any SCM, and I'd like to start using git on it. However,
I've run into issues with my directory layout I cannot resolve on my
own.
I have a collection of libraries and programs, which aren't coupled
too much, but aren't really independent either; for example, library X
depends on Y, program Z on lib A and so forth. Since all of these libs
and programs are logically connected to each other in some way, I
would like to have them all in one central repository.
So I heard that I could create kind of a "meta-repository" for the
whole project, and have submodules for each library or program, which
sounds exactly like what I want. However, I've been told that my
current directory layout will not work this way with git.

This is how my project root directory (say it's ~) looks like:
~/build - Build files which apply for the whole project, like doxygen
build files.
~/include/$submodule - Each library/program has an own directory here,
in which all header files go.
~/projects/$submodule - Files related to an individual project, like
makefiles etc.
~/src/$submodule - Like the above two, but for source files.
~/test/$submodule - Again, a directory for each library/program,
containing files for (unit)tests.
~/doc - Documentation files for the project as a whole.
~/doc/$submodule - Documentation files for individual libraries/programs.

These are the directories I would like git to track for me. There are
some other dirs not listed here (e.g. for object files,) but I can
easily add them to .gitignore.

So, the git structure as I imagine it would look like this: ~/.git
contains the "meta-repository," in which all the submodules reside.
Each submodule would have its .git directory in ~/projects/$submodule.
Alternatively, ~/.git for the meta-repo and ~/.git-$subproject or
something like this would be okay too.

However, I have been told I cannot go to ~/projects/$submodule and do
a "git add ../../{include,src,test,doc}/$submodule" there. I could add
symlinks in ~/projects/$submodule to each of these dirs and add that
link, but this would not work with windows, I guess (would it work
with git, anyway?)

So, how can I manage my code without having to restructure my tree?

I'd like to keep it that way, because it is convenient to have only
one directory to pass to the compiler as an additional include dir,
and can include my header files as "submodule/someheader.hpp" which
is, in my opinion, helpful in organizing the code.

If there should be no way I can keep my directory setup the way it is
with the current git, would a feature request be a good idea (and
possibly implemented), or does my directory tree have a serious flaw I
haven't stumbled across yet, which makes it unusable anyways?

Thank you in advance.
