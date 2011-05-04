From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] Add default merge options for all branches
Date: Tue, 03 May 2011 21:25:59 -0700
Message-ID: <7vzkn3f5wo.fsf@alter.siamese.dyndns.org>
References: <20110503090351.GA27862@elie> <4DC0608F.9040208@dailyvoid.com>
 <20110503204442.GI1019@elie> <7vsjsvgzzf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, vmiklos@frugalware.org
To: Jonathan Nieder <jrnieder@gmail.com>,
	Michael Grubb <devel@dailyvoid.com>
X-From: git-owner@vger.kernel.org Wed May 04 06:26:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHTfF-0003cr-RY
	for gcvg-git-2@lo.gmane.org; Wed, 04 May 2011 06:26:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751140Ab1EDE0N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2011 00:26:13 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:44683 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751088Ab1EDE0M (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2011 00:26:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D02615C4D;
	Wed,  4 May 2011 00:28:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gXwRuzCxjMuT12HgziKa0Qdms/g=; b=CdxeDn
	g971DVBAnfsoxHsNaRLhybkd6JX1r35z2A8Yw7m3tJmn9LC+fL+s/U25HmWJva1Q
	64D4UCedydoIr7wAkz4FvdyITX1sdDsnJVl7thwpOdsxPr+OXfYtGIfmem/Mn+Ms
	unMrM44ArVK/og1yTO9roEM9ZRUe0Pbhwy6oU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bl6NtfjnwM8aoNRyfnmavxHOKG+kH4v5
	TqaxTBXWkRJ3bcDouMjP822H4IuK2AbpmIFj8obtNsWdKcfQQjdvuqlpL9KuPHue
	7k0n39o+dw6wpdCoMZOA36ZNDRx4GZzrNTI6BFK9aUMNXdJUXBoJBYhHnAnnBDmK
	3g/mL9UC83E=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 896505C4C;
	Wed,  4 May 2011 00:28:10 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0BE825C4B; Wed,  4 May 2011
 00:28:04 -0400 (EDT)
In-Reply-To: <7vsjsvgzzf.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 03 May 2011 15:51:00 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EAF362BA-7606-11E0-9E38-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172712>

Junio C Hamano <gitster@pobox.com> writes:

> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>> I'm starting to suspect it might be simpler to add a new "[merge] no-ff"
>> configuration item, like the existing "[merge] log".
>
> Surely
>
> 	[merge]
>         	log = false
>               ff = false
>
> would be a lot simpler and probably far easier to explain.

Yes, it is far simpler and easier to explain.  I'll leave the tests and
the commit log message to people who are more interested in this topic
than I am ;-)

 Documentation/merge-config.txt |    6 ++++++
 builtin/merge.c                |    3 +++
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/Documentation/merge-config.txt b/Documentation/merge-config.txt
index 8920258..2aa4408 100644
--- a/Documentation/merge-config.txt
+++ b/Documentation/merge-config.txt
@@ -16,6 +16,12 @@ merge.defaultToUpstream::
 	to their corresponding remote tracking branches, and the tips of
 	these tracking branches are merged.
 
+merge.ff::
+	Do not generate a merge commit if the merge resolved as a
+	fast-forward; only update the branch pointer instead.  Setting
+	this to `false` would be equivalent to giving `--no-ff` from
+	the command line.
+
 merge.log::
 	In addition to branch names, populate the log message with at
 	most the specified number of one-line descriptions from the
diff --git a/builtin/merge.c b/builtin/merge.c
index d171c63..5194f04 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -541,6 +541,9 @@ static int git_merge_config(const char *k, const char *v, void *cb)
 		if (is_bool && shortlog_len)
 			shortlog_len = DEFAULT_MERGE_LOG_LEN;
 		return 0;
+	} else if (!strcmp(k, "merge.ff")) {
+		allow_fast_forward = git_config_bool(k, v);
+		return 0;
 	} else if (!strcmp(k, "merge.defaulttoupstream")) {
 		default_to_upstream = git_config_bool(k, v);
 		return 0;
