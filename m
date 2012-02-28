From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/2] "am -3" and "--no-prefix" does not work well
Date: Tue, 28 Feb 2012 15:24:53 -0800
Message-ID: <1330471495-12013-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 29 00:25:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2WQ2-0002CE-VO
	for gcvg-git-2@plane.gmane.org; Wed, 29 Feb 2012 00:25:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757283Ab2B1XY6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Feb 2012 18:24:58 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42734 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754703Ab2B1XY5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Feb 2012 18:24:57 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0F3F07A19
	for <git@vger.kernel.org>; Tue, 28 Feb 2012 18:24:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id; s=sasl; bh=wQEHudckZEO6dgM7tOzjXdX4Tzg
	=; b=I5X8OE6uo20i/CKvcnNoGNOZBHRnhMJ7MLr+Xed6g3DZ/YPxrnZwD7zF2oK
	K7MZBZUJp6NVf6dPLI4Q9oI+XCjfOgFvLBgAnf1mptEHtAS0pg68odgBJNenbyle
	J3QHqyuFnI6eyJZ6i6ebkXIx0gJ+qBVGYH97Svq+ik6HjjVI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id; q=dns; s=sasl; b=fvGcWGUK1NWBPGTrZFBIo2vclWcdj
	4GIcTuUm2O5deDSfLEewnj2byuLWAE43wpfZscBajJqFlr8Lomdb6jL3/dx9z1Et
	59On2Eq2x06jYMGg+pwBu0FqjtmzKo7s2tfUtM1T09fYzL6KfLytEpQZbtfXW1iU
	OgyLxXtV6YJ/KY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 06A387A18
	for <git@vger.kernel.org>; Tue, 28 Feb 2012 18:24:57 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 924747A17 for
 <git@vger.kernel.org>; Tue, 28 Feb 2012 18:24:56 -0500 (EST)
X-Mailer: git-send-email 1.7.9.2.344.g3e8c86
X-Pobox-Relay-ID: 6CE55618-6263-11E1-803A-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191792>

I wrote these a few days ago when I tried to review somebody's patch
on this list that was made with "format-patch --no-prefix".  The regular
patch application without the three-way fallback was prepared to honor a
custom -p<num>, but the code to synthesize the fake ancestor tree forgot
to pay attention to -p<num>, so "am -3 -p0" was failing.

Junio C Hamano (2):
  am -3: allow nonstandard -p<num> option
  test: "am -3" can accept non-standard -p<num>

 git-am.sh     |   11 +++++++----
 t/t4150-am.sh |   15 +++++++++++++++
 2 files changed, 22 insertions(+), 4 deletions(-)

-- 
1.7.9.2.344.g3e8c86
