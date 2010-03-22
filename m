From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH v4] Improve remote-helpers documentation
Date: Mon, 22 Mar 2010 12:32:31 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.1003221143250.14365@iabervon.org>
References: <f3271551003220604v4c9fbb5ep3b7c69300567a275@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 22 17:32:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtkYX-0004ld-0I
	for gcvg-git-2@lo.gmane.org; Mon, 22 Mar 2010 17:32:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755246Ab0CVQch (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Mar 2010 12:32:37 -0400
Received: from iabervon.org ([66.92.72.58]:33780 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755232Ab0CVQcd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Mar 2010 12:32:33 -0400
Received: (qmail 6780 invoked by uid 1000); 22 Mar 2010 16:32:31 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 22 Mar 2010 16:32:31 -0000
In-Reply-To: <f3271551003220604v4c9fbb5ep3b7c69300567a275@mail.gmail.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142943>

Looks good, other than an optional suggestion below. Incidentally, it's 
often helpful to describe the differences between earlier versions and v4 
of the patch between the "---" and the diffstat; that part of the email 
doesn't go into the commit, but can be seen by reviewers.

On Mon, 22 Mar 2010, Ramkumar Ramachandra wrote:

> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  Documentation/git-remote-helpers.txt |   40 +++++++++++++++++----------------
>  1 files changed, 21 insertions(+), 19 deletions(-)
> 
> diff --git a/Documentation/git-remote-helpers.txt
> b/Documentation/git-remote-helpers.txt
> index 1b5f61a..2d5aa8c 100644
> --- a/Documentation/git-remote-helpers.txt
> +++ b/Documentation/git-remote-helpers.txt
> @@ -3,7 +3,7 @@ git-remote-helpers(1)
> 
>  NAME
>  ----
> -git-remote-helpers - Helper programs for interoperation with remote git
> +git-remote-helpers - Helper programs for interacting with remote repositories
> 
>  SYNOPSIS
>  --------
> @@ -13,10 +13,23 @@ DESCRIPTION
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
> +the remote helper protocol. Remote helpers are spawned as binaries by
> +the main git programs and interact using text streams, without
> +linking.
> +
> +The curl helper is one such program. It is invoked via
> +'git-remote-http', 'git-remote-https', 'git-remote-ftp', or
> +'git-remote-ftps', and implments the capabilities 'fetch', 'option',
> +and 'push'. The curl helper essentially helps in transporting native
> +git objects.
> +
> +As opposed to native git objects, remote helpers can also provide a
> +fast-import stream through the 'import' capability. This makes them
> +especially useful when native interoperability with a foreign
> +versioning system is desired.
> 
>  COMMANDS
>  --------
> @@ -118,17 +131,9 @@ capabilities reported by the helper.
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

This is, indeed, what I was suggesting, although I think it might be more 
readable like:

'fetch'::
'option'::
'push'::
'connect'::
'import'::
	This helper supports the corresponding command with the same name.

But I'm fine with whichever format is most helpful for someone trying to 
read the document (that is, to you).

	-Daniel
*This .sig left intentionally blank*
