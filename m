From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v8 28/44] refs.c: make write_ref_sha1 static
Date: Tue, 20 May 2014 17:51:34 -0700
Message-ID: <20140521005134.GY12314@google.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
 <1400174999-26786-29-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Wed May 21 02:51:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wmukv-0008SW-EL
	for gcvg-git-2@plane.gmane.org; Wed, 21 May 2014 02:51:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751395AbaEUAvi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2014 20:51:38 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:56774 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751273AbaEUAvh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2014 20:51:37 -0400
Received: by mail-pa0-f45.google.com with SMTP id ey11so832500pad.32
        for <git@vger.kernel.org>; Tue, 20 May 2014 17:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=R69iqjpNsYK9YX7KtYZ7bFyoX0G/lbaD3+1YXKMUHM4=;
        b=aRxciI3vJbcJ4Y1btFq0GVQH0gxs4f31im/RZNQqTAjcjTW4r7uXDPaxqnZJ/f3UY4
         cV7P+eZV63+LaGFQQrSjSPlC06GG+zezggmGs16MwHGEnfT4HOWQ8rimc8UWpmgCh/qp
         CdF0bz/JzcHVklX9ANH70boG9dEgrOcpAcXGXeIjAGQIYceY5ILW919JMBIhNazt2ZN7
         lvPcpWM8mo+BWhwKVDnSm++AlTmO2C3xQLklENHP9fop4bLhhogIZRv2ed3dWaxsfUDf
         Y2Y8yzozz1et3MDfw+IpdvXsC0BPCQIh/Ibsj1TecAEWnBdR8ICV5emJGjG44xyx+J9w
         6/yA==
X-Received: by 10.68.89.4 with SMTP id bk4mr54815749pbb.153.1400633496882;
        Tue, 20 May 2014 17:51:36 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id gu1sm5152684pbd.0.2014.05.20.17.51.35
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 20 May 2014 17:51:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1400174999-26786-29-git-send-email-sahlberg@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249769>

Ronnie Sahlberg wrote:

> No external users call write_ref_sha1 any more so lets declare it static.

Yay!

[...]
> +++ b/refs.c
> @@ -251,6 +251,8 @@ struct ref_entry {
[...]
>  static void read_loose_refs(const char *dirname, struct ref_dir *dir);
> +static int write_ref_sha1(struct ref_lock *lock,
> +			  const unsigned char *sha1, const char *logmsg);

Is this forward declaration needed?

[...]
> --- a/refs.h
> +++ b/refs.h
> @@ -150,9 +150,6 @@ extern int commit_ref(struct ref_lock *lock);
>  /** Release any lock taken but not written. **/
>  extern void unlock_ref(struct ref_lock *lock);
>  
> -/** Writes sha1 into the ref specified by the lock. **/
> -extern int write_ref_sha1(struct ref_lock *lock, const unsigned char *sha1, const char *msg);

(nit) Would be nice to keep the documentation comment.

Thanks,
Jonathan
