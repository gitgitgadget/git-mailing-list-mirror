From: "Ben Lynn" <benlynn@gmail.com>
Subject: Re: git bugs
Date: Tue, 10 Jun 2008 17:24:46 -0700
Message-ID: <832adb090806101724k6199694ftbbc6ed151489a6e3@mail.gmail.com>
References: <832adb090806100141n69c086a2v2f59fe94b2f4ead3@mail.gmail.com>
	 <alpine.LFD.1.10.0806101028040.3101@woody.linux-foundation.org>
	 <832adb090806101145w55729676ya7bcfb41b0413f59@mail.gmail.com>
	 <alpine.LFD.1.10.0806101249580.3101@woody.linux-foundation.org>
	 <832adb090806101609q17a21948nb5814c3b22bd832d@mail.gmail.com>
	 <7v1w34dfn3.fsf@gitster.siamese.dyndns.org>
	 <832adb090806101702l79aba80cvba1eaab029e9ecd5@mail.gmail.com>
	 <7vwskwbz63.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	"Daniel Barkalow" <barkalow@iabervon.org>, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 11 02:25:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6E9m-0004fk-5l
	for gcvg-git-2@gmane.org; Wed, 11 Jun 2008 02:25:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753080AbYFKAYt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2008 20:24:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752885AbYFKAYt
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jun 2008 20:24:49 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:63183 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752784AbYFKAYs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2008 20:24:48 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1955115fgg.17
        for <git@vger.kernel.org>; Tue, 10 Jun 2008 17:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=8uOl9aYsIGOXoEhFj911N9IuZpr7ThPLNwPv0WZmyKE=;
        b=Oe84iaW8Spb+mrgw9hT7q6HkO9bAHdY543jciTi1lstZVxbg+PVaXPx6qe2vfnbBPo
         ONzzE/sndBOyADyXHRdLx+QpfOGMrrVpXEEKqu8pHr4kTm5Vq0vbKMvwVXuTcdTwVbVU
         d0wsn+H+QYzI4nPpMknMkR1VKUfrRy997vcm4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=PZAGBkz4jM+BucFj1ltWGkC89+bOZjz2/6xzu8B4RtoeLiAZq2nE3nT5R+RBfqTGvK
         pufpkDOLQkh1clgrj4jrfVjP93ZonY0yWfndVy8dlPf43oJqx8vpk79dHbCOr1lvIiCc
         ymG3Cpbrw5KjwEyMM2nT3yAOOzWMqKp/pq6UY=
Received: by 10.86.23.17 with SMTP id 17mr6413307fgw.44.1213143886757;
        Tue, 10 Jun 2008 17:24:46 -0700 (PDT)
Received: by 10.86.79.17 with HTTP; Tue, 10 Jun 2008 17:24:46 -0700 (PDT)
In-Reply-To: <7vwskwbz63.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84565>

That is problematic. How do I figure out what the filesystem thinks is
the current time? I could touch some file and read its mtime, but I
want a shortcut.

Are there any guarantees of any kind? e.g. is the filesystem current
time at least never ahead of the system time?

-Ben

On Tue, Jun 10, 2008 at 5:20 PM, Junio C Hamano <gitster@pobox.com> wrote:
> "Ben Lynn" <benlynn@gmail.com> writes:
>
>> ... I'm making the same
>> assumptions, i.e. files are not touched while they're being indexed.
>
> Actually you are making another assumption that is somewhat worrysome.
>
> The filesystem clock and time(2) clock can be skewed and comparing a
> timestamp you obtain from lstat(2) and time(2) might not give you any
> meaningful information.  That is why I made this codepath without using
> time(2) when I did the racy-git work.
>
>
