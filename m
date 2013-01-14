From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] am: invoke perl's strftime in C locale
Date: Mon, 14 Jan 2013 13:49:06 -0800
Message-ID: <7vr4ln8mgd.fsf@alter.siamese.dyndns.org>
References: <20130114205933.GA25947@altlinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Dmitry V. Levin" <ldv@altlinux.org>
X-From: git-owner@vger.kernel.org Mon Jan 14 22:49:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuruN-0004Qt-Kp
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jan 2013 22:49:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759021Ab3ANVtL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2013 16:49:11 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61081 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757580Ab3ANVtJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2013 16:49:09 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2232AB4A1;
	Mon, 14 Jan 2013 16:49:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/2dfKKBxhpK8iYeW+gJScYw98gc=; b=OC5lz8
	B3yoV9MV9LWbvT7whK0LXnUX0XqwZdetZOjfei8MN9v5jsL8+Fcg0KM5vZK31fQr
	JbF84fQGhtO32NSUjFSUsRlZdsVFQ4TdYyxhZ25k7vusUebbHl+asubaVCDrBpF7
	7djlxyyX4Ynog1qeT+MuiSZdkWZxyYjAggn1I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ezYbGVY5tHA//AiFtJky3Ibi894qlKFV
	mHWTzVoaH3gbEKi1Rij/Ud6Pjcr1nj1woGP406iRu6Qc+yczcLHXWxuRb0VL06lw
	TT2XeE1ZagC0sUtTCUoQdEyuwOZfxn0MJfVsAy8CZ/KsazvVzG2YzP/8reMm+fYq
	QpZYXBw7fR4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 169F2B4A0;
	Mon, 14 Jan 2013 16:49:09 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 85463B49D; Mon, 14 Jan 2013
 16:49:08 -0500 (EST)
In-Reply-To: <20130114205933.GA25947@altlinux.org> (Dmitry V. Levin's message
 of "Tue, 15 Jan 2013 00:59:33 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3963A262-5E94-11E2-B624-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213534>

"Dmitry V. Levin" <ldv@altlinux.org> writes:

> This fixes "hg" patch format support for locales other than C and en_*,
> see https://bugzilla.altlinux.org/show_bug.cgi?id=28248
>
> Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
> ---

Thanks.

The reference URL is not very friendly, and you should be able to
state it here on a single line in English instead, I think.

The patch looks correct, though.

>  git-am.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/git-am.sh b/git-am.sh
> index c682d34..64b88e4 100755
> --- a/git-am.sh
> +++ b/git-am.sh
> @@ -334,7 +334,7 @@ split_patches () {
>  			# Since we cannot guarantee that the commit message is in
>  			# git-friendly format, we put no Subject: line and just consume
>  			# all of the message as the body
> -			perl -M'POSIX qw(strftime)' -ne 'BEGIN { $subject = 0 }
> +			LC_ALL=C perl -M'POSIX qw(strftime)' -ne 'BEGIN { $subject = 0 }
>  				if ($subject) { print ; }
>  				elsif (/^\# User /) { s/\# User/From:/ ; print ; }
>  				elsif (/^\# Date /) {
