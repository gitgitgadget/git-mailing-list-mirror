From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] repack: rewrite the shell script in C.
Date: Wed, 21 Aug 2013 15:05:10 +0200
Message-ID: <vpq1u5n9ou1.fsf@anie.imag.fr>
References: <5213EF74.7020408@googlemail.com>
	<1377038334-15799-1-git-send-email-stefanbeller@googlemail.com>
	<vpqhaeje8e0.fsf@anie.imag.fr> <5214B6F8.6030102@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, mfick@codeaurora.org, apelisse@gmail.com,
	pclouds@gmail.com, iveqy@iveqy.com, gitster@pobox.com,
	mackyle@gmail.com, j6t@kdbg.org
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Wed Aug 21 15:05:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VC86N-00082B-3n
	for gcvg-git-2@plane.gmane.org; Wed, 21 Aug 2013 15:05:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751519Ab3HUNF1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Aug 2013 09:05:27 -0400
Received: from mx2.imag.fr ([129.88.30.17]:46054 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751486Ab3HUNF0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Aug 2013 09:05:26 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r7LD59nk008769
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 21 Aug 2013 15:05:09 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1VC862-0007QM-Qf; Wed, 21 Aug 2013 15:05:10 +0200
In-Reply-To: <5214B6F8.6030102@googlemail.com> (Stefan Beller's message of
	"Wed, 21 Aug 2013 14:47:52 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 21 Aug 2013 15:05:10 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r7LD59nk008769
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1377695110.63485@VjPew+QoygWFZkNNUDMKSQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232700>

Stefan Beller <stefanbeller@googlemail.com> writes:

> On 08/21/2013 10:49 AM, Matthieu Moy wrote:
>>> +	if (start_command(&cmd))
>>> > +		return 1;
>> A warning message would be welcome in addition to returning 1.
>> 
>
> Johannes Sixt proposes to retain the return value of
> the sub process, which I'd agree on.

Yes.

> I'd expect the pack-objects to bring up the warning as
> the stderr is untouched in the command invocation.

I was more thinking of weird cases like failure to fork or so. But
according to api-run-command.txt:

  . If a system call failed, errno is set and -1 is returned. A diagnostic
    is printed.

So you actually don't need it. In this case, following Johannes's
suggestion, you'd return -1 from the main function, which is unusual but
AFAICT is OK.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
