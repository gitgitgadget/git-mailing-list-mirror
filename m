From: bdowning@lavos.net (Brian Downing)
Subject: Re: [PATCH 5/9] git-cat-file: Add --separator option
Date: Tue, 23 Oct 2007 22:43:01 -0500
Message-ID: <20071024034301.GE24924@lavos.net>
References: <1193118397-4696-1-git-send-email-aroben@apple.com> <1193118397-4696-2-git-send-email-aroben@apple.com> <1193118397-4696-3-git-send-email-aroben@apple.com> <1193118397-4696-4-git-send-email-aroben@apple.com> <1193118397-4696-5-git-send-email-aroben@apple.com> <1193118397-4696-6-git-send-email-aroben@apple.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Adam Roben <aroben@apple.com>
X-From: git-owner@vger.kernel.org Wed Oct 24 05:43:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkX9T-0003UU-0O
	for gcvg-git-2@gmane.org; Wed, 24 Oct 2007 05:43:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753067AbXJXDnP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2007 23:43:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753198AbXJXDnO
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Oct 2007 23:43:14 -0400
Received: from mxsf09.insightbb.com ([74.128.0.79]:37309 "EHLO
	mxsf09.insightbb.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752981AbXJXDnO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2007 23:43:14 -0400
X-IronPort-AV: E=Sophos;i="4.21,322,1188792000"; 
   d="scan'208";a="108003806"
Received: from unknown (HELO asav00.insightbb.com) ([172.31.249.124])
  by mxsf09.insightbb.com with ESMTP; 23 Oct 2007 23:43:12 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Aq4HALdbHkdKhvkY/2dsb2JhbACBWo5k
X-IronPort-AV: E=Sophos;i="4.21,322,1188792000"; 
   d="scan'208";a="128167632"
Received: from 74-134-249-24.dhcp.insightbb.com (HELO mail.lavos.net) ([74.134.249.24])
  by asav00.insightbb.com with ESMTP; 23 Oct 2007 23:43:12 -0400
Received: by mail.lavos.net (Postfix, from userid 1000)
	id EB621309F21; Tue, 23 Oct 2007 22:43:01 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <1193118397-4696-6-git-send-email-aroben@apple.com>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62184>

On Mon, Oct 22, 2007 at 10:46:33PM -0700, Adam Roben wrote:
> +--separator::
> +	A string to print in between the output for each object passed on
> +	stdin. A newline will be appended to the separator each time it is
> +	printed.

Maybe I'm just unreasonably paranoid, but I don't think I could ever
trust that you'd never find an arbitrary separator in the data.  I
suppose if you scanned the files beforehand you could come up with
something guaranteed to be unique, but that seems like a pain (and
doesn't happen regardless in patch 9/9; it just uses
"--------------GITCATFILESEPARATOR-----------")  If I were committing to
SVN, it's sure not something I'd like to bet the integrity of my data
on.

I think a far more reasonable output format for multiple objects would
be something like:

<count> LF
<raw data> LF

Where <count> is the number of bytes in the <raw data> as an ASCII
decimal integer.

This is pretty much the spiritual analog to the fast-import "exact byte
count" data input format as well.

-bcd
