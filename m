From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/8] Teach git var about GIT_EDITOR
Date: Fri, 30 Oct 2009 15:43:52 -0700
Message-ID: <7vvdhwfqon.fsf@alter.siamese.dyndns.org>
References: <1256742357-sup-3798@ntdws12.chass.utoronto.ca>
 <7vskd3o11t.fsf@alter.siamese.dyndns.org>
 <20091029073224.GA15403@progeny.tock> <20091029075021.GC15403@progeny.tock>
 <7v8weu6idl.fsf@alter.siamese.dyndns.org>
 <20091030101634.GA1610@progeny.tock> <20091030102658.GD1610@progeny.tock>
 <4AEB51C6.7060204@kdbg.org> <20091030224737.GA16565@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>, Junio C Hamano <gitster@pobox.com>,
	Ben Walton <bwalton@artsci.utoronto.ca>,
	David Roundy <roundyd@physics.oregonstate.edu>,
	GIT List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 30 23:44:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N40Ck-0004tG-SB
	for gcvg-git-2@lo.gmane.org; Fri, 30 Oct 2009 23:44:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932997AbZJ3WoF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2009 18:44:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932958AbZJ3WoD
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 18:44:03 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:63646 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932139AbZJ3WoC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2009 18:44:02 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2E3BB6D6F0;
	Fri, 30 Oct 2009 18:44:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BeNyQfLP1Pzqr7OmHlQel14wIjc=; b=Hl/iTH
	hFIiHMo9t3Imw3NNNCT7zqfq9eYfDMAn6kFF6AIu6gc6D+v44z8fSG5Kvu7MzWnB
	P47Cn3HP0ZPchmEFmxmaUqkqEuW++pi4ndNnXCAyGAZOaj25UhTavT7nrFVFkGvU
	mEAfuIJ4sFZa3gib9A5rPF2g6wA4LlhjSM2LM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=X/wUGSOeOoUctI4C1onjCogbbKCNO//F
	Ap/JYkhLWVvSRiKRnj4YoG/RdMarE++cCorglIPu9r7jwS7DBVb5goDxQdBN705F
	AKrXvl0G5YaOwarNC/XP6IGrPK9+ycq+lKr4bnhU7oW0/pUWqoK0MhWo3e+RFx9y
	CyJTCtTRbCg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DAECC6D6EF;
	Fri, 30 Oct 2009 18:44:00 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D67176D6EE; Fri, 30 Oct
 2009 18:43:53 -0400 (EDT)
In-Reply-To: <20091030224737.GA16565@progeny.tock> (Jonathan Nieder's message
 of "Fri\, 30 Oct 2009 17\:47\:38 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B79FECB6-C5A5-11DE-9B2A-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131772>

Jonathan Nieder <jrnieder@gmail.com> writes:

> I am a bit uncomfortable with this error in general.  It makes some
> sense to refuse to use $VISUAL and fall back to $EDITOR if TERM=dumb,
> since without this the distinction between VISUAL and EDITOR is not
> very useful.

More importantly, that is what people traditionally expected from VISUAL
and EDITOR and we do that only to follow suit.

There is no such tradition for GIT_EDITOR nor core.editor and switching
behaviour based on the name of editor ("vi"? "vim"?...) does not feel
quite right.
