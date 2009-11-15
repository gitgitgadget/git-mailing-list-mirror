From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Define $PERL_PATH in test-lib.sh
Date: Sun, 15 Nov 2009 01:12:37 -0800
Message-ID: <7v639cqhh6.fsf@alter.siamese.dyndns.org>
References: <1257850011-7544-1-git-send-email-book@cpan.org>
 <20091110122315.GA15906@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: "Philippe Bruhat \(BooK\)" <book@cpan.org>
X-From: git-owner@vger.kernel.org Sun Nov 15 10:12:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9bAF-0002wX-Bm
	for gcvg-git-2@lo.gmane.org; Sun, 15 Nov 2009 10:12:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752456AbZKOJMn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Nov 2009 04:12:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752445AbZKOJMm
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Nov 2009 04:12:42 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:57146 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752439AbZKOJMl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Nov 2009 04:12:41 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6ACB97F405;
	Sun, 15 Nov 2009 04:12:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=QSD7PZGgzuXX5/W41odvojMUn6I=; b=jeHHuHmRGrpSw6ekcRLSvmW
	8RqRS66jeV54yTpD9TMPM1t0XOXJ60cNR35HUCB+IRE3br9RW/6V4uIaA0/46zfD
	5cefbUVj83x6qp5mXgT4fOL6Crr7qzyJKLs+MdDcPI/KFl0vnUtTnoM0KFpQqsp+
	SD/mB0OZKlFvFSdilf50=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=yaMY60wgYfWsK6o8caqesLd8Ux9Vi4YxAqNWm6r1sZ/Zx+mJe
	EANkkkQxI/T0Q44nA3KAUnBhBVsWQ0y1ZHIjsL0tpgQqtPkz+OaQmlg7CBDtYug8
	M//mcr+UXaNQc/IC8NNUjQXP9xnO+0BjFPSRQ8ILWyIJ+w0G/scOM2sULA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A258B7F404;
	Sun, 15 Nov 2009 04:12:43 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EA5C67F403; Sun, 15 Nov
 2009 04:12:38 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0856A55A-D1C7-11DE-A2B8-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132922>

Jeff King <peff@peff.net> writes:

> On Tue, Nov 10, 2009 at 11:46:51AM +0100, Philippe Bruhat (BooK) wrote:
> (snip)
> Will this work if I just have PERL_PATH in my config.mak in the root
> directory? Should we be adding PERL_PATH to the generated
> GIT-BUILD-OPTIONS file in the root, which gets sourced by test-lib?
>
> Something like the following (completely untested) patch?

Philippe, could you please help getting this topic unstuck with a "it
works" or "it doesn't and here is a better solution"?

> diff --git a/Makefile b/Makefile
> index a10a60c..b9a8145 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1643,6 +1643,7 @@ GIT-CFLAGS: .FORCE-GIT-CFLAGS
>  # and the first level quoting from the shell that runs "echo".
>  GIT-BUILD-OPTIONS: .FORCE-GIT-BUILD-OPTIONS
>  	@echo SHELL_PATH=\''$(subst ','\'',$(SHELL_PATH_SQ))'\' >$@
> +	@echo PERL_PATH=\''$(subst ','\'',$(PERL_PATH_SQ))'\' >$@
>  	@echo TAR=\''$(subst ','\'',$(subst ','\'',$(TAR)))'\' >>$@
>  	@echo NO_CURL=\''$(subst ','\'',$(subst ','\'',$(NO_CURL)))'\' >>$@
>  	@echo NO_PERL=\''$(subst ','\'',$(subst ','\'',$(NO_PERL)))'\' >>$@
