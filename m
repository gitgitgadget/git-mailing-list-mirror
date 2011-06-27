From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: tracking submodules out of main directory.
Date: Mon, 27 Jun 2011 20:14:54 +0200
Message-ID: <4E08C89E.5020109@web.de>
References: <1309180056.2497.220.camel@Naugrim.eriador.com> <7vvcvrxlol.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: henri GEIST <henri.geist@flying-robots.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 27 20:15:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QbGLS-0002fg-Pf
	for gcvg-git-2@lo.gmane.org; Mon, 27 Jun 2011 20:15:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753257Ab1F0SP2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jun 2011 14:15:28 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:38371 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753232Ab1F0SO7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2011 14:14:59 -0400
Received: from smtp02.web.de  ( [172.20.0.184])
	by fmmailgate03.web.de (Postfix) with ESMTP id 5D858192E0055;
	Mon, 27 Jun 2011 20:14:55 +0200 (CEST)
Received: from [93.240.101.84] (helo=[192.168.178.43])
	by smtp02.web.de with asmtp (WEB.DE 4.110 #2)
	id 1QbGKl-0001tD-00; Mon, 27 Jun 2011 20:14:55 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.18) Gecko/20110616 Lightning/1.0b2 Thunderbird/3.1.11
In-Reply-To: <7vvcvrxlol.fsf@alter.siamese.dyndns.org>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1+AH6spt8CqCmfj791DS5Gjeh07zLtGxh/n24yX
	AGySgphS04JRdgHsuQmY6m94+O34IGx74OQ9YYRNuyAbn8dqUt
	dhEELndIu5q2xMM4RU1A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176358>

Am 27.06.2011 18:51, schrieb Junio C Hamano:
> One possible working tree organization may look like this:
> 
> 	-+- lib1
>          +- project1/Makefile -- refers to ../lib1
>          +- project2/Makefile -- refers to ../lib1

This is what we do at work and it works really well for us. The
possible downside (that you can't tie project1 and project2 to a
specific version of lib1 in their own repo) is not a real problem
in our experience, as the superproject ties the correct combination
together.

> An interesting point your situation raises is that there is no direct way
> to express module dependencies in .gitmodules file right now, I think.
> Ideally you would want "submodule init project1" to infer automatically
> that project1 needs lib1 and run "submodule init lib1" for you. My gut
> feeling is that it belongs to .gitmodules of the superproject

That is where this is handled now, but having a submodule refer to a
submodule outside of it as a dependency is an interesting thought. But
as that only matters at the moment you add project1 (and it won't compile
because ../lib1 is missing, which can easily handled by: "oh, then I have
to add lib1 as a submodule to the superproject too"), I'm not sure that
would be a huge improvement over just having a sane convention of where
to get lib1 from.
