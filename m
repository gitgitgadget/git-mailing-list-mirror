From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] Documentation/urls: Rewrite to accomodate 
 <transport>::<address>
Date: Mon, 05 Apr 2010 15:22:17 -0700
Message-ID: <7vhbnpmteu.fsf@alter.siamese.dyndns.org>
References: <n2rf3271551004050656vdd7d242dpeebacb25d4082f75@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Gabriel Filion <lelutin@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 06 00:23:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nyuh0-0000mI-MA
	for gcvg-git-2@lo.gmane.org; Tue, 06 Apr 2010 00:22:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756805Ab0DEWWq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Apr 2010 18:22:46 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:36240 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756746Ab0DEWWl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Apr 2010 18:22:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 18AB2A8B96;
	Mon,  5 Apr 2010 18:22:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XoEiLnAFfcam2gkBXsWjuqzGcIE=; b=S0NRyG
	KZWklRT8NdD6l3JQ4IsIGgnnXfCoFxYKNfZG/aEhoDFaLHaQGhCgUBiNwPanU2ex
	SxlQfMLpJ9LZhRJaHiie2juGAVDtbM2hi1DlUSdwIA+EmE+s/h2BhmDOxTg8w9Z7
	fvnqMdGAYxgyXI686G2mM4YmHJUnPihbssJE0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Cc6Wn6xoABYAxmb7tdvDGbH9iLbx3HH5
	/RszvD1HWNE2310cvjLctn00Notz0eooWta3pacEFGl/ElP0AVYMbcTvipda35yB
	8AzigB3AC/ygie11karBrkuybjqYlRuk/wHAOu0eDNGd4woHGoPcx5xK0NG2Vivg
	xXfCpBTmSNo=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8D924A8B91;
	Mon,  5 Apr 2010 18:22:28 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 31971A8B8A; Mon,  5 Apr
 2010 18:22:19 -0400 (EDT)
In-Reply-To: <n2rf3271551004050656vdd7d242dpeebacb25d4082f75@mail.gmail.com>
 (Ramkumar Ramachandra's message of "Mon\, 5 Apr 2010 19\:26\:58 +0530")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B832B4D8-4101-11DF-AE3A-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144070>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Rewrite the first part of the document to explicitly show differences
> between the URLs that can be used with different transport
> protocols. Mention <transport>::<address> format to explicitly invoke
> a remote helper.
>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---

Nice to finally see s-o-b ;-)

> diff --git a/Documentation/urls.txt b/Documentation/urls.txt
> index 459a394..75743f2 100644
> --- a/Documentation/urls.txt
> +++ b/Documentation/urls.txt
> @@ -1,44 +1,48 @@
>  GIT URLS[[URLS]]
>  ----------------
>
> -One of the following notations can be used
> -to name the remote repository:
> -
> -- rsync://host.xz/path/to/repo.git/
> -- http://host.xz{startsb}:port{endsb}/path/to/repo.git/
> -- https://host.xz{startsb}:port{endsb}/path/to/repo.git/
> -- git://host.xz{startsb}:port{endsb}/path/to/repo.git/
> -- git://host.xz{startsb}:port{endsb}/~user/path/to/repo.git/
> -- ssh://{startsb}user@{endsb}host.xz{startsb}:port{endsb}/path/to/repo.git/
> -- ssh://{startsb}user@{endsb}host.xz/path/to/repo.git/
> -- ssh://{startsb}user@{endsb}host.xz/~user/path/to/repo.git/
> -- ssh://{startsb}user@{endsb}host.xz/~/path/to/repo.git
> -
> -SSH is the default transport protocol over the network.  You can
> -optionally specify which user to log-in as, and an alternate,
> -scp-like syntax is also supported.  Both syntaxes support
> -username expansion, as does the native git protocol, but
> -only the former supports port specification. The following
> -three are identical to the last three above, respectively:
> -
> -- {startsb}user@{endsb}host.xz:/path/to/repo.git/
> -- {startsb}user@{endsb}host.xz:~user/path/to/repo.git/
> +In general, URLs contain information about the transport protocol, the
> +address of the remote server, and the path to the repository.
> +Depending on the transport protocol, some of this information may be
> +absent.
> +
> +In addition to SSH, which is the default transport protocol over the
> +network, git natively supports git, rsync, http, https, ftp, and ftps
> +protocols. The following syntaxes may be used with them. Only SSH and
> +git protocols support username expansion.

I don't see why we want to single out ssh:// being the default at all; in
fact I do not think it is the default in any way.  To "git clone" or "git
remote add" you always specify what URL to use.

> +- ssh://{startsb}user@{endsb}host.xz{startsb}:port{endsb}/path/to/repo.git
> +- git://host.xz{startsb}:port{endsb}/path/to/repo.git
> +- rsync://host.xz/path/to/repo.git
> +- http{startsb}s{endsb}://host.xz{startsb}:port{endsb}/path/to/repo.git
> +- ftp{startsb}s{endsb}://host.xz{startsb}:port{endsb}/path/to/repo.git

I am not sure if dropping the user expansion from the example and
replacing that with one and half line of prose makes it easier to read, or
harder.

> +The SSH protocol also supports an alternative scp-like syntax:
> +
>  - {startsb}user@{endsb}host.xz:path/to/repo.git

This probably is an improvement as it wasn't clear what transport the scp
syntax triggered, namely the ssh transport.

I earlier said that ssh is not the default and there is no reason to
single it out as such.  But there is a notable thing to mention about the
ssh transport: it traditionally has been the only authenticated transport,
if you don't count the webdav push-over-http.

> -To sync with a local directory, you can use:
> +For local respositories, also supported by git natively, the following
> +syntaxes may be used:
>
> -- /path/to/repo.git/
> -- file:///path/to/repo.git/
> +- /path/to/repo.git
> +- file:///path/to/repo.git

Why did you have to drop the trailing slashes from all the examples that
made them clear that we are talking about directories?

>  ifndef::git-clone[]
> -They are mostly equivalent, except when cloning.  See
> -linkgit:git-clone[1] for details.
> +These two syntaxes are mostly equivalent, except when cloning, when
> +the former implies --local option. See linkgit:git-clone[1] for
> +details.
>  endif::git-clone[]

Good.

> -ifdef::git-clone[]
> -They are equivalent, except the former implies --local option.
> -endif::git-clone[]
> +When git doesn't know how to handle a certain transport protocol, it
> +attempts to use the 'remote-<transport>' remote helper, if one
> +exists. To explicitly request a remote helper, the following syntax
> +may be used:
> +
> +- <transport>::<address>
>
> +where <address> may be a path, a server and path, or an arbitrary
> +URL-like string recognized by the specific remote helper being
> +invoked. See linkgit:git-remote-helpers[1] for details.

I guess I should ask for "experts help" on this part, but to me this
paragraph looks good.

Thanks.
