From: "Mikael Magnusson" <mikachu@gmail.com>
Subject: Re: [PATCH] explicitly set LANG to 'C' in for guilt run-tests
Date: Mon, 29 Sep 2008 22:25:48 +0200
Message-ID: <237967ef0809291325p7a0e3581vac348a1e99dbd4ed@mail.gmail.com>
References: <1222714272-9557-1-git-send-email-smoser@brickies.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Josef Jeff Sipek" <jsipek@cs.sunysb.edu>, git@vger.kernel.org
To: "Scott Moser" <smoser@brickies.net>
X-From: git-owner@vger.kernel.org Mon Sep 29 22:37:24 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KkPUg-0005Yr-SR
	for gcvg-git-2@gmane.org; Mon, 29 Sep 2008 22:37:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752372AbYI2Ufx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Sep 2008 16:35:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753876AbYI2Ufx
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Sep 2008 16:35:53 -0400
Received: from ey-out-2122.google.com ([74.125.78.27]:50851 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752255AbYI2Ufw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Sep 2008 16:35:52 -0400
Received: by ey-out-2122.google.com with SMTP id 6so638358eyi.37
        for <git@vger.kernel.org>; Mon, 29 Sep 2008 13:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=8vfund4TKTblgq3YCB/sHD6btuOz5P58o7mEhsnz3oA=;
        b=uwKbYQ9B4vlm6RwIuXtO3FBbg3BT38nh4mwQM0BOnlW5UBwhplwnuE3+jbgwYsbMOI
         9oRWYbWy1x0XaUlmtnneQwL45MLR9+EU7vD/S7oADCSsLG4aMVkNsUp93qOz1QBdDR3C
         eaZ59+m492hoPGDH6xZtxfGis6ci2W6cQypCM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=KaaynWCM5FJt+7v9XK+ESBtyVM6iX9n5ygOz4B3Mb6xsQYnVNd4UG0RL8VZEXszJpW
         dmhiEA99UUKZp16GNYtXnrYmFW/14JDk4vQlMfbY+Vzeh4LkC4ab4C+xhiKn4HULUmj6
         k6FFzL5FpCw/i5crKcjziVEbqgmfvKTB4njrA=
Received: by 10.210.78.16 with SMTP id a16mr6784192ebb.53.1222719948972;
        Mon, 29 Sep 2008 13:25:48 -0700 (PDT)
Received: by 10.210.19.20 with HTTP; Mon, 29 Sep 2008 13:25:48 -0700 (PDT)
In-Reply-To: <1222714272-9557-1-git-send-email-smoser@brickies.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97052>

2008/9/29 Scott Moser <smoser@brickies.net>:
> The output of guilt's run-tests is dependent on LANG due to reliance on a
> given sorting algorithm. Currently, the test '052' will fail if LANG is
> set to 'en_US.UTF-8' (and likely others values).
>
> Remove the assumption by explicitly setting this in run-tests.
>
> Signed-off-by: Scott Moser <smoser@brickies.net>
> ---
>  regression/run-tests |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/regression/run-tests b/regression/run-tests
> index 8f572eb..945150b 100755
> --- a/regression/run-tests
> +++ b/regression/run-tests
> @@ -2,6 +2,7 @@
>
>  export REG_DIR="$PWD"
>  export PATH="$PWD/bin:$PATH"
> +export LANG=C
>
>  source scaffold
>
> --
> 1.5.6.3

If I'm not mistaken, $LANG is used as the ultimate fallback, while LC_ALL is
the one that overrides all others, so you probably want to set LC_ALL. I'm
unsure which off the specific ones would apply here, but very likely it's
LC_COLLATE. In other words, if LC_ALL is set, it is used, otherwise if
LC_COLLATE is set it is used, otherwise if LANG is set, it is used,
otherwise, "POSIX" is used.

-- 
Mikael Magnusson
