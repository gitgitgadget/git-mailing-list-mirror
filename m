From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] grep: add a perlRegexp configuration option
Date: Tue, 31 Jul 2012 14:05:18 -0700
Message-ID: <7v3947iqup.fsf@alter.siamese.dyndns.org>
References: <1343753854-66765-1-git-send-email-dark.panda@gmail.com>
 <7vehnrkdrq.fsf@alter.siamese.dyndns.org>
 <CADFUPgfHQCzdnXfby5b+z-pRkt5o6MAVEf_1waWER3iVtM1TZA@mail.gmail.com>
 <7vboivishe.fsf@alter.siamese.dyndns.org>
 <CADFUPgfrG75FkSNV6JS22DAciD3CVkNEjKncNJOPkfRQSf41Pg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: J Smith <dark.panda@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 31 23:05:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SwJd9-0000PX-7X
	for gcvg-git-2@plane.gmane.org; Tue, 31 Jul 2012 23:05:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752334Ab2GaVFW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Jul 2012 17:05:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39771 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751133Ab2GaVFV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jul 2012 17:05:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 858BB83D9;
	Tue, 31 Jul 2012 17:05:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LGwpua2IXWTF3MIsfExmsV3tH40=; b=HMPbud
	kqPVOoBHfsaOaT4l0MVDhRdcxjAsNJFVpRbWQxc4OOyV0XlXQ1wKHLic5SusqNQL
	axursoYPTw/H19Wgtifc72BewseaACOuqIj0+LqSAw9ym/tqvtLvQZ1IdZ4SUEiu
	Xv5WtmtM9NtbKyk/XCYD+RZnzmPMLUYCejf8E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=duD9esaL2Ydc+ntGFpHPmnX1OVhMogVv
	bZGGF1d7UMweWBPljRabRt+FAkcWvOH7jX//Aft/aqoVQSiNTgAzxTG1pOCc7hWk
	KkO363On+5LelpdSRwov8twsccZhTVK5BWRUg7PH1P34YfRo5uVWkYB6/T4YpaBm
	gGyMGrj3/WM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 717FB83D8;
	Tue, 31 Jul 2012 17:05:20 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BB89283D6; Tue, 31 Jul 2012
 17:05:19 -0400 (EDT)
In-Reply-To: <CADFUPgfrG75FkSNV6JS22DAciD3CVkNEjKncNJOPkfRQSf41Pg@mail.gmail.com> (J.
 Smith's message of "Tue, 31 Jul 2012 16:35:44 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6F87ACCC-DB53-11E1-B6BC-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202687>

J Smith <dark.panda@gmail.com> writes:

> On Tue, Jul 31, 2012 at 4:30 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> J Smith <dark.panda@gmail.com> writes:
>>
>>> ... For the sake of completeness (verbosity? pedantry?) I also
>>> included a setting for "extended" which is equivalent to true.
>>
>> Good thinking.
>>
>>> With this sort of change, would a more generic "grep.regexpMode",
>>> "grep.patternType" or something similar perhaps be more descriptive,
>>> with "grep.extendedRegexp" being aliased for backwards compatibility
>>> purposes? I could also add that functionality if desired.
>>
>> A variable called "extendedRegexp" already reads quite naturally if
>> it can have value to say what kind of extendedness is desired, at
>> least to me.  So I do not care too deeply either way.
>
> On the flip side, it might be useful to some to have the option to set
> the value to "fixed" for the "--fixed-strings" argument, in which case
> the option becomes less a type of extended regexp and more of a simple
> search string. Were that to be the case, I think "grep.patternType"
> would feel the most precise.
>
> I think for completeness at the very least I should work in the
> "fixed" value as an valid value, option naming aside.

Ok, then grep.patternType it is.

Thanks.
