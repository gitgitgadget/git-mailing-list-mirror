From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [RFC] helping smart-http/stateless-rpc fetch race
Date: Mon, 8 Aug 2011 23:05:27 +0200
Message-ID: <CAGdFq_i=8p4jvKo1C=UFpmQyPtUd9JOtr9VW8vn7viC0dQkQmg@mail.gmail.com>
References: <7vbow337gx.fsf@alter.siamese.dyndns.org> <CAJo=hJvdMCyU-5wzy0p1r+QJxXU=DJTE+Mu5G6pk9iAwAD51mA@mail.gmail.com>
 <7vbow01ols.fsf@alter.siamese.dyndns.org> <7vsjpbzv07.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 08 23:06:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QqX1c-0000KG-De
	for gcvg-git-2@lo.gmane.org; Mon, 08 Aug 2011 23:06:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751392Ab1HHVGL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Aug 2011 17:06:11 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:37602 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751425Ab1HHVGK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Aug 2011 17:06:10 -0400
Received: by gwaa12 with SMTP id a12so879837gwa.19
        for <git@vger.kernel.org>; Mon, 08 Aug 2011 14:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=eDr5Bm7VX8khRDuhtrJt/ZfmJtv9IPQkLAuQFzR7ggU=;
        b=hXJy6aPJ0KJuq0I2NN5m9xRyVq/vrVuFgkfJtKZCITNKqI23RQvAyOCgCFkvLA3Mmx
         ENqdjmKYbYRGIH7cNrsNiNF6DUFoAqt9Zsq2eDgVPFI9qAmYlyF7HInVMAe7WRklAUVW
         YoJBJZ6gcId1VI6tDod6Gd1ecP94rlrwf5kZk=
Received: by 10.142.165.18 with SMTP id n18mr3696792wfe.235.1312837568932;
 Mon, 08 Aug 2011 14:06:08 -0700 (PDT)
Received: by 10.68.63.102 with HTTP; Mon, 8 Aug 2011 14:05:27 -0700 (PDT)
In-Reply-To: <7vsjpbzv07.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178984>

Heya,

On Mon, Aug 8, 2011 at 19:13, Junio C Hamano <gitster@pobox.com> wrote:
>> =C2=A0(1) It might make sense to give admins who run upload-pack not=
 behind
>> =C2=A0 =C2=A0 =C2=A0smart-http an option to allow fetching from a no=
n-tip; and

You said earlier it isn't needed since the server process caches the
refs for git and ssh, that leaves dumb-http right? If that is indeed
the case I think we can just argue that since smart-http is our
solution to the http problems, if admins want to make life easier for
http fetches on busy repositories they should be using smart-http.

>> =C2=A0(2) It also might make sense to let admins who do run upload-p=
ack behind
>> =C2=A0 =C2=A0 =C2=A0smart-http force re-fetching when the race is en=
countered.

This would mean that if you're running smart-http without this option
enabled (because, say, you don't know it exists), your users have to
re-fetch (a lot). The only upside would be that if the server _knows_
what the user is asking for is outdated, that the user will know this
right away. That doesn't fly though, since we allow exactly that for
git and ssh transfer.

--=20
Cheers,

Sverre Rabbelier
