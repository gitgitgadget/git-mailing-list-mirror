From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC v2] git-multimail: a replacement for post-receive-email
Date: Mon, 25 Feb 2013 10:54:12 +0100
Message-ID: <vpqd2vok9bv.fsf@grenoble-inp.fr>
References: <5104E738.602@alum.mit.edu> <vpqfw0rb25c.fsf@grenoble-inp.fr>
	<5129A5B3.7020807@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git discussion list <git@vger.kernel.org>,
	Andy Parkins <andyparkins@gmail.com>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Marc Branchaud <mbranchaud@xiplink.com>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
	Chris Hiestand <chiestand@salk.edu>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Feb 25 10:54:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9ulu-0006GM-Cq
	for gcvg-git-2@plane.gmane.org; Mon, 25 Feb 2013 10:54:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758875Ab3BYJy3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2013 04:54:29 -0500
Received: from mx1.imag.fr ([129.88.30.5]:51927 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758837Ab3BYJy1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2013 04:54:27 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r1P9sCUM023449
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 25 Feb 2013 10:54:12 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1U9ulA-0007Nk-VF; Mon, 25 Feb 2013 10:54:13 +0100
In-Reply-To: <5129A5B3.7020807@alum.mit.edu> (Michael Haggerty's message of
	"Sun, 24 Feb 2013 06:31:31 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 25 Feb 2013 10:54:14 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r1P9sCUM023449
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1362390856.32875@XEOX2nfClZx1NgXvFuFyEw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217052>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> On 02/20/2013 01:28 PM, Matthieu Moy wrote:
>> Michael Haggerty <mhagger@alum.mit.edu> writes:
>>> A while ago, I submitted an RFC for adding a new email notification
>>> script to "contrib" [...]
>> 
>> We've discussed offline with Michael, a few patches have been merged,
>> and there are still a few pending pull requests. I liked the script
>> already, but it's getting even cooler ;-).
>> 
>> A few more random thoughts (not on my personal todo-list):
>> 
>> * It may make sense to add the short sha1 of the new reference in email
>>   titles (branch foo updated -> branch foo updated to $sha1), so that
>>   gmail users do not get a single huge thread "branch foo updated".
>> 
>>   (Yes, I do know about the Reference field, but gmail uses Subject: for
>>   threading).
>> [...]
>
> I just implemented this in branch sha1s-in-subject [1].  Please let me
> know if this works for you then I'll merge it to master.  (It depends on
> the header-handling branch, which also includes your patch for non-ASCII
> header fields.)

Works for me. One minor knit: you've included 10-characters sha1s (this
comes from

        self.short = read_output(['git', 'rev-parse', '--short=10', sha1])

), I'd find it better with shorter sha1s. In the case of branch update,
if the branch name is a bit long, it could be nice to save a few
characters.

Why not just say "git rev-parse --short", without argument? This way,
the default is used, ie. AFAICT it uses 7 characters by default, but
will use more if needed to keep the unicity.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
