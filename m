From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 4/8] Rename struct diff_filespec's sha1_valid member.
Date: Tue, 7 Jun 2016 08:21:26 +0200
Message-ID: <575667E6.7030509@kdbg.org>
References: <20160607005716.69222-2-sandals@crustytoothpaste.net>
 <20160607005716.69222-5-sandals@crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Tue Jun 07 08:21:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAAOd-0002Tm-Vv
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 08:21:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753394AbcFGGVc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2016 02:21:32 -0400
Received: from bsmtp3.bon.at ([213.33.87.17]:62916 "EHLO bsmtp3.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753049AbcFGGVa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2016 02:21:30 -0400
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 3rP1fw0Clhz5tlH;
	Tue,  7 Jun 2016 08:21:27 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id CDA9952A6;
	Tue,  7 Jun 2016 08:21:26 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
In-Reply-To: <20160607005716.69222-5-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296600>

Am 07.06.2016 um 02:57 schrieb brian m. carlson:
> Now that this struct's sha1 member is called "oid", update the comment
> and the sha1_valid member to be called "oid_valid" instead.  The
> following Coccinelle semantic patch was used to implement this, followed
> by the transformations in standard.cocci:
>
> @@
> struct diff_filespec *p;
> @@
> - p->sha1_valid
> + p->oid_valid
>
> @@
> struct diff_filespec o;
> @@
> - o.sha1_valid
> + o.oid_valid
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>   combine-diff.c    |  4 ++--
>   diff.c            | 28 ++++++++++++++--------------
>   diffcore-break.c  |  2 +-
>   diffcore-rename.c |  4 ++--
>   diffcore.h        |  2 +-
>   line-log.c        | 10 +++++-----
>   6 files changed, 25 insertions(+), 25 deletions(-)
>
> diff --git a/combine-diff.c b/combine-diff.c
> index f39be434..a20caa80 100644
> --- a/combine-diff.c
> +++ b/combine-diff.c
> @@ -1269,7 +1269,7 @@ static struct diff_filepair *combined_pair(struct combine_diff_path *p,
>   		pair->one[i].path = p->path;
>   		pair->one[i].mode = p->parent[i].mode;
>   		oidcpy(&pair->one->oid, &p->parent[i].oid);
> -		pair->one[i].sha1_valid = !is_null_oid(&p->parent[i].oid);
> +		pair->one->oid_valid = !is_null_oid(&p->parent[i].oid);

Is this transformation correct?

>   		pair->one[i].has_more_entries = 1;
>   	}
>   	pair->one[num_parent - 1].has_more_entries = 0;

-- Hannes
