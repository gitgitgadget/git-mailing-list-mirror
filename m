From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 1/2] worktree: fix "add -B"
Date: Tue, 16 Feb 2016 08:15:16 +0700
Message-ID: <CACsJy8BzN4Gskj3Vr_fZyJW-+cPtLE-590LD+kSfjDm1Y9gaLQ@mail.gmail.com>
References: <20160215094154.GA11698@lanh> <1455543333-25814-1-git-send-email-pclouds@gmail.com>
 <xmqq8u2lo7hq.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Kirill Likhodedov <kirill.likhodedov@jetbrains.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 16 02:15:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVUF5-0006oI-Db
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 02:15:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751642AbcBPBPr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Feb 2016 20:15:47 -0500
Received: from mail-lf0-f51.google.com ([209.85.215.51]:36118 "EHLO
	mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751477AbcBPBPr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Feb 2016 20:15:47 -0500
Received: by mail-lf0-f51.google.com with SMTP id 78so98953835lfy.3
        for <git@vger.kernel.org>; Mon, 15 Feb 2016 17:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=UGTxURHthjaaTr/2U2bQAJNzAMBTHhnmJXtecjZo78A=;
        b=ZMTSzQcTHIeR80uG4ONy/DOz/U8Ju3jAR8VD/LvjXPDOea4TmJzola65oTEScqgZNo
         c9kIU0G6uUBmXh29dHFT9pBavYhcQz5pc0MFC2Wt3rx52cEdIDs3DeJi18QcMZyylvkI
         SM0yGq8pengQokbbn+amEwN1QDdS2rHToUdMQ5pszK0A+oTN7/G0tETvqTQ2iCkHgSXL
         PGBV5IU1fljkePWkkS7+Kz/XNGkImQCoAW7C+WnEwAA1MDrdtYRxc3NkcNIlECsyCwUR
         L1mFqLfezBl8EBUrXlsKiJCqmgdmVXIi42G1tMXnAlIp7N+oA78OM9LOuoeM1+7lMFf3
         +Otg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=UGTxURHthjaaTr/2U2bQAJNzAMBTHhnmJXtecjZo78A=;
        b=c54eeXLOqJCeFoAx92KP6k1A3xlQDDdjR7soECk2bcd6pGJ4O7+IehjNRkiDI3kBiU
         xyIcvlOusnye2uH1/l29ylmAuCDB92AA1NHsWuXTyc5V2vXB3yQ7s6+U1b+/oNaB6Dez
         dB3zV6KAz3y/8WTosCIOaO45U4e8XErv1dEcq7k1PdIDxWz9+hKvvu8Co/65kz2XWIZB
         hwzFrqvQh+02oMfxA9ZnI3PO+ttiSH9VqGFZGk0vD7LRSyFGBXvOOi1qHBHvpfJB/Bi5
         QQIzSn4QKvddngcaPxmgbzxpQYwRkv4UiCKKBAUJdhnh6rbL/RPESvNHPbAlmvOUguRr
         Buxg==
X-Gm-Message-State: AG10YOSV83gv3+WzfxpfpPTbj1fhFIMsBFmI5fNlSvfOcEYv/xk8vHw9MOmK1d2/rxevX1UAhGzuan45gdFwmA==
X-Received: by 10.25.5.6 with SMTP id 6mr6786801lff.3.1455585345641; Mon, 15
 Feb 2016 17:15:45 -0800 (PST)
Received: by 10.112.97.72 with HTTP; Mon, 15 Feb 2016 17:15:16 -0800 (PST)
In-Reply-To: <xmqq8u2lo7hq.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286299>

On Tue, Feb 16, 2016 at 6:53 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>> Current code does not update "symref" when -B is used. This string
>> contains the new HEAD. Because it's empty "git worktree add -B" fail=
s at
>> symbolic-ref step.
>>
>> Because branch creation is already done before calling add_worktree(=
),
>> -B is equivalent to -b from add_worktree() point of view. We do not =
need
>> the special case for -B.
>>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gm=
ail.com>
>> ---
>>  Complete patch.
>>
>>  builtin/worktree.c      | 4 +---
>>  t/t2025-worktree-add.sh | 8 ++++++++
>>  2 files changed, 9 insertions(+), 3 deletions(-)
>>
>> diff --git a/builtin/worktree.c b/builtin/worktree.c
>> index 475b958..6b9c946 100644
>> --- a/builtin/worktree.c
>> +++ b/builtin/worktree.c
>> @@ -201,9 +201,7 @@ static int add_worktree(const char *path, const =
char *refname,
>>               die(_("'%s' already exists"), path);
>>
>>       /* is 'refname' a branch or commit? */
>> -     if (opts->force_new_branch) /* definitely a branch */
>> -             ;
>> -     else if (!opts->detach && !strbuf_check_branch_ref(&symref, re=
fname) &&
>> +     if (!opts->detach && !strbuf_check_branch_ref(&symref, refname=
) &&
>>                ref_exists(symref.buf)) { /* it's a branch */
>
> Makes a reader wonder why the original thought it was OK to do
> nothing when -B is given here.

The bug is quite subtle. This code is added in f7c9dac. At that
commit, I believe symref is simply a temporary var, to be used by
ref_exists() and nothing else. The next commit 7f44e3d replaces
git-checkout with git-symbolic-ref and symref is used again. But the
symref initialization code is not in the diff context lines, so it's
hard to see that there's one case where symref remains empty.

> What does symref.buf have at this point in the codeflow?

Empty.

> Will it always an existing branch?

It should be.

> In what case can it be the name of a branch that does not yet exist?

You can do "worktree add <path> <non-existing-ref>".
--=20
Duy
