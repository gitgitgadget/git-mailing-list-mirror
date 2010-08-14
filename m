From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: [PATCH il/rfc-remote-fd-ext] Fix build on Windows
Date: Sat, 14 Aug 2010 12:38:01 +0300
Message-ID: <20100814093801.GA28522@LK-Perkele-V2.elisa-laajakaista.fi>
References: <201008140009.19291.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sat Aug 14 11:34:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OkD8a-0002Bz-06
	for gcvg-git-2@lo.gmane.org; Sat, 14 Aug 2010 11:34:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934630Ab0HNJen (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Aug 2010 05:34:43 -0400
Received: from emh03.mail.saunalahti.fi ([62.142.5.109]:39067 "EHLO
	emh03.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933589Ab0HNJem (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Aug 2010 05:34:42 -0400
Received: from saunalahti-vams (vs3-11.mail.saunalahti.fi [62.142.5.95])
	by emh03-2.mail.saunalahti.fi (Postfix) with SMTP id 8F5A9EBB98;
	Sat, 14 Aug 2010 12:34:41 +0300 (EEST)
Received: from emh04.mail.saunalahti.fi ([62.142.5.110])
	by vs3-11.mail.saunalahti.fi ([62.142.5.95])
	with SMTP (gateway) id A02702874A7; Sat, 14 Aug 2010 12:34:41 +0300
Received: from LK-Perkele-V2 (a88-112-50-174.elisa-laajakaista.fi [88.112.50.174])
	by emh04.mail.saunalahti.fi (Postfix) with ESMTP id 4690B41BE2;
	Sat, 14 Aug 2010 12:34:37 +0300 (EEST)
Content-Disposition: inline
In-Reply-To: <201008140009.19291.j6t@kdbg.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153550>

On Sat, Aug 14, 2010 at 12:09:19AM +0200, Johannes Sixt wrote:
> This adds the necessary #defines so that the programs can be built, but
> since the poll emulation is not extended to support POLLOUT and POLLNVAL,
> the resulting programs will most likely not function properly. (The test
> does not check them, yet.)

The code doesn't really need POLLNVAL (Its just there for "can't happen"
case). POLLOUT is needed. I looked at poll emulation code: It returning
EINVAL causes transfer loop to fail quick.

I think its possible to write the loop in terms of select instead of poll.
Would this be better for Git on Windows?

-Ilari
