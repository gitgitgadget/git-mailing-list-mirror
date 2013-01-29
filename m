From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH v2 0/4] Auto-generate mergetool lists
Date: Tue, 29 Jan 2013 16:46:20 +0000
Message-ID: <20130129164619.GA1342@serenity.lan>
References: <7v38xm12kk.fsf@alter.siamese.dyndns.org>
 <CAJDDKr7sQKDNPpaFJi+en479TF=aLXL2pvXODeo6CC3xD1KMGw@mail.gmail.com>
 <7vr4l6yrd3.fsf@alter.siamese.dyndns.org>
 <CAJDDKr75K3RGgU79nrznbpjQMLQGkDs=W8XEofURNsS1X1bvjg@mail.gmail.com>
 <20130128210136.GC7498@serenity.lan>
 <7vk3qxugdg.fsf@alter.siamese.dyndns.org>
 <20130128222147.GD7498@serenity.lan>
 <ke8de9$lk5$1@ger.gmane.org>
 <20130129120923.GE7498@serenity.lan>
 <7vsj5krmng.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Joachim Schmitz <jojo@schmitz-digital.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 29 17:47:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0EL8-0007Xm-Fv
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jan 2013 17:47:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753385Ab3A2Qq5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2013 11:46:57 -0500
Received: from coyote.aluminati.org ([72.9.247.114]:36062 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751392Ab3A2Qqz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2013 11:46:55 -0500
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 13AFA19804C;
	Tue, 29 Jan 2013 16:46:55 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Mt--Mjd0Bx9g; Tue, 29 Jan 2013 16:46:54 +0000 (GMT)
Received: from serenity.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id 62C0D1980E9;
	Tue, 29 Jan 2013 16:46:49 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <7vsj5krmng.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214948>

On Tue, Jan 29, 2013 at 08:15:15AM -0800, Junio C Hamano wrote:
> With any backend that is non-trivial, it would not be unusual for
> the *tool.cmd to look like:
> 
>      [mergetool]
>      	mytool = sh -c '
>         	... some massaging to prepare the command line
>                 ... to run the real tool backend comes here, and
>      		... then ...
>                 my_real_tool $arg1 $arg2 ...
> 	'
> 
> and you will end up detecting the presence of the shell, which is
> not very useful.
> 
> I think it is perfectly fine to say "you configured it, so it must
> exist; it may fail when we try to run it but it is your problem".
> It is simpler to explain and requires one less eval.

I think you're right.  The even worse case from this point of view is if
you configure it as:

    [mergetool]
        mytool = 'f() {
            ... code to actually run the tool here ...
        }; f $BASE $REMOTE $LOCAL $MERGED'

which results in a false "unavailable" rather than just a useless check.


John
