From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 4/5 v4] log: parse detached options like git log --grep foo
Date: Tue, 03 Aug 2010 08:33:08 +0200
Message-ID: <vpq8w4ob3yz.fsf@bauges.imag.fr>
References: <vpq7hkdml22.fsf@bauges.imag.fr>
	<1280478669-22973-4-git-send-email-Matthieu.Moy@imag.fr>
	<7vvd7tlzfu.fsf@alter.siamese.dyndns.org>
	<vpqtyncdeuc.fsf@bauges.imag.fr>
	<7vsk2wk8lc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 03 08:33:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OgB47-0000rE-RM
	for gcvg-git-2@lo.gmane.org; Tue, 03 Aug 2010 08:33:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755244Ab0HCGdR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Aug 2010 02:33:17 -0400
Received: from mx2.imag.fr ([129.88.30.17]:40698 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755210Ab0HCGdR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Aug 2010 02:33:17 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o736V56F011620
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 3 Aug 2010 08:31:05 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1OgB3k-000618-SS; Tue, 03 Aug 2010 08:33:08 +0200
In-Reply-To: <7vsk2wk8lc.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's message of "Mon\, 02 Aug 2010 14\:28\:31 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 03 Aug 2010 08:31:06 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o736V56F011620
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1281421870.436@cZNoL4ZpBNoWzrh9R/jEPQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152487>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> The patch overall looks good, and this comments illustrates the issue
>>> rather well.  When the user wants to use "--longopt val" syntax, s/he
>>> needs to know that "--longopt" will always take a value.  Arguably
>>> majority of options that can take value will, but like "--stat X,Y" this
>>> leaves things inconsistent.  Without "--longopt value" patch there won't
>>> be such an inconsistency, but I think this patch series is lessor of two
>>> evils.
>>
>> ... especially when parse-option already does this:
>>
>> git commit --message foo   => works
>> git gc --prune 'last week' => doesn't
>>
>> Just like most GNU tools:
>>
>> grep --regexp foo => works
>> grep --color auto => doesn't
>
> Hmm.
>
> Are you hinting that we should keep "you can say '-Ofoo' and '-O foo'"
> bits but we should drop "you can also say '--opt=foo' and '--opt foo' as
> long as --opt always takes an argument"?
>
> I actually think that may make sense.

I'm not sure I parsed your sentence correctly, but if I did, then no,
I don't think we should drop separate forms when --opt always takes an
argument, just the opposite.

-O<string> => always accepted
-O <string> => OK if <string> is mandatory and always non-empty
--opt=<sting> => always accepted
--opt <string> => OK if <string> is mandatory (possibly empty)

My remark was that there's nothing very original here, what my patch
does is what other places of Git did, and that other common tools did
years before.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
