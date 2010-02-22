From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 4/4] Use git_mkstemp_mode and xmkstemp_mode in odb_mkstemp, not chmod later.
Date: Mon, 22 Feb 2010 08:55:31 +0100
Message-ID: <vpqfx4tln64.fsf@bauges.imag.fr>
References: <1266597207-32036-1-git-send-email-Matthieu.Moy@imag.fr>
	<1266597207-32036-5-git-send-email-Matthieu.Moy@imag.fr>
	<7vy6inekxq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 22 10:10:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjTDL-0005JX-HN
	for gcvg-git-2@lo.gmane.org; Mon, 22 Feb 2010 09:00:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752544Ab0BVIAR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2010 03:00:17 -0500
Received: from imag.imag.fr ([129.88.30.1]:50245 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751171Ab0BVIAP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2010 03:00:15 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id o1M7tWYx021266
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 22 Feb 2010 08:55:32 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1NjT8e-0002tX-4H; Mon, 22 Feb 2010 08:55:32 +0100
In-Reply-To: <7vy6inekxq.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's message of "Sat\, 20 Feb 2010 12\:01\:05 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.91 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Mon, 22 Feb 2010 08:55:32 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140645>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@imag.fr> writes:
>
>> diff --git a/t/t1304-default-acl.sh b/t/t1304-default-acl.sh
>> index 4ee44a1..b8e9c34 100755
>> --- a/t/t1304-default-acl.sh
>> +++ b/t/t1304-default-acl.sh
>> @@ -27,7 +27,7 @@ modebits () {
>>  	ls -l "$1" | sed -e 's|^\(..........\).*|\1|'
>>  }
>>  
>> -test_expect_failure 'git gc does not break ACLs with restrictive umask' '
>> +test_expect_success 'git gc does not break ACLs with restrictive umask' '
>>  	umask 077 &&
>>  	git gc &&
>>  	actual=$(modebits .git/objects/pack/*.pack) &&
>
> This does not seem to pass for me; I get 0444 instead of 0440 as you expect.

That is strange, it does pass (or it's skipped if I don't have
setfacl) for me.

What system are you using? Do you have ACLs enabled on the filesystem
where you run the tests? What permission do you get for packs with
Git-without-my-patch (I used to get 0400)?

Thanks,

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
