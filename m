From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v4 14/32] lock_file(): exit early if lockfile cannot be opened
Date: Thu, 11 Sep 2014 15:49:16 -0700
Message-ID: <CAL=YDWnoN_kJPQHDwTY_95bSU4gyMOX9Jf2qio8bSfT38d673g@mail.gmail.com>
References: <1409989846-22401-1-git-send-email-mhagger@alum.mit.edu>
	<1409989846-22401-15-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Sep 12 00:49:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XSDB8-0004qy-HG
	for gcvg-git-2@plane.gmane.org; Fri, 12 Sep 2014 00:49:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753523AbaIKWtT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2014 18:49:19 -0400
Received: from mail-vc0-f179.google.com ([209.85.220.179]:37126 "EHLO
	mail-vc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753347AbaIKWtR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2014 18:49:17 -0400
Received: by mail-vc0-f179.google.com with SMTP id im17so6468582vcb.24
        for <git@vger.kernel.org>; Thu, 11 Sep 2014 15:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=6slEnf/iMIdHojaYhDJXnDFOFCdRaIcPbLddR0Jh5cY=;
        b=fyHWoZRceU+3v8bPdnvD59xSOA5YJwT1XaWhjd1mH2kb4hSxoGxHiz2ISWZxtTip9O
         EBNA3eS2ugwau7o/0u2FMxPahNAaSEexobHRPHCLzVsR8FHStCOx3AzSt90qlP1nKa1A
         dn/h2BJ5tR78GniO1EejkPBdIXKOXf6AysDuoGZJvNwpfwqBRM1ZszkX1I1QcRdXLmlS
         pQspS5v1CmVD1zyRZHADE/QQX6mugbkxdSPDZ9GVeHjXXjxL8PgL2iByjDE2JXjL9l1V
         /XQZMOFOdlKZxmiLrzqfafZy3tj/F8w+7d49q7yYf+Iw3ngaiX52Amf6PcIBCciKvYr2
         DlrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=6slEnf/iMIdHojaYhDJXnDFOFCdRaIcPbLddR0Jh5cY=;
        b=bJCz0DDsDJtnb397Lg5tQ3UjPEAyyWE1HvH4u1PbnjYl2/19rQ4I+mLDs6vsY2qxYI
         qO50zVNmKJgdRDxw75fxI90A8PK2jws0imYT53uWlwEXjEUUKxf+dp5zxTMIAK9LPk9F
         MnbBEVJNYxcyMubA22jqZcy5nAc2MgfIfUp1AKVVVJVs1oBh8X2IPmY3Uqhx4jPX9xlj
         mTF1zqrpuGcUqicVheMAzniuNhZueojuddSDLA3EMsIGVAAZn2s6nwnIbYAbiOOvmE9i
         L54u86OCGlUBRTUPCJJQr0DyBl0M1PRUuuH1zLmBF35PbYPNSFv1USoqnC0SRLol3b+q
         vYDg==
X-Gm-Message-State: ALoCoQk+QflJNe0iUJ3wpPSCAMqs2OU7xcI00DbOKvxzrZPpVD1hZI/RhRRe8i+FK5lo7DLFafsG
X-Received: by 10.220.161.136 with SMTP id r8mr2910405vcx.21.1410475756838;
 Thu, 11 Sep 2014 15:49:16 -0700 (PDT)
Received: by 10.52.231.232 with HTTP; Thu, 11 Sep 2014 15:49:16 -0700 (PDT)
In-Reply-To: <1409989846-22401-15-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256887>

Reviewed-by: Ronnie Sahlberg <sahlberg@google.com>


On Sat, Sep 6, 2014 at 12:50 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> This is a bit easier to read than the old version, which nested part
> of the non-error code in an "if" block.
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  lockfile.c | 23 +++++++++++------------
>  1 file changed, 11 insertions(+), 12 deletions(-)
>
> diff --git a/lockfile.c b/lockfile.c
> index bfea333..71786c9 100644
> --- a/lockfile.c
> +++ b/lockfile.c
> @@ -207,19 +207,18 @@ static int lock_file(struct lock_file *lk, const char *path, int flags)
>                 resolve_symlink(lk->filename, max_path_len);
>         strcat(lk->filename, LOCK_SUFFIX);
>         lk->fd = open(lk->filename, O_RDWR | O_CREAT | O_EXCL, 0666);
> -       if (0 <= lk->fd) {
> -               lk->owner = getpid();
> -               if (adjust_shared_perm(lk->filename)) {
> -                       int save_errno = errno;
> -                       error("cannot fix permission bits on %s",
> -                             lk->filename);
> -                       rollback_lock_file(lk);
> -                       errno = save_errno;
> -                       return -1;
> -               }
> -       }
> -       else
> +       if (lk->fd < 0) {
>                 lk->filename[0] = 0;
> +               return -1;
> +       }
> +       lk->owner = getpid();
> +       if (adjust_shared_perm(lk->filename)) {
> +               int save_errno = errno;
> +               error("cannot fix permission bits on %s", lk->filename);
> +               rollback_lock_file(lk);
> +               errno = save_errno;
> +               return -1;
> +       }
>         return lk->fd;
>  }
>
> --
> 2.1.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
