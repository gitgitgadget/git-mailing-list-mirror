From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] pre-commit hook should ignore carriage returns at EOL
Date: Thu, 26 Jun 2008 15:33:58 -0700
Message-ID: <7vk5gbq10p.fsf@gitster.siamese.dyndns.org>
References: <3BA781AD-4C44-4F43-902A-07580B6CA075@gmail.com>
 <20080625181422.GC4039@steel.home>
 <5B163827-204D-4F76-88C9-8F0C93E60AF3@gmail.com>
 <7vhcbh1g4e.fsf@gitster.siamese.dyndns.org>
 <635350D7-2CC0-4FA6-BB74-CE9ED930ECE8@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Christian Holtje <docwhat@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 27 00:35:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KC03a-0002uY-7D
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 00:35:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752901AbYFZWeK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2008 18:34:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752865AbYFZWeI
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jun 2008 18:34:08 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:37686 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752537AbYFZWeH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2008 18:34:07 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A6F9723D48;
	Thu, 26 Jun 2008 18:34:03 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id F10D623D42; Thu, 26 Jun 2008 18:33:59 -0400 (EDT)
In-Reply-To: <635350D7-2CC0-4FA6-BB74-CE9ED930ECE8@gmail.com> (Christian
 Holtje's message of "Wed, 25 Jun 2008 22:41:12 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: FAD780F6-43CF-11DD-B0F8-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86494>

Christian Holtje <docwhat@gmail.com> writes:

>> I suggested using "diff --check" (and possibly teaching "diff --check"
>> other things the scripted example checks, such as conflict markers),
>> which would know to honor the line endings specified per path via
>> gitattributes(5), instead of building on top of the big Perl script,
>> and I
>> had an impression that you agreed to the approach.
>
> I'm completely confused how gitattributes and core.autocrlf interact,
> etc.

Here is a series I just cooked up so that we can remove the whole Perl
script and replace it by adding --check to "diff-index" used there. 

The first three are code clean-ups and the last two implements necessary
new features to "diff --check".  The whole series somewhat depend on the
fix to 'maint' not to lose the exit status I sent earlier.

[PATCH 1/5] diff --check: explain why we do not care whether old side is binary
[PATCH 2/5] check_and_emit_line(): rename and refactor
[PATCH 3/5] checkdiff: pass diff_options to the callback
[PATCH 4/5] Teach "diff --check" about a new blank lines at end
[PATCH 5/5] diff --check: detect leftover conflict markers
