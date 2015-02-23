From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Feb 2015, #06; Sun, 22)
Date: Mon, 23 Feb 2015 11:00:21 -0800
Message-ID: <xmqqk2z8tpve.fsf@gitster.dls.corp.google.com>
References: <xmqqk2z9vd38.fsf@gitster.dls.corp.google.com>
	<54EB30F0.4010404@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Feb 23 20:01:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YPyFb-0007ml-CO
	for gcvg-git-2@plane.gmane.org; Mon, 23 Feb 2015 20:01:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753219AbbBWTAx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2015 14:00:53 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50722 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753077AbbBWTAu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2015 14:00:50 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9D5CF3901F;
	Mon, 23 Feb 2015 14:00:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BcvZo2KYFMWU6s9i9BXqxfWqLRk=; b=hI6uXQ
	/Xeg9gr4pUIZYHBIk6plzOoOgdgrjmaJzT7F6O8wLwabXVxhljfJBG09sX3nPmMj
	Pk+Eu89NVhJw+Zwi06qogs492f7kJPsBOfYGtRKLUroE7BQJmkbMmCVzyFar1bm/
	iw2oKjq90oBxyyUAfQSL4ry8XMrQ84Hhu45zQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OIY6TYJ7reSNYhijgloGZvVGriBQlhqH
	SnQaC6RXjD13WaEMvLk79iORh82wZACSD1UIJDJKafK1JdOpiNzUhvNEP9TD/9ZY
	5rui6pvHbR5Tx1GGy3E+BUs3W1j1Bf1/2tiY3iJqOa46z2V4XqrwcT5YkvbPc8gk
	7Q0c2IYaDjs=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 947043901E;
	Mon, 23 Feb 2015 14:00:49 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 81C1A3900A;
	Mon, 23 Feb 2015 14:00:22 -0500 (EST)
In-Reply-To: <54EB30F0.4010404@drmicha.warpmail.net> (Michael J. Gruber's
	message of "Mon, 23 Feb 2015 14:53:52 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 37E48498-BB8E-11E4-9ADE-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264285>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> status, status -s and the like are in an ordinary user's tool box.
> ls-files isn't, at least not with "-t", which we even mark as deprecated.
>
> That makes me wonder, though, how difficult it would be to
> wt_status_collect_unchanged() and to leverage the status machinery
> rather than ls-files.

Good point.  wt-status feels like a much better infrastructure to
build on than "ls-files -t", which should die ;-).  Especially if
the command is interested in showing the state of the working tree
files relative to the tree of HEAD, as "ls-files" is purely between
the index and the working tree.
