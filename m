From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] perl: add new module Git::Config for cached 'git config'
 access
Date: Tue, 07 Apr 2009 23:29:59 -0700
Message-ID: <7vbpr7r72w.fsf@gitster.siamese.dyndns.org>
References: <1238975176-14354-1-git-send-email-sam.vilain@catalyst.net.nz>
 <20090406092942.GW17706@mail-vs.djpig.de>
 <1239058276.31863.19.camel@maia.lan> <m3prfo1xh6.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sam Vilain <sam.vilain@catalyst.net.nz>,
	Frank Lichtenheld <frank@lichtenheld.de>, git@vger.kernel.org,
	Petr Baudis <pasky@suse.cz>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 08 08:31:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrRK5-0003ut-9c
	for gcvg-git-2@gmane.org; Wed, 08 Apr 2009 08:31:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761234AbZDHGaM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Apr 2009 02:30:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760264AbZDHGaL
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Apr 2009 02:30:11 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:36625 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756272AbZDHGaK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Apr 2009 02:30:10 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 37FACA8299;
	Wed,  8 Apr 2009 02:30:09 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 01B8FA8291; Wed,
  8 Apr 2009 02:30:01 -0400 (EDT)
In-Reply-To: <m3prfo1xh6.fsf@localhost.localdomain> (Jakub Narebski's message
 of "Tue, 07 Apr 2009 05:01:37 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B4F515FE-2406-11DE-BB8C-BB14ECB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116045>

Jakub Narebski <jnareb@gmail.com> writes:

> Errr... wouldn't it be better to simply use 
>
> +		my ($item, $value) = split("\n", $_, 2)
>
> here? Have you tested Git::Config with a "null" value, i.e. something
> like
>
>     [section]
>         noval
>
> in the config file (which evaluates to 'true' with '--bool' option)?
> Because from what I remember from the discussion on the 
> "git config --null --list" format the lack of "\n" is used to
> distinguish between noval (which is equivalent to 'true'), and empty
> value (which is equivalent to 'false')
>
>     [boolean
>         noval        # equivalent to 'true'
>         empty1 =     # equivalent to 'false'
>         empty2 = ""  # equivalent to 'false'

I do not mind if the _write method always wrote out

	[core]
        	autocrlf = true

for a variable that is true, but it should be able to read existing

	[core]
        	autocrlf

correctly.

Sam, I think you meant to make me squash the "Oops, for no good reason,
here is a fix-up" into the previous one, but for this case, I'd appreciate
a re-roll of the series, that includes a test to read from an existing
configuration file that contains such "presense of the name alone means
boolean true" variables.
