From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 03/16] refs: add methods for the ref iterators
Date: Tue, 5 Jan 2016 14:43:40 +0100
Message-ID: <568BC88C.6000703@alum.mit.edu>
References: <1449102921-7707-1-git-send-email-dturner@twopensource.com>
 <1449102921-7707-4-git-send-email-dturner@twopensource.com>
 <20160103000623.GB14424@gmail.com>
 <xmqqziwlnp7d.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: David Turner <dturner@twopensource.com>, git@vger.kernel.org,
	Ronnie Sahlberg <sahlberg@google.com>
To: Junio C Hamano <gitster@pobox.com>,
	David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 05 14:43:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aGRu1-0007nE-CK
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jan 2016 14:43:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752102AbcAENny (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jan 2016 08:43:54 -0500
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:49734 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752044AbcAENnw (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Jan 2016 08:43:52 -0500
X-AuditID: 12074414-f794f6d000007852-af-568bc88f635c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id DC.14.30802.F88CB865; Tue,  5 Jan 2016 08:43:43 -0500 (EST)
Received: from [192.168.69.130] (p4FC972AB.dip0.t-ipconnect.de [79.201.114.171])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u05DheVh006709
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 5 Jan 2016 08:43:41 -0500
X-Enigmail-Draft-Status: N1110
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.4.0
In-Reply-To: <xmqqziwlnp7d.fsf@gitster.mtv.corp.google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAKsWRmVeSWpSXmKPExsUixO6iqNt/ojvM4PQ7EYsNS9cwW8zfdILR
	outKN5NFQ+8VZot/E2ocWD12zrrL7rFgU6nHxUvKHgue32f3+LxJLoA1itsmKbGkLDgzPU/f
	LoE7Y/qkJewFzyUqJi24xdzA2CDSxcjJISFgIrFm90EmCFtM4sK99WxdjFwcQgKXGSVO370N
	5ZxnkvizchozSJWwgJPEo9sXwGwRAQ+Jt2cmsUMU3WaUeHGsmwUkwSxQIHH0715GEJtNQFdi
	UU8z1Ao5id7uSWA1vALaEldmt4PZLAIqEr9+fgUbKioQIrF3ZwdUjaDEyZlPwGxOAWuJnkNf
	oebrSey4/osVwpaXaN46m3kCo+AsJC2zkJTNQlK2gJF5FaNcYk5prm5uYmZOcWqybnFyYl5e
	apGuhV5uZoleakrpJkZI6IvsYDxyUu4QowAHoxIPL8fLrjAh1sSy4srcQ4ySHExKorzrVnaH
	CfEl5adUZiQWZ8QXleakFh9ilOBgVhLhfX0EKMebklhZlVqUD5OS5mBREuf9tljdT0ggPbEk
	NTs1tSC1CCYrw8GhJMG7+ThQo2BRanpqRVpmTglCmomDE2Q4l5RIcWpeSmpRYmlJRjwoiuOL
	gXEMkuIB2msF0s5bXJCYCxSFaD3FqCglzlsPkhAASWSU5sGNhSW0V4ziQF8K88qBVPEAkyFc
	9yugwUxAgxmKwAaXJCKkpBoYIxJkgpbECh/4FLukttzgvt5p3bdrO5qeLW6typa/su6k3uZE
	6zJRBqdHt32ymgpv71T1X/ruXOJP15m7tl5l9SqcI/SrJnSyTJZL7x2rLDXL11Mj 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283376>

On 01/04/2016 08:01 PM, Junio C Hamano wrote:
> David Aguilar <davvid@gmail.com> writes:
> [...]
>> My only comment is that it seems like having a single static global
>> the_refs_backend seems like it should be avoided.
>> [...]
> 
> I think the ship is sailing in a different direction.  The API to
> deal with refs, possibly in multiple repositories, is that you use a
> single ref backend, and that backend is expected to handle refs in
> submodule repositories.  I.e. refs.c::for_each_ref_in_submodule()
> calls into the backend implementation of the same method.  So from
> that point of view, you cannot say "the top level repository uses
> LMDB backend but this and that submodule refs are looked up by
> consulting files backend".
> 
> If we want to go the opposite direction, so that we can keep more
> than one in-core representations of "repository" (what you called
> "application context") and optionally have different refs backend
> handling different repositories, we most likely would want to
> rethink the part of the refs API that special cases the submodule
> refs from within the current repository.  Their implementation
> should be excised from the API set, and instead made to be a set
> of thin wrapper functions that explicitly refer to a repository
> instance that represents the submodule.

I definitely think that the "one and only one refs backend per process"
model is not a good long-term approach. For example, submodules are
relatively independent but are nevertheless sometimes accessed from a
single process. I don't think insisting that they all use the same
references backend is tenable over the long term.

But I haven't insisted on this flexibility yet because I don't think it
will be much extra work in total to retrofit it later. What we mostly
want to avoid is the need to rewrite all call sites more than once. The
current patch series hasn't had to rewrite callers at all, so we still
have a rewrite in reserve :-)

Actually, maybe we will never have to rewrite all callers. I rather
think that we will retain one simplified API for dealing with "*this*
repository's references" and a second for dealing with other repos' refs.

By the way, I think the next step towards the ability to work with
multiple backends at the same time would be to store a pointer to the
refs backend inside the ref_cache instance (possibly renaming the
latter) and allowing them both to be looked up by submodule name as is
already done by get_ref_cache(). I think this change could also be done
without rewriting callers.

> [...]
> The caching of already read refs is a responsiblity of each ref
> backend in the current codebase.  I am not sure if that is a good
> placement, or a single implementation of the caching layer should
> instead sit on top of any and ll ref backends.

I still dream about having compoundable reference backends, in which
case, ultimately, a "CacheReferenceStore" instance would optionally wrap
on top of an arbitrary other "ReferenceStore" instance (so to speak) to
give it caching functionality.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
