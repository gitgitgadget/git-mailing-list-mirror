From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Patch for NO_R_TO_GCC_LINKER
Date: Wed, 13 Aug 2008 13:10:51 -0700
Message-ID: <7vy730n0ac.fsf@gitster.siamese.dyndns.org>
References: <c475e2e60808130342r452fae1cm7d08d8d2206d0468@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Giovanni Funchal" <gafunchal@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 13 22:28:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTMhQ-000763-0A
	for gcvg-git-2@gmane.org; Wed, 13 Aug 2008 22:12:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752403AbYHMULB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2008 16:11:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752166AbYHMULB
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Aug 2008 16:11:01 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:47525 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752003AbYHMULA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2008 16:11:00 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 5D605541C7;
	Wed, 13 Aug 2008 16:10:56 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id AF1C5541C5; Wed, 13 Aug 2008 16:10:53 -0400 (EDT)
In-Reply-To: <c475e2e60808130342r452fae1cm7d08d8d2206d0468@mail.gmail.com>
 (Giovanni Funchal's message of "Wed, 13 Aug 2008 12:42:30 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F03D6E02-6973-11DD-B04E-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92264>

"Giovanni Funchal" <gafunchal@gmail.com> writes:

> diff --git a/Makefile b/Makefile
> index 90c5a13..6e20b08 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -111,9 +111,8 @@ all::
>  #
>  # Define NO_DEFLATE_BOUND if your zlib does not have deflateBound.
>  #
> -# Define NO_R_TO_GCC_LINKER if your gcc does not like "-R/path/lib"
> -# that tells runtime paths to dynamic libraries;
> -# "-Wl,-rpath=/path/lib" is used instead.
> +# LD_RUNPATH_SWITCH specifies how to pass the runtime dynamic library paths
> +# to the linker. The default is "-Wl,-rpath,".

Can you make your change to configure.ac to minimize changes to the
Makefile?

In this project, use of configure is strictly optional and Makefile is
more canonical than autoconf generated configure.  Unless absolutely
necessary, I'd prefer to have a solution that does _not_ change the set of
make variables people need to override from the command line.

Changes to configure.ac so that generated script sets NO_R_TO_GCC_LINKER
appropriately would fit the current model much better and would not break
people's existing setups that do not use configure.
