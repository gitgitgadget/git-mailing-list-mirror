From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 07/15] user-manual: Mention 'git remote add' for
 remote branch config
Date: Sun, 10 Feb 2013 14:08:32 -0800
Message-ID: <7vobfrsty7.fsf@alter.siamese.dyndns.org>
References: <7vzjzexv8l.fsf@alter.siamese.dyndns.org>
 <cover.1360508415.git.wking@tremily.us>
 <1e3996dff5c19010aca1458b202b14cbb54b5d80.1360508415.git.wking@tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Sun Feb 10 23:09:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4f5K-0004PN-FF
	for gcvg-git-2@plane.gmane.org; Sun, 10 Feb 2013 23:09:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756702Ab3BJWIz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2013 17:08:55 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43991 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756586Ab3BJWIy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2013 17:08:54 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CA110C376;
	Sun, 10 Feb 2013 17:08:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kwJUXH2r6/ZQpr5coDWktVjgLos=; b=NIfsWG
	jMfmdS/jLdpLzZ8c4/SaedZIHeYugrcsNtQG+38SvjsrwtDToerhCd9uFD9lqhka
	EBhCS5MwGVNUuSbGGs0rICjv6XAuW/qGmLs2qxNFd/U8Mau5zL7BjCfMIjvpUbLc
	2UFTizYMofML7wFzJy0dUT0mi+XRGvWyEEzHY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=F1P/uVTjaCkSomIMAx8uRhQV2kTzhQQy
	SHCKWqT95/NP+/E+gyjBt4o+BGshto+EkDJpX+uUPEC3v/RT62+B/0KIUwVnqC28
	yIpqITbb9qzm8bhxcZQrpD0JQkhzQG3iApRFzMQATEKJQMY2KQ/e3shRElg1gwXF
	vN6BfbgdY6A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0A5F0C2FA;
	Sun, 10 Feb 2013 17:08:44 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CF85CC28B; Sun, 10 Feb 2013
 17:08:38 -0500 (EST)
In-Reply-To: <1e3996dff5c19010aca1458b202b14cbb54b5d80.1360508415.git.wking@tremily.us>
 (W. Trevor King's message of "Sun, 10 Feb 2013 10:10:33 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6E6D9F54-73CE-11E2-87F8-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215947>

"W. Trevor King" <wking@tremily.us> writes:

> diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
> index a68d6b9..424cdd6 100644
> --- a/Documentation/user-manual.txt
> +++ b/Documentation/user-manual.txt
> @@ -2909,8 +2909,23 @@ Also note that all of the above configuration can be performed by
>  directly editing the file .git/config instead of using
>  linkgit:git-config[1].
>  
> +You can produce a similar configuration with:
> +
> +-------------------------------------------------
> +$ git remote add example git://example.com/proj.git
> +-------------------------------------------------
> +
> +which adds the following stanza to `.git/config`:
> +
> +-------------------------------------------------
> +[remote "example"]
> +        url = git://example.com/proj.git
> +        fetch = +refs/heads/*:refs/remotes/example/*
> +-------------------------------------------------
> +

What the "config remoteexample.fetch" example before this hunk
teaches is stale and is a wrong advice these days.  I suspect that
the original was written very soon after a separate refs/remotes/
hierarchy was introduced, back when it was considered a good and
cautious practice to notice rewinds at the remote by omitting the
"+" from fetch refspecs.  I'd suggest rewriting everything after "If
there are other repositories that you also use frequently,..." of
this section.

Replace the first example after "for example, after" that uses
"config remote.example.url" with the new text in your patch, and
remove everything before "Also note that all of the above
configuration can be performed by directly editing".
