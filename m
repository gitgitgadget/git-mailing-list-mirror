From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v9 1/4] cache-tree: Create/update cache-tree on checkout
Date: Tue, 15 Jul 2014 21:35:43 +0200
Message-ID: <53C5828F.2050005@web.de>
References: <1405283299-25636-1-git-send-email-dturner@twitter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: David Turner <dturner@twitter.com>
To: David Turner <dturner@twopensource.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 15 21:39:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X78Z5-0004BD-Io
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jul 2014 21:39:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933302AbaGOTjA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2014 15:39:00 -0400
Received: from mout.web.de ([212.227.17.12]:55648 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933003AbaGOTi6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2014 15:38:58 -0400
Received: from [192.168.1.136] ([80.120.39.178]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0McWrM-1Wpbg73rxw-00HbZY; Tue, 15 Jul 2014 21:38:56
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Icedove/24.6.0
In-Reply-To: <1405283299-25636-1-git-send-email-dturner@twitter.com>
X-Provags-ID: V03:K0:40mEfYMBCYm8730htUxo/tFE8QQ2SxhrVGSSLkXFpDjWfvQrZG6
 z22GjlPqiBugZzUCBAoA2z4v4iVMHYBe8K9EqBsenEQP/Vc482+pN2lBGt2jpTnj63iwcDJ
 jwzmI4YVupPjx/xjFj0pKQtZjtLLUTr4Cthv1QOK2whsJtjfTCAyR6nyZMC2EH9BU88qlKu
 t2xGZAWYbzkEzNHMCggUg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253594>

On 07/13/2014 10:28 PM, David Turner wrote:
> From: David Turner <dturner@twopensource.com>
[]
> diff --git a/cache-tree.c b/cache-tree.c
> index 7fa524a..f951d7d 100644
> --- a/cache-tree.c
> +++ b/cache-tree.c
> @@ -239,9 +239,12 @@ static int update_one(struct cache_tree *it,
>   	struct strbuf buffer;
>   	int missing_ok = flags & WRITE_TREE_MISSING_OK;
>   	int dryrun = flags & WRITE_TREE_DRY_RUN;
> +	int repair = flags & WRITE_TREE_REPAIR;
>   	int to_invalidate = 0;
>   	int i;
>   
> +	assert(!(dryrun && repair));
I think something in the spirit of
die("dryrun and repaiir can not be used together"\n)
Would be nicer to the user as well as being more reliable (as assert may 
be a no-op in some systems)
