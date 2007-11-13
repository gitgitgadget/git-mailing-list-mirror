From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: Cloning empty repositories, was Re: What is the idea for bare repositories?
Date: Tue, 13 Nov 2007 22:48:37 +0100
Message-ID: <vpqhcjp6clm.fsf@bauges.imag.fr>
References: <Pine.LNX.4.64.0711121715090.4362@racer.site>
	<18232.35893.243300.179076@lisa.zopyra.com>
	<Pine.LNX.4.64.0711121727130.4362@racer.site>
	<vpq7iknqrtp.fsf@bauges.imag.fr>
	<Pine.LNX.4.64.0711121755460.4362@racer.site>
	<vpqy7d3pck0.fsf@bauges.imag.fr>
	<Pine.LNX.4.64.0711121804400.4362@racer.site>
	<vpqoddzpc88.fsf@bauges.imag.fr>
	<7v4pfr2kmh.fsf@gitster.siamese.dyndns.org>
	<vpqzlxiiii6.fsf@bauges.imag.fr> <20071113100209.GE14735@spearce.org>
	<vpqpryefmhj.fsf@bauges.imag.fr>
	<CBAEC42B-9F50-4723-9847-640D9832532E@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Bill Lear <rael@zopyra.com>,
	Jan Wielemaker <wielemak@science.uva.nl>, git@vger.kernel.org
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Tue Nov 13 22:51:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Is3fH-0007gv-LV
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 22:51:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754046AbXKMVuv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 16:50:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762352AbXKMVuv
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 16:50:51 -0500
Received: from imag.imag.fr ([129.88.30.1]:33316 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762283AbXKMVut (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 16:50:49 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id lADLmc9e012456
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 13 Nov 2007 22:48:38 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1Is3cb-0005JS-Ta; Tue, 13 Nov 2007 22:48:37 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1Is3cb-0003WN-Qv; Tue, 13 Nov 2007 22:48:37 +0100
In-Reply-To: <CBAEC42B-9F50-4723-9847-640D9832532E@silverinsanity.com> (Brian Gernhardt's message of "Tue\, 13 Nov 2007 14\:50\:49 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Tue, 13 Nov 2007 22:48:39 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64885>

Brian Gernhardt <benji@silverinsanity.com> writes:

> On Nov 13, 2007, at 5:50 AM, Matthieu Moy wrote:
>
>> While clone normally does a bit more:
>>
>> [remote "origin"]
>>        url = /tmp/git1/.git
>>        fetch = +refs/heads/*:refs/remotes/origin/*
>> [branch "master"]
>>        remote = origin
>>        merge = refs/heads/master
>
> But how is clone expected to do that when the origin is an empty
> repo?  There is no branch for it to track, and automagically setting
> it to master is bogus because then it's tracking something that
> doesn't exist.

An implementation of that would probably need to special-case the
empty repository. But an empty repository is already a special case.
HEAD already points to master, and master is already hardcoded here:

$ cat .git/HEAD 
ref: refs/heads/master

So, it's possible for HEAD to point to a branch which doesn't exist
yet, it's possible to commit to a branch which doesn't exist yet. It
would make sense to extend that to allow a remote to point to a branch
which doesn't exist either.

But don't get me wrong: I probably won't implement that myself, so I
can't _ask_ people to do it for me. I would just appreciate if people
stopped calling me (and other users interested in a sane empty clone
behavior) idiot because I think it would make sense to do it.

-- 
Matthieu
