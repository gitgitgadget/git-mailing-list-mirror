From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [PATCH] mergetool--lib: add support for araxis merge
Date: Sun, 3 May 2009 08:54:27 +0200
Message-ID: <200905030854.28059.markus.heidelberg@web.de>
References: <1241313481-17923-1-git-send-email-davvid@gmail.com>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, snowcoder@gmail.com, spearce@spearce.org,
	Johannes.Schindelin@gmx.de, git@vger.kernel.org,
	charles@hashpling.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 03 08:55:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M0Vb6-0006fH-0g
	for gcvg-git-2@gmane.org; Sun, 03 May 2009 08:54:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751573AbZECGyU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 May 2009 02:54:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751332AbZECGyU
	(ORCPT <rfc822;git-outgoing>); Sun, 3 May 2009 02:54:20 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:46870 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751143AbZECGyT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 May 2009 02:54:19 -0400
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate02.web.de (Postfix) with ESMTP id 202C0FE3D4BB;
	Sun,  3 May 2009 08:54:19 +0200 (CEST)
Received: from [89.59.70.225] (helo=.)
	by smtp05.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1M0Vac-0006Iy-00; Sun, 03 May 2009 08:54:19 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <1241313481-17923-1-git-send-email-davvid@gmail.com>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX19Ucv+hJ8p7RiTdyeT3B4CXblfgFA1k+a+Kz8uu
	V4eE1oFragyoHzT1TyM5mNiIqQiDNDmaAcfj5dTCCkSh24Cs09
	f+ZM+xItJKAeBbQvJDxA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118164>

David Aguilar, 03.05.2009:
> This patch is a result of the discussion on the msysgit list:
> 
> http://groups.google.com/group/msysgit/browse_thread/thread/fa353fa2240594d7
> 
> diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
> @@ -263,6 +266,23 @@ run_merge_tool () {
>  			status=1
>  		fi
>  		;;
> +	araxis)
> +		if merge_mode; then
> +			if $base_present; then

			touch "$BACKUP"

> +				"$merge_tool_path" -wait -merge -3 -a1 \
> +					"$BASE" "$LOCAL" "$REMOTE" "$MERGED" \
> +					>/dev/null 2>&1
> +			else
> +				"$merge_tool_path" -wait -2 \
> +					"$LOCAL" "$REMOTE" "$MERGED" \
> +					>/dev/null 2>&1
> +			fi
> +			check_unchanged
> +		else
> +			"$merge_tool_path" -wait -2 "$LOCAL" "$REMOTE" \
> +				>/dev/null 2>&1
> +		fi
> +		;;
>  	*)
>  		merge_tool_cmd="$(get_merge_tool_cmd "$1")"
>  		if test -z "$merge_tool_cmd"; then

Haven't you included the -title[1-3] command line switches because of
the strange "'title'" format? The user on the msysgit list had commented
it out in his patch, although he said it worked in this way. And looking
at git-gui/lib/mergetool.tcl, it is done in the same way.

Markus
