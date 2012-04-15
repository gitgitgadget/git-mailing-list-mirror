From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH v5 3/4] git-cherry-pick: Add test to validate new options
Date: Sun, 15 Apr 2012 11:39:35 +0200
Message-ID: <20120415093933.GB6263@ecki>
References: <1333136922-12872-1-git-send-email-nhorman@tuxdriver.com>
 <1334342707-3326-1-git-send-email-nhorman@tuxdriver.com>
 <1334342707-3326-4-git-send-email-nhorman@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Phil Hord <phil.hord@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Neil Horman <nhorman@tuxdriver.com>
X-From: git-owner@vger.kernel.org Sun Apr 15 11:41:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJLxa-0000EU-JL
	for gcvg-git-2@plane.gmane.org; Sun, 15 Apr 2012 11:41:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753468Ab2DOJkw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Apr 2012 05:40:52 -0400
Received: from smtpout12.highway.telekom.at ([195.3.96.74]:55793 "EHLO
	email.aon.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751534Ab2DOJkv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Apr 2012 05:40:51 -0400
Received: (qmail 12172 invoked from network); 15 Apr 2012 09:40:48 -0000
X-Spam-Checker-Version: SpamAssassin 3.2.0 (2007-05-01) on
	WARSBL504.highway.telekom.at
X-Spam-Level: ****
Received: from p5b22d2b0.dip.t-dialin.net (HELO [127.0.0.1]) (aon.912301525.1@aon.at@[91.34.210.176])
          (envelope-sender <drizzd@aon.at>)
          by smarthub76.res.a1.net (qmail-ldap-1.03) with AES128-SHA encrypted SMTP
          for <nhorman@tuxdriver.com>; 15 Apr 2012 09:40:47 -0000
Content-Disposition: inline
In-Reply-To: <1334342707-3326-4-git-send-email-nhorman@tuxdriver.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195552>

On Fri, Apr 13, 2012 at 02:45:06PM -0400, Neil Horman wrote:
>  
> +test_expect_success 'cherry pick an empty non-ff commit without --allow-empty' '
> +	git checkout master &&
> +	echo fourth >> file2 &&
> +	git add file2 &&
> +	git commit -m "fourth" && {
> +		test_must_fail git cherry-pick empty-branch2
> +	}
> +'

You don't need the braces. The same below.

> +
> +test_expect_success 'cherry pick an empty non-ff commit with --allow-empty' '
> +	git checkout master && {
> +		git cherry-pick --allow-empty empty-branch2
> +	}
> +'
> +
> +test_expect_success 'cherry pick with --keep-redundant-commits' '
> +	git checkout master && {
> +		git cherry-pick --keep-redundant-commits HEAD^
> +	}
> +'

And the expected result is that the HEAD commit is not removed, right?
You should check for that as well.

Also, please checkout empty-branch2^0 first, in order to make the test
independent of its predecessor.
