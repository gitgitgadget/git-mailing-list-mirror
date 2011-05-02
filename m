From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH/RFC 2/4] grep: pass current line number down to match_one_pattern
Date: Mon, 2 May 2011 16:29:31 +0200
Message-ID: <BANLkTimr7A64OYB51kSWe7pkjYaiOZy-ZQ@mail.gmail.com>
References: <cover.1304318972.git.bert.wesarg@googlemail.com>
	<cover.1304321122.git.bert.wesarg@googlemail.com>
	<f768ea6e107cdd229a18df0bac3bf583eb1f9fc5.1304321122.git.bert.wesarg@googlemail.com>
	<2681b60988c7c4d059f83df368395eca0520012c.1304321122.git.bert.wesarg@googlemail.com>
	<BANLkTi=HtStcEFezT9sEeRFzsGw1mMyg7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 02 16:29:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QGu82-0007n4-J3
	for gcvg-git-2@lo.gmane.org; Mon, 02 May 2011 16:29:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759564Ab1EBO3e convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 May 2011 10:29:34 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:61217 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756136Ab1EBO3d convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 May 2011 10:29:33 -0400
Received: by fxm17 with SMTP id 17so3658900fxm.19
        for <git@vger.kernel.org>; Mon, 02 May 2011 07:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=VrC2DAtAYvGGZiOb8R453X02NASXSg12KZLn4cM90eU=;
        b=QLD3zpy0gENSlQURf84d7ZpiH+LZ/G6nVjsZOjbzJzGTf3b2ydZAdzV7jPO7D45MMf
         BWiYM1AkqdaiEeQ8SZ1c3KpIGWia//vtCEluh4T4NzNQhN0lk3ckwYYvUxm+GZMDp3A2
         IeWcppRsq1Qbid9oozaz0tjxJyTHyaxwZ7P+I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=h++2VSxwOo32JV10ekeJ/ol0s2s5HHuaWjvfFjDpmuz3UR0Jjgsi7nJ84maMq1lg4h
         DHBg1WHOhsAQ1ioNV6zDruHYkiXN++IzLxfbO+5REOvHZd2eOKdM2GraP0K+yOH2SdSM
         lbgDJqKkBv77y799NzdRppgc5e1aIyGA8FpwQ=
Received: by 10.223.3.132 with SMTP id 4mr749698fan.132.1304346571782; Mon, 02
 May 2011 07:29:31 -0700 (PDT)
Received: by 10.223.71.205 with HTTP; Mon, 2 May 2011 07:29:31 -0700 (PDT)
In-Reply-To: <BANLkTi=HtStcEFezT9sEeRFzsGw1mMyg7Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172594>

On Mon, May 2, 2011 at 15:30, Thiago Farina <tfransosi@gmail.com> wrote=
:
> On Mon, May 2, 2011 at 8:39 AM, Bert Wesarg <bert.wesarg@googlemail.c=
om> wrote:
>> Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
>> ---
>> =C2=A0grep.c | =C2=A0 42 +++++++++++++++++++++---------------------
>> =C2=A01 files changed, 21 insertions(+), 21 deletions(-)
>>
>> diff --git a/grep.c b/grep.c
>> index b8eda9e..f21b022 100644
>> --- a/grep.c
>> +++ b/grep.c
>> @@ -437,7 +437,7 @@ static struct {
>> =C2=A0};
>>
>> =C2=A0static int match_one_pattern(struct grep_pat *p, char *bol, ch=
ar *eol,
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0enum grep_context ctx,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned lno, enum grep_context ctx,
>
> I'd rename lno to line_nr, so it's more clearer. Also, I'd add the ne=
w
> paramenter at the end, not in some random position (or was there some
> particular reason to put here but not in the end?).

lno is already in use in this file, so I followed here the precept.
The position was chosen, because bol/eol is the line content to match,
so the line number should probably be near the content parameter.

Bert

>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 regmatch_t *pmatch, int eflags)
>> =C2=A0{
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0int hit =3D 0;
