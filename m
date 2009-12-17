From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: diff attribute ignored by show and log -p
Date: Thu, 17 Dec 2009 00:23:49 -0500
Message-ID: <76718490912162123r49f9bd90n8e032c144d0cdbac@mail.gmail.com>
References: <76718490912162046k36e2a275gaf7672b38c7a63e4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Dec 17 06:23:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NL8qD-0004gi-Le
	for gcvg-git-2@lo.gmane.org; Thu, 17 Dec 2009 06:23:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751833AbZLQFXw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Dec 2009 00:23:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751799AbZLQFXv
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Dec 2009 00:23:51 -0500
Received: from mail-iw0-f171.google.com ([209.85.223.171]:64854 "EHLO
	mail-iw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751737AbZLQFXu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Dec 2009 00:23:50 -0500
Received: by iwn1 with SMTP id 1so1239242iwn.33
        for <git@vger.kernel.org>; Wed, 16 Dec 2009 21:23:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type;
        bh=NTZOn9opC0q6L9kZ3Hq02jmB7pBB1st/OAsihqzv3cE=;
        b=OKjXrFaCgdOrqQ5osCZK5IoMuPpRa+ueANqAGFCOsvrr35Fd0QBe8+G4Vd4eOQGwB6
         nB2OEa/B9Ou6ISun2CAuDzNFiT9qJWCr71n02DzonFA8COG0MaztGdwshOv7vP9LDDm7
         a2YeKz60uyEhQZiKD5+SdJJWyGeVM1QT0981Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        b=M7ak3t0uEildzrXbW0cOMPGIeKSn1iwTpc/fbiWn2bbbbfpOww5mBzumQhsUU3sDHF
         rng/9VI12sOOSjV7pf0J5co7D6xmOb4Inz2UDkVCj0TpYBNKyS/fzypFgMKexrIWJ4Uu
         qP5CNtostxG1+XyZx0nVIBelSqCVlNwW0ByUk=
Received: by 10.231.167.212 with SMTP id r20mr1993039iby.7.1261027429692; Wed, 
	16 Dec 2009 21:23:49 -0800 (PST)
In-Reply-To: <76718490912162046k36e2a275gaf7672b38c7a63e4@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135357>

On Wed, Dec 16, 2009 at 11:46 PM, Jay Soffian <jaysoffian@gmail.com> wrote:
> % cat .git/info/attributes
> *.xib diff=xibdiff
> % cat $(git config diff.xibdiff.command)
> #!/bin/sh
> trap "rm -f \"$2.tmp\" \"$5.tmp\"" 0 1 2 3 15
> ibtool --all "$2" > "$2".tmp
> ibtool --all "$5" > "$5".tmp
> colordiff -u "$2.tmp" "$5.tmp"
>
> Works great for things like:
>
> % git diff <commit1> <commit2> -- /path/to/*.xib
>
> But is apparently ignored by "git log -p" and "git show" which just
> use internal diff. Is this behavior intentional?

Ah, --ext-diff, and the reasoning behind requiring it for log/show is
explained in 72909be.

j.
