From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/5] ref glob exclusion follow-up
Date: Fri,  1 Nov 2013 12:34:12 -0700
Message-ID: <1383334455-18623-1-git-send-email-gitster@pobox.com>
References: <52264070.3080909@kdbg.org>
Cc: Johannes Sixt <j.sixt@viscovery.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 01 20:34:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VcKUE-0004Mh-EI
	for gcvg-git-2@plane.gmane.org; Fri, 01 Nov 2013 20:34:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752640Ab3KATeV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Nov 2013 15:34:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57537 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751872Ab3KATeU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Nov 2013 15:34:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2029E4ECD8;
	Fri,  1 Nov 2013 15:34:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=MfHm
	o9sR3DDKM+6Pkla0HZt6Cq0=; b=SAi4xSs5GQ0IE6ptcAxSltd+PizZneeXFmvm
	LnPqLoknei8SPAT/NeLOj8BOgXc/87vL9YY9H36E68oplNI78eiqQZ1+32T9X/9C
	M/g9yt+leV5T2csG7f4Ie4fxUTT8c/mYb+I0j5ysIK433gCrHRJmI9vNQXGSzVGJ
	03cJDZk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	jNBkESB/lc/+ApZgsQsQ6dCpINBSeTdmGniDuLjmodBG34mfS5uvd0poBhnw3LyR
	bt2Wtw5GZD4xtPlyxLTzQ+nvlQxI17f+jFTLY0fdxuLwcyTb9G2iuG0SAHJS+ZXr
	i6+iGpwDdT7c+7ZXzrIg9bZ7dN7u8Lylq/MtbIkKfZk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 08D814ECD6;
	Fri,  1 Nov 2013 15:34:20 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6119F4ECD5;
	Fri,  1 Nov 2013 15:34:19 -0400 (EDT)
X-Mailer: git-send-email 1.8.5-rc0-281-g8951339
In-Reply-To: <52264070.3080909@kdbg.org>
X-Pobox-Relay-ID: 9A174F96-432C-11E3-9402-1FFB7F2839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237218>

In $gmane/234730, J6t pointed out that "rev-list --exclude" needs a
matching updates to the globbing option "rev-parse" supports.

Here is a follow-up to do just that. They are meant to be applied on
top of the two patch series that has been cooking in 'pu'.

 - $gmane/233484: e7b432c5 (revision: introduce --exclude=<glob> to
   tame wildcards, 2013-08-30)
    
 - $gmane/233656 by J6t: 5c5d4cdb (document --exclude option,
  2013-09-02) came from

The second one [4/5] in this follow-up series should probably be
squashed into [1/5] e7b432c5.  We may even want to squash these five
patches further down to two patches, one for rev-list and the other
for rev-parse.

Junio C Hamano (3):
  rev-list --exclude: tests
  rev-list --exclude: export add/clear-ref-exclusion and ref-excluded
    API
  rev-parse: introduce --exclude=<glob> to tame wildcards

 Documentation/git-rev-parse.txt | 14 +++++++++++
 builtin/rev-parse.c             | 17 +++++++++++++
 revision.c                      | 46 +++++++++++++++++------------------
 revision.h                      |  5 ++++
 t/t6018-rev-list-glob.sh        | 54 +++++++++++++++++++++++++++++++++++++++++
 5 files changed, 113 insertions(+), 23 deletions(-)

-- 
1.8.5-rc0-281-g8951339
