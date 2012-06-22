From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/3] "log --first-parent --simplify-merges/by-decoration"
Date: Fri, 22 Jun 2012 15:27:37 -0700
Message-ID: <1340404061-11619-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 23 00:27:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SiCKT-0007W8-JN
	for gcvg-git-2@plane.gmane.org; Sat, 23 Jun 2012 00:27:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754304Ab2FVW1o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jun 2012 18:27:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37984 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753246Ab2FVW1n (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jun 2012 18:27:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C8D4A9490
	for <git@vger.kernel.org>; Fri, 22 Jun 2012 18:27:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id; s=sasl; bh=L9ThoCEUjH3KWXcjCFGrfUrfQ0c
	=; b=Fd7VrAuOM2TgtJ2P+Vm/A700WXOCtZDqPha4F6TZy0uHX+edxduZDnZ44xo
	ABNPBFTw1MbpHfr2/StCNqvik87je/sg559FyaVB+MbA09MtYY0CP1AKE6pvskOl
	scUYgjOpSIW5m72+2p0ZO96QG82k3F3fBqzOrGBBm15cl7Og=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id; q=dns; s=sasl; b=x8sB3fONjRRBQEHCorquDZaRD5Sul
	5JVLDNTH+A6Xb8/FU/P6NQgddWqK+eX+PutU9cs73n65ehPp7rTJA5oVg+tHGCA+
	FvBbHVwWOCrWfrs02OfDGkOS+BsBfQSaYKRqBciupYnF0/7cXn569L57llvvvYlD
	JhdxiRjR9CGYko=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C0944948F
	for <git@vger.kernel.org>; Fri, 22 Jun 2012 18:27:42 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 59210948E for
 <git@vger.kernel.org>; Fri, 22 Jun 2012 18:27:42 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.1.29.gf71be5c
X-Pobox-Relay-ID: 7B70153C-BCB9-11E1-A860-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200478>

It is unclear what it means to "simplify-merges" while traversing
only the "first-parent" ancestry chain, but the combination of the
options makes the simplification logic to use in-core commit objects
that haven't been examined for relevance, either producing incorrect
result or taking too long to produce any output.

Teach the simplification logic to ignore commits that the
first-parent traversal logic ignored when both are in effect to work
around the issue.

Junio C Hamano (3):
  revision: "simplify" options imply topo-order sort
  revision: note the lack of free() in simplify_merges()
  revision: ignore side parents while running simplify-merges

 revision.c | 41 +++++++++++++++++++++++++++++------------
 1 file changed, 29 insertions(+), 12 deletions(-)

-- 
1.7.11.1.29.gf71be5c
