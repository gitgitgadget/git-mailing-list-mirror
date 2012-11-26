From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-gui: textconv not used on unstaged files
Date: Mon, 26 Nov 2012 12:54:11 -0800
Message-ID: <7vk3t8qe4s.fsf@alter.siamese.dyndns.org>
References: <5088347F.50503@arcor.de> <50B3D0D2.6060308@arcor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Peter Oberndorfer <kumbayo84@arcor.de>
X-From: git-owner@vger.kernel.org Mon Nov 26 21:54:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Td5hY-00014Z-Ch
	for gcvg-git-2@plane.gmane.org; Mon, 26 Nov 2012 21:54:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755127Ab2KZUyS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2012 15:54:18 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50421 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754669Ab2KZUyO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2012 15:54:14 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D5074AFA2;
	Mon, 26 Nov 2012 15:54:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=isJ8M7yJrQgmbO0VpoDlaIM43Jc=; b=FmIcMa
	sm3C2X6kBlG0U6RmVMXcwPbz1jgs6mEcVYlkDX76uHvRJv7lvRg2jLE+fxSiAaUM
	PD+JlhCo2BuwygURY/q6t/zV0F/49Ali99TbkhTQkQ0i4vVlYW3g8lXVV90hobzM
	FmPtAItGuBva3t3vMYwQ9RitjZHloXxDBEzEQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WiHGDgnhE2HDUHiIQb+QVRMC6slzq+6F
	LmSWiE1SgpSY59ap31+NtwUOAak8O0pFrVR5IlBRyErGCqMgrSqV97tczBgt7sxs
	v1ujb+XNzUZWUn56dnczcUZpTFuRfCss43qHSMN/Xdtaq8qrGvlnYMax7JTeVgXA
	OHrcNF1XZQw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BA090AFA1;
	Mon, 26 Nov 2012 15:54:13 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2CECEAF9C; Mon, 26 Nov 2012
 15:54:13 -0500 (EST)
In-Reply-To: <50B3D0D2.6060308@arcor.de> (Peter Oberndorfer's message of
 "Mon, 26 Nov 2012 21:28:02 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6EF589B8-380B-11E2-AE69-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210487>

Peter Oberndorfer <kumbayo84@arcor.de> writes:

> Does anybody have a idea which git command would output the diff
> of a untracked file against /dev/null?

The "--no-index" option is meant as a bolt-on to let you use various
features of "git diff" that is missing from other people's "diff" in
a context where git does not know anything about that file.  It
should be usable even outside a git repository.

    $ git diff --no-index /dev/null new-file.txt

I do not know offhand (and didn't bother to check) if textconv
applies, though.  It does need access to a git repository as it
reads from the $GIT_DIR/config to learn what to do.
