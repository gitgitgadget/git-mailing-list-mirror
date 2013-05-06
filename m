From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: [PATCH 0/7] Make "$remote/$branch" work with unconventional refspecs
Date: Mon, 6 May 2013 03:04:29 +0200
Message-ID: <CA+gHt1DAy+OF-A8PiANM8k3=HdpsH8B-EWV5a3Dqv9svxCbZfA@mail.gmail.com>
References: <1367711749-8812-1-git-send-email-johan@herland.net>
 <7vr4hmuk20.fsf@alter.siamese.dyndns.org> <CALKQrgdp9DVDBLNwCAmQHbEfZDvhdsmSW3sh1BRo1XEnyqPPaA@mail.gmail.com>
 <7v8v3tuu6i.fsf@alter.siamese.dyndns.org> <CALKQrgf6NcT2tEGMTczxR2WspOi4NjrN_kxmKN-QyE2Py3iSaQ@mail.gmail.com>
 <7vvc6xt5ov.fsf@alter.siamese.dyndns.org> <CA+gHt1Aq+Hi5Uf-s+q5WaigHXP1Qyq100N=C4x4pwFf8-Q=GcA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Johan Herland <johan@herland.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 06 03:04:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZ9rM-0007aK-BS
	for gcvg-git-2@plane.gmane.org; Mon, 06 May 2013 03:04:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751864Ab3EFBEw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 May 2013 21:04:52 -0400
Received: from mail-la0-f45.google.com ([209.85.215.45]:56361 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751778Ab3EFBEv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 May 2013 21:04:51 -0400
Received: by mail-la0-f45.google.com with SMTP id fp12so2899786lab.18
        for <git@vger.kernel.org>; Sun, 05 May 2013 18:04:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=Gy6S3znHL2NUAcCzWTTBf9J5jfSlEMpbcht4MjobZsA=;
        b=LSKXxP/TA8TEM4G/s3shq4VGWpLYxhFL5RF4Xl1QFtmRU/HmcL3xL7wi3UEbWYj3Nv
         4cdmFLDIGYasZHsgaATaegfv+eoVwCJFMPmV2BF8UyTswfMQ2CUiNdBmS5LQvGTbQpCx
         KyJqMrB0qQ59xBp5A5aq69r7w26OyE7dBxWYDpOry8Oxb8nMd/UWD9A2gNdVDsCLAmyP
         8tQY0idwoLra7dRRpJY158NyevgfzlWZ8B0CwgGbHkcbN+A8o/PAhu6x+HQLU3HISLZq
         c/6HoHlFEhGoWptHR7EsWZLT4M9PtKfT+LYOkci4sjiF4pa5ixMTeL54tsyYa3FXPQNK
         8YwA==
X-Received: by 10.152.26.195 with SMTP id n3mr4481135lag.32.1367802289886;
 Sun, 05 May 2013 18:04:49 -0700 (PDT)
Received: by 10.114.184.180 with HTTP; Sun, 5 May 2013 18:04:29 -0700 (PDT)
In-Reply-To: <CA+gHt1Aq+Hi5Uf-s+q5WaigHXP1Qyq100N=C4x4pwFf8-Q=GcA@mail.gmail.com>
X-Gm-Message-State: ALoCoQk9gYvWVZMIBUQ1AOhjS1sX0mVsKKqUWBL5FWnHhlnwOwZ29IIiRdJZKvS0JTu+DvUJDHN/
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223427>

2013/5/6 Santi B=E9jar <santi@agolina.net>:
> El 06/05/2013 00:36, "Junio C Hamano" <gitster@pobox.com> escribi=F3:
>>
>> Johan Herland <johan@herland.net> writes:
>>
>> > This would not allow the user to use the relevant $remote_name for=
 $nick,
>> > which I argue might be the more natural name for the user to use, =
since
>> > it's the same name that is used for otherwise interacting with the=
 remote.
>>
>> That is where we differ.
>>
>> The thing is, when you name a local ref (be it "refs/heads/master"
>> or "refs/remotes/origin/master") with a short-hand, you are still
>> dealing with a refname, not interacting with the remote at all.
>>
>> Taking notice of remote.$nick.fetch mappings only to complicate the
>> refname resolution logic is absolutely unacceptable, at least to
>> somebody who comes from the "we are interacting with refs, not with
>> remotes" school, like me.
>
> Maybe we could mark it explicity with a double slash: "$remote//$bran=
ch",
> or similar. And it even allows a slash in the remote nick: "bar/baz//=
foo".

The next question could be: why not make it work with $url too? As in:

$ git merge git://git.kernel.org/pub/scm/git/git.git//master

But I don't know if it can be problematic...

I remember that there was a discussion about the remote#branch
notation used in cogito, and at the end it was rejected.

See you,
Santi
