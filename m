From: Junio C Hamano <gitster@pobox.com>
Subject: v1.5.4 plans
Date: Mon, 10 Dec 2007 14:37:09 -0800
Message-ID: <7vmysijhwq.fsf_-_@gitster.siamese.dyndns.org>
References: <20071022061115.GR14735@spearce.org>
	<7vodeecyni.fsf@gitster.siamese.dyndns.org>
	<7vpryqwtt7.fsf@gitster.siamese.dyndns.org>
	<7vk5ot40w9.fsf@gitster.siamese.dyndns.org>
	<7vy7d43ptc.fsf@gitster.siamese.dyndns.org>
	<7vabpg9x5k.fsf@gitster.siamese.dyndns.org>
	<7vy7cwsi3p.fsf@gitster.siamese.dyndns.org>
	<7vk5o6jbq9.fsf@gitster.siamese.dyndns.org>
	<7v63zjgoel.fsf@gitster.siamese.dyndns.org>
	<7vsl2i6ea4.fsf@gitster.siamese.dyndns.org>
	<7vhcixtnm4.fsf@gitster.siamese.dyndns.org>
	<7vfxye4yv7.fsf@gitster.siamese.dyndns.org>
	<7vve78qhtf.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 10 23:37:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1rFv-00032s-0U
	for gcvg-git-2@gmane.org; Mon, 10 Dec 2007 23:37:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751810AbXLJWhV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Dec 2007 17:37:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751807AbXLJWhV
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Dec 2007 17:37:21 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:33070 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751800AbXLJWhT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Dec 2007 17:37:19 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 8335B1A8F;
	Mon, 10 Dec 2007 17:37:13 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 83BFB1A8D;
	Mon, 10 Dec 2007 17:37:11 -0500 (EST)
In-Reply-To: <7vve78qhtf.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sun, 09 Dec 2007 02:32:44 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67765>

People might have noticed that I've been ignoring most of the new
topics/enhancements for the past few days.  Here is what I want to see
happen until we declare v1.5.4.

First, stabilize 'master' enough and tag v1.5.4-rc0 soon.

 * Among what's already in 'next', Christian's "git help -w" enhancement
   is the only candidate to be in v1.5.4.  Johannes's "git remote" could
   also be, but I've seen it fail tests when run in my k.org private
   repository and haven't had chance to find time to diagnose it, so I'd
   rather leave it after v1.5.4.

 * Eric's sanely-compact mapping from SVN rev-ids to git commits saw a
   positive feedback.  I haven't carefully read that patch but it seemed
   sane and I'd like to have it in v1.5.4.

 * Please, everybody, no more new features until v1.5.4 final ships, and
   please spend a bit more time on finding and fixing regressions than
   you would spend time cooking your favorite new features.  I do not
   have infinite amount of time to comment on new feature patches while
   concentrating on fixes at the same time.

There are outstanding issues that need to be resolved:

 * I'd like to see the pack-object's memory performance issue resolved
   before the release; two very capable people are looking into it and I
   am fairly optimistic.

 * We need to do something about "gc --aggressive".  The documentation
   removal patch from Linus, if it ever materializes, would be better
   than nothing, but I have this nagging suspicion that the explosion is
   merely a bad interation between -A and -f option to the repack, which
   are not meant to be used together.

 * We have a handful deprecation notices in the draft release notes, but
   if I recall correctly, Nico wanted to add a few more.  We need to
   come up with a wording that is easy to understand for the end users
   to decide which ancient versions will be affected.

  "git help -w" will want to have the HTML pages installed, which means
   we would need to add a new package to hold it in git.spec.in.  I am
   willing to work on the initial draft, but help in testing is very
   much appreciated --- I do not work on RPM systems myself.  The same
   goes for "git help -i" which will want the INFO pages installed.

 * I've seen t9119-git-svn-info.sh fail in my k.org private repository
   and have been skipping the test, but this needs to be diagnosed and
   fixed [*1*].  It could be just that the code is fine and the test is
   not rejecting SVN that is too-old. I dunno.

 * There have been quite a few HTTP paches from Mike Hommey.  I'd like
   to limit the changes only to fixes and trivially-correct clean-ups,
   which means these will need to be looked at:

    [PATCH 1/4] Cleanup variables in http.[ch]
    [PATCH 2/4] Use strbuf in http code
    [PATCH 1/5] Remove the default_headers variable from http-push.c
    [PATCH 2/5] Remove a CURLOPT_HTTPHEADER (un)setting
    [PATCH 3/5] Avoid redundant declaration of missing_target()
    [PATCH 4/5] Correctly initialize buffer in start_put() in http-push.c
    [PATCH 5/5] Fix various memory leaks in http-push.c and http-walker.c

   Help in reviewing these from people who were involved in the http
   part of the current codebase is very much appreciated.

If we can freeze by the end of the year, we may be able to release mid
January 2008.


[Footnote]
----------------------------------------------------------------

*1* t9119 first fails at the 6th test.  Perhaps the test needs to check
svn version first and stop testing this feature.  This test does not
fail on my personal box that has svn 1.4.2.

* expecting success:
        (cd svnwc; svn info file) > expected.info-file &&
        (cd gitwc; git-svn info file) > actual.info-file &&
        git-diff expected.info-file actual.info-file

diff --git a/expected.info-file b/actual.info-file
index b1d57f4..997c927 100644
--- a/expected.info-file
+++ b/actual.info-file
@@ -10,6 +10,5 @@ Last Changed Author: junio
 Last Changed Rev: 1
 Last Changed Date: 2007-12-10 22:18:12 +0000 (Mon, 10 Dec 2007)
 Text Last Updated: 2007-12-10 22:18:13 +0000 (Mon, 10 Dec 2007)
-Properties Last Updated: 2007-12-10 22:18:13 +0000 (Mon, 10 Dec 2007)
 Checksum: 5bbf5a52328e7439ae6e719dfe712200

* FAIL 6: info file

                (cd svnwc; svn info file) > expected.info-file &&
                (cd gitwc; git-svn info file) > actual.info-file &&
                git-diff expected.info-file actual.info-file

: hera t/master; svn --version
svn, version 1.3.2 (r19776)
   compiled Jun  1 2006, 10:05:51

Copyright (C) 2000-2006 CollabNet.
Subversion is open source software, see http://subversion.tigris.org/
This product includes software developed by CollabNet (http://www.Collab.Net/).

The following repository access (RA) modules are available:

* ra_dav : Module for accessing a repository via WebDAV (DeltaV) protocol.
  - handles 'http' scheme
  - handles 'https' scheme
* ra_svn : Module for accessing a repository using the svn network protocol.
  - handles 'svn' scheme
* ra_local : Module for accessing a repository on local disk.
  - handles 'file' scheme

----------------------------------------------------------------
