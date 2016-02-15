From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v4 20/21] refs: add LMDB refs storage backend
Date: Mon, 15 Feb 2016 16:57:09 +0700
Message-ID: <CACsJy8AkWpVERj8=ABaQ89xe=6-DRLV5KBz9_sxW8TE4LUzcQw@mail.gmail.com>
References: <1454701462-3817-1-git-send-email-dturner@twopensource.com>
 <1454701462-3817-21-git-send-email-dturner@twopensource.com> <CACsJy8CWS9E0Jb4omm4k0=kZ73w9UoHmofLFCFHUhHu53zfgYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Mon Feb 15 10:57:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVFud-0007or-Gg
	for gcvg-git-2@plane.gmane.org; Mon, 15 Feb 2016 10:57:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752156AbcBOJ5n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2016 04:57:43 -0500
Received: from mail-lb0-f179.google.com ([209.85.217.179]:33900 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752477AbcBOJ5k (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2016 04:57:40 -0500
Received: by mail-lb0-f179.google.com with SMTP id ap4so17384366lbd.1
        for <git@vger.kernel.org>; Mon, 15 Feb 2016 01:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=0znktMXQ1S2tTpKQMSgvNly+CUik6+RB9Owc85ZncEU=;
        b=bSpABRStWnU9LWQLSejXN5XzIXSaBjOKNIWQjix2dB+U+mFgyjeH66m2eC56CmRQps
         5C5yt9wBOFulnQmYQDjZ21J3472suZDqEgoujMFjp3Zr1IG+CFWtvDplRN6pIAiCUT5B
         K1K8bg8gM5wLuxWQ8ZYSTn2e9bMq5E5OOyiWHhX1SSDTDDqjEyotMz0ktzLdBsGPCIg3
         UkeVFkuquwpW70zDIP5h79iyM2wOCeI3UEdo+bliAgS0/V0bs8G8UtPNBmg4ySdJUzrC
         opm6r2GxKmXMSMQ+kYtVwTDRbFtueSywiI9ViJP7sjM5u0YF1cDQVwEOTiwhkZbMyC5W
         cjrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=0znktMXQ1S2tTpKQMSgvNly+CUik6+RB9Owc85ZncEU=;
        b=cRnnSSNXj2DjivXTUjkikB99dYmbmoLg+/oUVWNL6b0qdxz9FCddamo3GHbLuSVrND
         26icSnZakZhYbAHPw3PA7JQUd5Fu4N3hYpYNb5erxgnGRgDJg81Xd+HLwFWBrJ1DRgzM
         eAvJwc0pqjwW2/OCaY2fUVePRhCvSAHyiT8Md6iES31Ml4TFybNN5Og+i6ER1P2pDfPW
         ZESZG6sRgdUq/z5+cQoBpvBazE1TMgdUaJf6nV1mAn1TTuFuKEf637mMoxP08yewyEzv
         iyrkG0w6eEnvwTdyaWTUSyaQxtcRa3YJiTk/ckCkShwDFk+nWFW3GjN+XLXjHICIClEq
         OGYg==
X-Gm-Message-State: AG10YOSNbupTMCPZACBzY+hMPoq6NQV4k/BSN8g65WYWg7QZkEv6XKWI0qMAqmrLkHSBMIKgbuhIoQipO3AbrA==
X-Received: by 10.112.130.41 with SMTP id ob9mr6224140lbb.81.1455530259555;
 Mon, 15 Feb 2016 01:57:39 -0800 (PST)
Received: by 10.112.97.72 with HTTP; Mon, 15 Feb 2016 01:57:09 -0800 (PST)
In-Reply-To: <CACsJy8CWS9E0Jb4omm4k0=kZ73w9UoHmofLFCFHUhHu53zfgYw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286191>

On Sun, Feb 14, 2016 at 7:04 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Sat, Feb 6, 2016 at 2:44 AM, David Turner <dturner@twopensource.com> wrote:
>> +static char *get_refdb_path(const char *base)
>> +{
>> +       static struct strbuf path_buf = STRBUF_INIT;
>> +       strbuf_reset(&path_buf);
>> +       strbuf_addf(&path_buf, "%s/refdb", base);
>> +       return path_buf.buf;
>> +}
> ...
>> +static int lmdb_init_db(struct strbuf *err, int shared)
>> +{
>> +       /*
>> +        * To create a db, all we need to do is make a directory for
>> +        * it to live in; lmdb will do the rest.
>> +        */
>> +
>> +       if (!db_path)
>> +               db_path = xstrdup(real_path(get_refdb_path(get_git_common_dir())));
>
> This works for multiple worktrees. But scripts may have harder time
> getting the path. The recommended way is "git rev-parse --git-path
> refdb" but because "refdb" is not registered in path.c:common_list[],
> that command becomes git_path("refdb") instead of
> get_refdb(get_git_... like here. And I will need to know that
> .git/refdb is _not_ per-worktree when I migrate/convert main worktree
> (it's very likely I have to go that route to solve .git/config issue
> in multi worktree).
>
> The solution is register refdb to common_list[] and you can do
> git_path("refdb") here. But then what happens when another backend is
> added? Will the new backend use the same path "refdb", or say
> "refdb.sqlite"? If all backends share the name "refdb", why can't we
> just reuse "refs" instead because the default filesystem-based backend
> is technically just another backend?

To answer myself: I forgot that there were per-worktree refs (e.g.
refs/bisect). It makes me wonder if we should put per-worktree refs to
lmdb as well (maybe one per worktree if we don't want to put all in
one db). One of the advantages of moving away from fs-based backend is
the ability to deal with case sensitivity, "nested" refs (e.g. a/b and
a/b/c are both refs). With this split, I think some refs are still
left behind.. Sorry if this was discussed before, I haven't followed
this closely.
-- 
Duy
