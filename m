From: Rogan Dawes <discard@dawes.za.net>
Subject: Re: [PATCH] tar-tree: add the "tar.applyUmask" config option
Date: Thu, 20 Jul 2006 11:44:26 +0200
Message-ID: <44BF507A.4080801@dawes.za.net>
References: <20060719214025.GA10997@1wt.eu> <7vd5c1jkc3.fsf@assigned-by-dhcp.cox.net> <20060720093044.GA10824@1wt.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 20 11:44:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G3V5D-0000eU-CX
	for gcvg-git@gmane.org; Thu, 20 Jul 2006 11:44:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030217AbWGTJof (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Jul 2006 05:44:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030254AbWGTJoe
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Jul 2006 05:44:34 -0400
Received: from mailbigip2.dreamhost.com ([208.97.132.53]:54735 "EHLO
	spunkymail-a9.dreamhost.com") by vger.kernel.org with ESMTP
	id S1030217AbWGTJoe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jul 2006 05:44:34 -0400
Received: from [192.168.201.66] (dsl-165-2-63.telkomadsl.co.za [165.165.2.63])
	by spunkymail-a9.dreamhost.com (Postfix) with ESMTP id 15C0620811;
	Thu, 20 Jul 2006 02:44:30 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
To: Willy Tarreau <w@1wt.eu>
In-Reply-To: <20060720093044.GA10824@1wt.eu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24025>

Willy Tarreau wrote:
> +int git_tar_config(const char *var, const char *value)
> +{
> +	if (!strcmp(var, "tar.umask")) {
> +		if (!strcmp(value, "user")) {
> +			tar_umask = umask(0);
> +			umask(tar_umask);
> +		} else {
> +			tar_umask = git_config_int(var, value);

Looks like you forgot:
    			umask(tar_umask);

> +		}
> +		return 0;
> +	}
> +	return git_default_config(var, value);
> +}

Or else move it to just before the "return 0;" line.

Rogan
