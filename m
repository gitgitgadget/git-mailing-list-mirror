From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 14/25] setup.c: convert is_git_directory() to use strbuf
Date: Thu, 20 Feb 2014 22:38:00 -0500
Message-ID: <CAPig+cQ=fujZ=M8TgRcemR5+0kSYNLGHbJDAksiUq8GJCkDPFA@mail.gmail.com>
References: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
	<1392730814-19656-15-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 21 04:38:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WGgwF-0007uw-EL
	for gcvg-git-2@plane.gmane.org; Fri, 21 Feb 2014 04:38:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753478AbaBUDiG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Feb 2014 22:38:06 -0500
Received: from mail-yh0-f48.google.com ([209.85.213.48]:42600 "EHLO
	mail-yh0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751886AbaBUDiE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Feb 2014 22:38:04 -0500
Received: by mail-yh0-f48.google.com with SMTP id f10so1776653yha.35
        for <git@vger.kernel.org>; Thu, 20 Feb 2014 19:38:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=rN+xXRnRi4w0GEPmwn1A7t5MwxJLkjn7ygpS66FZS00=;
        b=IROXXwByzNvZ+xeJglpVRqKyvKP9/LJO9Ssa1WN29Xs5PcOsqdU95C/h6e6FGNZjqc
         AnW9cin44zs3EEYLkKJzd4jkg1lCwNooy7Rs+BCacAQhn30mwKaExugdKkjHqlMGjpKz
         AJQh1OEw1QJl0/c6/U6XoM1l/v2ecTIFiAdqErARhOIfgjAVt9A5kQiqoDSE/P7JPq5l
         W1kdl0VuNx2prM87YBXAca0YMShfpCxZrftB7ZzesuEqtI8Qaj3FeoxSOjOYaQR86Wm3
         jjH+FRDXpf/T2x0H9LPR6/bhc9pyKcJju+L9endnObW8Q1GU8EYNpiCmeqKQjbCwRRsL
         gaLA==
X-Received: by 10.236.120.17 with SMTP id o17mr7790600yhh.121.1392953880225;
 Thu, 20 Feb 2014 19:38:00 -0800 (PST)
Received: by 10.170.180.195 with HTTP; Thu, 20 Feb 2014 19:38:00 -0800 (PST)
In-Reply-To: <1392730814-19656-15-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: 5oJ9Xo4H6oD4RRvzwriUdc_p8FA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242456>

On Tue, Feb 18, 2014 at 8:40 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc =
Duy <pclouds@gmail.com> wrote:
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
> index 73e80ce..aec9fdb 100644
> --- a/strbuf.h
> +++ b/strbuf.h
> @@ -116,6 +116,10 @@ extern void strbuf_add(struct strbuf *, const vo=
id *, size_t);
>  static inline void strbuf_addstr(struct strbuf *sb, const char *s) {
>         strbuf_add(sb, s, strlen(s));
>  }
> +static inline void strbuf_addstr_at(struct strbuf *sb, size_t len, c=
onst char *s) {
> +       strbuf_setlen(sb, len);
> +       strbuf_add(sb, s, strlen(s));
> +}

Update Documentation/technical/api-strbuf.txt?

>  static inline void strbuf_addbuf(struct strbuf *sb, const struct str=
buf *sb2) {
>         strbuf_grow(sb, sb2->len);
>         strbuf_add(sb, sb2->buf, sb2->len);
> --
> 1.8.5.2.240.g8478abd
