From: Javier Domingo Cansino <javierdo1@gmail.com>
Subject: Re: [PATCH] diff: handle "-" as abbreviation of '@{-1}'
Date: Sat, 12 Mar 2016 02:48:38 +0000
Message-ID: <CALZVapk9seKDpLGbyJ23UVxP97WAHkdXS+U+yrJoKf-2cLamAQ@mail.gmail.com>
References: <1457748710-79370-1-git-send-email-senorsen.zhang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Senorsen <senorsen.zhang@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 12 03:49:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aeZc3-00046p-SG
	for gcvg-git-2@plane.gmane.org; Sat, 12 Mar 2016 03:49:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753202AbcCLCtB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Mar 2016 21:49:01 -0500
Received: from mail-lb0-f178.google.com ([209.85.217.178]:36356 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751583AbcCLCs7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Mar 2016 21:48:59 -0500
Received: by mail-lb0-f178.google.com with SMTP id x1so178559508lbj.3
        for <git@vger.kernel.org>; Fri, 11 Mar 2016 18:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=C0DMqwD7uWdrAfUnlIyOyc/1Mh0sK6qNhnLxkMG8r10=;
        b=ClI6BbbVfofYPVVYctxmsii/NOjF79dBDGo/dugE3q+dfOLyhlthLAZZuA+tiRzvWc
         8ucKt1Qm/5ErNRLlNLeonYp/fpjDH++m7uF/3+WaS+tfoHocf2atZ+xfMwA7WXjS9DJu
         q7tpOMivl2yQ8eqvtwEp/3FIiv+04EXn4oApzBkfuwu89HL6iXPQvYJHR+v3UOI+qqYz
         wiwRXv57NF7nqn2qGhYixHTWuhre5u+Slalzqjgj7BpkO3JNFTgOY82e/FhZNRDtghko
         /VSNwlEVM381vV8XxBt5knYPEwN5CeN3GEVzK13KPQzDT5CQTaCpc5llmP9CM4hV0e+B
         Cjnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=C0DMqwD7uWdrAfUnlIyOyc/1Mh0sK6qNhnLxkMG8r10=;
        b=RTvtXOfDVXncd6sjm2x3MUXwlgB/WxowwM16DsT4ArKVX2TX6WDIqTDzMJiIuGUMOD
         KawfLet4EuNHENkfCFlvlrLKIWJtBdjzOizFA88tDGX+D4N0b71BGg3+Ad9aCRP4tk74
         ffBFhrZHj7nEPs2Z4n8o+W4irwBalc0ujvj226rYZAKiY0Axe4FNmuEwo3neJ2S3dIhI
         Nve9oANN4t/cCvVTZSHdfHupwncWXaCTouGjmHS91dYhkVqhD0nxQM17p9I95Us2d630
         P0ZMyW6XNvwzRVfOHC/6EZd/fhDpJsmF1NSoNRh4shNrud72P8vphcOWMSoygUHd2PlM
         fHYg==
X-Gm-Message-State: AD7BkJKh0AmN8QUCzabughdGShCJNVkYaRfErr6Ujeb/fvpzzOGYs15bmGOOTUuNZuBBulW6DnoWo6jQLLQxfA==
X-Received: by 10.25.38.16 with SMTP id m16mr4430472lfm.37.1457750937882; Fri,
 11 Mar 2016 18:48:57 -0800 (PST)
Received: by 10.114.172.206 with HTTP; Fri, 11 Mar 2016 18:48:38 -0800 (PST)
In-Reply-To: <1457748710-79370-1-git-send-email-senorsen.zhang@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288725>

dash is usually used for representing stdin / stdout as a file. I
think this could drive to error... but I would agree with transforming
-h1 to @{-1} or -h2 to @{-2} (-h representing head).

I do agree however that all those signs are thought with american
keyboards in mind. All those punctuation marks are usually hard to
type in other keyboards, and -h1 is way simpler than HEAD~ or @{-1}

This links provides an example of my worry:
http://stackoverflow.com/questions/15270970/is-it-possible-to-git-diff-a-file-against-standard-input

On Sat, Mar 12, 2016 at 2:11 AM, Senorsen <senorsen.zhang@gmail.com> wrote:
>
> Currently it just replace "-" in argv[] into "@{-1}".
>
> For example,
>
>     git diff -
>
> equals to
>
>     git diff @{-1}
>
> Signed-off-by: Senorsen <senorsen.zhang@gmail.com>
> ---
> Notes:
>     Hello everyone, I'm Zhang Sen, a college student from Zhejiang University
>     in China, and this is a patch for the microproject of GSoC 2016. I'm
>     looking forward to contributing to Git and participating in GSoC 2016.
>
>     I have learnt some rules and guides from the documents, and carefully
>     wrote this small patch, according to other code from git.
>
>     Thanks a lot!
>
>  builtin/diff.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/builtin/diff.c b/builtin/diff.c
> index 52c98a9..c110141 100644
> --- a/builtin/diff.c
> +++ b/builtin/diff.c
> @@ -389,6 +389,11 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
>                 }
>         }
>
> +       for (i = 0; i < argc; i++) {
> +               if (!strcmp(argv[i], "-"))
> +                       argv[i] = "@{-1}";
> +       }
> +
>         for (i = 0; i < rev.pending.nr; i++) {
>                 struct object_array_entry *entry = &rev.pending.objects[i];
>                 struct object *obj = entry->item;
> --
> 2.7.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html




-- 
Javier Domingo Cansino
