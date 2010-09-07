From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Several tests: cd inside subshell instead of around
Date: Tue, 7 Sep 2010 00:19:22 -0500
Message-ID: <20100907051922.GP1182@burratino>
References: <4C85357A.8090000@web.de>
 <7vhbi2tqd0.fsf@alter.siamese.dyndns.org>
 <20100907023713.GJ1182@burratino>
 <7vlj7ep2ch.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 07 07:21:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Osqce-0004yA-1q
	for gcvg-git-2@lo.gmane.org; Tue, 07 Sep 2010 07:21:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751952Ab0IGFV1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Sep 2010 01:21:27 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:61046 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751076Ab0IGFV0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Sep 2010 01:21:26 -0400
Received: by gwj17 with SMTP id 17so1764828gwj.19
        for <git@vger.kernel.org>; Mon, 06 Sep 2010 22:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=npmvHmfX8v9QfvU0iV5aiUpRNNbut2QtYHqHAvtOJw4=;
        b=x6YxEOShcDs2YiftIcvMKcJ7F7zEXFwQ6pjzi97tsC33Y8fVNFc4eJs+3zWr59DFEm
         nx+m6UKbAFIoIuEdqQ9mH3eIOSGXLK+LiPLCLfJr8IGZE03fNpyVAbmujLkiQlOrhVbI
         NXKMXc4ZqXmySqPiUubnv++geZMXL8FIeJECY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=dAdPlog7moeh9xstgs7FUnInmXGdEIv5H11+Ogv5jZ04GeNuPF2ol3tK7F3Uwdcgxo
         KxigRkyHat+cQ8MJelbJJZodN59sfTdGa1j1IwRjOD7Il3uojqXe1yVW0S+AeNskcjLL
         ToDWemzFXBW6ZWA+H15ei4JdBM8BYEQBMEt8o=
Received: by 10.100.200.18 with SMTP id x18mr1006394anf.214.1283836885557;
        Mon, 06 Sep 2010 22:21:25 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id w1sm10676676ana.16.2010.09.06.22.21.24
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 06 Sep 2010 22:21:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vlj7ep2ch.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155676>

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> I like it.  Affected test scripts:
>> ... (many) ...
>> and probably some others.
>
> For the record, I _do not_ like it at all.  Is it worth being that
> draconian and say each test must start at $TRASH?  What do we gain by it?

To clarify, what I meant was something like "I like it, but reality
does not seem to permit it now".

> After we vet and apply Jens and your "turn 'cd there && do this && cd ..'
> into a subshell" series, and the "modernize indentation style" series,
> perhaps we should stop and think?  In an ideal world, it would be really
> nice if each "test_expect_success/failure" in a single script were
> independent from each other (if we did so, GIT_SKIP_TESTS=4321.4 starts to
> be more useful), but realistically, I don't think it is worth the effort.

Ah, our emails crossed.  I would rather that tests that affect the
state be marked as such, nothing more.  The "always return to $TRASH"
rule is a lot stronger than that, unfortunately.  What I really liked
about your suggestion is that the "tests must start and end in $TRASH"
rule could be checked with very little effort.  Unfortunately, as the
list of scripts illustrates, that rule doesn't describe what our
current tests do.
