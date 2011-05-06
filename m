From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Question about PERL_PATH
Date: Fri, 06 May 2011 09:05:08 -0700
Message-ID: <7v7ha33jd7.fsf@alter.siamese.dyndns.org>
References: <4DC3F804.3080205@mev.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ian Abbott <abbotti@mev.co.uk>
X-From: git-owner@vger.kernel.org Fri May 06 18:05:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QINWu-0001EZ-No
	for gcvg-git-2@lo.gmane.org; Fri, 06 May 2011 18:05:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752712Ab1EFQFS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2011 12:05:18 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:49782 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752261Ab1EFQFR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2011 12:05:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 839C758B0;
	Fri,  6 May 2011 12:07:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+vxKV28pvWu965gUHap4BXFzXbo=; b=xLVBLg
	0wVt9FEwkYR5VnMPokidyBbzfNguuE5jmcIpEbwUPJwvFXfGYMdgJkCbiPWXvW+T
	s2uuI30nCd365WJhtDBOZcSUsdh3DV3UVLNe6DNQHqLlRkXCuW4FipzqTfJHGl5O
	RBZd0SSUrSlV0LiqzdGn06WY6kYfImgiYp2Uc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lJPv28p733bSJSoLKMDMFFe7yea5XViz
	Bi/C6BpYow6F8YMsZ9nc9cRniPNcz4jfAMqT0LnSQb1QEhIjVTKkIq9Xl7c1ZeVD
	OTH9/9oJCCIjEVn/EbNbERtg9J3j2MDIJda4gwMp2cEdWuwr8FLUMOHwsV61r8D5
	PFwMIE0g1wg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6081D58AE;
	Fri,  6 May 2011 12:07:17 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 82C2058AC; Fri,  6 May 2011
 12:07:14 -0400 (EDT)
In-Reply-To: <4DC3F804.3080205@mev.co.uk> (Ian Abbott's message of "Fri, 6
 May 2011 14:30:44 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EA092E84-77FA-11E0-A2D5-90BEB0B5FC3A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172984>

Ian Abbott <abbotti@mev.co.uk> writes:

> The Gentoo ebuilds for git have started invoking 'make' with the option
> 'PERL_PATH=/usr/bin/env perl'.  This doesn't seem to cause any problems
> except when running git instaweb, which outputs an error similar to the
> following:
>
> /usr/libexec/git-core/git-instaweb: line 135: /usr/bin/env perl: No such
> file or directory

The variable is not PERL_COMMAND_LINE, but is PERL_PATH, so I think it
should expects the path to the program.

Our testsuite also rely on it being the path to the program by enclosing
the reference to it inside double quotes, to make sure that PERL_PATH set
to "/Program Files/Perl/perl.exe" works.  Didn't Gentoo folks see any test
breakage before shipping the ebuild procedure?
