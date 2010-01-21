From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] rev-parse --branches/--tags/--remotes=pattern
Date: Thu, 21 Jan 2010 12:09:42 -0800
Message-ID: <7vbpgnp6d5.fsf@alter.siamese.dyndns.org>
References: <1263980906-11058-1-git-send-email-ilari.liusvaara@elisanet.fi>
 <4B584DDD.7060701@viscovery.net> <4B585BED.700@drmicha.warpmail.net>
 <201001211827.05847.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Johannes Sixt <j.sixt@viscovery.net>, <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Jan 21 21:10:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NY3Lx-0002C2-NA
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jan 2010 21:10:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755072Ab0AUUJ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2010 15:09:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755078Ab0AUUJ6
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jan 2010 15:09:58 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:45605 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755065Ab0AUUJ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jan 2010 15:09:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C2B9192878;
	Thu, 21 Jan 2010 15:09:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=wyuSpvwMZ1WFBNflKm2DhlfZxaI=; b=uZHQYipcnxOHqSysYhmSiF2
	KqTcqEfVG5B9sUSqiTpQAiOTLJXArXGcpnXP/tsoXcxnqJj9FOZ28Mdz/ZwTFRnX
	svZJ4tM7x78P0LpkafxuCVaX3TJQ1uV3wpM3qcEXIIZs4xAz3O4iVCflEgf9Aah3
	nW5V98wFf+qY1cmRndfA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=MwjlKp8hnR5g37bTKtzOMgaM+ner0w7hL9eNvSTkVzjy0Aajv
	qrgf9ZfgpCap4vak5HnLIZKbwlXTSA983lxQEvfxhu49y7QJKWtmoAye1NW9ldOR
	sH7M8zNFcA38Blsf197ujxEEJIlbbJydd/60gmZf101GNPUXgAJ3mE6th8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 718CA9286C;
	Thu, 21 Jan 2010 15:09:51 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4C8F992863; Thu, 21 Jan
 2010 15:09:44 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: EED1D7D0-06C8-11DF-8BA8-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137689>

Thomas Rast <trast@student.ethz.ch> writes:

> Maybe the --branches, --tags and --remotes could be consolidated a
> bit, as in the draft patch below.

Looks sensible.

> diff --git i/Documentation/git-rev-parse.txt w/Documentation/git-rev-parse.txt
> index 2bbb566..6fce919 100644
> --- i/Documentation/git-rev-parse.txt
> +++ w/Documentation/git-rev-parse.txt
> @@ -104,29 +104,26 @@ OPTIONS
>  	Show all refs found in `$GIT_DIR/refs`.
>  
>  --branches[=pattern]::
> -	Show branch refs found in `$GIT_DIR/refs/heads`. If `pattern`
> -	is given, only branches matching given shell glob are shown.
> -	If pattern lacks '?', '*', or '[', '/*' at the end is impiled.
> -
>  --tags[=pattern]::
> -	Show tag refs found in `$GIT_DIR/refs/tags`. If `pattern`
> -	is given, only tags matching given shell glob are shown.
> -	If pattern lacks '?', '*', or '[', '/*' at the end is impiled.
> -
>  --remotes[=pattern]::
> -	Show tag refs found in `$GIT_DIR/refs/remotes`. If `pattern`
> -	is given, only remote tracking branches matching given shell glob
> -	are shown. If pattern lacks '?', '*', or '[', '/*' at the end is
> -	impiled.
> +	Show all branches, tags, or remote-tracking branches,
> +	respectively (i.e., refs found in `$GIT_DIR/refs/heads`,
> +	`$GIT_DIR/refs/tags`, or `$GIT_DIR/refs/remotes`,
> +	respectively).
> ++
> +If a `pattern` is given, only refs matching the given shell glob are
> +shown.  If the pattern does not contain a globbing character (`?`,
> +`\*`, or `[`), it is anchored by appending `/\*`.
> +
> +--glob=pattern::
> +	Show all refs matching the shell glob pattern `pattern`. If
> +	the pattern does not start with `refs/`, this is automatically
> +	prepended.  If the pattern does not contain a globbing
> +	character (`?`, `\*`, or `[`), it is anchored by appending `/\*`.
>  
>  --show-toplevel::
>  	Show the absolute path of the top-level directory.
>  
> ---glob=glob-pattern::
> -	Show refs matching shell glob pattern `glob-pattern`. If pattern
> -	specified lacks leading 'refs/', it is automatically prepended.
> -	If pattern lacks '?', '*', or '[', '/*' at the end is impiled.
> -
>  --show-prefix::
>  	When the command is invoked from a subdirectory, show the
>  	path of the current directory relative to the top-level
>
>
> -- 
> Thomas Rast
> trast@{inf,student}.ethz.ch
