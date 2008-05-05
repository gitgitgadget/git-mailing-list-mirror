From: Tarmigan <tarmigan+git@gmail.com>
Subject: Re: OSX, ZFS, UTF8, git - somebody hates me in this list
Date: Mon, 5 May 2008 12:00:48 -0700
Message-ID: <905315640805051200g4c155d15xada4f17e5e2fc424@mail.gmail.com>
References: <86wsm9dbhk.fsf@blue.stonehenge.com>
	 <20080504215208.GG29038@spearce.org>
	 <86skwxd97d.fsf@blue.stonehenge.com>
	 <8663tsbqg0.fsf@blue.stonehenge.com>
	 <alpine.LFD.1.10.0805051049440.32269@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Randal L. Schwartz" <merlyn@stonehenge.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon May 05 21:01:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jt5wS-0004an-Od
	for gcvg-git-2@gmane.org; Mon, 05 May 2008 21:01:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759509AbYEETAv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2008 15:00:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759447AbYEETAv
	(ORCPT <rfc822;git-outgoing>); Mon, 5 May 2008 15:00:51 -0400
Received: from mu-out-0910.google.com ([209.85.134.189]:51201 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754692AbYEETAu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2008 15:00:50 -0400
Received: by mu-out-0910.google.com with SMTP id w8so903142mue.1
        for <git@vger.kernel.org>; Mon, 05 May 2008 12:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=06VT8hh7HzG4NZXbW0phdQFcNzdV6JsUkAQWaXNbReQ=;
        b=iXsvAT4wKqnqKfVSLQK73c2g1qKzg/D1ybqdr5wvuKsoyFQKBYNKiyqeX8OL4kGORiYPZlDM82Bugh81Ecd6OovbL9qqaZ3zJYZ6bSgKJwEFqjeMuJpKygaN3GwBXGIVMFGutS+us26gRWxANwzWhavoXsORqFQ/czhMxRZrgEw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=FqE5BRAEnVFFO9wPW6sam6rfyice51yOMiNlH0DvacFAgJs7jJqlcfXae++1mi/Rmx+nI2n/adM/+Q5l8nRrkPWF4lOBV3/d+7+YR1Tdh2X4RKxXZ7AGLmqKUPh8stQXDRO4CqI+mDZiOhAN0+LmF+77Xj8FLs8iJopeXrIBymw=
Received: by 10.82.151.9 with SMTP id y9mr616397bud.8.1210014048458;
        Mon, 05 May 2008 12:00:48 -0700 (PDT)
Received: by 10.82.157.18 with HTTP; Mon, 5 May 2008 12:00:48 -0700 (PDT)
In-Reply-To: <alpine.LFD.1.10.0805051049440.32269@woody.linux-foundation.org>
Content-Disposition: inline
X-Google-Sender-Auth: 23a43919580e6046
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81304>

On Mon, May 5, 2008 at 10:53 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>  On Mon, 5 May 2008, Randal L. Schwartz wrote:
>  >
>  > Also, ZFS is case-sensitive, which leads me to believe that out of
>  > the box, it's more like UFS.
>  >
>  > Still don't know why ZFS breaks but UFS works.
>
>  UFS is a traditional Unix filesystem, and will not mangle your filenames.
>
>  ZFS apparently acts like a case-sensitive HFS+: it still tries to
>  normalize to UTF-8 (and does it badly, at that - picking an Apple-specific
>  almost-NFD form of normalization rather than the more sensible NFC form).
>
>  So ZFS may not corrupt cases, but it still corrupts UTF-8 filenames.

Not sure if that is always the case.  This thread suggests otherwise:
http://opensolaris.org/jive/thread.jspa?threadID=53303&tstart=0

Case sensitivity and mangling look like they are configurable.  See
the "casesensitivity" and "normalization" options at
http://docs.sun.com/app/docs/doc/819-2240/zfs-1m

ZFS on OSX may just default to "insensitive" and some form of
normalization especially if they were/are thinking about making it the
default fs and wanted backwards compatibility for broken apps.
Randal, can you make a new FS with casesensitivity=sensitive and
normalization=none and see how it behaves?

-Tarmigan
