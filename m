From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [RFC 0/2] Separate stat_data from cache_entry
Date: Mon, 13 May 2013 05:00:05 +0200
Message-ID: <1368414007-3819-1-git-send-email-mhagger@alum.mit.edu>
References: <5190500E.8060907@alum.mit.edu>
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon May 13 05:00:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ubj03-0007jj-1v
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 05:00:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752285Ab3EMDA1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 May 2013 23:00:27 -0400
Received: from ALUM-MAILSEC-SCANNER-3.MIT.EDU ([18.7.68.14]:45469 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751672Ab3EMDAZ (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 May 2013 23:00:25 -0400
X-AuditID: 1207440e-b7f2b6d00000094c-39-519057492285
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id B7.81.02380.94750915; Sun, 12 May 2013 23:00:25 -0400 (EDT)
Received: from michael.fritz.box (p57A25404.dip0.t-ipconnect.de [87.162.84.4])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r4D30EGu015002
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 12 May 2013 23:00:22 -0400
X-Mailer: git-send-email 1.8.2.2
In-Reply-To: <5190500E.8060907@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOIsWRmVeSWpSXmKPExsUixO6iqOsZPiHQYMUNTouuK91MFg29V5gt
	5t3dxWRxe8V8ZosfLT3MDqwef99/YPK49PI7m8ez3j2MHhcvKXt83iQXwBrFbZOUWFIWnJme
	p2+XwJ3RdK6dteAZa8XDk7tZGxgPsnQxcnJICJhI7P7UzAhhi0lcuLeerYuRi0NI4DKjxMSJ
	e1ggnHNMEh0PjrKDVLEJ6Eos6mlmArFFBGQlvh/eyAhSxCwwk1Hi+99vYEXCAmYS8/7vBiti
	EVCV+DbpNxuIzSvgLLHu5jUgmwNonYLEs7N8IGFOAR2JCe+XgF0kJKAtcbdzAuMERt4FjAyr
	GOUSc0pzdXMTM3OKU5N1i5MT8/JSi3SN9XIzS/RSU0o3MUKCim8HY/t6mUOMAhyMSjy8C5Qn
	BAqxJpYVV+YeYpTkYFIS5T0fAhTiS8pPqcxILM6ILyrNSS0+xCjBwawkwrvXDSjHm5JYWZVa
	lA+TkuZgURLnVVui7ickkJ5YkpqdmlqQWgSTleHgUJLgvRoK1ChYlJqeWpGWmVOCkGbi4AQR
	XCAbeIA2PAQp5C0uSMwtzkyHKDrFqCglzrsYJCEAksgozYMbAIv/V4ziQP8I874AqeIBpg64
	7ldAg5mABp/x6AcZXJKIkJJqYJTd183oceK4lMEJ1aXzFp5618Nq9H9ZheCyxNCOBL/5dWmN
	7JYCPh+MOe+r3znq6mIl7XvA6PH6K8e9zHsbHO19p0XtU7R9eu/0Pos5rAvkWVyXWXyI4Xr9
	wIjz98+2rV1XPT6ePX/52UGjjBdTN57/ohpx1O6oTMAGlYNPT/78P2PJG3PN0/VK 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224078>

This series is a possible replacement for Peff's

    "[PATCH 2/4] add a stat_validity struct"

that doesn't misuse the cache_entry too much in the implementation of
the new functions.  It is only interesting in the context of Peff's
series (or something like it), or if there are other places where
somebody wants to be able to tell whether a file has changed since
it was last checked.

Michael

Michael Haggerty (2):
  Extract a struct stat_data from cache_entry
  add a stat_validity struct

 builtin/ls-files.c |  12 ++--
 cache.h            |  60 +++++++++++++++--
 read-cache.c       | 191 ++++++++++++++++++++++++++++++++++-------------------
 3 files changed, 183 insertions(+), 80 deletions(-)

-- 
1.8.2.2
