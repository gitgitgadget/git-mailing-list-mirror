Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A2F241F453
	for <e@80x24.org>; Fri,  2 Nov 2018 14:47:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbeKBXzJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Nov 2018 19:55:09 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43459 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727454AbeKBXzJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Nov 2018 19:55:09 -0400
Received: by mail-qk1-f196.google.com with SMTP id r71so3374473qkr.10
        for <git@vger.kernel.org>; Fri, 02 Nov 2018 07:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8T9XTGmpcN/64L7qz7bZ8BitPIhAjYv7rUrP/fdoR1I=;
        b=Flsc9A/2smjmHKX1b7ENjx5I7h2DOJIsEYURYtPLYfqpBqkTfIhvGWc8JkaXamDUQj
         6oNYpSKdeb1k8MMGFWaW5DleXl4INdZ8I6YZlM89NTyB5aQGa/DO/gH/Ic9wNJj34BZd
         0duLL3ud5Rxbn9xMLYdl7IkzwxqEio1Xi/T5HvHW5W7N5RLritQGcCxEFQnjGta3fEaO
         T6GOIZFr6PAT1b2VXSz0uV6mHjydb8JFWYPE2Yntzn2FoVymIsXn1KKZRs+hxK8kAlCB
         2SJlghPYIPIQ6486JDalwTY1XiFpYlgvO09QqmuZB0clcLGrYyjffXndhhzyDO+R/ycB
         FRMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8T9XTGmpcN/64L7qz7bZ8BitPIhAjYv7rUrP/fdoR1I=;
        b=dcXRmQX8w3s+j5vgqn7WGzj5nrn7uarmOF0YSpeGBE/0WGgT/OER+ikBUFzjfduycR
         uq03HiVEsM6ra6x8azGn//z2UafVdskwy2MHmFwZKHMpPWPyzB6gJacrdZsSRBmNcwMi
         k41ea+XIim9s5s5OaQtNJouNLVgpAnLHU4+4EmpJELmF2vLE1GkfRLWeaqCIOXt/HIES
         Ymh4UKshYHd81Naic5cSjcmYesqC1ND/8fam1qd1b9zhw/yOAEaqOp6G6NpoMeRt5Y0C
         /gWgF/xW+/wfhoI+bkZyvp8yWzTR2X52nqzo9hpVpzT3qTSn6duHBADgTjdeRYFQzI8P
         X8AA==
X-Gm-Message-State: AGRZ1gKYEbQu6Z4jL4a7hiKTIYYRxnGdDrFenyorx4rI07nruFUGjk9M
        GO0re+evmVZF864vZmTNCgeZHdFW//OX247bJTQ=
X-Google-Smtp-Source: AJdET5dKodA9tSNdwhTnt9b5mYLqP1WlzazyutRxzLqDHFP/6tV11O8ArYoG3aXbqePE3JlZ1mEKU6TXVQtgCRBrxws=
X-Received: by 2002:ac8:17f0:: with SMTP id r45mr8383925qtk.206.1541170067573;
 Fri, 02 Nov 2018 07:47:47 -0700 (PDT)
MIME-Version: 1.0
References: <pull.64.git.gitgitgadget@gmail.com> <69bc5924f94b56f92d9653b3a64f721bd03f1956.1541020294.git.gitgitgadget@gmail.com>
 <c9e001de-3598-182d-416e-1e94f234c249@kdbg.org>
In-Reply-To: <c9e001de-3598-182d-416e-1e94f234c249@kdbg.org>
From:   Steve Hoelzer <shoelzer@gmail.com>
Date:   Fri, 2 Nov 2018 09:47:15 -0500
Message-ID: <CACbrTHctZejfDTjqWqVfPYdb=ssD253Cd2isr3BxWsL1AqsH2w@mail.gmail.com>
Subject: Re: [PATCH 1/1] poll: use GetTickCount64() to avoid wrap-around issues
To:     j6t@kdbg.org
Cc:     gitgitgadget@gmail.com, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 1, 2018 at 5:22 AM Johannes Sixt <j6t@kdbg.org> wrote:
>
> Am 31.10.18 um 22:11 schrieb Steve Hoelzer via GitGitGadget:
> > From: Steve Hoelzer <shoelzer@gmail.com>
> >
> >  From Visual Studio 2015 Code Analysis: Warning C28159 Consider using
> > 'GetTickCount64' instead of 'GetTickCount'.
> >
> > Reason: GetTickCount() overflows roughly every 49 days. Code that does
> > not take that into account can loop indefinitely. GetTickCount64()
> > operates on 64 bit values and does not have that problem.
> >
> > Note: this patch has been carried in Git for Windows for almost two
> > years, but with a fallback for Windows XP, as the GetTickCount64()
> > function is only available on Windows Vista and later. However, in the
> > meantime we require Vista or later, hence we can drop that fallback.
> >
> > Signed-off-by: Steve Hoelzer <shoelzer@gmail.com>
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >   compat/poll/poll.c | 10 +++++++---
> >   1 file changed, 7 insertions(+), 3 deletions(-)
> >
> > diff --git a/compat/poll/poll.c b/compat/poll/poll.c
> > index ad5dcde439..4abbfcb6a4 100644
> > --- a/compat/poll/poll.c
> > +++ b/compat/poll/poll.c
> > @@ -18,6 +18,9 @@
> >      You should have received a copy of the GNU General Public License along
> >      with this program; if not, see <http://www.gnu.org/licenses/>.  */
> >
> > +/* To bump the minimum Windows version to Windows Vista */
> > +#include "git-compat-util.h"
> > +
> >   /* Tell gcc not to warn about the (nfd < 0) tests, below.  */
> >   #if (__GNUC__ == 4 && 3 <= __GNUC_MINOR__) || 4 < __GNUC__
> >   # pragma GCC diagnostic ignored "-Wtype-limits"
> > @@ -449,7 +452,8 @@ poll (struct pollfd *pfd, nfds_t nfd, int timeout)
> >     static HANDLE hEvent;
> >     WSANETWORKEVENTS ev;
> >     HANDLE h, handle_array[FD_SETSIZE + 2];
> > -  DWORD ret, wait_timeout, nhandles, start = 0, elapsed, orig_timeout = 0;
> > +  DWORD ret, wait_timeout, nhandles, elapsed, orig_timeout = 0;
> > +  ULONGLONG start = 0;
> >     fd_set rfds, wfds, xfds;
> >     BOOL poll_again;
> >     MSG msg;
> > @@ -465,7 +469,7 @@ poll (struct pollfd *pfd, nfds_t nfd, int timeout)
> >     if (timeout != INFTIM)
> >       {
> >         orig_timeout = timeout;
> > -      start = GetTickCount();
> > +      start = GetTickCount64();
> >       }
> >
> >     if (!hEvent)
> > @@ -614,7 +618,7 @@ restart:
> >
> >     if (!rc && orig_timeout && timeout != INFTIM)
> >       {
> > -      elapsed = GetTickCount() - start;
> > +      elapsed = (DWORD)(GetTickCount64() - start);
>
> AFAICS, this subtraction in the old code is the correct way to take
> account of wrap-arounds in the tick count. The new code truncates the 64
> bit difference to 32 bits; the result is exactly identical to a
> difference computed from truncated 32 bit values, which is what we had
> in the old code.
>
> IOW, there is no change in behavior. The statement "avoid wrap-around
> issues" in the subject line is not correct. The patch's only effect is
> that it removes Warning C28159.
>
> What is really needed is that all quantities in the calculations are
> promoted to ULONGLONG. Unless, of course, we agree that a timeout of
> more than 49 days cannot happen ;)

Yep, correct on all counts. I'm in favor of changing the commit message to
only say that this patch removes Warning C28159.

Steve
