From: Marko Kreen <markokr@gmail.com>
Subject: Re: [PATCH] compat: Add another rudimentary poll() emulation
Date: Thu, 27 May 2010 14:39:13 +0300
Message-ID: <AANLkTikfaWVEPkHBRF8WHNWmyXIH9f7wRju1wSRC_lwm@mail.gmail.com>
References: <1274948384-167-1-git-send-email-abcd@gentoo.org>
	<1274948384-167-2-git-send-email-abcd@gentoo.org>
	<20100527101043.GA4390@progeny.tock>
	<AANLkTikYa2vq4PrKrO2QIkHVxYqbhUZRw42kQq875FNT@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Jonathan Callen <abcd@gentoo.org>, git@vger.kernel.org,
	mduft@gentoo.org, Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Johannes Sixt <j6t@kdbg.org>,
	msysGit <msysgit@googlegroups.com>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Thu May 27 13:39:20 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHbQl-00064B-J2
	for gcvg-git-2@lo.gmane.org; Thu, 27 May 2010 13:39:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755158Ab0E0LjP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 May 2010 07:39:15 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:58414 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754820Ab0E0LjO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 May 2010 07:39:14 -0400
Received: by gyg13 with SMTP id 13so3882258gyg.19
        for <git@vger.kernel.org>; Thu, 27 May 2010 04:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=0S1WjlKBp3rH0uwVacKsw3ZGznWYIH+pC71YDFvXllw=;
        b=aYjRvlxDNF3bBctLJERQSAwycxYZ4TFprhWLO5t8k5wslN07WhzGzbkt7Ehs226xTu
         +pMAA9Jm7NFocx/jOClZwlX73Wy3eZaVP7w4S8heSgZroTJ1NIuouzocgm/d+ZafPuiA
         7ykB61Pp4e2CLkt0fKhXP0pvK/Mw5axXAI95Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=q3odW5dFw+GZ++MV/ZoK2tysqt7cdDZDMd4HjnscdLa8zXNmLHBkfeudmHc+PbbwUA
         M1U+PxfZf2YzW8KUNsxVcH14sXUukVTaq4BpoB8V8iP4K9+KDIT6M9I2Gy0IikSbLEyR
         h+PpnSeJYiDBcxrTfN8Q8G3+T6EjCtTbKLo/4=
Received: by 10.150.14.5 with SMTP id 5mr58351ybn.17.1274960353407; Thu, 27 
	May 2010 04:39:13 -0700 (PDT)
Received: by 10.151.48.11 with HTTP; Thu, 27 May 2010 04:39:13 -0700 (PDT)
In-Reply-To: <AANLkTikYa2vq4PrKrO2QIkHVxYqbhUZRw42kQq875FNT@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147846>

On 5/27/10, Erik Faye-Lund <kusmabite@googlemail.com> wrote:
> On Thu, May 27, 2010 at 12:10 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>  > Implement the subset of poll() semantics needed by git in terms of
>  > select(), for use by the Interix port.  Inspired by commit 6ed807f
>  > (Windows: A rudimentary poll() emulation, 2007-12-01).
>  >
>
>
> A possible problem with this approach is that the maximum number of
>  file descriptors poll can handle limited by RLIMIT_NOFILE, whereas the
>  maximum number of file descriptors select can handle is limited by
>  FD_SETSIZE.
>
>  I don't think this is a big problem in reality, though - both values
>  seem to be pretty high in most implementations. And IIRC git-daemon is
>  the only one who needs more than 2, and it doesn't even check
>  RLIMIT_NOFILE.
>
>  If we decide to go this route, perhaps it'd make sense to change to
>  this code for Windows also? Our Windows-implementation of poll() has
>  some annoying limitations...

Example of poll() compat without FD_SETSIZE limit:

  http://github.com/markokr/plproxy-dev/blob/master/src/poll_compat.c

-- 
marko
