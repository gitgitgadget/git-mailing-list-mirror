From: Ealdwulf Wuffinga <ealdwulf@googlemail.com>
Subject: Re: Compatibility between git.git and jgit
Date: Sat, 2 May 2009 17:56:29 +0100
Message-ID: <efe2b6d70905020956p3c99a5fbib85ba00ba842a08e@mail.gmail.com>
References: <20090415182754.GF23644@curie-int> <alpine.LFD.2.00.0904151443030.6741@xanadu.home> 
	<7vy6tj109a.fsf@gitster.siamese.dyndns.org> <alpine.LFD.2.00.0905011616130.6741@xanadu.home> 
	<7v4ow4v0xl.fsf@gitster.siamese.dyndns.org> <20090502000123.GF23604@spearce.org> 
	<alpine.LFD.2.00.0905012032590.6741@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sat May 02 18:56:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M0IWG-0003JT-Lt
	for gcvg-git-2@gmane.org; Sat, 02 May 2009 18:56:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755386AbZEBQ4q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 May 2009 12:56:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754644AbZEBQ4q
	(ORCPT <rfc822;git-outgoing>); Sat, 2 May 2009 12:56:46 -0400
Received: from mail-ew0-f224.google.com ([209.85.219.224]:48158 "EHLO
	mail-ew0-f224.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752927AbZEBQ4p (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 May 2009 12:56:45 -0400
Received: by ewy24 with SMTP id 24so2931194ewy.37
        for <git@vger.kernel.org>; Sat, 02 May 2009 09:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=6cGTScMSSBMRpwF86hivvdm8ysISkzT12yu5vqiIWmY=;
        b=aKWKZkqjBwCzMA7anb9395Lbv57gFYqu1siOxUBbzfYfMhBV10FXu9uKYmyihUeTnV
         dRfMgmhQ6+sQyPxAi+68mFVGU8rF+6AagUyrj1eLH/nk8JSmEUMW7YePFJ3oJjkktPq7
         xZKelfVVWN3j3dBY23YOWEFfdZyJt2ohnholA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=KooO2Hd5ThlHw85fsO912SqCO2fwhGyUX9L1UppItuv+q22hYmTUsY/KlKjpuLJTOr
         gz51ImoQwPoolXlpNKYNK9OAMv/YgBSfVvk9jLSY90p0Sl5dNc2GeXlxbxb0ffV8qZpJ
         /b/4HHgIKhsBVDDHkCJGE1PBv/X4Hl6w9kbbg=
Received: by 10.216.8.77 with SMTP id 55mr1148308weq.220.1241283404179; Sat, 
	02 May 2009 09:56:44 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.0905012032590.6741@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118140>

On Sat, May 2, 2009 at 2:39 AM, Nicolas Pitre <nico@cam.org> wrote:
>
> A formal compatibility test suite would imply that every Git
> reimplementation should be compatible with the reference C version.
> You could add some tests in your test suite which are performed in
> parallel using JGit and the C git, and make sure that the produced
> results are identical, etc.

 If at all possible, it would be a good idea to make it trivial for
new tests in the usual
git testsuite to be compatability tests (in a special mode, since it
would probably slow them down drastically). Ie, we have special
separate copy of all the git.git executables, which
underneath run two different versions of git and check that they did
the same thing.
Or alternatively wait for the librarification of git.git to complete,
and do it at the level of that API.

This may be hideously slow unless you have some kind of snapshotting filesystem
underneath. (Ironically the one that springs to mind is built into
vesta, another scm: http://www.vestasys.org. Vesta's
filesystem-manipulation language would be ideal
for this. Maybe you could copy it;  it's LGPL).

It's less obvious how networking related tests could be automatically
made into compatability
tests.

Doing this would be a lot trickier than writing some new conformance
tests, but once it was working, it would be a lot easier to keep track
of new features. It may be too tricky
to get to work, but it strikes me as worth thinking about.

Ealdwulf
