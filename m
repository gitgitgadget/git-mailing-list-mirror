From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/2] DEFAULT_DOC_TARGET
Date: Thu,  3 Jan 2013 11:05:18 -0800
Message-ID: <1357239920-2201-1-git-send-email-gitster@pobox.com>
Cc: Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 03 20:05:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tqq6p-0003sj-Gt
	for gcvg-git-2@plane.gmane.org; Thu, 03 Jan 2013 20:05:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753847Ab3ACTFY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jan 2013 14:05:24 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64254 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753663Ab3ACTFX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jan 2013 14:05:23 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 58C7EAC3A;
	Thu,  3 Jan 2013 14:05:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id; s=sasl; bh=ZJzm2Oqg49MzJlZK0MMBw+1s5Vw
	=; b=WP3esnbsElqLgeuV2PF3KKFL1dwg5OFRjIMiiUbZKk8z/96RyawVPOLq3M/
	FPpOI2tk7BoP/QD9EQwf8WeZXz5WY+Q/jvGR/gt/GgK/lXuOwxRZoI+tqE4IGUkM
	u+ui1Acn1WQKOnng2hzDVBp9ZzQPStivuV/sz0EP7fONEZpE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id; q=dns; s=sasl; b=a04AdrH6N2aznqLZxfKQ9
	N/RxvOJdoVlPtxLnKJvpCcbjbfhgPUeyPCtBOBdrjP0X8i+Uye55DoJdPy9Fdug3
	RhJDrLeNqA+f1r69KVCI6W6mfxWDi0tr3jtGBK1JFFdXQ0ezlsvrqgHczvdoWTdQ
	Td6YvhYOy3LnI9+zpXMXbY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4AB67AC39;
	Thu,  3 Jan 2013 14:05:22 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C60B2AC2B; Thu,  3 Jan 2013
 14:05:21 -0500 (EST)
X-Mailer: git-send-email 1.8.1.293.g4a210a9
X-Pobox-Relay-ID: 85A7AB7E-55D8-11E2-A6A3-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212600>

This allows things like:

  $ DEFAULT_DOC_TARGET=html make doc
  $ DEFAULT_DOC_INSTALL_TARGET=html make install-doc

on a platform that does not have manpage viewer.  Which is not very
useful, given that you can already say

  $ make install-html

on such a platform, and these install-$format targets will not go
away.

The real motivation behind this was to let me say:

  $ git checkout $some_old_fork_point
  $ DEFAULT_DOC_TARGET=git-push.1 make doc

while updating the sources to the documentation for the maintainance
track, without having to format everything else that is different
between the old fork point and the primary branch I usually work on.

The first one was discussed some time ago on the list and all the
fixes mentioned on the thread already squashed in.  The second one
is merely for completeness.

For previous round, see:

  http://thread.gmane.org/gmane.comp.version-control.git/207193/focus=207201

Junio C Hamano (2):
  Allow generating a non-default set of documentation
  Allow installing a non-default set of documentation

 Documentation/Makefile | 10 ++++++++--
 Makefile               | 13 ++++++++++++-
 2 files changed, 20 insertions(+), 3 deletions(-)

-- 
1.8.1.293.g4a210a9
