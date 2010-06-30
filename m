From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 3/3] git-instaweb: Don't assume Apache executable is
	named apache2
Date: Wed, 30 Jun 2010 07:31:53 +0000
Message-ID: <20100630073153.GA25218@dcvr.yhbt.net>
References: <1277865900-25044-1-git-send-email-dpmcgee@gmail.com> <1277865900-25044-3-git-send-email-dpmcgee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dan McGee <dpmcgee@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 30 09:32:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTrm8-0003XX-EC
	for gcvg-git-2@lo.gmane.org; Wed, 30 Jun 2010 09:32:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752889Ab0F3Hbz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jun 2010 03:31:55 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:37917 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752855Ab0F3Hbx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jun 2010 03:31:53 -0400
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 59E151F510;
	Wed, 30 Jun 2010 07:31:53 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1277865900-25044-3-git-send-email-dpmcgee@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149949>

Dan McGee <dpmcgee@gmail.com> wrote:
> On Arch Linux, we keep the original 'httpd' name for the exectuable and
> don't rename it or the path to the modules. Remove some of these assumptions
> and add the httpd name in where it may be required.
> 
> Signed-off-by: Dan McGee <dpmcgee@gmail.com>

Thanks Dan,

Everything in this series looks reasonable to me (haven't tested):

Acked-by: Eric Wong <normalperson@yhbt.net>

> --- a/git-instaweb.sh
> +++ b/git-instaweb.sh
>  apache2_conf () {
> -	test -z "$module_path" && module_path=/usr/lib/apache2/modules
> +	if test -z "$module_path"; then
> +		test -d "/usr/lib/httpd/modules" && module_path="/usr/lib/httpd/modules"
> +		test -d "/usr/lib/apache2/modules" && module_path="/usr/lib/apache2/modules"
> +	fi

Minor style nitpicks (feel free to ignore unless somebody else feels
more strongly):

The preferred style in git is to have the "then" statement on a separate
line, omitting the semi-colon, but there remain plenty of examples
contrary in our code:

Likewise with "for i in x y z; do"

We also prefer to keep lines shorter than 80 characters (hard tabs being
8 chars), but we also have plenty of examples contrary to that in
instaweb, too :x

-- 
Eric Wong
