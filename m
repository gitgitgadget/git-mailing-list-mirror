From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] doc: Generate a list of valid merge tools
Date: Sun, 27 Jan 2013 15:46:01 -0800
Message-ID: <7v4ni2chqe.fsf@alter.siamese.dyndns.org>
References: <1359321886-80523-1-git-send-email-davvid@gmail.com>
 <1359321886-80523-5-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, John Keeping <john@keeping.me.uk>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 28 00:46:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tzbvg-0007l3-95
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jan 2013 00:46:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756887Ab3A0XqG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2013 18:46:06 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57347 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756848Ab3A0XqE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2013 18:46:04 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 30F21CA2D;
	Sun, 27 Jan 2013 18:46:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YnMATA3VxiSNFlxZR4QlVa3Dxes=; b=FsCtv4
	g1cJXypjd1r+oz3HM12yFK+KVaxsYgnoOwPuaJ2mMOjqVQhnHiV9U2dwvj2HIhYM
	47yxCNAeR5HZpZRnCRq7U4NLfw7+vjl16MWhmxhjSqROrNc3koKBeWQw1ukK9gXI
	kcd/2PkbJmxSzfbT0SVvbKH8QzfRkRLxnnDoo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=s+zaOuDUQzn3Kf4YqEdu7angSE3g0Jb9
	YtW4iCvWhUwc7UsbO2pcMJGKsuY6lz0gJXhjoMyuE9qBjr0doUuHVHNbB+bDgmU6
	9bbJLw5b5hHxsdeAS56H9FzSB38TFuVQ1j7Xg3In1ubkGJP7/vaezVKJLAbkdXbm
	kh1fNXTwjX4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EA799CA29;
	Sun, 27 Jan 2013 18:46:03 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0798BCA25; Sun, 27 Jan 2013
 18:46:02 -0500 (EST)
In-Reply-To: <1359321886-80523-5-git-send-email-davvid@gmail.com> (David
 Aguilar's message of "Sun, 27 Jan 2013 13:24:46 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B5EF6770-68DB-11E2-A2BA-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214756>

David Aguilar <davvid@gmail.com> writes:

> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index 267dfe1..f595d26 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -226,13 +226,27 @@ cmd-list.made: cmd-list.perl ../command-list.txt $(MAN1_TXT)
>  	$(PERL_PATH) ./cmd-list.perl ../command-list.txt $(QUIET_STDERR) && \
>  	date >$@
>  
> +mergetools_txt = mergetools-diff.txt mergetools-merge.txt
> +
> +$(mergetools_txt): mergetools-list.made

The product of files that include these two and doc.dep target have
to depend on these two files being up to date.  doc.dep depends on
$(wildcard *.txt) so you may be lucky and $(mergetools_txt) have
been built once in which case they would depend on it, or unlukcy
and end up doc.dep that does not know about them, no?
