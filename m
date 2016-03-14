From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH/RFC/GSoC 05/17] rebase-options: implement
 rebase_options_load() and rebase_options_save()
Date: Mon, 14 Mar 2016 13:30:41 -0700
Message-ID: <CAGZ79kYeYzi=J=dY27FqXp72BRe-Vmm4MR5Q6dFTMUP9CxYZcg@mail.gmail.com>
References: <1457779597-6918-1-git-send-email-pyokagan@gmail.com>
	<1457779597-6918-6-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Duy Nguyen <pclouds@gmail.com>,
	Sam Halliday <sam.halliday@gmail.com>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 14 21:30:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afZ8Z-0001aY-Fb
	for gcvg-git-2@plane.gmane.org; Mon, 14 Mar 2016 21:30:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756057AbcCNUao (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Mar 2016 16:30:44 -0400
Received: from mail-io0-f176.google.com ([209.85.223.176]:32972 "EHLO
	mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753263AbcCNUan (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Mar 2016 16:30:43 -0400
Received: by mail-io0-f176.google.com with SMTP id n190so237491569iof.0
        for <git@vger.kernel.org>; Mon, 14 Mar 2016 13:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=u4fntzyQ2UZrG31dabjgbKN5Vb2mn2mvVT2kM6fI8ZA=;
        b=Vc0M2FUfgO9pcg2/MIpfTrhvKK0a5Rj1zQ+Rgr8nDFvfo4uwmHafzj/4MhKiCb8Zjo
         xtGW+LR6Z3idQZPmlgYVCZhoJKdqK27mSaxQLCgcs4BcRTUu5lgF45TEbIcYz+2qUQHd
         M+G9RpioeMVkQdM7uzsXyrw0zsminYiWyOptDfoXEi3DwbsXl9F+QLLzxO7mUsPMIkMj
         MOBn5LELb11aWFB2dY5/Pypq8pQVqBWEx7p8A1JmSpee1QJMCwmbS1rU6VpgsmfUAjSB
         V3oIo6UhuEuSizovUQCiinb+cm8YbjzJc2p66Y1a/QpHYCTnoLlBQyE8ZOAxNgdJ59T1
         eJdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=u4fntzyQ2UZrG31dabjgbKN5Vb2mn2mvVT2kM6fI8ZA=;
        b=SzO3kmS2LBYtmicqW2+dcbZpnP2RGKv3nly9kr0m10ZR7wUdZINVPCBxHXyDPLFZeC
         PvRpGXYIiWpKW9pdlljyThcW1q/ZoAUt7Vmmrp1Wd7tjMLgZErwSgWIxkXMe73u8GW/y
         gDiezTjLT32c5PS5VkKWfZb80TbwMVKnVqNcdfeCCfWE4W1Ten0YthK9/Wy7EjKmrVS8
         4R4ALy/Menn0zGc7kzH7ZtZLS4NNNy5bXnSvltNzMG3/mkOz2R1eOk5sTrg34TAgItBN
         JfOGFxG7h8F8xmAxaONwBGJ91/mlpIK/kYS8qM3hn//ilry5oJyuIEnBP3tcyLHZqrVt
         TcwA==
X-Gm-Message-State: AD7BkJLs04rAi0Lq1yDEOsnCm9z5wXk9uM8r6oJk9owCgXGgAb3Te4A37NYnBF3IE94scmyA03kCzOn9L0vnFlWo
X-Received: by 10.107.167.80 with SMTP id q77mr29801885ioe.110.1457987441479;
 Mon, 14 Mar 2016 13:30:41 -0700 (PDT)
Received: by 10.107.132.101 with HTTP; Mon, 14 Mar 2016 13:30:41 -0700 (PDT)
In-Reply-To: <1457779597-6918-6-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288806>

On Sat, Mar 12, 2016 at 2:46 AM, Paul Tan <pyokagan@gmail.com> wrote:
> These functions can be used for loading and saving common rebase options
> into a state directory.
>
> Signed-off-by: Paul Tan <pyokagan@gmail.com>
> ---
>  rebase-common.c | 69 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  rebase-common.h |  4 ++++
>  2 files changed, 73 insertions(+)
>
> diff --git a/rebase-common.c b/rebase-common.c
> index 5a49ac4..1835f08 100644
> --- a/rebase-common.c
> +++ b/rebase-common.c
> @@ -26,3 +26,72 @@ void rebase_options_swap(struct rebase_options *dst, struct rebase_options *src)
>         *dst = *src;
>         *src = tmp;
>  }
> +
> +static int state_file_exists(const char *dir, const char *file)
> +{
> +       return file_exists(mkpath("%s/%s", dir, file));
> +}

How is this specific to the state file? All it does is create the
leading directory
if it doesn't exist? (So I'd expect file_exists(concat(dir, file)) to
have the same
result without actually creating the directory if it doesn't exist as
a side effect?

If the dir doesn't exist it can be created in rebase_options_load explicitly?


> +
> +static int read_state_file(struct strbuf *sb, const char *dir, const char *file)
> +{
> +       const char *path = mkpath("%s/%s", dir, file);
> +       strbuf_reset(sb);
> +       if (strbuf_read_file(sb, path, 0) >= 0)
> +               return sb->len;
> +       else
> +               return error(_("could not read '%s'"), path);
> +}
> +
> +int rebase_options_load(struct rebase_options *opts, const char *dir)
> +{
> +       struct strbuf sb = STRBUF_INIT;
> +       const char *filename;
> +
> +       /* opts->orig_refname */
> +       if (read_state_file(&sb, dir, "head-name") < 0)
> +               return -1;
> +       strbuf_trim(&sb);
> +       if (starts_with(sb.buf, "refs/heads/"))
> +               opts->orig_refname = strbuf_detach(&sb, NULL);
> +       else if (!strcmp(sb.buf, "detached HEAD"))
> +               opts->orig_refname = NULL;
> +       else
> +               return error(_("could not parse %s"), mkpath("%s/%s", dir, "head-name"));
> +
> +       /* opts->onto */
> +       if (read_state_file(&sb, dir, "onto") < 0)
> +               return -1;
> +       strbuf_trim(&sb);
> +       if (get_oid_hex(sb.buf, &opts->onto) < 0)
> +               return error(_("could not parse %s"), mkpath("%s/%s", dir, "onto"));
> +
> +       /*
> +        * We always write to orig-head, but interactive rebase used to write
> +        * to head. Fall back to reading from head to cover for the case that
> +        * the user upgraded git with an ongoing interactive rebase.
> +        */
> +       filename = state_file_exists(dir, "orig-head") ? "orig-head" : "head";
> +       if (read_state_file(&sb, dir, filename) < 0)
> +               return -1;

So from here on we always use "orig-head" instead of "head" for
interactive rebase.
Would people ever rely on the (internal) file name and have e.g.
scripts which operate
on the "head" file ?


> +       strbuf_trim(&sb);
> +       if (get_oid_hex(sb.buf, &opts->orig_head) < 0)
> +               return error(_("could not parse %s"), mkpath("%s/%s", dir, filename));
> +
> +       strbuf_release(&sb);
> +       return 0;
> +}
> +
> +static int write_state_text(const char *dir, const char *file, const char *string)
> +{
> +       return write_file(mkpath("%s/%s", dir, file), "%s", string);
> +}

Same comment as on checking the state files existence. I'm not sure if the side
effect of creating the dir is better done explicitly where it is used.
The concat of dir and
file name can still be done in the helper though? (If the helper is
needed at all then)

> +
> +void rebase_options_save(const struct rebase_options *opts, const char *dir)
> +{
> +       const char *head_name = opts->orig_refname;
> +       if (!head_name)
> +               head_name = "detached HEAD";
> +       write_state_text(dir, "head-name", head_name);
> +       write_state_text(dir, "onto", oid_to_hex(&opts->onto));
> +       write_state_text(dir, "orig-head", oid_to_hex(&opts->orig_head));
> +}
> diff --git a/rebase-common.h b/rebase-common.h
> index db5146a..051c056 100644
> --- a/rebase-common.h
> +++ b/rebase-common.h
> @@ -20,4 +20,8 @@ void rebase_options_release(struct rebase_options *);
>
>  void rebase_options_swap(struct rebase_options *dst, struct rebase_options *src);
>
> +int rebase_options_load(struct rebase_options *, const char *dir);
> +
> +void rebase_options_save(const struct rebase_options *, const char *dir);
> +
>  #endif /* REBASE_COMMON_H */
> --
> 2.7.0
>
