From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [1.8.0] git checkout refs/heads/foo checks out branch foo
Date: Mon, 07 Feb 2011 15:37:15 -0800
Message-ID: <7vaai7s9g4.fsf@alter.siamese.dyndns.org>
References: <alpine.DEB.1.10.1102062234010.3788@debian>
 <20110207205934.GD13461@sigill.intra.peff.net>
 <AANLkTinmqTi4cYbR6PtSxt6itCvFQDuT_sE1tjx45a3h@mail.gmail.com>
 <20110207220030.GA19357@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>, Jeff King <peff@peff.net>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 08 00:37:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmaeH-0002kP-Px
	for gcvg-git-2@lo.gmane.org; Tue, 08 Feb 2011 00:37:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755296Ab1BGXhc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Feb 2011 18:37:32 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:39584 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755210Ab1BGXhb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Feb 2011 18:37:31 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 968163799;
	Mon,  7 Feb 2011 18:38:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=w0I5AkhenQdbQGGdcCy2WCcgshA=; b=ABkEzD
	sUa6eEXoJR1YISdLplqdpUwS+MbFxQXuRz98aiNNed9D9xBxe6FZP2RhGuEJUFBj
	kry3PsqCFakaM0xIIHBo7iWwjoXKflFbhlpGppeq0mfoLPkDrQ1o+o7+RwmNa0iZ
	LxT9jD+2t2bDSrfiigF5t7K5bbYnn9vl3IAJ8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vFhTweXZNfZPr2m9eMxQOD/zQhGviWd+
	AyEveRb7BofEZEDB0+bljb334hbKhVHUFAMJGQEdMO/7PGFfG+Qu2eC4T4ccD++E
	UKxXZI23g3tg11bmEB4OgoCgBn94CG7UuLnl9YaUp3ZTAHOhD+tOD8u7TCZVaZzb
	WW0tVg9zMSM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3FD2F3794;
	Mon,  7 Feb 2011 18:38:21 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 78D043791; Mon,  7 Feb 2011
 18:38:14 -0500 (EST)
In-Reply-To: <20110207220030.GA19357@elie> (Jonathan Nieder's message of
 "Mon\, 7 Feb 2011 16\:00\:30 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5908457C-3313-11E0-AC2B-F13235C70CBC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166310>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Sverre Rabbelier wrote:
>
>> Now _that_ is an excellent usability improvement, assuming we want to
>> encourage detaching HEAD... do we?
>
> Yes.
>
> -- 8<
> Subject: commit: document --detach synonym for "git checkout foo^{commit}"
>
> For example, one might use this when making a temporary merge to test
> that two topics work well together.
>
> This patch just documents the option.  It is not meant for application
> without an implementation and tests for the option.

On top of v1.7.3.5-1-g0cb6ad3 (uk/checkout-ambiguous-ref)...

 builtin/checkout.c |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 953abdd..141f6a3 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -685,6 +685,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	char *conflict_style = NULL;
 	int patch_mode = 0;
 	int dwim_new_local_branch = 1;
+	int force_detach = 0;
 	struct option options[] = {
 		OPT__QUIET(&opts.quiet),
 		OPT_STRING('b', NULL, &opts.new_branch, "branch",
@@ -692,6 +693,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 		OPT_STRING('B', NULL, &opts.new_branch_force, "branch",
 			   "create/reset and checkout a branch"),
 		OPT_BOOLEAN('l', NULL, &opts.new_branch_log, "create reflog for new branch"),
+		OPT_BOOLEAN(0, "detach", &force_detach, "detach the HEAD at named commit"),
 		OPT_SET_INT('t', "track",  &opts.track, "set upstream info for new branch",
 			BRANCH_TRACK_EXPLICIT),
 		OPT_STRING(0, "orphan", &opts.new_orphan_branch, "new branch", "new unparented branch"),
@@ -726,6 +728,9 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	if (opts.new_branch && opts.new_branch_force)
 		die("-B cannot be used with -b");
 
+	if ((opts.new_branch || opts.new_orphan_branch) && force_detach)
+		die("--detach cannot be used with -b/-B/--orphan");
+
 	/* copy -B over to -b, so that we can just check the latter */
 	if (opts.new_branch_force)
 		opts.new_branch = opts.new_branch_force;
@@ -834,7 +839,8 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 		new.name = arg;
 		setup_branch_path(&new);
 
-		if (check_ref_format(new.path) == CHECK_REF_FORMAT_OK &&
+		if (!force_detach &&
+		    check_ref_format(new.path) == CHECK_REF_FORMAT_OK &&
 		    resolve_ref(new.path, branch_rev, 1, NULL))
 			hashcpy(rev, branch_rev);
 		else
