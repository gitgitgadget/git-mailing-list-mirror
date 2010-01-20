From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCHv8 00/10] git notes
Date: Tue, 19 Jan 2010 19:29:29 -0800
Message-ID: <7vska15u92.fsf@alter.siamese.dyndns.org>
References: <1258681154-2167-1-git-send-email-johan@herland.net>
 <7vk4xl5y3z.fsf@alter.siamese.dyndns.org>
 <20091120192800.6117@nanako3.lavabit.com>
 <7vk4xl1nkl.fsf@alter.siamese.dyndns.org>
 <81b0412b1001190754m37ed01b0nd93b318d77d88a75@mail.gmail.com>
 <7vk4ve9dad.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	spearce@spearce.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 20 04:29:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXRGT-0004Km-GN
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jan 2010 04:29:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754614Ab0ATD3t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2010 22:29:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754329Ab0ATD3s
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jan 2010 22:29:48 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:50948 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754023Ab0ATD3r (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2010 22:29:47 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5D77D9285A;
	Tue, 19 Jan 2010 22:29:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AzhbWj5uZwLdiL5275MJgHxqnQA=; b=r+MQfD
	dHtxQQCtlLNkGMtw/Xtd3X7KL/YJ/OQwT7ajFFQ+MVQLuGZxmys9t3PXHE03XyHG
	VoNzSowZswIsdYvzdy8VMaUeRoIoC1ljF2vqorEYUBDy0dZ9C3lpEcrKwObQV/Gr
	PMPgQ3AfZ3d55ICrVRP5GFvtffR9j6xxnc/6Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uOsxRFncZsT0HQN1HLg1NHolnu31IAor
	0I7TXn40nQade1/AEMqMoKQIvZa9VjYMgpFXiudjHPy+pNw3HG3SSFmBMlGCTRUy
	ndlyMqW+J8mHEnxGe52ZeHSNolvnO6ctrdM2+DUqhVWKo6HOhx5oERQiJWZ2AM7W
	67vCk1ZCOzA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E7E2D92854;
	Tue, 19 Jan 2010 22:29:38 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 71B609284F; Tue, 19 Jan
 2010 22:29:31 -0500 (EST)
In-Reply-To: <7vk4ve9dad.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue\, 19 Jan 2010 10\:10\:02 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0A28D2E6-0574-11DF-877D-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137518>

Junio C Hamano <gitster@pobox.com> writes:

> Alex Riesen <raa.lkml@gmail.com> writes:
>
>> On Fri, Nov 20, 2009 at 11:46, Junio C Hamano <gitster@pobox.com> wrote:
>>> @@ -716,7 +719,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
>>>                if (!strcmp(arg, "-"))
>>>                        arg = "@{-1}";
>>>
>>> -               if (get_sha1(arg, rev)) {
>>> +               if (get_sha1_mb(arg, rev)) {
>>>                        if (has_dash_dash)          /* case (1) */
>>>                                die("invalid reference: %s", arg);
>>>                        if (!patch_mode &&
>>
>> This is a bit of a problem on Windows, as the arg (eventually containing
>> something like "master..."), will be passed to resolve_ref below.
>
> I don't see "resolve_ref below"; do you mean this part?
>
> 		/* we can't end up being in (2) anymore, eat the argument */
> 		argv++;
> 		argc--;
>
> 		new.name = arg;
> 		if ((new.commit = lookup_commit_reference_gently(rev, 1))) {
> 			setup_branch_path(&new);
> 			if (resolve_ref(new.path, rev, 1, NULL))
> 				new.commit = lookup_commit_reference(rev);
> 			else
> 				new.path = NULL;
> 			parse_commit(new.commit);
> 			source_tree = new.commit->tree;
> 		} else
> 			source_tree = parse_tree_indirect(rev);
>
> It is primarily to tell "git checkout master" and "git checkout master^0"
> apart (the latter must detach HEAD).  IOW, it is testing if you gave the
> "name" of the branch, or something that yields the commit object name that
> happens to be at the tip of the branch.  So the call to resolve_ref() is
> very relevant.
>
>> Now, Windows,
>> being the piece of shit it is, will lie and tell that a file
>> "refs/heads/master..."
>> exists and be same as "refs/heads/master".
>
> Meh; then windows users cannot use "git checkout A..." syntax (they can
> still use "git checkout A...HEAD", I presume).
>
> This is not a problem specific to three-dots, but if you give the function
> "refs/heads/master.."  it would also get "exists" back, no?  You could
> teach resolve_ref() about windows (namely, the filesystem may lie about
> anything that ends with a series of dots).
>
>> This breaks "checkout to merge base" on Windows and t2012 in particular.

I think the attached patch would help.  If this fix is Ok with Windows
people (J6t CC'ed), I'd like to apply this to 'master' so that we can ship
1.7.0-rc0 without breakage.

Thanks.

-- >8 --
Subject: Fix "checkout A..." synonym for "checkout A...HEAD" on Windows

When switching to a different commit, we first see the named rev exists
as a commit using lookup_commit_reference_gently(), and set new.path to
a string "refs/heads/" followed by the name the user gave us (but after
taking into special short-hands like @{-1} == "previous branch" and
"@{upstream}" == "the branch we merge with" into account).  If the
resulting string names an existsing ref, then we are switching to that
branch (and will be building new commits on top of it); otherwise we are
detaching HEAD at that commit.

When the "master..." syntax is used as a short-hand for "master...HEAD",
we do want to detach HEAD at the merge base.  However, on Windows, when
asked if ".git/refs/heads/master..." exists, the filesystem happily says
"it does" when ".git/refs/heads/master" exists.

Work this issue around by first calling check_ref_format(new.path) to see
if the string can possibly be a valid ref under "refs/heads/", before
asking resolve_ref().

We used to run another lookup_commit_reference(rev) even though we know it
succeeded and we have a good commit in new.commit already; this has been
with us from 782c2d6 (Build in checkout, 2008-02-07), the first version we
had "git checkout" implemented in C.  Drop it.

Noticed by Alex Riesen.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-checkout.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/builtin-checkout.c b/builtin-checkout.c
index fe7c858..ad3c01f 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -745,8 +745,10 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 		new.name = arg;
 		if ((new.commit = lookup_commit_reference_gently(rev, 1))) {
 			setup_branch_path(&new);
-			if (resolve_ref(new.path, rev, 1, NULL))
-				new.commit = lookup_commit_reference(rev);
+
+			if ((check_ref_format(new.path) == CHECK_REF_FORMAT_OK) &&
+			    resolve_ref(new.path, rev, 1, NULL))
+				;
 			else
 				new.path = NULL;
 			parse_commit(new.commit);
