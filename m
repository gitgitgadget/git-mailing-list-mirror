From: Junio C Hamano <gitster@pobox.com>
Subject: rfc - Changing the way gitk and git-gui are managed
Date: Thu, 22 Jul 2010 19:39:11 -0700
Message-ID: <7vocdygbw0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 23 04:39:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oc8Ag-00085A-K5
	for gcvg-git-2@lo.gmane.org; Fri, 23 Jul 2010 04:39:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751585Ab0GWCjU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jul 2010 22:39:20 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:39187 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751412Ab0GWCjT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jul 2010 22:39:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 78834C7083;
	Thu, 22 Jul 2010 22:39:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type; s=sasl; bh=PXEg
	VGFQTjfVghpNObSiVhXXHCo=; b=ac4ABqPOTTW2SO/qZe2h+sLPchPSdqIvC5LB
	bTa2NxrYSrGh8hSqLeRaFDxU5tI1/xKeKvr54ZzFV6e0+c3MS53KfqcrZKrtcrGl
	iGM9PdrQloldsV58kS+4ZkO2w6CmZqrpnVRtVmBqrT0gEfHNCFh/qQUm9AwFV0tx
	0xR/djk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=Oj8
	GLpqQDYcELeC8A1DWyFC5mIGL6Y+IvWDgV49oyyK2F8SByr0QTDjchW4b4r8mV0Q
	L+yCoHWRe9VLaEv6WwSWhgnK3Q2WnuyvaS4IdwZyeXNcwM1UkP76zWEzTwSliVJn
	BKCAXx9hXtwYlhxgu1XGorTjK08/q4pD9SrE3yGE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4E37EC7081;
	Thu, 22 Jul 2010 22:39:15 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AE435C7080; Thu, 22 Jul
 2010 22:39:13 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7BF05DFC-9603-11DF-B5A9-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151502>

Somebody off-list suggested removing gitk and git-gui directories from my
repository and I've been playing with the idea and kind of like the end
result.

The plan (I am not decided to buy into it yet, hence I am sending this
rfc) is to:

    - remove gitk-git and git-gui directories;
    - add modules/gitk and modules/git-gui submodules;
    - teach the top-level Makefile about the new location of these two
      packages.

Switching from 1.7.2 to this tree will of course give you a tree without
gitk and git-gui (nothing a simple "git submodule init/update" cannot
fix), and switching back from there to 1.7.2 codebase needs manual removal
of these two directories that will become leftover directories if you want
to keep the superproject directory pristine clean, but other than that, I
do not see major downsides.

I am wondering what people think.  Especially distro people who download
and package git may be heavily affected.  I haven't adjusted the RPM spec
file or "make dist" target, so I cannot assess the damage to these people
myself yet.
