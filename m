From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v5 08/35] lock_file(): always add lock_file object to
 lock_file_list
Date: Tue, 16 Sep 2014 13:57:36 -0700
Message-ID: <20140916205736.GI29050@google.com>
References: <1410896036-12750-1-git-send-email-mhagger@alum.mit.edu>
 <1410896036-12750-9-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Sep 16 22:57:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTzom-000854-10
	for gcvg-git-2@plane.gmane.org; Tue, 16 Sep 2014 22:57:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755490AbaIPU5l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2014 16:57:41 -0400
Received: from mail-pd0-f175.google.com ([209.85.192.175]:60499 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754307AbaIPU5k (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Sep 2014 16:57:40 -0400
Received: by mail-pd0-f175.google.com with SMTP id z10so581922pdj.6
        for <git@vger.kernel.org>; Tue, 16 Sep 2014 13:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=X2GRM6DnsJ+3Cdz7Hb9UrrL6pb5R+4Qobv5wz+wM5Ac=;
        b=EbhiFLGvrqV+BddTWssKOPOzZDKT/K1qW/C2LYjO4n0d/weFa9jys25rcwB513Bjrh
         LBf9/xx2x66YL2f5KpyhwNnAXDhqBp/5nXtrdxRCCoYoNVHLnTR7ku+TqYZdUvawVttG
         u5OEwaYuUm8QkLXB6UPWotZN0QPe/sm1eixFmo8pyzaU+j+Doj4rPTvMfjKVuiy1m8BD
         cKnAQtFQSJp/hv428d9zN9YjqnOeaGCWR2k0sKq/Aj0EcWaVco/2BOLPwOcmOiuGt8dp
         i2+0pGMayqPwKOq7yiDXw0+1t5zzaJJx3AyUL9UhDwOM6RtkGZgpHS1qa7UTeze6MBei
         EI8A==
X-Received: by 10.66.222.97 with SMTP id ql1mr27072767pac.119.1410901059474;
        Tue, 16 Sep 2014 13:57:39 -0700 (PDT)
Received: from google.com (aiede.mtv.corp.google.com [172.27.69.120])
        by mx.google.com with ESMTPSA id h12sm14961055pdk.48.2014.09.16.13.57.38
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 16 Sep 2014 13:57:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1410896036-12750-9-git-send-email-mhagger@alum.mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257192>

Michael Haggerty wrote:

> The ambiguity didn't have any ill effects, because lock_file objects
> cannot be removed from the lock_file_list anyway.  But it is
> unnecessary to leave this behavior inconsistent.

Nit: commit messages usually use present tense for current behavior
(and imperative for the behavior after the patch).

More importantly, the above + the diffstat don't leave me very happy
about the change.

Can you spell out more about the intended effect?  E.g., is this about
making sure other code is appropriately exercised to tolerate the
signal handler even when there are a lot of errors (which should make
debugging easier) or something?
