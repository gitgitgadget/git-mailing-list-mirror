From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] git: submodule honor -c credential.* from command line
Date: Wed, 24 Feb 2016 19:27:23 -0500
Message-ID: <CAPig+cROoc+Y-V_6hw6Hx4X9pFGmRjfhpzYGKhswwa=bA5b=+g@mail.gmail.com>
References: <1456358352-28939-1-git-send-email-jacob.e.keller@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Mark Strapetz <marc.strapetz@syntevo.com>,
	Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jacob Keller <jacob.keller@gmail.com>
To: Jacob Keller <jacob.e.keller@intel.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 01:27:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYjmE-00074W-1I
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 01:27:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754188AbcBYA1Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2016 19:27:25 -0500
Received: from mail-vk0-f49.google.com ([209.85.213.49]:34921 "EHLO
	mail-vk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751373AbcBYA1Y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 19:27:24 -0500
Received: by mail-vk0-f49.google.com with SMTP id e6so33354514vkh.2
        for <git@vger.kernel.org>; Wed, 24 Feb 2016 16:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=ajYa3kCB1I1huj8EwgFWpKsMzKjxndnh/o3rXc/Zrp0=;
        b=za8KtoYrfDRlUD5QGz3y2X/wwshXg2Wu/82sKPqIiW9E2VjntchBilIOe8NKFIDYEy
         WPAH9qnyMw0ItrtMJPfKdyUvwnkTchvkSOfu5yeAkp6nTYLHe/VgJmwbfD5+95Xrt1pS
         siG2Z/hqiVbLcfXOqzGNQfsKNgqqdcyfcxc8KYzJsrX9PSoJUSirIKjQO2F5GeOCyhZS
         U2+wClMGc6jiRkl/YiCOB7BtP+U0wHTcYO36Magyr0UqQXLIOG/ceSWczYV6YWiOVQ4R
         f3iCinmNz+uOGyqaTqRAP8J9CiolzqmfApXDr9S/XHiE4L/42WkurEdXR8dGVDqIxqt3
         ldxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=ajYa3kCB1I1huj8EwgFWpKsMzKjxndnh/o3rXc/Zrp0=;
        b=dMdIOcXzp4aGhjWmJ9Zfu8y4iw/dGg+rlOam0srZAIwqy23gIrh6p3HL0v/0Jgyjz/
         lt5dxpuSoIM4cRCXL5JDryl35oF60lpU3IebnsHdkNZKInxNF+l5GgYrG2mM0bROicTi
         a7prqaSqQzcKIHzCJCHJoXHGLQlXbS60EQaQPY7jLggCv0w7vsc5U2TbMj85CFG3mdye
         y4qPN71hO6IX148V6xAXLa7dq4kGyvQn9syi2UWnO5+AcaypsYOGdUPZmGENOxkB2su8
         qR4RUz9+SfXX2FChISzWafGswc8WV8SjADTeN4G7pUODreNONbtyk4md5l2Yue8Abwyd
         OzuA==
X-Gm-Message-State: AG10YOQ2ozWOIlGlo49KblC/JV7ZYIN0bWRFiQRPndRZECl0M2qZ4PV654BwSqCBlzJEKfudbwWPR69UpqfhqA==
X-Received: by 10.31.41.14 with SMTP id p14mr35272183vkp.151.1456360043443;
 Wed, 24 Feb 2016 16:27:23 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Wed, 24 Feb 2016 16:27:23 -0800 (PST)
In-Reply-To: <1456358352-28939-1-git-send-email-jacob.e.keller@intel.com>
X-Google-Sender-Auth: cUDOFWVQTx07RkebA7N9jQfS8Wo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287294>

On Wed, Feb 24, 2016 at 6:59 PM, Jacob Keller <jacob.e.keller@intel.com> wrote:
> Due to the way that the git-submodule code works, it clears all local
> git environment variables before entering submodules. This is normally
> a good thing since we want to clear settings such as GIT_WORKTREE and
> other variables which would affect the operation of submodule commands.
> However, GIT_CONFIG_PARAMETERS is special, and we actually do want to
> preserve these settings. However, we do not want to preserve all
> configuration as many things should be left specific to the parent
> project.
>
> Add a git submodule--helper function, sanitize-config, which shall be
> used to sanitize GIT_CONFIG_PARAMETERS, removing all key/value pairs
> except a small subset that are known to be safe and necessary.
>
> Replace all the calls to clear_local_git_env with a wrapped function
> that filters GIT_CONFIG_PARAMETERS using the new helper and then
> restores it to the filtered subset after clearing the rest of the
> environment.

A few superficial comments below...

> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
> ---
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> @@ -255,6 +255,61 @@ static int module_clone(int argc, const char **argv, const char *prefix)
> +/* Rules to sanitize configuration variables that are Ok to be passed into
> + * submodule operations from the parent project using "-c". Should only
> + * include keys which are both (a) safe and (b) necessary for proper
> + * operation. Right now only "credential.*" fits both criteria.
> + */

Drop the final sentence for a couple reasons:

1. It's merely repeating what the code itself already says, and...
2. It's likely to become outdated when additional variables are added.

Also, style:

    /*
     * Multi-line comment
     * style.
     */

> +int submodule_config_ok(const char *var)
> +{
> +       if (starts_with(var, "credential."))
> +               return 1;
> +       return 0;
> +}
> +
> +int sanitize_submodule_config(const char *var, const char *value, void *data)
> +{
> +       struct strbuf quoted = STRBUF_INIT;
> +       struct strbuf *out = data;
> +
> +       if (submodule_config_ok(var)) {
> +               if (out->len)
> +                       strbuf_addch(out, ' ');
> +
> +               /* combined all the values before we quote them */

Comment repeats what the code already says, thus not terribly useful.

Also: s/combined/combine/

> +               strbuf_addstr(&quoted, var);
> +               strbuf_addch(&quoted, '=');
> +               strbuf_addstr(&quoted, value);

strbuf_addf(&quoted, "%s=%s", var, value);

> +               /* safely quote them for shell use */

Comment repeats what the code already says.

> +               sq_quote_buf(out, quoted.buf);
> +       }
> +       return 0;
> +}
> +
> +static int module_sanitize_config(int argc, const char **argv, const char *prefix)
> +{
> +       struct strbuf sanitized_config = STRBUF_INIT;
> +
> +       struct option module_sanitize_config_options[] = {
> +               OPT_END()
> +       };
> +
> +       const char *const git_submodule_helper_usage[] = {
> +               N_("git submodule--helper sanitize-config"),
> +               NULL
> +       };
> +
> +       argc = parse_options(argc, argv, prefix, module_sanitize_config_options,
> +                            git_submodule_helper_usage, 0);
> +
> +       git_config_from_parameters(sanitize_submodule_config, &sanitized_config);
> +       if (sanitized_config.len)
> +               printf("%s\n", sanitized_config.buf);

Perhaps not a big deal since the program exits immediately after, but you could:

    strbuf_release(&sanitized_config);

> +       return 0;
> +}
> +
> diff --git a/git-submodule.sh b/git-submodule.sh
> @@ -192,6 +192,16 @@ isnumber()
> +# Sanitize the local git environment for use within a submodule. We
> +# can't simply use clear_local_git_env since we want to preserve some
> +# of the settings from GIT_CONFIG_PARAMETERS.
> +sanitize_local_git_env()
> +{
> +       local sanitized_config = $(git submodule--helper sanitize-config)

Is 'local' a bashism? (Although, I see that 'local' is already being
used in relative_path(); perhaps that ought to be cleaned up.)

> +       clear_local_git_env
> +       GIT_CONFIG_PARAMETERS=$sanitized_config
> +}
> diff --git a/t/t7412-submodule--helper.sh b/t/t7412-submodule--helper.sh
> @@ -0,0 +1,25 @@
> +#!/bin/sh
> +#
> +# Copyright (c) 2016 Jacob Keller
> +#
> +
> +test_description='Basic plumbing support of submodule--helper
> +
> +This test tries to verify the submodule--helper plumbing command used

Maybe: s/tries to verify/verifies/

> +to implement git-submodule.
> +'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'sanitize-config clears configuration' '
> +       git -c user.name="Some User" submodule--helper sanitize-config >actual &&
> +       test_must_be_empty actual
> +'
> +
> +test_expect_success 'sanitize-config keeps credential.helper' '
> +       git -c credential.helper="helper" submodule--helper sanitize-config >actual &&
> +       echo "'\''credential.helper=helper'\''" >expect &&
> +       test_cmp expect actual
> +'
> +
> +test_done
