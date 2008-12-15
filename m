From: "Constantine Plotnikov" <constantine.plotnikov@gmail.com>
Subject: Re: Interactive rebase encoding
Date: Mon, 15 Dec 2008 19:21:07 +0300
Message-ID: <85647ef50812150821g4a032af0u31425fd7f4c0fd9@mail.gmail.com>
References: <85647ef50812150442n48609eadl4f3e47fcc715e643@mail.gmail.com>
	 <alpine.DEB.1.00.0812151652400.30769@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Dec 15 17:22:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCGDF-0004jl-DT
	for gcvg-git-2@gmane.org; Mon, 15 Dec 2008 17:22:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753094AbYLOQVL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Dec 2008 11:21:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752914AbYLOQVK
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Dec 2008 11:21:10 -0500
Received: from mail-bw0-f21.google.com ([209.85.218.21]:47976 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752436AbYLOQVJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Dec 2008 11:21:09 -0500
Received: by bwz14 with SMTP id 14so2197555bwz.13
        for <git@vger.kernel.org>; Mon, 15 Dec 2008 08:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=gG16MqukFY+TpaVfhYlOYB5L1IrbjdM6UX0bpeaFBiU=;
        b=T/ySHOITcZaToPBGq7rBAGpp2oe3k6CDnhY+0PG1T2BbFFG18z7M/EC11ekCWZRtMM
         Zf84w57xmyEFAIxycd9kNs3AFk+07PlTmnBwTJg2yeDKOtxO4dUwLojlVSaTlpLGbuLm
         smiFz6y22yanvX+4r9lKSbwsdYw22TB7lKC/U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=OiZhjQZG4K50AcY2I4h4vCg7CMqYgQiPbc9WpiGvThd71+c5H/XwhJ0PBOVs6YvGlb
         eslpqHusS8jueHmNBrgEeasXFaqRYNUbWuswzut9Dw9QW3uu/L/DhlxZTsdCjodqvqKV
         r8NqGdJWql7zzbhWGXklqFxqK58Zs5D2Q+g/c=
Received: by 10.180.250.7 with SMTP id x7mr2574189bkh.175.1229358067727;
        Mon, 15 Dec 2008 08:21:07 -0800 (PST)
Received: by 10.181.143.16 with HTTP; Mon, 15 Dec 2008 08:21:07 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0812151652400.30769@pacific.mpi-cbg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103178>

On Mon, Dec 15, 2008 at 6:54 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Mon, 15 Dec 2008, Constantine Plotnikov wrote:
>
>> The interactive rebase command builds a text file and passes it to
>> editor specified as environment variable or as configuration parameter.
>> However the man page for rebase operation says nothing about which
>> encoding will be used for that file. Apparently i18n.logoutputencoding
>> is used.
>
> As rebase -i does nothing else than piping the output of git log into a
> file (at least this is the first step), I thought it would be obvious that
> it uses the output encoding preferred by the user.

Yes. That was my first hypothesis, but I had to check it through small
experiment and source code examination. And if consider the bug
described in the thread
http://kerneltrap.org/mailarchive/git/2008/11/11/4063184, the
hypothesis might have been incorrect.

>
> Indeed, I cannot think of any scenario where it might make sense to have a
> different encoding in git rebase -i than in git log.
>

For IDE, it might make sense to force UTF-8 encoding instead of using
currently configured logoutputencoding. Currently the extra call to
git config is needed to check expected encoding of the file before
data could be shown to the user. Also user specified encoding might
fail to display some characters in commit messages that was encoded
using other encodings, forcing UTF-8 would have also fixed this
problem as well.

BTW for IDEs an option that causes non-abbreviated commit hashes would
have been useful as well.

Constantine
