From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Use warning function instead of fprintf(stderr,
 "Warning: ...").
Date: Sun, 03 Jan 2010 16:41:36 -0800
Message-ID: <7vljgevgzj.fsf@alter.siamese.dyndns.org>
References: <1262535630-3918-1-git-send-email-tfransosi@gmail.com>
 <20100104091847.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thiago Farina <tfransosi@gmail.com>, gitster@pobox.com,
	git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Mon Jan 04 01:41:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NRb16-0002Dw-CZ
	for gcvg-git-2@lo.gmane.org; Mon, 04 Jan 2010 01:41:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751877Ab0ADAls (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Jan 2010 19:41:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751556Ab0ADAls
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jan 2010 19:41:48 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:49690 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751490Ab0ADAlr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jan 2010 19:41:47 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9BB7A8D1E8;
	Sun,  3 Jan 2010 19:41:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=r5K+P6ivOf623r3n+fIUJcTCKok=; b=VG/xq2
	Nt5Px43+Z+CgSKvxiKbOx8IqDIW6awD72BXzv4/zOy9FQWjrrgxBRHLvuZ4mhSib
	Hn+eDw29iOB0eXOo11kdhdWroZ1FN59Kr0Xy7wX1msN/kUoBcpCszyzw1dcaOLtt
	/9EHsSqT/kDYIk4Z9GvIaGNDzbDIomPHA9xcU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tCMLcvafz10wlHuhZg2u5Wm91Ct08kaV
	5wt1IrQKupr56xF4Qwbso1QGC67yjAft5r34B4Mz2OG8GYmjS1vBZLdSIRtv4+TQ
	WrH9squwEPI0C2QZbtVRt7Cct2m+411Ubj2rzCVQ2ww6qVbTwKCfNJA0kk5wLt/3
	mVgJ+Lexxfw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5F5B58D1E7;
	Sun,  3 Jan 2010 19:41:42 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 813058D1E5; Sun,  3 Jan
 2010 19:41:37 -0500 (EST)
In-Reply-To: <20100104091847.6117@nanako3.lavabit.com> (Nanako Shiraishi's
 message of "Mon\, 04 Jan 2010 09\:18\:47 +0900")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: ED6E263A-F8C9-11DE-AC9F-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136087>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> Quoting Thiago Farina <tfransosi@gmail.com>
>
>> Signed-off-by: Thiago Farina <tfransosi@gmail.com>
>> ---
>> Removed the LF from the end of the strings.
>
> Trying this patch makes t6030-bisect-porcelain.sh fail for me. Was this tested at all?

I noticed it as well; will squash this in.

diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index def397c..c51865f 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -423,7 +423,7 @@ test_expect_success 'skipped merge base when good and bad are siblings' '
 	grep "merge base must be tested" my_bisect_log.txt &&
 	grep $HASH4 my_bisect_log.txt &&
 	git bisect skip > my_bisect_log.txt 2>&1 &&
-	grep "Warning" my_bisect_log.txt &&
+	grep "warning" my_bisect_log.txt &&
 	grep $SIDE_HASH6 my_bisect_log.txt &&
 	git bisect reset
 '
