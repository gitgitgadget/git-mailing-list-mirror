Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00150201A7
	for <e@80x24.org>; Tue, 16 May 2017 04:14:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750927AbdEPEOc (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 00:14:32 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:38513 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750839AbdEPEOb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 00:14:31 -0400
Received: by mail-wm0-f54.google.com with SMTP id v15so74165373wmv.1
        for <git@vger.kernel.org>; Mon, 15 May 2017 21:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ObXBDBeF5jC5HmGY/QUWg0ITm9tqsNoRW4h55vHoqiw=;
        b=cu1kr11Q4g2OZSkove/QR+UudJu9dGMkqsISgMrZNWjOKUk5vf546AEa3J5+u2chOn
         t1wFmEZGfyJO+lgfUuRpn849/ZUblpXF/1rfXHgvI9izO5e+AhUs8gAoS/HpQ3GfrXp2
         aboRnOjQ81RjveZa67X/9zHsSbIzD4zX5p3uFqCZg9MEafW65adfQVc0iZSxckQ6FreT
         rC8uesjvO1ig67K1C54mMV72bp4Hdtcfmh+uksULyw4muek7OzSN6CYIeEHF1+sXW7/E
         gRiJK9lAVTFTe/IIkVH0K27XvskMTCu4Xq3DjC8HCWfGMqlyV0GrvmOFItuLF8ptCCLU
         3RMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ObXBDBeF5jC5HmGY/QUWg0ITm9tqsNoRW4h55vHoqiw=;
        b=pHYj7okjbq0IbfpzX6pIbKOBp3n9rK/v66+0IWQBUX0CI+EM0ntYn00QeSZmPXnwiE
         xyyAzRtwEozb4yLDbEqcBIsuxw/rgeaV9nrTvnHgD1T7fyaiMA/wHssA/7QLzLH5cDpq
         M8ih3yyrACGNFqTbZXUuSi++i099zVXgjw87iOTUjoYpp4UN3d8CZ+jWNGmhLv1bigf0
         /s50wJBky+TCllVwAycnot7Qo78aaXRaP/7jdJ//1mrdJtbd3wU2bnFEdaHMtzsMhgq+
         WbNqkgxVljxX00yQKfH9ZB2iIuysUyaBhSAhpRZ6EOWpJTyy2CjysC4U67B7S8UJEYkj
         FrNQ==
X-Gm-Message-State: AODbwcAQxa6OSuv8EM+QByQ8xnqys/cgyiMcEHcBEd5KIh0pHFpp5NTu
        f2HXl/B7pfRwWTiPgnfmbwwScBUB+oNF
X-Received: by 10.28.157.209 with SMTP id g200mr5397106wme.34.1494908069634;
 Mon, 15 May 2017 21:14:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.18.149 with HTTP; Mon, 15 May 2017 21:14:28 -0700 (PDT)
In-Reply-To: <20170514040117.25865-19-sbeller@google.com>
References: <20170514040117.25865-1-sbeller@google.com> <20170514040117.25865-19-sbeller@google.com>
From:   Jonathan Tan <jonathantanmy@google.com>
Date:   Mon, 15 May 2017 21:14:28 -0700
Message-ID: <CAGf8dgJP+i5RL3FaGSYZyVKkt1ttSnnPd924ebs=4xJb4Fhc6w@mail.gmail.com>
Subject: Re: [PATCH 18/19] diff: buffer all output if asked to
To:     Stefan Beller <sbeller@google.com>
Cc:     Git mailing list <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Overall, this patch seems larger than it should to me, although there
might be good reasons for that that I don't know. I'll remark on what
I find unexpected.

On Sat, May 13, 2017 at 9:01 PM, Stefan Beller <sbeller@google.com> wrote:
> diff --git a/diff.c b/diff.c
> index 08dcc56bb9..dbab7fb44e 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -516,29 +516,29 @@ static void check_blank_at_eof(mmfile_t *mf1, mmfile_t *mf2,
>         ecbdata->blank_at_eof_in_postimage = (at - l2) + 1;
>  }
>
> -static void emit_line_0(struct diff_options *o, const char *set, const char *reset,
> -                       int sign, const char *line, int len)
> +static void emit_buffered_patch_line(struct diff_options *o,
> +                                    struct buffered_patch_line *e)
>  {
> -       int has_trailing_newline, has_trailing_carriage_return;
> +       int has_trailing_newline, has_trailing_carriage_return, len = e->len;
>         FILE *file = o->file;
>
>         fputs(diff_line_prefix(o), file);
>
> -       has_trailing_newline = (len > 0 && line[len-1] == '\n');
> +       has_trailing_newline = (len > 0 && e->line[len-1] == '\n');
>         if (has_trailing_newline)
>                 len--;
> -       has_trailing_carriage_return = (len > 0 && line[len-1] == '\r');
> +       has_trailing_carriage_return = (len > 0 && e->line[len-1] == '\r');
>         if (has_trailing_carriage_return)
>                 len--;
>
> -       if (len || sign) {
> -               if (set)
> -                       fputs(set, file);
> -               if (sign)
> -                       fputc(sign, file);
> -               fwrite(line, len, 1, file);
> -               if (reset)
> -                       fputs(reset, file);
> +       if (len || e->sign) {
> +               if (e->set)
> +                       fputs(e->set, file);
> +               if (e->sign)
> +                       fputc(e->sign, file);
> +               fwrite(e->line, len, 1, file);
> +               if (e->reset)
> +                       fputs(e->reset, file);
>         }
>         if (has_trailing_carriage_return)
>                 fputc('\r', file);
> @@ -546,6 +546,65 @@ static void emit_line_0(struct diff_options *o, const char *set, const char *res
>                 fputc('\n', file);
>  }
>
> +static void emit_buffered_patch_line_ws(struct diff_options *o,
> +                                       struct buffered_patch_line *e,
> +                                       const char *ws, unsigned ws_rule)

This introduces a new _ws emission function - how is this used and how
is this different from the non-ws one? I see BPL_EMIT_LINE_WS, but I
don't see the caller that introduces that constant in this patch.

> +{
> +       struct buffered_patch_line s = {e->set, e->reset, "", 0, e->sign};
> +
> +       emit_buffered_patch_line(o, &s);
> +       ws_check_emit(e->line, e->len, ws_rule,
> +                     o->file, e->set, e->reset, ws);
> +}
> +
> +static void process_next_buffered_patch_line(struct diff_options *o, int line_no)
> +{
> +       struct buffered_patch_line *e = &o->line_buffer[line_no];
> +
> +       const char *ws = o->current_filepair->ws;
> +       unsigned ws_rule = o->current_filepair->ws_rule;
> +
> +       switch (e->state) {
> +               case BPL_EMIT_LINE_ASIS:
> +                       emit_buffered_patch_line(o, e);
> +                       break;
> +               case BPL_EMIT_LINE_WS:
> +                       emit_buffered_patch_line_ws(o, e, ws, ws_rule);
> +                       break;
> +               case BPL_HANDOVER:
> +                       o->current_filepair++;

If we're just buffering the diff output, do we need to store
per-file-pair metadata? (I assume that's why you need a special
handover constant.) Clients can already read what they need from the
diff output.

> +                       break;
> +               default:
> +                       die("BUG: malformatted buffered patch line: '%d'", e->state);
> +       }
> +}
> +
> +static void append_buffered_patch_line(struct diff_options *o,
> +                                      struct buffered_patch_line *e)
> +{
> +       struct buffered_patch_line *f;
> +       ALLOC_GROW(o->line_buffer,
> +                  o->line_buffer_nr + 1,
> +                  o->line_buffer_alloc);
> +       f = &o->line_buffer[o->line_buffer_nr];
> +       o->line_buffer_nr++;
> +
> +       memcpy(f, e, sizeof(struct buffered_patch_line));
> +       f->line = e->line ? xmemdupz(e->line, e->len) : NULL;
> +}
> +
> +static void emit_line_0(struct diff_options *o,
> +                       const char *set, const char *reset,
> +                       int sign, const char *line, int len)
> +{
> +       struct buffered_patch_line e = {set, reset, line, len, sign, BPL_EMIT_LINE_ASIS};
> +
> +       if (o->use_buffer)
> +               append_buffered_patch_line(o, &e);
> +       else
> +               emit_buffered_patch_line(o, &e);
> +}
> +
>  void emit_line(struct diff_options *o, const char *set, const char *reset,
>                const char *line, int len)
>  {
> @@ -557,9 +616,12 @@ static void emit_line_ws(struct diff_options *o,
>                          const char *line, int len,
>                          const char *ws, unsigned ws_rule)
>  {
> -       emit_line_0(o, set, reset, sign, "", 0);
> -       ws_check_emit(line, len, ws_rule,
> -                     o->file, set, reset, ws);
> +       struct buffered_patch_line e = {set, reset, line, len, sign, BPL_EMIT_LINE_WS};
> +
> +       if (o->use_buffer)
> +               append_buffered_patch_line(o, &e);
> +       else
> +               emit_buffered_patch_line_ws(o, &e, ws, ws_rule);
>  }
>
>  void emit_line_fmt(struct diff_options *o,
> @@ -1160,6 +1222,16 @@ static void diff_words_flush(struct emit_callback *ecbdata)
>         if (ecbdata->diff_words->minus.text.size ||
>             ecbdata->diff_words->plus.text.size)
>                 diff_words_show(ecbdata->diff_words);
> +
> +       if (ecbdata->diff_words->opt->line_buffer_nr) {
> +               int i;
> +               for (i = 0; i < ecbdata->diff_words->opt->line_buffer_nr; i++)
> +                       append_buffered_patch_line(ecbdata->opt,
> +                               &ecbdata->diff_words->opt->line_buffer[i]);
> +
> +               ecbdata->diff_words->opt->line_buffer_nr = 0;
> +               /* TODO: free memory as well */
> +       }
>  }
>
>  static void diff_filespec_load_driver(struct diff_filespec *one)
> @@ -1195,6 +1267,11 @@ static void init_diff_words_data(struct emit_callback *ecbdata,
>                 xcalloc(1, sizeof(struct diff_words_data));
>         ecbdata->diff_words->type = o->word_diff;
>         ecbdata->diff_words->opt = o;
> +
> +       o->line_buffer = NULL;
> +       o->line_buffer_nr = 0;
> +       o->line_buffer_alloc = 0;
> +
>         if (!o->word_regex)
>                 o->word_regex = userdiff_word_regex(one);
>         if (!o->word_regex)
> @@ -2568,9 +2645,25 @@ static void builtin_diff(const char *name_a,
>                         xecfg.ctxlen = strtoul(v, NULL, 10);
>                 if (o->word_diff)
>                         init_diff_words_data(&ecbdata, o, one, two);
> +               if (o->use_buffer) {
> +                       ALLOC_GROW(o->filepair_buffer,
> +                                  o->filepair_buffer_nr + 1,
> +                                  o->filepair_buffer_alloc);
> +                       o->current_filepair =
> +                               &o->filepair_buffer[o->filepair_buffer_nr++];
> +
> +                       o->current_filepair->ws_rule = ecbdata.ws_rule;
> +                       o->current_filepair->ws =
> +                               diff_get_color(ecbdata.color_diff, DIFF_WHITESPACE);
> +               }
>                 if (xdi_diff_outf(&mf1, &mf2, fn_out_consume, &ecbdata,
>                                   &xpp, &xecfg))
>                         die("unable to generate diff for %s", one->path);
> +               if (o->use_buffer) {
> +                       struct buffered_patch_line e = BUFFERED_PATCH_LINE_INIT;
> +                       e.state = BPL_HANDOVER; /* handover to next file pair */
> +                       append_buffered_patch_line(o, &e);
> +               }
>                 if (o->word_diff)
>                         free_diff_words_data(&ecbdata);
>                 if (textconv_one)
> @@ -4785,11 +4878,44 @@ static void diff_flush_patch_all_file_pairs(struct diff_options *o)
>  {
>         int i;
>         struct diff_queue_struct *q = &diff_queued_diff;
> +       /*
> +        * For testing purposes we want to make sure the diff machinery
> +        * works completely with the buffer. If there is anything emitted
> +        * outside the emit_buffered_patch_line, then the order is screwed
> +        * up and the tests will fail.
> +        *
> +        * TODO (later in this series):
> +        * We'll unset this flag in a later patch.
> +        */
> +       o->use_buffer = 1;

What I would do is to add a demonstration patch at the end of the
patch series (which is not supposed to be queued) to avoid such churn
in history, but I'm not sure how the Git project prefers to do this.

> +
> +       if (o->use_buffer) {
> +               ALLOC_GROW(o->filepair_buffer,
> +                          o->filepair_buffer_nr + 1,
> +                          o->filepair_buffer_alloc);
> +               o->current_filepair = &o->filepair_buffer[o->filepair_buffer_nr];
> +       }
>         for (i = 0; i < q->nr; i++) {
>                 struct diff_filepair *p = q->queue[i];
>                 if (check_pair_status(p))
>                         diff_flush_patch(p, o);
>         }
> +
> +       if (o->use_buffer) {
> +               o->current_filepair = &o->filepair_buffer[0];
> +               for (i = 0; i < o->line_buffer_nr; i++)
> +                       process_next_buffered_patch_line(o, i);
> +
> +               for (i = 0; i < o->line_buffer_nr; i++);
> +                       free((void*)o->line_buffer[i].line);
> +
> +               o->line_buffer = NULL;
> +               o->line_buffer_nr = 0;
> +               free(o->line_buffer);
> +               o->filepair_buffer = NULL;
> +               o->filepair_buffer_nr = 0;
> +               free(o->filepair_buffer);
> +       }
>  }
>
>  void diff_flush(struct diff_options *options)
> diff --git a/diff.h b/diff.h
> index 5e89481769..c334aac02e 100644
> --- a/diff.h
> +++ b/diff.h
> @@ -115,6 +115,36 @@ enum diff_submodule_format {
>         DIFF_SUBMODULE_INLINE_DIFF
>  };
>
> +/*
> + * This struct is used when we need to buffer the output of the diff output.
> + *
> + * NEEDSWORK: Instead of storing a copy of the line, add an offset pointer
> + * into the pre/post image file. This pointer could be a union with the
> + * line pointer. By storing an offset into the file instead of the literal line,
> + * we can decrease the memory footprint for the buffered output. At first we
> + * may want to only have indirection for the content lines, but we could
> + * also have an enum (based on sign?) that stores prefabricated lines, e.g.
> + * the similarity score line or hunk/file headers.

This would be nice, but come to think of it, might not be possible.
When requesting --word-diff, control characters (or others) might
appear in the output, right?

> + */
> +struct buffered_patch_line {
> +       const char *set;
> +       const char *reset;
> +       const char *line;
> +       int len;
> +       int sign;
> +       enum {
> +               BPL_EMIT_LINE_WS,
> +               BPL_EMIT_LINE_ASIS,
> +               BPL_HANDOVER
> +       } state;

It might be better, for simplicity, just to have one big buffer
including everything (if we decide that we really can't add pointers
to input later).

> +};
> +#define BUFFERED_PATCH_LINE_INIT {NULL, NULL, NULL, 0, 0, 0}
> +
> +struct buffered_filepair {
> +       const char *ws;
> +       unsigned ws_rule;
> +};
> +
>  struct diff_options {
>         const char *orderfile;
>         const char *pickaxe;
> @@ -186,6 +216,15 @@ struct diff_options {
>         void *output_prefix_data;
>
>         int diff_path_counter;
> +
> +       int use_buffer;
> +
> +       struct buffered_patch_line *line_buffer;
> +       int line_buffer_nr, line_buffer_alloc;
> +
> +       struct buffered_filepair *filepair_buffer;
> +       int filepair_buffer_nr, filepair_buffer_alloc;
> +       struct buffered_filepair *current_filepair;
>  };
>
>  void emit_line_fmt(struct diff_options *o, const char *set, const char *reset,
> --
> 2.13.0.18.g183880de0a
>
