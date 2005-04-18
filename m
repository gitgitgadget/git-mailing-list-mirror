From: Kevin Smith <yarcs@qualitycode.com>
Subject: Re: Yet another base64 patch
Date: Mon, 18 Apr 2005 08:59:45 -0400
Message-ID: <4263AF41.1070806@qualitycode.com>
References: <Pine.LNX.4.58.0504141042450.7211@ppc970.osdl.org> <20050414191157.GA27696@outpost.ds9a.nl> <425EC3B4.6090908@zytor.com> <20050414214756.GA31249@outpost.ds9a.nl> <Pine.LNX.4.58.0504141743360.7211@ppc970.osdl.org> <425F13C9.5090109@zytor.com> <20050414205831.01039ee8.pj@engr.sgi.com> <4261DDBC.3050706@dwheeler.com> <20050416210513.1ba26967.pj@sgi.com> <42620452.4080809@dwheeler.com> <20050417181935.GD1461@pasky.ji.cz> <426341FC.7090600@dwheeler.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 18 15:01:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNVrC-0003mQ-6d
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 15:00:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261327AbVDRNDZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 09:03:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262085AbVDRNBj
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 09:01:39 -0400
Received: from deuterium.rootr.net ([203.194.209.160]:42855 "EHLO
	vulcan.rootr.net") by vger.kernel.org with ESMTP id S261327AbVDRM7x
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2005 08:59:53 -0400
Received: from [10.10.10.20] (147-49.35-65.tampabay.res.rr.com [65.35.49.147])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by vulcan.rootr.net (Postfix) with ESMTP id AB0AF3C0A
	for <git@vger.kernel.org>; Mon, 18 Apr 2005 12:59:47 +0000 (UTC)
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050325)
X-Accept-Language: en-us, en
In-Reply-To: <426341FC.7090600@dwheeler.com>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
To: unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

David A. Wheeler wrote:
> Does anyone know of any other issues in how git data is stored that
> might cause problems for some situations?  Windows' case-insensitive/
> case-preserving model for NTFS and vfat32 seems to be enough
> (since the case is preserved) so that the format should work,

If git is retaining hex naming, and not moving to base64, then I don't
think what I am about to say is relevant. However, if base64 file naming
is still being considered, then vfat32 compatibility may be a concern
(I'm not sure about NTFS). Although it is case-preserving, it actually
considers both cases as being the same name. So AaA would overwrite aAa.

If I'm doing the math right, we would effectively be ignoring roughly
one out of 6 base64 bits. This would reduce the collision avoidance
capability of SHA-1 (on vfat32) from 160 bits to about 133 bits. Still
strong, and probably acceptable, but worth noting.

I'll take this opportunity to support David's position that it would be
fantastic if git could end up being valuable for a wide range of
projects, rather than just the kernel. I also fully understand that the
kernel is the primary target, but when there are opportunities to make
the data structures more generally useful without causing problems for
the kernel project, I hope they are taken.

Thanks,

Kevin
