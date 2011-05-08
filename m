From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v0 0/3] git add a-Big-file
Date: Sun,  8 May 2011 01:47:32 -0700
Message-ID: <1304844455-23570-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 08 10:47:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QIzeS-0004Sw-Kf
	for gcvg-git-2@lo.gmane.org; Sun, 08 May 2011 10:47:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752137Ab1EHIrj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 May 2011 04:47:39 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:43810 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751361Ab1EHIrj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2011 04:47:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7CAE14DF1
	for <git@vger.kernel.org>; Sun,  8 May 2011 04:49:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id; s=sasl; bh=js9/E4WeML0D8Cp7xpHadJ0GdX0
	=; b=iUx18QafVoPzmRMhIeyrpPL0uGiXjYe5Rl72nYD87P4GT4hCk+HELxVRTlk
	hhBjCU4Izo+9ZKxLr7YAKSX3Nu5W/crNcvt99ihSgVrInFFrAWqsXHKAgUMoFYzX
	cYagDdpTDTqqjvUgFk2izkPkGbVThrp78HaphQ04ZrwizweQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id; q=dns; s=sasl; b=DwkXyunGxaHQz3KBOGhRpgI/8mQc2
	ljwpeKvLdl5NfDpkNczd9SpV6dv5w+4nCW6Z1f5qtHDyL+/aBsWR87jA6xRjh31B
	GNdFya3a7bsMeoP3m2RhyArSpd3M8yOwpFqUlX0hxe0HffVjAnVZr9rIccDxXEPr
	5kNnUjn81HWBJc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 76AD44DF0
	for <git@vger.kernel.org>; Sun,  8 May 2011 04:49:41 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 087B84DEF for
 <git@vger.kernel.org>; Sun,  8 May 2011 04:49:40 -0400 (EDT)
X-Mailer: git-send-email 1.7.5.1.268.gce5bd
X-Pobox-Relay-ID: 1D1F019E-7950-11E0-A532-90BEB0B5FC3A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173083>

This is merely a POC, hoping that interested parties might fill in the
blanks aka update the NEEDSWORK part of the patch.

Junio C Hamano (3):
  index_fd(): turn write_object and format_check arguments into one flag
  index_fd(): split into two helper functions
  Bigfile: teach "git add" to send a large file straight to a pack

 builtin/hash-object.c  |    5 +-
 builtin/update-index.c |    3 +-
 cache.h                |    7 ++-
 notes-merge.c          |    2 +-
 read-cache.c           |    4 +-
 sha1_file.c            |  165 +++++++++++++++++++++++++++++++++++++++++-------
 t/t1050-large.sh       |   22 +++++++
 7 files changed, 177 insertions(+), 31 deletions(-)
 create mode 100755 t/t1050-large.sh

-- 
1.7.5.1.268.gce5bd
