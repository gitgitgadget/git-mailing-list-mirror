From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Heads up: major rebase -i -p rework coming up
Date: Sat, 24 Jan 2009 12:37:53 -0800
Message-ID: <7vpricmoda.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0901242056070.14855@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Stephen Haberman <stephen@exigencecorp.com>,
	spearce@spearce.org, Thomas Rast <trast@student.ethz.ch>,
	=?utf-8?Q?Bj?= =?utf-8?Q?=C3=B6rn?= Steinbrink 
	<B.Steinbrink@gmx.de>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jan 24 21:39:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQpHw-0005JH-1K
	for gcvg-git-2@gmane.org; Sat, 24 Jan 2009 21:39:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755501AbZAXUiI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jan 2009 15:38:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755414AbZAXUiG
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jan 2009 15:38:06 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:60827 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755428AbZAXUiF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jan 2009 15:38:05 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id CD9E59369A;
	Sat, 24 Jan 2009 15:38:03 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id ACB5493699; Sat,
 24 Jan 2009 15:37:55 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.0901242056070.14855@racer> (Johannes
 Schindelin's message of "Sat, 24 Jan 2009 21:25:33 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E6072B3A-EA56-11DD-B46B-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107005>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> 	pick A
> 	pick C
> 	pick D
> 	goto A'
> 	pick B
> 	merge D' was E
>
> This should lead to a much more intuitive user experience.
>
> I am very sorry if somebody actually scripted rebase -i -p (by setting 
> GIT_EDITOR with a script), but I am very certain that this cleanup is 
> absolutely necessary to make rebase -i -p useful.

Three questions.

- An obvious one first.  How does this relate to the sequencer project (that
  seems to have gone somewhat dark?)

- What's with the apostrophe?  I seem to remember that you argued it would
  be enough to make "A" stand for the original when it is used for the
  first time and the second and later use can stand for the result of the
  last use (e.g. the "goto A'" above can be simply spelled as "goto A"),
  when I suggested to use "mark" in a way similar to how fast-import
  language uses it during the sequencer discussion?

  I am not complaining; I am just being curious why the sudden change of
  heart.

- Why do you need "merge D' was E"?  Shouldn't "pick E" be able to notice
  that E is a merge and decompose it into "merge D' was E" internally?

  This one I am somewhat complaining, unless your answer is "because this
  way the user could drop some parents from the merge in the editor".

  And if your answer is that, then my next question will be "if that is
  the case, can the user be expected to easily find out which commit each
  parent SHA-1 refers to, without having more hint on the 'merge' insn
  line?"
