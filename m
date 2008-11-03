From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Git and Media repositories....
Date: Mon, 03 Nov 2008 01:40:55 -0800 (PST)
Message-ID: <m3ljw1f8qv.fsf@localhost.localdomain>
References: <1225655428.11693.10.camel@vaio>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Dana How <danahow@gmail.com>
To: Tim Ansell <mithro@mithis.com>
X-From: git-owner@vger.kernel.org Mon Nov 03 10:42:19 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kwvwx-0005AP-0B
	for gcvg-git-2@gmane.org; Mon, 03 Nov 2008 10:42:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754913AbYKCJlA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2008 04:41:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754926AbYKCJlA
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Nov 2008 04:41:00 -0500
Received: from nf-out-0910.google.com ([64.233.182.191]:43280 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754911AbYKCJk7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2008 04:40:59 -0500
Received: by nf-out-0910.google.com with SMTP id d3so916673nfc.21
        for <git@vger.kernel.org>; Mon, 03 Nov 2008 01:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=vMFqANTHAr40M2UtjuUPQ4HBHXzHRCq88MkdehP+9Xw=;
        b=xxYjpFKrliiOF+aEdETgNwwIEGmoOJPUYn1zjJKl2a0WWyiYkG3S9h0BU2Da3wb0dK
         yvVfy8kYNlR2jXteR2F7ZHAVGXOKvMZ4hCXg4VHFQEilWXN9WniLlR97rhJoqil0v79D
         57RDbkoL8Ux5gyUGpDqkg2GaTPSOPIB+mQNZo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=HDY7ehjyZpPbjrzRHMpVHaWmpk7OGddVInaVzqaPdF2vGzTy4lzkhZshtxbUd0EcRy
         AQC2lKWT/6hmBMzla6k01zlrBA5BJ4bcTlJ6H7I2vQOKQ4fUhj2zNePiN9XGp0++b2LR
         sIAeoyhgPzXjK/BgWNfq3IE3nnKuTJOySxgXo=
Received: by 10.210.60.8 with SMTP id i8mr4673036eba.34.1225705257119;
        Mon, 03 Nov 2008 01:40:57 -0800 (PST)
Received: from localhost.localdomain (abvp247.neoplus.adsl.tpnet.pl [83.8.213.247])
        by mx.google.com with ESMTPS id i4sm35659731nfh.1.2008.11.03.01.40.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 03 Nov 2008 01:40:55 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id mA39eOGf017140;
	Mon, 3 Nov 2008 10:40:35 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id mA39e8Zd017136;
	Mon, 3 Nov 2008 10:40:08 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1225655428.11693.10.camel@vaio>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99921>

Tim Ansell <mithro@mithis.com> writes:

> Last week at the GitTogether I lead some discussions about how we could
> make Git better support large media repositories (which is one area
> where Subversion still make sense). It was suggested that I post to this
> list to get a discussion going. 
> 
> The general idea is that we always clone the complete meta-data (tags,
> commits and trees) and then only clone blobs when they are needed (using
> something like alternates). This allows us to support shallow, narrow
> and sparse checkouts while still being able to perform operations such
> as committing and merging.
> 
> You can find a copy of the summary presentation at
>  http://www.thousandparsec.net/~tim/media+git.pdf
> 
> I have started working on adapting git to check a remote http alternate
> to provide a proof of concept.
> 
> I appreciate any help or suggestions.

Dana How (CC-ed) worked on better support for large files, but in
corporate setting.  The solution that was the result of all discussion
and all patches (not all accpeted) was to create kept packfile for
those large files, and share those packfiles (perhaps via alternates)
using network filesystem, instead of keeping separate copies and
trasferring them on fetch / push.


>From what I remember there was one serious attempt (by serious I mean
here with patches) to add 'lazy clone' / 'sparse clone' / 'remote
alternates', using some kind of "stub" objects and trasferring objects
lazily.  This patch was fairly intrusive, and didn't get accepted.
I think you can find it in archives.  Unfortunately I haven't bookmarked
this thread...

The problem with lazy clone is that git assumes in many places that if
it has some object, it has all its dependencies.  Lazy clone
(on-demand object loading) breaks this assumption... although in your
case (only blobs of large size can be asked to be loaded lazily) it is
migitated somehow.


I also think that you would have to have 'sparse checkout' support.
If you don't have blob in object repository (and don't want to have it
there), you can not check it out.  Fortunately this feature is quite
alive, and worked on by Duy (pclouds), see "What's cooking..."
(nd/narrow branch in 'pu').

HTH
-- 
Jakub Narebski
Poland
ShadeHawk on #git
