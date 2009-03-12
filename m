From: John Tapsell <johnflux@gmail.com>
Subject: Re: git checkout -b origin/mybranch origin/mybranch
Date: Thu, 12 Mar 2009 16:16:09 +0000
Message-ID: <43d8ce650903120916yb91113fy5485813c512c8108@mail.gmail.com>
References: <43d8ce650903120436u261cb7e3p838e4a12e7b54d7d@mail.gmail.com>
	 <alpine.DEB.1.00.0903121240400.10279@pacific.mpi-cbg.de>
	 <43d8ce650903120448x51220ba0k660be7706acba755@mail.gmail.com>
	 <alpine.DEB.1.00.0903121357320.6335@intel-tinevez-2-302>
	 <43d8ce650903120618h79686207vaa478c54f34e26f8@mail.gmail.com>
	 <fabb9a1e0903120643r3cfefdfej560ff7edda2be6f5@mail.gmail.com>
	 <B9479687-D936-4EE1-A5A4-663968B76EBF@ai.rug.nl>
	 <20090312153738.GA24690@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pieter de Bie <pdebie@ai.rug.nl>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 12 17:31:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhnbS-0004oo-AQ
	for gcvg-git-2@gmane.org; Thu, 12 Mar 2009 17:17:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756702AbZCLQQP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Mar 2009 12:16:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754098AbZCLQQO
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 12:16:14 -0400
Received: from mail-qy0-f122.google.com ([209.85.221.122]:58779 "EHLO
	mail-qy0-f122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756674AbZCLQQN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Mar 2009 12:16:13 -0400
Received: by qyk28 with SMTP id 28so1119329qyk.33
        for <git@vger.kernel.org>; Thu, 12 Mar 2009 09:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=TAYe91Umalp0//DtpeOYKCzpkvjCYri7jHReVVQrd9Y=;
        b=dyYcCyWSifD6wmAW2dUpM+SwVrLI6bmIv09908OlAecRMC3l6w32ZRQfAyzOIoRxUt
         9ES9cQGGxyJRSf0JiSFORoaaYMubBI3FRcoxnMrRINuBxGbzlp5riXoz7E/QPD/V+m7O
         13humgP6W61XtV4u2f+EgksGYawjgaNLmZfP0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=wuSu7XTiSYmRN7CJrvvh3ANzCk8YH3SqAvBlbsdslxjkNPM8l6FCEFegLzzZMuZ4dm
         IpZEgHpRlpQMalB2iSZyf/4M1X2shMt32TTmROt0f+HEbm9rMIk7y7gjUX9NU6LrN9RX
         XZEdMJfbiGSc5F218ezBa043X3zCEnP3vLcrQ=
Received: by 10.142.165.21 with SMTP id n21mr16095wfe.56.1236874569846; Thu, 
	12 Mar 2009 09:16:09 -0700 (PDT)
In-Reply-To: <20090312153738.GA24690@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113083>

2009/3/12 Jeff King <peff@peff.net>:
> On Thu, Mar 12, 2009 at 03:21:48PM +0000, Pieter de Bie wrote:
>
>> You can also get this in other interactions, for example:
>>
>> =C2=A0 =C2=A0 =C2=A0 $ git checkout -b origin/test HEAD
>> =C2=A0 =C2=A0 =C2=A0 $ git checkout -b origin/test master
>>
>> yes, these might be user errors, but I still think it's not OK to cr=
eate a
>> new ref 'refs/heads/origin/test' if there's also a 'refs/
>> remotes/origin/test' (as I've said a few months ago).
>
> One thing that has been missing from this discussion (and I think you
> are getting to it here) is a concrete rule for "X is harmful, and Y i=
s
> not". That is, how do we know when to warn, and then what do we do?
>
> John's original example was "git checkout -b origin/test origin/test"=
=2E
> So it's a problem that they're textually the same, but obviously ther=
e
> are more problematic cases.
>
> The behavior I think you are implying would be something like:
>
> =C2=A0When making origin/test, try to resolve_ref("origin/test"); if =
it
> =C2=A0fails, we are OK. If it succeeds, then we know we will be creat=
ing an
> =C2=A0ambiguity. Complain and refuse the creation unless "-f" is give=
n.
>
> This would actually be a superset of the "branch already exists" case=
,
> so it should be pretty simple to code, and it makes for a simple rule=
:
> it is now "ref already exists".

+1

I was thinking more along the lines of checking if it begins with
remotes/, origin/, tags/, stash/, bisect/    and blacklisting these.

Can anyone suggest a reason that you really might want to create a
branch called  origin/something ?


> Does that actually cover all of the problematic cases?
>
> -Peff
>
