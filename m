From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Add `init-db.templatedir` configuration variable.
Date: Wed, 13 Jan 2010 00:50:15 -0800
Message-ID: <7vljg2pewo.fsf@alter.siamese.dyndns.org>
References: <alpine.LNX.2.00.1001131719050.22639@vqena.qenxr.bet.am>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Steven Drake <sdrake@xnet.co.nz>
X-From: git-owner@vger.kernel.org Wed Jan 13 09:50:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUyvx-0005AB-ML
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jan 2010 09:50:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754904Ab0AMIuY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2010 03:50:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754827Ab0AMIuX
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 03:50:23 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:62002 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754509Ab0AMIuX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2010 03:50:23 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 627F3909CB;
	Wed, 13 Jan 2010 03:50:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cTBWIt7PePaALu+rThklcAUGRCw=; b=Unkut/
	5L9iTWTV68ZGfRL7RWZCt7Ax9xy/VnQSZAzszKljsRcNAKp1t19CyAQmnfFm89f3
	t+k78RcwVZr7VQR54UeKIJKSOO7QtU5rKOn9c0XwCDMcxE+zGq67LTk/xegyDZKG
	/epq6czT72+inb/Tj4ubUVllYv18iOhSroK9c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cy1gTJoxFLr8C43upbF/v+a+ks6C3cLR
	9SicQ4RJy2V3X+yxbg6FqnvBKCV0Rdv37CG3n2zYw/hOdEpF10Qwsd5qH0dCVKBP
	UOjirUeMdJDLahvKOvw6LHkVAkSK+jZB/Lc9Vnf2j83Y7K+pzqAK1GuizCv93GKO
	OFQi41waMMU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3DACE909CA;
	Wed, 13 Jan 2010 03:50:20 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 880EF909C7; Wed, 13 Jan
 2010 03:50:17 -0500 (EST)
In-Reply-To: <alpine.LNX.2.00.1001131719050.22639@vqena.qenxr.bet.am> (Steven
 Drake's message of "Wed\, 13 Jan 2010 17\:19\:36 +1300 \(NZDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: ADF9A6D8-0020-11DF-B130-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136792>

Steven Drake <sdrake@xnet.co.nz> writes:

> Include `init.templatedir` as an alias for `init-db.templatedir`.

This describes what the patch adds, which we can read in the diff *if* we
wanted to.  The primary job of the first paragraph of the proposed commit
log message is to convince reviewers why it might be worthwhile to read
the diff, and to explain whoever reads "git log" output in the future what
motivated this change to be made.

Your log message doesn't say anything about why it is a good idea to add
this feature, which is much more important to talk about [*1*].

The target _may_ be probably to have this in $HOME/.gitconfig so that your
personal templates in $HOME/.gittemplate/ are used in all repositories you
will create.  But you shouldn't make me, anybody who reviews, or readers
of the documentation for that matter, *guess* what problem the new feature
is meant to solve.

IOW, code talks what it itself does, but it often cannot say why it does
what it does, nor why a particular way it does what it does was chosen.
You help your code justify itself by describing the motivation in your
commit log message.

I don't think init-db.templatedir is needed nor wanted.

 - People who learn about this configuration will never heard of init-db
  (i.e. lack of necessity);

 - We have already deprecated init-db and do not advertise in "git help
   git"---the longer term direction is to remove it once everybody forgets
   about it (i.e. actively undesirable).

By the way, this is probably less useful in /etc/gitconfig, as somebody
who can configure it can customize the system-wide templates with the same
ease.  That might also be something you would want to mention in the log.

[Footnote]

*1* I am not saying the commit log message shouldn't talk about what it
does or how it does it.  It also is a good thing to do, especially when
the linkage between the motivation and the implementation is not obvious.
