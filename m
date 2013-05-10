From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] t4300 (rebase): don't unnecessarily set GIT_TRACE
Date: Fri, 10 May 2013 07:38:00 -0700
Message-ID: <7vmws2529j.fsf@alter.siamese.dyndns.org>
References: <1368196178-5807-1-git-send-email-artagnon@gmail.com>
	<1368196178-5807-5-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 10 16:38:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaoSZ-0004as-GO
	for gcvg-git-2@plane.gmane.org; Fri, 10 May 2013 16:38:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757064Ab3EJOiG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 May 2013 10:38:06 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35787 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757140Ab3EJOiC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 May 2013 10:38:02 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3FC8F1B4DE;
	Fri, 10 May 2013 14:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iPUb7leKF0MpSc6LGYjCmJr1S/4=; b=NXWY6x
	kkVb8COL3R2JH9IHaijBQ+TqpYNxsYg8ooJQcPEEux1+2s7lTtP/tSQn6+t3MwaX
	7O0AIO+cqFpaaDeZdrST6oItvsv/bawsXUsg9GTSm7joZP5W+W7M4uYEBA5NUxDQ
	0SRSTsX7B2IXSlSx2fql+xyPTlIZd02pAltmA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UcGkOB6jygsk1OriKwglyBs+ZBcgFLpi
	CVnHJsXXMUf/qGsoo1sXpE4xIEYtVn89Kb2+Zsm70v+qUi8GjAvo7NF/z131hjgm
	9egF4bZyLlpI0i2jBgt1iYJWnJ0xbsjogUuUVk3myZjq72XHzsnALvpcJwV5pca2
	+MdJZ9gqBgQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 36F4C1B4DD;
	Fri, 10 May 2013 14:38:02 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8CD181B4DB;
	Fri, 10 May 2013 14:38:01 +0000 (UTC)
In-Reply-To: <1368196178-5807-5-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Fri, 10 May 2013 19:59:38 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 37648116-B97F-11E2-B39B-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223855>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> A couple of tests execute 'git rebase' with GIT_TRACE set to 1, but
> this trace output is not used anywhere.

Isn't it shown in "t4300-*.sh -v" output to help the debugger?

> relevant to what we are testing.
>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  t/t3400-rebase.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
> index 0841a12..d0d9442 100755
> --- a/t/t3400-rebase.sh
> +++ b/t/t3400-rebase.sh
> @@ -137,13 +137,13 @@ test_expect_success 'rebase a single mode change' '
>  	test_chmod +x A &&
>  	test_tick &&
>  	git commit -m modechange &&
> -	GIT_TRACE=1 git rebase master
> +	git rebase master
>  '
>  
>  test_expect_success 'rebase is not broken by diff.renames' '
>  	test_config diff.renames copies &&
>  	git checkout filemove &&
> -	GIT_TRACE=1 git rebase force-3way
> +	git rebase force-3way
>  '
>  
>  test_expect_success 'setup: recover' '
