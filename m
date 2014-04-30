From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 18/32] read-cache: mark new entries for split index
Date: Wed, 30 Apr 2014 16:35:54 -0400
Message-ID: <CAPig+cStwY3Evy8036Qetmz4Oz0t948=d9C3neBMsi6PbJjOGQ@mail.gmail.com>
References: <1398682553-11634-1-git-send-email-pclouds@gmail.com>
	<1398682553-11634-19-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 30 22:36:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfbEV-00015g-T7
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 22:36:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759512AbaD3Ufz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 Apr 2014 16:35:55 -0400
Received: from mail-yk0-f177.google.com ([209.85.160.177]:55090 "EHLO
	mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759493AbaD3Ufz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Apr 2014 16:35:55 -0400
Received: by mail-yk0-f177.google.com with SMTP id 19so999131ykq.22
        for <git@vger.kernel.org>; Wed, 30 Apr 2014 13:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=ZXrzZ6l0mp6x0e/c4r+/+4sweJNQeM1nNxHom+WY2fM=;
        b=LrXYQUVzLavt2VPN8Pz7zAIguUxbz29IQfH5vt8jhaF/F3mSiy/Rz8/xu0wh+cs19z
         nCZsqy0eAxYNUWlYGeQNu9SimwxLEgCnlAsdWHOdYpZefSFI7PMfrQwu5WVGBAYcDmUS
         DYRSZ0GJ9ncBuf5HmOGl8p7jlVIqfKILzPtiawgNFS2uYJ42NSh+8tlQGDrJSxBRTEVr
         p5v9/i+W/ohaxvgePDNnnX+awVxxNPeb1LnTvRPOvhVIxT4cbIi5uJR4MnG7bOJlLutn
         g2rZlLYBaYNxcvVkPrnEroCg51NwbXmnvgx9knXE2eIo1g/BXsuPurCU6QR0yrsgyHXN
         9MQw==
X-Received: by 10.236.170.37 with SMTP id o25mr8948002yhl.145.1398890154497;
 Wed, 30 Apr 2014 13:35:54 -0700 (PDT)
Received: by 10.170.163.66 with HTTP; Wed, 30 Apr 2014 13:35:54 -0700 (PDT)
In-Reply-To: <1398682553-11634-19-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: DCzMGL49UISFcAD8g86wt4qaGFE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247778>

On Mon, Apr 28, 2014 at 6:55 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc =
Duy <pclouds@gmail.com> wrote:
> Make sure entry addition does not lead to unifying the index. We don'=
t
> need to explicitly keep track of new entries. If ce->index is zero,
> they're new. Otherwise it's unlikely that they are new, but we'll do =
a
> through check later at writing time.

s/through/thorough/

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  read-cache.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/read-cache.c b/read-cache.c
> index ff889ad..2f2e0c1 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -38,7 +38,8 @@ static struct cache_entry *refresh_cache_entry(stru=
ct cache_entry *ce,
>  #define CACHE_EXT_LINK 0x6c696e6b        /* "link" */
>
>  /* changes that can be kept in $GIT_DIR/index (basically all extensi=
ons) */
> -#define EXTMASK (RESOLVE_UNDO_CHANGED | CACHE_TREE_CHANGED)
> +#define EXTMASK (RESOLVE_UNDO_CHANGED | CACHE_TREE_CHANGED | \
> +                CE_ENTRY_ADDED)
>
>  struct index_state the_index;
>  static const char *alternate_index_output;
> --
> 1.9.1.346.ga2b5940
