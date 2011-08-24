From: Vitor Antunes <vitor.hda@gmail.com>
Subject: Re: [PATCH/RFC 2/2] git-p4: Add complex test case for branch import
Date: Wed, 24 Aug 2011 22:23:17 +0100
Message-ID: <CAOpHH-Uv=zK9JoL+ooA9eEHg2XyX=k92hL1QZ_WNZwgvpnNj0g@mail.gmail.com>
References: <1313712590-26876-1-git-send-email-vitor.hda@gmail.com>
 <1313712590-26876-3-git-send-email-vitor.hda@gmail.com> <20110820191203.GC7135@arf.padd.com>
 <20110822011319.0a013117@fenix.utopia.dhis.org> <20110823022713.GA6005@arf.padd.com>
 <CAOpHH-V92CcWm1tCwvb=pJux5PKbYQoG=E8M_Pc2JGu00wnR8Q@mail.gmail.com>
 <20110823231034.GA11918@arf.padd.com> <CAOpHH-V9nm2NRD47gdUj6sLJSTypjABjE-JGCkADE=fxh2nSWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Tor Arvid Lund <torarvid@gmail.com>
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Wed Aug 24 23:23:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwKvQ-0002zJ-TV
	for gcvg-git-2@lo.gmane.org; Wed, 24 Aug 2011 23:23:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753758Ab1HXVXs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Aug 2011 17:23:48 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:49630 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753560Ab1HXVXr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Aug 2011 17:23:47 -0400
Received: by iye16 with SMTP id 16so2763645iye.1
        for <git@vger.kernel.org>; Wed, 24 Aug 2011 14:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=aErHpLRAO/LSroLjaK1j9UXGjqPHVdQyj3x193nl7dM=;
        b=JqdtSU5Yedu4TsRWBlJXuRXYClS3Wnymbfb6jt9vP+8ZIeGd9nEX1I+9GsJmbr1OrY
         uvJ0wQURUKK/Vzd2LLEoXwwUWER60lKgrDlMMvZZWEwgSThLTq0hrq4lyhS7uoESAJE9
         muxykGpzrHnvz1Ibvrq+zVliv81fgwz+xnk94=
Received: by 10.231.57.103 with SMTP id b39mr10990132ibh.41.1314221027105;
 Wed, 24 Aug 2011 14:23:47 -0700 (PDT)
Received: by 10.231.31.140 with HTTP; Wed, 24 Aug 2011 14:23:17 -0700 (PDT)
In-Reply-To: <CAOpHH-V9nm2NRD47gdUj6sLJSTypjABjE-JGCkADE=fxh2nSWg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180043>

On Wed, Aug 24, 2011 at 11:46 AM, Vitor Antunes <vitor.hda@gmail.com> w=
rote:
> 1. When doing a "checkpoint" it would make sense to have some kind of
> =A0 feedback loop to know when fast-import completes it. In fact, I'v=
e
> =A0 just looked at fast-import man page and the "progress" command se=
ems
> =A0 to do exactly that! Myabe we should crease a specific function fo=
r
> =A0 "checkpoint" that would call also "progress" instead of calling
> =A0 os.sleep().

    # Force a checkpoint in fast-import and wait for it to finish
    def checkpoint(self):
        self.gitStream.write("checkpoint\n\n")
        self.gitStream.write("progress checkpoint\n\n")
        out =3D self.gitOutput.readline()
        if self.verbose:
            print "checkpoint finished: " + out

This seems to work! :)

> 2. In order to avoid needing to use "--force" it would be nice to hav=
e
> =A0 some form of "drop" command in fast-import that would allows us t=
o
> =A0 actively drop an older commit after calling "reset" (this could e=
ven
> =A0 be an option of "reset"). This way fast-import would not find
> =A0 dangling commits in the end of the import. =A0Maybe there's alrea=
dy
> =A0 some sort of command to achieve this in fast-import...? We could
> =A0 probably ask to one of its maintainers.

Just missing point 2 now.

--=20
Vitor Antunes
