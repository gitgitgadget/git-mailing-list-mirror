From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] Coverage support revisited
Date: Mon, 13 May 2013 15:14:18 -0700
Message-ID: <7vk3n2le85.fsf@alter.siamese.dyndns.org>
References: <cover.1368479988.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>, Jens Lehmann <Jens.Lehmann@web.de>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Tue May 14 00:14:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uc10j-0005fU-Gk
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 00:14:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755421Ab3EMWOV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 18:14:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49899 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754413Ab3EMWOU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 18:14:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 766581E23F;
	Mon, 13 May 2013 22:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=p7Ka6nk/OVs5FTh/LO3jM25qLXA=; b=qHu6nY
	OAZlMxes93xq2Q93dJ7GcjUyQo+9dYu7XTZBbv+ucIrx53uo31rdPcMBOOx+d/Kz
	90ZzdAcU+Myyc0TGLgYofU9rVwYjGPzCd89TrwTCPiK6lheN9iFm8ja/NUUfyVew
	nL7Yl/GL7s3GMvTDlwaFa57SSMl4SbuWWzyco=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fLjdzHdq95mMRYSG3DmIffR6ucKbrYnN
	ETgt6e4J4MBzGFAfc14ZWDR6sw6Ybh3TSxqoevX/UTedfraluKFFmhTMZqZPIpOh
	4QuhOcdnqZIsefs8FuQWbzOoZMtYsBj9LBeB7VlXbiO4G/KQm2kZADa/r10ODrx6
	iivesVKIKDI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6D6581E23E;
	Mon, 13 May 2013 22:14:20 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E00681E239;
	Mon, 13 May 2013 22:14:19 +0000 (UTC)
In-Reply-To: <cover.1368479988.git.trast@inf.ethz.ch> (Thomas Rast's message
	of "Mon, 13 May 2013 23:27:24 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7565407A-BC1A-11E2-BB7D-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224215>

Thomas Rast <trast@inf.ethz.ch> writes:

> Below is the coverage-untested-functions output; it seems submodule.c
> is covered, so there is nothing for Jens to do ;-)

Nice.

Here are some hints to add coverages to the selected functions.

> alloc.c: report
> alloc.c: alloc_report

I believe these are only for debugging.

> archive-tar.c: write_extended_header

Need to create an archive that contains loong pathname (iirc, over
100 bytes) in the test.

> attr.c: git_etc_gitattributes
> builtin#add.c: ignore_removal_cb

"--ignore-removal" option parsing.

> builtin#apply.c: checkout_target

Try "git apply --index" to an empty working tree with a valid index.

> builtin#apply.c: add_name_limit
> builtin#apply.c: option_parse_exclude
> builtin#apply.c: option_parse_include

"git apply --exclude/include".

> builtin#apply.c: option_parse_z

"git apply --stat -z".

> builtin#blame.c: read_ancestry

"git blame -S<file>".

> builtin#blame.c: sanity_check_refcnt

Only used for debugging.

> builtin#blame.c: prepare_initial

"git blame --reverse".

> builtin#blame.c: blame_move_callback

"git blame -M" (option parsing).

> varint.c: decode_varint
> varint.c: encode_varint

"git update-index --index-version 4" and then read from the
resulting index.
