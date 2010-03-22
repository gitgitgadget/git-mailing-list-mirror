From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH v3] Improve remote-helpers documentation
Date: Mon, 22 Mar 2010 09:42:54 +0100
Message-ID: <4BA72D8E.5070508@drmicha.warpmail.net>
References: <f3271551003212037u66e9680cm8677c80b25f4b3a6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 22 09:45:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtdGg-0002qD-9n
	for gcvg-git-2@lo.gmane.org; Mon, 22 Mar 2010 09:45:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753513Ab0CVIpp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Mar 2010 04:45:45 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:43226 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752862Ab0CVIpo (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Mar 2010 04:45:44 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 6E03DE6CA0;
	Mon, 22 Mar 2010 04:45:43 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Mon, 22 Mar 2010 04:45:43 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=xU31l/9F76ucrBZXiryHSGgDEzg=; b=kk0qJLFUA82ivTvxiw8YoLZCxu6Q7+B1j0dnqRCOQWgIdHsxMqcp5W16Q9L8oxPfjAPF8bcXKSLtboLN34Ou992VZbCqVWxJgau97/PjBtXEm1xO1hKYKvziQOQnA2mgYBx5Qf5b3MidTcZdFGX4JtK8HEYBqtIVpMplqypUmPI=
X-Sasl-enc: t8SVFN1nA3IyH+ruCODztmRThMxBB4paRLxJl4wfa/un 1269247542
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 4A8014B220B;
	Mon, 22 Mar 2010 04:45:42 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.10pre) Gecko/20100319 Lightning/1.0b2pre Shredder/3.0.5pre
In-Reply-To: <f3271551003212037u66e9680cm8677c80b25f4b3a6@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142910>

Ramkumar Ramachandra venit, vidit, dixit 22.03.2010 04:37:
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  Documentation/git-remote-helpers.txt |   39 +++++++++++++++++----------------
>  1 files changed, 20 insertions(+), 19 deletions(-)
> 
> diff --git a/Documentation/git-remote-helpers.txt
> b/Documentation/git-remote-helpers.txt
> index 1b5f61a..b1f4e5d 100644
> --- a/Documentation/git-remote-helpers.txt
> +++ b/Documentation/git-remote-helpers.txt
> @@ -3,7 +3,7 @@ git-remote-helpers(1)
> 
>  NAME
>  ----
> -git-remote-helpers - Helper programs for interoperation with remote git
> +git-remote-helpers - Helper programs for interacting with main git
> without linking

Below, you say that helpers help Git interact with remote repositories
(which is correct). That should be matched by the short explanation
above. "Without linking" is a technical detail, so I suggest:

git-remote-helpers - Helper programs for interacting with remote
repositories

> 
>  SYNOPSIS
>  --------
> @@ -13,10 +13,22 @@ DESCRIPTION
>  -----------
> 
>  These programs are normally not used directly by end users, but are
> -invoked by various git programs that interact with remote repositories
> -when the repository they would operate on will be accessed using
> -transport code not linked into the main git binary. Various particular
> -helper programs will behave as documented here.
> +invoked by various git programs that interact with remote
> +repositories.  For a program to qualify as a remote helper, it must
> +implement a subset of the capabilities documented here, and conform to
> +the remote helper protocol. Remote helpers interact with the main git
> +programs via text streams, and do not link to them.

Isn't it more the other way round? Git calls and interacts with the
helpers, and does not link in the helpers.

> +
> +The curl helper is one such program. It is invoked via
> +'git-remote-http', 'git-remote-https', 'git-remote-ftp', or
> +'git-remote-ftps', and implments the capabilities 'fetch', 'option',
> +and 'push'. The curl helper essentially helps in moving around native
> +git objects.
> +
> +As opposed to native git objects, remote helpers can also provide a
> +fast-import stream through the 'import' capability. This makes it
> +especially useful when native interoperability with a foreign
> +versioning system is desired.
> 
>  COMMANDS
>  --------
> @@ -118,17 +130,9 @@ capabilities reported by the helper.
>  CAPABILITIES
>  ------------
> 
> -'fetch'::
> -	This helper supports the 'fetch' command.
> -
> -'option'::
> -	This helper supports the option command.
> -
> -'push'::
> -	This helper supports the 'push' command.
> -
> -'import'::
> -	This helper supports the 'import' command.
> +The following capabilities indicate that the remote helper supports
> +the corresponding command with the same name: 'fetch', 'option',
> +'push', 'connect', and 'import'.
> 
>  'refspec' 'spec'::
>  	When using the import command, expect the source ref to have
> @@ -140,9 +144,6 @@ CAPABILITIES
>  	all, it must cover all refs reported by the list command; if
>  	it is not used, it is effectively "*:*"
> 
> -'connect'::
> -	This helper supports the 'connect' command.
> -
>  REF LIST ATTRIBUTES
>  -------------------
> 

Rest looks fine.

Cheers,
Michael
