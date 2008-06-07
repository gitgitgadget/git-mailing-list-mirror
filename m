From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] Add an optional <mode> argument to commit/status
 -u|--untracked-files option
Date: Fri, 06 Jun 2008 18:55:36 -0700
Message-ID: <7v4p86qa93.fsf@gitster.siamese.dyndns.org>
References: <7vod6i1e3p.fsf@gitster.siamese.dyndns.org>
 <5f0ab026ce200e501be81a3b5082e482e1580e42.1212670149.git.marius@trolltech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Marius Storm-Olsen <marius@trolltech.com>
X-From: git-owner@vger.kernel.org Sat Jun 07 03:56:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4nfm-0004tv-Ny
	for gcvg-git-2@gmane.org; Sat, 07 Jun 2008 03:56:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753140AbYFGBz5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2008 21:55:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754454AbYFGBz5
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 21:55:57 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:56797 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753066AbYFGBz4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2008 21:55:56 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E25281908;
	Fri,  6 Jun 2008 21:55:53 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id A8D0C1907; Fri,  6 Jun 2008 21:55:49 -0400 (EDT)
In-Reply-To: <5f0ab026ce200e501be81a3b5082e482e1580e42.1212670149.git.marius@trolltech.com> (Marius Storm-Olsen's message of "Thu, 5 Jun 2008 10:31:19 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: DCD926B8-3434-11DD-963E-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84164>

Marius Storm-Olsen <marius@trolltech.com> writes:

> diff --git a/builtin-commit.c b/builtin-commit.c
> index b294c1f..1f4986b 100644
> --- a/builtin-commit.c
> +++ b/builtin-commit.c
> @@ -102,7 +103,7 @@ static struct option builtin_commit_options[] = {
>  	OPT_BOOLEAN('o', "only", &only, "commit only specified files"),
>  	OPT_BOOLEAN('n', "no-verify", &no_verify, "bypass pre-commit hook"),
>  	OPT_BOOLEAN(0, "amend", &amend, "amend previous commit"),
> -	OPT_BOOLEAN('u', "untracked-files", &untracked_files, "show all untracked files"),
> +	{ OPTION_STRING, 'u', "untracked-files", &untracked_files_arg, "mode", "show untracked files, optional modes: all, normal. (Default: all)", PARSE_OPT_OPTARG, NULL, (int)"all" },

Hmm.

$ make
builtin-commit.c:106: error: initializer element is not constant
builtin-commit.c:106: error: (near initialization for 'builtin_commit_options[18].defval')
make: *** [builtin-commit.o] Error 1

I also have to wonder what the funny cast of (int)"all"  is doing.
