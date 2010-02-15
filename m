From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH] don't use mmap() to hash files
Date: Mon, 15 Feb 2010 15:25:27 +0300
Message-ID: <37fcd2781002150425od069e75ueaff424e2357d78b@mail.gmail.com>
References: <20100211234753.22574.48799.reportbug@gibbs.hungrycats.org>
	 <20100214011812.GA2175@dpotapov.dyndns.org>
	 <alpine.DEB.1.00.1002140249410.20986@pacific.mpi-cbg.de>
	 <20100214024259.GB9704@dpotapov.dyndns.org>
	 <alpine.DEB.1.00.1002141908150.20986@pacific.mpi-cbg.de>
	 <37fcd2781002141106v761ce6e0kc5c5bdd5001f72a9@mail.gmail.com>
	 <alpine.DEB.1.00.1002142021100.20986@pacific.mpi-cbg.de>
	 <alpine.DEB.1.00.1002142025160.20986@pacific.mpi-cbg.de>
	 <37fcd2781002141156n7e2b9673s1eb6c12869facdb2@mail.gmail.com>
	 <4B78FC36.1090108@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Zygo Blaxell <zblaxell@esightcorp.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Thomas Rast <trast@student.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Mon Feb 15 13:25:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nh019-00080T-Vt
	for gcvg-git-2@lo.gmane.org; Mon, 15 Feb 2010 13:25:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755439Ab0BOMZa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2010 07:25:30 -0500
Received: from mail-fx0-f215.google.com ([209.85.220.215]:39764 "EHLO
	mail-fx0-f215.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754879Ab0BOMZ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2010 07:25:29 -0500
Received: by fxm7 with SMTP id 7so5630657fxm.28
        for <git@vger.kernel.org>; Mon, 15 Feb 2010 04:25:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=FkLuaSNuGFyAV/yh4GkkHAo+y8dXr/oSnpCTjGONSck=;
        b=vPGtkICz5mFR85iZRlbdpcJV92apbpdT/dk+Qdyl7cH8t+17RCLQBGhr+jDeVZKkKz
         Tgwhv+JfiNwDcWu6eX0R+1IURzpd0NTvF/tLKjb3rvLTReSxAUe1Ur4zBApkeM+78f9p
         3B3asQfKGGSST50xvuUAtzTHMPNB06UGgL/wE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=DxkfSp6y/YumkEClvO4R/zJACId6YbUt6oodN9QemwIOk4bJyPIxxOUzjIO69ce1np
         pwGYx3tS5KFmExQNluiwgvpaXz83S+bxVCxMznuDWAzXEa7MFgUCl7eOUou0glyq48mD
         JFZV6QFlE6aVvSap0wEp/wPQRf/+Jb1G9AqLk=
Received: by 10.239.193.141 with SMTP id j13mr498666hbi.188.1266236727680; 
	Mon, 15 Feb 2010 04:25:27 -0800 (PST)
In-Reply-To: <4B78FC36.1090108@gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140006>

On Mon, Feb 15, 2010 at 10:48 AM, Paolo Bonzini <bonzini@gnu.org> wrote:
> On 02/14/2010 08:56 PM, Dmitry Potapov wrote:
>>
>> It may not work without enough swap space
>
> No, the kernel will use the file itself as "swap" if it has to page out the
> memory (since the mmap is PROT_READ).

I was speaking about read(), when the whole file is read  in memory. In
this case, you are going to use a lot of "swap" and it is not pretty...
That's why I said maybe we should have an option here...


Dmitry
