From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 2/5] run-command: teach async threads to ignore SIGPIPE
Date: Thu, 21 Apr 2016 07:15:26 +0200
Message-ID: <571861EE.1080202@kdbg.org>
References: <20160419223945.GA18055@sigill.intra.peff.net>
 <20160419224941.GB18255@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 21 07:15:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1at6xh-0001Yl-I9
	for gcvg-git-2@plane.gmane.org; Thu, 21 Apr 2016 07:15:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751588AbcDUFPa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Apr 2016 01:15:30 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:39875 "EHLO bsmtp1.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751282AbcDUFP3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2016 01:15:29 -0400
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 3qr6QR0GH4z5tlK;
	Thu, 21 Apr 2016 07:15:26 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id 19DED5232;
	Thu, 21 Apr 2016 07:15:26 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
In-Reply-To: <20160419224941.GB18255@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292093>

Am 20.04.2016 um 00:49 schrieb Jeff King:
> This is our first use of pthread_sigmask, and I think Windows will have
> to come up with something for this in compat/. I don't know how SIGPIPE
> works there at all, so it's possible that we can just turn this into a
> noop. Worst case it could probably block SIGPIPE for the whole process.

There is no SIGPIPE on Windows. write() always returns EPIPE as if 
SIGPIPE was ignored.

We'll have to make pthread_sigmask() a no-op.

-- Hannes
