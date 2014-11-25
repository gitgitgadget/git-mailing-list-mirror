From: Olaf Hering <olaf@aepfle.de>
Subject: Re: how to reduce disk usage for large .git dirs?
Date: Tue, 25 Nov 2014 15:32:59 +0100
Message-ID: <20141125143259.GA9794@aepfle.de>
References: <20141113111444.GA15503@aepfle.de>
 <20141113154457.GA31624@aepfle.de>
 <20141113160325.GA24351@paksenarrion.iveqy.com>
 <20141114112428.GA12702@aepfle.de>
 <8761ehom8l.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Fredrik Gustafsson <iveqy@iveqy.com>, git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Tue Nov 25 15:33:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XtHAz-0008To-E5
	for gcvg-git-2@plane.gmane.org; Tue, 25 Nov 2014 15:33:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750870AbaKYOdE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Nov 2014 09:33:04 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.163]:57377 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750768AbaKYOdD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Nov 2014 09:33:03 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; t=1416925980; l=894;
	s=domk; d=aepfle.de;
	h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Subject:Cc:To:From:Date;
	bh=xzrTZHPnpJMMtMpZ3NebVXgDT5E=;
	b=OY291EFQRMgPnRHoG7/iQHgxA295geEYJHOCmutn7we0IblvuJJeKlJatL9582i0q/l
	2ho/jA1foPK+N1GUroZJjKtBhgrYrUrDKbyjy+9qMO2Wh+lp7Ly/KQRIspwaHczYD5ISx
	C3f7euhMMw74asGxjruXSDLRSrCsGphlD+c=
X-RZG-AUTH: :P2EQZWCpfu+qG7CngxMFH1J+yackYocTD1iAi8x+OWi/zfN1cLnBYfssDIZST8ulOSUJqstS8YMAWN1YEmXTnspMxV9Qxw==
X-RZG-CLASS-ID: mo00
Received: from probook.fritz.box ([2001:a60:1088:9901:1ec1:deff:feb9:bb48])
	by smtp.strato.de (RZmta 35.13 AUTH)
	with ESMTPSA id Q05bf2qAPEX0h3R
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate);
	Tue, 25 Nov 2014 15:33:00 +0100 (CET)
Received: by probook.fritz.box (Postfix, from userid 1000)
	id E478F50172; Tue, 25 Nov 2014 15:32:59 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <8761ehom8l.fsf@igel.home>
User-Agent: Mutt/1.5.22.rev6346 (2013-10-29)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260221>

On Fri, Nov 14, Andreas Schwab wrote:

> Olaf Hering <olaf@aepfle.de> writes:
> 
> > Even if I do a fresh clone with --bare, the result can not be updated
> > anymore with git fetch. What I'm doing wrong?
> 
> A --bare clone has no connection to its origin (there are no remotes).
> You want a --mirror.

Using --mirror for this purpose is dangerous because it will most likely
overwrite changes on the remote side. Fortunately I used 'git push --dry-run
origin' and the output was like:

To git://host/repo.git
 + abbrev1..abbrev2 branchA -> branchA (forced update)

Before that I pushed already to the remote repo without realizing where the
push goes to.

Looks like using the --bare option for cloning the master and then doing
something like "git clone --origin local_bare -b branchA --reference
repo-master git://host/repo.git repo-branchA" will work better.

Olaf
