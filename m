From: Stanislav Kolotinskiy <stanislav@assembla.com>
Subject: Re: [PATCH v2] git-send-pack: Fix --all option when used with
 directory
Date: Thu, 24 Mar 2016 16:17:51 +0200
Message-ID: <56F3F70F.2070207@assembla.com>
References: <1458828858-3577-1-git-send-email-stanislav@assembla.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 24 15:18:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aj65H-0007Yg-SD
	for gcvg-git-2@plane.gmane.org; Thu, 24 Mar 2016 15:18:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756823AbcCXORz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2016 10:17:55 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:35833 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751851AbcCXORy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2016 10:17:54 -0400
Received: by mail-wm0-f48.google.com with SMTP id l68so238424677wml.0
        for <git@vger.kernel.org>; Thu, 24 Mar 2016 07:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=assembla-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=Sflwz3zFW6sbh/RO8JhJgAQ4Oae6+6d3/Ym7n4Tj6Uo=;
        b=2EeQifYQ5Z3mbostTJgG04LrjEDIq/yniVP4NUMLbf4pP/rfc0bDM45fjCsngBWbPw
         ZCBcIFAw5PZ0V8GzX4P3Jgsq4Pv7MuMCinxsEFpMncf3PNe8uMgckWKzqMUXahttb0Ay
         ua91PZ1LJXg2AWzvSljQ5CkgwMpG9pEaO+agpWnSYlZJ2NDtkkVLApeOqMLO9JMnfi8o
         FjW1VO7aQ2vebQ3ZosgmWmIKC6YO26fCD5usgwVaZtEst8b5tm19FO9aidfrY8saI3YC
         s985fOnjfYO/5FQRh14ZPp1diAk3+K4JQZ/IT+fW1uVGddXUvX2zKWxlU0UfWffsVXXV
         zIJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=Sflwz3zFW6sbh/RO8JhJgAQ4Oae6+6d3/Ym7n4Tj6Uo=;
        b=Mwsnnmf8f3K3zAC4uGjmGzEUGhOPjottu14jLKysxFJiBBBSU4lCEeqZ8vukbUIex0
         Eh2hNyFWzaa/VLnFiTnV8IXZbx+kd1fttz0Q3NeQkC+xULexGHijkxoXFGU+tJWUtGCX
         UFYotpjfSiCj5XCxV4FADRWRlY8DHOj090voo94pc5AnqSDcTMPlPxDkatfI7Xg8JcU0
         zU8sRGRkCou9Rdgju6mCAjzHaQg35X208OWqFehYxpFUczr826NRBrX1UXp72cGaK6NF
         1keIpRxlklagRnQmKf37xtEWwY7hscsLCNailI4FtBSbgTSAj1shDE2nj/BlfWk77ZoK
         ywbw==
X-Gm-Message-State: AD7BkJIzTEC3SgPoLoMFwvzh1o6Uu1y3+BNTSn4xWSXH9j/hY3T0ulDOYIV79bgv2uvWsQ==
X-Received: by 10.194.60.145 with SMTP id h17mr10698974wjr.47.1458829073062;
        Thu, 24 Mar 2016 07:17:53 -0700 (PDT)
Received: from [192.168.88.127] ([217.26.172.139])
        by smtp.googlemail.com with ESMTPSA id m6sm7591615wje.21.2016.03.24.07.17.51
        for <git@vger.kernel.org>
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 24 Mar 2016 07:17:52 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
In-Reply-To: <1458828858-3577-1-git-send-email-stanislav@assembla.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289748>

Please ignore this thread, I sent the email without making sure that I 
copied commit message. I'm sorry for that.

On 24/03/16 16:14, Stanislav Kolotinskiy wrote:
> ---
>   builtin/send-pack.c  |  2 +-
>   t/t5400-send-pack.sh | 12 ++++++++++++
>   2 files changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/send-pack.c b/builtin/send-pack.c
> index f6e5d64..19f0577 100644
> --- a/builtin/send-pack.c
> +++ b/builtin/send-pack.c
> @@ -225,7 +225,7 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
>   	 * --all and --mirror are incompatible; neither makes sense
>   	 * with any refspecs.
>   	 */
> -	if ((refspecs && (send_all || args.send_mirror)) ||
> +	if ((nr_refspecs > 0 && (send_all || args.send_mirror)) ||
>   	    (send_all && args.send_mirror))
>   		usage_with_options(send_pack_usage, options);
>   
> diff --git a/t/t5400-send-pack.sh b/t/t5400-send-pack.sh
> index 04cea97..305ca7a 100755
> --- a/t/t5400-send-pack.sh
> +++ b/t/t5400-send-pack.sh
> @@ -128,6 +128,18 @@ test_expect_success 'denyNonFastforwards trumps --force' '
>   	test "$victim_orig" = "$victim_head"
>   '
>   
> +test_expect_success 'send-pack --all sends all branches' '
> +	# make sure we have at least 2 branches with different
> +	# values, just to be thorough
> +	git branch other-branch HEAD^ &&
> +
> +	git init --bare all.git &&
> +	git send-pack --all all.git &&
> +	git for-each-ref refs/heads >expect &&
> +	git -C all.git for-each-ref refs/heads >actual &&
> +	test_cmp expect actual
> +'
> +
>   test_expect_success 'push --all excludes remote-tracking hierarchy' '
>   	mkdir parent &&
>   	(
