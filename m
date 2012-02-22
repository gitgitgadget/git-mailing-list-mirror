From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug report: "git-merge --ff" should fail if branches have
 diverged
Date: Wed, 22 Feb 2012 14:14:24 -0800
Message-ID: <7vr4xm8qin.fsf@alter.siamese.dyndns.org>
References: <DB0837FD-0963-4BF9-BD7B-B243F580CC1C@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Sean Gies <Sean.Gies@imgtec.com>
X-From: git-owner@vger.kernel.org Wed Feb 22 23:14:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0KSG-0000aX-54
	for gcvg-git-2@plane.gmane.org; Wed, 22 Feb 2012 23:14:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755836Ab2BVWO1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Feb 2012 17:14:27 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65402 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753817Ab2BVWO1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Feb 2012 17:14:27 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 94751615C;
	Wed, 22 Feb 2012 17:14:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HdClzMtA9wGxqBv+cMJMQghoi9E=; b=EoekSl
	VImZuZxXDlMEEevpyhkb0JrmSfDn+KhulaLjAumpWwqOCBPY7Zc6GA/MgVSkcRkn
	N9reSJ9gWiM7vML4+aCVtyOkskOj9+94DYmnxTuBWwr6dSERaGR9qQ59hUc9e6hB
	biWZw9naJXAwJDAX2POAfHmmchaJkOQ5wzZrQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Traj0Mm9T2T0oVg26MpW9RtVVwOWW+Y2
	spebSQrI2MzEO2kMdub464w88v5bqvrRB+kJUzcBDtjqoCnIqE2wdwlxHa3Fblpj
	oXOPQZ7vQMgFMuaw1DH59WUVkuqWfgJhn7Mlt2qm4vafm1eksCaaGOESecUT4yqA
	H+m7qCrxSJQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 857BC615B;
	Wed, 22 Feb 2012 17:14:26 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F1B706159; Wed, 22 Feb 2012
 17:14:25 -0500 (EST)
In-Reply-To: <DB0837FD-0963-4BF9-BD7B-B243F580CC1C@imgtec.com> (Sean Gies's
 message of "Wed, 22 Feb 2012 21:51:05 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 94C7857C-5DA2-11E1-A39A-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191299>

Sean Gies <Sean.Gies@imgtec.com> writes:

> When I specify the "--ff" option to git-merge, I expect it to perform a
> fast-forward merge or none at all.

That expectation needs to be adjusted with s/--ff/--ff-only/, I think.

The "--no-ff" option says "Never do fast-forward and always create extra
commit even when the side branch is a descendant", and the "--ff" option
is a way to countermand it, i.e. "It is ok to fast-forward this merge".

And there is another one "I do not want anything bug fast forward", and
that is spelled --ff-only.
