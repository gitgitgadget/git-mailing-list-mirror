From: Junio C Hamano <gitster@pobox.com>
Subject: Re: fixing workdirs
Date: Thu, 08 Jul 2010 12:40:11 -0700
Message-ID: <7v7hl5pxt0.fsf@alter.siamese.dyndns.org>
References: <20100708110842.GC12789@madism.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git ML <git@vger.kernel.org>
To: Pierre Habouzit <madcoder@madism.org>
X-From: git-owner@vger.kernel.org Thu Jul 08 21:40:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWwxS-0004nY-58
	for gcvg-git-2@lo.gmane.org; Thu, 08 Jul 2010 21:40:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758528Ab0GHTkT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jul 2010 15:40:19 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:42652 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758465Ab0GHTkS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jul 2010 15:40:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EBE34C22DE;
	Thu,  8 Jul 2010 15:40:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=E2rpTQ8dsg2LiSuTA7JidN9w+Rc=; b=odb8eXlOSTkLVYzXmTt4iKu
	xrQLLp7U0Iop/Y8cgriHaDQp7LuZHyrHvEPcNakBkKMVBNSgg99vgsRQFhuuIVMd
	PbwsZqMqXvAcvGxk6APxeRIHmt1y9R1fu2YG12LGcWq09WCDX9LCmYofr9D7ew4o
	jCc0U85/oyA7qCPoHo54=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=JE61GZ8/QuAylWXlDAldHKVuVLhLOXf5ESZSOhojIlitjneDs
	uKLMUVbLWZLCElr8VXuwvfmA/ZhXVwKSSTQ+2VYNbd4gB76YDlO+QccI+8SUEdcm
	QuX/GvV3KR0/MHbNFCHb2q0s1lZrZ9qo5lLboVgmhoQBchewNTawHEBZ/E=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C9195C22DB;
	Thu,  8 Jul 2010 15:40:15 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2C334C22D8; Thu,  8 Jul
 2010 15:40:13 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A1DAC98A-8AC8-11DF-80A9-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150607>

Pierre Habouzit <madcoder@madism.org> writes:

> for the first one, the fix is simple: workdirs have now a name, and
> their HEAD reflog lives in the "master" git repository reflog namespace
> under logs/workdir/$workdir_name/HEAD. The workdir HEAD reflog is then a
> symlink to the masters.

I think this is a sane thing to do, except for the "symlink" part but that
would be just a minor implementation detail.

> For the second one, when a workdir is created, a [workdir "foo"] section
> is added to the master directory, with a path configuration variable
> pointing to the ... path of the working directory.

Ok.

> ... git checkout would check that no other workdir is currently "on
> the same branch", and would refuse to checkout to a branch that is
> already checkouted elsewhere.

I am personally fine with this, but if there is no way to override this
refusal it may break some people's existing workflow.  I dunno.
