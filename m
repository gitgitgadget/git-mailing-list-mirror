From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v3 12/19] initial_ref_transaction_commit(): check for
 duplicate refs
Date: Tue, 23 Jun 2015 09:11:32 +0200
Message-ID: <558906A4.8060106@alum.mit.edu>
References: <cover.1434980615.git.mhagger@alum.mit.edu>	<63ae59139a3a7b5c85f6d44864eade79a93965fb.1434980615.git.mhagger@alum.mit.edu> <xmqqtwtzfo79.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 23 09:11:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7IN8-0003JU-4t
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jun 2015 09:11:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753555AbbFWHLt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jun 2015 03:11:49 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:55835 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751358AbbFWHLs (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Jun 2015 03:11:48 -0400
X-AuditID: 12074414-f794f6d000007852-4f-558906a778b2
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id A9.E4.30802.7A609855; Tue, 23 Jun 2015 03:11:35 -0400 (EDT)
Received: from [192.168.69.130] (p4FC972ED.dip0.t-ipconnect.de [79.201.114.237])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t5N7BWRx014473
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 23 Jun 2015 03:11:33 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.7.0
In-Reply-To: <xmqqtwtzfo79.fsf@gitster.dls.corp.google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKKsWRmVeSWpSXmKPExsUixO6iqLucrTPU4HwDh0XXlW4mi4beK8wW
	P1p6mC02b25ncWDxWLCp1ONZ7x5Gj4uXlD0+b5ILYInitklKLCkLzkzP07dL4M74smUKa0Gf
	bMXKY23MDYwrxLsYOTgkBEwkjk6R6mLkBDLFJC7cW8/WxcjFISRwmVHi6bQtTBDOBSaJhvkb
	GUGqeAW0JaZtf8gKYrMIqEq8fTGJGcRmE9CVWNTTzAQyVFQgSOL1y1yIckGJkzOfsIDYIgJq
	EhPbDoHZzALxElvbr4K1CgtESdxfsYEZYtdWRokFj56DJTgFrCV2dG5lhmjQk9hx/RcrhC0v
	0bx1NvMERoFZSHbMQlI2C0nZAkbmVYxyiTmlubq5iZk5xanJusXJiXl5qUW6Fnq5mSV6qSml
	mxghwSyyg/HISblDjAIcjEo8vCemdoQKsSaWFVfmHmKU5GBSEuUV+QEU4kvKT6nMSCzOiC8q
	zUktPsQowcGsJMK79iZQjjclsbIqtSgfJiXNwaIkzvttsbqfkEB6YklqdmpqQWoRTFaDg0Ng
	xrm505mkWPLy81KVJHhlWTtDhQSLUtNTK9Iyc0oQSpk4OEEWcUmJFKfmpaQWJZaWZMSDIji+
	GBjDICkeoBuiQNp5iwsSc4GiEK2nGBWlxHk/sQAlBEASGaV5cGNhqesVozjQx8K8M0HaeYBp
	D677FdBgJqDBX3LbQAaXJCKkpBoYFUy27/0qsoCNOcV/6swXoZw551ZmFtc/qbBnqz94brOe
	89WJEx8ZHF+7yezzqs5eafF8e7en8Zo9U9fcbzyubnvn6+sOD693J2ZGWde83LxX 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272441>

On 06/22/2015 11:06 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> Error out if the ref_transaction includes more than one update for any
>> refname.
>>
>> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
>> ---
>>  refs.c | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
> 
> This somehow feels like "ehh, I now know better and this function
> should have been like this from the beginning" to me.
> 
> But that is OK.
> 
> Is the initial creation logic too fragile to deserve its own
> function to force callers to think about it, by the way?
> 
> What I am wondering is if we could turn the safety logic that appear
> here (i.e. no existing refs must be assumed by the set of updates,
> etc.)  into an optimization cue and implement this as a special case
> helper to ref_transaction_commit(), i.e.
> 
> 	ref_transaction_commit(...)
>         {
> 		if (updates are all initial creation &&
>                     no existing refs in repository)
> 			return initial_ref_transaction_commit(...);
> 		/* otherwise we do the usual thing */
> 		...
> 	}
> 
> and have "clone" call ref_transaction_commit() as usual.

The safety logic in this function is (approximately) necessary, but not
sufficient, to guarantee safety. One of the shortcuts that it takes is
not locking the references while they are being created. Therefore, it
would be unsafe for one process to call ref_transaction_commit() while
another is calling initial_ref_transaction_commit(). So the caller has
to "know" somehow that no other processes are working in the repository
for this optimization to be safe. It conveys that knowledge by calling
initial_ref_transaction_commit() rather than ref_transaction_commit().

Of course the next question is, "How does `git clone` know that no other
process is working in the new repository?" Actually, it doesn't. For
example, I just verified that I can run

    git clone $URL mygit &
    sleep 0.1
    cd mygit
    git commit --allow-empty -m "New root commit"

and thereby "overwrite" the upstream `master` without the usual
non-fast-forward protection. I guess we are just relying on the user's
common sense not to run Git commands in a new repository before its
creation is complete.

I suppose we *could* special-case `git clone` to not finish the
initialization of the repository (for example, not write the `config`
file) until *after* the packed-refs file is written. This would prevent
other git processes from recognizing the directory as a Git repository
and so prevent them from running before the clone is finished.

But I think if anything it would make more sense to go the other direction:

* Teach ref_transaction_commit() an option that asks it to write
  references updates to packed-refs instead of loose refs (but
  locking the references as usual).

* Change clone to use ref_transaction_commit() like everybody
  else, passing it the new REFS_WRITE_TO_PACKED_REFS option.

Then clone would participate in the normal locking protocol, and it
wouldn't *matter* if another process runs before the clone is finished.
There would also be some consistency benefits. For example, if
core.logallrefupdates is set globally or on the command line, the
initial reference creations would be reflogged. And other operations
that write references in bulk could use the new
REFS_WRITE_TO_PACKED_REFS option to prevent loose reference proliferation.

But I don't think any of this is a problem in practice, and I think we
can live with using the optimized-but-not-100%-safe
initial_ref_transaction_commit() for cloning.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
