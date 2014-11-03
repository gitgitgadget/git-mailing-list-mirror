From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] submodule: Fix documentation of update subcommand
Date: Mon, 03 Nov 2014 12:53:14 -0800
Message-ID: <xmqqsii0qa4l.fsf@gitster.dls.corp.google.com>
References: <1415009391-14979-1-git-send-email-sojkam1@fel.cvut.cz>
	<xmqqegtkrtt9.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Michal Sojka <sojkam1@fel.cvut.cz>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Nov 03 21:53:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XlOcu-0005zA-0v
	for gcvg-git-2@plane.gmane.org; Mon, 03 Nov 2014 21:53:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753675AbaKCUxT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2014 15:53:19 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50752 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752335AbaKCUxS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2014 15:53:18 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B7B601B920;
	Mon,  3 Nov 2014 15:53:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=o4/EtcC919aCSTv4FaZ7VrndECs=; b=gAH8CC
	/DLGAWY1mZzK4VuvjFAGTT1LgovLvVhTxUgn2uuonFWV+9XceAjGM4gql9H5ZHA0
	514l3rJG541mfUg2BjL4DlydHvlhKBX94hXLWEa7c+lITParn/LAwGJvtyJEx4CG
	7LXPYlrO65nk3EnK05Cq9Ww/QmBo4Dm5zxDrA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fJAV4/c2SP3l1pXjS58UgBGs+Xp8r1so
	wCRi14wak5DcNjPYmBaKmlvr/3vul+ywJ/gInP986rkhuTybMRiJPThhEnTGcJKr
	D80+qMtFzRsOvPMsD0o4F9PQ/3wYKhg9+7X8XplV6oYQiSPSnWzgkKfvRF6v82qW
	zSccDPCYWM4=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AED091B91F;
	Mon,  3 Nov 2014 15:53:16 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D777E1B91D;
	Mon,  3 Nov 2014 15:53:15 -0500 (EST)
In-Reply-To: <xmqqegtkrtt9.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 03 Nov 2014 11:02:42 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6EDBF51C-639B-11E4-B50D-692F9F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I did a bit more digging of the history, and came up with this,
which would be with a clearer and fairer description.  Also to
clarify, I spelled what Michal's "This" meant to refer to.

-- >8 --
From: Michal Sojka <sojkam1@fel.cvut.cz>
Date: Mon, 3 Nov 2014 11:09:51 +0100
Subject: [PATCH] submodule: clarify documentation for update subcommand

e6a1c43a (document submdule.$name.update=none option for gitmodules,
2012-05-10) meant to say "Unlike the case where your .update
configuration is set to either 'rebase' or 'merge', when it is set
to 'none', the tip of the submodule would never move.  You can use
the --checkout option if you want the contents of the submodule to
be updated to some other commit."

But the resulting text made it sound as if using "--checkout" would
have no effect when .update configuration is set to 'rebase' or
'merge', which was misleading.  In fact, with the "--checkout"
option, the tip of the submodule moves to the exact commit that is
recorded in the superproject tree, regardless of .update
configuration.

Signed-off-by: Michal Sojka <sojkam1@fel.cvut.cz>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-submodule.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 8e6af65..648323f 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -158,7 +158,7 @@ update::
 	checkout the commit specified in the index of the containing repository.
 	This will make the submodules HEAD be detached unless `--rebase` or
 	`--merge` is specified or the key `submodule.$name.update` is set to
-	`rebase`, `merge` or `none`. `none` can be overridden by specifying
+	`rebase`, `merge` or `none`. The configuration can be overridden by specifying
 	`--checkout`. Setting the key `submodule.$name.update` to `!command`
 	will cause `command` to be run. `command` can be any arbitrary shell
 	command that takes a single argument, namely the sha1 to update to.
-- 
2.2.0-rc0-43-g5b91d12
