From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH 05/20] contrib/examples/git-repack.sh: avoid "test
 <cond> -a/-o <cond>"
Date: Tue, 10 Jun 2014 11:39:00 -0700
Message-ID: <20140610183900.GB72751@gmail.com>
References: <1402066563-28519-1-git-send-email-gitter.spiros@gmail.com>
 <1402066563-28519-6-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, jrnieder@gmail.com
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 10 20:39:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuQwv-00064h-5i
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 20:39:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750897AbaFJSjE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2014 14:39:04 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:53072 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750822AbaFJSjD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 14:39:03 -0400
Received: by mail-pa0-f42.google.com with SMTP id lj1so112900pab.1
        for <git@vger.kernel.org>; Tue, 10 Jun 2014 11:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Fe7pVVeYu5TYIN3vwY/gC+fS0qFZv/yt5RL7imWSyCU=;
        b=Zj9cbzSNNjPwTbM8BA1lhQLe8ROblsIAI/4cgA4OMDnvBteCYKAJnquc9r3kMdeNkn
         POhMIK1SMzyhbYakRwYTdsCbL5dMuaD4VmhRpxPPmk0z1vJDQjbscU0soF+60VfLaIRn
         DbcNnOwRjd9PprFA0bFCE9w1+oie5m1+ReXGNBXvH0TZ/Bxmpc0W6/+YmLkTO1YW9m1V
         BTeAJT+QpzqParJjkFyop5KpX3Fc6n5qna+B7m2UnzyUKFOjormU/NLaBQsZouqRHd+Y
         hzct7j7n5Q5+YQ+RdOzB18ktslDozh1bk7TUn895zMHOD69fqf63NX2zrxRXziuUKihm
         tXMg==
X-Received: by 10.68.136.226 with SMTP id qd2mr13568481pbb.72.1402425541726;
        Tue, 10 Jun 2014 11:39:01 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id zn9sm16715923pac.31.2014.06.10.11.39.00
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 10 Jun 2014 11:39:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1402066563-28519-6-git-send-email-gitter.spiros@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251209>

On Fri, Jun 06, 2014 at 07:55:48AM -0700, Elia Pinto wrote:
> The construct is error-prone; "test" being built-in in most modern
> shells, the reason to avoid "test <cond> && test <cond>" spawning
> one extra process by using a single "test <cond> -a <cond>" no
> longer exists.
> 
> Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
> ---
>  contrib/examples/git-repack.sh |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/contrib/examples/git-repack.sh b/contrib/examples/git-repack.sh
> index f312405..96e3fed 100755
> --- a/contrib/examples/git-repack.sh
> +++ b/contrib/examples/git-repack.sh
> @@ -76,8 +76,8 @@ case ",$all_into_one," in
>  				existing="$existing $e"
>  			fi
>  		done
> -		if test -n "$existing" -a -n "$unpack_unreachable" -a \
> -			-n "$remove_redundant"
> +		if test -n "$existing" && test -n "$unpack_unreachable" && \
> +			test -n "$remove_redundant"
>  		then

I do not think the traling "\" is needed anymore; the "&&" takes care of it.
-- 
David
