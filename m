From: "J.H." <warthog19@eaglescrag.net>
Subject: Re: [PATCH] gitweb: Die if there are parsing errors in config file
Date: Sun, 07 Feb 2010 02:53:47 -0800
Message-ID: <4B6E9BBB.4000904@eaglescrag.net>
References: <20100207093744.29846.6468.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 07 11:53:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ne4m4-0001uu-Ag
	for gcvg-git-2@lo.gmane.org; Sun, 07 Feb 2010 11:53:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933527Ab0BGKxv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Feb 2010 05:53:51 -0500
Received: from shards.monkeyblade.net ([198.137.202.13]:33040 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932087Ab0BGKxu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Feb 2010 05:53:50 -0500
Received: from voot-cruiser.eaglescrag.net (c-71-202-189-206.hsd1.ca.comcast.net [71.202.189.206])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.3/8.14.3) with ESMTP id o17ArlDW013949
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
	Sun, 7 Feb 2010 02:53:48 -0800
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.95.3 at shards.monkeyblade.net
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.7) Gecko/20100120 Fedora/3.0.1-1.fc12 Lightning/1.0b2pre Thunderbird/3.0.1
In-Reply-To: <20100207093744.29846.6468.stgit@localhost.localdomain>
X-Enigmail-Version: 1.0
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.3 (shards.monkeyblade.net [198.137.202.13]); Sun, 07 Feb 2010 02:53:49 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139230>

I'd sign-off that, I've probably run into it a couple of times myself.

- John 'Warthog9' Hawley

On 02/07/2010 01:40 AM, Jakub Narebski wrote:
> Otherwise the errors can propagate, and show in damnest places, and
> you would spend your time chasing ghosts instead of debugging real
> problem (yes, it is from personal experience).
> 
> This follows (parts of) advice in `perldoc -f do` documentation.
> 
> Signed-off-by: Jakub Narebski <jnareb@gmail.com>
> ---
> This is fallout from my work on [split] "Gitweb output caching" series.
> Before I used `die $@ if $@;' in t/t9503/test_cache_interface.pl, tests
> failed for no discernable reason...
> 
> So I think the same should be done for the gitweb config file.
> 
>  gitweb/gitweb.perl |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 1f6978a..a5bc359 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -556,6 +556,8 @@ if (-e $GITWEB_CONFIG) {
>  	our $GITWEB_CONFIG_SYSTEM = $ENV{'GITWEB_CONFIG_SYSTEM'} || "++GITWEB_CONFIG_SYSTEM++";
>  	do $GITWEB_CONFIG_SYSTEM if -e $GITWEB_CONFIG_SYSTEM;
>  }
> +# die if there are errors parsing config file
> +die $@ if $@;
>  
>  # Get loadavg of system, to compare against $maxload.
>  # Currently it requires '/proc/loadavg' present to get loadavg;
> 
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
