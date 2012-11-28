From: Thomas Berg <merlin66b@gmail.com>
Subject: Re: Millisecond precision in timestamps?
Date: Wed, 28 Nov 2012 10:10:24 +0100
Message-ID: <CABYiQpnEZECU5Vj5JzMimtw-CAJQz2d=3rii4gM6d37wCnO5AA@mail.gmail.com>
References: <20121127204828.577264065F@snark.thyrsus.com>
	<CAJo=hJtZ+n+D4pOmeNApDeLNyZYeqnEDDYJWwSj_wLauQ+w4hQ@mail.gmail.com>
	<7vzk22lmz9.fsf@alter.siamese.dyndns.org>
	<20121127230419.GA26080@thyrsus.com>
	<CAJo=hJtOqRHcjWH1F71Qc5zvPkUAe+u1RrcC2pt_xQwLSUY0yg@mail.gmail.com>
	<20121128001231.GA27971@thyrsus.com>
	<CAMP44s3hpuxbo7mfKAD2trOkezPrV3nKYpNAzXOs3sQym102LQ@mail.gmail.com>
	<CAJo=hJuskvYaNTtCcTSqvU8YwEU=HwRpb_sqW-BSxfSr7xE57A@mail.gmail.com>
	<20121128011750.GA23498@sigill.intra.peff.net>
	<7v7gp6i3rx.fsf@alter.siamese.dyndns.org>
	<CABYiQpmEpdf3L56NYSvPWovNOs_ifqj5QctuPSMoygHyMrz8+g@mail.gmail.com>
	<CAMP44s3MPMySnwjWjzo4aRX05u05xratgiyiYJUYPmnV2WK6kQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Shawn Pearce <spearce@spearce.org>,
	Eric Raymond <esr@thyrsus.com>, git <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 10:10:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TddfJ-0006XB-Je
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 10:10:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752930Ab2K1JK2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2012 04:10:28 -0500
Received: from mail-lb0-f174.google.com ([209.85.217.174]:60392 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752357Ab2K1JK0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2012 04:10:26 -0500
Received: by mail-lb0-f174.google.com with SMTP id gi11so7385671lbb.19
        for <git@vger.kernel.org>; Wed, 28 Nov 2012 01:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=T7c4qVS+CbtFGH4FRklP0s9/SXOGN7cgSUcKhH27My0=;
        b=uDPcVtfn79dopiYDn3iHYfWkDcs9lv7yZu83bgnpp4ZCiuyAhTX/M14FoDyJzGSeoS
         tneIw6eccsCdghRZO1hLcuZVvCnfqqMNViYJHTE6u3/yR4y2vVbce1zjTpxMS5QETSzy
         WQ/vezktXIvIoSiHI2RYY4XOPz6dz5K9ForLdUXoG8HJeup6pnmPWNL7gwMIJEHwgby9
         0SvmoGa5pcXtKQlNF/f1V1shdbF6p0WQ0QfslXPhr466spSDWI1zOlX0FlWVgME078Eq
         gAOOuj1BQiUrQAr0tZ59bveHF8R0peLZ4fFstAZzJdPoKne+5XXRbj3ikHhwliEHW5O6
         CAAQ==
Received: by 10.152.113.225 with SMTP id jb1mr17217021lab.23.1354093824580;
 Wed, 28 Nov 2012 01:10:24 -0800 (PST)
Received: by 10.114.17.69 with HTTP; Wed, 28 Nov 2012 01:10:24 -0800 (PST)
In-Reply-To: <CAMP44s3MPMySnwjWjzo4aRX05u05xratgiyiYJUYPmnV2WK6kQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210723>

On Wed, Nov 28, 2012 at 9:44 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
>> If roundtripping to other version control systems is an argument,
>> adding sub-second timestamps could potentially create as many problems
>> as it solves. For example, I've been using the hg-git bridge, and it
>> supports roundtripping between git and mercurial today (for most repos
>> I've tried anyway). I may have missed something, but this could imply
>> that mercurial doesn't care about sub-second timestamps either. If so,
>> and if git suddenly were to record it, it would no longer be as
>> straight forward to represent git history in hg.
>
> I'm not entirely sure. The API seems to return a float for the time,
> but at least as far I can see, it never has any decimals anyway.
>
> But it doesn't really matter, mercurial doesn't have a committer
> information either. This is solved by tools like hg-git by storing the
> information in an 'extra' field, which can store anything.

True. For many commits though, hg-git doesn't need any extra fields,
as far as I've seen. A timestamp incompatibility would require extra
info on every commit.

> Either way, I don't see the point in changing git's commit format for
> external tools. The git-notes functionality works just fine for that,
> it just needs to be attached in the relevant places, like 'git
> fast-export'.

I agree. Even encoding info in the commit message works fine, and
git-svn already does that.

> BTW. Have you checked git's native support for hg?[1]

That's been added after I played with this last, I'll have a look.

Cheers,
Thomas
