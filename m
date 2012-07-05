From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/6] Teach clone to set remote.default.
Date: Thu, 05 Jul 2012 15:52:51 -0700
Message-ID: <7vzk7dq0qk.fsf@alter.siamese.dyndns.org>
References: <1341526277-17055-1-git-send-email-marcnarc@xiplink.com>
 <1341526277-17055-4-git-send-email-marcnarc@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens.Lehmann@web.de, peff@peff.net,
	phil.hord@gmail.com
To: marcnarc@xiplink.com
X-From: git-owner@vger.kernel.org Fri Jul 06 00:53:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Smuuy-0004gz-BE
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jul 2012 00:53:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933143Ab2GEWwy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jul 2012 18:52:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39837 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932163Ab2GEWwx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jul 2012 18:52:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 52B0B96B2;
	Thu,  5 Jul 2012 18:52:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bwVqxzaorvl8Ja0a99g64zr7wTg=; b=hsrVYy
	W4wxFgNgc5weNGqCRFRGKOHK0JBrhDX9dyfQQ7UfyLbzskpiOeVcFInVdU+G1FHK
	uuK+xnrCmrIUfXalpbyu8f/F7A+lv5nD2QcbBhzB5Nq1bibu+PtbPcOSlg3cpp/4
	ngwxMz+euKGQcfpqCpEFblTKmH1g8ph8c7RF4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eSHX0NJ9tupcTKhi+a8tw3y9oBggOdHF
	F3IOnErpB7zvwlzCcBj2BHsiO30ah5ZYARibWF5XlpMqqwgxKhWhKtPsWVMjIveG
	LgegF+WboWoUSLSBmMKUzsqBUcr4zJcAwO6v5ubuaH3UdT9ejQEDTYNtKsvx5M43
	B1PPC/5f6IY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4907F96B1;
	Thu,  5 Jul 2012 18:52:53 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D32D096AF; Thu,  5 Jul 2012
 18:52:52 -0400 (EDT)
In-Reply-To: <1341526277-17055-4-git-send-email-marcnarc@xiplink.com>
 (marcnarc@xiplink.com's message of "Thu, 5 Jul 2012 18:11:14 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 27231066-C6F4-11E1-91F5-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201074>

marcnarc@xiplink.com writes:

> From: Marc Branchaud <marcnarc@xiplink.com>
>
> Signed-off-by: Marc Branchaud <marcnarc@xiplink.com>
> ---
>  builtin/clone.c          |  2 ++
>  t/t5601-clone.sh         | 10 ++++++++++
>  t/t5702-clone-options.sh |  7 +++++--
>  3 files changed, 17 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/clone.c b/builtin/clone.c
> index a4d8d25..b198456 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -770,6 +770,8 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  	git_config_set(key.buf, repo);
>  	strbuf_reset(&key);
>  
> +	git_config_set("remote.default", option_origin);
> +

Is this something we would want to do unconditionally?  If so why?

Or is this what we want to do only when the "--origin name" option
is used?
