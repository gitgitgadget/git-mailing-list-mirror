From: Peter Harris <git@peter.is-a-geek.org>
Subject: Re: git repack and dumb protocols
Date: Thu, 4 Jun 2009 08:47:37 -0400
Message-ID: <eaa105840906040547o473801c8jca309c821282a091@mail.gmail.com>
References: <200906031950.56974.lists@informa.tiker.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?Andreas_Kl=F6ckner?= <lists@informa.tiker.net>
X-From: git-owner@vger.kernel.org Thu Jun 04 14:55:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCCTS-0003it-Q0
	for gcvg-git-2@gmane.org; Thu, 04 Jun 2009 14:55:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758211AbZFDMyh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Jun 2009 08:54:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757968AbZFDMyg
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Jun 2009 08:54:36 -0400
Received: from mail-ew0-f210.google.com ([209.85.219.210]:47360 "EHLO
	mail-ew0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758130AbZFDMyg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Jun 2009 08:54:36 -0400
X-Greylist: delayed 419 seconds by postgrey-1.27 at vger.kernel.org; Thu, 04 Jun 2009 08:54:35 EDT
Received: by ewy6 with SMTP id 6so1072604ewy.37
        for <git@vger.kernel.org>; Thu, 04 Jun 2009 05:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=BnL5FgcYfnLcPr4YHyNqctmHcUkiCLDWaDYnX6aLFI4=;
        b=BEQ8el3/hNqMoRCGCOK7E2rvNDEYdADfNSRHhz3T7PnoTXdtw42ask/BuVr8/mcPRK
         BieoicasUPQUh7F2MAYoEa0GbhqEv1ZN87UmVCJ1EmCorPouIxpAaabJb8ajfkIXI4FY
         wGIqL04NcvwbUXX8qecVLAhboQG0vEAyUCsbU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=cSzLZnKAybzvVX7dB8T6iKHDdvRB+DufVYQLH3jhOqAFW6IQxA/jxvBobVW7F3+Y1l
         lTHUegOLypW24W/rHVhyEmmoQYtloUi/WOR6abME+9E/57+XfiDMqSdWT2y9EiIb7y36
         Y4ed8jYo8GWhqdMI+GeqvGQOITuUik5mfJe7A=
Received: by 10.210.63.18 with SMTP id l18mr1898018eba.97.1244119657825; Thu, 
	04 Jun 2009 05:47:37 -0700 (PDT)
In-Reply-To: <200906031950.56974.lists@informa.tiker.net>
X-Google-Sender-Auth: 7c1c0fa9ec4c1244
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120696>

On Wed, Jun 3, 2009 at 7:50 PM, Andreas Kl=F6ckner wrote:
>
> 8< ------------------------------------------------------------------=
----
> Especially useful when packing a repository that is used for private
> development and there is no need to worry about people fetching via d=
umb
> protocols from it. 8<
> ---------------------------------------------------------------------=
-
>
> It says this relating to the '-a' option, but it makes me wonder if I=
'll break
> copies of the repo that other people have pulled if I use 'repack'? W=
hat are
> the possible interactions and things to keep in mind between repack a=
nd dumb
> protocols?

It won't break any copies, but it may cause excessive network use.

Dumb protocols can only fetch or not-fetch the entire pack. So if
someone hasn't fetched since the last push, the next time they do a
"git pull", they will retrieve the entire repository. Even if they
only need a single small commit.

As you can imagine, people using dumb protocols over slow connections
may become somewhat annoyed with the admin that often does a repack
-a.

You do want to repack (usually without -a -- but see also ".keep")
periodically, though. Working out a schedule depends on the activity
level of the repository, and is left as an exercise for the reader.

> In any case, I would like to suggest that the rather ominous-sounding=
 text in
> the manpage be replaced with something more concrete, i.e. "If you re=
pack an
> archive that has people fetching via dumb protocols from it, X, Y, an=
d Z will
> happen."

Patches welcome.

Peter Harris
