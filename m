From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [Patch v2] Add test-string-list.c
Date: Mon, 06 Sep 2010 17:15:06 -0700
Message-ID: <7viq2is92t.fsf@alter.siamese.dyndns.org>
References: <1283816603-12156-1-git-send-email-tfransosi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jrnieder@gmail.com
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 07 02:15:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OslqM-0003ia-PD
	for gcvg-git-2@lo.gmane.org; Tue, 07 Sep 2010 02:15:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752940Ab0IGAPS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Sep 2010 20:15:18 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:33439 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752229Ab0IGAPQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Sep 2010 20:15:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 60927D3899;
	Mon,  6 Sep 2010 20:15:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pKspzKNyLXkLr987XMvz5Hxkhpg=; b=fsRT36
	KiIYItIRmNB0SF3RN3yduEGL+v+Pp+ehOA1HpfZiur5HGub6jXIIZq7qAv/16plv
	gOSbQdOO6GNsvGotXwhMNXOKFFHZns3NLWtOCZRJZ9dLxHxMEBmHaopZETsupq1z
	eeSCcR5j4FxXO9wLyn3J3MZwk4jfqMM7QgIrk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cwxV2EkFV2KDz9tFcnlBVClHuW/0Ynw2
	YCTqSPacJ1SGZ+DJvDnLbqULTKWE2WlQD6paLkeEi0O3TGAORfI9mq+GDxZi1r5i
	onzoxq7MBS1THiVJH6sicrgj/XC6WlUoiNI/0BCcdHHOyk4x3ZFoVsDjqmuZkDzN
	iloC+lJqNZA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2D70BD3895;
	Mon,  6 Sep 2010 20:15:12 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 54AC2D3893; Mon,  6 Sep
 2010 20:15:08 -0400 (EDT)
In-Reply-To: <1283816603-12156-1-git-send-email-tfransosi@gmail.com> (Thiago
 Farina's message of "Mon\,  6 Sep 2010 20\:43\:23 -0300")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: FB3CF69E-BA14-11DF-8079-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155650>

We have many invocations of string_list_* functions in the code that are
already run with our test suite, and breakage to string_list functions
would very likely break them.  This patch adds yet another and a lot
simpler caller that is not used from anywhere.

Sorry, but I simply do not see the point.

As I already said in a previous message, your program, because it is so
short and simple, may be a lot easier example for people who are learning
git API than any of the real existing programs.  It might be a good public
service to give it a wider exposure by having it somewhere in my tree than
burying it in your blog ;-), but then I think a better place to do so
would be in Documentation/technical/api-*.txt and not in "test program"
that is not used by anything.

Or are you planning to change the implementation of string_list so
drastically real soon now that you need a specific test that only checks
the API?  If that is the case, I am Ok with treating it just like test-date
which tries to test the approxidate API in isolation, but then you would
need to connect test-string-list to a t/tNNNN-XXXX.sh script in the test
suite.

But for that purpose, you are not exercising the API to any meaningful
depth yet.  It uses the unordered append interface to add only two
elements, does a single look up, and clear.  It may be a good start, but
it isn't yet something I would want to be CC'ed for application.

Thanks.
