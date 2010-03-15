From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH 3/4] convert: Inhibit contraction of foreign $Id$ during 
	stats.
Date: Mon, 15 Mar 2010 16:42:48 +0100
Message-ID: <36ca99e91003150842q6a39a48dl2e88254fd636556d@mail.gmail.com>
References: <be7e603837d8f55461c4d654fb07bd61c97b70e6.1268664693.git.grubba@grubba.org>
	 <cover.1268664693.git.grubba@grubba.org>
	 <cff48594f97960444a3cd642dafd7fd4905e6891.1268664693.git.grubba@grubba.org>
	 <baa3d958d4885348d3d5a4c30305fce0f026d85c.1268664693.git.grubba@grubba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?Q?Henrik_Grubbstr=C3=B6m_=28Grubba=29?= <grubba@grubba.org>
X-From: git-owner@vger.kernel.org Mon Mar 15 16:43:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrCRU-0000GP-48
	for gcvg-git-2@lo.gmane.org; Mon, 15 Mar 2010 16:42:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936502Ab0COPmv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Mar 2010 11:42:51 -0400
Received: from mail-bw0-f209.google.com ([209.85.218.209]:34441 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936194Ab0COPmu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Mar 2010 11:42:50 -0400
Received: by bwz1 with SMTP id 1so3020447bwz.21
        for <git@vger.kernel.org>; Mon, 15 Mar 2010 08:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=P2VoMwPaPSN6mApB5klbVMGn5buIx9j85JrV++1JHtY=;
        b=OuMy5rmIQT+Zc51DRgSeO6M5WygYQch8jhO3IJwNn7cEYVMNGXGutXtqxQJY8PUpKr
         T0Bw2agTGo7+29dfFb56GMVnKypvMqAvfb1+WXeGd4U9CAcMXCnea5IbQbYEEL0loLuR
         hGcgZFeUujxLYZrAqR37r8tnL5hUsvVUvh2QQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=hKcUgilEIldCojNU6Fc7shYhO6iRtj1nOKp3JhKQS29eXQTiVQgmXQ5SvirF6BD4Hk
         F0YgomTRCZJw1yePpwLGFs2araHd8H8RHeKS6w9vbq8TDI+oH+lAVHSUPTebmZll1nux
         WSZ+eqVdkPqvqDvUUp7hFO2Y9+fdyxzfi4AFI=
Received: by 10.204.33.215 with SMTP id i23mr6339222bkd.86.1268667769091; Mon, 
	15 Mar 2010 08:42:49 -0700 (PDT)
In-Reply-To: <baa3d958d4885348d3d5a4c30305fce0f026d85c.1268664693.git.grubba@grubba.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142217>

2010/3/15 Henrik Grubbstr=C3=B6m (Grubba) <grubba@grubba.org>:
> diff --git a/builtin/apply.c b/builtin/apply.c
> index 3af4ae0..25adef8 100644
> --- a/builtin/apply.c
> +++ b/builtin/apply.c
> @@ -1759,7 +1759,7 @@ static int read_old_data(struct stat *st, const=
 char *path, struct strbuf *buf)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0case S_IFREG:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (strbuf_rea=
d_file(buf, path, st->st_size) !=3D st->st_size)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0return error("unable to open or read %s", path);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 convert_to_git(pat=
h, buf->buf, buf->len, buf, 0);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 convert_to_git(pat=
h, buf->buf, buf->len, buf, 0, 0);

So this new 0 should be ...

> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0default:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;
> diff --git a/builtin/blame.c b/builtin/blame.c
> index fc15863..16f7f00 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -2050,7 +2050,7 @@ static struct commit *fake_working_tree_commit(=
const char *path, const char *con
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (strbuf_rea=
d(&buf, 0, 0) < 0)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0die_errno("failed to read from stdin");
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> - =C2=A0 =C2=A0 =C2=A0 convert_to_git(path, buf.buf, buf.len, &buf, 0=
);
> + =C2=A0 =C2=A0 =C2=A0 convert_to_git(path, buf.buf, buf.len, &buf, 0=
, 0);

=2E.. (and this one too) ...

> =C2=A0 =C2=A0 =C2=A0 =C2=A0origin->file.ptr =3D buf.buf;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0origin->file.size =3D buf.len;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0pretend_sha1_file(buf.buf, buf.len, OBJ_BL=
OB, origin->blob_sha1);
> diff --git a/cache.h b/cache.h
> index 89f6a40..b62c462 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -556,6 +556,11 @@ enum safe_crlf {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0SAFE_CRLF_WARN =3D 2,
> =C2=A0};
>
> +enum ident_mode {
> + =C2=A0 =C2=A0 =C2=A0 IDENT_MODE_FALSE =3D 0,

=2E.. this?

> + =C2=A0 =C2=A0 =C2=A0 IDENT_MODE_KEEP_FOREIGN =3D 1,
> +};
> +
> =C2=A0extern enum safe_crlf safe_crlf;
>
> =C2=A0enum branch_track {
