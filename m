From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH v2] smart-http: Don't change POST to GET when following redirect
Date: Fri, 24 Sep 2010 20:06:35 +0200
Message-ID: <m21v8jaudw.fsf@igel.home>
References: <AANLkTimwkXTs==+zT=Ue3jFNyRLL+7A1FFhoDuF-5zZ3@mail.gmail.com>
	<877hijvff7.fsf@catnip.gol.com>
	<20100918070315.GA30872@LK-Perkele-V2.elisa-laajakaista.fi>
	<m262y3cvpy.fsf@whitebox.home> <m21v8rcua1.fsf_-_@whitebox.home>
	<1285309223-4348-1-git-send-email-rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Miles Bader <miles@gnu.org>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 24 20:06:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzCfU-0004XT-KC
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 20:06:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757178Ab0IXSGj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 14:06:39 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:56265 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752221Ab0IXSGj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 14:06:39 -0400
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 4124D1C006E4;
	Fri, 24 Sep 2010 20:06:36 +0200 (CEST)
Received: from igel.home (ppp-93-104-152-223.dynamic.mnet-online.de [93.104.152.223])
	by mail.mnet-online.de (Postfix) with ESMTP id 13F3C1C00457;
	Fri, 24 Sep 2010 20:06:36 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id 995D4CA2A0; Fri, 24 Sep 2010 20:06:35 +0200 (CEST)
X-Yow: I've got an IDEA!!  Why don't I STARE at you so HARD,
 you forget your SOCIAL SECURITY NUMBER!!
In-Reply-To: <1285309223-4348-1-git-send-email-rctay89@gmail.com> (Tay Ray
	Chuan's message of "Fri, 24 Sep 2010 14:20:23 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157028>

Tay Ray Chuan <rctay89@gmail.com> writes:

> diff --git a/http.c b/http.c
> index 1320c50..25f8b45 100644
> --- a/http.c
> +++ b/http.c
> @@ -275,6 +275,9 @@ static CURL *get_curl_handle(void)
>  	}
>
>  	curl_easy_setopt(result, CURLOPT_FOLLOWLOCATION, 1);
> +#if LIBCURL_VERSION_NUM >= 0x071301
> +	curl_easy_setopt(result, CURLOPT_POSTREDIR, CURL_REDIR_POST_ALL);
> +#endif

Should this fall back to CURLOPT_POST301 on older versions?  (Those
won't handle 302 though, I think.)

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
