From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Request: timeout option for remote operations, esp. "git fetch"
Date: Tue, 12 Nov 2013 10:33:49 -0800
Message-ID: <5282748D.9000907@zytor.com>
References: <527BC8DC.7010108@zytor.com>	<20131110201751.GA18513@dcvr.yhbt.net> <52825EBF.3050603@zytor.com> <xmqq1u2likea.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 12 19:34:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VgInK-0005L3-OC
	for gcvg-git-2@plane.gmane.org; Tue, 12 Nov 2013 19:34:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755599Ab3KLSeZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Nov 2013 13:34:25 -0500
Received: from terminus.zytor.com ([198.137.202.10]:36999 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755605Ab3KLSeY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Nov 2013 13:34:24 -0500
Received: from anacreon.sc.intel.com (fmdmzpr04-ext.fm.intel.com [192.55.55.39])
	(authenticated bits=0)
	by mail.zytor.com (8.14.7/8.14.5) with ESMTP id rACIXtln015936
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
	Tue, 12 Nov 2013 10:33:55 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <xmqq1u2likea.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237727>

On 11/12/2013 09:45 AM, Junio C Hamano wrote:
> "H. Peter Anvin" <hpa@zytor.com> writes:
> 
>> On 11/10/2013 12:17 PM, Eric Wong wrote:
>>> "H. Peter Anvin" <hpa@zytor.com> wrote:
>>>> When a remote server is unavailable or very slow, some git commands can
>>>> stall out indefinitely.  It would be a very good thing if remote
>>>> commands -- but especially git fetch -- could be given a timeout.
>>>
>>> We've had SO_KEEPALIVE on git and ssh transports since e47a8583 (2011-12-06)
>>> SO_KEEPALIVE for http was added recently (a15d069a) and will be in git 1.8.5
>>>
>>> Do you want a shorter timeout for slow (but still alive) servers?
>>>
>>
>> Yes; note that SO_KEEPALIVE only guarantees that the server is alive at
>> the TCP socket level.  If the server is overloaded but technically alive
>> it may still make no meaningful forward progress.
> 
> Which means that your original wish may not be granted with
> SO_KEEPALIVE at all, no?  I was wondering if you wanted a forced
> timeout based on alarm(2), something similar to what you added to
> git-daemon in 960deccb (git-daemon: timeout, eliminate double DWIM,
> 2005-10-19).
> 

Yes, something more like that on the client end.  SO_KEEPALIVE is better
than nothing, but not really good enough.

	-hpa
