From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: OS X and umlauts in file names
Date: Wed, 25 Nov 2009 11:19:56 +0100
Message-ID: <46a038f90911250219p54badb6era2177e2f6484f6d9@mail.gmail.com>
References: <4B0ABA42.1060103@syntevo.com>
	 <alpine.LNX.2.00.0911231403100.14365@iabervon.org>
	 <4B0CEFCA.5020605@syntevo.com>
	 <46a038f90911250207o214b3952s67a022a017dbe2d9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Thomas Singer <thomas.singer@syntevo.com>
X-From: git-owner@vger.kernel.org Wed Nov 25 11:20:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDEyi-0004cF-26
	for gcvg-git-2@lo.gmane.org; Wed, 25 Nov 2009 11:20:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758496AbZKYKTw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Nov 2009 05:19:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758469AbZKYKTw
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 05:19:52 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:33675 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752242AbZKYKTv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Nov 2009 05:19:51 -0500
Received: by ewy19 with SMTP id 19so216220ewy.21
        for <git@vger.kernel.org>; Wed, 25 Nov 2009 02:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=msKrAkONTr2QykzsiT7KFsTtpRUbqLgUXPEoiMe7Juw=;
        b=VcqW4oYq3en3+BDDty4DnseEQrHWsOM0Sj4HsIGBOsm+HYbs/sMpvxi9GDC2anY0vy
         Qa5EEQKldyiVKIyGZNX9lsF0tby12Dcc9QufI//JWGUHGGALAuWIh7FcONWY6/qfrXEo
         7PLPg+wDWIVcJvM3N9VOnNRw5d2Ompnt9RT5c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ld7z+XNu5SxQzVcaTP72FJ8GvOxLr2ZmZJk3h8H/nRsQF+zTZCaII8XIGNk0SUZIFf
         Y3l6UR3Ah65u4J7DN1y9NLMXHLnAg7xuUBkKDmBmug0tJhREuRZN1YpAaZiD0JePn+O8
         fH0txThH7GlG9t5GXJVMnMe3zdQud/QDedClQ=
Received: by 10.213.0.218 with SMTP id 26mr7631051ebc.7.1259144396804; Wed, 25 
	Nov 2009 02:19:56 -0800 (PST)
In-Reply-To: <46a038f90911250207o214b3952s67a022a017dbe2d9@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133625>

On Wed, Nov 25, 2009 at 11:07 AM, Martin Langhoff
<martin.langhoff@gmail.com> wrote:
> On Wed, Nov 25, 2009 at 9:50 AM, Thomas Singer
> <thomas.singer@syntevo.com> wrote:
>> =A0toms-mac-mini:git-umlauts tom$ git stage "U\314\210berla\314\210n=
ge.txt"
>> =A0fatal: pathspec 'U\314\210berla\314\210nge.txt' did not match any=
 files
>
> does a find * | xargs git add work?

Also, you can try with `find * -print0 | git-update-index --add
--stdin -z `. Find should report the exact filename that the OS has,
and git should add it as it is.

Background: git-add used to be a trivial shell script wrapping around
git-update-index. If you have a git checkout, try:

 git show f25933987f29070e9cd79dfddf03018010e82e80:git-add.sh

If git cannot track this file in a pure OSX world, there is a good
chance it's a bug in git.

In in this narrow test case (single machine, running OSX) git *must*
be able to do the right thing. If you work on multi-platform projects
however, there is a good chance a Windows or Linux user will commit a
file with a name that _when you checkout on OSX_, OSX will save with a
different (but "equivalent") name due to its funny decomposition
rules. And all sorts of "fun" will ensue.

cheers,


m
--=20
 martin.langhoff@gmail.com
 martin@laptop.org -- School Server Architect
 - ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff
