From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH 4/4] bisect--helper: `bisect_reset` shell function in C
Date: Wed, 8 Jun 2016 18:50:52 +0530
Message-ID: <CAFZEwPPC3WZR4dMphgZWK7UomAXEok-J8ZXvFR22+xDrFP=hEg@mail.gmail.com>
References: <20160607205454.22576-1-pranit.bauva@gmail.com>
 <20160607205454.22576-4-pranit.bauva@gmail.com> <CAPig+cSsMg5HznWGiUsngpHskSDMNhauvVw5jvaJTtEtJBw+ew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Lars Schneider <larsxschneider@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 15:21:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAdPq-0006r5-6Q
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jun 2016 15:21:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753635AbcFHNU4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2016 09:20:56 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:34745 "EHLO
	mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753188AbcFHNUy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2016 09:20:54 -0400
Received: by mail-yw0-f193.google.com with SMTP id j74so908886ywg.1
        for <git@vger.kernel.org>; Wed, 08 Jun 2016 06:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=sXYeOJamiEsiQCEp7tIJaKIZEjgA+FxNo1yfa8YXWEk=;
        b=bx8+P13U44upBZLs9vAWWKyGtjRwIlSE20w+OdP11Hnq3QNhAfSKKMwJeMXSHpQIgE
         e4hoolgqA57dYGCA//x79Lzsojumojxgcmndy7Fe7n+vWTafL3OmTeQannVBIBUY3p4V
         ZwIa26598Zja9WHU3qhPr+LkmB8yAa0NdAJRVND9+Izy18G+YYKVuGLiVrF6Yw+2ajq/
         xv+YSHoSFy5TXRk3Jkmo4jNLVzV0EfmY0LfPFyxBhI1T209lgCGe0+RH20nDatD/Quj4
         VkGwpIZHLxytUvot/CoQQ8t6xfSQ47vVqVtjLnOzbvZq9pG8uuY6uSiKLlD48mhfe4/5
         YZTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=sXYeOJamiEsiQCEp7tIJaKIZEjgA+FxNo1yfa8YXWEk=;
        b=ZwJbg7yVSawyBTGbH1TTkeuuS8ty9hDyw2aNhyJE9ZRqQX79PqLjkEvdvJM0njueML
         I2bPCCTLDYYHZGmwCHI6VeSgkftl/iIyn11mz1g7OpxRQugFJoyIDJC7eaS4WEDCMa98
         0x/ADtFcEfnTht2kWCAnM2kmQiZOF8Kqz7B6W0uCdsC/g+FJSaOqME6lYTvY2YlUTeN9
         eHjYsWPrhLtvbd2PL9CJElGH0V9QVwVfYE6dueZGZSvA5BrQWba2J1yKSWpbmSnaRV6k
         +4fm2353VW3+aFSmEoCeTTHEAwo84x4imA/p09+bORKukGXyan/0hTsAcVmGph2G9YmR
         uFcQ==
X-Gm-Message-State: ALyK8tJMbFR4wToUDWF8UVu28VvXh/FKOpFdLZ3uv4i2fnhtAUdJAV3iAIby0bJpR3WANLiuET9vn/pyLcVOjg==
X-Received: by 10.129.81.87 with SMTP id f84mr2519013ywb.154.1465392053259;
 Wed, 08 Jun 2016 06:20:53 -0700 (PDT)
Received: by 10.129.124.132 with HTTP; Wed, 8 Jun 2016 06:20:52 -0700 (PDT)
In-Reply-To: <CAPig+cSsMg5HznWGiUsngpHskSDMNhauvVw5jvaJTtEtJBw+ew@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296797>

Hey Eric,

On Wed, Jun 8, 2016 at 1:29 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Tue, Jun 7, 2016 at 4:54 PM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>> Reimplement `bisect_reset` shell function in C and add a `--bisect-reset`
>> subcommand to `git bisect--helper` to call it from git-bisect.sh .
>>
>> Using `bisect_reset` subcommand is a temporary measure to port shell
>> functions to C so as to use the existing test suite. As more functions
>> are ported, this subcommand would be retired and will be called by some
>> other method.
>>
>> Note: --bisect-clean-state subcommand has not been retired as there are
>> still a function namely `bisect_start()` which still uses this
>> subcommand.
>>
>> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
>> ---
>> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
>> @@ -118,12 +122,51 @@ int bisect_clean_state(void)
>> +int bisect_reset(const char *commit)
>
> s/^/static/
>
>> +{
>> +       struct strbuf branch = STRBUF_INIT;
>> +       int status = 0;
>> +
>> +       if (file_size(git_path_bisect_start()) < 1) {
>
> This doesn't even care about the size of the file, only if it
> encountered an error while stat()'ing it. Why not just use
> file_exists() instead (which you already use elsewhere in this
> function)? Alternately, if you're trying to be faithful to the shell
> code, then you *do* need to check that the file has non-zero size
> before issuing the "not bisecting" diagnostic, so:
>
>     if (file_size(git_path_bisect_start()) <= 0)
>         printf("... not bisecting ...");

Umm, I think that for all x belonging to integers,
            x <= 0    <=>      x < 1

> A different approach would be to invoke strbuf_read_file()
> unconditionally, rather than performing this separate check. If
> strbuf_read_file() returns -1, then the file didn't exist or couldn't
> be read; if it returns 0, then the file has no content:

strbuf_read_file() opens the file and then reads its contents. Well
this much of computation isn't really required. By using stat we can
get the file size without actually reading the file. Are there any
benefits which I have missed of using strbuf_read_file() over stat() ?

>     if (strbuf_read_file(&branch, ..., 0) <= 0)
>         printf("... not bisecting ...");
>
>> +               printf("We are not bisecting.\n");
>> +               return 0;
>> +       }
>> +
>> +       if (!commit) {
>> +               strbuf_read_file(&branch, git_path_bisect_start(), 0);
>
> Shouldn't you be checking the return value of strbuf_read_file()?

The shell script didn't report any error but I guess this doesn't have
to continue. Its probably better to add error handling code while
rewriting.

>> +               strbuf_rtrim(&branch);
>> +       } else {
>> +               struct object_id oid;
>> +               if (get_oid(commit, &oid))
>> +                       return error(_("'%s' is not a valid commit"), commit);
>> +               strbuf_addf(&branch, "%s", commit);
>> +       }
>> +
>> +       if (!file_exists(git_path_bisect_head())) {
>> +               struct argv_array argv = ARGV_ARRAY_INIT;
>> +               argv_array_pushl(&argv, "checkout", branch.buf, "--", NULL);
>> +               status = run_command_v_opt(argv.argv, RUN_GIT_CMD);
>> +               argv_array_clear(&argv);
>> +       }
>> +
>> +       if (status) {
>
> What's the purpose of having this 'status' conditional outside of the
> above !file_exists() conditional, which is the only place that
> 'status' gets assigned. Likewise, 'status' itself could be declared
> within the scope of that conditional block.

I wanted to avoid nesting. In a few other parts of the code also,
nesting is avoided as much as possible.

>> +               error(_("Could not check out original HEAD '%s'. "
>> +                               "Try 'git bisect reset <commit>'."), branch.buf);
>> +               strbuf_release(&branch);
>> +               return -1;
>> +       }
>> +
>> +       strbuf_release(&branch);
>> +       return bisect_clean_state();
>> +}

Regards,
Pranit Bauva
