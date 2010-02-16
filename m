From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH v2 07/11] notes: implement helpers needed for note
 copying during rewrite
Date: Tue, 16 Feb 2010 15:58:18 -0800
Message-ID: <7v635w20o5.fsf@alter.siamese.dyndns.org>
References: <cover.1266361759.git.trast@student.ethz.ch>
 <b8d8e699a7067f0bb095f4df73966fc61ffeb6c6.1266361759.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>, Johannes Sixt <j6t@kdbg.org>,
	Johan Herland <johan@herland.net>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Feb 17 00:58:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhXJM-0008Ah-PR
	for gcvg-git-2@lo.gmane.org; Wed, 17 Feb 2010 00:58:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933513Ab0BPX6b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2010 18:58:31 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:36093 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933117Ab0BPX6a (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2010 18:58:30 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id F0E119AFC5;
	Tue, 16 Feb 2010 18:58:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=K3crGJXOwhLGXxRduvAkDLBPWjY=; b=xIohpW
	Y/eoselBIuD3zDmdpDtFSy5iNi86unpMIgvqM5iCta3vtjysT1qkNbPFf4cWF6RB
	bNxckeTw7dNQsDgSVx8kezymksWmWlhxsgGlSXh9xFKGlkx5n1U7eFZWv0AvHk8c
	jqxiiw+xDoNVnRmuqan35asXEr4zbdgSupuI4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Wra/Yax0V+q0EQPLv/iEDGe2+9MAkR3+
	ASbUPCbS5Uen1KZ0bAtPEZf97YjSlt2j2VgWtSfnfHfWlqy+wuzLJ3UWLTtNNNSA
	pcU8FPDV58CvFpn6SbIv1IcFOiiZN6G1/daF2Jf6vD80yaPpog2BvFrKeRuxffyd
	tGMeK7Uw/WQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 515739AFC3;
	Tue, 16 Feb 2010 18:58:25 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3BB339AFC0; Tue, 16 Feb
 2010 18:58:20 -0500 (EST)
In-Reply-To: <b8d8e699a7067f0bb095f4df73966fc61ffeb6c6.1266361759.git.trast@student.ethz.ch> (Thomas Rast's message of "Wed\, 17 Feb 2010 00\:26\:03 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2BA835D0-1B57-11DF-9589-D83AEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140183>

Thomas Rast <trast@student.ethz.ch> writes:

> Implement helper functions to load the rewriting config, and to
> actually copy the notes.  Also document the config.

I find it somewhat unnerving that this series is a bit overengineered to
have fancier and facier handling of notes, while at the same time still
sticking to the "only one default notes tree" mode of operation.  Are you
digging a deep hole that you will find hard to get out of when you finally
need to support copying/rewriting notes from multiple trees at the same
time?
