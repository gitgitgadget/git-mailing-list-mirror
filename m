From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix wrong xhtml option to highlight
Date: Mon, 24 Jan 2011 14:48:25 -0800
Message-ID: <7vvd1dlxza.fsf@alter.siamese.dyndns.org>
References: <1295898298-9794-1-git-send-email-Jochen@herr-schmitt.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jochen Schmitt <Jochen@herr-schmitt.de>
X-From: git-owner@vger.kernel.org Mon Jan 24 23:48:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PhVDD-00046F-LR
	for gcvg-git-2@lo.gmane.org; Mon, 24 Jan 2011 23:48:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752478Ab1AXWse (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jan 2011 17:48:34 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:41052 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751344Ab1AXWsd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jan 2011 17:48:33 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4BBBF2987;
	Mon, 24 Jan 2011 17:49:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YCSF1OxzEpxeJgVKfFjmq8+9ghg=; b=o0a1wC
	jdpgJm63AhMVJ5FqvviUZf+oizIDhKzxx5X2VJ52Fa8eMEopTek0fNZbHY+k9SZj
	wKud+lHLARGt8SM1pm1xwxbSfh7dNXZM1AbjxXqnRoJeSRP8/zWlSsCoNCrgHPkC
	RVjX6MsrNUkPL+4UhIpD/FR8sMAIEqyxxr0r8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MccDQNk1CvAzFx94ykjoiqn4A3l5EKlb
	tk+kLQ2329yjqEj4qKWRAYDxexOqNKsHBSh5VZm1eNruztEwIf6YABntOI5WvF9K
	8cPTTX1HgqWgLMOcDnKj2EVHVCbZm7kX5JOyCXFJe8OdxinPrF7TFtwZqEVOxB5p
	8NzmPkmU37w=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0B0FC2986;
	Mon, 24 Jan 2011 17:49:20 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E5AED2983; Mon, 24 Jan 2011
 17:49:16 -0500 (EST)
In-Reply-To: <1295898298-9794-1-git-send-email-Jochen@herr-schmitt.de>
 (Jochen Schmitt's message of "Mon\, 24 Jan 2011 20\:44\:58 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2E156776-280C-11E0-B47C-BC4EF3E828EC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165461>

Jochen Schmitt <Jochen@herr-schmitt.de> writes:

> ---
> Hallo,
>
> because I'm the maintainer of the highlight package in the
> Fedora Project I was notified, that highlight doesn't works
> properly with gitweb in BZ #672293.
>
> So I have create the following simple patch to solve the 
> reported issue.
>
> Best Regards
>
> Jochen Schmitt
>
>  gitweb/gitweb.perl |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 1025c2f..b662420 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -3468,7 +3468,7 @@ sub run_highlighter {
>  	close $fd;
>  	open $fd, quote_command(git_cmd(), "cat-file", "blob", $hash)." | ".
>  	          quote_command($highlight_bin).
> -	          " --xhtml --fragment --syntax $syntax |"
> +	          " -xhtml --fragment --syntax $syntax |"

Curious.

Does the command take double-dash for the fragment and syntax options but
a single dash for the xhtml option?  Really...

A few top hits returned by Google for "highlight manual page" tells me
otherwise.
