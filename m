From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2] branch: show rebase/bisect info when possible instead
 of "(no branch)"
Date: Mon, 4 Feb 2013 14:14:34 +0700
Message-ID: <CACsJy8CGqiahw3y42KRt61gChtfOucFHqZqn_uvLrj7j7KrQbg@mail.gmail.com>
References: <1359461574-24529-1-git-send-email-pclouds@gmail.com>
 <1359870520-22644-1-git-send-email-pclouds@gmail.com> <vpqpq0hnlb1.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Niedier <jrnieder@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Feb 04 08:15:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2GHF-0001mi-Ov
	for gcvg-git-2@plane.gmane.org; Mon, 04 Feb 2013 08:15:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753576Ab3BDHPJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Feb 2013 02:15:09 -0500
Received: from mail-oa0-f53.google.com ([209.85.219.53]:60487 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751632Ab3BDHPE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Feb 2013 02:15:04 -0500
Received: by mail-oa0-f53.google.com with SMTP id m1so5240151oag.40
        for <git@vger.kernel.org>; Sun, 03 Feb 2013 23:15:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=vDTHkVwC6knIdv5JH+CP9brL1bGZNVs4w2G8ZESE4Jg=;
        b=Q5DF1pWHiMwtWCdPlKEASAYIw3TjJCIGv0j8zWmb+dE6j5AQLWFUYZcSUgQKayULcZ
         tCf7pB5YSPvvpNVa0hRNsngNZrEGG8UKWlGmGR2zSqXnjdTJRfbW3Th46+OMBBvqK1RU
         Au+mCJcm4xbhj2i8ZgGqSvS/v4wiJ6hKIGCgYs3OiVJtJh2sQ6hAkLiIVYmQ2t9L7gmj
         uswapCEt3bkn0ROT8wNQl65SgCuer+gtk1X2KlGleOA5/j4GmKH+YlIUnJNNQsn9Teie
         zGavU/Bb4hFlZDXisiLBsPbjU3sYIR0URcAJGaj86dEEZ+Sow6udsjRwk09E3s9U7tGI
         nONA==
X-Received: by 10.182.18.133 with SMTP id w5mr14945108obd.64.1359962104187;
 Sun, 03 Feb 2013 23:15:04 -0800 (PST)
Received: by 10.182.118.229 with HTTP; Sun, 3 Feb 2013 23:14:34 -0800 (PST)
In-Reply-To: <vpqpq0hnlb1.fsf@grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215361>

On Mon, Feb 4, 2013 at 4:23 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:
>
>> --- a/t/t6030-bisect-porcelain.sh
>> +++ b/t/t6030-bisect-porcelain.sh
>> @@ -164,7 +164,7 @@ test_expect_success 'bisect start: existing ".gi=
t/BISECT_START" not modified if
>>       cp .git/BISECT_START saved &&
>>       test_must_fail git bisect start $HASH4 foo -- &&
>>       git branch > branch.output &&
>> -     test_i18ngrep "* (no branch)" branch.output > /dev/null &&
>> +     test_i18ngrep "* (bisecting other)" branch.output > /dev/null =
&&
>
> I'd have spelled it (no branch, bisecting other) to make it clear tha=
t
> we're on detached HEAD, and avoid confusing old-timers. But maybe you=
r
> version is enough, I'm not sure.

If we want to make it clear, I think the standard "* (no branch)" shoul=
d become

* HEAD (detached)

or non-detached case:

* HEAD -> foo

Then we could present rebase/bisect information as

* HEAD (detached, bisecting)
* HEAD (detached, rebasing)
* foo (rebasing)

I don't want to make this line too long because it would break (well,
waste space in) column layout. So if we do this, no branch name added
for rebase/bisect.
--=20
Duy
