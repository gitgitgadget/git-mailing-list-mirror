From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 13/14] revert: Introduce --continue to continue the
 operation
Date: Wed, 06 Jul 2011 14:21:03 -0700
Message-ID: <7vliwbjebk.fsf@alter.siamese.dyndns.org>
References: <1309938868-2028-1-git-send-email-artagnon@gmail.com>
 <1309938868-2028-14-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 06 23:21:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QeZWz-0001qL-F0
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jul 2011 23:21:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756500Ab1GFVVH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jul 2011 17:21:07 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:47729 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756319Ab1GFVVG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2011 17:21:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0D38C69EE;
	Wed,  6 Jul 2011 17:21:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=wKNWq5cF9X1gopFQDNS4oumLacY=; b=CMAkgzL42anXccy0r8eW
	TFQYomam7DNmFU8m8nT7xk3tvWKhsdlcCkX5O2oOj3sAb35PXIWj8NInuEBaVyV5
	q0DxzCXCLm3xhEyWJ0PWXhV1GmQue4FInFDLXWl/FKs33jELIU73Or366J95hQgw
	CLRs9Vipt6Mit75cZ5GoWMs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=YxC4+yb5OcGa78n44r1zDftsisXchFYsCssEfBrAVq8FVg
	4ZEq9bMNJ70XJvhpLEk2lWtcUNNFG3nJplMZzzEmL/PWtHlnyTeXsHgm4ct7xdQl
	S7ufgQXPI9gKbBY1wMFKTPu49zmdKXmptHcj9qOVQrwRvPn9Ye5VM2zTmlVfA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 066AD69ED;
	Wed,  6 Jul 2011 17:21:06 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 5741B69EB; Wed,  6 Jul 2011
 17:21:05 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DBA64700-A815-11E0-A585-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176732>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> diff --git a/builtin/revert.c b/builtin/revert.c
> index 9e18d64..6ef56ee 100644
> --- a/builtin/revert.c
> +++ b/builtin/revert.c
> @@ -47,6 +47,7 @@ struct replay_opts {
>  	enum replay_action action;
>  
>  	int reset;
> +	int contin;

As Jonathan mentiond, these three look like all action's to me.

> +static void verify_opt_mutually_compatible(const char *me, ...)
> +{

Isn't "being compatible" by definition "mutual"?  

I.e. verify-option-compatibility perhaps?
