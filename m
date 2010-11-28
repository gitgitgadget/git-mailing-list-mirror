From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: gitweb: false base href sent when integrated via reverse proxy
 and path_info is active
Date: Sun, 28 Nov 2010 18:25:48 +0100
Message-ID: <AANLkTinM8qyL9DafMx4XWBQ5RUeWABKVc5mNjdVEkQfZ@mail.gmail.com>
References: <20101128081048.13668.67286.reportbug@sb74.startrek> <20101128162720.GB18335@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Daniel Reichelt <debian@nachtgeist.net>,
	Jakub Narebski <jnareb@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 28 18:26:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PMl0y-0002ih-Nh
	for gcvg-git-2@lo.gmane.org; Sun, 28 Nov 2010 18:26:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753769Ab0K1R0L convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 28 Nov 2010 12:26:11 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:39989 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753429Ab0K1R0K convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 28 Nov 2010 12:26:10 -0500
Received: by iwn7 with SMTP id 7so55295iwn.19
        for <git@vger.kernel.org>; Sun, 28 Nov 2010 09:26:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=ZUNGBFKzt7EyAeslTrpeoqKxiqAAfeHoQY0Y86jqa54=;
        b=mbfioykIr2YiRt34pgG13949fDsbvkBsTZlJEvqRwwLJ7RAVF+KjTPxOCDUcohWyXU
         hG9yukcVoGHrIbXWJlgw6ZizbmhA/Hz+SR22lEz+bYl+1bGGTXdnSFddo5VR6Ud93Ux/
         cQu7qoHYvRdyEwQnNyg5wcLlFZ/fGRIFZ8gBk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Mwdyukc2WTQjxNGzCiYJtgKNrUIGSmkdmZgDZiMXsSlS/dPrJ8TyJhvDFgh6B3KbC6
         UXPmaUGJ7WVlGsvjXc8y1TnfG0r34mYRAXH1B5DlSVEjqPfB/tit9TgWkybznQK4HLV5
         wel9+qTp+PM7acruq5826vlVGcTfuSP9EFO90=
Received: by 10.231.14.10 with SMTP id e10mr4384250iba.132.1290965169251; Sun,
 28 Nov 2010 09:26:09 -0800 (PST)
Received: by 10.231.17.135 with HTTP; Sun, 28 Nov 2010 09:25:48 -0800 (PST)
In-Reply-To: <20101128162720.GB18335@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162342>

On Sun, Nov 28, 2010 at 5:27 PM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Hi Jakub et al,
>
> Daniel Reichelt wrote[1]:
>
>> I just noticed that integrating gitweb via reverse proxy is impossib=
le when
>> path_info is enabled in gitweb.conf. The base href sent on gitweb.cg=
i:3427
>> contains the "internal" URL called by the reverse proxy mechanism, n=
ot the
>> original one called by the user agent which makes it impossible for =
the
>> client to display CSS, images, etc...
>>
>> I suggest an additional config variable, e.g.
>> $feature{'pathinfo'}{'basehrefoverride'} which could override the ba=
se href
>> tag determinted by the cgi script (or disable sending a base href ta=
g at all
>> - at least I was able to achieve my desired setup by adjusting the U=
RLs for
>> CSS etc in gitweb.conf to fitting absolute URLs).
>
> Any advice for Daniel? =A0Is it a good idea?

I'm not familiar with the way reverse proxies operate. Is there some
information that the script can scrape to understand that its request
is being reverse-proxied? Or are there options that the reverse
proxies can be configured with to pretend that the URL is not being
rewritten? These would be better solutions.

Lacking that, a plain

our $base_url  =3D 'whatever';

in the gitweb config should probably work, as the gitweb config is
evaluated _after_ the internal URI variables are set. Can the bug
submitter confirm that this does indeed work?

--=20
Giuseppe "Oblomov" Bilotta
