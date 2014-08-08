From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH 0/5] ref-transactions-req-strbuf-err
Date: Fri, 8 Aug 2014 09:15:29 -0700
Message-ID: <CAL=YDWn1uNvdKxdEg_D-=1-wvAm1PzbSM0N_G6_KUbuc7X7-Rw@mail.gmail.com>
References: <1406841910-3278-1-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 08 18:15:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFmpL-00039l-AT
	for gcvg-git-2@plane.gmane.org; Fri, 08 Aug 2014 18:15:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755730AbaHHQPb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2014 12:15:31 -0400
Received: from mail-vc0-f175.google.com ([209.85.220.175]:40704 "EHLO
	mail-vc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752570AbaHHQPa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2014 12:15:30 -0400
Received: by mail-vc0-f175.google.com with SMTP id ik5so8492950vcb.6
        for <git@vger.kernel.org>; Fri, 08 Aug 2014 09:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=B6H71ykp3tZh/kTL1RssJzoqaUCH5UUHkQ/pdU9Uvnk=;
        b=HYnys2WNrNNwoIoAVjvssoNGGy4PscvJ7r6dDWkGUuvT2zPuMYax6mAP1S7nOPAicX
         /ga7HL4836LPOJ+7Gn1JlLDTgKBHqIUk8q0iTEIgGIPckjX5NY3jX7KrmNm4qY4lnL+q
         8IbhROzqgRwV65v8d3A4B6Qa6l6vhdbDcsPbEHckSA8zVQW3/7kNceN1uuCuJsF+i7Lt
         XmDOC6NxkXlYiezXVCASZz2FqGIoJaB9jGrz79cgkViAkoQeGwlv//FfKaBK5a1hrlI4
         Xtaq8I8z6qRqNmGbLL5ibuYd9z+prmvtk/IpJWRC5wUrzpxnvWOGesOJw/2YzXyBhrhE
         it2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=B6H71ykp3tZh/kTL1RssJzoqaUCH5UUHkQ/pdU9Uvnk=;
        b=DA3OLoRAqFNje0k1x7l7hI7zfdu06rbj5eijDTEwfV0xHplTj8JCNwACzOEHrhEXhH
         /tyEzmUByg1Z6BgMRBlO1Z/Nq/RqwPEiUOFazj5PLAvqjrm5AloWwn/3Jt/FQtfIcHny
         jw3rbPXiwTFWF+CFo05bXj8yoEFYOq9Kev6Lpz1D7odzbpOXaB6Id+crpko0hVDfNcCE
         y8dOPHeUsuXlp1g/1b1GLQd5ABhGnX7yU8haAwzj7RKnJBSOh/iyJ9aMpsz88nHroM3H
         KUW5KB4ydAN7WMAvdUbeo5R92+7ZjykRYu4RGbpTp0XXPhaULzADaD7A3e6W5DA5yzBM
         Amsg==
X-Gm-Message-State: ALoCoQmTNich9hAl9kSCDH66yKtmbn0XYFnVUjl/WfYq/Q4iWrM9TN+9FKp7Zl4Bb261PziTNayN
X-Received: by 10.52.230.164 with SMTP id sz4mr962316vdc.68.1407514529474;
 Fri, 08 Aug 2014 09:15:29 -0700 (PDT)
Received: by 10.52.69.136 with HTTP; Fri, 8 Aug 2014 09:15:29 -0700 (PDT)
In-Reply-To: <1406841910-3278-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255020>

Ping ?

On Thu, Jul 31, 2014 at 2:25 PM, Ronnie Sahlberg <sahlberg@google.com> wrote:
> List,
>
> This is the next patch series in the ref transaction work.
> This patch series is called ref-transactions-req-strbuf-err and builds ontop
> of the series called ref-transactions-req-packed-refs which is origin/pu
>
>
> This patch series mainly adds some nice strbuf arguments to some functions to
> pass errors back to callers.
> The only thing noteworthy is that we finally get to remove
> -enum action_on_err {
> -       UPDATE_REFS_MSG_ON_ERR,
> -       UPDATE_REFS_DIE_ON_ERR,
> -       UPDATE_REFS_QUIET_ON_ERR
> -};
>
> aside from that there is little/nothing much interesting in there.
>
>
> Ronnie Sahlberg (5):
>   refs.c: replace the onerr argument in update_ref with a strbuf err
>   refs.c: make add_packed_ref return an error instead of calling die
>   refs.c: make lock_packed_refs take an err argument
>   refs.c: add an err argument to commit_packed_refs
>   refs.c: add an err argument to pack_refs
>
>  builtin/checkout.c   |   7 ++-
>  builtin/clone.c      |  23 +++++---
>  builtin/merge.c      |  20 ++++---
>  builtin/notes.c      |  24 +++++----
>  builtin/pack-refs.c  |   8 ++-
>  builtin/reset.c      |  12 +++--
>  builtin/update-ref.c |   7 ++-
>  notes-cache.c        |   2 +-
>  notes-utils.c        |   5 +-
>  refs.c               | 148 +++++++++++++++++++++++++++++----------------------
>  refs.h               |  13 ++---
>  transport-helper.c   |   7 ++-
>  transport.c          |   9 ++--
>  13 files changed, 170 insertions(+), 115 deletions(-)
>
> --
> 2.0.1.523.g70700c9
>
