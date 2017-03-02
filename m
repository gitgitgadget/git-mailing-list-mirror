Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E410D1F5FB
	for <e@80x24.org>; Thu,  2 Mar 2017 13:15:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753008AbdCBNPq (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Mar 2017 08:15:46 -0500
Received: from mail-ot0-f172.google.com ([74.125.82.172]:32927 "EHLO
        mail-ot0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752883AbdCBNPd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Mar 2017 08:15:33 -0500
Received: by mail-ot0-f172.google.com with SMTP id k4so51495775otc.0
        for <git@vger.kernel.org>; Thu, 02 Mar 2017 05:15:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=TXtuAPeMbtOiDMS0Bcx/iXhVDJYQgUh0/Sq0VLYBn2w=;
        b=m4hCYpE6eG8UCyYtyKI0oGqfcUErND0yKjkNWpt2nsqKeD14ew7baNE1926LA16L3U
         yu8/MgSpcPS2JFp1mKphkBqHKstp+mToCRM8hH48CmGVM1ViZuhuzqv14b+yV3lbFmUQ
         1D9mXY/wYPTmgXRK7OhKVmWjwqoFgd+l3YqM7229R2mWHw1D5E+Z4VXj/0sUk1e2L3/v
         YHxvYAPBSqFZLOOIutZXtWQ2J6rwGdJ39NqhhYPbcE4AHAhsBytq1uanNEWPbwm203tQ
         +vZW+LFDFc82Itbj1NDITcyQFtsmp2t3e54GQXvWNji5zQl8g9eqqfy7MWL4aFMoFdVq
         glaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=TXtuAPeMbtOiDMS0Bcx/iXhVDJYQgUh0/Sq0VLYBn2w=;
        b=EGXWmT3NxnoGLjx9kAzoUrM87a6CZ4YrwqBaKUe9AoATEhiPzIwmVv50rHrD1KTQ6Z
         x1ARYrf8VFUHmYfhdO29Y4CBy/a43Sbwn4s6ntjq5Ssr0qiwLUfAD4r6Frtb3kA0kWEQ
         X7t3iS4Op8C00t0RF2LvcXWknx8UhTNfHCdEZ5KZ5k5rF7c+RyeTZJUFt3rHZmUgg1yz
         40NWjWuypWoXlc+OEMee8ZO0rp9LTL1xpL+gjlg0kZR1Vs8VR8O/LFJVeKZPoyVe7M9D
         jyzvNPGU/I54e1OwsGYIA6yLmJDVT+JVLGpyIsiIPtEBfrh5LuLvxM6PtgHA4tFwLNc2
         2Wfg==
X-Gm-Message-State: AMke39nv8GrzZcA5KTCV1NPBNa5qHWoFDlBhhnN9u9+uYi8rXVyXI8mngYBcRlnXHsmYuW+2eer/RciSTVRXJA==
X-Received: by 10.157.36.225 with SMTP id z88mr6416589ota.271.1488460063695;
 Thu, 02 Mar 2017 05:07:43 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.158.84 with HTTP; Thu, 2 Mar 2017 05:07:13 -0800 (PST)
In-Reply-To: <cb86192d-8644-bed3-1e73-821931589e79@alum.mit.edu>
References: <20170218133303.3682-1-pclouds@gmail.com> <20170222140450.30886-1-pclouds@gmail.com>
 <20170222140450.30886-6-pclouds@gmail.com> <cb86192d-8644-bed3-1e73-821931589e79@alum.mit.edu>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 2 Mar 2017 20:07:13 +0700
Message-ID: <CACsJy8AoZt-po5R7+1qPBqTzJ6aiVkKif9Lyp9y0ZwRM09Tj-Q@mail.gmail.com>
Subject: Re: [PATCH v5 05/24] files-backend: move "logs/" out of TMP_RENAMED_LOG
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>,
        David Turner <novalis@novalis.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 1, 2017 at 12:19 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> @@ -2513,7 +2513,7 @@ static int files_delete_refs(struct ref_store *ref_store,
>>   * IOW, to avoid cross device rename errors, the temporary renamed log must
>>   * live into logs/refs.
>>   */
>> -#define TMP_RENAMED_LOG  "logs/refs/.tmp-renamed-log"
>> +#define TMP_RENAMED_LOG  "refs/.tmp-renamed-log"
>
> The constant name feels a little bit misleading now that it is not the
> name of a logfile but rather a reference name. OTOH "tmp-renamed-log" is
> *in* the reference name so I guess it's not really wrong.

Heh.. I had a similar internal debate and almost renamed it to
tmp_renamed_refname. But then it's technically not a valid ref name
either (starting with a leading dot). My lazy side came in and
declared that doing nothing was always the right way.

>>  struct rename_cb {
>>       const char *tmp_renamed_log;
>> @@ -2549,7 +2549,7 @@ static int rename_tmp_log(const char *newrefname)
>>       int ret;
>>
>>       strbuf_git_path(&path, "logs/%s", newrefname);
>> -     strbuf_git_path(&tmp, TMP_RENAMED_LOG);
>> +     strbuf_git_path(&tmp, "logs/%s", TMP_RENAMED_LOG);
>>       cb.tmp_renamed_log = tmp.buf;
>>       ret = raceproof_create_file(path.buf, rename_tmp_log_callback, &cb);
>>       if (ret) {
>> @@ -2626,12 +2626,12 @@ static int files_rename_ref(struct ref_store *ref_store,
>>               return 1;
>>
>>       strbuf_git_path(&sb_oldref, "logs/%s", oldrefname);
>> -     strbuf_git_path(&tmp_renamed_log, TMP_RENAMED_LOG);
>> +     strbuf_git_path(&tmp_renamed_log, "logs/%s", TMP_RENAMED_LOG);
>>       ret = log && rename(sb_oldref.buf, tmp_renamed_log.buf);
>>       strbuf_release(&sb_oldref);
>>       strbuf_release(&tmp_renamed_log);
>>       if (ret)
>> -             return error("unable to move logfile logs/%s to "TMP_RENAMED_LOG": %s",
>> +             return error("unable to move logfile logs/%s to logs/"TMP_RENAMED_LOG": %s",
>>                       oldrefname, strerror(errno));
>
> It seems like it would be preferable to use `sb_oldref.buf` and
> `tmp.buf` when building the error message. But I guess that `tmp.buf`
> might include some path preceding "logs/" that is unwanted in the error
> message? But it's a shame to hardcode the file naming scheme here again.
>
> Maybe we *do* want the path in the error message?

It's an error, every piece of details matters. So yeah I'm inclined we
should print full path.

> It just occurred to me: this temporary logfile lives in the main
> repository, right? What if a worktree reference is being renamed? Part
> of the advertised use of worktrees is that the worktree might live far
> from the main directory, or even on removable media. But it's not
> possible to rename files across partitions. Maybe this will come out in
> the wash once worktrees are ref_stores themselves.

The actual working directory may be separated, but all the things that
belong to .git (even of a linked worktree) stay in the main worktree's
.git directory. And I don't think we ever support having a .git
directory on multiple partitions. You can rename refs freely even when
the worktree is on a detached removable drive.

> For that matter, what if a user tries to rename a worktree ref into a
> common ref or vice versa?

Interesting. It should work, it's just a
rename(".git/worktrees/blah/refs/bisect/good",
".git/refs/heads/saved") after the path translation done by
git_path().
-- 
Duy
