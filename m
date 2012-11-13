From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Notes in format-patch
Date: Tue, 13 Nov 2012 09:26:28 -0800
Message-ID: <7vr4nxe7nf.fsf@alter.siamese.dyndns.org>
References: <50A0B896.8050700@drmicha.warpmail.net>
 <a35a8f44b908bded0b475b02e7917011fb3bf90b.1352728712.git.git@drmicha.warpmail.net> <50A2213B.4060505@drmicha.warpmail.net> <7vhaotfou6.fsf@alter.siamese.dyndns.org> <7vzk2le918.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Nov 13 18:26:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYKGA-0001bY-Ss
	for gcvg-git-2@plane.gmane.org; Tue, 13 Nov 2012 18:26:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755353Ab2KMR0c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2012 12:26:32 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60071 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755337Ab2KMR0a (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2012 12:26:30 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 53FD49CEA;
	Tue, 13 Nov 2012 12:26:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=l3ctI30mDqvMXHr0mcdaPVCEcFQ=; b=pEiR8t
	fwO6XhBKDRSyKHDyhGRH4ENjjA8pIot5nJ+P7H/gjdSZ5Y3Y4Ipuc+XZlmQVOqS1
	Ejs/HxyuunkwN5uUWLgYKDeREcpgTUNs02cieq6YcqPSBGZ/BwgAg4NAytboG5CD
	KA14f3b0ZAq3bkWnPL0fBfJ/YQC+8JWtV1Z9M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FeMneA+e7UZy2tfxXlqh5RQdv46c3ofq
	zp/YV6+DNi5CUeUV/x5YVCGMLrfUtbj0ivIVxktHVMdAV0CUJrFIeSLRd/8FDX5V
	3RYN6XuR/sp84CFcqmduEOJSMaVVDJZU1vNcXQIPw4QqiI8UzOYi+ndN8yzdi+sC
	68Ql7pIVHwU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 401FA9CE9;
	Tue, 13 Nov 2012 12:26:30 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9B6569CE7; Tue, 13 Nov 2012
 12:26:29 -0500 (EST)
In-Reply-To: <7vzk2le918.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 13 Nov 2012 08:56:35 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 42BC7D74-2DB7-11E2-B413-54832E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209647>

Junio C Hamano <gitster@pobox.com> writes:

> As the topic seems to be already in Peff's next, here is a trivial
> fix for this in incremental form.
>
> -- >8 --
> Subject: format-patch: add a blank line between notes and diffstat
>
> The last line of the note text comes immediately before the diffstat
> block, making the latter unnecessarily harder to view.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  log-tree.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git i/log-tree.c w/log-tree.c
> index 712a22b..9303fd8 100644
> --- i/log-tree.c
> +++ w/log-tree.c
> @@ -683,6 +683,7 @@ void show_log(struct rev_info *opt)
>  			opt->shown_dashes = 1;
>  		}
>  		strbuf_addstr(&msgbuf, ctx.notes_message);
> +		strbuf_addch(&msgbuf, '\n');
>  	}
>  
>  	if (opt->show_log_size) {

... and it is broken X-<.

The blank line should be added before the diffstat, not after the
notes message (t3307 shows a case where we give notes without
diffstat, and we shouldn't be adding an extra blank line in that
case.
