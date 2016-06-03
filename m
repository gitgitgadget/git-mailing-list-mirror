From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [PATCH v2 3/3] fetch: reduce duplicate in ref update status lines
Date: Fri, 3 Jun 2016 16:00:01 -0400
Message-ID: <5751E1C1.8080507@xiplink.com>
References: <20160522112019.26516-1-pclouds@gmail.com>
 <20160603110843.15434-1-pclouds@gmail.com>
 <20160603110843.15434-4-pclouds@gmail.com> <575199E7.7000503@xiplink.com>
 <xmqqh9dap5jk.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 03 22:05:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8vGL-0003VL-Dl
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 22:00:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932624AbcFCUAE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 16:00:04 -0400
Received: from smtp98.ord1c.emailsrvr.com ([108.166.43.98]:46521 "EHLO
	smtp98.ord1c.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751818AbcFCUAD (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Jun 2016 16:00:03 -0400
Received: from smtp21.relay.ord1c.emailsrvr.com (localhost.localdomain [127.0.0.1])
	by smtp21.relay.ord1c.emailsrvr.com (SMTP Server) with ESMTP id 4566A380229;
	Fri,  3 Jun 2016 16:00:02 -0400 (EDT)
X-Auth-ID: mbranchaud@xiplink.com
Received: by smtp21.relay.ord1c.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id EAF813802F8;
	Fri,  3 Jun 2016 16:00:01 -0400 (EDT)
X-Sender-Id: mbranchaud@xiplink.com
Received: from [10.10.1.32] ([UNAVAILABLE]. [192.252.130.194])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA)
	by 0.0.0.0:465 (trex/5.5.4);
	Fri, 03 Jun 2016 16:00:02 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.8.0
In-Reply-To: <xmqqh9dap5jk.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296368>

On 2016-06-03 01:04 PM, Junio C Hamano wrote:
> Marc Branchaud <marcnarc@xiplink.com> writes:
>
>> What if we detect when the full line exceeds the terminal width, and
>> insert a newline after the remote ref and indent the ->  to the same
>> offset as its surrounding lines, like this:
>>
>>   * [new branch]      2nd-index -> pclouds/2nd-index
>>   * [new branch]      some-kind-of-long-ref-name
>>                                 -> pclouds/some-kind-of-long-ref-name
>>   * [new branch]      3nd-index -> pclouds/3nd-index
>
> I am OK with this format (not in the sense that I like it better
> than what the patch produces, but in the sense that I do not have
> strong preference either way).  It may be hard to come up with a
> good heuristics to decide where on the display width "->" should
> come, though.

I think aligning it with the -> on the other lines makes the most 
aesthetic sense.

Are you worried that the right-hand-side ref might still wrap?  I'm not 
too concerned about that -- there'll always be the possibility of a ref 
name that's longer than the terminal.

>>> +When `from` and `to` share a common suffix, the line could be
>>> +displayed in the form:
>>> +
>>> +-------------------------------
>>> + <flag> <summary> {<from> -> <to>}<suffix> (<reason>)
>>
>> If we go with this format, we'll need to document <suffix>.
>
> The sentence above calls it "a common suffix", so instead of saying
> <suffix> we can say <common-suffix> perhaps?  Or did you mean
> something more than that?

I missed that, and although I think it's an adequate description I think 
most readers will miss it too.  They eye tends to notice the 
syntax-description bits then skip down to the list of element 
descriptions to understand which bits mean what.  My brain wants to find 
"suffix" in that list.

Anyway, not a major issue, really.

		M.
