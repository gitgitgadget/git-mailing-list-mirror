From: =?utf-8?q?=E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=81=AA=E3=81=93?= 
	<nanako3@bluebottle.com>
Subject: Re: [RFH/PATCH] prefix_path(): disallow absolute paths
Date: Wed, 30 Jan 2008 06:53:48 +0900
Message-ID: <200801292158.m0TLwA7u019321@mi0.bluebottle.com>
References: <7vwspts9vj.fsf@gitster.siamese.dyndns.org>
 <47975FE6.4050709@viscovery.net>
 <1201463731-1963-1-git-send-email-shawn.bohrer@gmail.com>
 <alpine.LSU.1.00.0801272043040.23907@racer.site>
 <7v3asiyk2i.fsf@gitster.siamese.dyndns.org> <20080128003404.GA18276@lintop>
 <7vodb6wtix.fsf@gitster.siamese.dyndns.org> <479D805E.3000209@viscovery.net>
 <7vprvmuykw.fsf@gitster.siamese.dyndns.org> <479D9ADE.6010003@viscovery.net>
 <alpine.LSU.1.00.0801281210440.23907@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Shawn Bohrer <shawn.bohrer@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 29 22:55:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJyQU-0000mE-Bn
	for gcvg-git-2@gmane.org; Tue, 29 Jan 2008 22:55:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758802AbYA2Vy0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2008 16:54:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755122AbYA2Vy0
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jan 2008 16:54:26 -0500
Received: from mi0.bluebottle.com ([206.188.25.15]:52811 "EHLO
	mi0.bluebottle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754691AbYA2VyY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2008 16:54:24 -0500
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by mi0.bluebottle.com (8.13.1/8.13.1) with ESMTP id m0TLwA7u019321
	for <git@vger.kernel.org>; Tue, 29 Jan 2008 13:58:10 -0800
DomainKey-Signature: a=rsa-sha1; s=mail; d=bluebottle.com; c=nofws; q=dns;
	h=received:from:to:cc:date:subject:in-reply-to:references:
	mime-version:content-type:content-transfer-encoding:x-trusted-delivery;
	b=wdACdvA9poHGOUs4Mq1HMiFAFqOLe0xaLrK631bvKfyJEll5Fa33EGjjtA+Jg2jxh
	4Dw6Pxh3bWVNTibwB6AY9INisoYKGLcid4HiMZxI9KgrMBRWy9r4Zwh7ao7Vhhl
Received: from nanako3.mail.bluebottle.com ([212.62.97.23])
	(authenticated bits=0)
	by fe1.bluebottle.com (8.13.1/8.13.1) with ESMTP id m0TLs9ve005761
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 29 Jan 2008 13:54:15 -0800
In-Reply-To: <7vwspts9vj.fsf@gitster.siamese.dyndns.org>
X-Trusted-Delivery: <ce4591c2dfcd05ffcdc45e0c5aee5b6a>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72002>

Quoting Junio C Hamano <gitster@pobox.com>:

> Currently, we:
>
>  - Remove "." path component (i.e. the directory leading part
>    specified) from the input;
>
>  - Remove ".." path component and strip one level of the prefix;
>
> only from the beginning.  So if you give nonsense pathspec from
> the command line, you can end up calling prefix_path() with things
> like "/README", "/absolute/path/to//repository/tracked/file", and
> "fo//o/../o".
>
> And not passing such ambiguous path like "fo//o" to the core
> level but sanitizing matters.  Then core level can always do
> memcmp() with "fo/o" to see they are talking about the same
> path.

I may be mistaken but I think "fo//o" and "fo//o/" are returned as two different strings "fo/o" and "fo/o/" from your patch. Shouldn't you clean-up the second one to "fo/o", too?

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/

----------------------------------------------------------------------
Free pop3 email with a spam filter.
http://www.bluebottle.com/tag/5
