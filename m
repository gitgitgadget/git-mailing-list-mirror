From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 0/5] Header includes cleanup
Date: Mon, 30 Mar 2009 12:50:07 +0200
Message-ID: <49D0A3DF.4000203@viscovery.net>
References: <1238406925-15907-1-git-send-email-nathaniel.dawson@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Nathaniel P Dawson <nathaniel.dawson@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 30 12:51:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoF5b-0002SS-4m
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 12:51:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752303AbZC3KuB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2009 06:50:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751708AbZC3KuB
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 06:50:01 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:65197 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751009AbZC3KuA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2009 06:50:00 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1LoF42-0002po-3o; Mon, 30 Mar 2009 12:49:58 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id DC7F969F; Mon, 30 Mar 2009 12:49:57 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <1238406925-15907-1-git-send-email-nathaniel.dawson@gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115134>

Please wrap your lines at ca. 75 columns.

Nathaniel P Dawson schrieb:
> This is just the beginning for this project. I'm slowly cleaning up
> the header includes one chunk at a time. I hope my patches aren't too
> messy, I've learned how to better utilize git to make patches and
> organize my commits logically so I'll submit neater chunks henceforth.
> You can expect patches from me nightly until I've finished this project.

You have removed includes that are implied by other includes, i.e. if
foo.h includes bar.h, then you removed #include "bar.h" from *.c if there
is #include "foo.h".

IMO, this is not a good guiding principle to reduce includes. A better
principle is to keep #include "bar.h" in a source or header file iff a
feature that is declared or defined in bar.h is *used* *directly* in that
source or header file, regardless of whether bar.h is included in foo.h
that is itself included in that source or header file.

If this latter principle is obeyed, then the build won't break by removing
the include of foo.h (for the reason that nothing of foo.h is *use*
*directly* anymore).

-- Hannes
