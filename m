From: Michal Dudek <Michal.Dudek@cern.ch>
Subject: GIT pre-commit hook problem with "git commit -m 'text' file.c"
 syntax
Date: Thu, 29 Aug 2013 12:29:15 +0000
Message-ID: <CABF5274B2F4714E97745603BDD7A3F7979E4C99@PLOXCHG23.cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 29 14:29:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VF1Lo-0004GL-8T
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 14:29:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754751Ab3H2M3T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 08:29:19 -0400
Received: from cernmx31.cern.ch ([137.138.144.179]:9710 "EHLO CERNMX31.cern.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752276Ab3H2M3R convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Aug 2013 08:29:17 -0400
Received: from CERNFE22.cern.ch (137.138.144.151) by cernmxgwlb2.cern.ch
 (137.138.144.179) with Microsoft SMTP Server (TLS) id 14.2.318.1; Thu, 29 Aug
 2013 14:29:16 +0200
Received: from PLOXCHG23.cern.ch ([fe80::1976:74b3:fc31:2b14]) by
 CERNFE22.cern.ch ([fe80::897b:8d03:da25:5b36%10]) with mapi id
 14.02.0318.004; Thu, 29 Aug 2013 14:29:16 +0200
Thread-Topic: GIT pre-commit hook problem with "git commit -m 'text' file.c"
 syntax
Thread-Index: Ac6kszWt5bKlnTPuSmaoV7HXpZrnoA==
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.138.217.55]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233248>

Hi!
I am writing a "pre-hook" script, which will be responsible for checking style (formatting/indenting) of the C source code. The script at the beginning executes "git diff --name-only -z --cached HEAD" in order to get all the committed changes, then it makes a two copies of the staged file, one is kept as an original and the second one is formatted by "astyle" program. Then I am creating patch using "git diff" between the original file and formatted one. After that I am applying patch (asking user some questions before doing that) to the index or to the file in the working tree (behaviour depends on the situation, if the file was staged and modified after that (git status returns file as "staged" and "modified but NOT staged") I am applying changes to index using "git apply -v --cached patc
 h", otherwise if the file was staged and no changes to it were made afterwards (git status returns file as "staged" only) I am modifying file in the working tree using "git apply -v patch" and adding modified file to stage using "git add my_file.c"). Everything works fine till the moment when user modifies a file and commits it using command "git commit -m 'comment' my_file.c". After that the committed file looks ok (also in git log etc.) but when I type "git status" or use "gitk" I see some leftovers. Gitk shows a "local changes checked to index but not committed" -- this is a raw file before applying a patch -- and "local uncommitted changes not checked into index" -- this is a file after patch was applied. The manual says that listing files as arguments to the commit command, make the
  git ignore changes staged in the index, and instead record the current content of the listed files. I would like to ask you if there is a way to force commit to ALWAYS add files before commit? Can I distinguish, that the commit was executed using syntax "git commit -m 'text' file.c"? Is there any other solution for my problem?

Thank you for your time!
Michal Dudek
