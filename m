From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-svnimport: Use separate arguments in the pipe for git-rev-parse
Date: Tue, 18 Sep 2007 01:54:01 -0700
Message-ID: <7vlkb4wdzq.fsf@gitster.siamese.dyndns.org>
References: <200709161857.06065.danda@osc.co.cr>
	<20070917070303.GI31176@kiste.smurf.noris.de>
	<200709171333.48331.danda@osc.co.cr>
	<20070918074753.GQ31176@kiste.smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dan Libby <danda@osc.co.cr>, git@vger.kernel.org
To: Matthias Urlichs <smurf@smurf.noris.de>
X-From: git-owner@vger.kernel.org Tue Sep 18 10:54:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXYqb-0001A8-Fb
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 10:54:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753133AbXIRIyI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2007 04:54:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752179AbXIRIyI
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 04:54:08 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:51272 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751240AbXIRIyH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2007 04:54:07 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id F10A11373BC;
	Tue, 18 Sep 2007 04:54:24 -0400 (EDT)
In-Reply-To: <20070918074753.GQ31176@kiste.smurf.noris.de> (Matthias Urlichs's
	message of "Tue, 18 Sep 2007 09:47:53 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58546>

Matthias Urlichs <smurf@smurf.noris.de> writes:

> Signed-Off-By: Matthias Urlichs <smurf@smurf.noris.de>
> ---
> Please tell me whether that works for you.
>
> Somebody else, preferably its author, can fix git-svn. ;-)
> 
> diff --git a/git-svnimport.perl b/git-svnimport.perl
> index d3ad5b9..aa5b3b2 100755
> --- a/git-svnimport.perl
> +++ b/git-svnimport.perl
> @@ -633,7 +633,7 @@ sub commit {
>  
>  	my $rev;
>  	if($revision > $opt_s and defined $parent) {
> -		open(H,"git-rev-parse --verify $parent |");
> +		open(H,'-|',"git-rev-parse","--verify",$parent);
>  		$rev = <H>;
>  		close(H) or do {
>  			print STDERR "$revision: cannot find commit '$parent'!\n";

I seem to be missing the context, but please describe what
problem this fixes in the commit log message.  I guess some
people use shell metacharacters and/or SP in their branch names
and this is about that problem?
