From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix "identifier redeclared" compilation error with SUN cc
Date: Tue, 20 Nov 2007 00:30:57 -0800
Message-ID: <7vhcjhl3ni.fsf@gitster.siamese.dyndns.org>
References: <7vy7d08her.fsf@gitster.siamese.dyndns.org>
	<1195089303-28085-1-git-send-email-B.Steinbrink@gmx.de>
	<7vd4ua3hww.fsf@gitster.siamese.dyndns.org>
	<Pine.LNX.4.64.0711191847550.7957@bianca.dialin.t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?Q?Bj=C3=B6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	raa.lkml@gmail.com, git@vger.kernel.org
To: Guido Ostkamp <git@ostkamp.fastmail.fm>
X-From: git-owner@vger.kernel.org Tue Nov 20 09:31:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IuOVx-0007jQ-1W
	for gcvg-git-2@gmane.org; Tue, 20 Nov 2007 09:31:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757450AbXKTIbH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Nov 2007 03:31:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757449AbXKTIbG
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Nov 2007 03:31:06 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:38484 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757162AbXKTIbF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Nov 2007 03:31:05 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 3F1C42F0;
	Tue, 20 Nov 2007 03:31:26 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id A9AA096AF1;
	Tue, 20 Nov 2007 03:31:21 -0500 (EST)
In-Reply-To: <Pine.LNX.4.64.0711191847550.7957@bianca.dialin.t-online.de>
	(Guido Ostkamp's message of "Mon, 19 Nov 2007 18:51:00 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65533>

Guido Ostkamp <git@ostkamp.fastmail.fm> writes:

>> ...
>> How about doing it this way?
>
> it looks ok on Solaris. I assembled the following patch from your
> posting, could you please include it?
>
>
> Signed-off-by: Guido Ostkamp <git@ostkamp.fastmail.fm>

I knew it would work on Solaris with gcc and cc that do not
understand flexible array members, but I am a bit worried about
other environments, where flexible array members are properly
supported.  They've been happily using member[] but with the
patch they suddenly start wasting a cell.

But we should do this sooner rather than later to find out any
breakage, and give people on platforms with a cc that supports
flexible array members and care about wasted memory enough time
to send patches to support their compiler in the way similar to
how gcc is supported.

But I cannot use your message with whitespace-broken patch (note
"format=flawed") and insufficient commit log message, which
means I have to do this myself.  Not tonight...
