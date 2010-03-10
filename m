From: Geert Bosch <bosch@adacore.com>
Subject: Re: [PATCH] darwin: Use CommonCrypto to compute SHA1
Date: Tue, 9 Mar 2010 23:00:33 -0500
Message-ID: <392914AB-CF6D-4094-969D-6057608F86F8@adacore.com>
References: <9AE94716-A53B-40A6-A7D9-CCD39B820390@apple.com>
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeremy Huddleston <jeremyhu@apple.com>
X-From: git-owner@vger.kernel.org Wed Mar 10 05:06:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NpDBo-0001ri-U8
	for gcvg-git-2@lo.gmane.org; Wed, 10 Mar 2010 05:06:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756177Ab0CJEG3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Mar 2010 23:06:29 -0500
Received: from rock.gnat.com ([205.232.38.15]:53506 "EHLO rock.gnat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756148Ab0CJEG1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Mar 2010 23:06:27 -0500
X-Greylist: delayed 351 seconds by postgrey-1.27 at vger.kernel.org; Tue, 09 Mar 2010 23:06:27 EST
Received: from localhost (localhost.localdomain [127.0.0.1])
	by filtered-rock.gnat.com (Postfix) with ESMTP id 026F82BAB8A;
	Tue,  9 Mar 2010 23:00:35 -0500 (EST)
X-Virus-Scanned: Debian amavisd-new at gnat.com
Received: from rock.gnat.com ([127.0.0.1])
	by localhost (rock.gnat.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id mAG-b6h09T7N; Tue,  9 Mar 2010 23:00:34 -0500 (EST)
Received: from [172.16.1.4] (sdsl-216-220-103-157.dsl.bway.net [216.220.103.157])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rock.gnat.com (Postfix) with ESMTPSA id AB2942BAB7C;
	Tue,  9 Mar 2010 23:00:34 -0500 (EST)
In-Reply-To: <9AE94716-A53B-40A6-A7D9-CCD39B820390@apple.com>
X-Mailer: Apple Mail (2.1077)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mar 9, 2010, at 19:01, Jeremy Huddleston wrote:
> From: Jeremy Huddleston <jeremyhu@apple.com>
> Date: Mon, 8 Mar 2010 15:10:54 -0800
> Subject: [PATCH] darwin: Use CommonCrypto to compute SHA1
> 
> Signed-off-by: Jeremy Huddleston <jeremyhu@apple.com>
> Reviewed-by: Kevin Van Vechten <kvv@apple.com>
> ---
> Makefile |   14 ++++++++++++++
> cache.h  |    7 +++++++
> 2 files changed, 21 insertions(+), 0 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index f64610a..bb4a1f0 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -91,6 +91,10 @@ all::
> # Define PPC_SHA1 environment variable when running make to make use of
> # a bundled SHA1 routine optimized for PowerPC.
> #
> +# Define COMMONCRYPTO_SHA1 environment variable when running make to make
> +# use of the Darwin/Mac OS X Common Cryptography library for SHA1
> +# computation (instead of libcrypto).
> +#

You're missing an argument of why this would be an improvement over
the status quo. If the argument is performance, you'd better show
some convincing numbers, both of SHA-1 heavy tasks and situations
where program initialization is an important factor.

By default, increasing the number of different ways we use to
compute the SHA1 is a negative development. There has to be a
strong reason to do so, such as: for my workload X this saves 
me Y seconds each time I do Z.

  -Geert
