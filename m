From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 0/2] Ignore trailing spaces in .gitignore
Date: Mon, 10 Feb 2014 11:29:17 +0700
Message-ID: <CACsJy8AZbi89gsM_MWzPe+95y+MqjtFpiFZE8ai1JMtzwiLTQg@mail.gmail.com>
References: <1391847004-22810-1-git-send-email-pclouds@gmail.com> <7vd2iv8vbo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 10 05:29:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WCiVE-0006EA-CN
	for gcvg-git-2@plane.gmane.org; Mon, 10 Feb 2014 05:29:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751849AbaBJE3s convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Feb 2014 23:29:48 -0500
Received: from mail-qa0-f52.google.com ([209.85.216.52]:46110 "EHLO
	mail-qa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751788AbaBJE3r convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Feb 2014 23:29:47 -0500
Received: by mail-qa0-f52.google.com with SMTP id j15so8990550qaq.11
        for <git@vger.kernel.org>; Sun, 09 Feb 2014 20:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=rIJNoBi9tLxhhaN9KKFU36juQPUBVP56Ac/AYZ8ZtIg=;
        b=m75tb/yjkr0eeia5fOlonueSmWpMCltQsVKvssettOkh4kjr4OSdy2+2pw5fUBXMtd
         CSCYsh73eyoRx7xI0Ceu8/Ee8p2msjBN+RcQ6306Gu7vE0EpRSt0OGf50Rnln0UCWTci
         NIgN/4a2jWTyJJwt0Y7HVf7yAvv1Hb7mu96NG4fjym//Y9FNNhvLPqm4o0BW3hmrG2eq
         X+fUrEcaX4cEhJDwoDTTOz/H6/yVB4EerZ0H8yG03lBy2AMszHPNuW4QBhj6E5FaSUlI
         NRJJb6l4PGPRwN1hy+yn84DQ33AQcCqaZZg//AzNmjI6wNYad83RZwwn3RPUiUfDLHTZ
         jLHA==
X-Received: by 10.224.36.129 with SMTP id t1mr41289309qad.8.1392006587252;
 Sun, 09 Feb 2014 20:29:47 -0800 (PST)
Received: by 10.96.215.102 with HTTP; Sun, 9 Feb 2014 20:29:17 -0800 (PST)
In-Reply-To: <7vd2iv8vbo.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241900>

On Mon, Feb 10, 2014 at 11:07 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>> Trailing spaces are invisible in most standard editors (*). "git dif=
f"
>> does show trailing spaces by default. But that does not help newly
>> written .gitignore files. And trailing spaces are the source of
>> frustration when writing .gitignore.
>>
>> So let's ignore them. Nobody sane would put a trailing space in file
>> names. But we could be careful and do it in two steps: warn first,
>> then ignore trailing spaces. Another option is merge two patches in
>> one and be done with it.
>>
>> People can still quote trailing spaces, which will not be ignored (a=
nd
>> much more visible). Quoting comes with a cost of doing fnmatch(). Bu=
t
>
> Hmph, sorry but I fail to see why we need to incur cost for
> fnmatch().  We read and parse the file and keep them as internal
> strings, so your unquoting (and complaining the unquoted trailng
> spaces) can be done at the parse time, while keeping the trailing
> spaces the user explicitly told us to keep by quoting in the
> internal string that we eventually feed fnmatch() with _after_
> unquoting, no?

That's the optimization in the "but" sentence. Another (off topic)
opt. we could do is make "*.[ch]" behave more like "*.c", where we
just try to match the tail part.
--=20
Duy
