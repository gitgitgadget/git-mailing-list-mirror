From: Stefan Zager <szager@chromium.org>
Subject: Re: Make the git codebase thread-safe
Date: Wed, 12 Feb 2014 12:27:50 -0800
Message-ID: <CAHOQ7J8Q1905pVwx9QVib1BM-Xxg8vTL=hDUjT7garX++VXm3g@mail.gmail.com>
References: <CA+TurHgyUK5sfCKrK+3xY8AeOg0t66vEvFxX=JiA9wXww7eZXQ@mail.gmail.com>
	<CACsJy8Bsc6sywL9L5QC-SKKmh9J+CKnoG5i78WfUbAG9BdZ8Rw@mail.gmail.com>
	<CAHOQ7J8gvwpwJV2mBPDaARu3cQ54-ZDQ6iGOwKuJRr9Z+XBL7g@mail.gmail.com>
	<xmqqr478m6xx.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Zager <szager@chromium.org>, Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 12 21:27:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WDgPU-0006Al-L0
	for gcvg-git-2@plane.gmane.org; Wed, 12 Feb 2014 21:27:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753658AbaBLU1w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Feb 2014 15:27:52 -0500
Received: from mail-oa0-f41.google.com ([209.85.219.41]:61127 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752916AbaBLU1v (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Feb 2014 15:27:51 -0500
Received: by mail-oa0-f41.google.com with SMTP id j17so11673911oag.28
        for <git@vger.kernel.org>; Wed, 12 Feb 2014 12:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=samgtdE6LfvlEvEQliEMstnduIZ08pyl7YvsZ7fnJ70=;
        b=VnTIZUv0Yy4EH+FNdy41YekyeUzqBTT5AkAzsqB7sPBA7ymJbiIXJXD6f1U06VLIBI
         HcfQh8nktdBu0q2+cvLl2bA3eZckF9R2Wx8snzunJUnMvoY4G58gY140oWFgnFSPMnI+
         cJLns9fqYi2Odn+6n0udF8VVtLWauttrLGdE9/4hcCXV8aK6g0z3vuf1bKdUUa5TaR/h
         Y2oKNWNyptXfPNgJfL7chQQbDdNwETCNX5JQePwpUt2FjRBQvm1HQktj9iGzbHQtOTEw
         cjonIYr9c62Efe90zHJtKAsrWFo+/6upbAv5FwYu9lUypKnyOC0VY1gU68r8fhDszAuk
         4aPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=samgtdE6LfvlEvEQliEMstnduIZ08pyl7YvsZ7fnJ70=;
        b=MmyY7rrVrVoDrjMgrmxYpGegZweFLkMnxBG0DFLM2dUdUdMAdNSf7oed7QQerO7YAQ
         rz+67CK33iAzvQJungvEeWVVBz5/jDrlPwTipvGQKuS8DagCStJsWnZm5VqzIeU7vgS8
         CnTrqRoMNBmHPSVuzFnKrnGPgmLTa+m8AeQ9o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=samgtdE6LfvlEvEQliEMstnduIZ08pyl7YvsZ7fnJ70=;
        b=QDZqpHOIUPhUQzGIhMH3inMvRMkdTO1eiwhugZ8Hl2Cw3IXAFZZ4Ve8Z6++vucOu/6
         8OGE/eg1T+WtsXrMIlWErWOQha8sSuVQMlqq/E5U8jDh5b6vjlfFDckapVDXuG/dnEp7
         0CEjjMjs97F0aFVPW4O1M2PcNehgG1MXvpN/6v0rGeuo18x0NmlZqf6LmcZMTNbj0aOR
         F2jctkJQI5tgcTj9BixKtbTZn2tsYkX4Qy3ZffMlGQHSDaZ+40TWKZR9JxvabitZrBvk
         RfljlCyxLXbsZhuipKCV5NDFk/G0yqnO67uaiRtM9LgptSWu2uGjV/OyCovhCmfOphax
         NKeg==
X-Gm-Message-State: ALoCoQniXa5gvsRgjXlwAcUrRLphE5xmsCM7KrkS6tnWoWMGexO7QvNHKku0+zwqgW3qaQnpo+glFj+xoHGvvHJQtqY0yo9HZKWTS6ib+4cX8aTxYLIN6E/xXpzkMNcdOK5XX3ujrccYW17L8BKTj3zXlzCM94bqd4ovrwZcYHnXx9UWat8aY+a7xWh40QFpGBUKBZX1BDES
X-Received: by 10.60.123.10 with SMTP id lw10mr39164232oeb.24.1392236870859;
 Wed, 12 Feb 2014 12:27:50 -0800 (PST)
Received: by 10.182.233.201 with HTTP; Wed, 12 Feb 2014 12:27:50 -0800 (PST)
In-Reply-To: <xmqqr478m6xx.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: 1mFh3sFphVULWjdhkgum9ix4c7M
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242021>

On Wed, Feb 12, 2014 at 12:06 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Zager <szager@chromium.org> writes:
>
>> ...  I used the Very Sleepy profiler
>> to see where all the time was spent on Windows: 55% of the time was
>> spent in OpenFile, and 25% in CloseFile (both in win32).
>
> This is somewhat interesting.
>
> When we check things out, checkout_paths() has a list of paths to be
> checked out, and iterates over them and call checkout_entry().
>
> I wonder if you can:
>
>  - introduce a version of checkout_entry() that takes file
>    descriptors to write to;
>
>  - have an asynchronous helper threads that pre-open the paths to be
>    written out and feed <ce, file descriptor to be written> to a
>    queue;
>
>  - restructure that loop so that it reads the <ce, file descriptor
>    to be written> from the queue, performs the actual writing out,
>    and then feeds <file descriptor to be closed> to another queue; and
>
>  - have another asynchronous helper threads that reads <file
>    descriptor to be closed> from the queue and close them.
>
> Calls to write (and preparation of data to be written) will then
> remain single-threaded, but it sounds like that codepath is not the
> bottleneck in your measurement, so....

Yes, I considered that as well.  At a minimum, that would still
require attr.c to implement thread locking, since attribute files must
be parsed to look for stream filters.  I have already done that work.

But I'm not sure it's the best long-term approach to add convoluted
custom threading solutions to each git operation as it appears on the
performance radar.  I'm hoping to make the entire code base more
thread-friendly, so that threading can be added in a more natural and
idiomatic (and less painful) way.

For example, the most natural way to add threading to checkout would
be in the loops over the index in check_updates() in unpack-trees.c.
If attr.c and sha1_file.c were thread-safe, then it would be possible
to thread checkout entirely in check_updates(), with a pretty compact
code change.  I have already done the work in attr.c; sha1_file.c is
hairier, but do-able.

Stefan
