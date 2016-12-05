Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91CD81FBB0
	for <e@80x24.org>; Mon,  5 Dec 2016 23:54:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752327AbcLEXyt (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Dec 2016 18:54:49 -0500
Received: from mail-qt0-f174.google.com ([209.85.216.174]:33352 "EHLO
        mail-qt0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751501AbcLEXys (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2016 18:54:48 -0500
Received: by mail-qt0-f174.google.com with SMTP id p16so330204121qta.0
        for <git@vger.kernel.org>; Mon, 05 Dec 2016 15:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=YbwI77Luf21xMEaLSOT1YZlEJdVDz9jOsvt3k0Hd3Ho=;
        b=V/1BwD+5exoRwF69+7dtDqKZJAM5/BSXpiSArPoqEugTarpRhX6zjABj02NXXy5gUg
         X0d/ZzNqXjqF5S90TaYhjN8Owi2wHECy5Ex+RTDJpL7Eky0bY5Rt2/4LmOC8qxY94WOo
         DHw6aJWdZUwWMPi7T20srYTtEIN4acOqdaikOS2Q8fCi3n/zfcwhS8Vx4cOyR0TJlsrl
         hkXjHvBw5X/5RYSnGVZyDDIc8YxtrVibdovIom9C+zJ/P/5EN4vPRtsESHdYSzcJeBlp
         EM3smPOd1UFkOYJ56Cg1OCZAzFTRdHgGPf5aW6FLNe2U9uCmZOwyOiyQ22Uue4X2yE9q
         JfVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=YbwI77Luf21xMEaLSOT1YZlEJdVDz9jOsvt3k0Hd3Ho=;
        b=SQ3/rnds2AdwpGDC7vetoEu9QrmHMZJ6+OJDtnfZYsrZlSZOoE0bzFF4FjyFrAZhLq
         bFDIaURojh2cRiRdSJMkQj+umTfIQEbD7abF0cDDbmBrvU/w/R0gsyMQvaFmUQzMCA5q
         2jmbuRiMRnpziuYFFM1uXEZ8D9sCjed5aUUeuFCKQ/v2lAQYAQGbUHtFvWQ/7r26L7VK
         QfuFu25wvVeJ8IywFwRXGnQucEbBGcciFkb2gTzTXK5wC6sqH9HbM1xY+o5mBk4f66CR
         WUlV6QlrI0N/NIDr/hZ0jUtKYmT/BvSuY33o/PZL372HhkfDlS8vrj+//f8uMJ5eu7mZ
         0VeA==
X-Gm-Message-State: AKaTC02tdE3aHD2hOI1NfOCObzs+YaENc9e440kE+CDcDasK0QybNSQ0YnHDtU/4TKnJAUPbrZvfSYyhgaZD2H0A
X-Received: by 10.200.37.221 with SMTP id f29mr58087549qtf.123.1480982087638;
 Mon, 05 Dec 2016 15:54:47 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.147.188 with HTTP; Mon, 5 Dec 2016 15:54:47 -0800 (PST)
In-Reply-To: <f19844d15ab4424b8c056cd13837d233@exmbdft7.ad.twosigma.com>
References: <20161203003022.29797-1-sbeller@google.com> <20161203003022.29797-10-sbeller@google.com>
 <f19844d15ab4424b8c056cd13837d233@exmbdft7.ad.twosigma.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 5 Dec 2016 15:54:47 -0800
Message-ID: <CAGZ79kbbNHL8VQEztcHOea0yoawaitEvoFm6BWt-xi9Uq+8Qqw@mail.gmail.com>
Subject: Re: [RFC PATCHv2 09/17] update submodules: add scheduling to update submodules
To:     David Turner <David.Turner@twosigma.com>
Cc:     "bmwill@google.com" <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "sandals@crustytoothpaste.net" <sandals@crustytoothpaste.net>,
        "hvoigt@hvoigt.net" <hvoigt@hvoigt.net>,
        "gitster@pobox.com" <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 5, 2016 at 3:37 PM, David Turner <David.Turner@twosigma.com> wrote:
> This patch confuses me -- see below.
>
>> -----Original Message-----
>> From: Stefan Beller [mailto:sbeller@google.com]
>> Sent: Friday, December 02, 2016 7:30 PM
>> To: bmwill@google.com; David Turner
>> Cc: git@vger.kernel.org; sandals@crustytoothpaste.net; hvoigt@hvoigt.net;
>> gitster@pobox.com; Stefan Beller
>> Subject: [RFC PATCHv2 09/17] update submodules: add scheduling to update
>> submodules
> [snip]
>> +static int update_submodule(const char *path, const struct object_id
>> *oid,
>> +                         int force, int is_new)
>> +{
>> +     const char *git_dir;
>> +     struct child_process cp = CHILD_PROCESS_INIT;
>> +     const struct submodule *sub = submodule_from_path(null_sha1, path);
>> +
>> +     if (!sub || !sub->name)
>> +             return -1;
>> +
>> +     git_dir = resolve_gitdir(git_common_path("modules/%s", sub->name));
>> +
>> +     if (!git_dir)
>> +             return -1;
>> +
>> +     if (is_new)
>> +             connect_work_tree_and_git_dir(path, git_dir);
>> +
>> +     /* update index via `read-tree --reset sha1` */
>> +     argv_array_pushl(&cp.args, "read-tree",
>> +                                force ? "--reset" : "-m",
>> +                                "-u", sha1_to_hex(oid->hash), NULL);
>> +     prepare_submodule_repo_env(&cp.env_array);
>> +     cp.git_cmd = 1;
>> +     cp.no_stdin = 1;
>> +     cp.dir = path;
>> +     if (run_command(&cp)) {
>> +             warning(_("reading the index in submodule '%s' failed"),
>> path);
>
> The error is not (usually) in "reading the index" -- it's "updating the index" (or the working tree)
>
>> +             child_process_clear(&cp);
>> +             return -1;
>> +     }
>> +
>> +     /* write index to working dir */
>> +     child_process_clear(&cp);
>> +     child_process_init(&cp);
>> +     argv_array_pushl(&cp.args, "checkout-index", "-a", NULL);
>
> I'm confused -- doesn't read-tree -u already do this?  And if not, shouldn't we back out the result of the read-tree, to leave the submodule as it was?
>
>> +     cp.git_cmd = 1;
>> +     cp.no_stdin = 1;
>> +     cp.dir = path;
>> +     if (force)
>> +             argv_array_push(&cp.args, "-f");
>> +
>> +     if (run_command(&cp)) {
>> +             warning(_("populating the working directory in submodule '%s'
>> failed"), path);
>> +             child_process_clear(&cp);
>> +             return -1;
>> +     }
>> +
>> +     /* get the HEAD right */
>> +     child_process_clear(&cp);
>> +     child_process_init(&cp);
>> +     argv_array_pushl(&cp.args, "checkout", "--recurse-submodules",
>> NULL);
>
>
> Why are we running checkout on the submodule when we've already done most of the checkout? The only thing left is to set HEAD and recurse, right?  I must be missing something.
>

Yes this is only used to set the HEAD correctly and then recurse down.
I tried to remove the first 2 calls to ch8ild processes at one point in time,
which did not work out.  I should have written in the commit message why
that was a problem. So I'll redo that just to see the problem and improve
the commit message.
