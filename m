From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH v2] send-email: fix mutt regex for grouped aliases
Date: Wed, 30 Sep 2009 13:55:01 -0700
Message-ID: <20090930205501.GA30910@dcvr.yhbt.net>
References: <20090930112833.GA4984@sigio.peff.net> <1254322176-4561-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 30 22:55:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mt6Cq-0006h7-BV
	for gcvg-git-2@lo.gmane.org; Wed, 30 Sep 2009 22:55:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753935AbZI3Uy7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Sep 2009 16:54:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753764AbZI3Uy7
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Sep 2009 16:54:59 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:50348 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752989AbZI3Uy6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Sep 2009 16:54:58 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by dcvr.yhbt.net (Postfix) with ESMTPSA id 786031F9AD;
	Wed, 30 Sep 2009 20:55:02 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1254322176-4561-1-git-send-email-felipe.contreras@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129357>

Felipe Contreras <felipe.contreras@gmail.com> wrote:
> For example:
> alias -group friends foo Foo Bar <foo@bar.com>
> 
> Comments by Jeff King.
> 
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>

Interesting, I didn't know about this feature in mutt before.

Acked(-and-tested)-by: Eric Wong <normalperson@yhbt.net>

> ---
>  git-send-email.perl |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/git-send-email.perl b/git-send-email.perl
> index 0700d80..93b7ed2 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -401,7 +401,7 @@ my %aliases;
>  my %parse_alias = (
>  	# multiline formats can be supported in the future
>  	mutt => sub { my $fh = shift; while (<$fh>) {
> -		if (/^\s*alias\s+(\S+)\s+(.*)$/) {
> +		if (/^\s*alias\s+(?:-group\s+\S+\s+)*(\S+)\s+(.*)$/) {
>  			my ($alias, $addr) = ($1, $2);
>  			$addr =~ s/#.*$//; # mutt allows # comments
>  			 # commas delimit multiple addresses
> -- 
