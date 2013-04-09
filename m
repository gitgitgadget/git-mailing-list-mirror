From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 2/3] Teach mv to move submodules using a gitfile
Date: Tue, 09 Apr 2013 16:08:56 -0700
Message-ID: <7vwqsbnvxz.fsf@alter.siamese.dyndns.org>
References: <515C88FE.9020203@web.de> <515C8987.2060804@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Phil Hord <phil.hord@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	"W. Trevor King" <wking@tremily.us>,
	Peter Collingbourne <peter@pcc.me.uk>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Apr 10 01:09:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPhez-0008Rh-WC
	for gcvg-git-2@plane.gmane.org; Wed, 10 Apr 2013 01:09:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752808Ab3DIXJA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Apr 2013 19:09:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49321 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751767Ab3DIXI7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Apr 2013 19:08:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2A83B15946;
	Tue,  9 Apr 2013 23:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=V1GjRub8CzLoFp2uCEUfLKB3OuI=; b=sf3dWe
	11F8m1Mum9N0e+4cOtSH6m8gzJI77lehy5WbVEh6ZOaPfWnhVYF5T/u6iiBWNjcc
	LH8Lj9F0XgpMatQvoOi8nBzEqY/b8oLDxYtLDVdBNRe4yuVMgb7nfQahVo4wCmy5
	NvmnxFCkvgvjY15CQHrHSS9d/c0my3giNZDmE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Avo/jQIjJSqOWfY0FmN4FhAhk9gXhXJx
	GjsLIr8CfU3e/cGpUF3tleJ3O9WcvyYwkqEfqKMsYSc8gdV/wBE+/X0x8QhUwqtJ
	kEaBtcBwI9XnoGNlXHz1HyHGSWDYBTcfN/i6+8DQ1qme0n16njn+zo025s29yHq7
	tw57UpZc+4c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2047115945;
	Tue,  9 Apr 2013 23:08:59 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5856315944; Tue,  9 Apr
 2013 23:08:58 +0000 (UTC)
In-Reply-To: <515C8987.2060804@web.de> (Jens Lehmann's message of "Wed, 03
 Apr 2013 21:56:55 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 75812D28-A16A-11E2-950A-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220650>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> diff --git a/submodule.c b/submodule.c
> index 975bc87..eba9b42 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -1001,3 +1001,67 @@ int merge_submodule(unsigned char result[20], const char *path,
> ...
> +	if (!fp)
> +		die(_("Could not create git link %s"), gitfile_name.buf);
> +	fprintf(fp, gitfile_content.buf);

Perhaps.

	fprintf(fp, "%s", gitfile_content.buf);
