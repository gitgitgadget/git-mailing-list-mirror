From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCHv3 00/13] the refs-transactions-reflog series
Date: Thu, 04 Dec 2014 22:13:38 +0100
Message-ID: <5480CE82.9000408@alum.mit.edu>
References: <1417681763-32334-1-git-send-email-sbeller@google.com> <54809577.4080302@alum.mit.edu> <20141204181404.GD9992@google.com> <20141204183231.GA2649@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: ronniesahlberg@gmail.com, gitster@pobox.com, git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 04 22:13:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xwdil-0000eo-Tc
	for gcvg-git-2@plane.gmane.org; Thu, 04 Dec 2014 22:13:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754863AbaLDVNt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2014 16:13:49 -0500
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:42242 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754630AbaLDVNr (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Dec 2014 16:13:47 -0500
X-AuditID: 12074413-f79f26d0000030e7-e2-5480ce850f62
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 29.BC.12519.58EC0845; Thu,  4 Dec 2014 16:13:41 -0500 (EST)
Received: from [192.168.69.130] (p5DDB0B3C.dip0.t-ipconnect.de [93.219.11.60])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id sB4LDcci022193
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Thu, 4 Dec 2014 16:13:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.2.0
In-Reply-To: <20141204183231.GA2649@google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHKsWRmVeSWpSXmKPExsUixO6iqNt6riHEYMIbYYuuK91MFg29V5gt
	3t5cwmjR2/eJ1WLz5nYWB1aPnbPusnss2FTqcfGSssfnTXIBLFHcNkmJJWXBmel5+nYJ3Bmt
	65ayFkyXrji6dSdbA+MT0S5GDg4JAROJ6f+Yuxg5gUwxiQv31rN1MXJxCAlcZpSY+eM8M4Rz
	lkli647LLCBVvALaEqv2PmADsVkEVCUmnZjGCmKzCehKLOppZgKxRQWCJE7uuc4OUS8ocXLm
	E7BeEQEfiUW958FqmAVcJBa2LGMEOUJYwEGi4xQ/xK4VjBK/Z0wHq+cU0JfY/2o9C0S9nsSO
	679YIWx5ieats5knMArMQrJiFpKyWUjKFjAyr2KUS8wpzdXNTczMKU5N1i1OTszLSy3SNdfL
	zSzRS00p3cQICWvhHYy7TsodYhTgYFTi4S3YXR8ixJpYVlyZe4hRkoNJSZT3wKmGECG+pPyU
	yozE4oz4otKc1OJDjBIczEoivMZHgHK8KYmVValF+TApaQ4WJXFetSXqfkIC6YklqdmpqQWp
	RTBZGQ4OJQne7WeBGgWLUtNTK9Iyc0oQ0kwcnCDDuaREilPzUlKLEktLMuJBkRpfDIxVkBQP
	0N5SkHbe4oLEXKAoROspRkUpcd5VIAkBkERGaR7cWFiyesUoDvSlMO/DM0BVPMBEB9f9Cmgw
	E9Dgsw21IINLEhFSUg2MctHljhzrV6ryBa3wmTjDx6ty7asbm/ZL7Dq+Ztb3qnuFP9fu3r0o
	ozWt+nJUaH0C+66bLKazdlq7SP3+UrjWh2/bt9BVkpdO3xAqe79hQ83ydVXrl5Z0 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260803>

On 12/04/2014 07:32 PM, Stefan Beller wrote:
> On Thu, Dec 04, 2014 at 10:14:04AM -0800, Jonathan Nieder wrote:
>> Michael Haggerty wrote:
>>
>>> I am still unhappy with the approach of this series, for the reasons
>>> that I explained earlier [1]. In short, I think that the abstraction
>>> level is wrong. In my opinion, consumers of the refs API should barely
>>> even have to *know* about reflogs, let alone implement reflog expiration
>>> themselves.
>>
> Ok, what is a consumer for you? In my understanding the builtin/reflog.c is
> a consumer of the refs API, so there we want to see clean code just telling the
> refs backend to do its thing.
> 
> I think Jonathan made a good point by saying our patch series have 
> different goals.
> 
> So I really like the code, which leads to 
> 
>     reflog_expiry_prepare(refname, sha1, cb.policy_cb);
>     for_each_reflog_ent(refname, expire_reflog_ent, &cb);
>     reflog_expiry_cleanup(cb.policy_cb);
> 
> but look at the surrounding code:
>     
> 	if (!(flags & EXPIRE_REFLOGS_DRY_RUN)) {
> 		if (hold_lock_file_for_update(&reflog_lock, log_file, 0) < 0)
> 			...
> 	}
> 
> 
> 	if (!(flags & EXPIRE_REFLOGS_DRY_RUN)) {
> 		if (close_lock_file(&reflog_lock)) {
> 			...
> 		}
> 	}
> 
> That part should also go into the refs.c backend, so in the expire_reflog
> function you can just write:
> 
> 	transaction_begin(...)  // This does all the hold_lock_file_for_update magic 
> 				// lines 457-464 in mhagger/reflog-expire-api
> 
>  	reflog_expiry_prepare(refname, sha1, cb.policy_cb);
> 	for_each_reflog_ent(refname, expire_reflog_ent, &cb);
> 	reflog_expiry_cleanup(cb.policy_cb);
> 
> 	transaction_commit(...) // This does all the close_lock_file/rename/write_in_full
> 				// lines 470-488 in mhagger/reflog-expire-api

I'm pleasantly surprised that you guys have already looked at my work in
progress. I wish I had had more time earlier today to explain what is
still to be done:

The whole point of all of the refactoring is to move expire_reflog()
(and supporting functions like expire_reflog_ent()) to refs.c. The
"surrounding code" that you mention above would be moved there and would
*not* need to be done by callers.

expire_reflog() will gain three callback function pointers as
parameters. The caller (in this case reflog.c) will pass pointers to
reflog_expiry_prepare(), reflog_expiry_cleanup(), and
should_expire_reflog_ent() into expire_reflog().

There is no need to wrap the code in a transaction, because the
"surrounding code" that you mentioned implements all the "transaction"
that is needed! There is no need to complicated the *ref_transaction*
interface to allow arbitrary reflog updates when all we need is this one
very special case, plus of course the reflog appends that (I claim)
should happen implicitly whenever a reference is updated [1].

>> So *both* are making good changes, with different goals.
> 
> If you want to I can rebase the reflog series on top of yours to show
> they can work together quite nicely.

Feel free to do what you want, but I really don't think we will ever
need transactions to handle generic reflog updates.

Meanwhile I'll try to get my series finished, including API docs as
Jonathan requested. I hope the code will be more convincing than my
prose :-)

Michael

[1] Of course, only for references that have reflogs enabled.

-- 
Michael Haggerty
mhagger@alum.mit.edu
