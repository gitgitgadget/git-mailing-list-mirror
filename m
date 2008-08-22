From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] git-submodule: replace duplicated code with a
 module_list function
Date: Fri, 22 Aug 2008 15:53:40 -0700
Message-ID: <7vpro064qz.fsf@gitster.siamese.dyndns.org>
References: <edc9ece47ca86c3c3e4265e7f4222c8ea6917461.1219390139.git.davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Mark Levedahl <mlevedahl@gmail.com>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 23 00:54:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWfWt-0002pi-QH
	for gcvg-git-2@gmane.org; Sat, 23 Aug 2008 00:54:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753514AbYHVWxs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 18:53:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752441AbYHVWxs
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 18:53:48 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:46628 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752165AbYHVWxr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 18:53:47 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id D9F6F6458E;
	Fri, 22 Aug 2008 18:53:46 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id EEC616458B; Fri, 22 Aug 2008 18:53:42 -0400 (EDT)
In-Reply-To: <edc9ece47ca86c3c3e4265e7f4222c8ea6917461.1219390139.git.davvid@gmail.com>
 (David Aguilar's message of "Fri, 22 Aug 2008 00:30:50 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2DA33D5A-709D-11DD-A5D2-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93391>

David Aguilar <davvid@gmail.com> writes:

> @@ -54,6 +54,15 @@ resolve_relative_url ()
>  }
>  
>  #
> +# Get submodule info for registered submodules
> +# $@ = path to limit submodule list
> +#
> +module_list()
> +{
> +	git ls-files --stage -- "$@" | grep '^160000 '
> +}
> +
> +#
>  # Map submodule path to submodule name
>  #
>  # $1 = path
> @@ -206,7 +215,7 @@ cmd_add()
>  #
>  cmd_foreach()
>  {
> -	git ls-files --stage | grep '^160000 ' |
> +	module_list |

Thanks.

I think the original "foreach" implementation does not pay attention to
"$@" not by design but by mistake, and we should pass "$@" here as well.

Other than that I do not see anything obviously wrong with the patch.

Mark?
