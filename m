From: Sascha Cunz <Sascha-ML@babbelbox.org>
Subject: Re: [RFC/PATCH] Use work tree to determine if it supports symlinks
Date: Sat, 28 Jul 2012 01:51:18 +0200
Message-ID: <5249760.yb8Rz8UMH4@mephista>
References: <17699041.7b2cBoDgE0@mephista> <3068717.2K7be5iONg@mephista> <7vsjccyfo6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 28 01:52:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SuuKI-0007al-Os
	for gcvg-git-2@plane.gmane.org; Sat, 28 Jul 2012 01:52:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752472Ab2G0Xv1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jul 2012 19:51:27 -0400
Received: from babbelbox.org ([83.133.105.186]:57547 "EHLO mail.babbelbox.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752454Ab2G0Xv1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2012 19:51:27 -0400
Received: (qmail 7585 invoked from network); 27 Jul 2012 23:51:38 -0000
Received: from unknown (HELO mephista.localnet) (Sascha@Babbelbox.org@89.204.130.192)
  by babbelbox.org with ESMTPA; 27 Jul 2012 23:51:38 -0000
User-Agent: KMail/4.8.4 (Linux/3.4.4-gentoo; KDE/4.8.4; x86_64; ; )
In-Reply-To: <7vsjccyfo6.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202395>

On Friday, July 27, 2012 03:58:49 PM you wrote:
> Sascha Cunz <Sascha@babbelbox.org> writes:

> > Ok, so repository and working directory are simply not meant to be on
> > different file systems. Thanks for the clarification.
> 
> I did not mean "and that is a rule we need to enforce and keep
> forever".
I did not parse your statement as such - I just realized, that i probably 
won't find a valid use case for using 2 file systems with different 
capabilities. Which lead me to conclude that your "is not supported" is a 
sufficient response.

Though, I think I have a valid use case for using different file systems: For 
speed reasons one could setup .git to point to a different drive. I wanted to 
try this ever since I saw, it would be possible - but I never came around 
actually trying it.
However, if this would turn out to be an improvement, I don't think one would 
mix file systems with different capabilities (i.e. FAT+ext2).

> I was just answering your (implied) question "why does
> code comment, behaviour and documentation disagree?", to give a data
> point that would be useful when discussing what the ideal behaviour
> should be.

I think, that 'git init --separate-git-dir' (without a 'different filesystems' 
restriction) is some kind of support for creating non-bare repositories where 
work tree and .git dir are located on different file systems.

Then, in case a user _did_ setup a peculiar layout, an invocation of 'git 
submodule init' might make a call to 'git clone', which _should_ set 
core.symlinks to false but doesn't. At that point the user might not remember 
in detail how peculiar the setup actually is - and at the same time did not 
request git to do anything special.

I don't know how far-fetched that is, but it's at least possible.
