From: Philip Oakley <philipoakley@iee.org>
Subject: Re: [PATCH v3 8/9] rebase: add the --gpg-sign option
Date: Sat, 08 Feb 2014 13:04:09 +0000
Message-ID: <52F62B49.7080709@iee.org>
References: <1391221086-1044384-1-git-send-email-sandals@crustytoothpaste.net> <1391221086-1044384-9-git-send-email-sandals@crustytoothpaste.net> <xmqqlhxrdgb5.fsf@gitster.dls.corp.google.com> <20140207235058.GJ635004@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Nicolas Vigier <boklm@mars-attacks.org>,
	sandals@crustytoothpaste.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 08 14:04:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WC7aD-0003ta-6x
	for gcvg-git-2@plane.gmane.org; Sat, 08 Feb 2014 14:04:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751378AbaBHNEO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Feb 2014 08:04:14 -0500
Received: from out1.ip02ir2.opaltelecom.net ([62.24.128.238]:38075 "EHLO
	out1.ip02ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750957AbaBHNEN (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Feb 2014 08:04:13 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApMBABIq9lICYJpS/2dsb2JhbAANTINEwBiBHoMZAQEBAQM4QAEQCxgJFg8JAwIBAgFFEwEHAQEFiAmrFqFGF459BxaEIgSteQ
X-IPAS-Result: ApMBABIq9lICYJpS/2dsb2JhbAANTINEwBiBHoMZAQEBAQM4QAEQCxgJFg8JAwIBAgFFEwEHAQEFiAmrFqFGF459BxaEIgSteQ
X-IronPort-AV: E=Sophos;i="4.95,806,1384300800"; 
   d="scan'208";a="453700835"
Received: from host-2-96-154-82.as13285.net (HELO [192.168.1.4]) ([2.96.154.82])
  by out1.ip02ir2.opaltelecom.net with ESMTP; 08 Feb 2014 13:04:09 +0000
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <20140207235058.GJ635004@vauxhall.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241834>

On 07/02/14 23:50, brian m. carlson wrote:
> On Mon, Feb 03, 2014 at 01:42:06PM -0800, Junio C Hamano wrote:
>>> +	--gpg-sign)
>>> +		gpg_sign_opt=-S
>>> +		;;
>>> +	--gpg-sign=*)
>>> +		# Try to quote only the argument, as this will appear in human-readable
>>> +		# output as well as being passed to commands.
>>> +		gpg_sign_opt="-S$(git rev-parse --sq-quote "${1#--gpg-sign=}" |
>>> +			sed 's/^ //')"
>>
>> Isn't an invocation of sed excessive?
>>
>> 	gpg_sign_opt=$(git rev-parse --sq-quote "${1#--gpg-sign=}") &&
>> 	gpg_sign_opt=-S${gpg_sign_opt# }
>>
>> if you really need to strip the leading SP, which I do not think is
>> a necessary thing to do.  It is sufficient to remove the SP before
>> the variable substitution in the human-readable messages, e.g.
>
> I'm not sure that command line parsing of "-S 'foo <x@example.tld>'"
> will work exactly as expected due to the fact that -S doesn't always
> take an argument.  Your suggestion to use # seems fine, though.
>
> I'm a little embarrassed to admit that in my fifteen years of Unix
> experience, I've never learned the variable modifiers for shell, so it
> didn't occur to me to use them in this case.  Guess it's time to learn
> them now.

Same here:

For other readers, I found most google results were only partial on the 
issue, missing the '#' symbol option. Here's a more complete ref 
http://www.gnu.org/software/bash/manual/bashref.html#Shell-Parameter-Expansion-1 
for fellow learners.

Philip
--

>
