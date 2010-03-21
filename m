From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] git checkout: create unparented branch by --orphan
Date: Sun, 21 Mar 2010 12:37:44 -0700
Message-ID: <7vd3yxqxdj.fsf@alter.siamese.dyndns.org>
References: <1269185678-3039-1-git-send-email-erick.mattos@gmail.com>
 <20100321171431.GE2557@m62s10.vlinux.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Erick Mattos <erick.mattos@gmail.com>, git@vger.kernel.org
To: Peter Baumann <waste.manager@gmx.de>
X-From: git-owner@vger.kernel.org Sun Mar 21 20:38:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtQyE-0000OV-JA
	for gcvg-git-2@lo.gmane.org; Sun, 21 Mar 2010 20:37:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752475Ab0CUThy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Mar 2010 15:37:54 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:52736 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751337Ab0CUThx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Mar 2010 15:37:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E1A3AA447E;
	Sun, 21 Mar 2010 15:37:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=7Ba2qUuqTex/cKjQd3ebyiNhwkk=; b=hBRRZEgozzWHDyGE2DaWRgn
	4hTQ0pab9hUq7heS8QGrsH0E2k+AvbC6jOifsm8/R3gpEoFmzRFBXnS3QPUk7zCV
	QtEOM8c6ALM04Y7sQwMz8qsR9d0o/fXwhfZftpPUiXD52vIRVzZ7DDS8SuieopVc
	5Orq+/Y/aWnWdEW2wsDs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=avihNqz9i5i+/MrIhX7E2anm2LxhGWCUKDhvb8/WxF+Nb4HlC
	r2I63KvR+Zfvk3LwChF7hJYHydrJ+3FLf9Owt5HavSmclWTN8cuKgZTlK9Kofo1a
	CMj+w+M/6y5M3GjIjnPbHjnFMLTGLg6rcfIBMtR5eOzsqBr+lIyKXYfzlQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B17B6A447B;
	Sun, 21 Mar 2010 15:37:49 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F2ACAA4477; Sun, 21 Mar
 2010 15:37:45 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3BBDDCFC-3521-11DF-B5FB-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142852>

Peter Baumann <waste.manager@gmx.de> writes:

> Sorry to skim in so late but --orphan sounds - at least to me as a non native
> speaker - a little strange. Yes, I know it means "without parents", but
> actually it would be the *last* thing I would search for after opening the
> manpage.

I'm not native either, and "orphan" sounded strange in that we've never
used that word in any of our use case or workflow description in our
documents.

GitTips page of git wiki mentions this under "a new branch that has no
ancestor", and speaks of a way to add "a new and empty branch".  Scott
Chacon also creates "new empty branches" in the community book.

But if one compares them with what we discussed in the messages in the
threads on earlier iterations of this patch, one would realize that
neither of these pages is backed by enough thought/discussion on the
reason why the end user might want to do this in the first place; they
choose the word "empty" without even realizing that it describes only one
mode of operation (aka "no common paths" in our discussion) that a
disconnected history might be wanted by users.

The main point of the feature is not the emptyness of the resulting tree
(it is merely one possible outcome), but is the lack of parents in the
resulting commit.  So I would recommend against --empty.  --root might be
a good synonym, though, and we _do_ already use that word for that purpose
in some commands (e.g. "log --root").
