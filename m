From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Suggestion: rebase [--onto <newbase>] [<upstream>][..[<branch>]]
Date: Tue, 17 Jan 2012 12:17:21 -0800
Message-ID: <7vr4yyqe26.fsf@alter.siamese.dyndns.org>
References: <hbf.20120117gdfh@bombur.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Hallvard Breien Furuseth <h.b.furuseth@usit.uio.no>
X-From: git-owner@vger.kernel.org Tue Jan 17 21:17:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RnFTE-000570-S8
	for gcvg-git-2@lo.gmane.org; Tue, 17 Jan 2012 21:17:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755653Ab2AQURY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jan 2012 15:17:24 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63973 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753028Ab2AQURX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jan 2012 15:17:23 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3442777FE;
	Tue, 17 Jan 2012 15:17:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RMThQVbijp10POl9Y1VnC3xotMk=; b=hFnldc
	deozoJxj3vOtrAtB2Mi2i8L2wx1eC9IOzWtGZNUMeexnifyxFa0sDCKT/955WQLS
	CqWMLSqYFtdP/61cp/mzkTwwD+/DWbRIwxhX4gX2LtAbS88puTMIpWu8SaTc8+pt
	o/zCFQp6gABKrriGtWwRUQRK1zQtTwOAzQNxM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aoLULAzPu1PSq5qjdGivcbIWMJwMFQZF
	DROSAhOKmU5gNp5dbRXncrctXsb2qnzZyZhjJ0TSbTHDZV0iK07UGHtDRlMBdUOH
	TmvPvRoVWxT9Kxnn9t19NKBARUMUUCgn7rUDFK/Rpb4F0K3ko0BiiHNYb25BGq+9
	fq4DwpXX8Cw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2BDBF77FD;
	Tue, 17 Jan 2012 15:17:23 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B7AC877FC; Tue, 17 Jan 2012
 15:17:22 -0500 (EST)
In-Reply-To: <hbf.20120117gdfh@bombur.uio.no> (Hallvard Breien Furuseth's
 message of "Tue, 17 Jan 2012 17:44:29 +0100 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 43BB6476-4148-11E1-B5E4-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188720>

Hallvard Breien Furuseth <h.b.furuseth@usit.uio.no> writes:

> I think
> 	git rebase [--onto <newbase>] [<upstream>][..[<branch>]]
> would be a more readable syntax for what rebase is doing.  Easier
> to see which argument means what without staring at the manpage.
> "..[<branch>]" without <upstream> implies --root.

I do not offhand see a huge issue if you come up with a patch that allows
users to additionally say:

    $ git rebase upstream..topic
    $ git rebase --onto there upstream..topic

what they express with

    $ git rebase upstream topic
    $ git rebase --onto there upstream topic

today.

However, "git rebase ..topic" to mean "everything down to root from topic"
is not OK; lack of one side in dotted range defaults to HEAD everywhere
else and such a change will introduce a huge discrepancy.
