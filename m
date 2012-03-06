From: Michal Privoznik <mprivozn@redhat.com>
Subject: Re: [PATCH] config: Introduce --patience config variable
Date: Tue, 06 Mar 2012 14:32:33 +0100
Message-ID: <4F5611F1.4020309@redhat.com>
References: <a87ed689ddfb06601dd639541199fc72d829bdaf.1331031473.git.mprivozn@redhat.com> <20120306114914.GB6733@sigill.intra.peff.net> <87pqcp6fyh.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org, gitster@pobox.com
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Mar 06 14:33:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4uWQ-0005G8-7h
	for gcvg-git-2@plane.gmane.org; Tue, 06 Mar 2012 14:33:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030682Ab2CFNdl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Mar 2012 08:33:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:8231 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030378Ab2CFNdk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2012 08:33:40 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q26DWa9d008820
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Tue, 6 Mar 2012 08:32:37 -0500
Received: from [10.34.27.226] (dhcp-27-226.brq.redhat.com [10.34.27.226])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id q26DWX04000585;
	Tue, 6 Mar 2012 08:32:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.1) Gecko/20120302 Thunderbird/10.0.1
In-Reply-To: <87pqcp6fyh.fsf@thomas.inf.ethz.ch>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.22
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192347>

On 06.03.2012 14:01, Thomas Rast wrote:
> Jeff King <peff@peff.net> writes:
> 
>> On Tue, Mar 06, 2012 at 11:59:42AM +0100, Michal Privoznik wrote:
>>
>>> --- a/Documentation/diff-config.txt
>>> +++ b/Documentation/diff-config.txt
>>> @@ -86,6 +86,9 @@ diff.mnemonicprefix::
>>>  diff.noprefix::
>>>  	If set, 'git diff' does not show any source or destination prefix.
>>>  
>>> +diff.patience:
>>> +    If set, 'git diff' will use patience algorithm.
>>> +
>>
>> Should this be a boolean? Or should we actually have a diff.algorithm
>> option where you specify the algorithm you want (e.g., "diff.algorithm =
>> patience")? That would free us up later to more easily add new values.
>>
>> In particular, I am thinking about --minimal. It is mutually exclusive
>> with --patience, and is simply ignored if you use patience diff.
>> we perhaps have "diff.algorithm" which can be one of "myers", "minimal"
>> (which is really myers + the minimal flag), and "patience".
> 
> Don't forget "histogram".  I have no idea why it's not documented
> (evidently 8c912eea slipped through the review cracks) but --histogram
> is supported since 1.7.7.
> 

Okay guys. I'll got with diff.algorithm = [patience | minimal |
histogram | myers] then. What I am not sure about is how to threat case
when user have say algorithm = patience set in config but want to use
myers. I guess we need --myers option then, don't we?

Michal
