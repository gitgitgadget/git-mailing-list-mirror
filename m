From: Anders Melchiorsen <mail@cup.kalibalik.dk>
Subject: Re: [RFC PATCH] Make the rebase edit mode really end up in an edit state
Date: Sun, 18 Jan 2009 02:24:18 +0100
Message-ID: <877i4tmmnx.fsf@cup.kalibalik.dk>
References: <87ab9th0rh.fsf@cup.kalibalik.dk>
	<7vfxjlxuu5.fsf@gitster.siamese.dyndns.org>
	<20090115153529.GA13961@neumann>
	<7vvdsgql17.fsf@gitster.siamese.dyndns.org>
	<bd6139dc0901151420j4ae62433uc0cc70d86dc45cfa@mail.gmail.com>
	<20090115225912.GL9794@neumann> <20090116001139.GA26357@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes.Schindelin@gmx.de
To: =?utf-8?Q?Bj=C3=B6rn?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jan 18 02:25:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOMQA-0006yc-Gh
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 02:25:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756415AbZARBYW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Jan 2009 20:24:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756376AbZARBYW
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jan 2009 20:24:22 -0500
Received: from mail.hotelhot.dk ([77.75.163.100]:37806 "EHLO mail.hotelhot.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756168AbZARBYV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 Jan 2009 20:24:21 -0500
Received: from mail.hotelhot.dk (localhost [127.0.0.1])
	by mail.hotelhot.dk (Postfix) with ESMTP id 5831730AF8;
	Sun, 18 Jan 2009 02:23:43 +0100 (CET)
Received: from dylle (router.kalibalik.dk [192.168.0.1])
	by mail.hotelhot.dk (Postfix) with ESMTP id E682630013;
	Sun, 18 Jan 2009 02:23:42 +0100 (CET)
In-Reply-To: <20090116001139.GA26357@atjola.homenet> (=?utf-8?Q?=22Bj?=
 =?utf-8?Q?=C3=B6rn?= Steinbrink"'s message of "Fri\, 16 Jan 2009 01\:11\:39
 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106125>

Bj=C3=B6rn Steinbrink <B.Steinbrink@gmx.de> writes:

> No, you don't have to do that. As long as you only want to "edit"
> the commit you marked as "edit", you only need to use "git add" and
> "git rebase --continue". rebase -i checks whether HEAD still
> resolves to the same commit and if so, it automatically does the
> soft reset for you.
>
> Maybe we should just advertise that in the message provided by
> rebase after it stops? I'm afraid I can't come up with a sane
> wording though, as there are still cases when you need to commit
> yourself, eg. when you use reset. And getting that into one simple
> sentence seems a bit hard (for me).

I was happy to learn that trick when looking at the source, so I agree
that it is a good idea to advertise it. You are right that it is hard
to describe well in few words, though. Does somebody feel like
repainting this?


--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -336,14 +336,13 @@ do_next () {
 		make_patch $sha1
 		git rev-parse --verify HEAD > "$DOTEST"/amend
 		warn "Stopped at $sha1... $rest"
-		warn "You can amend the commit now, with"
-		warn
-		warn "	git commit --amend"
-		warn
-		warn "Once you are satisfied with your changes, run"
+		warn "You can amend the commit now, by marking"
+		warn "paths with 'git add <paths>' and running"
 		warn
 		warn "	git rebase --continue"
 		warn
+		warn "If you want to create new commits, run"
+		warn "'git commit' yourself before continuing."
 		exit 0
 		;;
 	squash|s)
