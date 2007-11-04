From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add more tests for git-clean
Date: Sun, 04 Nov 2007 15:35:42 -0800
Message-ID: <7vve8hr3ch.fsf@gitster.siamese.dyndns.org>
References: <1194202941253-git-send-email-shawn.bohrer@gmail.com>
	<11942029442710-git-send-email-shawn.bohrer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Shawn Bohrer <shawn.bohrer@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 05 00:36:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iop0d-0003oQ-9p
	for gcvg-git-2@gmane.org; Mon, 05 Nov 2007 00:36:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752953AbXKDXft (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2007 18:35:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751729AbXKDXft
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 18:35:49 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:34269 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751480AbXKDXft (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2007 18:35:49 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 7E8D42EF;
	Sun,  4 Nov 2007 18:36:09 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 182EC923F6;
	Sun,  4 Nov 2007 18:36:05 -0500 (EST)
In-Reply-To: <11942029442710-git-send-email-shawn.bohrer@gmail.com> (Shawn
	Bohrer's message of "Sun, 4 Nov 2007 13:02:20 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63458>

Shawn Bohrer <shawn.bohrer@gmail.com> writes:

> +test_expect_success 'git-clean with prefix' '
> +
> +	mkdir -p build docs &&
> +	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
> +	cd src/ &&
> +	git-clean &&
> +	cd - &&

This is wrong for two reasons.

 - Is "cd -" portable?

 - What happens when git-clean fails?  This test fails, and then
   it goes on to the next test without cd'ing back.
