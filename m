From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Commit f5bbc322 to git broke pre-commit hooks which read stdin
Date: Tue, 04 Mar 2008 21:36:42 -0800
Message-ID: <7vtzjl3f6d.fsf@gitster.siamese.dyndns.org>
References: <0tableanpe.wl%bremner@pivot.cs.unb.ca>
 <alpine.LSU.1.00.0803041044120.22527@racer.site>
 <7vk5ki91zj.fsf@gitster.siamese.dyndns.org>
 <0t4pbmaew9.wl%bremner@pivot.cs.unb.ca>
 <alpine.LSU.1.00.0803041203320.22527@racer.site>
 <0tr6eq87az.wl%bremner@pivot.cs.unb.ca> <20080305051212.GZ8410@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Bremner <bremner@unb.ca>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Kristian =?utf-8?Q?H=C3=B8gsberg?= <krh@redhat.com>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Mar 05 06:37:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWmJr-0001rn-8u
	for gcvg-git-2@gmane.org; Wed, 05 Mar 2008 06:37:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752008AbYCEFg5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2008 00:36:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751919AbYCEFg5
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 00:36:57 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:47890 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751295AbYCEFg4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2008 00:36:56 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 62CD01112;
	Wed,  5 Mar 2008 00:36:52 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 8BB6F1111; Wed,  5 Mar 2008 00:36:46 -0500 (EST)
In-Reply-To: <20080305051212.GZ8410@spearce.org> (Shawn O. Pearce's message
 of "Wed, 5 Mar 2008 00:12:12 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76173>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> What happens to such hooks under git-gui?
>
> git-gui invokes the pre-commit hook with stdin coming off the stdin
> that the wish process inherited when it was spawned.  This may not
> be the best way to interact with the end-user of that repository.

Well, if git-gui is designed to interoperate with CLI git (and I think
that is a sensible thing to aim for), we probably should revisit the list
of hooks in hooks.txt and make sure we define the environment these hooks
are invoked in precisely enough (this incidentally will help C rewrite
effort to avoid regressing).  Then, hooks that take input from and give
output to the user could be launched with I/O redirected to talk with wish
(which I presume has a terminal lookalike widget you can embed in your
application).
