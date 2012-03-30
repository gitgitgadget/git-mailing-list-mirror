From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] git-rebase: add keep_empty flag
Date: Fri, 30 Mar 2012 13:43:22 -0700
Message-ID: <7vhax5lt05.fsf@alter.siamese.dyndns.org>
References: <1333136922-12872-1-git-send-email-nhorman@tuxdriver.com>
 <1333136922-12872-3-git-send-email-nhorman@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Phil Hord <phil.hord@gmail.com>
To: Neil Horman <nhorman@tuxdriver.com>
X-From: git-owner@vger.kernel.org Fri Mar 30 22:43:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDifV-00068c-IM
	for gcvg-git-2@plane.gmane.org; Fri, 30 Mar 2012 22:43:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934590Ab2C3Un0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Mar 2012 16:43:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48540 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934521Ab2C3UnY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2012 16:43:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0A80D4116;
	Fri, 30 Mar 2012 16:43:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hC7c+n58uKxGDk6TkgNmQt3g4+0=; b=FqvFj0
	ko9S662HpN2pvDqHF0IP0q6OY2Lplv3KHR0jUoN6CK9WfGsHLQ47vlA++ODSJ9p/
	4HWPCx3k4gmueUYhXup2C1ONo4gUbju1PIUXboVVxVw7KR/mxQguq+1diUCL4ExT
	u+mr5r3CaeoLABr41qZEGCP9X37SIzj9Ly/NU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LluNo17TcTiDyBdBbd//1MMu37+zBdBz
	QNhyWh0hYdaARxITpQnyZrhcdzOUhYtgm3rGwRd7mNat+xYymkrAm0zYTaPBVNlb
	Bl1GYOw6+zF1xU6sWEwXJo/xrlf2Xtmhiz6+cMegJFjsIk1I2uSSkyQUv9wfBlhO
	9NSE6zNAdqA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F40ED4115;
	Fri, 30 Mar 2012 16:43:23 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 58D314114; Fri, 30 Mar 2012
 16:43:23 -0400 (EDT)
In-Reply-To: <1333136922-12872-3-git-send-email-nhorman@tuxdriver.com> (Neil
 Horman's message of "Fri, 30 Mar 2012 15:48:40 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FE15A9A0-7AA8-11E1-869C-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194405>

Neil Horman <nhorman@tuxdriver.com> writes:

> Add a command line switch to git-rebase to allow a user the ability to specify
> that they want to keep any commits in a series that are empty.
>
> Signed-off-by: Neil Horman <nhorman@tuxdriver.com>
> CC: Jeff King <peff@peff.net>
> CC: Phil Hord <phil.hord@gmail.com>
> CC: Junio C Hamano <gitster@pobox.com>

The same comments on Cc: apply to all of your patches.

>  Documentation/git-rebase.txt |    6 ++++++
>  git-rebase.sh                |    5 +++++
>  2 files changed, 11 insertions(+), 0 deletions(-)
>
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index 504945c..9717d3e 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -238,6 +238,12 @@ leave out at most one of A and B, in which case it defaults to HEAD.
>  	will be reset to where it was when the rebase operation was
>  	started.
>  
> +--keep-empty::
> +	Informs git-rebase that comits which are empty should not be
> +	automatically removed.  This is at times useful when empty commits
> +	are used to hold developer information and notes, but contain no real
> +	code changes
> +

Unlike "cherry-pick", I think "--keep-empty" is a better name for the
option than "--allow-empty" in this context.  The difference is that from
the end-user's point of view, cherry-pick _replays_ commits that exist
elsewhere, and you are allowing the command to replay empty ones as well,
while rebase _rebuilds_ commits on the same branch, and you are telling
the command to keep empty ones.

"... which are empty should not be removed" is a bit of double-negation,
though.  Perhaps

	--keep-empty::
		Keep the commits that do not change anything from its
		parents in the result.  This is at times useful when empty
		commits are used to hold developer information and notes
		without having any real changes.

But as I rephrased the first part, the last line may have become redundant
and could safely be removed.

The patch does not seem to do anything other than accepting and silently
ignoring the option, though.
