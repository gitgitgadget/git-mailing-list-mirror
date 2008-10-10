From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] describe: Make --tags and --all match lightweight
 tags  more often
Date: Fri, 10 Oct 2008 11:18:38 -0700
Message-ID: <7vwsggl3ep.fsf@gitster.siamese.dyndns.org>
References: <20080930083940.GA11453@artemis.corp>
 <20081010165952.GI8203@spearce.org> <20081010171217.GB29028@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Erez Zilber <erezzi.list@gmail.com>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Fri Oct 10 20:20:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KoMan-0004b8-DR
	for gcvg-git-2@gmane.org; Fri, 10 Oct 2008 20:20:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758711AbYJJSSt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Oct 2008 14:18:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758386AbYJJSSt
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Oct 2008 14:18:49 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:50470 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755501AbYJJSSs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Oct 2008 14:18:48 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 227F76D3DB;
	Fri, 10 Oct 2008 14:18:47 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 85D446D3D7; Fri, 10 Oct 2008 14:18:40 -0400 (EDT)
In-Reply-To: <20081010171217.GB29028@artemis.corp> (Pierre Habouzit's message
 of "Fri, 10 Oct 2008 19:12:17 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E14217DE-96F7-11DD-8BFA-9364E785EAEE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97952>

Pierre Habouzit <madcoder@debian.org> writes:

> I would like to see an enhanced information in the documentation so that
> people remember that lightweight tags are not meant to be constant over
> time and that's a bad idea to use them.
>
> What the discussion showed, is that the people don't know about
> annotated tags, and git-describe should have a stub of documentation
> that points to git-tag(1) so that people learn about it.
>
> Apart from that, it feels fine.

The primary mode of operation without --tags of "describe" is about coming
up with version numbers, and as such, it should try to base its output on
immutable anchors as much as possible.  For that reason, I think it should
use "tag " line from the tag object, not the name of the ref, to describe
the committish.  They should match (otherwise fsck would say something
about it) in practice, though...

The patch is about --tags, which is not about such a strict "version
number" generation, but about "come up with a closest ref", so in that
light it feels perfectly fine.
