From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] commit: add a commit.verbose config variable
Date: Thu, 10 Mar 2016 14:52:08 -0800
Message-ID: <xmqq60wuc5ev.fsf@gitster.mtv.corp.google.com>
References: <0102015362963f6a-626ad27e-e705-4a75-93a6-55a5f75d0226-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 10 23:52:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ae9RI-0003Pu-05
	for gcvg-git-2@plane.gmane.org; Thu, 10 Mar 2016 23:52:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932357AbcCJWwN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2016 17:52:13 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:64476 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932089AbcCJWwL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Mar 2016 17:52:11 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CF9EE4BF80;
	Thu, 10 Mar 2016 17:52:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/+SjPnnB76L3T9/P2QCWEnmLaiA=; b=QPOVl6
	7Ro67nCR4nRG2+7QKmksw4k9J2juBhY+fG/KGwWHtzKK9oJsHypx4LT5wsCL6eJR
	V3BeiLyTqawNVmnMOVaPJ2wFXRaCNpRK1tCvhMI5cF/kG3Z7W0K0yddQo8DiRdOD
	TGNxI47FfTcbpMI2FctoGDWbhDKzCCrVGAFZE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Tq5KS9OGm902ii7CR/tsPEhUB3QH2AT6
	aOe1BYTSa3Y7DP1uz2dgbjZPMTMv2xliUzMms3cwBcHU1Pcr5HlVHmQlljmg9dX4
	VU6t4okmE/OSn78IuaQoqU/6VOfqRFdNuGWwEcQOQxSieWz6ISVhu9mkL5uVkuY4
	QASICnRZgTs=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C62004BF7F;
	Thu, 10 Mar 2016 17:52:09 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 3CD8F4BF7E;
	Thu, 10 Mar 2016 17:52:09 -0500 (EST)
In-Reply-To: <0102015362963f6a-626ad27e-e705-4a75-93a6-55a5f75d0226-000000@eu-west-1.amazonses.com>
	(Pranit Bauva's message of "Thu, 10 Mar 2016 22:12:07 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B854BF48-E712-11E5-83CA-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288657>

Pranit Bauva <pranit.bauva@gmail.com> writes:

> +	if (!strcmp(k, "commit.verbose")){

v3 did this line correctly but you somehow lost the SP between
"){".  What happened?

> diff --git a/t/t7507-commit-verbose.sh b/t/t7507-commit-verbose.sh
> index 2ddf28c..4e123a5 100755
> --- a/t/t7507-commit-verbose.sh
> +++ b/t/t7507-commit-verbose.sh
> @@ -96,4 +96,52 @@ test_expect_success 'verbose diff is stripped out with set core.commentChar' '
>  	test_i18ngrep "Aborting commit due to empty commit message." err
>  '
>  
> +test_expect_success 'commit with commit.verbose true and no arguments' '
> +test_expect_success 'commit with commit.verbose true and --no-verbose' '
> +test_expect_success 'commit with commit.verbose false and -v' '
> +test_expect_success 'commit with commit.verbose false no arguments' '

Don't you need a test that status is not broken when the variable is
set?
