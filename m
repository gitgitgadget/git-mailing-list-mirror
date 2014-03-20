From: Jeff King <peff@peff.net>
Subject: [PATCH 0/12] GIT_CONFIG in the test suite
Date: Thu, 20 Mar 2014 19:11:59 -0400
Message-ID: <20140320231159.GA7774@sigill.intra.peff.net>
References: <244284@gmane.comp.version-control.git>
 <1395144518-2489-1-git-send-email-unsignedzero@gmail.com>
 <xmqqd2hj6y5o.fsf@gitster.dls.corp.google.com>
 <20140318214536.GA10076@sigill.intra.peff.net>
 <xmqqy5075f0k.fsf@gitster.dls.corp.google.com>
 <20140318230658.GA10679@sigill.intra.peff.net>
 <xmqqzjkm3xo1.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David Tran <unsignedzero@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 21 00:12:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQm8P-0003ac-WC
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 00:12:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759504AbaCTXMD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2014 19:12:03 -0400
Received: from cloud.peff.net ([50.56.180.127]:43550 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758342AbaCTXMB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2014 19:12:01 -0400
Received: (qmail 27410 invoked by uid 102); 20 Mar 2014 23:12:01 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 20 Mar 2014 18:12:01 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Mar 2014 19:11:59 -0400
Content-Disposition: inline
In-Reply-To: <xmqqzjkm3xo1.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244601>

On Wed, Mar 19, 2014 at 10:28:46AM -0700, Junio C Hamano wrote:

> [git config --file versus GIT_CONFIG=]
>
> Thanks.  Then I think it makes sense to do such a conversion but it
> probably should be done on top of this patch (we could do it before
> this patch), not as a part of this patch.

Here's a series that goes on top of what you queued in
dt/tests-with-env-not-subshell. Once I started cleaning, I noticed a lot
of room for improvement and modernization in t0001. I hope I didn't get
too carried away.

  [01/12]: t/Makefile: stop setting GIT_CONFIG
  [02/12]: t/test-lib: drop redundant unset of GIT_CONFIG
  [03/12]: t: drop useless sane_unset GIT_* calls
  [04/12]: t: stop using GIT_CONFIG to cross repo boundaries
  [05/12]: t: prefer "git config --file" to GIT_CONFIG with test_must_fail
  [06/12]: t: prefer "git config --file" to GIT_CONFIG
  [07/12]: t0001: make symlink reinit test more careful
  [08/12]: t0001: use test_path_is_*
  [09/12]: t0001: use test_config_global
  [10/12]: t0001: use test_must_fail
  [11/12]: t0001: drop useless subshells
  [12/12]: t0001: drop subshells just for "cd"

 t/Makefile                      |   4 +-
 t/t0001-init.sh                 | 211 ++++++++++-------------------------
 t/t1300-repo-config.sh          |  28 ++---
 t/t1302-repo-version.sh         |   2 +-
 t/t5701-clone-local.sh          |   6 +-
 t/t7400-submodule-basic.sh      |   5 +-
 t/t9130-git-svn-authors-file.sh |   3 +-
 t/t9154-git-svn-fancy-glob.sh   |   6 +-
 t/t9400-git-cvsserver-server.sh |   1 -
 t/test-lib.sh                   |   1 -
 10 files changed, 87 insertions(+), 180 deletions(-)

-Peff
