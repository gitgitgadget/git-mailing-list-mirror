From: Kevin Cernekee <cernekee@gmail.com>
Subject: Re: [PATCH 1/1] gitweb: javascript ability to adjust time based on timezone
Date: Thu, 24 Mar 2011 15:00:08 -0700
Message-ID: <AANLkTi=OsPwQxMRoxLSUEXE1FzSYNvrv3Y+-rXUbzTST@mail.gmail.com>
References: <dab08d0ff27b0f571a17ed4f1ab0f39b@localhost>
	<1300925335-3212-2-git-send-email-warthog9@eaglescrag.net>
	<AANLkTincAcVQQtH+T9+K7tyBd0P5S=8YxXpsfrQ=68gE@mail.gmail.com>
	<201103242119.40214.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "John 'Warthog9' Hawley" <warthog9@eaglescrag.net>,
	git@vger.kernel.org, Junio Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 24 23:00:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2sZl-0002aQ-UR
	for gcvg-git-2@lo.gmane.org; Thu, 24 Mar 2011 23:00:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932657Ab1CXWAM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Mar 2011 18:00:12 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:43180 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932406Ab1CXWAK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Mar 2011 18:00:10 -0400
Received: by fxm17 with SMTP id 17so480666fxm.19
        for <git@vger.kernel.org>; Thu, 24 Mar 2011 15:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=iE9/MZCxLZGTlTqyIQ3MO0jkE8SNprzjbg9ZwLyyfgI=;
        b=viA9XAfiqQFrRwGcYJpgncI3Sz16WyIiA0444cqFmZOJtcdbtsU+k6AvcdfAk2oFpL
         +GR7AF4aOWCdGRE5QMSWOM0+IuXQFuBSdnLnKzC0goOM80njREkK92Unaak/6v3AlJ6G
         +g+ddMjE5DsgJtaJDhxofrrFv9QZB66SvvdY4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=szpdnZDWuzxpF4933fUoP9qnY7AU0uamH84Z/ZkU3eOyzlNwFTnFF1cBDNegm9L01o
         TUUFMoFj0jeRAuCMVwPwvjWbu91tZQyzJd61tN9WmCIcfUMx+obe1VSQx4hT9CZiJA+p
         O2scHmLKGmy/B9ktDASgb02WK7l/Vo6rdxTTc=
Received: by 10.223.143.12 with SMTP id s12mr9701fau.121.1301004008512; Thu,
 24 Mar 2011 15:00:08 -0700 (PDT)
Received: by 10.223.145.131 with HTTP; Thu, 24 Mar 2011 15:00:08 -0700 (PDT)
In-Reply-To: <201103242119.40214.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169948>

2011/3/24 Jakub Narebski <jnareb@gmail.com>:
>> 4) IE6 does not seem to like ISO 8601 format:
>>
>> x =3D new Date("2011-03-09T03:29:09Z");
>>
>> This sets all fields to NaN. =C2=A0I suspect that getTime() values
>> (milliseconds since 1970-01-01) are more portable.
>
> Do you mean using epoch in title attribute, or fallback to parsing
> ISO 8601 UTC format with regexps?

getTime() format is $epoch * 1000.  When I switched to that format,
all 3 of my browsers were able to handle it.

I really don't think relying on "new Date(iso8601_timestamp)" is a
good idea, but I guess the string parsing approach would work:

http://webcloud.se/log/JavaScript-and-ISO-8601/

> Dealing with DST (zoneinfo library) is simply too hard for JavaScript
> IMHO. =C2=A0What we could do is to store "local" in cookie, not a fix=
ed TZ
> offset (or perhaps store both as to not recalculate it).

I agree, and I do not have a comprehensive solution for handling
non-local timezones.

> Hmmm... perhaps a 'config' page?

Any thoughts on what other user-configurable items might get added in
the future, and whether they will be on the client side or server
side?
