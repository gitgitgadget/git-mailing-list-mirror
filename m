From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/6] more automation for cover letter generation
Date: Sat, 18 Apr 2009 11:31:31 -0700
Message-ID: <7v8wlxx18c.fsf@gitster.siamese.dyndns.org>
References: <1240071381-25165-1-git-send-email-ft@bewatermyfriend.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Frank Terbeck <ft@bewatermyfriend.org>
X-From: git-owner@vger.kernel.org Sat Apr 18 20:33:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvFLt-0005XJ-5H
	for gcvg-git-2@gmane.org; Sat, 18 Apr 2009 20:33:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753526AbZDRSbj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Apr 2009 14:31:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753348AbZDRSbj
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Apr 2009 14:31:39 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:46726 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752263AbZDRSbi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Apr 2009 14:31:38 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 8BB79AB8A1;
	Sat, 18 Apr 2009 14:31:36 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 78744AB8A0; Sat,
 18 Apr 2009 14:31:33 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 265ADDDA-2C47-11DE-8EDB-C121C5FC92D5-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116861>

Frank Terbeck <ft@bewatermyfriend.org> writes:

> The following setup would suit me pretty well:
>
> [format]
>     coverletter = true
>     coveronepatch = false

Nobody wants a cover letter to a single patch, so a better way
would probably be:

	'yes' means default behaviour, that is add cover letter for
	multiple-patch series, non for a single patch;

	'no' means no cover; and

	'always' means a probably insane "cover even a single patch".

In any case, because this new feature is way too late to be in the
upcoming 1.6.3 release anyway, I think it is a saner approach to add a
command line option "--cover=yes" to "cover if multiple", "--cover=always"
to "cover even a single patch", and "--cover=no" to countermand a
configured "format.cover" the user may have in the configuration from the
command line.

>     overwritecoverletter = false

I do not think it is particularly a good idea, and it is a good idea to
have it in the configuration.

 - Why not protect the earlier patch output?  People often tweak messages
   (both above and below the three-dash lines) in them.

 - Isn't this pretty much per invocation?

I can understand (I may not be enthused about it) a new --clobber={yes,no}
command line option to allow/forbid clobbering the existing files, and you
may want to add --clobber=patches to allow clobbering only the patches but
not cover (which I do not think makes much sense, though).
