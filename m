From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 0/2] fsck: don't ignore broken reflog entries
Date: Mon,  8 Jun 2015 15:40:03 +0200
Message-ID: <cover.1433769878.git.mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 08 15:40:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1xI4-0002r1-AN
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 15:40:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752769AbbFHNkc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2015 09:40:32 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:50290 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752372AbbFHNkX (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Jun 2015 09:40:23 -0400
X-AuditID: 1207440d-f79026d000000bad-9d-55759b396ad8
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id A1.02.02989.93B95755; Mon,  8 Jun 2015 09:40:09 -0400 (EDT)
Received: from michael.fritz.box (p4FC977B6.dip0.t-ipconnect.de [79.201.119.182])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t58De6NB022064
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 8 Jun 2015 09:40:07 -0400
X-Mailer: git-send-email 2.1.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRmVeSWpSXmKPExsUixO6iqGs5uzTUYEOHgkXXlW4mi4beK8wW
	/cu72Cxur5jPbPGjpYfZgdXj7/sPTB4fPsZ5POvdw+hx8ZKyx+dNcgGsUdw2SYklZcGZ6Xn6
	dgncGfvPH2Yr2MJS8fnJepYGxlPMXYycHBICJhLvXp1kg7DFJC7cWw9kc3EICVxmlNjT1ckE
	4Zxgktj5YBJYFZuArsSinmYmEFtEQE1iYtshFpAiZoH5jBKPW18xgiSEBWwltnXeAFvBIqAq
	MfXlP7A4r4C5xMWTZ6BWy0mcP/6TeQIj9wJGhlWMcok5pbm6uYmZOcWpybrFyYl5ealFukZ6
	uZkleqkppZsYIUHCu4Px/zqZQ4wCHIxKPLwHFpWECrEmlhVX5h5ilORgUhLlre8rDRXiS8pP
	qcxILM6ILyrNSS0+xCjBwawkwps8HSjHm5JYWZValA+TkuZgURLnVVui7ickkJ5YkpqdmlqQ
	WgSTleHgUJLgrZoJ1ChYlJqeWpGWmVOCkGbi4AQZziUlUpyal5JalFhakhEPCvb4YmC4g6R4
	gPaWgrTzFhck5gJFIVpPMepy3JnyfxGTEEtefl6qlDjvBpAiAZCijNI8uBWwlPCKURzoY2Fe
	p1lAVTzAdAI36RXQEiagJd+/FoMsKUlESEk1MHYc6ZVKfuii8K+X75TI1mlT1A4YWMf3JE9u
	PLDrXrGQy97G4wwdimnHN5jztrMzfhLxt+Qr7P+su7D+sMpJz6j4+Faj3IC8uv9Jcq2i59+v
	8y7qNetZwCmkLS9+TNP8udDMy1t37nt+r3BFt4HSabNJzxk/8T8qPDZz5UT3GWnt 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271030>

Previously, if a reflog entry's old or new SHA-1 was not resolvable to
an object, that SHA-1 was silently ignored. Instead, report such cases
as errors.

This patch series is also available from my GitHub account [1], branch
"fsck-reflog-entries".

Michael

[1] https://github.com/mhagger/git

Michael Haggerty (2):
  fsck_handle_reflog_sha1(): new function
  fsck: report errors if reflog entries point at invalid objects

 builtin/fsck.c | 34 ++++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 14 deletions(-)

-- 
2.1.4
