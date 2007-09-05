From: Junio C Hamano <gitster@pobox.com>
Subject: Re: .gitignore, .gitattributes, .gitmodules, .gitprecious?,.gitacls? etc.
Date: Wed, 05 Sep 2007 01:14:44 -0700
Message-ID: <7vk5r5jzpn.fsf@gitster.siamese.dyndns.org>
References: <7vhcmmpxed.fsf@gitster.siamese.dyndns.org>
	<B4A2AE9980774365B5D14B442A7A22F6@ntdev.corp.microsoft.com>
	<20070826100647.GH1219@pasky.or.cz>
	<4C603F7C51884DF8AFAEC3F6E263798D@ntdev.corp.microsoft.com>
	<a1bbc6950708271327x4dd948d4m8e9e35f757a7d92e@mail.gmail.com>
	<Pine.LNX.4.64.0708280945350.28586@racer.site>
	<20070904202326.GC3786@efreet.light.src>
	<a1bbc6950709050106j137215obd7272b2a77c3b13@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Jan Hudec" <bulb@ucw.cz>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Petr Baudis" <pasky@suse.cz>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Dmitry Kakurin" <dmitry.kakurin@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 05 10:15:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISq2i-0004Fn-8p
	for gcvg-git@gmane.org; Wed, 05 Sep 2007 10:15:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755957AbXIEIOx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Sep 2007 04:14:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755772AbXIEIOx
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 04:14:53 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:56334 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755924AbXIEIOw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2007 04:14:52 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 2AFF812EBC1;
	Wed,  5 Sep 2007 04:15:08 -0400 (EDT)
In-Reply-To: <a1bbc6950709050106j137215obd7272b2a77c3b13@mail.gmail.com>
	(Dmitry Kakurin's message of "Wed, 5 Sep 2007 01:06:03 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57682>

"Dmitry Kakurin" <dmitry.kakurin@gmail.com> writes:

> I assert that since index does not have .gitattributes the one from
> local directory should not be used.
>
> Think about dedicated build machine scenario: I have a machine that
> always does sync + build. After every sync the local directory should
> always be identical to what-was-committed.

Thinking about the reason _why_ .gitattributes may be updated,
one would notice that it is because somebody did this command
sequence:

	git checkout		;# now work tree is clean
	edit .gitattributes	;# modify the attributes of a file
	edit file		;# edit the file attributes talks about
	git add file		;# this can be affected by .gitattributes
	git add .gitattributes	;# this is changed in the same commit
	git commit

Now, should we always take .gitattributes from the index?
