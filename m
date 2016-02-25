From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/7] run_processes_parallel: rename parameters for the
 callbacks
Date: Wed, 24 Feb 2016 17:47:02 -0800
Message-ID: <20160225014702.GQ28749@google.com>
References: <1456364525-21190-1-git-send-email-sbeller@google.com>
 <1456364525-21190-4-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens.Lehmann@web.de, peff@peff.net,
	sunshine@sunshineco.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 02:47:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYl1h-0003Z4-Dm
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 02:47:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752579AbcBYBrP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2016 20:47:15 -0500
Received: from mail-pa0-f41.google.com ([209.85.220.41]:35546 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759310AbcBYBrF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 20:47:05 -0500
Received: by mail-pa0-f41.google.com with SMTP id ho8so23358800pac.2
        for <git@vger.kernel.org>; Wed, 24 Feb 2016 17:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=OA/yn7WQoiC+RddwcrC7rdUb5KPoCj7y6nSAWJnuK8I=;
        b=vx+yUdFDCksVp4XiU++WjLICUPVyTUM7gewcA+ZVaXXOkTfPn2URIkqW3fxLt51qfv
         SCmV4F0oJmUqRtpY8ZV/UlUDk32VhkMtGoEthQ0wXrevA78PHJN0OG1kCgzeHZvVjy5D
         9wTrdgBuObqdIheVHG57S9BdHA/hTPo9oJVM1XBGh2STFX2xDDagCGfZFszu1UydWZzd
         rgNiGaBX3XJmD1AhKmnMWjnbDspLnLvL6GWCiTQDhjBPJCCR4rKlk4T6m5CRLfwhIjWV
         VVQZWhMFcIl2lZ8w9Yaz2eiVqPkohL/upSUyNcFWOuADOMy7acWZNscVV4rZfUVI4Bg4
         q2jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=OA/yn7WQoiC+RddwcrC7rdUb5KPoCj7y6nSAWJnuK8I=;
        b=jCrFy5lIVCdZ0hwWkg/ERVD/2eFAq0CTXH7/ngtNb/BF1fny6FPM9xPdSYnBRw04TT
         1fGdSQZb3ILAkKFP2uIP82NnAfxuvgY/IRILDyxMzGYCD5ZuoIjPhl2r4O4N4UKwZ1jg
         Reqa2yzIfII9fPu4ZAH1dSUNAS07EaBfiHt0BunA49aqiD/sNSJfGfBwh71j27zKqO35
         BblLYbQzdJicNK/TkqbxLV6e56sQgNzZ81R0p6YSYcN1My9x6k3+N47iPIDYQgBAc3Ac
         VpGKx3MQlW4f+KvNexYJi9MF19F7Vy+FF1U44JwYUL8G51mJOy5FzaLahX1Xcj4eYIZj
         p6DQ==
X-Gm-Message-State: AG10YOTz+JxGUGtGSso6cfpQrfoaTkCZ1T92umQrGVIGjxhjzWY47y1a/hNkT1UUaGre+Q==
X-Received: by 10.66.100.228 with SMTP id fb4mr58361818pab.84.1456364825030;
        Wed, 24 Feb 2016 17:47:05 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:41cf:620e:463d:86cf])
        by smtp.gmail.com with ESMTPSA id 195sm7748632pfa.5.2016.02.24.17.47.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 24 Feb 2016 17:47:04 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1456364525-21190-4-git-send-email-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287310>

Stefan Beller wrote:

> +++ b/run-command.h
> @@ -159,7 +159,7 @@ typedef int (*get_next_task_fn)(struct child_process *cp,
>   * the negative signal number.
>   */
>  typedef int (*start_failure_fn)(struct child_process *cp,
> -				struct strbuf *err,
> +				struct strbuf *out,
>  				void *pp_cb,
>  				void *pp_task_cb);

Yay, thank you.  The docstrings still refer to err.

Jonathan
