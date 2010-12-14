From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-p4: Fix 'p4 opened' in git-p4 for names with spaces
Date: Tue, 14 Dec 2010 15:16:02 -0800
Message-ID: <7vvd2wq72l.fsf@alter.siamese.dyndns.org>
References: <1292360165-26771-1-git-send-email-jerzy.kozera@gmail.com>
 <1292360165-26771-2-git-send-email-jerzy.kozera@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jerzy Kozera <jerzy.kozera@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 15 00:16:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSe6T-0005uN-Ug
	for gcvg-git-2@lo.gmane.org; Wed, 15 Dec 2010 00:16:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757368Ab0LNXQL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Dec 2010 18:16:11 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:38533 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754035Ab0LNXQK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Dec 2010 18:16:10 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9F86E2E11;
	Tue, 14 Dec 2010 18:16:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EoIdDXwGQ1xBbKX1MzgaRjYTxT4=; b=QfkhJT
	zgRYH9Nt1TmZt0xNY/kUVfY7C9lo6nCpJXfQik31LbRaxnNdl45LI5l6yF+FFoJM
	1HWdH5HWzlrBrSLHGPOpevHNbDzacb7F+9YV9hY5zR22b9pArPI/xd4k3kn+DmDn
	Zb7IWr+DUVK1EZw17yq0HcVyc4DTPiMsIeM40=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pmQmG2gBkmt7EAMRSJKZ26krWwKryIEk
	AFHj+9hqXWyPC5HMZgjr6rcTI+m7NbxF8U9TQ6MA4GQhbcG5U2AcNQI1YXAsp4sV
	ZDtezWHCi9+uEDl3BoL7sFkfQZdf1ppDxt4UuUWbaQWpKQn4mx2wx43He/4YjFdP
	tB35nRAH2Nw=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7AD0E2E0F;
	Tue, 14 Dec 2010 18:16:34 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 7B6FE2E0C; Tue, 14 Dec 2010
 18:16:31 -0500 (EST)
In-Reply-To: <1292360165-26771-2-git-send-email-jerzy.kozera@gmail.com>
 (Jerzy Kozera's message of "Tue\, 14 Dec 2010 20\:56\:05 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 316AAD22-07D8-11E0-9457-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163718>

Jerzy Kozera <jerzy.kozera@gmail.com> writes:

> Signed-off-by: Jerzy Kozera <jerzy.kozera@gmail.com>
> ---
>  contrib/fast-import/git-p4 |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
> index 04ce7e3..a5297e7 100755
> --- a/contrib/fast-import/git-p4
> +++ b/contrib/fast-import/git-p4
> @@ -144,7 +144,7 @@ def setP4ExecBit(file, mode):
>  def getP4OpenedType(file):
>      # Returns the perforce file type for the given file.
>  
> -    result = p4_read_pipe("opened %s" % file)
> +    result = p4_read_pipe("opened \"%s\"" % file)

Don't you need a lot more than that?  What if file has " or \ in it?
