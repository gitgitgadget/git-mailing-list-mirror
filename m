From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 2/2] rev-parse: fix some options when executed from
 subpath of main tree
Date: Tue, 10 May 2016 03:38:34 -0400
Message-ID: <CAPig+cQ9+=JcNguvuFN9GwHf1M1aLDNeyY8dJQLMkEGSXrU6Tg@mail.gmail.com>
References: <1462541720-79553-1-git-send-email-rappazzo@gmail.com>
	<1462541720-79553-3-git-send-email-rappazzo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
To: Michael Rappazzo <rappazzo@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 10 09:38:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b02Fq-0001hl-EU
	for gcvg-git-2@plane.gmane.org; Tue, 10 May 2016 09:38:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751843AbcEJHih (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2016 03:38:37 -0400
Received: from mail-ig0-f195.google.com ([209.85.213.195]:34764 "EHLO
	mail-ig0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751041AbcEJHif (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2016 03:38:35 -0400
Received: by mail-ig0-f195.google.com with SMTP id kj7so609714igb.1
        for <git@vger.kernel.org>; Tue, 10 May 2016 00:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=S4GyFuNjsnBw02/y/kdw058QVBq9/OH7UD5CH/Tn5PY=;
        b=TYrkcLwF/kQYKejrpZ/XWzbCSqJ9m2OeP/y+la5dr9Vw1E4eHYIblI3hj1i8zrLc1c
         upg+f+GXZ73k30899Rf4P9zSZ7SLDC89c/drNxoey5Mkvp99ddm+0nXzZ+Qb12JlqzmS
         VBvi/15IByqz8cTXAen8b1FgVRZLaG6YiO5oL2w86DmWoOx51RFloFyS4PyAVNVBRUHE
         0HQpQQ05Vtnx3bWArCXCmWk8GpwVwD5rqO5Sbi+Dh7bvBx+VSS4FP7vU3rh91B904cUM
         lxot1NY2x7fMOk0AUZ8G3gnliYiiv22OFLLEOa9KXH3EVTlKGWxbgoYMtScBvEiFNNrj
         O4jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=S4GyFuNjsnBw02/y/kdw058QVBq9/OH7UD5CH/Tn5PY=;
        b=RnAC2YFHuFDoelM2AMOkhv4vF/5mo4GUVftwLfPTj5QROyjGWmkQzh1CHmeErMG4lj
         W5BEc81JVgfq48+vDOVxMBPHLeEO7SL4SG4BVmRCTDZkAcSSL7/JZNad1PX5+o+hK5ZA
         Ne1PrX4Xy4mQoeENYeKNujI1eo3iJmmkfa/Lnea5M/i2r+FyyZJEGcoBsWunU5j6jL8N
         6ZfDBHlcm0MbQaguklE4u7cDnnthsD8h88sdqBOuPbhXQvsbOLRuuNL2FdsCzpfji1l8
         8Mg/hkQdMSNwrFgsn+jCqtmJpXqog7nkWuqN7WgjcWoMm0W/fdAullRAMiq8xbxiFhcO
         Duzw==
X-Gm-Message-State: AOPr4FWVD5WDkKzj6MaMXNYX76qrijGr0G6w+flKQ/7+RudHvEIFx5uFDJdOH6OaUHKRIAlMO+zG51d7O5mWJw==
X-Received: by 10.50.6.15 with SMTP id w15mr16198581igw.91.1462865914170; Tue,
 10 May 2016 00:38:34 -0700 (PDT)
Received: by 10.79.139.4 with HTTP; Tue, 10 May 2016 00:38:34 -0700 (PDT)
In-Reply-To: <1462541720-79553-3-git-send-email-rappazzo@gmail.com>
X-Google-Sender-Auth: dZK5LBog6UldlbAnuBcsiRmEGj8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294113>

On Fri, May 6, 2016 at 9:35 AM, Michael Rappazzo <rappazzo@gmail.com> wrote:
> Executing `git-rev-parse` with `--git-common-dir`, `--git-path <path>`,
> or `--shared-index-path` from the root of the main worktree results in
> a relative path to the git dir.
>
> When executed from a subdirectory of the main tree, it can incorrectly
> return a path which starts 'sub/path/.git'.  Change this to return the
> proper relative path to the git directory.
>
> Related tests marked to expect failure are updated to expect success
>
> Signed-off-by: Michael Rappazzo <rappazzo@gmail.com>
> ---
> diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
> @@ -564,10 +564,13 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
>                 if (!strcmp(arg, "--git-path")) {
> +                       struct strbuf sb = STRBUF_INIT;
>                         if (!argv[i + 1])
>                                 die("--git-path requires an argument");
> -                       puts(git_path("%s", argv[i + 1]));
> -                       i++;
> +
> +                       puts(relative_path(xstrfmt("%s/%s", get_git_dir(), argv[++i]),
> +                               prefix, &sb));

This is leaking the result of xstrfmt().

> +                       strbuf_release(&sb);
>                         continue;
>                 }
> @@ -811,7 +815,12 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
>                                 if (the_index.split_index) {
>                                         const unsigned char *sha1 = the_index.split_index->base_sha1;
> -                                       puts(git_path("sharedindex.%s", sha1_to_hex(sha1)));
> +                                       struct strbuf sb = STRBUF_INIT;
> +
> +                                       puts(relative_path(
> +                                               xstrfmt("%s/sharedindex.%s", get_git_dir(), sha1_to_hex(sha1)),
> +                                               prefix, &sb));

Likewise leaking xstrfmt().

> +                                       strbuf_release(&sb);
>                                 }
>                                 continue;
>                         }
