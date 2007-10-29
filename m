From: "Morten Welinder" <mwelinder@gmail.com>
Subject: Re: [PATCH] Speedup scanning for excluded files.
Date: Mon, 29 Oct 2007 18:59:00 -0400
Message-ID: <118833cc0710291559kbd874a8o8111b9495090ef27@mail.gmail.com>
References: <200710290845.26727.lars@trolltech.com>
	 <20071029080234.GA22826@artemis.corp>
	 <200710290959.32538.lars@trolltech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Pierre Habouzit" <madcoder@debian.org>,
	"Junio C Hamano" <gitster@pobox.com>
To: "Lars Knoll" <lars@trolltech.com>
X-From: git-owner@vger.kernel.org Mon Oct 29 23:59:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImdZm-0006bp-Sh
	for gcvg-git-2@gmane.org; Mon, 29 Oct 2007 23:59:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752419AbXJ2W7F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Oct 2007 18:59:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752403AbXJ2W7E
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Oct 2007 18:59:04 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:13980 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752221AbXJ2W7D (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Oct 2007 18:59:03 -0400
Received: by nf-out-0910.google.com with SMTP id g13so1461812nfb
        for <git@vger.kernel.org>; Mon, 29 Oct 2007 15:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=xHz76FFLBxkYJDifsmg0BZ8r0UWw36jUwPwpB5/f8Fw=;
        b=HgS6FBZLl8TakLRlTpj7Zvp1wEm5mOiSBBWYrwVTTT1R4gXNm3V3tqWadjNgQW+l6z6OnzEYGfKG1mC5bND+R0xr2DKXl2jDqKgxJPHpI+SPeNNoDnuG0Mvpnjw1tTqUOQsXkUn4ka1J/IEch/0Ro3AFDS4fXh/qXt3Cixv0YFI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VNpdqXDIQbOia1K04IIfvJnUJHr54ERy3upmsKYiCVDuAGStX1hCbe5BURiq1teJq6t3CfUlNzb240wj23hyr0LzOiBp4RPqbRVS+GCqxT8RTJ8+Eg6gDqt/D3ypNF4A+orzy/G9paRCWp8k7BSqvKInBBkeIvjo/nJfgfhfyzc=
Received: by 10.86.97.7 with SMTP id u7mr5152594fgb.1193698740860;
        Mon, 29 Oct 2007 15:59:00 -0700 (PDT)
Received: by 10.86.29.17 with HTTP; Mon, 29 Oct 2007 15:59:00 -0700 (PDT)
In-Reply-To: <200710290959.32538.lars@trolltech.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62630>

> +                               } else if (x->flags & EXC_FLAG_ENDSWITH) {
> +                                       if (!strcmp(exclude + 1, pathname + pathlen -x->patternlen + 1))

Is there some guarantee that the result of that subtraction is still within
the string?

Morten
