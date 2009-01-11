From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 3/4] word diff: make regex configurable via attributes
Date: Sun, 11 Jan 2009 15:20:51 -0800
Message-ID: <7veiz9o2ek.fsf@gitster.siamese.dyndns.org>
References: <cover.1231669012.git.trast@student.ethz.ch>
 <4aea85caafd38a058145c5769fe8a30ffdbd4d13.1231669012.git.trast@student.ethz.ch> <529cd830908f018f796dbc46d3b055c1f8ba9c1b.1231669012.git.trast@student.ethz.ch> <72242bd75fa8d55c2afc723f8539ef56f2569d3e.1231669012.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Teemu Likonen <tlikonen@iki.fi>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Jan 12 00:22:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LM9dR-0006LP-SN
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 00:22:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751834AbZAKXVB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jan 2009 18:21:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751975AbZAKXVA
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jan 2009 18:21:00 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:64597 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751858AbZAKXU7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jan 2009 18:20:59 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 87E0C8F4BE;
	Sun, 11 Jan 2009 18:20:58 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 478CC8F4BC; Sun,
 11 Jan 2009 18:20:53 -0500 (EST)
In-Reply-To: <72242bd75fa8d55c2afc723f8539ef56f2569d3e.1231669012.git.trast@student.ethz.ch> (Thomas Rast's message of "Sun, 11 Jan 2009 11:27:13 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 80D5D042-E036-11DD-82A3-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105252>

Thomas Rast <trast@student.ethz.ch> writes:

> Make the --color-words splitting regular expression configurable via
> the diff driver's 'wordregex' attribute.  The user can then set the
> driver on a file in .gitattributes.  If a regex is given on the
> command line, it overrides the driver's setting.
> ...
> diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
> index 6152d5b..d22c06b 100644
> --- a/Documentation/diff-options.txt
> +++ b/Documentation/diff-options.txt
> @@ -96,7 +96,9 @@ endif::git-format-patch[]
>  	By default, a new word only starts at whitespace, so that a
>  	'word' is defined as a maximal sequence of non-whitespace
>  	characters.  The optional argument <regex> can be used to
> -	configure this.
> +	configure this.  It can also be set via a diff driver, see
> +	linkgit:gitattributes[1]; if a <regex> is given explicitly, it
> +	overrides any diff driver setting.
>  +
>  The <regex> must be an (extended) regular expression.  When set, every
>  non-overlapping match of the <regex> is considered a word.  (Regular

One bikeshedding I think is better to get over with is that this probably
should be called xwordregex for consistency with xfuncname where 'x'
variant means POSIX ERE and the one without means POSIX BRE, even if we
are not going to support diff.wordregex that uses BRE.

I am assuming [3/4] can be trivially adjusted if we were to adopt the
clean-up approach Dscho is taking?
