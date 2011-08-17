From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/3] Minor "list-objects" updates
Date: Wed, 17 Aug 2011 14:30:32 -0700
Message-ID: <1313616635-25331-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 17 23:31:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QtnhO-00080u-LR
	for gcvg-git-2@lo.gmane.org; Wed, 17 Aug 2011 23:30:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751570Ab1HQVaj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Aug 2011 17:30:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55699 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751643Ab1HQVai (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2011 17:30:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CFF103B0E
	for <git@vger.kernel.org>; Wed, 17 Aug 2011 17:30:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id; s=sasl; bh=8povp30Y8WFRKHznLBVQYFtimSg
	=; b=PLwID1SaHRKSGWOitgUaHF9cpU2/Kgv4ZKbPO2NBFwEt1xrsiHfTz33/XZL
	VYlPbLPnBu2BKK3XYupP89/En58/z1SYkPiz0db1IjUyfx4mlu76tDoaClZNkl7q
	dK0VpGpfm9ZHZKUGmy7DG2mikwvQvG1aW80X4lcvA3Q7R+QA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id; q=dns; s=sasl; b=yMR+SYCkHt2962NQb90EAiKu0hLUC
	dIOTnrrjLv7B+T3OOgCuI5Id8i4zlPdJmFi05w6Go6gNUgpqxk8b4wV/MPaPLHH+
	qSjmhyW6K/2E4qOkVsO13qPhvYiRUxGRKA5VGIjZyo+3BiWQU3GHU+9eaFwCMX/g
	a8UyicS+Jqe+uA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C7A7B3B0D
	for <git@vger.kernel.org>; Wed, 17 Aug 2011 17:30:37 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0D47B3B0C for
 <git@vger.kernel.org>; Wed, 17 Aug 2011 17:30:36 -0400 (EDT)
X-Mailer: git-send-email 1.7.6.472.g4bfe7c
X-Pobox-Relay-ID: 25BCD84A-C918-11E0-A7FA-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179540>

Unify two codepaths that list objects in "rev-list --objects" format, and
get rid of unnecessary malloc()/free() done per each line of output.

Junio C Hamano (3):
  rev-list: fix finish_object() call
  revision.c: add show_object_with_name() helper function
  revision.c: update show_object_with_name() without using malloc()

 builtin/rev-list.c |   17 ++---------------
 revision.c         |   41 +++++++++++++++++++++++++++++++++++++++++
 revision.h         |    2 ++
 upload-pack.c      |   15 +--------------
 4 files changed, 46 insertions(+), 29 deletions(-)

-- 
1.7.6.472.g4bfe7c
