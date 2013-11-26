From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 04/28] update-server-info: do not publish shallow clones
Date: Tue, 26 Nov 2013 19:41:26 +0700
Message-ID: <CACsJy8Duzkj4WVvXY8JEx4yNBjmY43+GCCp7oeQk21WT+5CJsg@mail.gmail.com>
References: <1385351754-9954-1-git-send-email-pclouds@gmail.com>
 <1385351754-9954-5-git-send-email-pclouds@gmail.com> <xmqqr4a4xn1a.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 26 13:42:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VlHxp-0002q6-Lh
	for gcvg-git-2@plane.gmane.org; Tue, 26 Nov 2013 13:42:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756546Ab3KZMl5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Nov 2013 07:41:57 -0500
Received: from mail-qe0-f49.google.com ([209.85.128.49]:48584 "EHLO
	mail-qe0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752039Ab3KZMl4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Nov 2013 07:41:56 -0500
Received: by mail-qe0-f49.google.com with SMTP id w7so5436353qeb.8
        for <git@vger.kernel.org>; Tue, 26 Nov 2013 04:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=6UfxDEmNoYMcvFkbmWNpOC1A1ymCM9IalL1jo+l9JvY=;
        b=HGLx0Wfeou4CQDZNSC/wnTXw4xNayVv4g0K5ylF73WcrxzdDnBiY9NHwTquSYB0cF+
         L/vYjCg37HvJfn1LzY44Ch2qGCBmp7aYsdJkbZTN04ubOJICI8VLapSF2wiblCdvOHSt
         KMdLac+2RdACCCctFAE1hzZNwWOiRA6FdmYO5GHPScJNeh2Gt4jwOekW21cPky2F4y97
         39c4AENVkNzf5p/tPxymm39ouTY6BLI5thEy3gibbyfP6q1ma2yHu7mjal7YmP7cdVKd
         K2LN4MYnkoWLp3KlDwQDroHe19uPdh3P0DdQQ9A/+EZ5e9yy8zuFl+VT+ChyyBum6FCb
         ejUw==
X-Received: by 10.49.15.227 with SMTP id a3mr28138065qed.66.1385469716127;
 Tue, 26 Nov 2013 04:41:56 -0800 (PST)
Received: by 10.96.134.68 with HTTP; Tue, 26 Nov 2013 04:41:26 -0800 (PST)
In-Reply-To: <xmqqr4a4xn1a.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238382>

On Tue, Nov 26, 2013 at 3:08 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>> Dumb commit walker does not care about .git/shallow and until someon=
e
>> steps up to make it happen, let's not publish shallow clones using
>> dumb protocols.
>>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gm=
ail.com>
>> ---
>>  server-info.c | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>
> I doubt that pros-and-cons is in this patch's favor.  Without this
> patch, if a fetch requests commits just on the surface in this
> shallow repository, the walker would happily get the necessary
> objects just fine.  If the request has to dig deeper and cross the
> shallow boundary, the walker will get a failure and error out.
>
> With this patch, both will error out.  So overall, the patch did not
> make anything safer (e.g. preventing from introducing new corruption
> on the recipient's end) while breaking a case where it worked just
> fine, no?
>
> Or am I missing something?  Not that dumb walkers would matter very
> much these days, ...

No you're not. If it may fail, in my opinion it should fail early than
walk all the way and fail. But yeah dropping the patch is fine too. I
don't care too much about dumb walkers.
--=20
Duy
