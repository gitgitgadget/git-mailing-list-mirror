From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add __git_ps1_pc to use as PROMPT_COMMAND
Date: Fri, 28 Sep 2012 10:58:59 -0700
Message-ID: <7vipaym3ks.fsf@alter.siamese.dyndns.org>
References: <5064140E.50007@drmicha.warpmail.net>
 <50658C9B.6030809@nieuwland.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, s.oosthoek@xs4all.nl,
	Michael J Gruber <git@drmicha.warpmail.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	schwab@linux-m68k.org
To: Simon Oosthoek <soosthoek@nieuwland.nl>
X-From: git-owner@vger.kernel.org Fri Sep 28 19:59:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THeqG-0005EI-M2
	for gcvg-git-2@plane.gmane.org; Fri, 28 Sep 2012 19:59:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758675Ab2I1R7D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Sep 2012 13:59:03 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60931 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756672Ab2I1R7B (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2012 13:59:01 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2F5078D1F;
	Fri, 28 Sep 2012 13:59:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Cz9aFSIiqOqdxhWAWdhttrWorHU=; b=U59art
	91FXNCDuzIi2Cvfzn1eqplUIUHh43B7DOX5uYTHgTi/Zfm7XMCYPHS0PdTi61a5q
	PLgzbOOpgqw7jCK0cg1MTi7UEvfFv4Gx00LwNMJRddVUCwQ1zXRrydlIVGR5xn4v
	Y3x8aQV1FaBVTKpt0Yi1nZyy/QNEYeulLt1nY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FsNJbw/w/abRBkkabeETtd3I5Rw105W/
	heFFfuCNQRF+uCW2Vzln543WYelcHFAQhkLbKNk96JIJuuQJnqBFI+miiHSWVyZw
	daJIjG9zoF6OnGQLuWhp7bpGeuhoE42I+jFexBZbs65xI1oi9hxoFMZvlxET7zrI
	i1mkVBwoWi8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1CBA18D1E;
	Fri, 28 Sep 2012 13:59:01 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8433F8D1D; Fri, 28 Sep 2012
 13:59:00 -0400 (EDT)
In-Reply-To: <50658C9B.6030809@nieuwland.nl> (Simon Oosthoek's message of
 "Fri, 28 Sep 2012 13:40:11 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2E907DD6-0996-11E2-9832-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206590>

Simon Oosthoek <soosthoek@nieuwland.nl> writes:

> +# __git_ps1_pc accepts 0 arguments (for now)
> +# It is meant to be used as PROMPT_COMMAND, it sets PS1
> +__git_ps1_pc ()
> +{
> +	local g="$(__gitdir)"
> +	if [ -n "$g" ]; then
> +...
> +	fi
> +}

This looks awfully similar to the existing code in __git_ps1
function.  Without refactoring to share the logic between them, it
won't be maintainable.
