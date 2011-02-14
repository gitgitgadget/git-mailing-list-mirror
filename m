From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [1.8.0 RFD] Homogeneous use of short options
Date: Mon, 14 Feb 2011 14:03:01 -0500
Message-ID: <AANLkTi=PGwYz_GbYT3UR00UrhMi5KP_KU1y-+g+Qo1n9@mail.gmail.com>
References: <4D594460.1040206@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Feb 14 20:03:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pp3hy-0003TL-I7
	for gcvg-git-2@lo.gmane.org; Mon, 14 Feb 2011 20:03:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752330Ab1BNTDe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Feb 2011 14:03:34 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:34448 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751164Ab1BNTDc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Feb 2011 14:03:32 -0500
Received: by iyj8 with SMTP id 8so5122695iyj.19
        for <git@vger.kernel.org>; Mon, 14 Feb 2011 11:03:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=rqsW+RT1BU9w4QIfC5boSJVcY9hyWZMsbJqJixzFsds=;
        b=mQHl1ORbydo/rAaLfvjFPu1zKqSk+OMYKUEcgwnlGhnmNYa7bpsdmSYD9v3ZxmdMtS
         d1valWAMzapPclhZVbpzHGXCF+yUhiSsHUqKlRjp+HV8gSjuIBDfRW4WwMWlJyM48uRb
         P4d7x/0cbsv/qk2TA77aOQaTVolGoMNmsToH4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=xl9+lqHm0EaW4fEEN2Lz9NmaKrprrC+oM5BvNedxB1Gx7oCzr0yFjGGJ9HIyvH7gJf
         cy2/x3zfkGRes8IOoCp6//DB4Gv0cJfwo8wJOaveNpO6Bi/Xz/chuGUqI2v5O6jL/OX0
         6Cbf0GBhlJ96c7eKnpN2I26zo58gfIR/IxX6k=
Received: by 10.231.37.138 with SMTP id x10mr3170189ibd.192.1297710211898;
 Mon, 14 Feb 2011 11:03:31 -0800 (PST)
Received: by 10.231.40.2 with HTTP; Mon, 14 Feb 2011 11:03:01 -0800 (PST)
In-Reply-To: <4D594460.1040206@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166748>

On Mon, Feb 14, 2011 at 10:04 AM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> tag -v: This is not a real problem, but users have certain expections
> for "-f,-h,-n,-v" which we should break as rarely as possible. OTOH,
> what would "verbose" mean for tag? (NB: tag.txt is grossly wrong.)

I made mine look like branch -v:

$ cat bin/git-tagv
#!/bin/sh
format='
case %(objecttype) in
  commit)
    sha1=%(objectname:short)
    subject=%(subject)
    ;;
  tag)
    sha1=%(*objectname:short)
    subject=%(*subject)
    ;;
esac
printf "%s\t%s\t%s\n" %(refname:short) "$sha1" "$subject"
'
eval "$(git for-each-ref --shell --format="$format" refs/tags)" |
column -t -s "$(printf '\t')"

j.
