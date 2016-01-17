From: greened@obbligato.org (David A. Greene)
Subject: Re: [PATCH v7] contrib/subtree: fix "subtree split" skipped-merge bug
Date: Sun, 17 Jan 2016 16:41:40 -0600
Message-ID: <8737tvbzh7.fsf@waller.obbligato.org>
References: <1452806795-26621-1-git-send-email-davidw@realtimegenomics.com>
	<1452818503-21079-1-git-send-email-davidw@realtimegenomics.com>
	<xmqq4meeisas.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Dave Ware <davidw@realtimegenomics.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 17 23:41:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aKw1B-000856-R1
	for gcvg-git-2@plane.gmane.org; Sun, 17 Jan 2016 23:41:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753430AbcAQWlu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jan 2016 17:41:50 -0500
Received: from li209-253.members.linode.com ([173.255.199.253]:32959 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753263AbcAQWls (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jan 2016 17:41:48 -0500
Received: from chippewa-nat.cray.com ([136.162.34.1] helo=waller.obbligato.org)
	by johnson.obbligato.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
	(Exim 4.85)
	(envelope-from <greened@obbligato.org>)
	id 1aKw2S-0003ay-82; Sun, 17 Jan 2016 16:43:12 -0600
In-Reply-To: <xmqq4meeisas.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Fri, 15 Jan 2016 10:58:03 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
X-Filter-Spam-Score: ()
X-Filter-Spam-Report: Spam detection software, running on the system "johnson.obbligato.org",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 @@CONTACT_ADDRESS@@ for details.
 Content preview:  Junio C Hamano <gitster@pobox.com> writes: > Dave Ware <davidw@realtimegenomics.com>
    writes: > >> 'git subtree split' can incorrectly skip a merge even when both
    parents >> act on the subtree, provided the merge results in a tree identical
    to >> one of the parents. Fix by copying the merge if at least one parent
    is >> non-identical, and the non-identical parent is not an ancestor of the
    >> identical parent. >> >> Also, add a test case which checks that a descendant
    remains a >> descendent on the subtree in this case. >> >> Signed-off-by:
     
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284269>

Junio C Hamano <gitster@pobox.com> writes:

> Dave Ware <davidw@realtimegenomics.com> writes:
>
>> 'git subtree split' can incorrectly skip a merge even when both parents
>> act on the subtree, provided the merge results in a tree identical to
>> one of the parents. Fix by copying the merge if at least one parent is
>> non-identical, and the non-identical parent is not an ancestor of the
>> identical parent.
>>
>> Also, add a test case which checks that a descendant remains a
>> descendent on the subtree in this case.
>>
>> Signed-off-by: Dave Ware <davidw@realtimegenomics.com>
>> ---
>
> David, how does this round look?  Can we proceed with your (and Eric's)
> Reviewed-by: with this version (with one grammo fix Eric pointed out)?

Yes, this looks great to me!  Thanks Dave!

                            -David

>>
>> Notes:
>>     Many thanks to Eric Sunshine and Junio Hamano for adivce on this patch
>>     Also many thanks to David A. Greene for help with subtree test style
>>     
>>     Changes since v6
>>     - I forgot the notes when I sumbitted v6. (I have now set notes.rewriteRef,
>>       so hopefully this wont happen again).
>>     - Fixed some missing && in my test rewrite.
>>     Changes since v5
>>     - Rewrote test case to use subtree test repo and commit creation methods
>>     - Added comments on what the test does and which bits are checked
>>     - Added comments to test on related bugs which aren't fixed yet
>>     Changes since v4
>>     - Minor spelling and style fixes to test case
>>     Changes since v3:
>>     - Improvements to commit message
>>     - Removed incorrect use of --boundary on rev-list
>>     - Changed use of rev-list to use --count
>>     Changes since v2:
>>     - Minor improvements to commit message
>>     - Changed space indentation to tab indentation in test case
>>     - Changed use of rev-list for obtaining commit id to use rev-parse instead
>>     Changes since v1:
>>     - Minor improvements to commit message
>>     - Added sign off
>>     - Moved test case from own file into t7900-subtree.sh
>>     - Added subshell to test around 'cd'
>>     - Moved record of commit for cherry-pick to variable instead of dumping into file
>>     
>>     [v6]: http://thread.gmane.org/gmane.comp.version-control.git/282065/focus=284095>     [v5]: http://thread.gmane.org/gmane.comp.version-control.git/282065/focus=282197>     [v4]: http://thread.gmane.org/gmane.comp.version-control.git/282065/focus=282182>     [v3]: http://thread.gmane.org/gmane.comp.version-control.git/282065/focus=282176>     [v2]: http://thread.gmane.org/gmane.comp.version-control.git/282065/focus=282121>     [v1]: http://thread.gmane.org/gmane.comp.version-control.git/282065>
>>  contrib/subtree/git-subtree.sh     | 12 ++++++--
>>  contrib/subtree/t/t7900-subtree.sh | 60 ++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 70 insertions(+), 2 deletions(-)
>>
>> diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
>> index edf36f8..5c83727 100755
>> --- a/contrib/subtree/git-subtree.sh
>> +++ b/contrib/subtree/git-subtree.sh
>> @@ -479,8 +479,16 @@ copy_or_skip()
>>  			p="$p -p $parent"
>>  		fi
>>  	done
>> -	
>> -	if [ -n "$identical" ]; then
>> +
>> +	copycommit=
>> +	if [ -n "$identical" ] && [ -n "$nonidentical" ]; then
>> +		extras=$(git rev-list --count $identical..$nonidentical)
>> +		if [ "$extras" -ne 0 ]; then
>> +			# we need to preserve history along the other branch
>> +			copycommit=1
>> +		fi
>> +	fi
>> +	if [ -n "$identical" ] && [ -z "$copycommit" ]; then
>>  		echo $identical
>>  	else
>>  		copy_commit $rev $tree "$p" || exit $?
>> diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t7900-subtree.sh
>> index 751aee3..3bf96a9 100755
>> --- a/contrib/subtree/t/t7900-subtree.sh
>> +++ b/contrib/subtree/t/t7900-subtree.sh
>> @@ -1014,4 +1014,64 @@ test_expect_success 'push split to subproj' '
>>  	)
>>  '
>>  
>> +#
>> +# This test covers 2 cases in subtree split copy_or_skip code
>> +# 1) Merges where one parent is a superset of the changes of the other
>> +#    parent regarding changes to the subtree, in this case the merge
>> +#    commit should be copied
>> +# 2) Merges where only one parent operate on the subtree, and the merge
>> +#    commit should be skipped
>> +#
>> +# (1) is checked by ensuring subtree_tip is a descendent of subtree_branch
>> +# (2) should have a check added (not_a_subtree_change shouldn't be present
>> +#     on the produced subtree)
>> +#
>> +# Other related cases which are not tested (or currently handled correctly)
>> +# - Case (1) where there are more than 2 parents, it will sometimes correctly copy
>> +#   the merge, and sometimes not
>> +# - Merge commit where both parents have same tree as the merge, currently
>> +#   will always be skipped, even if they reached that state via different
>> +#   set of commits.
>> +#
>> +
>> +next_test
>> +test_expect_success 'subtree descendant check' '
>> +	subtree_test_create_repo "$subtree_test_count" &&
>> +	test_create_commit "$subtree_test_count" folder_subtree/a &&
>> +	(
>> +		cd "$subtree_test_count" &&
>> +		git branch branch
>> +	) &&
>> +	test_create_commit "$subtree_test_count" folder_subtree/0 &&
>> +	test_create_commit "$subtree_test_count" folder_subtree/b &&
>> +	cherry=$(cd "$subtree_test_count"; git rev-parse HEAD) &&
>> +	(
>> +		cd "$subtree_test_count" &&
>> +		git checkout branch
>> +	) &&
>> +	test_create_commit "$subtree_test_count" commit_on_branch &&
>> +	(
>> +		cd "$subtree_test_count" &&
>> +		git cherry-pick $cherry &&
>> +		git checkout master &&
>> +		git merge -m "merge should be kept on subtree" branch &&
>> +		git branch no_subtree_work_branch
>> +	) &&
>> +	test_create_commit "$subtree_test_count" folder_subtree/d &&
>> +	(
>> +		cd "$subtree_test_count" &&
>> +		git checkout no_subtree_work_branch
>> +	) &&
>> +	test_create_commit "$subtree_test_count" not_a_subtree_change &&
>> +	(
>> +		cd "$subtree_test_count" &&
>> +		git checkout master &&
>> +		git merge -m "merge should be skipped on subtree" no_subtree_work_branch &&
>> +
>> +		git subtree split --prefix folder_subtree/ --branch subtree_tip master &&
>> +		git subtree split --prefix folder_subtree/ --branch subtree_branch branch &&
>> +		check_equal $(git rev-list --count subtree_tip..subtree_branch) 0
>> +	)
>> +'
>> +
>>  test_done
