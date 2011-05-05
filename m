From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix test t3701-add-interactive.sh
Date: Thu, 05 May 2011 11:27:17 -0700
Message-ID: <7vzkn16m0q.fsf@alter.siamese.dyndns.org>
References: <20110505165029.GD31229@camk.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kacper Kornet <draenog@pld-linux.org>
X-From: git-owner@vger.kernel.org Thu May 05 20:27:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QI3H5-0000gA-GG
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 20:27:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755704Ab1EES10 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2011 14:27:26 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:58474 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755217Ab1EES1Z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2011 14:27:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1833B40C7;
	Thu,  5 May 2011 14:29:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mtvLBewQvn8OjjgFKB5IMOdziYE=; b=s1Ulfa
	pGRTq1IkHK3FEwqVKzIvazPxuqKKEspp+4qkkPGWFm/ynQxadCWvD0qzE962QLac
	mPM+b1Q/c8hrFQdzW6eDR6B2plgcdSnM/FU1Kn+n2+cpprj7v27QBd1ekabH6HqT
	DbGtrLEx7oxghLzv69ivWhN82AwVGAWVl8kbA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PhVl7ZWgTQiNP9kqD+oXsPecpiyYOnjJ
	m3CcbtqnrL/jC9YgQvyAllfLEpzhBIwxLxOcnRY9qYukzDcBvL3iB7U6ID5OFK7x
	Do+oRLUKDcxeQksOh7HXy8BNEdWM3amCxFZhZilMBnDMq2X3LXtel7MwAh/D1KIq
	uWG7P4QkANg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E950E40C6;
	Thu,  5 May 2011 14:29:26 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id C8CD440C3; Thu,  5 May 2011
 14:29:23 -0400 (EDT)
In-Reply-To: <20110505165029.GD31229@camk.edu.pl> (Kacper Kornet's message of
 "Thu, 5 May 2011 18:50:29 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9B9B7942-7745-11E0-BAE3-90BEB0B5FC3A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172866>

Kacper Kornet <draenog@pld-linux.org> writes:

> One of the tests used to fail due to EOF not in the first column and not
> continued &&.
>
> Signed-off-by: Kacper Kornet <draenog@pld-linux.org>
> ---
>  t/t3701-add-interactive.sh |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
> index d6327e7..018f5d9 100755
> --- a/t/t3701-add-interactive.sh
> +++ b/t/t3701-add-interactive.sh
> @@ -83,9 +83,9 @@ EOF
>  
>  test_expect_success PERL 'setup fake editor' '
>  	cat >fake_editor.sh <<EOF
> -	EOF
> +EOF
>  	chmod a+x fake_editor.sh &&
> -	test_set_editor "$(pwd)/fake_editor.sh" &&
> +	test_set_editor "$(pwd)/fake_editor.sh"
>  '

Very curious. I never saw the breakage.  We are getting:

./test-lib.sh: line 450: warning: here-document at line 447 delimited by
end-of-file (wanted `EOF')

Well spotted.  Thanks.
