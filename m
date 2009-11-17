From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] Expand ~ and ~user in core.excludesfile, commit.template
Date: Tue, 17 Nov 2009 09:57:52 +0100
Message-ID: <vpqlji5plyn.fsf@bauges.imag.fr>
References: <1258366060-27966-1-git-send-email-Matthieu.Moy@imag.fr>
	<m3k4xqc9qj.fsf@localhost.localdomain>
	<7viqd9isbm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Karl Chen <quarl@quarl.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 17 09:58:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAJtd-0005dh-9N
	for gcvg-git-2@lo.gmane.org; Tue, 17 Nov 2009 09:58:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753084AbZKQI6e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Nov 2009 03:58:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752905AbZKQI6d
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Nov 2009 03:58:33 -0500
Received: from mx2.imag.fr ([129.88.30.17]:49031 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752824AbZKQI6d (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Nov 2009 03:58:33 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id nAH8uqFn025359
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 17 Nov 2009 09:56:52 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1NAJsn-0003Ma-4Y; Tue, 17 Nov 2009 09:57:53 +0100
In-Reply-To: <7viqd9isbm.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's message of "Mon\, 16 Nov 2009 22\:22\:21 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 17 Nov 2009 09:56:53 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: nAH8uqFn025359
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1259053013.74212@7sud2TiCSPJ916h0vKgnLA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133081>

Junio C Hamano <gitster@pobox.com> writes:

> Jakub Narebski <jnareb@gmail.com> writes:
>
>> It would be nice to have an option to git-config which would do such
>> expansion, as a separate type similar to --int and --bool, e.g.:
>>
>>   git config --path section.key
>>
>> so that not only core.excludesfile could use this new feature, but for
>> example also core.worktree, commit.template, gitcvs.logfile,
>> mailmap.file, and perhaps also *.receivepack and *.uploadpack
>
> What should "git config -l" do for these (and core.excludesfile)?

I don't know what it "should", but it "does" not do the expansion. I
had the same questionning when testing the patch, I'd have liked to be
able to write a simple test-case like

$ git config core.excludesfile '~/foo'
$ git config --i-dont-know-what core.excludesfile

to go through this codepath. Maybe we can just say

$ git config --default core.excludesfile

to say "call git_default_config(...) on this before printing it". My
understanding is that this is what the C code is doing, we should
allow the shell scripts to do the same.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
