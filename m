From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/2] add --recode-patch option to git-mailinfo
Date: Sun, 13 Jun 2010 22:33:55 -0700
Message-ID: <7vvd9mb2kc.fsf@alter.siamese.dyndns.org>
References: <1276455040-14726-1-git-send-email-r0bertz@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Zhang Le <r0bertz@gentoo.org>
X-From: git-owner@vger.kernel.org Mon Jun 14 07:34:22 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OO2JK-0007fg-OK
	for gcvg-git-2@lo.gmane.org; Mon, 14 Jun 2010 07:34:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751557Ab0FNFeF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jun 2010 01:34:05 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:49097 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751392Ab0FNFeB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jun 2010 01:34:01 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6A170BC6CC;
	Mon, 14 Jun 2010 01:34:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=QxDv4QDLYmO7YKPwD3vpMgK1khM=; b=TNSsfCv5PFPEn2mJhW8NoHm
	Pkh76wTDUVDuE1oHU6+Wh6edcMBhLiZ9fvwXsBPP4UbCB+5UPGXonp8ed7G3aI4/
	spcETPXUsZmB3uK5T/K/yI71Ym4qRB8izlkJgD76KDlNd8GwKT4nid3HetH7Nu/G
	TnQaHP8DOepmidtiw28U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=tWRe41kM9EIc8Wag1oE0V/S7HecOb3RMOR+9cQMa5scnqwI56
	UcQgZi+4eCPmxGPlQLPyWR32ilYCi7nJS6FfWHNbFtVZUtnSrkRijfAbSp3Oei0E
	Xo7Ap5Td4R78GqBex/HaiWjY5fnFSm5IWfQ0F2hNnG/B3SImG1bwvAPq+A=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 41881BC6CB;
	Mon, 14 Jun 2010 01:33:59 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 94C58BC6C9; Mon, 14 Jun
 2010 01:33:56 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6EC0B6D2-7776-11DF-B96B-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149075>

Zhang Le <r0bertz@gentoo.org> writes:

> diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
> index 4a9729b..73f51f3 100644
> --- a/builtin/mailinfo.c
> +++ b/builtin/mailinfo.c
> @@ -830,6 +831,8 @@ static int handle_commit_msg(struct strbuf *line)
>  
>  static void handle_patch(const struct strbuf *line)
>  {
> +	if (recode_patch)
> +		convert_to_utf8(line, charset.buf);

builtin/mailinfo.c: In function 'handle_patch':
builtin/mailinfo.c:835: error: passing argument 1 of 'convert_to_utf8' discards qualifiers from pointer target type

I do not think there is a reason for "line" to be const anymore; it used
to make sense back when handle_patch() was only about writing the patch
out, but that no longer is the case.
