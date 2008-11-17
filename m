From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb: fix encode handling for site_{header,footer}
Date: Mon, 17 Nov 2008 02:28:03 -0800
Message-ID: <7v8wrizlxo.fsf@gitster.siamese.dyndns.org>
References: <87vdumbxgc.wl@vaj-k-334-sugi.local.valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: Tatsuki Sugiura <sugi@nemui.org>
X-From: git-owner@vger.kernel.org Mon Nov 17 11:30:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L21N2-0004Dc-KS
	for gcvg-git-2@gmane.org; Mon, 17 Nov 2008 11:30:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751773AbYKQK20 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2008 05:28:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751945AbYKQK20
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Nov 2008 05:28:26 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:61172 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751618AbYKQK2Z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2008 05:28:25 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 52FF416E30;
	Mon, 17 Nov 2008 05:28:23 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 889EA16E31; Mon,
 17 Nov 2008 05:28:08 -0500 (EST)
In-Reply-To: <87vdumbxgc.wl@vaj-k-334-sugi.local.valinux.co.jp> (Tatsuki
 Sugiura's message of "Mon, 17 Nov 2008 16:53:07 +0900")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 76429518-B492-11DD-AC69-C128113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101210>

Tatsuki Sugiura <sugi@nemui.org> writes:

> All non-ASCII chars of site_{header,footer} will be broken
> by perl IO layer without decoding to utf8.
>
> Here is a fix to just call to_utf8 for inputs from these files.
>
> Signed-off-by: Tatsuki Sugiura <sugi@nemui.org>

Looks good, thanks.

> ---
>  gitweb/gitweb.perl |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 933e137..79ca5c2 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -2929,7 +2929,7 @@ EOF
>  
>  	if (-f $site_header) {
>  		open (my $fd, $site_header);
> -		print <$fd>;
> +		print map {to_utf8($_)} <$fd>;
>  		close $fd;
>  	}
>  
> @@ -3018,7 +3018,7 @@ sub git_footer_html {
>  
>  	if (-f $site_footer) {
>  		open (my $fd, $site_footer);
> -		print <$fd>;
> +		print map {to_utf8($_)} <$fd>;
>  		close $fd;
>  	}
>  
> -- 
> 1.5.6.5
