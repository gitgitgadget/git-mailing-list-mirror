From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add platform-independent .git "symlink"
Date: Sun, 03 Feb 2008 17:45:37 -0800
Message-ID: <7vr6fto5oe.fsf@gitster.siamese.dyndns.org>
References: <8c5c35580802020959v613b9e32v321e97f93f2af761@mail.gmail.com>
	<1201975757-13771-1-git-send-email-hjemli@gmail.com>
	<alpine.LSU.1.00.0802021815510.7372@racer.site>
	<8c5c35580802021047o41a7de9fi84a6b33f0f779e2e@mail.gmail.com>
	<7vwsplporv.fsf@gitster.siamese.dyndns.org>
	<alpine.LSU.1.00.0802040024030.7372@racer.site>
	<20080204013559.GE24004@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Lars Hjemli <hjemli@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Feb 04 02:46:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLqPd-0003uB-0p
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 02:46:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754545AbYBDBpt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2008 20:45:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754428AbYBDBpt
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Feb 2008 20:45:49 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:43997 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753942AbYBDBpt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2008 20:45:49 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id C4B8C1783;
	Sun,  3 Feb 2008 20:45:46 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 232671782;
	Sun,  3 Feb 2008 20:45:39 -0500 (EST)
In-Reply-To: <20080204013559.GE24004@spearce.org> (Shawn O. Pearce's message
	of "Sun, 3 Feb 2008 20:35:59 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72447>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>> On Sun, 3 Feb 2008, Junio C Hamano wrote:
>> 
>> > "Lars Hjemli" <hjemli@gmail.com> writes:
>> > 
>> > > Maybe this as a compromise?
>> > >
>> > > 	static char buf[PATH_MAX + 9];  /* "GITDIR: " + "\n"  */
>> > > ...
>> > > 	if (!len || buf[len - 1] != '\n')
>> > > 		return NULL;
>> > > 	buf[len - 1] = '\0';
>> > > 	if (prefixcmp(buf, "GITDIR: "))
>> > > 		return NULL;
>> > 
>> > Perhaps that is easier to read.
>> > 
>> > For now I haven't picked up any of the "how about this way"
>> > revisions.
>> 
>> Yeah, I think all my comments have been addressed...  Lars, care to send a 
>> new version?
>
> I would suggest a slightly different name, "GIT_DIR: ", as the
> line prefix, because the environment variable is also GIT_DIR.
>
> But that's just me.

I think that was modelled after symref HEAD that would point at
the real ref with "ref: refs/heads/master", as if you have a
symlink whose value is "refs/heads/master".  So reusing "ref: "
might be Ok, and saying "directory: " or "gitdir: " would be
also Ok.

If we would want to reuse the mechanism in the future to allow
symlink challenged systems to use it in contrib/workdir/, we may
want to keep the name a bit more generic than "gitdir: ".
