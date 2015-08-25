From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/8] grep: make it clear i-t-a entries are ignored
Date: Tue, 25 Aug 2015 10:37:31 -0700
Message-ID: <xmqq37z71d7o.fsf@gitster.dls.corp.google.com>
References: <xmqqy4j80wdb.fsf@gitster.dls.corp.google.com>
	<1440205700-19749-1-git-send-email-pclouds@gmail.com>
	<1440205700-19749-7-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, phiggins@google.com, snoksrud@gmail.com
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 25 19:37:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUIAD-0006G7-F8
	for gcvg-git-2@plane.gmane.org; Tue, 25 Aug 2015 19:37:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755999AbbHYRhd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Aug 2015 13:37:33 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:36771 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755756AbbHYRhc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Aug 2015 13:37:32 -0400
Received: by pacgr6 with SMTP id gr6so194338pac.3
        for <git@vger.kernel.org>; Tue, 25 Aug 2015 10:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version:content-type:content-transfer-encoding;
        bh=KMuYYBnlZxGzmfEtfwRB9IvDYkXaixgkIoIB+cK5u2E=;
        b=STo4BbRxN5KbViHCBsF9Ly829dEY0hIuPyycIJ0vvw9B0PINfmQp/8RgDBYzVwOXCy
         ehRv6xiXKtxEkRzj+Zft1tOHPpTkImxhln4zXmLbpw0jfwdSndgALa1D7oxOe+fpMUl2
         uSJysoKpTOSaqafnFOS+9k1m6yEyLCiFNJ8emdcZaCtDzzo9qUanHD2sE5f4O/aLSRc8
         hAA/hjakwR12ll99vMYHFB26SglRUMO5r/Dhv/hRqXiOHx6ry06XW4ekS8j5RePsfkf3
         LjpbMestlfGKRcMrhaT2gp8W+KMsQvAFdJIpwUTwGAgsTRBl7wyaIc1uA2/Hj4cj2aHy
         Uo8w==
X-Received: by 10.66.148.6 with SMTP id to6mr58437675pab.132.1440524251977;
        Tue, 25 Aug 2015 10:37:31 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:cdc0:fd6d:4069:6223])
        by smtp.gmail.com with ESMTPSA id qf6sm6634040pdb.94.2015.08.25.10.37.31
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Tue, 25 Aug 2015 10:37:31 -0700 (PDT)
In-Reply-To: <1440205700-19749-7-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sat, 22
 Aug 2015 08:08:09 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276548>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> The expression "!S_ISREG(ce)" covers i-t-a entries as well because
> ce->ce_mode would be zero then. I could make a comment saying that, b=
ut
> it's probably better just to comment with code, in case i-t-a entry
> content changes in future.

OK.  Thanks.

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  builtin/grep.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/grep.c b/builtin/grep.c
> index d04f440..f508179 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -375,7 +375,7 @@ static int grep_cache(struct grep_opt *opt, const=
 struct pathspec *pathspec, int
> =20
>  	for (nr =3D 0; nr < active_nr; nr++) {
>  		const struct cache_entry *ce =3D active_cache[nr];
> -		if (!S_ISREG(ce->ce_mode))
> +		if (!S_ISREG(ce->ce_mode) || ce_intent_to_add(ce))
>  			continue;
>  		if (!ce_path_match(ce, pathspec, NULL))
>  			continue;
