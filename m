From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 42/43] refs: add LMDB refs backend
Date: Wed, 07 Oct 2015 20:31:08 +0200
Message-ID: <561564EC.8070704@alum.mit.edu>
References: <1443477738-32023-1-git-send-email-dturner@twopensource.com>	 <1443477738-32023-43-git-send-email-dturner@twopensource.com>	 <56129B77.1030409@alum.mit.edu> <1444182660.7739.77.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed Oct 07 20:38:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZjtbV-0000cT-CB
	for gcvg-git-2@plane.gmane.org; Wed, 07 Oct 2015 20:38:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751797AbbJGSiN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Oct 2015 14:38:13 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:60308 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751488AbbJGSiM (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Oct 2015 14:38:12 -0400
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Wed, 07 Oct 2015 14:38:12 EDT
X-AuditID: 1207440c-f79e16d000002a6e-72-561564ee0e44
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id A6.F6.10862.EE465165; Wed,  7 Oct 2015 14:31:10 -0400 (EDT)
Received: from [192.168.69.130] (p4FC9720C.dip0.t-ipconnect.de [79.201.114.12])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t97IV8YS015151
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 7 Oct 2015 14:31:09 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.8.0
In-Reply-To: <1444182660.7739.77.camel@twopensource.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjleLIzCtJLcpLzFFi42IRYndR1H2XIhpmcHWjgMX8TScYLbqudDM5
	MHkseH6f3ePzJrkApihum6TEkrLgzPQ8fbsE7oy3Kx8wFTxQrlj+9wtbA+MZmS5GTg4JAROJ
	Pwf3M0HYYhIX7q1n62Lk4hASuMwosbLjBDNIQkjgHJPEhfUWIDavgLbE02t32LsYOThYBFQl
	1r2vBAmzCehKLOppBpsjKhAksWL5C0aIckGJkzOfsIDYIkCts4/0sIK0MguIS/T/AwsLC1hK
	HH7cyAqx9gqjxIKVS8HWcgpYSHTeeQs2k1lAXeLPvEvMELa8RPPW2cwTGAVmIVkxC0nZLCRl
	CxiZVzHKJeaU5urmJmbmFKcm6xYnJ+blpRbpGurlZpbopaaUbmKEhCnPDsZv62QOMQpwMCrx
	8P4wFgkTYk0sK67MPcQoycGkJMq70Ec0TIgvKT+lMiOxOCO+qDQntfgQowQHs5IIb2AIUI43
	JbGyKrUoHyYlzcGiJM6rukTdT0ggPbEkNTs1tSC1CCYrw8GhJMH7NxmoUbAoNT21Ii0zpwQh
	zcTBCTKcS0qkODUvJbUosbQkIx4Up/HFwEgFSfEA7b0N0s5bXJCYCxSFaD3FqCglzrsMJCEA
	ksgozYMbC0s+rxjFgb4U5o0CqeIBJi647ldAg5mABvfLC4EMLklESEk1MIZoV6v3MxWcnTR1
	Y4T85PTiox8fXp4hdWLhan7Xwrfr7j/pOCn1O5p/bVXR/r9GrRIO+n8Pm5Z0nLJo/JP+dMLE
	GzUnjYy1uCuO77g7+4G0qcDEihO2TRlVXtfVhBZFf5ItrOFsWbOqXTyA43/CKZk0 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279192>

On 10/07/2015 03:51 AM, David Turner wrote:
> On Mon, 2015-10-05 at 17:47 +0200, Michael Haggerty wrote:
>> On 09/29/2015 12:02 AM, David Turner wrote:
>>> Add a database backend for refs using LMDB.  [...]
>>
>> I think you have said before that if one writer holds the write lock on
>> the DB, then other writers fail immediately. Is that correct? If so, is
>> that something that can be adjusted? I think it would be preferable for
>> the second writer to retry acquiring the write lock for a little while
>> with a timeout (as we now do when trying to acquire the packed-refs
>> lock). Otherwise you could have the unhappy situation that somebody
>> spends a long time pushing a packfile to a server, only to have the
>> reference update be rejected at the last moment due to a lock conflict
>> with another process that was touching completely different references.
>> We already do before/after consistency checks when updating references,
>> so you wouldn't even have to add such code in the backend yourself.
> 
> No, the second writer waits for the first writer to unlock (or for it to
> crash).

Cool, that's better behavior.

> [...]
>> Do you store "peeled" reference values for tags, as is done in
>> packed-refs? I think that is an important optimization.
> 
> No.  Do you happen to know in what situations this is a performance
> benefit, so that I can benchmark?  I suspect it would matter much less
> for the LMDB backend, because lookups are pretty quick.

The reference lookup speed is not relevant here. "Peeling" is applied to
references that point at tag objects (a.k.a. annotated tags). It means
that the tag object is looked up to see what *it* points at (recursively
if necessary) and the result is stored to the packed-refs file in a
specially-formatted extra line that looks like

    17f9f635c101aef03874e1de1d8d0322187494b3 refs/tags/v2.6.0
    ^be08dee9738eaaa0423885ed189c2b6ad8368cf0

I think a good command to benchmark would be `git show-refs -d` in a
repository with a number of annotated tags. This command's output is
similar to the output of `git ls-remote <remote>` and also comes up
during reference negotiation when fetching (so its performance is
definitely not moot).

> [...]
>> Currently we discard the reflog for a reference when the reference is
>> deleted. [...]
>> Have you thought about removing this limitation in the lbdb backend?
> 
> I'm going for feature parity first.  We can always add new functionality
> later.  This particular function would be pretty straightforward to add,
> I think.

+1

> [...]
>>> +The rsync and file:// transports don't work yet, because they
>>> +don't use the refs API.
>>
>> Do they fail gracefully?
> 
> Not particularly gracefully.
> 
> rsync: link_stat "/home/dturner/git/t/trash
> directory.t5510-fetch/.git/packed-refs" failed: No such file or
> directory (2)
> rsync error: some files/attrs were not transferred (see previous errors)
> (code 23) at main.c(1183) [sender=3.1.1]
> fatal: Could not run rsync to get refs
> -------------
> 
> The problem is that rsync on the client assumes that packed-refs exists.
> We could hack it to also check for refdb.

I guess this is something that will have to be improved sooner or later,
though I guess not as a precondition for merging this patch series.

> [...]
>> I'm somewhat surprised that you only register the lmdb backend if it is
>> used in the main repo. I would expect the backend to be registered
>> unconditionally on startup. The cost is trivial, isn't it?
> 
> Yeah, but this was the easiest place to do it.

OK.

> [...]

I'm really happy about your work.

Regarding strategy: I think a good approach would be to get as much of
the preparatory work as possible (the abstraction and separation of
refs-be-files) to the point where it can be merged before there is too
much more code churn in the area. That work is not very controversial, I
think, and letting it wait for a long time will increase the likelihood
of conflicts with other people's changes. The refs-be-lmdb patches, on
the other hand, (1) will take longer to get polished, (2) will take
longer to review because other people are not familiar with LDMB, and
(3) won't bitrot very fast anyway because they don't overlap as much
with areas that other people are likely to work on. So I would advocate
working on those at a more deliberate pace and planning for them to be
merged as a separate batch.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
