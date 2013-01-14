From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/3] A smoother transition plan for cvsimport
Date: Sun, 13 Jan 2013 17:40:26 -0800
Message-ID: <1358127629-7500-1-git-send-email-gitster@pobox.com>
References: <7v8v7wiv3a.fsf@alter.siamese.dyndns.org>
Cc: jrnieder@gmail.com, mhagger@alum.mit.edu, esr@thyrsus.com,
	chris@rorvick.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 14 02:41:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuZ2p-0001ro-7a
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jan 2013 02:40:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755716Ab3ANBkf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jan 2013 20:40:35 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39968 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755590Ab3ANBkf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2013 20:40:35 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 04213BC28;
	Sun, 13 Jan 2013 20:40:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=IbP7
	W9618RzbQbEU3WWtAxfHPXE=; b=wffZ0IAM4JobCxSSKMwY727fjAtQypglvhzU
	2fySHQI0DzS+vAmD51rMFv7kIPJNXHw4MylOGrOmSoA+TFGioKy9muykRb30P9Mq
	j6D8ImbVp4duR7EOkCAu27wja9XbK1abH4wcRVK7ZXH8kcUaf+5RaTReIlCDawun
	s4PI15I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	AFAzgLc2s/BlC9y6JwQ5FnRGY02DkU4B2aOF/igw9M+V+gbvRR1KoGH1zBfXzER/
	xpNIcHRm9wZMjQDVFGWR2C8J4Srb0hEl2HOOleiMrrkGm+g7cJe1hVPkW8F7xoBj
	Nyhxldv8P4AcpMpo1S0m3ioFDFsiR/8iimfELHBf8T8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A33FDBC1E;
	Sun, 13 Jan 2013 20:40:33 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A4B5ABC10; Sun, 13 Jan 2013
 20:40:31 -0500 (EST)
X-Mailer: git-send-email 1.8.1.421.g6236851
In-Reply-To: <7v8v7wiv3a.fsf@alter.siamese.dyndns.org>
X-Pobox-Relay-ID: 6294D736-5DEB-11E2-AF29-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213415>

So here is a start of how such a transition plan outlined in the
previous message may look like.

The first two are preparatory step to allow the current code to
still work even when cvsps2 and cvsps3 are both available on the
system.

The last patch is mostly for illustration purposes; the cvsimport-3.py
script it adds was taken from the patch Eric sent earlier and I relayed
to the list, and does not have later improvements in Eric's tree or
any of Chris's patches.

Junio C Hamano (3):
  cvsimport: allow setting a custom cvsps (2.x) program name
  cvsimport: introduce a version-switch wrapper
  cvsimport: start adding cvsps 3.x support

 .gitignore           |    1 +
 Makefile             |   28 +-
 git-cvsimport-2.perl | 1179 ++++++++++++++++++++++++++++++++++++++++++++++++++
 git-cvsimport-3.py   |  344 +++++++++++++++
 git-cvsimport.perl   | 1177 -------------------------------------------------
 git-cvsimport.sh     |    5 +
 t/lib-cvs.sh         |    4 +-
 7 files changed, 1553 insertions(+), 1185 deletions(-)
 create mode 100755 git-cvsimport-2.perl
 create mode 100755 git-cvsimport-3.py
 delete mode 100755 git-cvsimport.perl
 create mode 100755 git-cvsimport.sh

-- 
1.8.1.421.g6236851
