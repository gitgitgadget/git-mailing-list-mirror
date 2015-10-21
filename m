From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v3 17/34] mailinfo: move use_scissors and
 use_inbody_headers to struct mailinfo
Date: Wed, 21 Oct 2015 13:24:48 -0700
Message-ID: <CAGZ79kZkms9SS3YpyEK4tmUPZ3TwXRF1M30X58GrS8dV13rJng@mail.gmail.com>
References: <1444855557-2127-1-git-send-email-gitster@pobox.com>
	<1445239731-10677-1-git-send-email-gitster@pobox.com>
	<1445239731-10677-18-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 21 22:25:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZozwM-0006re-T8
	for gcvg-git-2@plane.gmane.org; Wed, 21 Oct 2015 22:24:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755324AbbJUUYu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2015 16:24:50 -0400
Received: from mail-yk0-f180.google.com ([209.85.160.180]:32982 "EHLO
	mail-yk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750767AbbJUUYt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2015 16:24:49 -0400
Received: by yknn9 with SMTP id n9so61808123ykn.0
        for <git@vger.kernel.org>; Wed, 21 Oct 2015 13:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Qr2vF1iqjVybVAMOGMjJnUntQ5lAMvM6L/rItwFl8mI=;
        b=l8s+tE0QpjfiaqGWdaOMEt4Gc35Oc6xML0XoGv9ydoONrAO3bWW/mXNoSb+VDRqfrA
         SP2nk0wpy0Iwa99IJfBtcqQ7A/bnETptBE+1+0eHDjN0tENd4o9UKwlzqoDCiRBxec0i
         GgJfyOCees1oDFdJbvuC9H+GLzQsMWu8WMY4FHQYhJC3Fxx5olJv2osSMC+rDmevI2jO
         3pQ3y961yIVEX9ReaNdAFYePjNNTpZfCZBm1pnz+w7aOvS+lG8B0vI4xdVnS35j6a5wl
         mhHGiYa4c8L1TpwsIwFHVyyBgBVErqx++ke3dhP6gval1LdNxNDkmTkPkzNLH42sgC4V
         Rz0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=Qr2vF1iqjVybVAMOGMjJnUntQ5lAMvM6L/rItwFl8mI=;
        b=U8mlBPLTYhRMGGK23Z2V0OtvhSvrBs6mT/g2ZcK8JBM2g+cPHadex6qidd7wDpG3x/
         KL96cBovfhyLyxIe0h6CTfaQ6E+u4bOkXKiDuYSg+ldDYJCEz0E2y/a/P9MmhC+z/tpA
         c55qqlarFpkmtq0OQTJ+lnmenszhoLK8XMpmxmH5hJ7vpGygA1Upp+iwX+LFwmpK1dsI
         NjPv7hUKTf8ovSGensg3Tn8jBD7EknxvaS1RFmeixrIs/+/je0iLkE6n/mJQbic4HFEk
         r2ME6Dadexvu774H0QDPLd0RzP47L2m+jquJdbh0zHseJVXtlgviBB2t2TMCnfzzgdFc
         P8IA==
X-Gm-Message-State: ALoCoQmr5Du4Wwxr3ymQFlHqm1mKMGbrZi0fzPr/y3m+usjfUBvaOhNKIC63FHYIEtagC+0tvVNy
X-Received: by 10.129.155.130 with SMTP id s124mr6515166ywg.68.1445459088630;
 Wed, 21 Oct 2015 13:24:48 -0700 (PDT)
Received: by 10.37.29.213 with HTTP; Wed, 21 Oct 2015 13:24:48 -0700 (PDT)
In-Reply-To: <1445239731-10677-18-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280012>

On Mon, Oct 19, 2015 at 12:28 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  builtin/mailinfo.c | 23 +++++++++++++----------
>  1 file changed, 13 insertions(+), 10 deletions(-)
>
> diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
> index c0522f2..2c8f249 100644
> --- a/builtin/mailinfo.c
> +++ b/builtin/mailinfo.c
> @@ -20,6 +20,8 @@ struct mailinfo {
>         int keep_subject;
>         int keep_non_patch_brackets_in_subject;
>         int add_message_id;
> +       int use_scissors;
> +       int use_inbody_headers; /* defaults to 1 */

IMHO there is no need for the comment here, stating its default.
That can be looked up in the init function, which is as convenient as
reading globals in a file?

>
>         char *message_id;
>         int patch_lines;
> @@ -34,8 +36,6 @@ static enum  {
>  static struct strbuf charset = STRBUF_INIT;
>
>  static struct strbuf **p_hdr_data, **s_hdr_data;
> -static int use_scissors;
> -static int use_inbody_headers = 1;
>
>  #define MAX_HDR_PARSED 10
>  #define MAX_BOUNDARIES 5
> @@ -734,7 +734,7 @@ static int handle_commit_msg(struct mailinfo *mi, struct strbuf *line)
>                         return 0;
>         }
>
> -       if (use_inbody_headers && mi->header_stage) {
> +       if (mi->use_inbody_headers && mi->header_stage) {
>                 mi->header_stage = check_header(mi, line, s_hdr_data, 0);
>                 if (mi->header_stage)
>                         return 0;
> @@ -748,7 +748,7 @@ static int handle_commit_msg(struct mailinfo *mi, struct strbuf *line)
>         if (metainfo_charset)
>                 convert_to_utf8(line, charset.buf);
>
> -       if (use_scissors && is_scissors_line(line)) {
> +       if (mi->use_scissors && is_scissors_line(line)) {
>                 int i;
>                 if (fseek(cmitmsg, 0L, SEEK_SET))
>                         die_errno("Could not rewind output message file");
> @@ -1009,12 +1009,14 @@ static int mailinfo(struct mailinfo *mi, const char *msg, const char *patch)
>         return 0;
>  }
>
> -static int git_mailinfo_config(const char *var, const char *value, void *unused)
> +static int git_mailinfo_config(const char *var, const char *value, void *mi_)
>  {
> +       struct mailinfo *mi = mi_;
> +
>         if (!starts_with(var, "mailinfo."))
> -               return git_default_config(var, value, unused);
> +               return git_default_config(var, value, NULL);
>         if (!strcmp(var, "mailinfo.scissors")) {
> -               use_scissors = git_config_bool(var, value);
> +               mi->use_scissors = git_config_bool(var, value);
>                 return 0;
>         }
>         /* perhaps others here */
> @@ -1027,6 +1029,7 @@ static void setup_mailinfo(struct mailinfo *mi)
>         strbuf_init(&mi->name, 0);
>         strbuf_init(&mi->email, 0);
>         mi->header_stage = 1;
> +       mi->use_inbody_headers = 1;
>         git_config(git_mailinfo_config, &mi);
>  }
>
> @@ -1068,11 +1071,11 @@ int cmd_mailinfo(int argc, const char **argv, const char *prefix)
>                 else if (starts_with(argv[1], "--encoding="))
>                         metainfo_charset = argv[1] + 11;
>                 else if (!strcmp(argv[1], "--scissors"))
> -                       use_scissors = 1;
> +                       mi.use_scissors = 1;
>                 else if (!strcmp(argv[1], "--no-scissors"))
> -                       use_scissors = 0;
> +                       mi.use_scissors = 0;
>                 else if (!strcmp(argv[1], "--no-inbody-headers"))
> -                       use_inbody_headers = 0;
> +                       mi.use_inbody_headers = 0;
>                 else
>                         usage(mailinfo_usage);
>                 argc--; argv++;
> --
> 2.6.2-383-g144b2e6
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
