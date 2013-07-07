From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/4] Make "git name-rev $(git rev-parse v1.8.3)" work
Date: Sun,  7 Jul 2013 15:33:40 -0700
Message-ID: <1373236424-25617-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 08 00:33:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UvxWi-0004mw-O3
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jul 2013 00:33:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753298Ab3GGWdt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jul 2013 18:33:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45928 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753202Ab3GGWdr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jul 2013 18:33:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 660C02EA5E
	for <git@vger.kernel.org>; Sun,  7 Jul 2013 22:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id; s=sasl; bh=hsPI5LORU6u2JT/z8ujQ64pDOJg
	=; b=GGn3yqfcN2YztFJ3QFwUkzzIHhhv040NaCUc/+mwYyV62DfYbf9xlCsJHuI
	t/vteVpjqp7BE3vaYaPMzLQscsCCa3Luuyil00rkH1ozh3WoF8SIvgrQqxaFPcxT
	BeX7JG1EoH3939fqGAk2x5fwJYmMF4eVlZ31H+KAts3Bkcb0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id; q=dns; s=sasl; b=S96uS3VfOrckkNvnGYOdE0wb526In
	W2bzFw0P9jIg5SzpxQmtfZOuUKnonO3aJU7kEJUWkplqkt8pkm6wBQqT/37UlMlS
	jpF867GilNEDTNhNGGHdMokuiwu6icmnq4UAqyhnN3XSvFk1S9KcUZPYqUVg/pYD
	y6PQrxpI98POaQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5CE5A2EA5D
	for <git@vger.kernel.org>; Sun,  7 Jul 2013 22:33:46 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E02092EA5A
	for <git@vger.kernel.org>; Sun,  7 Jul 2013 22:33:45 +0000 (UTC)
X-Mailer: git-send-email 1.8.3.2-853-ga8cbcc9
X-Pobox-Relay-ID: 491A9CAC-E755-11E2-8C25-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229812>

So here is a set of small preparatory steps to help the other topic
to allow "git describe -contains v1.8.3" omit trailing "^0" from its
output.  We do not want to prevent people from allowing "name-rev"
to convert object names other than commit-ishes.

The series should apply on 96ffd4ca (Merge branch
'nk/name-rev-abbreviated-refs', 2013-06-30).

Junio C Hamano (4):
  name-ref: factor out name shortening logic from name_ref()
  name-rev: allow converting the exact object name at the tip of a ref
  describe: use argv-array
  describe/name-rev: tell name-rev to peel the incoming object to commit first

 builtin/describe.c |  32 ++++++++-------
 builtin/name-rev.c | 113 ++++++++++++++++++++++++++++++++++++++++++++---------
 2 files changed, 112 insertions(+), 33 deletions(-)

-- 
1.8.3.2-853-ga8cbcc9
