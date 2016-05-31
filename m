From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/3] pretty: support "mboxrd" output format
Date: Mon, 30 May 2016 23:40:48 -0400
Message-ID: <CAPig+cQrSJe03_RtSyf5KO2vE3Rri7t70-he8SXA9Y4oBYY_Ww@mail.gmail.com>
References: <20160530232142.21098-1-e@80x24.org>
	<20160530232142.21098-2-e@80x24.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Eric Wong <e@80x24.org>
X-From: git-owner@vger.kernel.org Tue May 31 05:45:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7acf-00055I-Pi
	for gcvg-git-2@plane.gmane.org; Tue, 31 May 2016 05:45:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932632AbcEaDku (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 May 2016 23:40:50 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:33823 "EHLO
	mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932469AbcEaDku (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2016 23:40:50 -0400
Received: by mail-it0-f66.google.com with SMTP id k76so9216903ita.1
        for <git@vger.kernel.org>; Mon, 30 May 2016 20:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=NxJYJk7WWVSpjJE1aFHW4ZzNtRWXh4C04k0sRd3jYec=;
        b=enOg3ipv8eoNhm9BVxq2+98wTRL2h2Wrta8NCna1EM1WY3TAOS9KAk/Vmf6rkUzYB2
         oB4ITgMpb8UX6ubC+6E/giNFe/fej48ChDNQmxzQDbBvpXf3lNuRUVuRQzPu28/aX+BS
         gKryg8uSxVFuGy5T4WzYfWXZzSU5kcOb0+mLryYaMJ0jp8YwxP4EaUqr888jXEf0PJrO
         pEBNH1oeXENgEGWqLgL07Et1ns/auYcywS4iQUbCqaK3Fgs0SewTETc1FFFbI2P0eXqb
         t5lxNQ0065SjuWvx36bPvQHBV/hIUYM79l7TqGRxYFtnWLpqN/uuXcE6wjPGTpclvIL/
         534A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=NxJYJk7WWVSpjJE1aFHW4ZzNtRWXh4C04k0sRd3jYec=;
        b=gnrZExWSIWh0h1rn9bZaHYhXT9bagEzc/rDupZ5Yb9T8nol11mxPs/x1wSfRA85Wl1
         oyJCcBYbX3TkvEZbmMpM1l3FLtEP7AaLCfwJXNOoXezusf6/lVNDvlkAnyhpfxT7HQoO
         7KKTUx1Wl9sWYOJ//oO7uRwHGYrZ0zdR8vfH8Dyvxq33bNW7WxXwz5HkpwA9M04kSItA
         KpV2zZODkjCqQhGmFK5mtTsAfTZG13n+9sPRR7GmOpnIyP+0k2l2n09S73a8MyU1VawK
         BEzyQURDwte9KBCe/3aF0kcMoXY8LHhZWQD2gB8g8w9sEWLMLmsTEHKehfwyd+sMuMNP
         ZXMg==
X-Gm-Message-State: ALyK8tKoGN46aKiCaH/JSvcLfVfldMgMPb/3HNvrHLvY+gEBvEvUeQ3VwOEQEZRmB2ko+DjgYm1AlKLhy6cHkA==
X-Received: by 10.36.112.81 with SMTP id f78mr11328418itc.32.1464666048826;
 Mon, 30 May 2016 20:40:48 -0700 (PDT)
Received: by 10.79.110.21 with HTTP; Mon, 30 May 2016 20:40:48 -0700 (PDT)
In-Reply-To: <20160530232142.21098-2-e@80x24.org>
X-Google-Sender-Auth: YmJ87Zdwd1_NiQ4w1GrQUEpY9-A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295947>

On Mon, May 30, 2016 at 7:21 PM, Eric Wong <e@80x24.org> wrote:
> This output format prevents format-patch output from breaking
> readers if somebody copy+pasted an mbox into a commit message.
>
> Unlike the traditional "mboxo" format, "mboxrd" is designed to
> be fully-reversible.  "mboxrd" also gracefully degrades to
> showing extra ">" in existing "mboxo" readers.
> [...]
> Signed-off-by: Eric Wong <e@80x24.org>
> ---
> diff --git a/pretty.c b/pretty.c
> @@ -1697,12 +1699,34 @@ static void pp_handle_indent(struct pretty_print_context *pp,
> +static regex_t *mboxrd_prepare(void)
> +{
> +       static regex_t preg;
> +       const char re[] = "^>*From ";
> +       int err = regcomp(&preg, re, REG_NOSUB | REG_EXTENDED);
> +[...]
> +       return &preg;
> +}
> +
>  void pp_remainder(struct pretty_print_context *pp,
>                   const char **msg_p,
>                   struct strbuf *sb,
>                   int indent)
>  {
> +       static regex_t *mboxrd_from;
> +
> +       if (pp->fmt == CMIT_FMT_MBOXRD && !mboxrd_from)
> +               mboxrd_from = mboxrd_prepare();
> +
> @@ -1725,8 +1749,13 @@ void pp_remainder(struct pretty_print_context *pp,
>                 else if (pp->expand_tabs_in_log)
>                         strbuf_add_tabexpand(sb, pp->expand_tabs_in_log,
>                                              line, linelen);
> -               else
> +               else {
> +                       if (pp->fmt == CMIT_FMT_MBOXRD &&
> +                                       !regexec(mboxrd_from, line, 0, 0, 0))
> +                               strbuf_addch(sb, '>');

At first glance, this seems dangerous since it's handing 'line' to
regexec() without paying attention to 'linelen'. For an arbitrary
regex, this could result in erroneous matches on subsequent "lines",
however, since this expression is anchored with '^', it's not a
problem. But, it is a bit subtle.

I wonder if hand-coding, rather than using a regex, could be an improvement:

    static int is_mboxrd_from(const char *s, size_t n)
    {
        size_t f = strlen("From ");
        const char *t = s + n;

        while (s < t && *s == '>')
            s++;
        return t - s >= f && !memcmp(s, "From ", f);
    }

    ...
    if (is_mboxrd_from(line, linelen)
        strbuf_addch(sb, '>');

or something.

> +
>                         strbuf_add(sb, line, linelen);
> +               }
>                 strbuf_addch(sb, '\n');
>         }
>  }
> diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
> @@ -1565,4 +1565,31 @@ test_expect_success 'format-patch --base overrides format.useAutoBase' '
> +test_expect_success 'format-patch --pretty=mboxrd' '
> +       cat >msg <<-INPUT_END &&

Maybe use <<-\INPUT_END to indicate that no variable interpolation is
expected. Ditto below.

> +       mboxrd should escape the body
> +
> +       From could trip up a loose mbox parser
> +       >From extra escape for reversibility
> +       >>From extra escape for reversibility 2
> +       from lower case not escaped
> +       Fromm bad speling not escaped
> +        From with leading space not escaped
> +       INPUT_END
> +
> +       cat >expect <<-INPUT_END &&
> +       >From could trip up a loose mbox parser
> +       >>From extra escape for reversibility
> +       >>>From extra escape for reversibility 2
> +       from lower case not escaped
> +       Fromm bad speling not escaped
> +        From with leading space not escaped
> +       INPUT_END
> +
> +       C=$(git commit-tree HEAD^^{tree} -p HEAD <msg) &&
> +       git format-patch --pretty=mboxrd --stdout -1 $C~1..$C >patch &&
> +       grep -A5 "^>From could trip up a loose mbox parser" patch >actual &&

Hmm, -A is not POSIX and is otherwise not used in Git tests. Perhaps
you could use 'git grep --no-index -A' instead or something?

> +       test_cmp expect actual
> +'
> +
>  test_done
