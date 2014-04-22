From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH] mergetools: add vimdiff3 mode
Date: Mon, 21 Apr 2014 22:01:43 -0700
Message-ID: <20140422050142.GB60610@gmail.com>
References: <1398039860-31420-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 22 07:01:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcSq9-0006Hw-HT
	for gcvg-git-2@plane.gmane.org; Tue, 22 Apr 2014 07:01:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751244AbaDVFBu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2014 01:01:50 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:35230 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750756AbaDVFBt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2014 01:01:49 -0400
Received: by mail-pd0-f180.google.com with SMTP id v10so4412643pde.25
        for <git@vger.kernel.org>; Mon, 21 Apr 2014 22:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=SaUr+sIZ2ZGMyvD+O2YsR1uzx4nWijEqwEt2wMvPmRw=;
        b=bLVhJrXYjQAOXGs/gvxIMDyctCmVoUQxXryF9MBC63MKj/PPURjxovz5QRf1XDal01
         mwXzbrr/w6d8NmCvFeuW7RVeE/5pzKv4Ii0UV/mxmpUiCXkehRAdItpdIUMiGnPSTR6x
         gHmMzBC9mbSazQd6cVwz39sawhGhdscl+w4pqjcTpSuJMBOmmj322NBKxKzm8Q5xRoS0
         nxsJjeBRWagJTkG2QAOSdi23vl8A966W8KXHyjH1LUc7ga6JOd3psFA7Ug6JYDRWZ4h+
         aol5YMtVhlGm6VaXdo0VmqUz+XL914EoACqYyX7kkJrqfeXIJK6bXZgM5qb6CrkhJaaS
         Zk9A==
X-Received: by 10.68.190.163 with SMTP id gr3mr41853291pbc.103.1398142908837;
        Mon, 21 Apr 2014 22:01:48 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id ov4sm77264276pbc.46.2014.04.21.22.01.46
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 21 Apr 2014 22:01:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1398039860-31420-1-git-send-email-felipe.contreras@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246692>

On Sun, Apr 20, 2014 at 07:24:20PM -0500, Felipe Contreras wrote:
> It's similar to the default, except that the other windows are hidden.
> This ensures that removed/added colors are still visible on the main
> merge window, but the other windows not visible.
> 
> Specially useful with merge.conflictstyle=diff3.

This is a nice addition, thanks.

FWIW,
Acked-by: David Aguilar <davvid@gmail.com>

> 
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
> 
> How a conflict looks:
> http://felipec.org/vimdiff3-conflict.png
> 
> How it looks resolved:
> http://felipec.org/vimdiff3-resolved.png
> 
>  mergetools/gvimdiff3 |  1 +
>  mergetools/vimdiff   | 14 ++++++++++++--
>  mergetools/vimdiff3  |  1 +
>  3 files changed, 14 insertions(+), 2 deletions(-)
>  create mode 100644 mergetools/gvimdiff3
>  create mode 100644 mergetools/vimdiff3
> 
> diff --git a/mergetools/gvimdiff3 b/mergetools/gvimdiff3
> new file mode 100644
> index 0000000..04a5bb0
> --- /dev/null
> +++ b/mergetools/gvimdiff3
> @@ -0,0 +1 @@
> +. "$MERGE_TOOLS_DIR/vimdiff"
> diff --git a/mergetools/vimdiff b/mergetools/vimdiff
> index 39d0327..1ddfbfc 100644
> --- a/mergetools/vimdiff
> +++ b/mergetools/vimdiff
> @@ -20,16 +20,26 @@ merge_cmd () {
>  		"$merge_tool_path" -f -d -c 'wincmd l' \
>  			"$LOCAL" "$MERGED" "$REMOTE"
>  		;;
> +	gvimdiff3|vimdiff3)
> +		if $base_present
> +		then
> +			"$merge_tool_path" -f -d -c 'hid | hid | hid' \
> +				"$LOCAL" "$REMOTE" "$BASE" "$MERGED"
> +		else
> +			"$merge_tool_path" -f -d -c 'hid | hid' \
> +				"$LOCAL" "$REMOTE" "$MERGED"
> +		fi
> +		;;
>  	esac
>  	check_unchanged
>  }
>  
>  translate_merge_tool_path() {
>  	case "$1" in
> -	gvimdiff|gvimdiff2)
> +	gvimdiff|gvimdiff2|gvimdiff3)
>  		echo gvim
>  		;;
> -	vimdiff|vimdiff2)
> +	vimdiff|vimdiff2|vimdiff3)
>  		echo vim
>  		;;
>  	esac
> diff --git a/mergetools/vimdiff3 b/mergetools/vimdiff3
> new file mode 100644
> index 0000000..04a5bb0
> --- /dev/null
> +++ b/mergetools/vimdiff3
> @@ -0,0 +1 @@
> +. "$MERGE_TOOLS_DIR/vimdiff"
> -- 
> 1.9.2+fc1.1.g5c924db
-- 
David
