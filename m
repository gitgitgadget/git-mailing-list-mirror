From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v3 24/34] mailinfo: move content/content_top to struct mailinfo
Date: Wed, 21 Oct 2015 13:36:01 -0700
Message-ID: <CAGZ79kbRLVaNNR=ZuMZNtJD2vorV5K1-wZ+R9CY5FY_zS3i95Q@mail.gmail.com>
References: <1444855557-2127-1-git-send-email-gitster@pobox.com>
	<1445239731-10677-1-git-send-email-gitster@pobox.com>
	<1445239731-10677-25-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 21 22:36:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zp07m-0002lZ-O7
	for gcvg-git-2@plane.gmane.org; Wed, 21 Oct 2015 22:36:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755941AbbJUUgG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2015 16:36:06 -0400
Received: from mail-yk0-f179.google.com ([209.85.160.179]:34400 "EHLO
	mail-yk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755578AbbJUUgD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2015 16:36:03 -0400
Received: by ykdr3 with SMTP id r3so62232453ykd.1
        for <git@vger.kernel.org>; Wed, 21 Oct 2015 13:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=bqy3j33jvh8AhYqalKYIx7qUBxRTPbxczfeeH8MJ0c8=;
        b=fv9lqk9q89RcB/2pbQiOyQ0xtQ3lrwrrvA2fdiGcqdKjL8VPkCjOGhGyTUms4e/PP+
         tfaIdTUM+TU5cQaHv9ZL+Hz9tL7pQf9DoMJKbEy9JkFN3VlbuQrKTGCpFYGCHI3bS1vH
         E2pfoxqaMYZT0r87/N7uug198dE0F++W2mgAo9u3rT94FDMM4Ga/W6HkfvtBrY5UTX/E
         vDGPHnNzxXk7ZB9aBcpNv85KKDFP58xT+7D9QpSRtHWp+0pqsMBBJ9rUw2PDVtqKB+cP
         oe0ju0w091GjkhImo7hHy0MUVvLojDYp35iW9C75Ne6AqYTPjUGrx5zNVVSDkVebMb9B
         YNWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=bqy3j33jvh8AhYqalKYIx7qUBxRTPbxczfeeH8MJ0c8=;
        b=CLddiNAGoxW1t0A45lTjshLbMC2djEP/jR6fTk4WcNGn/EdmqXwMtTu7kJJuOg0Vc+
         z32N91dIjI9VBVU3s26S532exZKNrxL8J7B7hUoEb6Gc4txdIvFDOVEIfjIabSol+O/O
         or/8xIKA6HyTCJNUsj2vaAj3K87b/P9TsBHV45H+GUARaUdJzqdqOqo7csdtdMJX+ZEt
         hXTOC2vf6IMEnhgf4pjb9h1HAcG14IeZL60t/mSS7b7WewjJhu81quIC+g0WLzmhH+3P
         bQJi36+0jt8dErTxSUEsCQUwZu/5T01abBAE6A0WXJW6OWRRt593de8OCGe/tW+zmqli
         yxdg==
X-Gm-Message-State: ALoCoQm/xR/ak+bH3kWa/DZ4JBASYcidDoWwBb2Tt+iIs3IZ8+02bS6XfdTYXuZvhjCie3YuwVz/
X-Received: by 10.13.199.133 with SMTP id j127mr8276497ywd.176.1445459761340;
 Wed, 21 Oct 2015 13:36:01 -0700 (PDT)
Received: by 10.37.29.213 with HTTP; Wed, 21 Oct 2015 13:36:01 -0700 (PDT)
In-Reply-To: <1445239731-10677-25-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280016>

On Mon, Oct 19, 2015 at 12:28 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  builtin/mailinfo.c | 45 ++++++++++++++++++++++++++-------------------
>  1 file changed, 26 insertions(+), 19 deletions(-)
>
> diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
> index 2c194da..ec65805 100644
> --- a/builtin/mailinfo.c
> +++ b/builtin/mailinfo.c
> @@ -7,6 +7,8 @@
>  #include "utf8.h"
>  #include "strbuf.h"
>
> +#define MAX_BOUNDARIES 5
> +
>  struct mailinfo {
>         FILE *input;
>         FILE *output;
> @@ -22,6 +24,8 @@ struct mailinfo {
>         int use_inbody_headers; /* defaults to 1 */
>         const char *metainfo_charset;
>
> +       struct strbuf *content[MAX_BOUNDARIES];
> +       struct strbuf **content_top;
>         struct strbuf charset;
>         char *message_id;
>         enum  {
> @@ -35,7 +39,6 @@ struct mailinfo {
>  };
>
>  #define MAX_HDR_PARSED 10
> -#define MAX_BOUNDARIES 5

Would it make sense to also move MAX_HDR_PARSED, such that we have all
defines in one place? The previous patch moved HDR related stuff around, so
either there or here?


>
>  static void cleanup_space(struct strbuf *sb);
>
> @@ -180,10 +183,6 @@ static int slurp_attr(const char *line, const char *name, struct strbuf *attr)
>         return 1;
>  }
>
> -static struct strbuf *content[MAX_BOUNDARIES];
> -
> -static struct strbuf **content_top = content;
> -
>  static void handle_content_type(struct mailinfo *mi, struct strbuf *line)
>  {
>         struct strbuf *boundary = xmalloc(sizeof(struct strbuf));
> @@ -191,11 +190,11 @@ static void handle_content_type(struct mailinfo *mi, struct strbuf *line)
>
>         if (slurp_attr(line->buf, "boundary=", boundary)) {
>                 strbuf_insert(boundary, 0, "--", 2);
> -               if (++content_top >= &content[MAX_BOUNDARIES]) {
> +               if (++mi->content_top >= &mi->content[MAX_BOUNDARIES]) {
>                         fprintf(stderr, "Too many boundaries to handle\n");
>                         exit(1);
>                 }
> -               *content_top = boundary;
> +               *(mi->content_top) = boundary;
>                 boundary = NULL;
>         }
>         slurp_attr(line->buf, "charset=", &mi->charset);
> @@ -223,10 +222,12 @@ static void handle_content_transfer_encoding(struct mailinfo *mi,
>                 mi->transfer_encoding = TE_DONTCARE;
>  }
>
> -static int is_multipart_boundary(const struct strbuf *line)
> +static int is_multipart_boundary(struct mailinfo *mi, const struct strbuf *line)
>  {
> -       return (((*content_top)->len <= line->len) &&
> -               !memcmp(line->buf, (*content_top)->buf, (*content_top)->len));
> +       struct strbuf *content_top = *(mi->content_top);
> +
> +       return ((content_top->len <= line->len) &&
> +               !memcmp(line->buf, content_top->buf, content_top->len));
>  }
>
>  static void cleanup_subject(struct mailinfo *mi, struct strbuf *subject)
> @@ -799,7 +800,7 @@ static void handle_filter(struct mailinfo *mi, struct strbuf *line)
>  static int find_boundary(struct mailinfo *mi, struct strbuf *line)
>  {
>         while (!strbuf_getline(line, mi->input, '\n')) {
> -               if (*content_top && is_multipart_boundary(line))
> +               if (*(mi->content_top) && is_multipart_boundary(mi, line))
>                         return 1;
>         }
>         return 0;
> @@ -811,18 +812,18 @@ static int handle_boundary(struct mailinfo *mi, struct strbuf *line)
>
>         strbuf_addch(&newline, '\n');
>  again:
> -       if (line->len >= (*content_top)->len + 2 &&
> -           !memcmp(line->buf + (*content_top)->len, "--", 2)) {
> +       if (line->len >= (*(mi->content_top))->len + 2 &&
> +           !memcmp(line->buf + (*(mi->content_top))->len, "--", 2)) {
>                 /* we hit an end boundary */
>                 /* pop the current boundary off the stack */
> -               strbuf_release(*content_top);
> -               free(*content_top);
> -               *content_top = NULL;
> +               strbuf_release(*(mi->content_top));
> +               free(*(mi->content_top));
> +               *(mi->content_top) = NULL;
>
>                 /* technically won't happen as is_multipart_boundary()
>                    will fail first.  But just in case..
>                  */
> -               if (--content_top < content) {
> +               if (--mi->content_top < mi->content) {
>                         fprintf(stderr, "Detected mismatched boundaries, "
>                                         "can't recover\n");
>                         exit(1);
> @@ -857,14 +858,14 @@ static void handle_body(struct mailinfo *mi, struct strbuf *line)
>         struct strbuf prev = STRBUF_INIT;
>
>         /* Skip up to the first boundary */
> -       if (*content_top) {
> +       if (*(mi->content_top)) {
>                 if (!find_boundary(mi, line))
>                         goto handle_body_out;
>         }
>
>         do {
>                 /* process any boundary lines */
> -               if (*content_top && is_multipart_boundary(line)) {
> +               if (*(mi->content_top) && is_multipart_boundary(mi, line)) {
>                         /* flush any leftover */
>                         if (prev.len) {
>                                 handle_filter(mi, &prev);
> @@ -1028,6 +1029,7 @@ static void setup_mailinfo(struct mailinfo *mi)
>         strbuf_init(&mi->charset, 0);
>         mi->header_stage = 1;
>         mi->use_inbody_headers = 1;
> +       mi->content_top = mi->content;
>         git_config(git_mailinfo_config, &mi);
>  }
>
> @@ -1046,6 +1048,11 @@ static void clear_mailinfo(struct mailinfo *mi)
>         for (i = 0; mi->s_hdr_data[i]; i++)
>                 strbuf_release(mi->s_hdr_data[i]);
>         free(mi->s_hdr_data);
> +
> +       while (mi->content < mi->content_top) {
> +               free(*(mi->content_top));
> +               mi->content_top--;
> +       }
>  }
>
>  static const char mailinfo_usage[] =
> --
> 2.6.2-383-g144b2e6
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
