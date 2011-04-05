From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 1/2] Documentation: clarify fnmatch behavior in
 gitignore
Date: Tue, 05 Apr 2011 15:34:42 -0700
Message-ID: <7vfwpwl43h.fsf@alter.siamese.dyndns.org>
References: <1302041878-24426-1-git-send-email-eblake@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, j6t@kdbg.org, jrnieder@gmail.com
To: Eric Blake <eblake@redhat.com>
X-From: git-owner@vger.kernel.org Wed Apr 06 00:35:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7Epy-0004D5-Bi
	for gcvg-git-2@lo.gmane.org; Wed, 06 Apr 2011 00:35:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754117Ab1DEWe5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Apr 2011 18:34:57 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:51322 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754012Ab1DEWe4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Apr 2011 18:34:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2C01A52D5;
	Tue,  5 Apr 2011 18:36:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/wflS1MCCDAPF7hSpH8zJfnGAvg=; b=OE+Fe6
	Co8c9zu2HRgtwO91lxRxnXVJfnnmPHtHXsY/RsSnWuqQ4ImokRCZkHMhLup/8jOm
	OrhxLC7b/w1VBxrLBNpovt8Xel9gw66mqCZINxn+NFOQt4GrSEUaxHd9ALC7NpBj
	yFapcRWOKzMibovvgMGSlTb1lDwSPTNX1J0p0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mEffYv9batl3776cpAmkMAV+I86878uq
	liQ0pcnrZv1pCcHcjiCO8Kzb+zY3fnUQYNrEBd+huQnlNx2jxQz8miGC4nwDHgXn
	DjkOCFzM5dFrNjIrr/MZCR/ZyBM6TWVRRGGj9iE/BNUYvQ/0rByEXm+A64ZF4cWG
	OcCkpw95YbM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DF87B52D3;
	Tue,  5 Apr 2011 18:36:41 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 756A952C1; Tue,  5 Apr 2011
 18:36:36 -0400 (EDT)
In-Reply-To: <1302041878-24426-1-git-send-email-eblake@redhat.com> (Eric
 Blake's message of "Tue, 5 Apr 2011 16:17:57 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2D8F8826-5FD5-11E0-A0D6-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170931>

Eric Blake <eblake@redhat.com> writes:

> Make it clear that in a .gitignore file,
>
>   *ignore
>
> matches (and therefore excludes) `.gitignore', even though the
> same glob does not match in the shell.
>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>
> v3: separate fnmatch wording cleanup into its own patch
>
>  Documentation/gitignore.txt |    7 ++++---
>  1 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
> index 2e7328b..9b1e5e1 100644
> --- a/Documentation/gitignore.txt
> +++ b/Documentation/gitignore.txt
> @@ -86,9 +86,10 @@ PATTERN FORMAT
>     `.gitignore` file).
>
>   - Otherwise, git treats the pattern as a shell glob suitable
> -   for consumption by fnmatch(3) with the FNM_PATHNAME flag:
> -   wildcards in the pattern will not match a / in the pathname.
> -   For example, "Documentation/{asterisk}.html" matches
> +   for consumption by fnmatch(3) with the FNM_PATHNAME but not
> +   FNM_PERIOD flags: wildcards in the pattern will match leading
> +   . but not / in pathnames.  For example,

Does this format correctly with asciidoc?

Even if it does not get confused as a bullet or something, I think you
would want to quote it (and the slash), perhaps like

	`.` (dot) and `/` (slash)

In any case, I tend to think that we would want to add FNM_PERIOD to
tighten the match in the longer term, perhaps at the 1.8.0 boundary.
