Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A9402022A
	for <e@80x24.org>; Tue,  8 Nov 2016 01:12:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751662AbcKHBMq (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Nov 2016 20:12:46 -0500
Received: from mail-qt0-f172.google.com ([209.85.216.172]:33746 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751074AbcKHBMp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2016 20:12:45 -0500
Received: by mail-qt0-f172.google.com with SMTP id p16so98631595qta.0
        for <git@vger.kernel.org>; Mon, 07 Nov 2016 17:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=vFNu75QiCWpmqrRKzGKOZukdDVjBfrtW55qtH4WEz74=;
        b=o/Y4eVAxz16SqRuAZkCTnk7qUUY5bzXWtiwxWmtYRlRNLQEvzAFCLGNoLR3suHP36j
         CBq7a3k/Xh/L505EmKBtbWTYC6C/B2yJzOMco2TGUqt/0h6YlXF3WfGamnQseXaKOsmK
         2SDsdtoBMgIwLXApbPt9G3taXMG6nWT+HQmiCsrYYch1JxYPU6P59PwjL3b3wej28Jyp
         f/B8sHNFgdSsyoohQVgYNQtQ5X/yHGi2CJbxiafduwJYUlRhqEFd3MQJAlKhANv6vCyu
         hKzbKvT0/FWwY14N8vpOLJHhzn3LfzjgPG+cAy0m6y8Isno4/uv1p6LnmR08zpTTrBPh
         vq8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=vFNu75QiCWpmqrRKzGKOZukdDVjBfrtW55qtH4WEz74=;
        b=kc1PUPH73mh0JDgzpIXlds7NvpMuJ+AnSysXYr2UfD9YuQigxPdAs5fnt5FPWXqznR
         +R+Tq8XEDKdGEEjUq6TYD5ylmbULklZ4pYwjBDGvQAfeU731DoggIR8ZOdkwy3wPdTuT
         viGFEp413WAKMxqYq4S7W7yLxxiSumNMbZ5L/gJEtFI5OW3Uc091ZGlMkO7+Z7tSH8Et
         M5m21gUPbuzukGeBJkXkJcw3GYV78BwMA2+o7kxBHWrEzAx/ytIG35kb416YgeFvrID3
         H/eoKL/0tOVY3c4ICSbJLrlpSD4gx00o0UzyWF7o3L4qETvPkwn7o6BSjWWgCwLAIDsE
         lPUw==
X-Gm-Message-State: ABUngvcbgBiYXvDT3UFur2ZwiA/m7V14DspkXaj0qzxd0xaDSqC/mVnNDhGV/M7m3hJbpLaHFjtJuuJEOaeaDHJH
X-Received: by 10.200.53.53 with SMTP id y50mr9860580qtb.127.1478567563973;
 Mon, 07 Nov 2016 17:12:43 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.34.175 with HTTP; Mon, 7 Nov 2016 17:12:43 -0800 (PST)
In-Reply-To: <20161108003034.apydvv3bav3s7ehq@sigill.intra.peff.net>
References: <20161003203321.rj5jepviwo57uhqw@sigill.intra.peff.net>
 <20161003203417.izcgwt4yz3yspdnm@sigill.intra.peff.net> <CAGyf7-HWAMF8S+Bw3wcwJCS1Subc28KHjpSCc1__0qn-GSMyvA@mail.gmail.com>
 <20161108003034.apydvv3bav3s7ehq@sigill.intra.peff.net>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Mon, 7 Nov 2016 17:12:43 -0800
Message-ID: <CAGyf7-FYvUgvOZm0xvFAJx=8hSc4ji=YQ5dUm3B1unU_WOcjeQ@mail.gmail.com>
Subject: Re: [PATCH 07/18] link_alt_odb_entry: handle normalize_path errors
To:     Jeff King <peff@peff.net>
Cc:     Git Users <git@vger.kernel.org>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 7, 2016 at 4:30 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Nov 07, 2016 at 03:42:35PM -0800, Bryan Turner wrote:
>
>> > @@ -335,7 +340,9 @@ static void link_alt_odb_entries(const char *alt, int len, int sep,
>> >         }
>> >
>> >         strbuf_add_absolute_path(&objdirbuf, get_object_directory());
>> > -       normalize_path_copy(objdirbuf.buf, objdirbuf.buf);
>> > +       if (strbuf_normalize_path(&objdirbuf) < 0)
>> > +               die("unable to normalize object directory: %s",
>> > +                   objdirbuf.buf);
>>
>> This appears to break the ability to use a relative alternate via an
>> environment variable, since normalize_path_copy_len is explicitly
>> documented "Returns failure (non-zero) if a ".." component appears as
>> first path"
>
> That shouldn't happen, though, because the path we are normalizing has
> been converted to an absolute path via strbuf_add_absolute_path. IOW, if
> your relative path is "../../../foo", we should be feeding something
> like "/path/to/repo/.git/objects/../../../foo" and normalizing that to
> "/path/to/foo".
>
> But in your example, you see:
>
>   error: unable to normalize alternate object path: ../0/objects
>
> which cannot come from the code above, which calls die(). It should be
> coming from the call in link_alt_odb_entry().

Ah, of course. I should have looked more closely at the call.

<snip>

> No, I had no intention of disallowing relative alternates (and as you
> noticed, a commit from the same series actually expands the use of
> relative alternates). My use has been entirely within info/alternates
> files, though, not via the environment.
>
> As I said, I'm not sure this was ever meant to work, but as far as I can
> tell it mostly _has_ worked, modulo some quirks. So I think we should
> consider it a regression for it to stop working in v2.11.
>
> The obvious solution is one of:
>
>   1. Stop calling normalize() at all when we do not have a relative base
>      and the path is not absolute. This restores the original quirky
>      behavior (plus makes the "foo/../../bar" case work).
>
>      If we want to do the minimum before releasing v2.11, it would be
>      that. I'm not sure it leaves things in a very sane state, but at
>      least v2.11 does no harm, and anybody who cares can build saner
>      semantics for v2.12.
>
>   2. Fix it for real. Pass a real relative_base when linking from the
>      environment. The question is: what is the correct relative base? I
>      suppose "getcwd() at the time we prepare the alt odb" is
>      reasonable, and would behave similarly to older versions ($GIT_DIR
>      for bare repos, top of the working tree otherwise).
>
>      If we were designing from scratch, I think saner semantics would
>      probably be always relative from $GIT_DIR, or even always relative
>      from the object directory (i.e., behave as if the paths were given
>      in objects/info/alternates). But that breaks compatibility with
>      older versions. If we are treating this as a regression, it is not
>      very friendly to say "you are still broken, but you might just need
>      to add an extra '..' to your path".
>
> So I dunno. I guess that inclines me towards (1), as it lets us punt on
> the harder question.

Is there anything I can do to help? I'm happy to test out changes.
I've got a set of ~1,040 tests that verify all sorts of different Git
behaviors (those tests flagged this change, for example, and found a
regression in git diff-tree in 2.0.2/2.0.3, among other things). I run
them on the "newest" patch release for every feature-bearing line of
Git from 1.8.x up to 2.10 (currently 1.8.0.3, 1.8.1.5, 1.8.2.3,
1.8.3.4, 1.8.4.5, 1.8.5.6, 1.9.5, 2.0.5, 2.1.4, 2.2.3, 2.3.10, 2.4.11,
2.5.5, 2.6.6, 2.7.4, 2.8.4, 2.9.3 and 2.10.2), and I add in RCs of new
as soon as they become available. (I also test Git for Windows; at the
moment I've got 1.8.0, 1.8.1.2, 1.8.3, 1.8.4, 1.8.5.2 and 1.9.5.1 from
msysgit and 2.3.7.1, 2.4.6, 2.5.3, 2.6.4, 2.7.4, 2.8.4, 2.9.3 and
2.10.2 from Git for Windows. 2.11.0-rc0 on Windows passes my test
suite; it looks like it's not tagging the same git/git commit as
v2.11.0-rc0 is.) I wish there was an easy way for me to open this up.
At the moment, it's something I can really only run in-house, as it
were.

At the moment I have limited ability to actually try to submit patches
myself. I really need to sit down and setup a working development
environment for Git. (My current dream, if I could get such an
environment running, is to follow up on your git blame-tree work.

>
> -Peff
