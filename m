From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] rebase -m: Fix incorrect short-logs of already applied commits.
Date: Sat, 01 Sep 2007 11:20:20 +0200
Message-ID: <85ps12agiz.fsf@lola.goethe.zz>
References: <200709010925.27926.johannes.sixt@telecom.at>
	<7vmyw6u5ca.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 01 11:20:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRP9d-000711-Ba
	for gcvg-git@gmane.org; Sat, 01 Sep 2007 11:20:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752499AbXIAJU2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 1 Sep 2007 05:20:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752421AbXIAJU2
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Sep 2007 05:20:28 -0400
Received: from mail-in-10.arcor-online.net ([151.189.21.50]:50389 "EHLO
	mail-in-10.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752259AbXIAJU1 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 1 Sep 2007 05:20:27 -0400
Received: from mail-in-01-z2.arcor-online.net (mail-in-01-z2.arcor-online.net [151.189.8.13])
	by mail-in-10.arcor-online.net (Postfix) with ESMTP id 664A91F577D;
	Sat,  1 Sep 2007 11:20:26 +0200 (CEST)
Received: from mail-in-06.arcor-online.net (mail-in-06.arcor-online.net [151.189.21.46])
	by mail-in-01-z2.arcor-online.net (Postfix) with ESMTP id 1BB9D12DFB2;
	Sat,  1 Sep 2007 11:20:26 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-061-160.pools.arcor-ip.net [84.61.61.160])
	by mail-in-06.arcor-online.net (Postfix) with ESMTP id 0522135E6AA;
	Sat,  1 Sep 2007 11:20:21 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 9C6301D3D827; Sat,  1 Sep 2007 11:20:20 +0200 (CEST)
In-Reply-To: <7vmyw6u5ca.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's message of "Sat\, 01 Sep 2007 02\:01\:41 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/4115/Sat Sep  1 10:05:44 2007 on mail-in-06.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57262>

Junio C Hamano <gitster@pobox.com> writes:

> I would propose doing the attached patch on top of yours.
> Opinion?
>
> +	git rev-list --pretty=oneline -1 "$cmt" | sed -e 's/^[^ ]* //'

What about

    git-rev-list --pretty=format:%s -1 "$cmt"

It seems pretty pointless to first print with a wrong format, then fix
it up afterwards.

Incidentally, the above spews out a full commit line before the entry
(meaning this does not work with current git-rev-list).  This is
arguably wrong: when format: is employed, the user presumably knows
perfectly well what he wants printed.

So I guess I vouch for both not using sed as well as what I consider
fixing git-rev-list --pretty=format:

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
