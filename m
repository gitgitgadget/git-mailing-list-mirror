From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH 1/2] fix clang -Wconstant-conversion with bit fields
Date: Wed, 16 Jan 2013 23:08:00 +0000
Message-ID: <20130116230800.GB4574@serenity.lan>
References: <20130116182449.GA4881@sigill.intra.peff.net>
 <1358376443-7404-1-git-send-email-apelisse@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Max Horn <max@quendi.de>, Junio C Hamano <gitster@pobox.com>,
	git <git@vger.kernel.org>, Johannes Sixt <j6t@kdbg.org>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 17 00:08:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tvc5y-0002V5-0R
	for gcvg-git-2@plane.gmane.org; Thu, 17 Jan 2013 00:08:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755473Ab3APXIM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2013 18:08:12 -0500
Received: from coyote.aluminati.org ([72.9.247.114]:53793 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755337Ab3APXIM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2013 18:08:12 -0500
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 18B876064CF;
	Wed, 16 Jan 2013 23:08:11 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level: 
X-Spam-Status: No, score=-1 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YcIefDs1qO7W; Wed, 16 Jan 2013 23:08:10 +0000 (GMT)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by coyote.aluminati.org (Postfix) with ESMTP id 7012A6064B7;
	Wed, 16 Jan 2013 23:08:10 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 63460161E550;
	Wed, 16 Jan 2013 23:08:10 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id J1nEvdmwFX-N; Wed, 16 Jan 2013 23:08:10 +0000 (GMT)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id D1F95161E276;
	Wed, 16 Jan 2013 23:08:02 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <1358376443-7404-1-git-send-email-apelisse@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213821>

On Wed, Jan 16, 2013 at 11:47:22PM +0100, Antoine Pelisse wrote:
> clang incorrectly reports a constant conversion warning (implicit
> truncation to bit field) when using the "flag &= ~FLAG" form, because
> ~FLAG needs to be truncated.
> 
> Convert this form to "flag = flag & ~FLAG" fixes the issue as
> the right operand now fits into the bit field.
> 
> Signed-off-by: Antoine Pelisse <apelisse@gmail.com>
> ---
> I'm sorry about this fix, it really seems bad, yet it's one step closer
> to warning-free clang compilation.
> 
> It seems quite clear to me that it's a bug in clang.

Which version of clang did you see this with?  I don't get these
warnings with clang 3.2.


John
