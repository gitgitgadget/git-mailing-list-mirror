From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: [PATCH 1/2] git-svn: don't append extra newlines at the end of commit messages.
Date: Fri, 13 Jun 2008 12:17:44 -0400
Message-ID: <32541b130806130917y23a55751tfccac0de8143ebe4@mail.gmail.com>
References: <1213312251-8081-1-git-send-email-apenwarr@gmail.com>
	 <7vfxrhyjqd.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Eric Wong" <normalperson@yhbt.net>,
	"Sam Vilain" <sam.vilain@catalyst.net.nz>, kha@treskal.com,
	ae@op5.se
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 13 18:19:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7Bzb-0004Et-DI
	for gcvg-git-2@gmane.org; Fri, 13 Jun 2008 18:19:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757229AbYFMQRr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2008 12:17:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756989AbYFMQRr
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jun 2008 12:17:47 -0400
Received: from fk-out-0910.google.com ([209.85.128.189]:31798 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756610AbYFMQRq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2008 12:17:46 -0400
Received: by fk-out-0910.google.com with SMTP id 18so2135703fkq.5
        for <git@vger.kernel.org>; Fri, 13 Jun 2008 09:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=i5HQAEY0RIzaO6HxTVyBjQPFCqtMfb9HdI0lNIhUkg8=;
        b=UzsEpEJRvqUnV1MozLbZ90VWynqF5+UZ/Wx7Wt05KlMKnsEVzQK9m+z+etX+ZrR03P
         s2iTenzGBEq4MB2ZQbnk2gOnSEAzckigt3uS1nGYAFt00MKFf1z1eEnM40Zenl7d52qJ
         MxJsYFBx0hX8vPuvCfc/0ck5vgDcJ4lDWGfHw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=YLdeY2j7bQeUlx/D5agwZigh9iy4vG7gJ11KMw3paUExT1cEOF+RzQeAAG607p2UHi
         MdCFw0tDzQ0haCOJhHe8kRvoohMpz2x6VgvaXLtK5qNMhubRCRex4P75h5aSX2ZQZ3K5
         TjH2zj2wQISHFgXpHB4oLGg+Zycgdg9xZGysw=
Received: by 10.82.150.15 with SMTP id x15mr182865bud.23.1213373865008;
        Fri, 13 Jun 2008 09:17:45 -0700 (PDT)
Received: by 10.82.100.5 with HTTP; Fri, 13 Jun 2008 09:17:44 -0700 (PDT)
In-Reply-To: <7vfxrhyjqd.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84896>

On 6/13/08, Junio C Hamano <gitster@pobox.com> wrote:
> Avery Pennarun <apenwarr@gmail.com> writes:
>  > Instead, let's remove all trailing whitespace from the git commit on the way
>  > through to svn.
>
> Perl part of the code looks fine but I am unsure if we like the
>  ramifications of this patch on existing git-svn managed repositories.
>  Doesn't this change the commit object name on our end for almost all of
>  them?

Unless I got confused while coding this (I don't think I did), this
should *not* affect existing or re-imported svn or git-svn
repositories.  It only removes trailing whitespace the first time a
git commit is sent into svn, which should happen only once for a brand
new commit by someone who has made it in git and is now dcommiting it
to svn.

Naturally, the dcommit round-trip *always* produces a new sha1 hash
for that commit anyhow because of the added git-svn-id: line.  After
this change, the sha1 will be different than it would have been
before, but it will still be the same for anyone who checks out from
svn again with git-svn.

Thanks,

Avery
