From: "J.H." <warthog9@eaglescrag.net>
Subject: Re: [RFC PATCH 00/10] gitweb: Simple file based output caching
Date: Sat, 23 Jan 2010 11:55:29 -0800
Message-ID: <4B5B5431.6050808@eaglescrag.net>
References: <1263432185-21334-10-git-send-email-warthog9@eaglescrag.net> <cover.1264198194.git.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "John 'Warthog9' Hawley" <warthog9@kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 23 20:56:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYm5h-0001xw-L8
	for gcvg-git-2@lo.gmane.org; Sat, 23 Jan 2010 20:56:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753097Ab0AWT4O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Jan 2010 14:56:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753074Ab0AWT4N
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jan 2010 14:56:13 -0500
Received: from shards.monkeyblade.net ([198.137.202.13]:44864 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752995Ab0AWT4M (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jan 2010 14:56:12 -0500
Received: from voot-cruiser.eaglescrag.net (c-71-202-189-206.hsd1.ca.comcast.net [71.202.189.206])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.3/8.14.3) with ESMTP id o0NJtTZu022435
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
	Sat, 23 Jan 2010 11:55:30 -0800
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.95.3 at shards.monkeyblade.net
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.5) Gecko/20091209 Fedora/3.0-4.fc12 Lightning/1.0pre Thunderbird/3.0
In-Reply-To: <cover.1264198194.git.jnareb@gmail.com>
X-Enigmail-Version: 1.0
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.3 (shards.monkeyblade.net [198.137.202.13]); Sat, 23 Jan 2010 11:55:30 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137855>

Just a heads up I wasn't able to get to these yesterday (Friday), but
I'll try and work in looking these over come Monday.

- John 'Warthog9' Hawley

On 01/22/2010 04:27 PM, Jakub Narebski wrote:
> This 10 patches long patch series is intended as proof of concept
> for splitting large 'gitweb: File based caching layer (from git.kernel.org)'
> mega-patch by John 'Warthog9' Hawley aka J.H., by starting small and
> adding features piece by piece.
> 
> This patch is meant as replacement for last two patches:
> * [PATCH 8/9] gitweb: Convert output to using indirect file handle
>   Message-ID: <1263432185-21334-9-git-send-email-warthog9@eaglescrag.net>
> * [PATCH 9/9] gitweb: File based caching layer (from git.kernel.org)
>   Message-ID: <1263432185-21334-10-git-send-email-warthog9@eaglescrag.net>
> 
> in the long patch series by J.H.
> * [PATCH 0/9] Gitweb caching v5
>   http://thread.gmane.org/gmane.comp.version-control.git/136913
> 
> Note that this patch series is part of 'gitweb/cache-kernel' branch of
> http://repo.or.cz/w/git/jnareb-git.git repository (gitweb link), built
> on top of modified patches from 'Gitweb caching v2' series (from
> 'gitweb-ml-v2' branch of http://git.kernel.org/?p=git/warthog9/gitweb.git
> repository).  Therefore they might not apply as straight replacements
> on top of early parts of 'gitweb-ml-v5' branch.
> 
> This is work in progress (showing how I see introducing output caching
> to gitweb), it lacks proper documentation (POD for gitweb/cache.pm,
> new configuration variables in gitweb/README, perhaps "Gitweb caching"
> section in gitweb/README and gitweb/cache.pm mentioned in gitweb/INSTALL),
> and commits/patches marked '(WIP)' lacks proper commit message.
> 
> Just food for thought...
> 
> Table of contents:
> ~~~~~~~~~~~~~~~~~~
>  [RFC PATCH 01/10] gitweb: Print to explicit filehandle (preparing
>                    for caching)
>  [RFC PATCH 02/10] gitweb: href(..., -path_info => 0|1)
>  [RFC PATCH 03/10] gitweb/cache.pm - Very simple file based caching
>  [RFC PATCH 04/10] gitweb/cache.pm - Stat-based cache expiration
>  [RFC PATCH 05/10] gitweb: Use Cache::Cache compatibile (get, set)
>                    output caching (WIP)
>  [RFC PATCH 06/10] gitweb/cache.pm - Adaptive cache expiration time (WIP)
>  [RFC PATCH 07/10] gitweb: Use CHI compatibile (compute method) caching (WIP)
>  [RFC PATCH 08/10] gitweb/cache.pm - Use locking to avoid 'stampeding herd'
>                    problem (WIP)
>  [RFC PATCH 09/10] gitweb/cache.pm - Serve stale data when waiting for
>                    filling cache (WIP)
>  [RFC PATCH 10/10] gitweb: Show appropriate "Generating..." page when
>                    regenerating cache (WIP)
> 
> 
> Diffstat:
> ~~~~~~~~~
> 
>  gitweb/cache.pm                        |  566 ++++++++++
>  gitweb/gitweb.perl                     | 1923 +++++++++++++++++---------------
>  t/gitweb-lib.sh                        |    2 +
>  t/t9500-gitweb-standalone-no-errors.sh |   13 +
>  t/t9503-gitweb-caching.sh              |   32 +
>  t/t9503/test_cache_interface.pl        |  195 ++++
>  t/test-lib.sh                          |    3 +
>  7 files changed, 1836 insertions(+), 898 deletions(-)
>  create mode 100644 gitweb/cache.pm
>  create mode 100755 t/t9503-gitweb-caching.sh
>  create mode 100755 t/t9503/test_cache_interface.pl
