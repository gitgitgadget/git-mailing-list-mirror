From: "Octavio Alvarez" <alvarezp@alvarezp.ods.org>
Subject: Re: [RFC/PATCH 0/2] New 'stage' command
Date: Tue, 07 Apr 2009 01:39:04 -0700
Message-ID: <op.ur0czewh4oyyg1@localhost.localdomain>
References: <1238939331-10152-1-git-send-email-felipe.contreras@gmail.com>
 <200904052358.53028.markus.heidelberg@web.de>
 <94a0d4530904051535v8bd901fsedecdf61bc4acb33@mail.gmail.com>
 <200904060117.24810.markus.heidelberg@web.de>
 <fabb9a1e0904051622k66352ea4v542ecd99bd5d9c6@mail.gmail.com>
 <20090406032457.GA14758@gmail.com> <7v63hie4yh.fsf@gitster.siamese.dyndns.org>
 <871vs5kjfw.fsf@krank.kagedal.org> <7vy6ud4otd.fsf@gitster.siamese.dyndns.org>
 <87skkligzb.fsf@krank.kagedal.org> <7v8wmd46p9.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Felipe Contreras" <felipe.contreras@gmail.com>,
	"markus heidelberg" <markus.heidelberg@web.de>,
	"Sverre Rabbelier" <srabbelier@gmail.com>,
	"David Aguilar" <davvid@gmail.com>, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>,
	=?iso-8859-1?Q?David_K=E5gedal?= <davidk@lysator.liu.se>
X-From: git-owner@vger.kernel.org Tue Apr 07 10:41:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lr6rj-0002RB-08
	for gcvg-git-2@gmane.org; Tue, 07 Apr 2009 10:41:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753951AbZDGIja convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Apr 2009 04:39:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753448AbZDGIja
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Apr 2009 04:39:30 -0400
Received: from spider.alvarezp.com ([66.150.225.106]:44169 "EHLO
	spider.alvarezp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754265AbZDGIj2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Apr 2009 04:39:28 -0400
Received: from localhost.localdomain (201.160.155.130.cable.dyn.cableonline.com.mx [201.160.155.130])
	(authenticated bits=0)
	by spider.alvarezp.com (8.13.8/8.13.8/Debian-3) with ESMTP id n378d9ap027783
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NOT);
	Tue, 7 Apr 2009 01:39:14 -0700
In-Reply-To: <7v8wmd46p9.fsf@gitster.siamese.dyndns.org>
User-Agent: Opera Mail/10.00 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115938>

On Mon, 06 Apr 2009 18:02:10 -0700, Junio C Hamano <gitster@pobox.com> =
wrote:

> David K=E5gedal <davidk@lysator.liu.se> writes:
>
>>>    - when you want to work with both the index and the work tree at=
 the
>>>      same time, you say STAGEANDWORKTREE (the same disambiguation =20
>>> caveat
>>>      applies).
>>
>> No, where did this come from?
>
> "git apply STAGEANDWORKTREE this.patch".  I do not want "for diff you=
 can
> use these metavariables to name two things compared, but you can do s=
o
> only for diff".

That example is broken. git apply doesn't even take an arbitrary treeis=
h.

>>> Think.  What does "git log STAGE" mean?  Can you explain why it doe=
s =20
>>> not
>>> make any sense?

gitk actually does this. Even more, gitk shows them in this order:
STAGE^ would be HEAD.
WORKTREE^ would be STAGE.

Makes sense.

(Not that I think git log should do the same.)

The difference between git diff and git reset is that git diff should t=
ake
a range of trees, not a range of commits as parameters. OTOH, git reset
doesn't know or care about trees, it needs commits.

git checkout WORKTREE:file makes sense, even though it is useless, but
that's why it git checout STAGE:file makes sense: it should accept any =
tree
instead of a commit.

git apply doesn't even take commits. It *could* take trees if it
automagically created a branch on the commit, though. Either that,
or git-apply shouldn't exist at all.

It's similar with git reset. You wouldn't use STAGE or WORKTREE here be=
cause
a commit is actually necessary, but according option names like: --stag=
e
--worktree --both --none are better than --hard, --soft and --mixed.

So, if the man page for git-reset says "commit-id" and the man page for
git diff says "tree-id..tree-id", I don't see any kind of confusion.
git checkout could too. git reset and git log are to say "commit-id",
but support clearer options.

WORKTREE, STAGE are trees as commits are also trees, but not all trees =
are
commits.
