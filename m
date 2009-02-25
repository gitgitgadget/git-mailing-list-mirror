From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add tests for git log --pretty, --format and --oneline.
Date: Wed, 25 Feb 2009 01:54:30 -0800
Message-ID: <7vtz6i4zah.fsf@gitster.siamese.dyndns.org>
References: <7vljrvhh13.fsf@gitster.siamese.dyndns.org>
 <1235509597-18336-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nanako Shiraishi <nanako3@lavabit.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 25 10:56:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcGV3-0002VW-PE
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 10:56:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758323AbZBYJyj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2009 04:54:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757755AbZBYJyi
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 04:54:38 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:32777 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757532AbZBYJyh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2009 04:54:37 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id E681C16DD;
	Thu, 26 Feb 2009 04:54:34 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 2D12116DB; Thu,
 26 Feb 2009 04:54:31 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 78F2DAD6-03EB-11DE-AD54-8D02133F2F75-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111431>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> More specifically; --pretty=format, tformat and new %foo shortcut.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  t/t4202-log.sh |   40 ++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 40 insertions(+), 0 deletions(-)

Because 4202 seems to be about testing the log functionality and they rely
on correctly working format output to verify other aspects of the
operation of "git log", I initially was not sure if this is the right
place to add these new tests.  After looking around I didn't find any
existing test that checks the various --pretty output formats that the new
tests can be added, so this probably is as good a place as any.

> diff --git a/t/t4202-log.sh b/t/t4202-log.sh
> index 7b976ee..f1287fe 100755
> --- a/t/t4202-log.sh
> +++ b/t/t4202-log.sh
> @@ -37,6 +37,46 @@ test_expect_success setup '
>  
>  '
>  
> +echo -ne "sixth\nfifth\nfourth\nthird\nsecond\ninitial" > expect
> +test_expect_success 'pretty' '
> +
> +	git log --pretty="format:%s" > actual &&
> +	test_cmp expect actual
> +'
> +
> +echo -ne "sixth\nfifth\nfourth\nthird\nsecond\ninitial\n" > expect

We avoid "echo -e" to cater to people whose echo does not like it and
instead use printf for things like this.

Other than that, the patch looked Ok.  I queued it with a minor fixup.

Thanks.
