From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 02/11] revert: Lose global variables "commit" and "me"
Date: Mon, 11 Apr 2011 05:24:20 +0200
Message-ID: <201104110524.21104.chriscool@tuxfamily.org>
References: <1302448317-32387-1-git-send-email-artagnon@gmail.com> <1302448317-32387-3-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 11 05:24:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q97ju-00011N-Vn
	for gcvg-git-2@lo.gmane.org; Mon, 11 Apr 2011 05:24:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753244Ab1DKDYa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Apr 2011 23:24:30 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:51531 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752633Ab1DKDY3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Apr 2011 23:24:29 -0400
Received: from style.localnet (unknown [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id A7AB3A637C;
	Mon, 11 Apr 2011 05:24:22 +0200 (CEST)
User-Agent: KMail/1.13.5 (Linux/2.6.35-22-generic; KDE/4.5.1; x86_64; ; )
In-Reply-To: <1302448317-32387-3-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171302>

On Sunday 10 April 2011 17:11:48 Ramkumar Ramachandra wrote:
> @@ -546,10 +547,13 @@ static int prepare_revs(struct rev_info *revs)
>  	return 0;
>  }
> 
> -static int read_and_refresh_cache(const char *me)
> +static int read_and_refresh_cache(void)
>  {
>  	static struct lock_file index_lock;
>  	int index_fd = hold_locked_index(&index_lock, 0);
> +	const char *me;
> +
> +	me = (cmd_opts.action == REVERT ? "revert" : "cherry-pick");

It looks like this patch will not compile as cmd_opts is introduced in patch 
03/11.

>  	if (read_index_preload(&the_index, NULL) < 0)
>  		return error(_("%s: failed to read the index"), me);
>  	refresh_index(&the_index, REFRESH_QUIET|REFRESH_UNMERGED, NULL, NULL,

Best regards,
Christian.
