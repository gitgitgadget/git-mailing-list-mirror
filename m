From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH 2/2] wt-status: take advice.statusHints seriously
Date: Fri, 23 Apr 2010 12:15:56 +0800
Message-ID: <q2ibe6fef0d1004222115gcdd8fd81xce8993508bfa9f5d@mail.gmail.com>
References: <c7003ec93f4ea01be80fbba08d2ed5544fa0df4d.1271968072.git.git@drmicha.warpmail.net>
	 <7v39yo53mt.fsf@alter.siamese.dyndns.org>
	 <86a4d8e5df80008c5c2b3ff4f2a5842ad1f58dc4.1271968072.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Apr 23 06:16:06 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5AJA-0000Pi-Ka
	for gcvg-git-2@lo.gmane.org; Fri, 23 Apr 2010 06:16:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753025Ab0DWEP6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Apr 2010 00:15:58 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:51142 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752487Ab0DWEP5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Apr 2010 00:15:57 -0400
Received: by gyg13 with SMTP id 13so4917413gyg.19
        for <git@vger.kernel.org>; Thu, 22 Apr 2010 21:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=2Ro+g2mkHpQwj2GGyExgXa9W3rFOFzfXBNJeEkVGNdM=;
        b=IonR4+rbusZPwrLjUZq5Z/OEgneZDXkT3R/Qp5WpYuAXq0rv6u/Sd3YWrS05nyr17H
         wxiczVY6TcNh7zPleGEqnX0z62GcHy0ZIta0uM9FBzsTpV8qmsymxo+M1XV+4o4W/Ghe
         IFNOdidmVMFrUN4g2gM3VhnT47eXGBalN8zUE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=omdFAzErSErQahcuwXf2dQU1PkIu6B8LX17zrDBrmZpSv3N0HtyH0yRrJyEDZlrMnM
         jDPE4gZ1wChOJTBrVAZkMTaJbzfBDIXx89WJl7A4YK2eMw9LVgx4SkJ3kbLpkFyiJxbk
         15eDWhJGIqvXtIh+HqnVqBwTal3bRnes1tLJo=
Received: by 10.231.36.201 with HTTP; Thu, 22 Apr 2010 21:15:56 -0700 (PDT)
In-Reply-To: <86a4d8e5df80008c5c2b3ff4f2a5842ad1f58dc4.1271968072.git.git@drmicha.warpmail.net>
Received: by 10.101.181.21 with SMTP id i21mr14323491anp.106.1271996156321; 
	Thu, 22 Apr 2010 21:15:56 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145585>

Hi,

On Fri, Apr 23, 2010 at 4:30 AM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else if (s->untracked.nr)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printf("nothing added t=
o commit but untracked files present (use \"git add\" to track)\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printf("nothing added t=
o commit but untracked files present%s\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 advice_=
status_hints
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ? " (us=
e \"git add\" to track)" : "");

while we're at it, perhaps we could put the hints on its own line,
with a "hint: " prefix:

  nothing added to commit but untracked files present
  hint: use "git add" to track

This way, we give future git usability hackers the space to elaborate
further on why a certain flag or command was recommended.

--=20
Cheers,
Ray Chuan
