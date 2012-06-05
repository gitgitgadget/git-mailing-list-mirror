From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Bugreport on Ubuntu LTS: not ok - 2 Objects creation does not break ACLs with restrictive umask
Date: Tue, 05 Jun 2012 08:02:55 +0200
Message-ID: <vpqpq9ejnxs.fsf@bauges.imag.fr>
References: <CALbm-Ea5ZkAGFyB2OETqe7vK7LE+yO0zSaa_+kFMXOhO-nMwMQ@mail.gmail.com>
	<7vhauqsue3.fsf@alter.siamese.dyndns.org>
	<CALbm-EatNCPjFRO4NyGfZuSa72-FXwZcd_7cFe-f_iMOdGL4MQ@mail.gmail.com>
	<7vy5o2ra7w.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <stefanbeller@googlemail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 05 08:03:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbmrM-00034L-LM
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jun 2012 08:03:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758532Ab2FEGDJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jun 2012 02:03:09 -0400
Received: from mx2.imag.fr ([129.88.30.17]:42436 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753310Ab2FEGDI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2012 02:03:08 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q555sDE1022247
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 5 Jun 2012 07:54:13 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Sbmr2-00061n-9A; Tue, 05 Jun 2012 08:02:56 +0200
In-Reply-To: <7vy5o2ra7w.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 04 Jun 2012 15:19:47 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 05 Jun 2012 07:54:14 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q555sDE1022247
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1339480458.549@22c0s62WHudsPGmQapITeg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199203>

Junio C Hamano <gitster@pobox.com> writes:

> Stefan Beller <stefanbeller@googlemail.com> writes:
>
>> I tried debugging into it:
>> In git/t/t1304-default-acl.sh there is:
>> check_perms_and_acl () {
>>     test -r "$1" &&
>>     getfacl "$1" > actual &&
>>     grep -q "user:root:rwx" actual &&
>>     grep -q "user:${LOGNAME}:rwx" actual &&
>>     egrep "mask::?r--" actual > /dev/null 2>&1 &&
>>     grep -q "group::---" actual || false
>> }

Can you run it with --verbose and post the result?

> Any ideas (other than "Your filesystem is broken",
> that is)?

I'm very tempted to go for the "Your filesystem is broken" indeed.

> As far as I can tell, with 'mask::---', these specific users who are
> given permissions to read from the objects wouldn't be able to read
> from them, so...

That's my understanding too.

Stefan, which filesystem are you using in the directory where you run
tests (type "mount" if you don't know)? Are you running on a virtual
machine?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
