From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-daemon is insecure?
Date: Sun, 27 Jan 2008 19:00:13 -0800
Message-ID: <7vk5luwt6q.fsf@gitster.siamese.dyndns.org>
References: <20080127103934.GA2735@spearce.org>
	<7vsl0ix4gh.fsf@gitster.siamese.dyndns.org>
	<20080128001655.GY24004@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Jan 28 04:00:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJKEy-0002j3-C5
	for gcvg-git-2@gmane.org; Mon, 28 Jan 2008 04:00:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751770AbYA1DAZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2008 22:00:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752652AbYA1DAZ
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Jan 2008 22:00:25 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:40387 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751734AbYA1DAZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2008 22:00:25 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id D76791CEA;
	Sun, 27 Jan 2008 22:00:23 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 793B91CE9;
	Sun, 27 Jan 2008 22:00:21 -0500 (EST)
In-Reply-To: <20080128001655.GY24004@spearce.org> (Shawn O. Pearce's message
	of "Sun, 27 Jan 2008 19:16:55 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71847>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> With regards to this patch, yes, you can export your entire $HOME
> and maybe expose things you shouldn't or didn't want to.

That was not what I meant.  git-daemon running as nobody.project
will allow read access to project group's files, and the
whitelisting and --base-path are ways to limit it to files that
are in the repository.  But the process still has the power to
read files outside that can be read nobody user or project
group, the only thing needed is for git-daemon and whatever it
spawn to have bugs.

But the point is that "power to read files outside" is still
limited to nobody.project, even if there are such bugs to allow
it escape the whitelist/base-path jail.  It won't extend to
anybody's $HOME.

If you run git-daemon as spearce.spearce, you cannot rely on
that built-in limitation.
