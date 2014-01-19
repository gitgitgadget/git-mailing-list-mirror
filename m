From: David Kastrup <dak@gnu.org>
Subject: [PATCH 0/2] Two janitorial patches for builtin/blame.c
Date: Sun, 19 Jan 2014 19:57:48 +0100
Message-ID: <1390157870-29795-1-git-send-email-dak@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Kastrup <dak@gnu.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 19 19:58:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W4xZp-0007fU-O8
	for gcvg-git-2@plane.gmane.org; Sun, 19 Jan 2014 19:58:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751709AbaASS6V convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 19 Jan 2014 13:58:21 -0500
Received: from fencepost.gnu.org ([208.118.235.10]:47911 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751591AbaASS6U convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Jan 2014 13:58:20 -0500
Received: from localhost ([127.0.0.1]:46952 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1W4xZb-00021t-7y; Sun, 19 Jan 2014 13:58:19 -0500
Received: by lola (Postfix, from userid 1000)
	id C373CE0510; Sun, 19 Jan 2014 19:58:04 +0100 (CET)
X-Mailer: git-send-email 1.8.3.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240697>

This is more a warmup than anything else: I'm actually doing a quite
more involved rewrite of git-blame right now.  But it's been a long
time since I=C2=A0sent patches for Git, so I'm starting out with someth=
ing
reasonably uncontroversial.  Patch 1 is a no-brainer: maintaining
reverse links is not worth the trouble if you are not going to use
them.  Now one can be "conservative" and say "but git-blame is awfully
inefficient and maybe we'll need them in a more efficient version".
I=C2=A0can answer this with "no": the kind of stuff that would make thi=
ngs
more efficient does not require backlinks.

Patch 2 is a bit more tricky: basically its contention is that
I=C2=A0understand some implications of the code better than its author
appeared to do.  Which is somewhat optimistic.  Since my followup work
depends on my understanding this correctly, it's better to make sure
of that by handing in a nicely isolated patch for review.  It's
conceivable that my understanding of the commit->util cache is not
fully satisfactory.  I don't use it in my followup work anyway, but it
still would be nice to get this code path cleaned out in advance.

I don't expect measurable performance improvements from these two
patches: their main purpose is to get some cruft out of the way so
that the heavy-duty patches actually dealing with the performance
sinks will be a bit more focused.

And of course, getting the ball rolling again.

David Kastrup (2):
  builtin/blame.c: struct blame_entry does not need a prev link
  Eliminate same_suspect function in builtin/blame.c

 builtin/blame.c | 38 ++++++++++----------------------------
 1 file changed, 10 insertions(+), 28 deletions(-)

--=20
1.8.3.2
