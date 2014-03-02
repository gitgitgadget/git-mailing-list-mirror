From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 2/2] use strbuf_write_or_die()
Date: Sun, 2 Mar 2014 17:04:12 -0500
Message-ID: <CAPig+cRVaNa=Gi5gck0RDKHUkjLtQgMO8KaQiUZ=oL0pimw0bQ@mail.gmail.com>
References: <CAPig+cR0gTeB1oUUPQ=W_wWGPMDaY4gkG7+531HT-ktnwn5L-Q@mail.gmail.com>
	<1393745664-21077-1-git-send-email-faiz.off93@gmail.com>
	<1393745664-21077-2-git-send-email-faiz.off93@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Johannes Sixt <j6t@kdbg.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Faiz Kothari <faiz.off93@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 02 23:04:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKEUf-0005DO-3s
	for gcvg-git-2@plane.gmane.org; Sun, 02 Mar 2014 23:04:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752746AbaCBWEO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2014 17:04:14 -0500
Received: from mail-yh0-f49.google.com ([209.85.213.49]:61351 "EHLO
	mail-yh0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752411AbaCBWEM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2014 17:04:12 -0500
Received: by mail-yh0-f49.google.com with SMTP id z6so2871690yhz.22
        for <git@vger.kernel.org>; Sun, 02 Mar 2014 14:04:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=Uene9RVUf8QJE072QPTYCy8J7puWpM4Flkt+RkVfhsc=;
        b=HV17PmQYjnaNozMis3+SCUCweA96g2bRj4CMZVuCBXDN2Q0TH3hz5dTL2wEKj1HYV0
         cntjaecUJ5TPmpQdrHx7ur1SeYu1759LKmssxLQ4XfxZdxaJnbUtQokGyQB7nhTrVXyo
         3MzccEiC7Nh+g5+AUwmmXZvdx1wa1mHyxaQ9OJjI//hf9XPxgcJSrRNZkWF8lb2gia8E
         mb5s8Yp86JSALCUkDLIkiCiWRD3YfBvRjnIBEfWVqCteLjdIZwYNONYH0KRTRFeVKyfZ
         IVGbif2gWYtRkOr8hMBym9GdDHkeAIEtGpONFYzNUwfM82y5Oet1/ePfG4yvx49wZhNw
         SI8g==
X-Received: by 10.236.134.199 with SMTP id s47mr18208396yhi.32.1393797852085;
 Sun, 02 Mar 2014 14:04:12 -0800 (PST)
Received: by 10.170.180.195 with HTTP; Sun, 2 Mar 2014 14:04:12 -0800 (PST)
In-Reply-To: <1393745664-21077-2-git-send-email-faiz.off93@gmail.com>
X-Google-Sender-Auth: r96fCd6JGIIM3Su_t9ro100AZLM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243161>

On Sun, Mar 2, 2014 at 2:34 AM, Faiz Kothari <faiz.off93@gmail.com> wrote:
> Signed-off-by: Faiz Kothari <faiz.off93@gmail.com>

Sign off below commit message.

> Used strbuf.c:strbuf_write_or_die() instead of
> write_or_die.c:write_or_die() at relevant places.

Imperative: "Use strbuf..."

Otherwise, the patch looks okay.

> ---
>  builtin/cat-file.c     |    2 +-
>  builtin/notes.c        |    6 +++---
>  builtin/receive-pack.c |    2 +-
>  builtin/send-pack.c    |    2 +-
>  builtin/stripspace.c   |    2 +-
>  builtin/tag.c          |    2 +-
>  bundle.c               |    2 +-
>  credential-store.c     |    2 +-
>  fetch-pack.c           |    2 +-
>  http-backend.c         |    2 +-
>  remote-curl.c          |    6 +++---
>  11 files changed, 15 insertions(+), 15 deletions(-)
>
> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> index d5a93e0..d07a0be 100644
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -255,7 +255,7 @@ static int batch_one_object(const char *obj_name, struct batch_options *opt,
>
>         strbuf_expand(&buf, opt->format, expand_format, data);
>         strbuf_addch(&buf, '\n');
> -       write_or_die(1, buf.buf, buf.len);
> +       strbuf_write_or_die(&buf, 1);
>         strbuf_release(&buf);
>
>         if (opt->print_contents) {
> diff --git a/builtin/notes.c b/builtin/notes.c
> index 2b24d05..a208d56 100644
> --- a/builtin/notes.c
> +++ b/builtin/notes.c
> @@ -140,7 +140,7 @@ static void write_commented_object(int fd, const unsigned char *object)
>         if (strbuf_read(&buf, show.out, 0) < 0)
>                 die_errno(_("could not read 'show' output"));
>         strbuf_add_commented_lines(&cbuf, buf.buf, buf.len);
> -       write_or_die(fd, cbuf.buf, cbuf.len);
> +       strbuf_write_or_die(&cbuf, fd);
>
>         strbuf_release(&cbuf);
>         strbuf_release(&buf);
> @@ -167,14 +167,14 @@ static void create_note(const unsigned char *object, struct msg_arg *msg,
>                         die_errno(_("could not create file '%s'"), path);
>
>                 if (msg->given)
> -                       write_or_die(fd, msg->buf.buf, msg->buf.len);
> +                       strbuf_write_or_die(&(msg->buf), fd);
>                 else if (prev && !append_only)
>                         write_note_data(fd, prev);
>
>                 strbuf_addch(&buf, '\n');
>                 strbuf_add_commented_lines(&buf, note_template, strlen(note_template));
>                 strbuf_addch(&buf, '\n');
> -               write_or_die(fd, buf.buf, buf.len);
> +               strbuf_write_or_die(&buf, fd);
>
>                 write_commented_object(fd, object);
>
> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index 85bba35..d590993 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -1114,7 +1114,7 @@ static void report(struct command *commands, const char *unpack_status)
>         if (use_sideband)
>                 send_sideband(1, 1, buf.buf, buf.len, use_sideband);
>         else
> -               write_or_die(1, buf.buf, buf.len);
> +               strbuf_write_or_die(&buf, 1);
>         strbuf_release(&buf);
>  }
>
> diff --git a/builtin/send-pack.c b/builtin/send-pack.c
> index f420b74..f26ba21 100644
> --- a/builtin/send-pack.c
> +++ b/builtin/send-pack.c
> @@ -86,7 +86,7 @@ static void print_helper_status(struct ref *ref)
>                 }
>                 strbuf_addch(&buf, '\n');
>
> -               write_or_die(1, buf.buf, buf.len);
> +               strbuf_write_or_die(&buf, 1);
>         }
>         strbuf_release(&buf);
>  }
> diff --git a/builtin/stripspace.c b/builtin/stripspace.c
> index 1259ed7..33b7f85 100644
> --- a/builtin/stripspace.c
> +++ b/builtin/stripspace.c
> @@ -115,7 +115,7 @@ int cmd_stripspace(int argc, const char **argv, const char *prefix)
>         else
>                 comment_lines(&buf);
>
> -       write_or_die(1, buf.buf, buf.len);
> +       strbuf_write_or_die(&buf, 1);
>         strbuf_release(&buf);
>         return 0;
>  }
> diff --git a/builtin/tag.c b/builtin/tag.c
> index 74d3780..53ab280 100644
> --- a/builtin/tag.c
> +++ b/builtin/tag.c
> @@ -349,7 +349,7 @@ static void create_tag(const unsigned char *object, const char *tag,
>                                 strbuf_commented_addf(&buf, _(tag_template), comment_line_char);
>                         else
>                                 strbuf_commented_addf(&buf, _(tag_template_nocleanup), comment_line_char);
> -                       write_or_die(fd, buf.buf, buf.len);
> +                       strbuf_write_or_die(&buf, fd);
>                         strbuf_release(&buf);
>                 }
>                 close(fd);
> diff --git a/bundle.c b/bundle.c
> index e99065c..c8bddd8 100644
> --- a/bundle.c
> +++ b/bundle.c
> @@ -279,7 +279,7 @@ int create_bundle(struct bundle_header *header, const char *path,
>         while (strbuf_getwholeline(&buf, rls_fout, '\n') != EOF) {
>                 unsigned char sha1[20];
>                 if (buf.len > 0 && buf.buf[0] == '-') {
> -                       write_or_die(bundle_fd, buf.buf, buf.len);
> +                       strbuf_write_or_die(&buf, bundle_fd);
>                         if (!get_sha1_hex(buf.buf + 1, sha1)) {
>                                 struct object *object = parse_object_or_die(sha1, buf.buf);
>                                 object->flags |= UNINTERESTING;
> diff --git a/credential-store.c b/credential-store.c
> index f9146e5..6cb5fcb 100644
> --- a/credential-store.c
> +++ b/credential-store.c
> @@ -48,7 +48,7 @@ static void print_entry(struct credential *c)
>  static void print_line(struct strbuf *buf)
>  {
>         strbuf_addch(buf, '\n');
> -       write_or_die(credential_lock.fd, buf->buf, buf->len);
> +       strbuf_write_or_die(buf, credential_lock.fd);
>  }
>
>  static void rewrite_credential_file(const char *fn, struct credential *c,
> diff --git a/fetch-pack.c b/fetch-pack.c
> index f061f1f..af28bd2 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -216,7 +216,7 @@ static void send_request(struct fetch_pack_args *args,
>                 send_sideband(fd, -1, buf->buf, buf->len, LARGE_PACKET_MAX);
>                 packet_flush(fd);
>         } else
> -               write_or_die(fd, buf->buf, buf->len);
> +               strbuf_write_or_die(buf, fd);
>  }
>
>  static void insert_one_alternate_ref(const struct ref *ref, void *unused)
> diff --git a/http-backend.c b/http-backend.c
> index d2c0a62..bed9341 100644
> --- a/http-backend.c
> +++ b/http-backend.c
> @@ -157,7 +157,7 @@ static void send_strbuf(const char *type, struct strbuf *buf)
>         hdr_int(content_length, buf->len);
>         hdr_str(content_type, type);
>         end_headers();
> -       write_or_die(1, buf->buf, buf->len);
> +       strbuf_write_or_die(buf, 1);
>  }
>
>  static void send_local_file(const char *the_type, const char *name)
> diff --git a/remote-curl.c b/remote-curl.c
> index 10cb011..677df24 100644
> --- a/remote-curl.c
> +++ b/remote-curl.c
> @@ -634,7 +634,7 @@ static int rpc_service(struct rpc_state *rpc, struct discovery *heads)
>         if (start_command(&client))
>                 exit(1);
>         if (preamble)
> -               write_or_die(client.in, preamble->buf, preamble->len);
> +               strbuf_write_or_die(preamble, client.in);
>         if (heads)
>                 write_or_die(client.in, heads->buf, heads->len);
>
> @@ -767,7 +767,7 @@ static int fetch_git(struct discovery *heads,
>
>         err = rpc_service(&rpc, heads);
>         if (rpc.result.len)
> -               write_or_die(1, rpc.result.buf, rpc.result.len);
> +               strbuf_write_or_die(&rpc.result, 1);
>         strbuf_release(&rpc.result);
>         strbuf_release(&preamble);
>         free(depth_arg);
> @@ -889,7 +889,7 @@ static int push_git(struct discovery *heads, int nr_spec, char **specs)
>
>         err = rpc_service(&rpc, heads);
>         if (rpc.result.len)
> -               write_or_die(1, rpc.result.buf, rpc.result.len);
> +               strbuf_write_or_die(&rpc.result, 1);
>         strbuf_release(&rpc.result);
>         argv_array_clear(&args);
>         return err;
> --
> 1.7.9.5
>
