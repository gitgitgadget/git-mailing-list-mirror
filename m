From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-mergetool: add support for ediff
Date: Sat, 30 Jun 2007 10:19:33 -0700
Message-ID: <7vk5tle4wq.fsf@assigned-by-dhcp.cox.net>
References: <1183193781941-git-send-email-sam.vilain@catalyst.net.nz>
	<11831937813223-git-send-email-sam.vilain@catalyst.net.nz>
	<11831937822346-git-send-email-sam.vilain@catalyst.net.nz>
	<11831937823184-git-send-email-sam.vilain@catalyst.net.nz>
	<11831937823982-git-send-email-sam.vilain@catalyst.net.nz>
	<1183193782172-git-send-email-sam.vilain@catalyst.net.nz>
	<11831937822249-git-send-email-sam.vilain@catalyst.net.nz>
	<11831937823756-git-send-email-sam.vilain@catalyst.net.nz>
	<11831937822950-git-send-email-sam.vilain@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, tytso@mit.edu
To: Sam Vilain <sam.vilain@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Sat Jun 30 19:19:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I4gbp-0005lz-PH
	for gcvg-git@gmane.org; Sat, 30 Jun 2007 19:19:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757321AbXF3RTn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Jun 2007 13:19:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756845AbXF3RTg
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jun 2007 13:19:36 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:54132 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756422AbXF3RTf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jun 2007 13:19:35 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070630171935.HYOD1594.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Sat, 30 Jun 2007 13:19:35 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id HtKZ1X00H1kojtg0000000; Sat, 30 Jun 2007 13:19:34 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51227>

Sam Vilain <sam.vilain@catalyst.net.nz> writes:

> There was emerge already but I much prefer this mode.

I thought Ted said he'll look into clearning this up, so I won't
apply it yet at this moment to my tree, but have one comment...

> @@ -320,15 +329,15 @@ if test -z "$merge_tool" ; then
>          fi
>      fi
>      if echo "${VISUAL:-$EDITOR}" | grep 'emacs' > /dev/null 2>&1; then
> -        merge_tool_candidates="$merge_tool_candidates emerge"
> +        merge_tool_candidates="$merge_tool_candidates emerge ediff"
>      fi
>      if echo "${VISUAL:-$EDITOR}" | grep 'vim' > /dev/null 2>&1; then
>          merge_tool_candidates="$merge_tool_candidates vimdiff"
>      fi
> -    merge_tool_candidates="$merge_tool_candidates opendiff emerge vimdiff"
> +    merge_tool_candidates="$merge_tool_candidates opendiff ediff emerge vimdiff"
>      echo "merge tool candidates: $merge_tool_candidates"

So by default outside X environment, if your $EDITOR is emacs,
you would use emerge and not ediff, but if your $EDITOR is unset
and have emacs in your $PATH you would use ediff not emerge?
