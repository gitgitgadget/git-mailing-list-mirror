From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] grep: do not do external grep on skip-worktree entries
Date: Mon, 11 Jan 2010 08:24:43 -0800
Message-ID: <7veilwr4ms.fsf@alter.siamese.dyndns.org>
References: <7vtyv4cpna.fsf@alter.siamese.dyndns.org>
 <87ljgfgbl0.fsf@catnip.gol.com>
 <fc339e4a1001021847hf1e1a7fq894de7908839ff77@mail.gmail.com>
 <877hrzga16.fsf@catnip.gol.com>
 <alpine.LFD.2.00.1001031124420.3630@localhost.localdomain>
 <7v3a2mzzg4.fsf@alter.siamese.dyndns.org>
 <20100104053125.GA5083@coredump.intra.peff.net>
 <7vbphaquwl.fsf@alter.siamese.dyndns.org>
 <20100104064408.GA7785@coredump.intra.peff.net>
 <alpine.LFD.2.00.1001040659150.3630@localhost.localdomain>
 <fc339e4a1001040757n31298f3h724eacfafb68c63e@mail.gmail.com>
 <alpine.LFD.2.00.1001040801290.3630@localhost.localdomain>
 <7vvdf9402f.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1001110739280.13040@localhost.localdomain>
 <alpine.LFD.2.00.1001110748560.13040@localhost.localdomain>
 <7vtyusr4r7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Miles Bader <miles@gnu.org>, Jeff King <peff@peff.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Jan 11 17:25:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUN4e-0007kl-QI
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jan 2010 17:25:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751243Ab0AKQY5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Jan 2010 11:24:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751050Ab0AKQY5
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jan 2010 11:24:57 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:52375 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751191Ab0AKQY4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Jan 2010 11:24:56 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1C2218F83D;
	Mon, 11 Jan 2010 11:24:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=uMFyeyAZQtWX
	yp6AUWCLmS3vQpk=; b=fvkelHphsrnbn88tKHeUNjGdqOUEl4oSFfqsnRyc1nIH
	2jo0qgYbCbqq3JP7AZ4NxrCQdaA8yMswnJJXEMMNEU3fUGukU83Fb17/SH+wjeko
	LASqj/uL2ysacFqp03lTcgWbG3RzczJPSnYIC5zJ+oFWylbqnIw5ercm1esi5Tc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=fxnjTZ
	iV4oI2sd3xGU1uDFrFl5O0pJS8tTAcC2T+fV2RS+BWu3wJkF46StM18Px5HZFQ5G
	IOZNQz6v3duYq49hyCmz4XEepEjJt7fel0hGHxVB7h6VXWfB3VsCIs/HDoBK8/40
	B2o+U4OAqhLjnVGH3dLNcLlo4jmxBuDPnr1kU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B55278F839;
	Mon, 11 Jan 2010 11:24:50 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8BCEF8F834; Mon, 11 Jan
 2010 11:24:44 -0500 (EST)
In-Reply-To: <7vtyusr4r7.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon\, 11 Jan 2010 08\:22\:04 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D79883A0-FECD-11DE-BB67-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136641>

Junio C Hamano <gitster@pobox.com> writes:

> Meh.  I checked pre-context codepath before sending the patch and was=
 very
> satisfied that Ren=C3=A9 did the right thing in 49de321 (grep: handle=
 pre
> context lines on demand, 2009-07-02), but somehow forgot about the po=
st
> context codepath.

Just to clarify, it was *I* who forgot to check the post context codepa=
th
while adding the lookahead; I didn't mean Ren=C3=A9 forgot anything in =
49de321.
