From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 01/16] refs: add a backend method structure with transaction functions
Date: Fri, 04 Dec 2015 16:07:02 -0800
Message-ID: <xmqqegf1pxll.fsf@gitster.mtv.corp.google.com>
References: <1449102921-7707-1-git-send-email-dturner@twopensource.com>
	<1449102921-7707-2-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, mhagger@alum.mit.edu,
	Ronnie Sahlberg <sahlberg@google.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Sat Dec 05 01:07:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a50Nd-0006sz-5i
	for gcvg-git-2@plane.gmane.org; Sat, 05 Dec 2015 01:07:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754985AbbLEAHG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Dec 2015 19:07:06 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:58130 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752806AbbLEAHF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Dec 2015 19:07:05 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DF12131A65;
	Fri,  4 Dec 2015 19:07:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=hzUKkN6Fp8cAJw2spNHpmlJffPk=; b=agoLyytA0sZwguin0MKp
	x90pDNfSbMBOZIaady7sPko+jyDxJeHsuN+e6Du8sQ8udlGSUQzLCBahXFjuuXPM
	3eYlRe0DeGYnm0K1qMgEiSJS+pXpdFrzDzjOIee/Vg6CLty89PpsEPJgYucFD5cE
	+OOfmZtuFvmUSrU9dyZ28dM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=PMkqjj1LPywn6nqjKNb0bqOf+IC1dtv0bEYp+iUy8rnQLv
	xTldgQKRqJSQpxoBdisiJqD5HNUoc2kHTo9X7wlt/9smisn90lxR+9NLbvc6cfRU
	qPdume+Cbj2XuQVG1bMVdS6UOG5U/EAyh2l0PYF8aghgd/OMbqby6rwNVdkCQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D7CC731A64;
	Fri,  4 Dec 2015 19:07:03 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 55CF331A63;
	Fri,  4 Dec 2015 19:07:03 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1CF4614A-9AE4-11E5-B66A-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282020>

David Turner <dturner@twopensource.com> writes:

> diff --git a/refs.c b/refs.c
> index 0f7628d..babba8a 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -10,6 +10,31 @@
>  #include "tag.h"
>  
>  /*
> + * We always have a files backend and it is the default.
> + */
> +extern struct ref_be refs_be_files;

It is customary to s/extern //; in C sources.
