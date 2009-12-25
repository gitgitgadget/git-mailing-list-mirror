From: Junio C Hamano <gitster@pobox.com>
Subject: Branch shuffling after 1.6.6 release plans
Date: Thu, 24 Dec 2009 16:25:46 -0800
Message-ID: <7vljgrgar9.fsf@alter.siamese.dyndns.org>
References: <7vpr65kwnt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 25 01:25:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NNy0F-0004KN-3p
	for gcvg-git-2@lo.gmane.org; Fri, 25 Dec 2009 01:25:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755814AbZLYAZy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Dec 2009 19:25:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755204AbZLYAZy
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Dec 2009 19:25:54 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:45178 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754270AbZLYAZy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Dec 2009 19:25:54 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BDFCFA9886;
	Thu, 24 Dec 2009 19:25:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qA1AEpHMxm+Iyk0jKYnE/Volrys=; b=rHO3+P
	wSa+ZBtH3SFkqzhO01YwZN+9TLleT5hmpMXOXIZhIbQKjNSMQAXf4uV8rfux9pVP
	0X6VOQaFJuePGuJvrElbZ0a+XIFeeCgIdmiRvhwnkoVGI/Pwv/ruBqoQoQxIjjWy
	+xOYMIGrnIZA4tOG02N6OUWw8I9S2TmM4g02A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cR08koE1IEUJ0edtQV0WRgjjUnobQqLY
	GZ6SvtbFZKy61HN9/G4ub2Z40k7uSPS78HWckyU/jCqhCpgN+4vetOd4onqqv545
	6ooHfBGKVf94C7QykY/8qErlcVHNZj/fWpxYVlWpTWge+F0S3EpNVecDmwxoPetl
	hjPIKuyN89Q=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id AA161A9884;
	Thu, 24 Dec 2009 19:25:49 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D3311A9883; Thu, 24 Dec 2009
 19:25:47 -0500 (EST)
In-Reply-To: <7vpr65kwnt.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed\, 23 Dec 2009 17\:06\:46 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0D777106-F0EC-11DE-B953-465EBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135664>

Here is a list of short-term branch shuffling I plan to do.

 - Kick a few topics back to 'pu'.  They were merged to 'next' in the hope
   of them either getting discussed to form a consensus or perfected, but
   they ended up in limbo for a long time without progress (pre-release
   freeze didn't have any impact on them),

   This involves applying a few reverts directly on top of 'next', which
   I've already done privately.  People _could_ vote to bring them back by
   working on perfecting them and/or discussing them to reach concensus.

     * je/send-email-no-subject (2009-08-05) 1 commit
      - send-email: confirm on empty mail subjects

     The existing tests cover the positive case (i.e. as long as the user says
     "yes" to the "do you really want to send this message that lacks subject",
     the message is sent) of this feature, but the feature itself needs its own
     test to verify the negative case (i.e. does it correctly stop if the user
     says "no"?)

     * tr/maint-merge-ours-clarification (2009-11-15) 1 commit
      - rebase: refuse to rebase with -s ours

     I do not think we reached a concensus for solving conflicts between "give
     them rope" and "protect users from clearly meaningless combinations".  The
     author obviously is for the latter (and I am inclined to agree); Dscho
     seems to think otherwise.

     * tr/reset-checkout-patch (2009-11-19) 1 commit
      - {checkout,reset} -p: make patch direction configurable

     I do not particularly like a configuration like this that changes the
     behaviour of a command in a drastic way---it will make helping others
     much harder.

 - Graduate the following topics to 'master':

     * sr/vcs-helper (2009-12-07) 14 commits
     * jc/1.7.0-send-email-no-thread-default (2009-08-22) 1 commit.
     * jc/1.7.0-push-safety (2009-02-09) 2 commits.
     * jc/1.7.0-diff-whitespace-only-status (2009-08-30) 4 commits.
     * gb/1.7.0-diff-whitespace-only-output (2009-11-19) 1 commit

   Also possibly:

     * jk/1.7.0-status (2009-12-11) 16 commits
     * jc/1.7.0-status (2009-09-05) 4 commits

   For these topics, we would need to decide what to do with the
   "submodule summary" stuff in the --porcelain format output, which we
   promised will never change in the documentation.  My current thinking
   is to keep the current code and don't show anything; Porcelains can
   choose to run "git log" inside submodule directories if they so desire.

 - Rebuild 'next' on top of the updated 'master' with remaining topics.

   I actually won't do this step before the new year, so that people who
   based their topics on 'next' can still fast-forward, but with many
   topics for 1.7.0 graduating this week to 'master' hopefully it would be
   easier for them to rebase on top of 'master'.
