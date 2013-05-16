From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCHv2] git-submodule.txt:  Clarify 'init' and 'add' subcommands.
Date: Thu, 16 May 2013 20:50:58 +0200
Message-ID: <51952A92.5030009@web.de>
References: <201305152246.r4FMkVW5005582@freeze.ariadne.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Dale R. Worley" <worley@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu May 16 20:51:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ud3Gj-0001M7-Vi
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 20:51:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751481Ab3EPSvK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 14:51:10 -0400
Received: from mout.web.de ([212.227.17.11]:54365 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750835Ab3EPSvI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 14:51:08 -0400
Received: from [192.168.178.41] ([91.3.188.160]) by smtp.web.de (mrweb001)
 with ESMTPA (Nemesis) id 0M1Wxd-1UNZmT20vB-00txUf; Thu, 16 May 2013 20:51:04
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130509 Thunderbird/17.0.6
In-Reply-To: <201305152246.r4FMkVW5005582@freeze.ariadne.com>
X-Enigmail-Version: 1.5.1
X-Provags-ID: V02:K0:B1e314xXhxnwKOgvf8X/0FfkyxamHBuD11wvIXb5x9U
 xDdIx+gdpL7w1oM/w672bxrbxNHhgwMoFPWe1YUqA46KHfl/qx
 lXOoVCRGuYCVn1FUMHgiXhj6BfDBOhQPpeHl1UJDZdYh0yvT7E
 oPl40TpXJWUcUnVw1BvEn7dy+LTz3OeISVz/vgKxCLAWGc2mGl
 Sw9rkFuUygpAoy8fmnZ2A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224610>

Am 16.05.2013 00:28, schrieb Dale R. Worley:
> Describe how 'add' sets the submodule's logical name, which is used in
> the configuration entry names.
> 
> Clarify that 'init' only sets up the configuration entries for
> submodules that have already been added elsewhere.  Describe that
> <path> arguments limit the submodules that are configured.
> 
> Signed-off-by: Dale Worley <worley@ariadne.com>

Thanks, this patch addresses all issues raised.

Acked-by: Jens Lehmann <Jens.Lehmann@web.de>

> ---
> This patch seems to have all the features that we have discussed:
> 
> - Describes how 'add' selects the submodule logical name, including
>   the effect of --name.  (My first patch was on a version of Git that
>   did not support --name, so I didn't know of it.)
> 
> - Corrects description of 'init' to clarify that its behavior is
>   driven by the gitlinks recorded in the index, rather than implying
>   it is driven by the contents of .gitmodules.
> 
> - Describes 'init' behavior to be driven by the index, rather than my
>   previous incorrect use of "file tree".  (Of course, gitlinks aren't
>   visible in the file tree.)
> 
> - Updated text for 'init' is shorter and less technical than my
>   previous patch.
> 
> - Since "(which were added and committed elsewhere)" is stated in the
>   first sentence, I've removed the later sentence explaining that
>   submodules must be added before they can be inited.
> 
> - Explains the effect of <path> arguments to 'init' subcommand.
> 
>  Documentation/git-submodule.txt |    8 ++++++--
>  1 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
> index c99d795..83235c0 100644
> --- a/Documentation/git-submodule.txt
> +++ b/Documentation/git-submodule.txt
> @@ -76,6 +76,8 @@ argument <path> is the relative location for the cloned submodule
>  to exist in the superproject. If <path> is not given, the
>  "humanish" part of the source repository is used ("repo" for
>  "/path/to/repo.git" and "foo" for "host.xz:foo/.git").
> +The <path> is also used as the submodule's logical name in its
> +configuration entries unless `--name` is used to specify a logical name.
>  +
>  <repository> is the URL of the new submodule's origin repository.
>  This may be either an absolute URL, or (if it begins with ./
> @@ -123,8 +125,10 @@ linkgit:git-status[1] and linkgit:git-diff[1] will provide that information
>  too (and can also report changes to a submodule's work tree).
>  
>  init::
> -	Initialize the submodules, i.e. register each submodule name
> -	and url found in .gitmodules into .git/config.
> +	Initialize the submodules recorded in the index (which were
> +	added and committed elsewhere) by copying submodule
> +	names and urls from .gitmodules to .git/config.
> +	Optional <path> arguments limit which submodules will be initialized.
>  	It will also copy the value of `submodule.$name.update` into
>  	.git/config.
>  	The key used in .git/config is `submodule.$name.url`.
> 
