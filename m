From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rev-parse: teach "--verify" to be quiet when using "-q"
 or "--quiet"
Date: Sat, 26 Apr 2008 23:16:59 -0700
Message-ID: <7vabjfizz8.fsf@gitster.siamese.dyndns.org>
References: <20080426135723.2b9e7c16.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sun Apr 27 08:18:02 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jq0D3-0001wP-M4
	for gcvg-git-2@gmane.org; Sun, 27 Apr 2008 08:18:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752002AbYD0GRP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Apr 2008 02:17:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751954AbYD0GRP
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Apr 2008 02:17:15 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:62113 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751246AbYD0GRO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Apr 2008 02:17:14 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 8381D4F6D;
	Sun, 27 Apr 2008 02:17:13 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id D10E84F6C; Sun, 27 Apr 2008 02:17:08 -0400 (EDT)
In-Reply-To: <20080426135723.2b9e7c16.chriscool@tuxfamily.org> (Christian
 Couder's message of "Sat, 26 Apr 2008 13:57:23 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80418>

Christian Couder <chriscool@tuxfamily.org> writes:

> Currently "git rev-parse --verify <something>" is often used with
> its error output redirected to /dev/null. This patch makes it
> easier to do that.
>
> The -q|--quiet option is designed to work the same way as it does
> for "git symbolic-ref".
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  Documentation/git-rev-parse.txt |    5 +++++
>  builtin-rev-parse.c             |   20 ++++++++++++++++----
>  2 files changed, 21 insertions(+), 4 deletions(-)
>
> 	By the way it's strange that for example:
>
> 	$ git rev-parse --verify <good-rev> <junk>
>
> 	works whatever <junk> is, as long as <good-rev> can be
> 	parsed.

Very much so.  The earlier plumbing programs tend to have this "works if
you give correct input but sometimes ignores bogosity" tendency.  They are
loose not by design, and we should be able to tighten without worrying
about breaking existing scripts.
