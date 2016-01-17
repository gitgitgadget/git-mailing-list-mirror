From: greened@obbligato.org (David A. Greene)
Subject: Re: [PATCH v5] contrib/subtree: fix "subtree split" skipped-merge bug
Date: Sun, 17 Jan 2016 16:40:19 -0600
Message-ID: <877fj7bzjg.fsf@waller.obbligato.org>
References: <CAPig+cSfkz=SNOn+8yP-QN8gJ0ej1wo3HW+y3NO+QvUCOP=+8A@mail.gmail.com>
	<1449695853-24929-1-git-send-email-davidw@realtimegenomics.com>
	<87y4bunopj.fsf@waller.obbligato.org>
	<CAET=KiVY5g41YgCbGqDqUaDjrd-Do9jNf=1L6xbBPcUoGcM2Kg@mail.gmail.com>
	<87bn8o97mh.fsf@waller.obbligato.org>
	<CAET=KiWjVr5h8nfU2DfUHGvzc7Tq7LoDWym7zXPq1Nvf+xHCCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: David Ware <davidw@realtimegenomics.com>
X-From: git-owner@vger.kernel.org Sun Jan 17 23:41:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aKw0O-0007XQ-B6
	for gcvg-git-2@plane.gmane.org; Sun, 17 Jan 2016 23:41:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753068AbcAQWka (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jan 2016 17:40:30 -0500
Received: from li209-253.members.linode.com ([173.255.199.253]:32952 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750769AbcAQWk2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jan 2016 17:40:28 -0500
Received: from chippewa-nat.cray.com ([136.162.34.1] helo=waller.obbligato.org)
	by johnson.obbligato.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
	(Exim 4.85)
	(envelope-from <greened@obbligato.org>)
	id 1aKw19-0003aZ-BE; Sun, 17 Jan 2016 16:41:52 -0600
In-Reply-To: <CAET=KiWjVr5h8nfU2DfUHGvzc7Tq7LoDWym7zXPq1Nvf+xHCCg@mail.gmail.com>
	(David Ware's message of "Fri, 15 Jan 2016 09:45:43 +1300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
X-Filter-Spam-Score: ()
X-Filter-Spam-Report: Spam detection software, running on the system "johnson.obbligato.org",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 @@CONTACT_ADDRESS@@ for details.
 Content preview:  David Ware <davidw@realtimegenomics.com> writes: > On Thu,
    Jan 14, 2016 at 4:12 PM, David A. Greene <greened@obbligato.org> wrote: >>
    David Ware <davidw@realtimegenomics.com> writes: >>> The commit was made
   against v2.6.3, when I try to apply the patch >>> against master it fails.
    >> >> Any ideas why? > > "git am" (a command I have never used before) Fails
    like so > > Applying: contrib/subtree: fix "subtree split" skipped-merge
   bug > error: patch failed: contrib/subtree/t/t7900-subtree.sh:468 > error:
    contrib/subtree/t/t7900-subtree.sh: pat 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284268>

David Ware <davidw@realtimegenomics.com> writes:

> On Thu, Jan 14, 2016 at 4:12 PM, David A. Greene <greened@obbligato.org> wrote:
>> David Ware <davidw@realtimegenomics.com> writes:
>>> The commit was made against v2.6.3, when I try to apply the patch
>>> against master it fails.
>>
>> Any ideas why?
>
> "git am" (a command I have never used before) Fails like so
>
> Applying: contrib/subtree: fix "subtree split" skipped-merge bug
> error: patch failed: contrib/subtree/t/t7900-subtree.sh:468
> error: contrib/subtree/t/t7900-subtree.sh: patch does not apply

Oh I'm sorry, I misunderstood.  I thought you meant that the patch
applied but the test failed.

> It doesn't even put any files into a conflict state.
> I guess it's because of the hefty test refactoring you mentioned.

You should be able to just paste your new test right to the end of the
updated test file.  The tests were refactored to make each test
independent of the other.  There's no functionality change at all.

>> Re-checking the patch submission guidelines, it looks like bugfixes
>> should be based against maint.  I did that and the test still fails with
>> your changes.  It seems like we ought to rebase to maint and continue
>> our investigation there.
>>
>
> Hmm, the patch fails to apply for me there also. Same issue with
> contrib/subtree/t/t7900-subtree.sh
>
> I haven't worked with mailed patches at all before, so it is possible
> I'm not using the correct workflow (I just saved the raw email I
> received for the patch as txt and fed it to 'git am').
> Cherrypicking the commit onto maint works fine though, and the test
> passes for me in this situation.

Ok, that's probably just fine.  I've not used git-am myself either.

>>> The process I'm using to run the tests is a little strange though, it
>>> seems I have to make git, then make contrib/subtree, then cp
>>> git-subtree to the root before running the Makefile on the tests.  Let
>>> me know if there's a less strange process for running the subtree
>>> tests.
>>
>> I actually have an update that makes this easier but I haven't submitted
>> it yet.  But yes, you've got the current process right.
>>
>
> That will be nice.

I submitted it yesterday.  Might take another round and then a few days
to get it in.  I believe it would go into master since it's a new
"feature" in the Makefile.

> I've rewritten the test to use the repo/commit creation methods, and
> renamed that branch. I've also added the comments you requested, and
> changed the push to an ancestor check.
> I'll be submitting the new version of the patch shortly.

Thank you!

                    -David
