From: Junio C Hamano <gitster@pobox.com>
Subject: Re: rev-list --cherry-pick and context lines
Date: Fri, 02 Sep 2011 12:13:40 -0700
Message-ID: <7vippalpuj.fsf@alter.siamese.dyndns.org>
References: <4E60F707.40708@drmicha.warpmail.net>
 <1k6zcbk.ov5qevxc1a91M%lists@haller-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@drmicha.warpmail.net (Michael J Gruber), git@vger.kernel.org
To: lists@haller-berlin.de (Stefan Haller)
X-From: git-owner@vger.kernel.org Fri Sep 02 21:13:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QzZBX-0008LI-BH
	for gcvg-git-2@lo.gmane.org; Fri, 02 Sep 2011 21:13:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754851Ab1IBTNp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Sep 2011 15:13:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51191 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754342Ab1IBTNp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Sep 2011 15:13:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 150F15B3D;
	Fri,  2 Sep 2011 15:13:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=T3txSunRIs/L88Dy2F764iisjHw=; b=hPkfV8
	SnlTmJWa6wRx2CzVqrVNzNuIxvFikPLUlOa0Z3n033VyOpwDD8tf2RAZs3qS3oAW
	yl5o9wAggPO8tvsDg7PtEabJD61gyFWCYC2hqrXg3v/rW/HsN84KinuCAKFvG396
	bwGQC267Ock8fReCK56gmgZuf/L5mNDgo8jY8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qK2nIXFAeI1Da7MQ7yFep8p+sBbtaWo+
	gNDeCTHMNyG5biEOKm4ajkV3E/ggDwzHpOFdeUGLf7p3Ol1QxvrW9ZfkBg+wlOyS
	HRKCl96SQ+0e9FYyfSjL/CWFyMu99+d5kLzZzxMiK0pi39SMWSV4UAZNna9SWM8b
	AFkntiMkorU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 025CD5B3C;
	Fri,  2 Sep 2011 15:13:44 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8A0E95B3B; Fri,  2 Sep 2011
 15:13:43 -0400 (EDT)
In-Reply-To: <1k6zcbk.ov5qevxc1a91M%lists@haller-berlin.de> (Stefan Haller's
 message of "Fri, 2 Sep 2011 18:33:06 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: ACB9FA86-D597-11E0-A280-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180633>

lists@haller-berlin.de (Stefan Haller) writes:

> Is there a reason why the hard-coded default is 3 in the current code?
> It seems to me that 1 would be a better choice; it would mean "patches
> are equal if their added/removed lines are the same, and they could be
> cherry-picked without conflicts."

Even if two patches have the same added/deleted lines, depending on where
in the preimage they are applied (which is given by the context lines),
the meaning of the patches can be and are very different. So if the
default for showing uses 3-line contect (hence applying, as e-mailed
patches are usually generated with 3-line context), it makes sense for the
default to generate patch id to match it.

As Michael hinted, I think it would make sense to reduce the number of
context lines to generate patch-id the same way if/when you reduce the
context to smaller number of lines for the purpose of patch application,
but it does not make sense to use zero-line context as default.
