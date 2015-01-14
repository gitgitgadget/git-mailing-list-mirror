From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] receive-pack.c: don't miss exporting unsolicited push certificates
Date: Tue, 13 Jan 2015 16:11:34 -0800
Message-ID: <CAGZ79kad=c1wXW163doxWBRdSvQ7Y9EkkD+ZXtOfawjtxEyeQw@mail.gmail.com>
References: <xmqqbnm7bj8m.fsf@gitster.dls.corp.google.com>
	<1420849874-32013-1-git-send-email-sbeller@google.com>
	<xmqqmw5r9zck.fsf@gitster.dls.corp.google.com>
	<54B0A2C1.4040602@gmail.com>
	<xmqqiogb95t4.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Beller <stefanbeller@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 14 01:11:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBBYi-0005kS-DN
	for gcvg-git-2@plane.gmane.org; Wed, 14 Jan 2015 01:11:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751331AbbANALg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2015 19:11:36 -0500
Received: from mail-ie0-f179.google.com ([209.85.223.179]:55872 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750995AbbANALf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2015 19:11:35 -0500
Received: by mail-ie0-f179.google.com with SMTP id rp18so5994102iec.10
        for <git@vger.kernel.org>; Tue, 13 Jan 2015 16:11:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=t5iQr1U3knMb6jVW4g9V7jc7lnCzafJplOypf50h9RU=;
        b=kqRiOk61Wn6SNQYVEKlIH94hWgoy+6dgXCXlKnBXs0Kh9wn4HF1zWy7uQkDy87/CAe
         TvUDf9qPNGNWTq6bi4kGkb/7XuKxYTLCzptivxczqOGO3zXntxamYPGL1khudx9dcUgm
         soBKa+UmDOObKKvZDXGtkR9JtrQD1DB+FcTgV5U5Fo191Z6qUU0qEnWBGXgksgGuKZqy
         Fm8+rtKg+QO3jwcZFjqtDBQxz0tzShu1kmJZvbQC4TSq1YKiyZcuuXoPzXd9cW8/+mAp
         EzqoKFsxxO97TsX4H9h8TKo2IdmV9X7OzZQ+K+I7MwIbt3bLxOmGxvhWCIX6rKktJKy6
         r+aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=t5iQr1U3knMb6jVW4g9V7jc7lnCzafJplOypf50h9RU=;
        b=lJNoMEwRWVeZavfwZeIYGXJcWqbLHBX1ImOWEKmKxVIRy2PgHM6724X64XTwhs4O/A
         TQHFw0pWtHGZkY/B8lvUO/SdysjKQPJu/Eg8+N7Zr+jzK5bYMfXx0FpbeO/td9lv4PJi
         +/Xd/JWB8Uk0bCm3sysO8ign7Wo1KTJ4QVe2PtGOYj/+sAAfCML9pYKGfX+Zz/9nkvx1
         HvPyYncmRHJxeeBhPb0/iPoFyZjNo3gjv5ApdbLdYPRW1rlP57kf82fjpucKIt3dJuw8
         gnxlGRodaTtPYsG5PbA9Uu+v0c36VjRjimSJ+8BhUFZX7Lc72vnEbdZKWtnO97nBKswf
         kLPQ==
X-Gm-Message-State: ALoCoQkQkDCVnQdc0qLkVlRY8afincx6JFLI6AmUB+kQ6FsuhOnmzC4ciw/QemNDxijMibwGJC3C
X-Received: by 10.107.170.166 with SMTP id g38mr1350128ioj.2.1421194294935;
 Tue, 13 Jan 2015 16:11:34 -0800 (PST)
Received: by 10.107.31.8 with HTTP; Tue, 13 Jan 2015 16:11:34 -0800 (PST)
In-Reply-To: <xmqqiogb95t4.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262364>

On Mon, Jan 12, 2015 at 11:07 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> yes that's what I was trying to hint at. The hook would just see
>> it is unsolicited instead of not having the state available.
>
> OK.  That makes sort of sense.  So if we:
>
>  1) did not apply either patch (i.e. we accept unsolicited
>     certificate, and the fact that we did not exchange "give me this
>     nonce" "here is your nonce" is conveyed to the hooks by the lack
>     of GIT_PUSH_CERT_NONCE environment and possible presense of
>     unsolicited nonce in the GIT_PUSH_CERT blob); and then
>
>  2) applied this patch first (i.e. we still allow unsolicited
>     certificate, and the same fact is now conveyed to the hooks also
>     by GIT_PUSH_CERT_NONCE_STATUS=UNSOLICITED if they sent a nonce,
>     or GIT_PUSH_CERT_NONCE_STATUS=MISSING); and then finally
>
>  3) applied the other patch to reject unsolicited certificate.
>
> then we can stop at any of these three steps and the behaviour of
> three resulting systems make sense and the pre-receive hook can
> reject unsolicited certificates if it wants to, even at step #1.

I do not quite understand the intention of your mail. Are you saying I should
make a patch series to solve the problems as outlined above?
