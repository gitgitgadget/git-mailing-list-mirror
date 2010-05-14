From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Git methodology question
Date: Fri, 14 May 2010 17:54:48 -0400
Message-ID: <AANLkTin40FdBUx75c0ENHU6PhsN3tPjy1dK-D6cxPgPX@mail.gmail.com>
References: <20100505033536.GB8779@coredump.intra.peff.net> 
	<cover.1273760226.git.git@drmicha.warpmail.net> <20100514060612.GA19652@coredump.intra.peff.net> 
	<4BED7574.4070503@drmicha.warpmail.net> <F802F7F4D3C2674881AB105A9CD324A804EE0D0D8D@azsmsx504.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "Akhbari, Farshad" <farshad.akhbari@intel.com>
X-From: git-owner@vger.kernel.org Fri May 14 23:55:18 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OD2qk-0003eV-Ai
	for gcvg-git-2@lo.gmane.org; Fri, 14 May 2010 23:55:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759930Ab0ENVzL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 May 2010 17:55:11 -0400
Received: from mail-yx0-f191.google.com ([209.85.210.191]:42230 "EHLO
	mail-yx0-f191.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759614Ab0ENVzJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 May 2010 17:55:09 -0400
Received: by yxe29 with SMTP id 29so1254809yxe.4
        for <git@vger.kernel.org>; Fri, 14 May 2010 14:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=W/vcO+irpW9e8Dz4R2/4+vJqQ8yCUNFjkXcqzwMfEIo=;
        b=aKah0bhb5Vyb4h7VM6yLBfvkIAh2eDAOIvjLZeLmcIcB0KCRrD1T8BESDJDckcf2AO
         dtRWbbrJBYguDwoPTLj9h2bHvbPeBFJEktkJNnh1c+MV6Q3idvJnypluD5U7NTSPsYfG
         0YF7MVQT6HM4yWQxIWQ0E9NJGY++IZwJR0PFE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=flru1/TZ/WAjYXbTlrExChJKhthgRTXWKvqpgrSJib4wi7Vdq9s1xX7um+EDmCUHwD
         O1OAdR/FKaR602202FPPeXD8IOdo1kA+53MHR6lEtPPyIZKlwO+38qzOZJCPL9Zi4Fs6
         eOJoqo+4EmD8OqkXriJjtb5URt2Nbfpji7QN4=
Received: by 10.150.160.14 with SMTP id i14mr2895577ybe.144.1273874108135; 
	Fri, 14 May 2010 14:55:08 -0700 (PDT)
Received: by 10.150.217.12 with HTTP; Fri, 14 May 2010 14:54:48 -0700 (PDT)
In-Reply-To: <F802F7F4D3C2674881AB105A9CD324A804EE0D0D8D@azsmsx504.amr.corp.intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147124>

On Fri, May 14, 2010 at 12:14 PM, Akhbari, Farshad
<farshad.akhbari@intel.com> wrote:
> In order of time:
> User1 =96 pulls from the origin; updates, modifies, verifies and comm=
its into his clone. This will generate SHA1_1
> User2 =96 pulls from the origin; updates, modifies, verifies and comm=
its into his clone. This will generate SHA1_2
> User3 =96 pulls from the origin; updates, modifies, verifies and comm=
its into his clone. This will generate SHA1_3
>
> In none of these cases, anyone is updating from each other=92s clones
>
> At the end of the week, the model builder needs to merge and verify a=
ll commits from user1, user2 and user3 before pushing into the origin m=
aster.
>
> The question is,
> =A0 =A0 =A0 =A0 =A0 =A0Can the model builder use SHA1_3 tag only to g=
et all the updates made by user1, user2 and user3; or all SHA1 tags are=
 needed?

You will definitely need all three commit ids (SHA1_* in your words)
since all three commits are totally independent from each other.

In order for someone to *get* all three of those commits, they will
have to retrieve them somehow.  Generally, you do it in one of these
ways:

1) Run a git-daemon (or similar) on all three users' machines, and let
the model builder 'git pull' from all three servers

or

2) Have all three users 'git push' to a different branch on the
central repo, as in "git push origin HEAD:user1", "git push origin
HEAD:user2" and so on, and have the model builder merge all three
branches and then push the result back to master.

Of course, you could also have everybody pulling from / pushing to
master directly, but I guess that isn't what you're trying to
accomplish (it sounds like you want your "model builder" to be a
central maintainer who decides what does/doesn't get into the main
trunk).

Have fun,

Avery
