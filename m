From: Jonas Fonseca <fonseca@diku.dk>
Subject: [ANNOUNCE] tig-0.16
Date: Sat, 12 Jun 2010 12:24:05 -0400
Message-ID: <AANLkTim3y6FiKlbI2sKv0hujAfyfkrMuZp-1MpktMdRp@mail.gmail.com>
References: <5036131121414306558@unknownmsgid>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 12 18:24:33 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ONTVZ-0002SV-6h
	for gcvg-git-2@lo.gmane.org; Sat, 12 Jun 2010 18:24:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751833Ab0FLQY3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jun 2010 12:24:29 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:49978 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751743Ab0FLQY2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jun 2010 12:24:28 -0400
Received: by iwn9 with SMTP id 9so1584935iwn.19
        for <git@vger.kernel.org>; Sat, 12 Jun 2010 09:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:sender:received
         :in-reply-to:references:from:date:x-google-sender-auth:message-id
         :subject:to:content-type;
        bh=jFljBHEQusjADK1R7v6t7S2KTgEdHWDlGg82qhs5lQY=;
        b=R0fjovN4Jsoe27qu1x+7w86CsjOY5/7PjjrxTC88xZsAvEgMIFwFTn9xXTP9OfZGof
         jYY1DPbNB2+QFSvwSkRIsBX3/RQgIirBwG6TPzTRlxrGqHVfMET7xkd6dd6++KZI4xi6
         t8CGxhJ/RgtA22Gooqjh09k8iVUn8I/kPxPpI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:content-type;
        b=jk2lhpNfYrUBPP0/jNJcyFpTo/BuNZ+ZhYTjjnd5WS7NS4vmm6q+3zn8XpiTse6DJQ
         /52iHCHjXnrglZisFB0TINZ58nggEcL+f8/coiiKwdOZAZTDQQ0/f2Xvcr/jS5qy//3r
         Y0pXwiZ+HfMyeteOnM0J8ZpmXXVg3UTPGCu28=
Received: by 10.231.158.131 with SMTP id f3mr3632166ibx.54.1276359865675; Sat, 
	12 Jun 2010 09:24:25 -0700 (PDT)
Received: by 10.231.206.145 with HTTP; Sat, 12 Jun 2010 09:24:05 -0700 (PDT)
In-Reply-To: <5036131121414306558@unknownmsgid>
X-Google-Sender-Auth: goepvfHu8xumePcfP3khm82YOh8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149013>

Salut,

A new version of tig is available. Thanks to everyone who provided
patches and input.

In the pipe-line are changes to finally rewrite the graph visualisation
(currently being rebased in wip/graph) and retire the log view.

What is tig?
------------
Tig is an ncurses-based text-mode interface for git. It functions mainly
as a git repository browser, but can also assist in staging changes for
commit at chunk level and act as a pager for output from various git
commands.

 - Homepage:	http://jonas.nitro.dk/tig/
 - Manual:	http://jonas.nitro.dk/tig/manual.html
 - Tarballs:	http://jonas.nitro.dk/tig/releases/
 - Git URL:	git://repo.or.cz/tig.git
 - Gitweb:	http://repo.or.cz/w/tig.git

Release notes
-------------
Incompatibilities:

 - Encode everything internally as UTF-8. This can affect performance,
   but should in general improve handling of character lengths etc.
   Also, to properly handle UTF-8 environments use ncurses with wide
   character support.
 - The use of TIG_{MAIN,DIFF,LOG,TREE,BLOB}_CMD environment variables
   has been deprecated. To allow configuration of the diff view,
   TIG_DIFF_OPTS can be used.

Improvements:

 - Plug several memory leaks.
 - Command line arguments are split into diff, revision, and file
   arguments and made available as %(diffargs), %(revargs), and
   %(fileargs). Diff view will limit diffs using %(fileargs).
 - Status view: update the file variable when a line is selected so
   %(file) works as expected.
 - Branch view: add %(branch) symbol providing access to the selected
   branch.
 - Branch view: add entry to browse all branches (uses git-log's --all
   flag).
 - Abbreviation of author names can now be configured and toggled.
 - Mark detached heads with [HEAD].
 - Add support for displaying dates in local time.

Bug fixes:

 - Status view: fix usage from sub directories, which was broken by the
   changes made to support blame view from sub directories.
 - Fix text expansion to not truncate long lines
 - Fix parsing of boolean show-date values.
 - Fix relative date.
 - Fix unbind to behave as if the keybinding was never defined.
 - Fix unbind to also cover built-in run requests.
 - Fix parsing of unknown keymap names.
 - Blame view: fix parent blame to detect renames. It uses "previous"
   line info from the blame porcelain output added in git version 1.6.3.

Change summary
--------------
The diffstat and log summary for changes made in this release.

 INSTALL                     |   19 +-
 Makefile                    |   13 +
 NEWS                        |   42 +
 TODO                        |    2 +
 VERSION                     |    2 +-
 contrib/announcement.sh     |    2 +-
 contrib/aspell.dict         |   13 +-
 contrib/release.sh          |    2 +-
 contrib/tig-completion.bash |    2 +-
 manual.txt                  |   81 +--
 tig.1.txt                   |   29 +-
 tig.c                       | 1724 +++++++++++++++++++----------------
 tigrc.5.txt                 |   29 +-
 13 files changed, 1065 insertions(+), 895 deletions(-)

     1	Ingmar Vanhassel
     2	Jeff King
    89	Jonas Fonseca
     2	Simon Gerber
     1	Simon Ruderich
     1	jipey
