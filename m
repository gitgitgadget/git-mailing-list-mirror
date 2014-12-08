From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 13/23] Rename expire_reflog_cb to expire_reflog_policy_cb
Date: Mon, 8 Dec 2014 14:46:10 -0800
Message-ID: <20141208224610.GE25562@google.com>
References: <1417734515-11812-1-git-send-email-mhagger@alum.mit.edu>
 <1417734515-11812-14-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Dec 08 23:46:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xy74K-0000cx-Pm
	for gcvg-git-2@plane.gmane.org; Mon, 08 Dec 2014 23:46:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754925AbaLHWqN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Dec 2014 17:46:13 -0500
Received: from mail-pa0-f74.google.com ([209.85.220.74]:63428 "EHLO
	mail-pa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751520AbaLHWqM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Dec 2014 17:46:12 -0500
Received: by mail-pa0-f74.google.com with SMTP id kq14so795457pab.1
        for <git@vger.kernel.org>; Mon, 08 Dec 2014 14:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=aUxmhdyD40NJPBtZZhjoiEidsr80GMT703abyPfHK0c=;
        b=S2/YB8pVvV+NdDjfZfiOYbI/iF1wd1aTsCE1wrBqzX+h4vlbbLgVYeGigtvTQlM5QI
         RmkZW5IN/SsZgd7vgMQvAhfbnzEaux6mBFc+2irbp+yW1M8PclmYzi6zCsplVRLs6E2U
         zU0l5xVvFkpki7cJtowYfsvfWaS6M6p8PxRHlrlpvBrQMheQPkywTXTdxW8Yk/cTiUxL
         xTXmYG6Gs8FJgb6GrIS0O7jvaay5KAGHec39TVB0Bx3ZyJEnwdV/O4gRzojPtnVU/A9r
         f/JnPupx7Maq0avUXjHecZrvzGfu39NXMc9Umv2oHPFLqvAyGJoFoZQKVW/jNcnquQ3I
         VX9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=aUxmhdyD40NJPBtZZhjoiEidsr80GMT703abyPfHK0c=;
        b=icOnw9ve7+CttCqGBfLMzEkpA4IM7RSmcckTat9OKbm2zH4A0C+eAboBVqLLhVXI+L
         y8J5eMxzvIdr6Q4RQrU/E1KguSpulLV2+wiZ3d7PYrKuE/b3nNvL9bExDWc6QwZD7ep5
         1y75U31p/47li5HDwLVGqV3niGMJrJt1SpU8iDevGAnlpYmiahgyrxYGrkXXSlklVzeE
         TtfwqTDY3ZjTTXPm1qW2Ixu3QILkEolM8+qgs8cuvG1AxrietFwPU4zIGffqK5QP7kBN
         eRpmijvn2Aj5Yoq/dBNJ3FY9m2OY5g48LB5YwtKwMTsgmRtRu/Q9G+QVpcK4xARSlZXo
         hWaQ==
X-Gm-Message-State: ALoCoQl/wv+sOS17ssVFWMutPavDn0/lGLimdHDbDf235fFT/fgnWFnV4oD2muAjQGGJdvIW2S5f
X-Received: by 10.68.65.70 with SMTP id v6mr34082045pbs.1.1418078771620;
        Mon, 08 Dec 2014 14:46:11 -0800 (PST)
Received: from corpmail-nozzle1-2.hot.corp.google.com ([100.108.1.103])
        by gmr-mx.google.com with ESMTPS id t24si1694971yht.2.2014.12.08.14.46.11
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Dec 2014 14:46:11 -0800 (PST)
Received: from sbeller.mtv.corp.google.com ([172.27.69.125])
	by corpmail-nozzle1-2.hot.corp.google.com with ESMTP id ul8d7kMf.1; Mon, 08 Dec 2014 14:46:11 -0800
Received: by sbeller.mtv.corp.google.com (Postfix, from userid 279346)
	id 87939140BBD; Mon,  8 Dec 2014 14:46:10 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1417734515-11812-14-git-send-email-mhagger@alum.mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261090>

On Fri, Dec 05, 2014 at 12:08:25AM +0100, Michael Haggerty wrote:
> This is the first step towards separating the data needed by the
> policy code from the data needed by the reflog expiration machinery.
> 
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>

Reviewed-by: <sbeller@google.com>
> ---
>  builtin/reflog.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/builtin/reflog.c b/builtin/reflog.c
> index 597c547..3538e4b 100644
> --- a/builtin/reflog.c
> +++ b/builtin/reflog.c
> @@ -30,7 +30,7 @@ struct cmd_reflog_expire_cb {
>  	int recno;
>  };
>  
> -struct expire_reflog_cb {
> +struct expire_reflog_policy_cb {
>  	FILE *newlog;
>  	enum {
>  		UE_NORMAL,
> @@ -220,7 +220,7 @@ static int keep_entry(struct commit **it, unsigned char *sha1)
>   * the expire_limit and queue them back, so that the caller can call
>   * us again to restart the traversal with longer expire_limit.
>   */
> -static void mark_reachable(struct expire_reflog_cb *cb)
> +static void mark_reachable(struct expire_reflog_policy_cb *cb)
>  {
>  	struct commit *commit;
>  	struct commit_list *pending;
> @@ -259,7 +259,7 @@ static void mark_reachable(struct expire_reflog_cb *cb)
>  	cb->mark_list = leftover;
>  }
>  
> -static int unreachable(struct expire_reflog_cb *cb, struct commit *commit, unsigned char *sha1)
> +static int unreachable(struct expire_reflog_policy_cb *cb, struct commit *commit, unsigned char *sha1)
>  {
>  	/*
>  	 * We may or may not have the commit yet - if not, look it
> @@ -295,7 +295,7 @@ static int should_expire_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
>  				    const char *email, unsigned long timestamp, int tz,
>  				    const char *message, void *cb_data)
>  {
> -	struct expire_reflog_cb *cb = cb_data;
> +	struct expire_reflog_policy_cb *cb = cb_data;
>  	struct commit *old, *new;
>  
>  	if (timestamp < cb->cmd->expire_total)
> @@ -323,7 +323,7 @@ static int expire_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
>  		const char *email, unsigned long timestamp, int tz,
>  		const char *message, void *cb_data)
>  {
> -	struct expire_reflog_cb *cb = cb_data;
> +	struct expire_reflog_policy_cb *cb = cb_data;
>  
>  	if (cb->cmd->rewrite)
>  		osha1 = cb->last_kept_sha1;
> @@ -350,7 +350,8 @@ static int expire_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
>  	return 0;
>  }
>  
> -static int push_tip_to_list(const char *refname, const unsigned char *sha1, int flags, void *cb_data)
> +static int push_tip_to_list(const char *refname, const unsigned char *sha1,
> +			    int flags, void *cb_data)
>  {
>  	struct commit_list **list = cb_data;
>  	struct commit *tip_commit;
> @@ -365,7 +366,7 @@ static int push_tip_to_list(const char *refname, const unsigned char *sha1, int
>  
>  static void reflog_expiry_prepare(const char *refname,
>  				  const unsigned char *sha1,
> -				  struct expire_reflog_cb *cb)
> +				  struct expire_reflog_policy_cb *cb)
>  {
>  	if (!cb->cmd->expire_unreachable || !strcmp(refname, "HEAD")) {
>  		cb->tip_commit = NULL;
> @@ -397,7 +398,7 @@ static void reflog_expiry_prepare(const char *refname,
>  	}
>  }
>  
> -static void reflog_expiry_cleanup(struct expire_reflog_cb *cb)
> +static void reflog_expiry_cleanup(struct expire_reflog_policy_cb *cb)
>  {
>  	if (cb->unreachable_expire_kind != UE_ALWAYS) {
>  		if (cb->unreachable_expire_kind == UE_HEAD) {
> @@ -422,7 +423,7 @@ static int expire_reflog(const char *refname, const unsigned char *sha1,
>  			 unsigned int flags, void *cb_data)
>  {
>  	struct cmd_reflog_expire_cb *cmd = cb_data;
> -	struct expire_reflog_cb cb;
> +	struct expire_reflog_policy_cb cb;
>  	struct ref_lock *lock;
>  	char *log_file;
>  	int status = 0;
> -- 
> 2.1.3
> 
