From: "J.H." <warthog9@eaglescrag.net>
Subject: Re: [PATCH] gitweb: highlight: replace tabs with spaces
Date: Wed, 16 Mar 2011 15:48:47 -0700
Message-ID: <4D813E4F.1030304@eaglescrag.net>
References: <6ac7d48cfdf4192c3240c1ecbd4e5522@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Kevin Cernekee <cernekee@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 16 23:49:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzzWT-00021b-HT
	for gcvg-git-2@lo.gmane.org; Wed, 16 Mar 2011 23:48:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753194Ab1CPWsx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2011 18:48:53 -0400
Received: from shards.monkeyblade.net ([198.137.202.13]:42888 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751688Ab1CPWsv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2011 18:48:51 -0400
Received: from voot-cruiser.eaglescrag.net (c-71-202-185-40.hsd1.ca.comcast.net [71.202.185.40])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.4/8.14.4) with ESMTP id p2GMmlHL025333
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
	Wed, 16 Mar 2011 15:48:48 -0700
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Lightning/1.0b2pre Thunderbird/3.0.10
In-Reply-To: <6ac7d48cfdf4192c3240c1ecbd4e5522@localhost>
X-Enigmail-Version: 1.0.1
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.3 (shards.monkeyblade.net [198.137.202.13]); Wed, 16 Mar 2011 15:48:48 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169206>

On 03/16/2011 03:34 PM, Kevin Cernekee wrote:
> Consider the following code fragment:
> 
>         /*
>          * test
>          */
> 
> vim ":set list" mode shows that the first character on each line is a
> tab:
> 
> ^I/*$
> ^I * test$
> ^I */$
> 
> By default, the "highlight" program will retain the tabs in the HTML
> output:
> 
> $ highlight --fragment --syntax c test.c
>         <span class="hl com">/*</span>
> <span class="hl com">    * test</span>
> <span class="hl com">    */</span>
> 
> vim list mode:
> 
> ^I<span class="hl com">/*</span>$
> <span class="hl com">^I * test</span>$
> <span class="hl com">^I */</span>$
> 
> In gitweb, this winds up looking something like:
> 
>    1         /*
>    2     * test
>    3     */
> 
> I tried both Firefox and Opera and saw the same behavior.
> 
> The desired output is:
> 
>    1         /*
>    2          * test
>    3          */
> 
> This can be accomplished by specifying "--replace-tabs=8" on the
> highlight command line.
> 
> Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
> ---
>  gitweb/gitweb.perl |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index d171ad5..649e10a 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -3485,7 +3485,7 @@ sub run_highlighter {
>  	close $fd;
>  	open $fd, quote_command(git_cmd(), "cat-file", "blob", $hash)." | ".
>  	          quote_command($highlight_bin).
> -	          " --fragment --syntax $syntax |"
> +	          " --replace-tabs=8 --fragment --syntax $syntax |"
>  		or die_error(500, "Couldn't open file or run syntax highlighter");
>  	return $fd;
>  }

Looks fine to me.

- John 'Warthog9' Hawley
