From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] contrib/rerere-train: use installed git-sh-setup
Date: Mon, 30 Apr 2012 12:46:30 -0700
Message-ID: <7vwr4xdmuh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: nanako3@lavabit.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 30 21:46:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SOwYP-0003wX-UV
	for gcvg-git-2@plane.gmane.org; Mon, 30 Apr 2012 21:46:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756583Ab2D3Tqd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Apr 2012 15:46:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54025 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756470Ab2D3Tqc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2012 15:46:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3DEAB7BE4;
	Mon, 30 Apr 2012 15:46:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=b
	g4xzR3a+rDXb1FhL0yT1FUcJVM=; b=fUSuQsokFz1LDT/DSh4YEo0G9bIGFZJsE
	4hbcViQLl5So6ho/kbUqOHL1UpMSSYNiotgjua71phXyJwm2FQLtNoPl/EqBPGKc
	zUL0KA4rsgWaDst84QERhf97dxhNO5DV31zg3B85nelvRMQx3tBoDkB3UpkPQcS9
	aJutk7R5DY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; q=dns; s=
	sasl; b=C1EhN62+hylpOs66MfMmfCFufT30JQzXUrUtSeiW0ZzrbI9gJGP3jRuO
	u+t2Ln5Tlrv/F1GDrsS/ko6vXbhaE0Od3N2keC+yYtlxGTXmlWwlXUT0DQu4btbp
	MDwYF7VCROuP6bHqHHRUU4YqwjdCiOjtZediApHUF2KdGI15MHU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 35A857BE2;
	Mon, 30 Apr 2012 15:46:32 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C09777BDF; Mon, 30 Apr 2012
 15:46:31 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2F6EB46C-92FD-11E1-B592-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196602>

Instead of sourcing git-sh-setup from random place that is on the $PATH,
explicitly source $(git --exec-path)/git-sh-setup.  As I do not personally
have any libexec/git-core directory on my $PATH like many other people, the
script will fail without this update.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * I recently was helped greatly by this old script written in Sept 2008.
   We may want to integrate it to "git rerere" proper some day, but that
   is a separate topic.

 contrib/rerere-train.sh |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/rerere-train.sh b/contrib/rerere-train.sh
index 2cfe1b9..36b6fee 100755
--- a/contrib/rerere-train.sh
+++ b/contrib/rerere-train.sh
@@ -7,7 +7,7 @@ USAGE="$me rev-list-args"
 
 SUBDIRECTORY_OK=Yes
 OPTIONS_SPEC=
-. git-sh-setup
+. $(git --exec-path)/git-sh-setup
 require_work_tree
 cd_to_toplevel
 
-- 
1.7.10.479.g65462
