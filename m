From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: Cloning empty repositories, was Re: What is the idea for bare repositories?
Date: Tue, 13 Nov 2007 23:01:00 +0100
Message-ID: <vpqd4ud6c0z.fsf@bauges.imag.fr>
References: <86k5on8v6p.fsf@lola.quinscape.zz>
	<20071112131927.GA1701@c3sl.ufpr.br>
	<Pine.LNX.4.64.0711121355380.4362@racer.site>
	<200711121719.54146.wielemak@science.uva.nl>
	<Pine.LNX.4.64.0711121624330.4362@racer.site>
	<vpq3avbv2ju.fsf@bauges.imag.fr>
	<Pine.LNX.4.64.0711121715090.4362@racer.site>
	<18232.35893.243300.179076@lisa.zopyra.com>
	<Pine.LNX.4.64.0711121727130.4362@racer.site>
	<vpq7iknqrtp.fsf@bauges.imag.fr>
	<Pine.LNX.4.64.0711121755460.4362@racer.site>
	<vpqy7d3pck0.fsf@bauges.imag.fr>
	<Pine.LNX.4.64.0711121804400.4362@racer.site>
	<vpqoddzpc88.fsf@bauges.imag.fr>
	<7v4pfr2kmh.fsf@gitster.siamese.dyndns.org>
	<vpqzlxiiii6.fsf@bauges.imag.fr>
	<7vir46t2cc.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Bill Lear <rael@zopyra.com>,
	Jan Wielemaker <wielemak@science.uva.nl>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 13 23:10:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Is3xe-0006JW-TH
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 23:10:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758060AbXKMWKD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 17:10:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759561AbXKMWKC
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 17:10:02 -0500
Received: from imag.imag.fr ([129.88.30.1]:46152 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757789AbXKMWKA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 17:10:00 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id lADM10It015265
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 13 Nov 2007 23:01:00 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1Is3oa-0005cS-BE; Tue, 13 Nov 2007 23:01:00 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1Is3oa-0003Y3-8X; Tue, 13 Nov 2007 23:01:00 +0100
In-Reply-To: <7vir46t2cc.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's message of "Tue\, 13 Nov 2007 10\:41\:39 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Tue, 13 Nov 2007 23:01:01 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64892>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@imag.fr> writes:
>
>> To create an initial commit in a bare repository, the most natural way
>> for me is to clone it, create the commit in the clone, and then push.
>>
>> Bare-ness _does_ matter for that.
>
> You are still wrong.
>
> The most natural is to create a commit in a non-bare repository
> you create, and push into a bare empty repository.

Yes, we agree on that point.

But I do find (incorrect with current git)

(1)

$ mkdir ~/bare-repo
$ cd ~/bare-repo
$ git --bare init
$ cd
$ git clone bare-repo local/non-bare
$ cd local/non-bare
<put files, git add, git commit>
$ git push

Simpler than (valid with current git)

(2)

$ mkdir ~/bare-repo
$ cd ~/bare-repo
$ git --bare init
$ cd
$ mkdir local/non-bare
$ cd local/non-bare
$ git init
<put files, git add, git commit>
$ git push ~/bare-repo
$ git remote add origin ~/bare-repo
$ git config branch.master.remote origin
$ git config branch.master.merge refs/heads/master

Where the bare-ness of ~/bare-repo matters is that with a bare
repository, I could have actually created the initial commit there
(valid with current git too):

(3)

$ mkdir ~/non-bare-repo
$ cd ~/non-bare-repo
$ git init
<put files, git add, git commit>
$ cd
$ git clone bare-repo local/non-bare

> The repository that is pushed into can be non-bare, but bareness of
> that does _NOT_ matter.

Either there is a way to achive (3) above with a bare repository which
I don't know, or bare-ness does matter in this case.

-- 
Matthieu
