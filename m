From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] repack vs re-clone
Date: Mon, 11 Feb 2008 10:45:24 -0800 (PST)
Message-ID: <m3myq7e3ie.fsf@localhost.localdomain>
References: <e5bfff550802100025k616ccff5ib2917d283eeb0ff0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git mailing list" <git@vger.kernel.org>
To: "Marco Costalba" <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 11 19:46:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOdfM-0002iH-HZ
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 19:46:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759791AbYBKSpc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2008 13:45:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759805AbYBKSpb
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 13:45:31 -0500
Received: from fk-out-0910.google.com ([209.85.128.188]:40605 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757621AbYBKSpa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2008 13:45:30 -0500
Received: by fk-out-0910.google.com with SMTP id z23so4613791fkz.5
        for <git@vger.kernel.org>; Mon, 11 Feb 2008 10:45:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=IrwkeOBb1EfQ4rJXRFjYqmllYQCYQununKM7OHMzHn8=;
        b=NKERDDFm0v7oAR5oGYidkBlltS2xvfqDY+XD76rfp3RAiDBcEw0UAqVmHGrD4HNi5DXCJ/mqqpoWefQL63B90ZheGhpkMzv3Q5cVATBrL/P9Du0+N9LnyLTJmMhsIV0N3cxs7BQ/LKAHr84C7Ekdzc+viUnnduiZdqNeA3ZMPd8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=H4TNPl7JdmRtwzSPa5S8ZcT5RtctDAfr2t8eEkqFgHW0ASysNZN14J7mAEPSNCvVBL1dxKgcrzu1ac7X5mA3f5AmXW08WdKhRvcdtXPJaBPYRXKFz21vtfuVLdg0lJgN0lPRdYc4Wo7bH/FtgFR2NrDrN4aoiyDngCIR9qR8Mqk=
Received: by 10.82.161.19 with SMTP id j19mr584904bue.20.1202755526777;
        Mon, 11 Feb 2008 10:45:26 -0800 (PST)
Received: from localhost.localdomain ( [83.8.220.23])
        by mx.google.com with ESMTPS id y34sm19598682iky.6.2008.02.11.10.45.23
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 11 Feb 2008 10:45:24 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m1BIjJ8f016559;
	Mon, 11 Feb 2008 19:45:20 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m1BIjD0K016555;
	Mon, 11 Feb 2008 19:45:13 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <e5bfff550802100025k616ccff5ib2917d283eeb0ff0@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73562>

"Marco Costalba" <mcostalba@gmail.com> writes:

> Sometime I found myself re-cloning entirely a repository, as example
> the Linux tree, instead of repackaging my local copy.
> 
> The reason is that the published Linux repository is super compressed
> and to reach the same level of compression on my local copy I would
> need to give my laptop a long night running.

Repacking without '--force' (for gc) or '--no-reuse-delta' (low level)
would always reuse this tight packing. Only with '--force' you would
waste CPU trying to find better deltaification[*1*].
 
> So it happens to be just faster to re-clone the whole thing by upstream.

So what you are doing is passing the work, unnecessary work I'd say,
to some poor server. Not nice.


[*1*] I hope that '--no-reuse-delta' means _try_ to find better delta,
but use current one as possible delta, not stupid forget about current
deltaification at all...
-- 
Jakub Narebski
Poland
ShadeHawk on #git
