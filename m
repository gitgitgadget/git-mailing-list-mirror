From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] unpack-trees: add the dry_run flag to
 unpack_trees_options
Date: Tue, 24 May 2011 16:18:39 -0700
Message-ID: <7v39k37kmo.fsf@alter.siamese.dyndns.org>
References: <4DDC1DF9.9030109@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed May 25 01:18:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QP0sG-0007u6-Ma
	for gcvg-git-2@lo.gmane.org; Wed, 25 May 2011 01:18:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933212Ab1EXXSr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2011 19:18:47 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:37003 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933166Ab1EXXSr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2011 19:18:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 404D75B56;
	Tue, 24 May 2011 19:20:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/sOM+FdI5/TMLGfHugyTFJDfYjw=; b=WHnK5F
	e88InwkZ6+RsDXXB7voM7WgLZpafguDEX2I/bby3RG9iEsfSWwq8WqGzCyPcS+Gu
	nzpyOTFu3bISF/fbK256T0DcBmbW7J8dv4SuWb0L/WK5OlcmFD16A1+mVTerylsk
	JFVGvJkB8yOgL2WDIhWWHjwBx0Rp0nPpXLSdc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vbt0BTWbu2Dc/U/mLQpkqDSzBeYX3aJB
	U8Q2ppUieG3e60sOaUWRs57O3OH0BaxvBqj8cz9hDnRtJXsGC1IqeDW11D4mAINa
	WppraCo9vVgIlUV0AVGnLoAdrzQ5vjFZMpqfPE3NknEVTzHajkg/eqUhI61oOZc+
	Qi7NPEuA0FA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1C1F35B55;
	Tue, 24 May 2011 19:20:52 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 1A83A5B54; Tue, 24 May 2011
 19:20:48 -0400 (EDT)
In-Reply-To: <4DDC1DF9.9030109@web.de> (Jens Lehmann's message of "Tue, 24
 May 2011 23:07:05 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 77748240-865C-11E0-A623-D6B6226F3D4C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174360>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Until now there was no way to test if unpack_trees() with update=1 would
> succeed without really updating the work tree. The reason for that is that
> setting update to 0 does skip the tests for new files and deactivates the
> sparse handling, thereby making that unsuitable as a dry run.
>
> Add the new dry_run flag to struct unpack_trees_options unpack_trees().
> Setting that together with the update flag will check if the work tree
> update would be successful without doing it for real.
>
> The only class of problems that is not detected at the moment are file
> system conditions like ENOSPC or missing permissions. Also the index
> entries of updated files are not as they would be after a real checkout
> because lstat() isn't run as the files aren't updated for real.
>
> Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
> ---

A very sane and clear description. Good.

> AFAICS this patch enables the user to achieve a dry run by calling
> unpack_trees() with both update and dry_run set.
>
> My "Teach read-tree the -n|--dry-run option" adapted to this new flag
> runs all tests successfully ...
>
>
>  unpack-trees.c |    4 ++--
>  unpack-trees.h |    3 ++-
>  2 files changed, 4 insertions(+), 3 deletions(-)

But on which change does this come?
