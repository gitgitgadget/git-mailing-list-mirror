From: Marco Costalba <mcostalba@gmail.com>
Subject: Re: [QGIT PATCH/RFC]
Date: Thu, 5 Nov 2009 21:25:32 +0100
Message-ID: <e5bfff550911051225s13c6e39dh355dc3ab1c0623f@mail.gmail.com>
References: <4AF19630.2070402@lyx.org> <e5bfff550911050141t751d45a0r4e340fa0d10af366@mail.gmail.com> 
	<4AF2A538.7040303@lyx.org> <4AF2A69F.1090802@lyx.org> <4AF2AAFD.9000309@lyx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Abdelrazak Younes <younes@lyx.org>
X-From: git-owner@vger.kernel.org Thu Nov 05 21:26:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N68u7-0000qP-4o
	for gcvg-git-2@lo.gmane.org; Thu, 05 Nov 2009 21:25:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758403AbZKEUZs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Nov 2009 15:25:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758316AbZKEUZs
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Nov 2009 15:25:48 -0500
Received: from mail-ew0-f207.google.com ([209.85.219.207]:47249 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757031AbZKEUZr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Nov 2009 15:25:47 -0500
Received: by ewy3 with SMTP id 3so396592ewy.37
        for <git@vger.kernel.org>; Thu, 05 Nov 2009 12:25:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=4S+EkAmZgvAh6QX7V84UvhVcZAisgUW9kXsDFHbff+Y=;
        b=jlKEa8fJwZlAxtSlCUX8HEZ5uO6Nj6sXB8B2+DfJnbGcXxvTDGKMZdQzF5d0qebv83
         aqy0ii/1k2D4UI8AdYOqAgA3rEaL9itrLDaJdqla7tU3Uj3RG6yormRcITwkjpktZnr9
         IgEcZ+NLJsoEloVjQlbm29OCZlVoJIyS1PJe8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=vljLyUaN72eY8fcjHGCGNwjJ68RvjHYq73wSp/WUtdOBla7eLspqaeKO/2iGyfpKVx
         t06EW2sccvIZEv8QWB21pkFRfMUb85BTpg4UM+HVAOfge4P21cujUGdS4lrMb+NMVYCx
         zckw4dRknhjG9hT/V5h6NChDCdLOjpqpclyqk=
Received: by 10.213.23.81 with SMTP id q17mr608624ebb.93.1257452752138; Thu, 
	05 Nov 2009 12:25:52 -0800 (PST)
In-Reply-To: <4AF2AAFD.9000309@lyx.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132244>

On Thu, Nov 5, 2009 at 11:37, Abdelrazak Younes <younes@lyx.org> wrote:
>
> I recompiled qgit with the Qt version and I didn't notice any performance
> problem with a big repo (Qt).
>

In git we don't need to compute hashes of sha strings because they are
already hashed !

That's the idea of using a custom hashing function that does nothing
but taking the first chars of the sha string. Instead the general
purpose Qt hashing must do real work because it has to work for any
string.

When I tested I _found_ a speed difference, but now I don't remember
of how much. Be sure you have warm cache when doing the test (press
F5) for few times to be sure all is in RAM.


> Just tell me if this is not interesting to you and I'll shut up :-)
>

No, it is very interesting indeed. My bad I have no time for  net access today.

If QByteArray is faster then QLatin1String() we should definitely
change. But if I don't remember wrong QLatin1String() is already
implemented above a QByteArray and the methods that we use are
inherited directly from a QByteArray, but I may be wrong. I don't have
access to the sources now. I only remember that when I implemented
that part it took a good amount of time and testing ;-)

Thanks
Marco
