From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Better cooperation between checkouts and stashing
Date: Mon, 01 Mar 2010 11:44:38 -0800
Message-ID: <7vk4tvsu6x.fsf@alter.siamese.dyndns.org>
References: <4B67227A.7030908@web.de>
 <7vhbq0wuy6.fsf@alter.siamese.dyndns.org> <4B898F97.90706@web.de>
 <7vr5o6s5xf.fsf@alter.siamese.dyndns.org> <4B8B9BF1.10408@web.de>
 <7v1vg4ufas.fsf@alter.siamese.dyndns.org>
 <4b8c0420.5544f10a.2eb2.ffffb4c4@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Markus Elfring <Markus.Elfring@web.de>
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 01 20:44:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NmBXz-0005ah-4s
	for gcvg-git-2@lo.gmane.org; Mon, 01 Mar 2010 20:44:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751282Ab0CATot (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Mar 2010 14:44:49 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:37360 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750855Ab0CATos (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Mar 2010 14:44:48 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B84F49ED99;
	Mon,  1 Mar 2010 14:44:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zs4wuMZUWGoZ3ara+5X59+9zFlo=; b=gLzBJ0
	Rb/PiS3KnO0pyrsAgt0cR5otbYy0nnwh+h4nib3crfByBD76JfgEGrAeqVIfIxOW
	MdR88QxIQQ2+0zh+cuZRF4wBTRDCL22B9G9VPX6rB/JxMWxJedDLzEYGNbBi8F1V
	7nfni/jWdK5VikItl/gUa38dpvTpDqt713lmM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IfyMW6VxlWjN2ao84s44mJ5zJifPz1ve
	vTDol8bzYAfUN2fMlNAZmQXPBtMwnZLR8CVjI/LRD28djXnHp3psdgljylv0oAsv
	+HuRnZKzCxsVW4Se2FqAtN/0V1iE8ESMbjTa3AU1/CaUVbnEAVHmNUwhZPzFi+c5
	sePTcEdCQzU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8834C9ED98;
	Mon,  1 Mar 2010 14:44:44 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C7B5C9ED96; Mon,  1 Mar
 2010 14:44:39 -0500 (EST)
In-Reply-To: <4b8c0420.5544f10a.2eb2.ffffb4c4@mx.google.com> (Michael
 Witten's message of "Mon\, 01 Mar 2010 10\:14\:56 -0800 \(PST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E2BE23C0-256A-11DF-805E-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141343>

Michael Witten <mfwitten@gmail.com> writes:

> Markus Elfring's goal (I think) is to associate local modifications with
> a particular branch, *not* carry them across branches;

You fooled me by having "stash pop" in the same script after you wrote
'git checkout "$@"' to switch branches.  If you want to have per-branch
stash, that is a totally independent problem, and I'd suggest using real
refs ($GIT_DIR/refs/stashes/$branch_name) instead of the md5 hack, if that
is the motivation.
