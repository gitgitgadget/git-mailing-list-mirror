From: Jari Aalto <jari.aalto@cante.net>
Subject: Re: Start encouraging English.pm (Was: [PATCH v2] git-send-email.perl: Add sub maildomain_sanitize)
Date: Fri, 16 Apr 2010 20:00:16 +0300
Organization: Private
Message-ID: <87iq7rqqn3.fsf_-_@jondo.cante.net>
References: <1270789906-23735-1-git-send-email-brian@gernhardtsoftware.com>
	<m38w8og9w4.fsf@localhost.localdomain>
	<87wrw7qtx8.fsf_-_@jondo.cante.net>
	<201004161811.14259.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 16 19:00:27 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2ou3-0007KC-5x
	for gcvg-git-2@lo.gmane.org; Fri, 16 Apr 2010 19:00:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758636Ab0DPRAV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Apr 2010 13:00:21 -0400
Received: from emh03.mail.saunalahti.fi ([62.142.5.109]:46875 "EHLO
	emh03.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758627Ab0DPRAU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Apr 2010 13:00:20 -0400
Received: from saunalahti-vams (vs3-11.mail.saunalahti.fi [62.142.5.95])
	by emh03-2.mail.saunalahti.fi (Postfix) with SMTP id 4915AEC164;
	Fri, 16 Apr 2010 20:00:19 +0300 (EEST)
Received: from emh04.mail.saunalahti.fi ([62.142.5.110])
	by vs3-11.mail.saunalahti.fi ([62.142.5.95])
	with SMTP (gateway) id A04D8844F0C; Fri, 16 Apr 2010 20:00:19 +0300
Received: from jondo.cante.net (a91-155-187-216.elisa-laajakaista.fi [91.155.187.216])
	by emh04.mail.saunalahti.fi (Postfix) with ESMTP id 10B0D41BE2;
	Fri, 16 Apr 2010 20:00:16 +0300 (EEST)
In-Reply-To: <201004161811.14259.jnareb@gmail.com> (Jakub Narebski's message
	of "Fri, 16 Apr 2010 18:11:11 +0200")
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/23.1 (gnu/linux)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145085>

Jakub Narebski <jnareb@gmail.com> writes:
> O.K.
>
>
> Note however that while setting $_ ($ARG with English) simplifies regexp
> matching

Speaking of which...

Could we please move to using this everywhere:

    use English qw( -no_match_vars );

That would give all the benefits of readability without performance
penalties. The load time seems to be neglible:

    $ perl --version | grep v5

    This is perl, v5.10.1 (*) built for x86_64-linux-gnu-thread-multi

    $ time perl -e 'print'

    real    0m0.005s
    user    0m0.000s
    sys     0m0.004s

    $ time perl -e 'use English qw( -no_match_vars ); print'

    real    0m0.017s
    user    0m0.008s
    sys     0m0.008s

> you have to take care to use
>
>> +sub maildomain_sanitize {
>> +	local $_ = shift;

>    local $_ = shift;
>
> and not
>
>    my $_ = shift; 
>
> And to use 'local'.

As done.

The Perl 5.12 now finally allow my'ing of $ARG too. But maybe we don't
switch to it just yet...

Jari
