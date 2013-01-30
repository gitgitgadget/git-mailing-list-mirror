From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] fixup! mergetool--lib: add functions for finding
 available tools
Date: Wed, 30 Jan 2013 12:23:34 -0800
Message-ID: <7vk3quju7t.fsf@alter.siamese.dyndns.org>
References: <cover.1359575447.git.john@keeping.me.uk>
 <2c7dec096455e6e43d2e9aa28668f69a26f3d5f9.1359575447.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Wed Jan 30 21:24:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0eCO-0001GW-J5
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jan 2013 21:24:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752326Ab3A3UXj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2013 15:23:39 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62673 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751564Ab3A3UXi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2013 15:23:38 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3C177DC35;
	Wed, 30 Jan 2013 15:23:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4le691Q2OGSpA3I1YZi7ah9teOk=; b=YU4UgK
	wCssX/tRJN1EEx6TbiUr6yCXlHQ6ramZPN9jV2V47lki+WrWKU1IuWmpirCzkCPT
	6TKKuiSIZv+Z6vBH3pnLuQT5AnmqgP7B41/zwr5a4ag8Ve52Mh2yAqvfTsoX87sR
	lgFDlmNudVYwlcR741X+yQ5sGKbBJUbB1EBps=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kg2DVIOhR/xeI+tKZuq8VlJk57TGqOiZ
	TNWBWQGsmEJcrOdeTHjWafPXBjRfWCg6z/wLvq52lS3i95SvYozAbg82Z2P2oEAr
	DHKhE4B7ouMJ76NhYHbarlR0TI1zIMqpCZdCVOR8IyQqGE9A2/DtoYVysVU4Cx/v
	jZ8PeWAobhs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DA1C0DC2D;
	Wed, 30 Jan 2013 15:23:36 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2A88DDC22; Wed, 30 Jan 2013
 15:23:36 -0500 (EST)
In-Reply-To: <2c7dec096455e6e43d2e9aa28668f69a26f3d5f9.1359575447.git.john@keeping.me.uk>
 (John Keeping's message of "Wed, 30 Jan 2013 19:55:44 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: ECDFA9DE-6B1A-11E2-9095-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215070>

John Keeping <john@keeping.me.uk> writes:

> Signed-off-by: John Keeping <john@keeping.me.uk>
> ---
>  git-mergetool--lib.sh | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Thanks.

> diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
> index 25631cd..b6ed2fa 100644
> --- a/git-mergetool--lib.sh
> +++ b/git-mergetool--lib.sh
> @@ -34,9 +34,9 @@ show_tool_names () {
>  				then
>  					echo "$preamble"
>  					preamble=
> -					shown_any=yes
>  				fi
> -				printf "%s%s\n" "$per_line_prefix" "$tool"
> +				shown_any=yes
> +				printf "%s%s\n" "$per_line_prefix" "$toolname"

Thanks for spotting s/tool/toolname/; does the change to shown_any
matter, though?

>  			fi
>  		done
>  		test -n "$shown_any"
> @@ -244,6 +244,7 @@ show_tool_help () {
>  
>  	tab='	' av_shown= unav_shown=
>  
> +	cmd_name=${TOOL_MODE}tool
>  	if show_tool_names 'mode_ok && is_available' "$tab$tab" \
>  		"$tool_opt may be set to one of the following:"
>  	then
