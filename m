From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/3] Convert resolve_ref+xstrdup to new resolve_refdup
 function
Date: Sat, 10 Dec 2011 07:15:03 -0600
Message-ID: <20111210131503.GI22035@elie.hsd1.il.comcast.net>
References: <1323521631-24320-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Tony Wang <wwwjfy@gmail.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 10 14:15:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZMlm-0000M7-Te
	for gcvg-git-2@lo.gmane.org; Sat, 10 Dec 2011 14:15:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751132Ab1LJNPJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 10 Dec 2011 08:15:09 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:44209 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750940Ab1LJNPI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Dec 2011 08:15:08 -0500
Received: by iaeh11 with SMTP id h11so216581iae.19
        for <git@vger.kernel.org>; Sat, 10 Dec 2011 05:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=EWCwRXkQzSHIpHvGu3Hxqb+oILXcaWfu8LcN8k8/Gh8=;
        b=jcALWY5P7grFP7YgD0EQC1pG6QyPR7v6FS1Qm4ayMm2McB6WUo1N2wkKuTS3twiOFb
         k/nakfj0P+FVN1jFWeTS3QzfivRTRFE7b7CFUpHofeVasymaQZU9ylkOevDps0K+4TG5
         tAYUTpEeumrTFmWsU105nOfLrXvO0tB6lH+1A=
Received: by 10.50.192.197 with SMTP id hi5mr7519262igc.16.1323522908307;
        Sat, 10 Dec 2011 05:15:08 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id h9sm23352114ibh.11.2011.12.10.05.15.06
        (version=SSLv3 cipher=OTHER);
        Sat, 10 Dec 2011 05:15:07 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1323521631-24320-1-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186778>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> [Subject: Convert resolve_ref+xstrdup to new resolve_refdup function]

I like it.

> --- a/builtin/revert.c
> +++ b/builtin/revert.c
> @@ -901,7 +901,7 @@ static int rollback_single_pick(void)
>  	if (!file_exists(git_path("CHERRY_PICK_HEAD")) &&
>  	    !file_exists(git_path("REVERT_HEAD")))
>  		return error(_("no cherry-pick or revert in progress"));
> -	if (!resolve_ref("HEAD", head_sha1, 0, NULL))
> +	if (read_ref_full("HEAD", head_sha1, 0, NULL))
>  		return error(_("cannot resolve HEAD"));
>  	if (is_null_sha1(head_sha1))
>  		return error(_("cannot abort from a branch yet to be born"));

Unrelated change that snuck in, I assume?

The rest of the patch looks very sensible and no-op-like. :)
