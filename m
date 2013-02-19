From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Feature idea : notes to track status of a commit, which remotes
 it is shared to
Date: Tue, 19 Feb 2013 10:55:15 -0800
Message-ID: <7vsj4s5e24.fsf@alter.siamese.dyndns.org>
References: <51234801.5050208@mildred.fr>
 <87bobgtxvk.fsf@pctrast.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mildred Ki'Lya <mildred-ml@mildred.fr>, <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Feb 19 19:57:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7sNd-0005Fp-KJ
	for gcvg-git-2@plane.gmane.org; Tue, 19 Feb 2013 19:57:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934461Ab3BSSzX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2013 13:55:23 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47142 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934458Ab3BSSzS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2013 13:55:18 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B87E5B8DB;
	Tue, 19 Feb 2013 13:55:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kTbkGHtY0dVfPVn77o1tfB1hh88=; b=K/mX/v
	GL538E3VeDFOK0ZJGXBK1ENuZ3ckR6FhFxvyWxr7b7hAk4XOZ05Bb7BCFgwaUQjB
	zZQz+PM4V0v7odzj3xh2zT0YCiBMIa8TMmeSRVgmlwJZOQ+6bdTLbYmZOAJ71vYQ
	EMAV1y3an7cm0Cjh2Aad+mlEJaZd9mHTyMqBs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ruIndkPe5AtzluxHPR2X0ecsQstE33DR
	OHNakC0jHMxcxzlD/TQ67j8QS55GGrdtAeYcPAIrJdfw+eOLGRvo1wIcbfCZ0Zk9
	5RrmNcM5bvGwQKLt57VzeA631bJB3yiZRa19yISKWKfqYHqv/GIxaij0WkNBhz+K
	QNkwAGLnz74=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AAE61B8DA;
	Tue, 19 Feb 2013 13:55:17 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1490AB8D7; Tue, 19 Feb 2013
 13:55:16 -0500 (EST)
In-Reply-To: <87bobgtxvk.fsf@pctrast.inf.ethz.ch> (Thomas Rast's message of
 "Tue, 19 Feb 2013 11:13:19 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E6A50CDE-7AC5-11E2-9CBD-21622E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216646>

Thomas Rast <trast@student.ethz.ch> writes:

> Mildred Ki'Lya <mildred-ml@mildred.fr> writes:
>
>> The idea is to basically track automatically (in notes, either in the
>> notes namespace or in another namespace) which repository/remote
>> contains a commit. When doing git log, we'd see lines with each
>> commit, something like:
>>
>> commit b044e6d0f1a1782820b052348ab0db314e2db3ca
>> Author: Myself <myself@localhost.localdomain>
>> Date:   Tue Nov 20 16:46:38 2012 +0100
>>
>>     This is the commit description
>>
>> Published on:
>>     origin
>>     git@git.host.com:pub/repo.git
>
> The problem here is that doing this in notes is unreliable: you'd have
> to identify all places where the set of "publishes" can change for any
> commit, and update them there.

Unreliable you can fix with effort.

But I think a bigger problem is that it is a pointless "false
economy" to attempt to record and try to maintain this note for each
and every commit.

When you push out a tip of the branch to a new location, you would
have to update notes to all commits from that tip down to where in
the history to record that new location?  To the root?  Also your
upstream may fetch from your published place and you may fetch it
back (you will notice that now the commit appears in your 'origin').
Would you do the traversal and update all notes?

It is both much easier and cheaper to compute this on demand as you
pointed out.
