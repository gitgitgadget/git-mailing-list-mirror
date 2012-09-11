From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] describe: document and test --first-parent
Date: Tue, 11 Sep 2012 10:20:45 -0700
Message-ID: <7vy5kgh3wy.fsf@alter.siamese.dyndns.org>
References: <cover.1347370970.git.git@drmicha.warpmail.net>
 <a0f0cf4e9cf41577d01d728007250f78e18a9ac0.1347370970.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Sep 11 19:20:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBU8v-0008Dn-Uz
	for gcvg-git-2@plane.gmane.org; Tue, 11 Sep 2012 19:20:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758937Ab2IKRUt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Sep 2012 13:20:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55400 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757516Ab2IKRUs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Sep 2012 13:20:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BC8D384F0;
	Tue, 11 Sep 2012 13:20:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4nHNqutzfRd21NEJZkZ1x8I2hSQ=; b=Nz+u72
	rlCjxRDvLIrRzDxcBhtAGOLRwCIDcKhQtGZB4wPKa+8oQbqBhbxpgNLpbUzLsRwZ
	lyKuruLKtAVHcMn/SrYmDBdzwoKkKuklZMgntUNJSQs19YHwa7zKXqS7oNIL26to
	UAAdQb/Z43x0a5VeKaoZ1+22labRY/PHgBYTM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fUzBH7CJ0gUd/q12nKjaIywECoD2k7pK
	H4Bz8pl2S+yaIkwjVX2yYtrzWrvrFpSdq+71GvQbYtJ3g61z9GPVNE5957hWn2vp
	6ETwH/BR3YksstyuEyDuZHfsim4wW6WsQgt3ZAIY7VqoyuV5rPfvLE1v/JThYfOb
	SbF3vhN7YFg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A89D084EE;
	Tue, 11 Sep 2012 13:20:47 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0F84684EC; Tue, 11 Sep 2012
 13:20:46 -0400 (EDT)
In-Reply-To: <a0f0cf4e9cf41577d01d728007250f78e18a9ac0.1347370970.git.git@drmicha.warpmail.net> (Michael J. Gruber's message of "Tue, 11 Sep 2012 15:51:52 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0685A168-FC35-11E1-B3F8-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205253>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
>  Documentation/git-describe.txt | 16 +++++++++++++++-
>  t/t6120-describe.sh            |  7 +++++++
>  2 files changed, 22 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git-describe.txt b/Documentation/git-describe.txt
> index 72d6bb6..9fb5c84 100644
> --- a/Documentation/git-describe.txt
> +++ b/Documentation/git-describe.txt
> @@ -84,6 +84,10 @@ OPTIONS
>  	Only consider tags matching the given pattern (can be used to avoid
>  	leaking private tags made from the repository).
>  
> +--first-parent::
> +	Only consider tags which can be reached from '<committish>' by a first
> +	parent walk, i.e. only those which are not on side branches.
> +

[PATCH 1/2] says:

    git describe --contains --first-parent is forbidden because git name-rev
    (which is called by that) favors first-parent transversal already,
    although not strictly so.

but the end-users won't read the log message, so something like that
need to be here, I guess.

But if "name-rev" does more-or-less first-parent anyway, perhaps
simply ignoring --first-parent when doing --contains may make more
sense?
