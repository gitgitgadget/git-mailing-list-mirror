From: Bob Kagy <bobkagy@gmail.com>
Subject: git archive, cygwin, and --git-dir vs --remote
Date: Mon, 18 May 2009 09:37:14 -0500
Message-ID: <e664dae0905180737mae29811ie4cae889b3e3904f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 18 16:37:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M63y0-0006E6-CC
	for gcvg-git-2@gmane.org; Mon, 18 May 2009 16:37:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752924AbZEROhQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 18 May 2009 10:37:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752863AbZEROhP
	(ORCPT <rfc822;git-outgoing>); Mon, 18 May 2009 10:37:15 -0400
Received: from mail-qy0-f112.google.com ([209.85.221.112]:60272 "EHLO
	mail-qy0-f112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752453AbZEROhO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 May 2009 10:37:14 -0400
Received: by qyk10 with SMTP id 10so1270677qyk.33
        for <git@vger.kernel.org>; Mon, 18 May 2009 07:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=vKB4SSnjepOsVYff4+VlvnQPHhlmFc/FOXVEke6qGj4=;
        b=f74Mais8dDH30Yyo0XkX1QOrrM/cLU9LsI4ObHqY7BiNjZy1DaOOGX0wG2gqa3TkYG
         FTLLzI0XyWtEM3UztWzdYauRlvJ6pSVdOn9LJnfs7eVPMOhBrtGgwjnxslmqsYKApTCH
         roC91OVgDnGv5fNKmOUqRL+Fm6byAL7WQj3hk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=hAnxqfpiYCgLwnnqcDdA+Yw29Fjt8KoL9PU4xXJcdUV0+wixBPM0P1ZE/lDJvFxEl0
         thSGVnN2qpUeqFT4em11g0UTl8YypRHburybV6JPKfVN/scL1nvMxk+jRzVYerfsFg9g
         T4k4t67mj87MyXM2W3RzM04WS2az+S6FFZzzQ=
Received: by 10.224.54.9 with SMTP id o9mr6346486qag.269.1242657434954; Mon, 
	18 May 2009 07:37:14 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119444>

I'm using git on cygwin, and am confused by behavior from git archive.

git --version
git version 1.6.1.2

This command works as expected:
git --git-dir=3D/cygdrive/w archive --format=3Dtar --verbose --prefix=3D=
tmp/
HEAD | tar -xpf -
The latest copy is retrieved and dumped to the tmp subdirectory.

However, I first went down the path of using the --remote option, as
described in the git-archive man page:
git archive --format=3Dtar --verbose --prefix=3Dtmp/ --remote=3D/cygdri=
ve/w
HEAD | tar -xpf -

When I use the --remote branch it seems to create the same files.=C2=A0=
 But
then rather than exiting it hangs out until I kill the process, using
about the same CPU % as it did when creating files.

I'm trying to use this for a scripted build process where all I need
is the latest copy, not an archive.=C2=A0 And we're just starting with =
git,
so while it works fine now I think we're supposed to be switch from
shared drives to something more controlled, at which point I don't
know that the --git-dir option will work.

I've tried searching the mailing list archive, and got overwhelmed by
patches, so I apologize if this has already been discussed and I just
couldn't find it.
