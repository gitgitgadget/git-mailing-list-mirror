From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] Documentation: exclude irrelevant options from "git pull"
Date: Tue, 14 Jan 2014 11:54:45 -0800
Message-ID: <xmqqd2ju49b3.fsf@gitster.dls.corp.google.com>
References: <loom.20140114T025825-557@post.gmane.org>
	<xmqqvbxm4dyq.fsf@gitster.dls.corp.google.com>
	<52D5874D.7070102@web.de> <7v61pm1hfe.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ivan Zakharyaschev <imz@altlinux.org>, git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Jan 14 21:07:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3AGP-0005PV-Q6
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jan 2014 21:07:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751472AbaANUHB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jan 2014 15:07:01 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46009 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751274AbaANUG7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jan 2014 15:06:59 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2A75C611B4;
	Tue, 14 Jan 2014 15:06:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=Ai6L7NDgc9BnaSymAMlZkIzSz3Q=; b=PXpfppgThu3ZCfjOXmAn
	KtfizKMDI8wXFJ8ytxt+i1AOqNfbEdvitSUQ3vQ/dUE2z1q2bfeNqMDlVNxWLO9X
	ASn/dsamMzl8HUWfJpWRCSF59YUexoi14aQm+S7Vc53izWRm+hjo51/ZfGruw0wd
	sBZmq68TWJ2RrbAZs1fxlR0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=nJrdTB1fqcQWjx1XGyaC0EsGa9KMY7YWjyYYaWoDGbO0ex
	QDFqyR801uyVIuFJ5evlL9T9ov6ud5vMf+CEf+y+D0CR4+0Wura1+JJwvR9nZr3R
	RxnPo5oEIN/UxWXZKpMZJdE+tPCz70U5bD7DOu/MGS9NVKm6yqsKWrKysciT4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 12B99611B3;
	Tue, 14 Jan 2014 15:06:59 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3EDC3611B2;
	Tue, 14 Jan 2014 15:06:58 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 6C3A8F24-7D57-11E3-8C73-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240411>

10eb64f5 (git pull manpage: don't include -n from fetch-options.txt,
2008-01-25) introduced a way to exclude some parts of included
source when building git-pull documentation, and later 409b8d82
(Documentation/git-pull: put verbosity options before merge/fetch
ones, 2010-02-24) attempted to use the mechanism to exclude some
parts of merge-options.txt when used from git-pull.txt.

However, the latter did not have an intended effect, because the
macro "git-pull" used to decide if the source is included in
git-pull documentation were defined a bit too late.

Define the macro before it is used to fix this.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * To be applied on top of 409b8d82 (Documentation/git-pull: put
   verbosity options before merge/fetch ones, 2010-02-24)

 Documentation/git-pull.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index d47f9dd..0e7a1fe 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -42,10 +42,10 @@ OPTIONS
 Options related to merging
 ~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-include::merge-options.txt[]
-
 :git-pull: 1
 
+include::merge-options.txt[]
+
 --rebase::
 	Instead of a merge, perform a rebase after fetching.  If
 	there is a remote ref for the upstream branch, and this branch
-- 
1.8.5.3-493-gb139ac2
