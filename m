From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 03/15] user-manual: Use 'remote add' to setup push
 URLs
Date: Sun, 10 Feb 2013 13:33:31 -0800
Message-ID: <7v8v6vua50.fsf@alter.siamese.dyndns.org>
References: <7vzjzexv8l.fsf@alter.siamese.dyndns.org>
 <cover.1360508415.git.wking@tremily.us>
 <44d89e81a8465d3bbf50b106a8a844c9d90ac384.1360508415.git.wking@tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Sun Feb 10 22:34:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4eX9-00030h-9q
	for gcvg-git-2@plane.gmane.org; Sun, 10 Feb 2013 22:33:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756603Ab3BJVdf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2013 16:33:35 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36713 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755786Ab3BJVde (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2013 16:33:34 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 04900CDAE;
	Sun, 10 Feb 2013 16:33:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nYpmg/qIjI9F/OT7E5+BWXLBJYg=; b=ID44CL
	fSdz0Pa48/9p4uW078V7wQJr/zs3YvvV0/g81K1ewb/bRebUArwEMrNgw73aL29Y
	RzmDjQrEbMzA/1aKrBZwtTlekujgyByOQe2/oETkIm4NGWq5xmtaAOgvCPnWteje
	BXpqVBrxRQjNbaJ+Vl7i+iVeYTy8VQkOzF98Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CHhMnx5CvKVxy3RAvMocN2xG+u6VQOx5
	OrR0s4L4wwsFGs8BcSJ04g9TmpqIjtdi9wbl5uQtR34VTB6L44gK0krD5L9iMEBP
	MytOeJpE6RIGLwgpJxZkeYYYjhvYktSokSoS7VoHGTFW0gNVK26LyGmKdWy4K1Zg
	IpSLzw7Cfjc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D9A2CCDAC;
	Sun, 10 Feb 2013 16:33:33 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 09044CDA3; Sun, 10 Feb 2013
 16:33:32 -0500 (EST)
In-Reply-To: <44d89e81a8465d3bbf50b106a8a844c9d90ac384.1360508415.git.wking@tremily.us>
 (W. Trevor King's message of "Sun, 10 Feb 2013 10:10:29 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 84FB2E9E-73C9-11E2-9523-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215937>

"W. Trevor King" <wking@tremily.us> writes:

> From: "W. Trevor King" <wking@tremily.us>
>
> There is no need to use here documents to setup this configuration.
> It is easier, less confusing, and more robust to use Git's
> configuration tools directly.
>
> Signed-off-by: W. Trevor King <wking@tremily.us>
> ---
>  Documentation/user-manual.txt | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
>
> diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
> index 8524c08..53f73c3 100644
> --- a/Documentation/user-manual.txt
> +++ b/Documentation/user-manual.txt
> @@ -1994,14 +1994,17 @@ default.  See the description of the receive.denyCurrentBranch option
>  in linkgit:git-config[1] for details.
>  
>  As with `git fetch`, you may also set up configuration options to
> -save typing; so, for example, after
> +save typing; so, for example, after either
>  
> --------------------------------------------------
> -$ cat >>.git/config <<EOF
> -[remote "public-repo"]
> -	url = ssh://yourserver.com/~you/proj.git
> -EOF
> --------------------------------------------------
> +------------------------------------------------
> +$ git remote add public-repo ssh://yourserver.com/~you/proj.git
> +------------------------------------------------
> +
> +or, more explicitly,
> +
> +------------------------------------------------
> +$ git config remote.public-repo.url ssh://yourserver.com/~you/proj.git
> +------------------------------------------------

Look at how "Fetching branches from other repositories" is done.  It
shows the use of "remote add" and then shows the result by running
"cat" to show the contents.

I think that organization is much nicer than completely hiding how
the result looks like behind another "git config --set" call, like
the latter half of this patch does.  The resulting text may read
like so:

	...
	save typing; so for example:

	------------
        $ git remote add public-repo yourserver.com:proj.git
	------------

	will add this to your configuration:

	------------
        $ cat .git/config
        ...
        [remote "public-repo"]
		url = yourserver.com:proj.git
	...
	------------

	which lets you do the same push with just

	------------
        $ git push public-repo master
	------------
