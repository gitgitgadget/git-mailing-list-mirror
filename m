From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Use git_open_noatime when accessing pack data
Date: Wed, 03 Nov 2010 12:35:20 -0700
Message-ID: <7vvd4ew687.fsf@alter.siamese.dyndns.org>
References: <1288652061-19614-1-git-send-email-spearce@spearce.org>
 <1288652061-19614-2-git-send-email-spearce@spearce.org>
 <7v8w1axrnp.fsf@alter.siamese.dyndns.org> <20101103174148.GB13377@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 03 20:37:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDj9f-00080Q-Bn
	for gcvg-git-2@lo.gmane.org; Wed, 03 Nov 2010 20:37:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753743Ab0KCTfc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Nov 2010 15:35:32 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:54484 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753371Ab0KCTfb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Nov 2010 15:35:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E3E342490;
	Wed,  3 Nov 2010 15:35:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Gv++aoCVPtb6J80pDvICDQxPEAA=; b=YEAFV+
	ymNt0ky7azBKWhKYpyKqEMu1PxmSJoQLp7+v3FkhHOl3yIb4JBTegnwe5yvbQxZl
	XQMwI42MEFDihbxdk5jzxO6c3FC7uo9W58cts/TTNOZpnar4uYqyReQtKDftnveJ
	2YsjaVKwegId7k6tBI06baHaYiwQ9Szp4fMGE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=O/vlUP4nePrrtPGrVMya24YWAfJ6go9z
	ljks+qjnY32ugG8NuRTMDpYGszfelzKcIRB72CkT6Fh82PdUIuYkQkEEjaMC+GZw
	c7zU8oAzT0x7nbK7djQSmrZnG7WbSMZU6c6Cn77XnG2nB21U40mbidbfCLdoV0JZ
	DBRvnoyQE20=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AEFC7248F;
	Wed,  3 Nov 2010 15:35:25 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A9768248D; Wed,  3 Nov
 2010 15:35:21 -0400 (EDT)
In-Reply-To: <20101103174148.GB13377@burratino> (Jonathan Nieder's message of
 "Wed\, 3 Nov 2010 12\:41\:48 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 81AE210A-E781-11DF-B691-B51D107BB6B6-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160636>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Judging from these three use cases, readonly open()s to the worktree
> should indeed use noatime, but open()s of .git/config, say, should
> not.  Hmm.

Why not, when you are talking about readonly open?
