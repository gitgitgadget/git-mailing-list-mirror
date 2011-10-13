From: mhagger@alum.mit.edu
Subject: [PATCH 00/14] Tidying up references code
Date: Thu, 13 Oct 2011 09:58:21 +0200
Message-ID: <1318492715-5931-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 13 09:59:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REGC3-0001nZ-34
	for gcvg-git-2@lo.gmane.org; Thu, 13 Oct 2011 09:59:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753179Ab1JMH66 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Oct 2011 03:58:58 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:34322 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751232Ab1JMH65 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Oct 2011 03:58:57 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1REG66-0002Mo-LG; Thu, 13 Oct 2011 09:52:58 +0200
X-Mailer: git-send-email 1.7.7.rc2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183448>

From: Michael Haggerty <mhagger@alum.mit.edu>

This is the next installment of the reference changes that I have been
working on.  This batch includes a lot of tidying up in preparation
for the real changes.

The last few patches have a little bit of meat on them.  They start
changing the innards of refs.c to work less with strings and more with
objects.  This work will continue in later patches with the ultimate
goal of swapping the data structure used to store cached references
out from under the module--changing it from a sorted array of pointers
into a hierarchical tree shaped like the reference namespace
tree.

This patch series should be applied on top of "[PATCH v3] Provide API
to invalidate refs cache".  It has textual dependencies on that patch
series, though logically I don't think that they interact.

Michael Haggerty (14):
  cache.h: add comments for git_path() and git_path_submodule()
  struct ref_list: document name member
  refs.c: rename some local "refname" variables
  refs: rename some parameters result -> sha1
  clear_ref_list(): rename from free_ref_list()
  resolve_gitlink_ref(): improve docstring
  is_refname_available(): remove the "quiet" argument
  parse_ref_line(): add docstring
  add_ref(): add docstring
  is_dup_ref(): extract function from sort_ref_list()
  refs: change signatures of get_packed_refs() and get_loose_refs()
  get_ref_dir(): change signature
  Pass a (cached_refs *) to the resolve_gitlink_*() functions
  resolve_gitlink_ref_recursive(): change to work with struct
    cached_refs

 cache.h |   15 +++
 refs.c  |  418 +++++++++++++++++++++++++++++++++-----------------------------
 refs.h  |   34 +++--
 3 files changed, 258 insertions(+), 209 deletions(-)

-- 
1.7.7.rc2
