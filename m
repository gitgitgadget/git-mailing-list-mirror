From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] "git fetch --tags" seems to be broken with recent change
 on 'master'
Date: Mon, 28 Mar 2011 23:33:22 -0700
Message-ID: <7vsju6tozx.fsf@alter.siamese.dyndns.org>
References: <7vzkoeu0mr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Tue Mar 29 08:33:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4SUm-0004PR-In
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 08:33:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754023Ab1C2Gdi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2011 02:33:38 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:44166 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753740Ab1C2Gdg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2011 02:33:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id AE673235B;
	Tue, 29 Mar 2011 02:35:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=goQh4LX5x/2rvNTraSrpscn7DtQ=; b=nb5qdg
	GOjSocawppVET5ttmqrvI9HdF0Cy2BzJV40ltH097OU9K8yw1alzEx2Yw3yGD8ke
	ycACUoB5Iqyd1EZQOEc6OALONT4P9+MvBEp6EwO7EdwQnABQ9SkShzDLf+cxAVnT
	/n9o1F1879i6jtrtwy4GnHlWoPOizNtaLGbio=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=O7mwXb+cKYZ1JOKIIT2zQ8Ew+/QgaAYE
	MYl/iCUhQgPaJCWzOiEBBV3NT4qv+F6XEmWhNIzBQ1EE+EWXjH4l8Usn7DyE1r2G
	aBMSXnVb33bAskyB/Y6JYz+pPeWul2pz4VMPliqJKhvqfJNieE+phtOle1wJcSVc
	PVatr82AI+c=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8B324235A;
	Tue, 29 Mar 2011 02:35:14 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id A34892359; Tue, 29 Mar 2011
 02:35:11 -0400 (EDT)
In-Reply-To: <7vzkoeu0mr.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 28 Mar 2011 19:22:04 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B457B1EC-59CE-11E0-BD1B-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170228>

I still haven't pinpointed where things go wrong (I have GIT_TRACE_PACKET
output, thanks to Peff, though), but I seem to be reliably able to
reproduce the issue with 'master' and also reliably able to make the issue
disappear with 'master' plus two reverts ("no-done" protocol extension).

For tonight, I'll revert 3e63b21 (upload-pack: Implement no-done
capability, 2011-03-14) and 761ecf0 (fetch-pack: Implement no-done
capability, 2011-03-14), as I don't want to harm other people with this
issue.
