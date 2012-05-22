From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: remove_duplicates() in builtin/fetch-pack.c is O(N^2)
Date: Tue, 22 May 2012 09:15:55 +0200
Message-ID: <4FBB3D2B.4010300@alum.mit.edu>
References: <4FB9F92D.8000305@alum.mit.edu> <20120521174525.GA22643@sigill.intra.peff.net> <20120521221417.GA22664@sigill.intra.peff.net> <20120521235219.GA5589@sigill.intra.peff.net> <4FBB0F21.5080608@alum.mit.edu> <20120522041123.GA9972@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Martin Fick <mfick@codeaurora.org>,
	git discussion list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 22 09:23:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWjRD-0006Wt-45
	for gcvg-git-2@plane.gmane.org; Tue, 22 May 2012 09:23:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753967Ab2EVHXE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 May 2012 03:23:04 -0400
Received: from ALUM-MAILSEC-SCANNER-8.MIT.EDU ([18.7.68.20]:63864 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753472Ab2EVHXA (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 May 2012 03:23:00 -0400
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Tue, 22 May 2012 03:23:00 EDT
X-AuditID: 12074414-b7fbf6d0000008cf-8c-4fbb3d2e64f8
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id A6.66.02255.E2D3BBF4; Tue, 22 May 2012 03:15:58 -0400 (EDT)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q4M7FuZx027980
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 22 May 2012 03:15:56 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:12.0) Gecko/20120430 Thunderbird/12.0.1
In-Reply-To: <20120522041123.GA9972@sigill.intra.peff.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOKsWRmVeSWpSXmKPExsUixO6iqKtnu9vf4MJMVouuK91MFg29V5gt
	7r9fx2Txo6WH2YHF43JfL5PHs949jB4XLyl7fN4kF8ASxW2TlFhSFpyZnqdvl8CdsWX/UfaC
	rQIVf+41szYwdvJ2MXJySAiYSDxZ8JsFwhaTuHBvPVsXIxeHkMBlRoklK6awQzjHmSS+z7kP
	VsUroC3xa04PM4jNIqAq8eT9MlYQm01AV2JRTzNTFyMHh6hAmMTqBxoQ5YISJ2c+AWsVEZCV
	+H54IyOIzSzQzihxfq8diC0s4CSx4sdUVohdrUwSnRd62UASnAJWEkeunWWBaDCT6NraBdUs
	L7H97RzmCYwCs5DsmIWkbBaSsgWMzKsY5RJzSnN1cxMzc4pTk3WLkxPz8lKLdC30cjNL9FJT
	SjcxQgJaZAfjkZNyhxgFOBiVeHidKnf5C7EmlhVX5h5ilORgUhLlPWu921+ILyk/pTIjsTgj
	vqg0J7X4EKMEB7OSCO+mNqBy3pTEyqrUonyYlDQHi5I477fF6n5CAumJJanZqakFqUUwWRkO
	DiUJ3gAboKGCRanpqRVpmTklCGkmDk6Q4VxSIsWpeSmpRYmlJRnxoFiNLwZGK0iKB2hvHEg7
	b3FBYi5QFKL1FKMux4xPi64xCrHk5eelSonzBoEUCYAUZZTmwa2Apa9XjOJAHwvzOoJU8QBT
	H9ykV0BLmICWBL3YCbKkJBEhJdXAWJsuqDnpl9OkjlNNiWw+SelL976zVN6ezVjT23SP4avI
	8RX/N224ul/l0hamT7lvlq4VXSJRXvV7NuvvQ0uNtdXOHp0zYfnjo6cVlJzZ8jTj 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198184>

On 05/22/2012 06:11 AM, Jeff King wrote:
> On Tue, May 22, 2012 at 05:59:29AM +0200, Michael Haggerty wrote:
>
>>> Try doing "git fetch . refs/*:refs/*" in a repository with a large
>>> number of refs (e.g., 400K). With git v1.7.10, this takes about 9.5s on
>>> my machine. But using the version of git in "next" takes about 16.5s.
>>> Bisection points to your 432ad41 (refs: store references hierarchically,
>>> 2012-04-10). Perf shows sort_ref_dir and msort_with_tmp as hot spots.
>>
>> I'm looking into this.
>>
>> For your test, were the 400k references all in one "directory", or
>> were they sharded somehow?
>
> Sharded. This was the rails network repo, so it basically looks like
> this:
>
>    refs/remotes/XXXXXXX/heads/master
>    refs/remotes/XXXXXXX/tags/v1.0
>    refs/remotes/XXXXXXX/tags/v1.1
>    ...
>    refs/remotes/XXXXXXX/tags/v3.5
>    refs/remotes/YYYYYYY/heads/master
>    refs/remotes/YYYYYYY/tags/v1.0
>    refs/remotes/YYYYYYY/tags/v1.1
>    ...
>
> Basically the same 90 or so refs you would have in a normal repository
> (a branch or two, and a bunch of tags), repeated over and over under
> numbered remote hierarchies (i.e., each remote is basically a copy of
> the refs from somebody's fork of the repo).
>
> I can provide you with the exact repo if you want, but it is about 100M.
>
> Interestingly, I don't seem to get nearly as much slow-down in my "fake"
> many-refs repo, which has all 100K entries directly in refs/heads.

That could explain why I cannot reproduce your result.  I have done all 
of my testing in fake repos (with sharded and non-sharded variants) with 
very little file content.

If it is not too much trouble, please let me know where I can obtain 
your test repo and what commands you used to get your result.  (Was the 
local repo already a full clone of the remote, including all 400k 
references?  How was the remote set up--sharing data or not, local or 
remote?  Warm or cold disk cache?)

Thanks,
Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
