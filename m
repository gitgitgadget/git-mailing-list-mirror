From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2] rev-parse: Check argc before using argv[i+1]
Date: Tue, 28 Jan 2014 23:01:17 +0100
Message-ID: <52E828AD.2040609@kdbg.org>
References: <CAJL_ekuMJByFDVLMCYD4fo9EQy3LKdohsw25WfHqJv9M=3S9Kw@mail.gmail.com> <1390944060-783-1-git-send-email-dhsharp@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: David Sharp <dhsharp@google.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 28 23:01:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W8Gix-0007Jr-Jw
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jan 2014 23:01:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755836AbaA1WBf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jan 2014 17:01:35 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:36656 "EHLO lbmfmo03.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755828AbaA1WBf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jan 2014 17:01:35 -0500
Received: from bsmtp.bon.at (unknown [192.168.181.107])
	by lbmfmo03.bon.at (Postfix) with ESMTP id 14ABDCE0E9
	for <git@vger.kernel.org>; Tue, 28 Jan 2014 23:01:32 +0100 (CET)
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id D91D313006C;
	Tue, 28 Jan 2014 23:01:19 +0100 (CET)
Received: from dx.sixt.local (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 998D519F3AD;
	Tue, 28 Jan 2014 23:01:18 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <1390944060-783-1-git-send-email-dhsharp@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241195>

Am 28.01.2014 22:21, schrieb David Sharp:
> @@ -738,9 +740,12 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
>  				continue;
>  			}
>  			if (!strcmp(arg, "--resolve-git-dir")) {
> -				const char *gitdir = resolve_gitdir(argv[i+1]);
> +				const char *gitdir = argv[++i];
>  				if (!gitdir)
> -					die("not a gitdir '%s'", argv[i+1]);
> +					die("--resolve-git-dir requires an argument");
> +				gitdir = resolve_gitdir(gitdir);
> +				if (!gitdir)
> +					die("not a gitdir '%s'", argv[i]);
>  				puts(gitdir);
>  				continue;
>  			}

In this hunk, I don't see where the old code incremented i for the
argument. Was this another bug lurking that is fixed now?

-- Hannes
