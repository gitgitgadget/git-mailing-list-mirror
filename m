From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/2] Getopt::Long workaround in send-email
Date: Fri, 13 Feb 2015 12:19:27 -0800
Message-ID: <1423858769-1565-1-git-send-email-gitster@pobox.com>
References: <xmqq8ug2pvw7.fsf@gitster.dls.corp.google.com>
Cc: Brandon Casey <drafnel@gmail.com>,
	"Tom G. Christensen" <tgc@statsbiblioteket.dk>,
	"Kyle J. McKay" <mackyle@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 13 21:19:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YMMiB-00033M-3G
	for gcvg-git-2@plane.gmane.org; Fri, 13 Feb 2015 21:19:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753192AbbBMUTd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2015 15:19:33 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:60253 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752924AbbBMUTd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2015 15:19:33 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5DD3A248BB;
	Fri, 13 Feb 2015 15:19:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=qKUG
	QHhz1y32uJT7TWqERXDfXoU=; b=vyAZhpNTmBnqRoyR1/agiVm9/nUjwxMLNBYU
	HLL8xFIwZI7p6jnMtarrAyz+CK/XuoDZafFt4PY5AnvtWUqf8v0+KdgVK53v8zmA
	/RBlc1uFsoOa88eltrxb6sKxNYN7xoRcsy9mxA9NuHFYM4AL+cvmVNPupluMsPDI
	4YizZBw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	x+RCFeB37ArU45hItYp3aI9IgfU3eYp+YC4rBVwmoO8UTHCWutLiG3l+bHV9TN2o
	YJfeS7BknapFlssJjgoXeJ38gih5ki3ynYmEkEnGhPWZ1WSArXTPme3WBKHXW3SO
	aRo0lU8tPFmYmghqlzD53Hb6VEHTkQVM+SygN76LP3U=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 54044248BA;
	Fri, 13 Feb 2015 15:19:32 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D1E69248B7;
	Fri, 13 Feb 2015 15:19:30 -0500 (EST)
X-Mailer: git-send-email 2.3.0-191-geb1a277
In-Reply-To: <xmqq8ug2pvw7.fsf@gitster.dls.corp.google.com>
X-Pobox-Relay-ID: 9E94DE64-B3BD-11E4-AC2B-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263829>

The first one is a replay of Kyle's workaround for older versions of
Getopt::Long that did not take "--no-option" to negate a boolean
option "--option".  The second one revert the workarounds made to
the test script over time, and should break if the first one does
not work well for older Getopt::Long (I have no reason to suspect it
would break, though).

I am inclined to squash these into one commit before starting to
merge them down to 'next' and then to 'master', after getting
Tested-by: from those with older Getopt::Long (prior to 2.32).

Obviously, tc/t9001-noxmailer topic will become unnecessary and be
dropped when that happens.

Thanks.

Junio C Hamano (1):
  SQUASH??? t9001: turn --no$option workarounds to --no-$option

Kyle J. McKay (1):
  git-send-email.perl: support no- prefix with older GetOptions

 git-send-email.perl   | 10 ++++++++++
 t/t9001-send-email.sh | 10 +++++-----
 2 files changed, 15 insertions(+), 5 deletions(-)

-- 
2.3.0-191-geb1a277
