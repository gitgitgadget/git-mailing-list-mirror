From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: [RFC 0/2] Git-over-TLS (gits://) client side support
Date: Wed, 13 Jan 2010 18:51:03 -0500
Message-ID: <32541b131001131551m38ff02acpdd08d9f0562ac84d@mail.gmail.com>
References: <20100113144745.GA7246@Knoppix> <20100113173610.GA7609@Knoppix> 
	<20100113183520.GA23674@inner.home.ulmdo.de> <20100113191802.GA8110@Knoppix> 
	<32541b131001131130i6afae1a1xd3a70e5de5daa5cf@mail.gmail.com> 
	<20100113200629.GA8383@Knoppix> <32541b131001131213m75b4baefsc70a4cbf3c8431c8@mail.gmail.com> 
	<20100113210414.GA8535@Knoppix> <32541b131001131403u162bc6ebpd551ed19aadde7fb@mail.gmail.com> 
	<20100113230023.GA9171@Knoppix>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andreas Krey <a.krey@gmx.de>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Thu Jan 14 00:51:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVCzo-0005KV-Up
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jan 2010 00:51:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756643Ab0AMXvZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Jan 2010 18:51:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756638Ab0AMXvZ
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 18:51:25 -0500
Received: from mail-yw0-f176.google.com ([209.85.211.176]:58231 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753436Ab0AMXvY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Jan 2010 18:51:24 -0500
Received: by ywh6 with SMTP id 6so23787088ywh.4
        for <git@vger.kernel.org>; Wed, 13 Jan 2010 15:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=zBfcO1Cd5zMCif53z/GGcpxBiYiuxudrgZ8W084rV9U=;
        b=CrYNFAvYDPdqXFIu/O/iO7MhbsXQI20HpD202UJf58Czo4JCO0Ffk+CuvbaYBNFoHi
         W2zWJdPD3euc4XqjpHyEc1Ug6GjeJRmwP8XyBzNCyjxkoAzs58vC6EYnhAy9VvuFnb6s
         On9SHizpfgGyjjUA0diRAwzmdAvjTLhUGtzOI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=NSVc1Esp0tSuCaKzEWVPjfenBXynzqS4rHW+KpwOtRQzQ7GIw7OgP+mJS5AjQ81ozq
         I4KbiiFtlUztkx6++im005JzbUQ/HQYmACk/wSa9Br58w5fiD4z4Alc/Yj+3zZPZ81Ra
         bH/WPyuPOwG22RwGD+RjuKpQ8MvSq3jEBZPGo=
Received: by 10.101.149.28 with SMTP id b28mr10434275ano.85.1263426683306; 
	Wed, 13 Jan 2010 15:51:23 -0800 (PST)
In-Reply-To: <20100113230023.GA9171@Knoppix>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136898>

On Wed, Jan 13, 2010 at 6:00 PM, Ilari Liusvaara
<ilari.liusvaara@elisanet.fi> wrote:
> On Wed, Jan 13, 2010 at 05:03:45PM -0500, Avery Pennarun wrote:
>> This is still not very illuminating. =A0How do you know your replace=
ment
>> will not have these same failure modes?
>
> No client-side fallbacks, key auth works pseudonymously. That takes
> care of them pretty well.

Perhaps I'm being dense, but I don't understand what you mean by
either of those.

>> If you solve your main
>> annoyances with ssh, how do you know you won't introduce any new
>> annoying failure modes?
>
> Ensuring that at least some information make back to client (presuabl=
y
> enough to figure out the problem).

Unfortunately revealing information like that is a compromise; it
helps attackers as well as legitimate users.  It's the same reason
login prints "invalid username or password" instead of choosing
between "invalid username" and "invalid password."

If you reveal more information than ssh, you'll be accused of being
less secure.  And since the purpose of your protocol is security, this
is a problem.

>> *Why* can't ssh be fixed to solve the =A0problem?
>
> Client side fallbacks (may be desired or not!), service not being
> able to intervene on wheither to allow client or not in case of
> keypair auth.

I don't understand that answer.  Couldn't ssh be patched to do
whatever you want?  Particularly if it's just better (optional)
diagnostics, you'd think someone would accept the patch for that.

>> =A0Will I have to generate and manage yet another new set of
>> keys to use the new system?
>
> Yes.

Ouch.

>> (Even if
>> ssh is hard to set up, I've *already set it up*, so any new
>> alternative starts with an immediate negative score.)
>
> Well, if you like SSH more, then use ssh://...

I'm just looking for a justification for why I *shouldn't* like ssh
more.  Is the only reason the fact that it might be easier to
initially configure the key exchange?

Avery
