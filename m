From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2] alias: use run_command api to execute aliases
Date: Thu, 6 Jan 2011 14:05:18 -0600
Message-ID: <20110106200518.GA14945@burratino>
References: <1294343649-6272-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, msysgit@googlegroups.com, j6t@kdbg.org
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 06 21:05:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Paw5i-0006eK-9O
	for gcvg-git-2@lo.gmane.org; Thu, 06 Jan 2011 21:05:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753440Ab1AFUFc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Jan 2011 15:05:32 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:40013 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753412Ab1AFUFb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jan 2011 15:05:31 -0500
Received: by vws16 with SMTP id 16so6933932vws.19
        for <git@vger.kernel.org>; Thu, 06 Jan 2011 12:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=T7EudADdFx9EAAHQfJMbpm//qgYwHJ/UCEZLi4P5ZWw=;
        b=PIVSOIHv0c0AjCPZzxyoJNOXA9gX8/FWXU1SZDkEAnwPUIbmW2HiFS3Anyaf8tdMlL
         fd/Uj7UBzQ5XZa8Uag/KUnswScjWZHOGuQIjtuVPXLrNaDCsSI83Lg1w8UtV5Gcc5M5W
         yd6AZ5BOnCOugShSA0BxYE5fCDiGr093CzM50=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=HYHm5Z8gFj8/6YFWsKNf8n5LWjYssyOVZx79Gw85Q9iVNmOmDTVSS6ENuCpRIK84Su
         drW3tN4Idxc8XEUBJjqh3UMFYGjbqcCq0Vf6qW9VX6vaw+79gUL/KKxdGS1urKW3nJpc
         3d5xwQNhzTvQ5aKmEv0fy34eRojk6+iuyb1b8=
Received: by 10.220.180.11 with SMTP id bs11mr7956861vcb.138.1294344330092;
        Thu, 06 Jan 2011 12:05:30 -0800 (PST)
Received: from burratino (adsl-69-209-72-219.dsl.chcgil.ameritech.net [69.209.72.219])
        by mx.google.com with ESMTPS id v26sm5428654vcr.37.2011.01.06.12.05.27
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 06 Jan 2011 12:05:28 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1294343649-6272-1-git-send-email-kusmabite@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164664>

Erik Faye-Lund wrote:

> --- a/git.c
> +++ b/git.c
> @@ -177,22 +177,22 @@ static int handle_alias(int *argcp, const char ***argv)
[...]
> +			alias_argv = xmalloc(sizeof(char *) * argc + 1);

Missed a spot?  (missing parens)

Thanks for this.  It also should provide a minor speedup in the case
of commands with no shell metacharacters.
