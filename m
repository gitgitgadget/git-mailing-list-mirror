From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] gitignore(5): explain how to stop tracking a file
Date: Wed, 10 Nov 2010 12:55:55 -0600
Message-ID: <20101110185555.GA12365@burratino>
References: <1289387440-8509-1-git-send-email-sitaram@atc.tcs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Sitaram Chamarty <sitaram@atc.tcs.com>
X-From: git-owner@vger.kernel.org Wed Nov 10 19:56:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGFqK-00047p-Fg
	for gcvg-git-2@lo.gmane.org; Wed, 10 Nov 2010 19:56:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755178Ab0KJS4U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Nov 2010 13:56:20 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:63697 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753298Ab0KJS4T (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Nov 2010 13:56:19 -0500
Received: by fxm16 with SMTP id 16so654354fxm.19
        for <git@vger.kernel.org>; Wed, 10 Nov 2010 10:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=oaPMjszZJo4ZCqkMwxSnkMcvqGX4H/MaTnHQpVIZPIY=;
        b=yD4ix8/O5/BUq6rllyb7wthi/V2fXoiD+ZCPG4G2a7OF9CenzuFt0Ge9OuuWb62BUX
         J4WAtkn6zZIBU+0YUZCgy1qlEZFi/her0VYUSwDxoFjfPAqC0X/W1FDFDET8aIJk5nxA
         MnuNfIgEwZyhTOxv0iZp0PnED8U/KbT+bgCPw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=mKVmCNUKRNX4lRoNc2rEjoP6z8B0CykeScUu+bOtjVaEDf66xI1mWwdPyeGhiSogLT
         ppPHvM7ZbOfrBCl6LshwcplAIf7URNA3Vw2rEtJRKkHXYLMLe6WyP7y+oe7o6UlhXVep
         ObwN/RwVo4JiFunomDBMpxSTmxe0N1KzxEoFQ=
Received: by 10.204.100.79 with SMTP id x15mr8603395bkn.10.1289415378057;
        Wed, 10 Nov 2010 10:56:18 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id k21sm494532faa.1.2010.11.10.10.56.15
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 10 Nov 2010 10:56:17 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1289387440-8509-1-git-send-email-sitaram@atc.tcs.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161169>

Sitaram Chamarty wrote:

> --- a/Documentation/gitignore.txt
> +++ b/Documentation/gitignore.txt
> @@ -18,7 +18,8 @@ Note that all the `gitignore` files really concern only files
>  that are not already tracked by git;
>  in order to ignore uncommitted changes in already tracked files,
>  please refer to the 'git update-index --assume-unchanged'
> -documentation.
> +documentation.  To stop tracking a file that is currently tracked,
> +use 'git rm --cached'.

Ack.  But I fear this makes the gitignore page feel even more top-heavy
than it already is.

The current structure is:

	SYNOPSIS
	[list of excludes files]

	DESCRIPTION
	One-sentence description.  Long comment about some totally
	different command.

	Description of structure.  Long comment about precedence rules:

	. some rules
	...

	Paragraph about which excludes file works for which use case.

	Paragraph about which commands pay attention to excludes files.

	Patterns have the following format:

	. some rules
	...

	An example:

	 transcript

	Another example:

	 transcript

	Quick analysis.

	DOCUMENTATION
	Various people's names.

	GIT
	Part of the git(1) suite.

It's a wonder people can find anything there. :)  So how about this?

Patch 1 splits the description into three sections.  Yes, having the
PATTERN FORMAT section is not part of the conventional list in
man-pages(7), but I think it's easier to find the interesting part
this way.

Patch 2 puts the comments about related commands in a separate NOTES
section.

This way, one could expand on the "stop tracking file" procedure
without interrupting the flow of the basic description of what
excludes files do, by adding to the NOTES or EXAMPLES section.

Thoughts?

Jonathan Nieder (2):
  Documentation: split gitignore page into sections
  Documentation: point to related commands from gitignore

 Documentation/gitignore.txt |   30 +++++++++++++++++++++++-------
 1 files changed, 23 insertions(+), 7 deletions(-)

-- 
1.7.2.3.557.gab647.dirty
