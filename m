From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-init: treat option `--bare'
Date: Wed, 28 May 2008 17:55:46 -0700
Message-ID: <7vzlqaq67h.fsf@gitster.siamese.dyndns.org>
References: <20080519175313.GA17305@bit.office.eurotux.com>
 <20080520194850.GB19226@bit.office.eurotux.com>
 <7vy761sgks.fsf@gitster.siamese.dyndns.org>
 <20080528185103.GA4431@bit.office.eurotux.com>
 <20080528185357.GB4431@bit.office.eurotux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Luciano Rocha <luciano@eurotux.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 29 02:57:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1WSE-0004Sv-75
	for gcvg-git-2@gmane.org; Thu, 29 May 2008 02:57:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752656AbYE2A4A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2008 20:56:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751857AbYE2A4A
	(ORCPT <rfc822;git-outgoing>); Wed, 28 May 2008 20:56:00 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:57572 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751829AbYE2A4A (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2008 20:56:00 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id BA54A1F8A;
	Wed, 28 May 2008 20:55:58 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 0A0801F89; Wed, 28 May 2008 20:55:55 -0400 (EDT)
In-Reply-To: <20080528185357.GB4431@bit.office.eurotux.com> (Luciano Rocha's
 message of "Wed, 28 May 2008 19:53:57 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 003EDE26-2D1A-11DD-84ED-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83163>

Luciano Rocha <luciano@eurotux.com> writes:

> Currently, passing the `--bare' option to git-init proper doesn't work, and
> gives no indication that `git --bare init' would work instead:
>
> $ git init --bare
> usage: git-init [-q | --quiet] [--template=<template-directory>] [--shared]
>
> Treat the `--bare' option internally in builtin-init-db.
>
> Also, fix the usage string, synchronising it with the synopsis in the
> documentation.
>
> Signed-off-by: Luciano Rocha <strange@nsk.pt>

It could be argued that this kind of "special casing to help common
mistake situation" would in the long run hamper the new users in
understanding what --bare means, because one who uses "git init --bare"
will not realize that --bare is an option to "git" potty in general and
can be given when invoking other git commands.  On the other hand, many
commands do work sensibly inside a bare repository already, and "init" is
truly special in that it cannot inspect the surroundings to guess if the
user wants to create a bare repository or one with a work-tree because
there isn't a repository yet.  In that sense, probably people not learning
"git --bare" is not such a loss after all.

In general, I am not particularly fond of this kind of special casing, but
initializing a bare repository would be a common enough operation that I
personally think it is probably Ok to take this as an exception.

Opinions?  Breakages?
