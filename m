From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v3 3/6] diff: allow --patch & cie to override -s/--no-patch
Date: Mon, 15 Jul 2013 20:23:56 +0200
Message-ID: <vpqvc4badhf.fsf@anie.imag.fr>
References: <20130715173536.GB14690@google.com>
	<1373910925-18422-1-git-send-email-Matthieu.Moy@imag.fr>
	<1373910925-18422-4-git-send-email-Matthieu.Moy@imag.fr>
	<20130715180908.GE14690@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 15 20:26:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UynTg-0003T0-7K
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jul 2013 20:26:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754251Ab3GOS0V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jul 2013 14:26:21 -0400
Received: from mx1.imag.fr ([129.88.30.5]:48862 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754236Ab3GOS0U (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jul 2013 14:26:20 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r6FINst6029289
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 15 Jul 2013 20:23:55 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UynRF-0004Ik-0i; Mon, 15 Jul 2013 20:23:57 +0200
In-Reply-To: <20130715180908.GE14690@google.com> (Jonathan Nieder's message of
	"Mon, 15 Jul 2013 11:09:09 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 15 Jul 2013 20:23:55 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r6FINst6029289
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1374517436.08641@XSfdHaCq2fL1WG9AWgCQFQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230514>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Matthieu Moy wrote:
>
>> All options that trigger a patch output now override --no-patch.
>>
>> The case of --binary is particular as the name may suggest that it turns
>
> Usage nit: this should say "is unusual" 

I don't get it. The point is not that --binary is unusual, but that it
is a particular case that deserves extra attention.

> or "In the case of --binary in particular, the name may suggest ...".

Not really. I'd use "in particular" if --binary was a sub-case of the
others, but here I'm precisely saying that it may not be.

>> --- a/t/t4000-diff-format.sh
>> +++ b/t/t4000-diff-format.sh
>> @@ -71,4 +71,9 @@ test_expect_success 'git diff-files --no-patch as synonym for -s' '
>>  	test_must_be_empty err
>>  '
>>  
>> +test_expect_success 'git diff-files --no-patch --patch shows the patch' '
>> +	git diff-files --no-patch --patch >diff-np-output 2>err &&
>> +	compare_diff_patch expected actual
>
> Shouldn't that be "compare_diff_patch expected diff-np-output"?

Oops, right.

> A couple of other test ideas:
>
>  - "git diff-files --patch --no-patch"
>  - "git diff-files -s --patch-with-stat"

I'd rather avoid having a too long list here, or we'll end-up testing
all combinations of options ...

I'll send a reroll tomorrow.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
