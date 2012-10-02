From: Junio C Hamano <gitster@pobox.com>
Subject: Re: erratic behavior commit --allow-empty
Date: Tue, 02 Oct 2012 10:27:02 -0700
Message-ID: <7vzk449449.fsf@alter.siamese.dyndns.org>
References: <CAB9Jk9BynCunFHRFhGKoyDA-qof1iu6w952sAgSs2_JWb8+U3A@mail.gmail.com>
 <506AA51E.9010209@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Angelo Borsotti <angelo.borsotti@gmail.com>,
	git <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Oct 02 19:27:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJ6Fe-0002nf-BR
	for gcvg-git-2@plane.gmane.org; Tue, 02 Oct 2012 19:27:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752935Ab2JBR1H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2012 13:27:07 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41306 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751730Ab2JBR1F (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2012 13:27:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8CAC582DB;
	Tue,  2 Oct 2012 13:27:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2/yna52rpzkvf0auIYUhxB+4u3s=; b=wTuvny
	QK/jvTURjRgOIt0uRJYOVhcqx02Kc0df2nnwnSZQ/zQcf0hYB8p7F4D/Y1tS6LaV
	ys4FZsMx/Qu77uuHrt1r1Yw876mryJCuTdTz9quLFaWHEJp3N01454w28cImxsd8
	uGe/GqcCNAwYjfZCdZM9Aj+VpNo44oewoNNX4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Se1omDnUNLXjw5oQECDUn6rfk4nXCRD2
	zhrowcWer4tnqY/HbS4gzXAvK6FqWT7eJ5hrWND3rIHHsrJOtHrQMSJPlzwCcckq
	HC5WuMvS96W9YYW078/pFiZEYT1wNAxh0rAVNJ6JBdOzFrWg5Vqmnz8xsqprEtja
	yVkwx5lOEUo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7661282DA;
	Tue,  2 Oct 2012 13:27:04 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E789682D9; Tue,  2 Oct 2012
 13:27:03 -0400 (EDT)
In-Reply-To: <506AA51E.9010209@viscovery.net> (Johannes Sixt's message of
 "Tue, 02 Oct 2012 10:26:06 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 61D66B1A-0CB6-11E2-B811-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206826>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Note that git commit -m A --allow-empty *DID* create a commit. Only, that
> it received the same name (SHA1) as the commit you created before it
> because it had the exact same contents (files, parents, author, committer,
> and timestamps). Obviously, your script was executed sufficiently fast
> that the two commits happend in the same second.

Correct.

And this does not have anything to do with --allow-empty.  You can
"reset --soft HEAD^" immediately after committing a change and redo
it to get the same effect.  If you commit the same state with the
same history with the same message as the same person at the same
time, you will reliably get the same commit object.

And that is fundamental property called reproducibility.  There is
nothing to be alarmed by this exercise.
