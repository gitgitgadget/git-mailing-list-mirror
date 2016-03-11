From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] t/t7502 : drop duplicate test
Date: Fri, 11 Mar 2016 10:39:56 -0800
Message-ID: <xmqqvb4samf7.fsf@gitster.mtv.corp.google.com>
References: <0102015362963f6a-626ad27e-e705-4a75-93a6-55a5f75d0226-000000@eu-west-1.amazonses.com>
	<010201536326c56b-cd751f0b-f03f-4c9f-b834-20cee14b6eb5-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 11 19:40:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aeRyn-0002ZX-CT
	for gcvg-git-2@plane.gmane.org; Fri, 11 Mar 2016 19:40:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750734AbcCKSkA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Mar 2016 13:40:00 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:64299 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750791AbcCKSj7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Mar 2016 13:39:59 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CBA8B4A7F6;
	Fri, 11 Mar 2016 13:39:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=l12pKcus4kpx1wiTbwDsXixbAms=; b=CN9aAr
	9T6W7EDBa1zQOtZEB1PJkgQz6bYYN3Hq2w7hbEm08f6XgCYtpNCuptnMWPhed+VQ
	s4O4maGJr1RpT+GAVA07u4Tdr7rqNtCATZv/mUPPUgtLcAulgqjFbDjSaM+9bXzC
	znGptW/fEGZDXEtISklw14c2JRN2TtIHwQX14=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=F/9/A1+Ya0fb8urrwCXeYcxQ+mg5zG0q
	bGxXax4xXx7mhoCfKDpJQ3XNX9GOb7UsqOLIytPx8MazcCuLEjXi1ZC7N2WAGas7
	MBCaLAVmkvQW7N5RaFT7ivdRPAcb7iYn4Squfyb2+J1FyOSpPzdiNq1Kqm3RRWFx
	OcsCES/O+18=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C37914A7F5;
	Fri, 11 Mar 2016 13:39:57 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 3B8CD4A7F4;
	Fri, 11 Mar 2016 13:39:57 -0500 (EST)
In-Reply-To: <010201536326c56b-cd751f0b-f03f-4c9f-b834-20cee14b6eb5-000000@eu-west-1.amazonses.com>
	(Pranit Bauva's message of "Fri, 11 Mar 2016 00:49:58 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A75D4CB8-E7B8-11E5-B94C-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288697>

Pranit Bauva <pranit.bauva@gmail.com> writes:

> This extra test was introduced erroneously by
> f9c0181 (t7502: test commit.status, --status and
> --no-status, 2010-01-13)
>
> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
> ---

Thanks.  I briefly thought that this might be checking that doing
this twice would give different results, but that is not what is
happening.  Also the remainder of this does cover all the
combinations, so we are OK after applying this patch.

Thanks, will queue.

>  t/t7502-commit.sh | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/t/t7502-commit.sh b/t/t7502-commit.sh
> index b39e313..725687d 100755
> --- a/t/t7502-commit.sh
> +++ b/t/t7502-commit.sh
> @@ -527,11 +527,6 @@ try_commit_status_combo () {
>  		test_i18ngrep "^# Changes to be committed:" .git/COMMIT_EDITMSG
>  	'
>  
> -	test_expect_success 'commit' '
> -		try_commit "" &&
> -		test_i18ngrep "^# Changes to be committed:" .git/COMMIT_EDITMSG
> -	'
> -
>  	test_expect_success 'commit --status' '
>  		try_commit --status &&
>  		test_i18ngrep "^# Changes to be committed:" .git/COMMIT_EDITMSG
>
> --
> https://github.com/git/git/pull/208
