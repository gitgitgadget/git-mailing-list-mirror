From: Nick <oinksocket@letterboxes.org>
Subject: Re: [1.8.0] perl/Git.pm: moving away from using Error.pm module
Date: Mon, 21 Feb 2011 11:02:10 +0000
Message-ID: <4D624632.80904@letterboxes.org>
References: <201102202346.36410.jnareb@gmail.com> <7v4o7xluph.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Petr Baudis <pasky@suse.cz>, Alex Riesen <raa.lkml@gmail.com>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_?= =?ISO-8859-1?Q?Bjarmason?= 
	<avarab@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 21 11:59:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PrTU0-000476-QY
	for gcvg-git-2@lo.gmane.org; Mon, 21 Feb 2011 11:59:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754427Ab1BUK7G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Feb 2011 05:59:06 -0500
Received: from udon.noodlefactory.co.uk ([80.68.88.167]:45465 "EHLO
	udon.noodlefactory.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753339Ab1BUK7F (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Feb 2011 05:59:05 -0500
Received: from 87-194-154-6.bethere.co.uk ([87.194.154.6] helo=[192.168.0.102])
	by udon.noodlefactory.co.uk with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <oinksocket@letterboxes.org>)
	id 1PrTTs-0002ae-31; Mon, 21 Feb 2011 10:59:04 +0000
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.13) Gecko/20101208 Lightning/1.0b2 Thunderbird/3.1.7
In-Reply-To: <7v4o7xluph.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167472>

On 21/02/11 07:20, Junio C Hamano wrote:
> If we are going to change things so that everybody uses a
> more traditional "eval {}; if ($@) { ... }", it would be a welcome change
> from my point of view.

A small aside - note the "Dangers of using $@" described here:

  http://www.socialtext.net/perl5/exception_handling

To paraphrase, this:

  eval { stuff ; 1} or do { handle_exception };

is marginally safer than:

  eval { stuff }; if (defined $@) { handle_exception }

because it is possible that $@ can be modified (say, by a DESTROY method) before
the if clause sees it.  The former idiom does not stop that, it just means your
exception handler is executed reliably.

Normally it is not a problem, but this is still something worth knowing.

N
