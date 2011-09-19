From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] abspath: increase array size of cwd variable to PATH_MAX
Date: Mon, 19 Sep 2011 09:43:52 -0700
Message-ID: <7v8vpkbhyv.fsf@alter.siamese.dyndns.org>
References: <1316425872-30457-1-git-send-email-Hui.Wang@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: Wang Hui <Hui.Wang@windriver.com>
X-From: git-owner@vger.kernel.org Mon Sep 19 18:44:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5gwu-0005Ky-An
	for gcvg-git-2@lo.gmane.org; Mon, 19 Sep 2011 18:44:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756767Ab1ISQn6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Sep 2011 12:43:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54178 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756778Ab1ISQn6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Sep 2011 12:43:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5A32D4E3F;
	Mon, 19 Sep 2011 12:43:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8E0nmhUdgYrnCCftcnJunpPJ5mc=; b=a/zuX4
	7v2+o+jygALBilhWxiwLhtLJaM4jfjFuylqEfHSwwpJyR0rC+tBh96PxuY0o0Maz
	jh//rjaFiG76P9Paxyg0yX0DdC8U5tXYB/5vNXhcpVioe43jn6EKIFo7GWJvegI/
	mbO4+cBhgSS8L1z2f/Rl/zeD1Nt8Pgo6LtECs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aZeUNdZF2sLsVQnUd0FAO0jF7oFar/b8
	szgy2FXQ0Y0N/4xbyVpg21GUKeKfy59rZ0XUQMrYr18RDebIwrpe6colivFrBuV1
	gy3Fsc1oChmye1Ud0bui4QE58pIQAvL7WsKEOdv24u+lFkld9CdZnAAVuKLANi7J
	grHj76+Umz0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 519164E3E;
	Mon, 19 Sep 2011 12:43:56 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DCE8A4E3B; Mon, 19 Sep 2011
 12:43:55 -0400 (EDT)
In-Reply-To: <1316425872-30457-1-git-send-email-Hui.Wang@windriver.com> (Wang
 Hui's message of "Mon, 19 Sep 2011 17:51:12 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 90AF95C2-E2DE-11E0-BC73-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181682>

Wang Hui <Hui.Wang@windriver.com> writes:

> diff --git a/abspath.c b/abspath.c
> index f04ac18..2ce1db9 100644
> --- a/abspath.c
> +++ b/abspath.c
> @@ -24,7 +24,7 @@ int is_directory(const char *path)
>  const char *real_path(const char *path)
>  {
>  	static char bufs[2][PATH_MAX + 1], *buf = bufs[0], *next_buf = bufs[1];
> -	char cwd[1024] = "";
> +	char cwd[PATH_MAX] = "";

Thanks.

This does not make things worse but in the longer term we should move away
from using PATH_MAX in general.
