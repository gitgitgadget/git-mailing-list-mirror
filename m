From: Junio C Hamano <gitster@pobox.com>
Subject: What's the point of saying "HEAD is now at ..."?
Date: Thu, 13 Sep 2012 22:14:29 -0700
Message-ID: <7vvcfh6v9m.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 14 07:14:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCOEi-0004ue-Og
	for gcvg-git-2@plane.gmane.org; Fri, 14 Sep 2012 07:14:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751255Ab2INFOc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Sep 2012 01:14:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57487 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750907Ab2INFOc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Sep 2012 01:14:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 50F5998EE;
	Fri, 14 Sep 2012 01:14:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=D
	A81jTiu98/rHsBGXgrKQomuG1A=; b=Ee1IxldElb13SgPAnkQiEeQXk+4quo9ee
	XzKe0k56EzoBecf5nAVCfhyt2ZE2dT7McpNOM+dfEssQt9hWP3SkJhwwEkv3Xoxs
	6pnswjhVomwPMYiIDFzGJDqhS7QeEHglDHmhqCY3s1I2B4VvFLHyKuA2UZI7CnOh
	0Qg8O6/atA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=JIK
	pOsoK6CQ/mbZ1bEXyifYpTzNKdtStX4aceExsPZa+zclDg5H4/3l97G/jRR4LbW8
	7kP72jEvYXl7K7kQsLzQDs0oBwU5XXiEragJSsHSbY4R7MTXZp+dmerMJvUgBNt1
	IoKK2BFy1wJBMAFZ36TK+J1IuO3dZfZF1Hg9ok2c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3F62098ED;
	Fri, 14 Sep 2012 01:14:31 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A89DD98EB; Fri, 14 Sep 2012
 01:14:30 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1037F402-FE2B-11E1-95FF-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205454>

I sometimes wonder what value the message is giving us.

For example, while reviewing a patch in my Emacs session, I may say

    | git am -s3c <RETURN>

which runs the command on the contents of the e-mail I am reading,
to apply the patch.  After that, I would go to a separate terminal
and do things like "git show -U20", etc.  Once I am done, I reset
the temporary commit away, and get this:

    $ git reset --hard HEAD^
    HEAD is now at ce5cf6f Merge git://github.com/git-l10n/git-po

or often it is

    $ git reset --hard ko/master
    HEAD is now at ce5cf6f Merge git://github.com/git-l10n/git-po

In either case, I know where I am resetting to, so "HEAD is now at"
is a less than useful noise.  If it contained "HEAD was at ...", it
may let me realize that I was still going to use the contents in
some other way and quickly go back to it with another reset, with
cut and paste or with HEAD@{1}.  In either case, showing the tip of
what I just discarded seems to be a lot more useful information than
what we are currently giving the users.
