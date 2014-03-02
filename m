From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 1/2] Introduce strbuf_write_or_die()
Date: Sun, 2 Mar 2014 15:05:39 -0500
Message-ID: <CAPig+cQfbxX0oH_tfaQt5PT0DP29hRZ8seZdJ-ssLDQbH=iJGQ@mail.gmail.com>
References: <CAPig+cR0gTeB1oUUPQ=W_wWGPMDaY4gkG7+531HT-ktnwn5L-Q@mail.gmail.com>
	<1393745664-21077-1-git-send-email-faiz.off93@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Johannes Sixt <j6t@kdbg.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Faiz Kothari <faiz.off93@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 02 21:06:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKCeE-0001iZ-TT
	for gcvg-git-2@plane.gmane.org; Sun, 02 Mar 2014 21:06:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751906AbaCBUFl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2014 15:05:41 -0500
Received: from mail-yh0-f48.google.com ([209.85.213.48]:47727 "EHLO
	mail-yh0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751732AbaCBUFk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2014 15:05:40 -0500
Received: by mail-yh0-f48.google.com with SMTP id z6so2788843yhz.7
        for <git@vger.kernel.org>; Sun, 02 Mar 2014 12:05:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=JBgBd9nZ5UNTHqRIkfohJsO5a4QSNwfef3YEH5++vxU=;
        b=B5Wi5aQYas75xCswKQ1zIxqdjS+bkLhrVyDxBJ4KLML9/2qbHmH5IWTXU1Vz/8VYhb
         M1bOLf04hU49qqrtlR3LkwQoiLmK3V6EhsbIdRpTqg5iJRlNykmJ/ob8tXCZmSyEv9DX
         U9c6om/a1d55pt7puaHjnWqHYt5rPPGsyrlldRjCFm6BtcuHxCZANxthHAsX1lPn/xth
         fTjweg8A0npBB1MMviQ0K8jSa6X97/hbRU2O5cyUhn9rrYzS+n624XPi7bLy2b37EFie
         4/uDanFgEeSjs0QZkRp+SIOk5pXe8lVCP3lnSiPtfwc33+OqLAagh1Dltqyn0llMrbHf
         DkIw==
X-Received: by 10.236.17.34 with SMTP id i22mr93748yhi.110.1393790739818; Sun,
 02 Mar 2014 12:05:39 -0800 (PST)
Received: by 10.170.180.195 with HTTP; Sun, 2 Mar 2014 12:05:39 -0800 (PST)
In-Reply-To: <1393745664-21077-1-git-send-email-faiz.off93@gmail.com>
X-Google-Sender-Auth: bBcLvObvwfhzLPoQUb0kCyeWmnI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243160>

On Sun, Mar 2, 2014 at 2:34 AM, Faiz Kothari <faiz.off93@gmail.com> wrote:
> Signed-off-by: Faiz Kothari <faiz.off93@gmail.com>

Place your sign off below the commit message.

> Introduced a new function strbuf.c:strbuf_write_or_die()
> to the strbuf family of functions. Now use this API instead
> of write_or_die.c:write_or_die()

You want to explain what this patch is doing in imperative tone. Use
"Introduce" rather than "Introduced". The first sentence correctly
states what the patch is doing, however, the second sentence explains
what the next patch is doing, so it doesn't belong here. So, your
commit message for this patch might become:

    Subject: strbuf: introduce strbuf_write_or_die()

    Add strbuf convenience wrapper around lower-level write_or_die().

> ---
> Hi,
> Thanks for the suggestions and feedbacks.
> As Johannes Sixt  pointed out, the function is now defined
> in strbuf.c and prototype added to strbuf.h
> Also, replaced if(!sbuf) with assert(sbuf) and split the patch into two
> as pointed out by Eric Sunshine.

Good explanation of what changed since the last attempt.

> As far as justification is concerned, I am not able to come up with
> a satisfactory justification. Apart from, that it makes life of the
> programmer a little easier and if we add a few more functions
> to thestrbuf API, we can make strbuf completely opaque. I am open
> to views and since I haven't used this API extensively, I cannot
> comment for what is missing and what is required. But I am going through it.
> Also, once this patch is OK, I'll add documentation for the API.

It's a good idea to add documentation when you add the function
itself, otherwise reviewers will have to wait yet another round to
review that addition. In this case, the documentation will likely be
one line, so it shouldn't be a particular burden to write it.

> Thanks again for the feedback.
>
>  strbuf.c |    6 ++++++
>  strbuf.h |    1 +
>  2 files changed, 7 insertions(+)
>
> diff --git a/strbuf.c b/strbuf.c
> index 83caf4a..337a70c 100644
> --- a/strbuf.c
> +++ b/strbuf.c
> @@ -477,6 +477,12 @@ int strbuf_read_file(struct strbuf *sb, const char *path, size_t hint)
>         return len;
>  }
>
> +void strbuf_write_or_die(const struct strbuf *sb, int fd)
> +{
> +       assert(sb);
> +       write_or_die(fd, sb->buf, sb->len);
> +}

Nice. Much better than previous versions of the patch.

>  void strbuf_add_lines(struct strbuf *out, const char *prefix,
>                       const char *buf, size_t size)
>  {
> diff --git a/strbuf.h b/strbuf.h
> index 73e80ce..6aadb6d 100644
> --- a/strbuf.h
> +++ b/strbuf.h
> @@ -156,6 +156,7 @@ extern size_t strbuf_fread(struct strbuf *, size_t, FILE *);
>  /* XXX: if read fails, any partial read is undone */
>  extern ssize_t strbuf_read(struct strbuf *, int fd, size_t hint);
>  extern int strbuf_read_file(struct strbuf *sb, const char *path, size_t hint);
> +extern void strbuf_write_or_die(const struct strbuf *sb, int fd);
>  extern int strbuf_readlink(struct strbuf *sb, const char *path, size_t hint);
>
>  extern int strbuf_getwholeline(struct strbuf *, FILE *, int);
> --
> 1.7.9.5
