From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] fixed translation in config file to enhance user output
 message from the porcelain command(git config). This fixes the error and die
 function by wrapping it in the _(...) function. This also avoid the code from breaking
Date: Wed, 6 May 2015 12:26:30 -0700
Message-ID: <CAGZ79kaVhYi8amQkRMsHEWZCyMOSWr7NwRaz5TG+pyz5O79k6g@mail.gmail.com>
References: <554a6462.c2bbb40a.1e2a.0255@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Alangi Derick <alangiderick@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 06 21:26:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yq4xq-0001XT-7H
	for gcvg-git-2@plane.gmane.org; Wed, 06 May 2015 21:26:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751282AbbEFT0d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 May 2015 15:26:33 -0400
Received: from mail-ig0-f175.google.com ([209.85.213.175]:38780 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751219AbbEFT0b (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 May 2015 15:26:31 -0400
Received: by igbhj9 with SMTP id hj9so26146857igb.1
        for <git@vger.kernel.org>; Wed, 06 May 2015 12:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=jK7sirbfkerq8KFA+Nm+XVdkAO1+myEzkA02kdaDquE=;
        b=Ypa20X/QKdPJnkjeqthCp8j/KQYchCfPaZZxWXnyZihfn/Co9tnsglr/EIgp2U5J/t
         psW+fn6SKkjvDNnzm3ey6+QIhvR41+ZDNYfFrZzNpgcPx+a6piVWW33PB/lEbWri+k0S
         BcBYYIFodtjEt081IC8pFnE6Lu2DdhgUUOb4PFLvBQRy5g+hodN7LlLfcP9vwBIxsnDi
         /bJ9ES4BRHXyQs1qSHIR/0nCXChS9P+E+U/bxkEK+2NZ3f/2f19oaF9hgRZyu7vMYx4Q
         41GUDfGMXx9yPn2y+zI4IcStYobnxXAnzwfGHIf2twutpvC0uik/xRjYFPkDjh1s11mg
         D8+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:content-type;
        bh=jK7sirbfkerq8KFA+Nm+XVdkAO1+myEzkA02kdaDquE=;
        b=kBrxwv+yp5Ndst1R+8I8lRCldhGQDDaHZabDj+W5juXPjJF388AJgFgOCLl0hoEo7Q
         ih0CIrmBwlb3AYbAIXGcCbi8c5Lh7oZcB/PdAdUywyfJUDcqGJkjMASpLR/sEKEXhbp5
         NJPfh/F5urPnqdQDaJ6N2menLBj5NI9gf6U/X9XsS8s7FoxfRdS+vfsdsxOOfxElcVOV
         DiZFqWRrHqxs7wSS85+d9ksg3xa+JDs5b/rdsV0SG6xHvvK2KMUXx2R8OE2jNgbRekz1
         m8L1tdn/oHSRtkFh0HMldi7Aj2CemUkQv0EYDUPu0XYdBKiV8i1O/IqxGLjrIxDTHz9j
         /zZQ==
X-Gm-Message-State: ALoCoQnqZwub3dO68BdrvDdX19MYrFOo9/o14XT6Wc1MhTbDZy4uTgjW1nM3c6ZcqFvgf2MsDXts
X-Received: by 10.107.170.226 with SMTP id g95mr448462ioj.2.1430940390804;
 Wed, 06 May 2015 12:26:30 -0700 (PDT)
Received: by 10.107.46.22 with HTTP; Wed, 6 May 2015 12:26:30 -0700 (PDT)
In-Reply-To: <554a6462.c2bbb40a.1e2a.0255@mx.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268485>

Please don't BCC all recipients, but just CC or send it to them.


On Wed, May 6, 2015 at 11:51 AM, Alangi Derick <alangiderick@gmail.com> wrote:

Usually here comes a rationale why the changes below are worth accepting
such as:

    This enables translations in git-config, which is a porcelain user facing
    command, so we want to show localized error messages.

Mind that there are 2 different files ./config.c and ./builtin/config.c
While ./builtin/config.c is used for the "git config" command and would
benefit from the error translation, I am unsure about ./config.c

All files directly in the top level directory from Git are usually quite
library like and used by the different commands in the builtin/ directory.
So I suspect there is a plumbing command which would make use of
these code paths, which is what we want to avoid.

> Signed-off-by: Alangi Derick <alangiderick@gmail.com>
> ---
>  config.c | 46 +++++++++++++++++++++++-----------------------
>  1 file changed, 23 insertions(+), 23 deletions(-)
>
> diff --git a/config.c b/config.c
> index 66c0a51..cc41dbb 100644
> --- a/config.c
> +++ b/config.c
> @@ -76,7 +76,7 @@ static int config_buf_ungetc(int c, struct config_source *conf)
>         if (conf->u.buf.pos > 0) {
>                 conf->u.buf.pos--;
>                 if (conf->u.buf.buf[conf->u.buf.pos] != c)
> -                       die("BUG: config_buf can only ungetc the same character");
> +                       die(_("BUG: config_buf can only ungetc the same character"));
>                 return c;
>         }
>
> @@ -106,7 +106,7 @@ static int handle_path_include(const char *path, struct config_include_data *inc
>
>         expanded = expand_user_path(path);
>         if (!expanded)
> -               return error("Could not expand include path '%s'", path);
> +               return error(_("Could not expand include path '%s'"), path);
>         path = expanded;
>
>         /*
> @@ -117,7 +117,7 @@ static int handle_path_include(const char *path, struct config_include_data *inc
>                 char *slash;
>
>                 if (!cf || !cf->path)
> -                       return error("relative config includes must come from files");
> +                       return error(_("relative config includes must come from files"));
>
>                 slash = find_last_dir_sep(cf->path);
>                 if (slash)
> @@ -177,7 +177,7 @@ int git_config_parse_parameter(const char *text,
>
>         pair = strbuf_split_str(text, '=', 2);
>         if (!pair[0])
> -               return error("bogus config parameter: %s", text);
> +               return error(_("bogus config parameter: %s"), text);
>
>         if (pair[0]->len && pair[0]->buf[pair[0]->len - 1] == '=') {
>                 strbuf_setlen(pair[0], pair[0]->len - 1);
> @@ -189,7 +189,7 @@ int git_config_parse_parameter(const char *text,
>         strbuf_trim(pair[0]);
>         if (!pair[0]->len) {
>                 strbuf_list_free(pair);
> -               return error("bogus config parameter: %s", text);
> +               return error(_("bogus config parameter: %s"), text);
>         }
>         strbuf_tolower(pair[0]);
>         if (fn(pair[0]->buf, value, data) < 0) {
> @@ -854,7 +854,7 @@ static int git_default_core_config(const char *var, const char *value)
>                         comment_line_char = value[0];
>                         auto_comment_line_char = 0;
>                 } else
> -                       return error("core.commentChar should only be one character");
> +                       return error(_("core.commentChar should only be one character"));
>                 return 0;
>         }
>
> @@ -949,7 +949,7 @@ static int git_default_branch_config(const char *var, const char *value)
>                 else if (!strcmp(value, "always"))
>                         autorebase = AUTOREBASE_ALWAYS;
>                 else
> -                       return error("Malformed value for %s", var);
> +                       return error(_("Malformed value for %s"), var);
>                 return 0;
>         }
>
> @@ -976,8 +976,8 @@ static int git_default_push_config(const char *var, const char *value)
>                         push_default = PUSH_DEFAULT_CURRENT;
>                 else {
>                         error("Malformed value for %s: %s", var, value);
> -                       return error("Must be one of nothing, matching, simple, "
> -                                    "upstream or current.");
> +                       return error(_("Must be one of nothing, matching, simple, "
> +                                    "upstream or current."));
>                 }
>                 return 0;
>         }
> @@ -1124,10 +1124,10 @@ static int git_config_from_blob_sha1(config_fn_t fn,
>
>         buf = read_sha1_file(sha1, &type, &size);
>         if (!buf)
> -               return error("unable to load config blob object '%s'", name);
> +               return error(_("unable to load config blob object '%s'"), name);
>         if (type != OBJ_BLOB) {
>                 free(buf);
> -               return error("reference '%s' does not point to a blob", name);
> +               return error(_("reference '%s' does not point to a blob"), name);
>         }
>
>         ret = git_config_from_buf(fn, name, buf, size, data);
> @@ -1143,7 +1143,7 @@ static int git_config_from_blob_ref(config_fn_t fn,
>         unsigned char sha1[20];
>
>         if (get_sha1(name, sha1) < 0)
> -               return error("unable to resolve config blob '%s'", name);
> +               return error(_("unable to resolve config blob '%s'"), name);
>         return git_config_from_blob_sha1(fn, name, sha1, data);
>  }
>
> @@ -1173,7 +1173,7 @@ unsigned long git_env_ulong(const char *k, unsigned long val)
>  {
>         const char *v = getenv(k);
>         if (v && !git_parse_ulong(v, &val))
> -               die("failed to parse %s", k);
> +               die(_("failed to parse %s"), k);
>         return val;
>  }
>
> @@ -1720,7 +1720,7 @@ static int store_aux(const char *key, const char *value, void *cb)
>
>  static int write_error(const char *filename)
>  {
> -       error("failed to write new configuration file %s", filename);
> +       error(_("failed to write new configuration file %s"), filename);
>
>         /* Same error code as "failed to rename". */
>         return 4;
> @@ -1859,12 +1859,12 @@ int git_config_parse_key(const char *key, char **store_key, int *baselen_)
>          */
>
>         if (last_dot == NULL || last_dot == key) {
> -               error("key does not contain a section: %s", key);
> +               error(_("key does not contain a section: %s"), key);
>                 return -CONFIG_NO_SECTION_OR_NAME;
>         }
>
>         if (!last_dot[1]) {
> -               error("key does not contain variable name: %s", key);
> +               error(_("key does not contain variable name: %s"), key);
>                 return -CONFIG_NO_SECTION_OR_NAME;
>         }
>
> @@ -1886,12 +1886,12 @@ int git_config_parse_key(const char *key, char **store_key, int *baselen_)
>                 if (!dot || i > baselen) {
>                         if (!iskeychar(c) ||
>                             (i == baselen + 1 && !isalpha(c))) {
> -                               error("invalid key: %s", key);
> +                               error(_("invalid key: %s"), key);
>                                 goto out_free_ret_1;
>                         }
>                         c = tolower(c);
>                 } else if (c == '\n') {
> -                       error("invalid key (newline): %s", key);
> +                       error(_("invalid key (newline): %s"), key);
>                         goto out_free_ret_1;
>                 }
>                 (*store_key)[i] = c;
> @@ -2113,7 +2113,7 @@ int git_config_set_multivar_in_file(const char *config_filename,
>         }
>
>         if (commit_lock_file(lock) < 0) {
> -               error("could not commit config file %s", config_filename);
> +               error(_("could not commit config file %s"), config_filename);
>                 ret = CONFIG_NO_WRITE;
>                 lock = NULL;
>                 goto out_free;
> @@ -2228,7 +2228,7 @@ int git_config_rename_section_in_file(const char *config_filename,
>         lock = xcalloc(1, sizeof(struct lock_file));
>         out_fd = hold_lock_file_for_update(lock, config_filename, 0);
>         if (out_fd < 0) {
> -               ret = error("could not lock config file %s", config_filename);
> +               ret = error(_("could not lock config file %s"), config_filename);
>                 goto out;
>         }
>
> @@ -2240,7 +2240,7 @@ int git_config_rename_section_in_file(const char *config_filename,
>         fstat(fileno(config_file), &st);
>
>         if (chmod(lock->filename.buf, st.st_mode & 07777) < 0) {
> -               ret = error("chmod on %s failed: %s",
> +               ret = error(_("chmod on %s failed: %s"),
>                                 lock->filename.buf, strerror(errno));
>                 goto out;
>         }
> @@ -2295,7 +2295,7 @@ int git_config_rename_section_in_file(const char *config_filename,
>         fclose(config_file);
>  unlock_and_out:
>         if (commit_lock_file(lock) < 0)
> -               ret = error("could not commit config file %s", config_filename);
> +               ret = error(_("could not commit config file %s"), config_filename);
>  out:
>         free(filename_buf);
>         return ret;
> @@ -2313,7 +2313,7 @@ int git_config_rename_section(const char *old_name, const char *new_name)
>  #undef config_error_nonbool
>  int config_error_nonbool(const char *var)
>  {
> -       return error("Missing value for '%s'", var);
> +       return error(_("Missing value for '%s'"), var);
>  }
>
>  int parse_config_key(const char *var,
> --
> 2.4.0.dirty
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
