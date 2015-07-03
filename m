From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase: return non-zero error code if format-patch fails
Date: Fri, 03 Jul 2015 10:52:32 -0700
Message-ID: <xmqqpp493z8f.fsf@gitster.dls.corp.google.com>
References: <20150702091133.GA13353@musxeris015.imu.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Andrew Wong <andrew.kw.w@gmail.com>,
	Jorge Nunes <jorge.nunes@intel.com>
To: Clemens Buchacher <clemens.buchacher@intel.com>
X-From: git-owner@vger.kernel.org Fri Jul 03 19:52:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZB58i-00086G-8z
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jul 2015 19:52:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754930AbbGCRwf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jul 2015 13:52:35 -0400
Received: from mail-ig0-f172.google.com ([209.85.213.172]:33831 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754977AbbGCRwe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jul 2015 13:52:34 -0400
Received: by igcsj18 with SMTP id sj18so192131012igc.1
        for <git@vger.kernel.org>; Fri, 03 Jul 2015 10:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=wuUlFgw1JDZCuAUTslUoPDlzp19tR85iXOoz6MdnV+w=;
        b=nSiagoUnVp+Rlx61Vt29v8W2+NVHK7TlrswguvZFHEDPkSFhkf6nMKTpEkdxub/oQQ
         16QbRj3NvTSzgxtGMJ8SEKY0BeENCgWtg1gD4TRa3u0iLA1ULKuS/HQIGisC2A9iGeDs
         Y8XtHT5sWl09wRgQR2E/C6lJQfniRtCcsfRkvnr9jyjs8Gmmdhvfv6xY/PN95vZi2L5X
         +DbQxcC1N2uNxCgPxnZ0uqrIsoKeGHk8yBfNR/laja5IVDzt0AFALs3mn9ZZr5FOVGYO
         vS5tXNBLkuG4jPwXFqeGNU9m6U329p2o/eNLyk9oJdm2mskjI/WaKv+Skrwnxw75e3bZ
         Pzig==
X-Received: by 10.107.13.201 with SMTP id 192mr45456795ion.70.1435945954321;
        Fri, 03 Jul 2015 10:52:34 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:846f:c5d0:52c9:d18a])
        by mx.google.com with ESMTPSA id w4sm3864729igl.22.2015.07.03.10.52.33
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 03 Jul 2015 10:52:33 -0700 (PDT)
In-Reply-To: <20150702091133.GA13353@musxeris015.imu.intel.com> (Clemens
	Buchacher's message of "Thu, 2 Jul 2015 11:11:33 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273304>

Clemens Buchacher <clemens.buchacher@intel.com> writes:

> Since e481af06 (rebase: Handle cases where format-patch fails) we
> notice if format-patch fails and return immediately from
> git-rebase--am. We save the return value with ret=$?, but then we
> return $?, which is usually zero in this case.
>
> Fix this by returning $ret instead.

Sounds sensible.

>
> Cc: Andrew Wong <andrew.kw.w@gmail.com>
> Signed-off-by: Clemens Buchacher <clemens.buchacher@intel.com>
> Reviewed-by: Jorge Nunes <jorge.nunes@intel.com>

Where was this review made?  I may have missed a recent discussion,
and that is why I am asking, because Reviewed-by: lines that cannot
be validated by going back to the list archive does not add much
value.

Thanks.

> ---
>  git-rebase--am.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/git-rebase--am.sh b/git-rebase--am.sh
> index f923732..9ae898b 100644
> --- a/git-rebase--am.sh
> +++ b/git-rebase--am.sh
> @@ -78,7 +78,7 @@ else
>  
>  		As a result, git cannot rebase them.
>  		EOF
> -		return $?
> +		return $ret
>  	fi
>  
>  	git am $git_am_opt --rebasing --resolvemsg="$resolvemsg" \
