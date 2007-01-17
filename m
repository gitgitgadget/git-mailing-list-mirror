From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] Add a suffix option to git-format-patch
Date: Wed, 17 Jan 2007 14:49:50 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701171446410.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <625fc13d0701170510x8883539g93f43d9ddffe56f0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jan 17 14:50:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7BAo-0006K7-Rx
	for gcvg-git@gmane.org; Wed, 17 Jan 2007 14:49:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932174AbXAQNtx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 Jan 2007 08:49:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932101AbXAQNtw
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jan 2007 08:49:52 -0500
Received: from mail.gmx.net ([213.165.64.20]:40640 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932174AbXAQNtw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jan 2007 08:49:52 -0500
Received: (qmail invoked by alias); 17 Jan 2007 13:49:50 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp054) with SMTP; 17 Jan 2007 14:49:50 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Josh Boyer <jwboyer@gmail.com>
In-Reply-To: <625fc13d0701170510x8883539g93f43d9ddffe56f0@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37002>

Hi,

On Wed, 17 Jan 2007, Josh Boyer wrote:

> Could we add an option to git-format-patch to use ".patch" as the file
> suffix instead of ".txt"?  Something like the below?
> 
> diff --git a/builtin-log.c b/builtin-log.c
> index a59b4ac..4eb2d32 100644
> --- a/builtin-log.c
> +++ b/builtin-log.c
> @@ -217,6 +217,7 @@ static int git_format_config(const char *var,
> const char *value)
> 
> static FILE *realstdout = NULL;
> static const char *output_directory = NULL;
> +static int psuffix = 0;

Why not

	static const char *file_extension = ".txt"

Hmm?

> 	}
> -	strcpy(filename + len, ".txt");

Here, you would write

	strcpy(filename + len, file_extension);

> @@ -436,6 +441,8 @@ int cmd_format_patch(int argc, const char **argv,
> const char *prefix)
> 				die("Need a Message-Id for --in-reply-to");
> 			in_reply_to = argv[i];
> 		}
> +		else if (!strcmp(argv[i], "--psuffix"))
> +			psuffix = 1;

and here:

		else if (!strncmp(argv[i], "--extension=", 12))
			file_extension = argv[i] + 12;

You'd call it with "--extension=.patch", and if you really want, you can 
make a config variable from it.

Ciao,
Dscho
