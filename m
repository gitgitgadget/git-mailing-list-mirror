From: Junio C Hamano <gitster@pobox.com>
Subject: Instituting feature and infrastructure enhancement proposal window?
Date: Sun, 24 Feb 2008 11:33:13 -0800
Message-ID: <7v8x1ataiu.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 24 20:34:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTMbu-0006Xv-KY
	for gcvg-git-2@gmane.org; Sun, 24 Feb 2008 20:34:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751004AbYBXTda convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Feb 2008 14:33:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751084AbYBXTda
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Feb 2008 14:33:30 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:50642 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751004AbYBXTd3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Feb 2008 14:33:29 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B491618A3;
	Sun, 24 Feb 2008 14:33:26 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 860C218A2; Sun, 24 Feb 2008 14:33:21 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74955>

As I mentioned, I'd like to keep each cycle manageably shorter
than 1.5.4 (which took 5 months that is 2 months too many).

This is still "a weather balloon", but I'd like to establish for
each development cycle a feature and infrastructure enhancement
proposal window, just like the kernel folks have "merge window".

 * These are outside of the scope:

   - Well-contained minor bugfixes,
   - Documentation updates,
   - Additional tests.
   - Updates to contrib/ and (what I consider) non-core parts,
     like gitweb.

 * Fixes to serious issues can delay and prolong the cycle.

 * The mailing list discussions and patch reviews are expected
   to continue as before, however:

   - Isolated new features that come after the window closes may
     be merged to "next" but won't graduate until the new release.

   - Infrastructure changes that have wider impact that come
     after the window closes won't even hit "next" until the
     new release.

If this proposal is accepted favorably by the list and is
implemented, a release cycle will look like this:

 * A release from 'master' is made (e.g. v1.5.4 gets released on
   Feb 1st).

 * The release is merged to 'maint'.

 * Fix-ups to v1.5.4 start flowing and get applied to 'maint',
   and merged to 'master'.  At some point, the first maintenance
   release is made (e.g. v1.5.4.1 was released on Feb 10th).

 * The topics that have been cooking in 'next' may be rebased to
   v1.5.4, and 'next' is rebuilt on top of 'master' with them
   (e.g. this happened on Feb 17th for this cycle).

 * New topics start appearing in 'next', cook and graduate to
   'master' as before.

 * The window closes.  We pick what topics we should have in the
   new release.

 * We continue as before, but with the understanding that some
   topics in 'next' won't graduate before the new release.

 * Tag -rc1.  'next' really closes and we go into feature
   freeze.

 * RC cycle continues.  Perhaps one or two RCs every week, as before.

 * The new release is made (hopefully within 3 months since the
   beginning of the cycle).

The important dates in the above would be (in parentheses are my
straw-mans):

 * The first maintenance release (+1 week from the last release)

 * The rebuilding of 'next' (immediately after the first maint)

 * The close of the window (+6 weeks from the last release)

 * The -rc1 (+8 weeks from the last release)

 * The new release (+12 weeks from the last release)

=46or 1.5.5, I'd like to make the above +6 weeks a bit short and
make it by the end of this month, though, so upcoming dates
would roughly be:

 - By the end of February, the 1.5.5 window closes;
 - By mid March, 1.5.5-rc1 is tagged;
 - By early April, 1.5.5 is released.

Which would make this week for the discussion to pick which
topic should be in 1.5.5.

Here are the current candidates I personally have in mind for
topics that should be in 1.5.5:

 * describe --exact (Shawn)
 * checkout in C (Daniel)
 * format-patch --cover-letter (Daniel)
 * autodetect ncpu in threaded pack (Andreas Ericsson)
 * stash delete / stash pop (Dscho, Brandon Casey)
 * run-command API clean-ups (Johannes Sixt)
 * local branch tracking (Jay Soffian)
 * url rewriting (Daniel)
 * low-level merge improvements (Dscho)
 * apply --whitespace=3Dfix improvements (me)
 * diff --relative (me)
 * diff --dirstat (Linus)
 - mergetool updates (Charles Bailey)
 - bisect vs cg-seek (Carl Worth)
 - worktree setup (Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy)
 - tightened object parser and walker safety (Martin Koegler)

One topic that is missing from the above list, which is queued
in 'pu', worth mentioning is "gitdir: $path in .git" by Lars
Hjemli.  The situation is like Dscho's "reflog delete" before we
did v1.5.4 in that it is waiting for a real user to prove this
is a good enhancement.  I am sure that later rounds would build
enhancements to "git submodule" on top of this, and I think it
is better to wait until that effort starts cooking.

Thoughts?
