From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Fix sed usage in tests to work around broken xpg4/sed on Solaris
Date: Mon, 20 Jul 2015 09:07:04 -0700
Message-ID: <xmqqd1zmzuc7.fsf@gitster.dls.corp.google.com>
References: <1437232892-27978-1-git-send-email-bdwalton@gmail.com>
	<55AB49C1.8010105@kdbg.org>
	<fadc4ff7e755913a4c6076165556b56c@www.dscho.org>
	<55AB6290.2090003@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Ben Walton <bdwalton@gmail.com>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Mon Jul 20 18:07:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZHDb0-0008IZ-JY
	for gcvg-git-2@plane.gmane.org; Mon, 20 Jul 2015 18:07:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754142AbbGTQHI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jul 2015 12:07:08 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:35847 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753674AbbGTQHG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jul 2015 12:07:06 -0400
Received: by pdjr16 with SMTP id r16so105649815pdj.3
        for <git@vger.kernel.org>; Mon, 20 Jul 2015 09:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=99wA5HagXCn0U6uP+ad6stqddhnGi3gWb8kAGHxC/is=;
        b=CtMj8el2e6kyMgDLz8N1m+V5JnGVWltJ1PAaFflwLdOgsve4AC2Jb3xi7H4IGYia+T
         SvIVwwpWaP+neZAuHFLPJ0zwMH3+68WhgDT9JbtCZX6POxF8Es3+UAPq25dp/SQcpFag
         a2S9HvK+o5Gmc9ho4M5nysm0sEC6YytYOqM+VS+VA4UIPNCjVfH9lbPPun0UtNRJ5IVw
         jonQVmyAZ+wkIVCNiUxtRO8p6tf7DIoRBVtAo5WJd3NsdcC57SbrHkyrBH7SfbC/UCUI
         wsbjuTqJYTDJKYfzimvM0ZxN7EcF8q/cC0Qs7OPDC2ry+jDdhJIIflWPVZRIK03iW+6o
         hp3g==
X-Received: by 10.70.37.77 with SMTP id w13mr62042895pdj.49.1437408426251;
        Mon, 20 Jul 2015 09:07:06 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:d4dc:19bb:f338:713b])
        by smtp.gmail.com with ESMTPSA id j4sm22578829pdg.64.2015.07.20.09.07.04
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 20 Jul 2015 09:07:05 -0700 (PDT)
In-Reply-To: <55AB6290.2090003@kdbg.org> (Johannes Sixt's message of "Sun, 19
	Jul 2015 10:40:48 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274327>

Johannes Sixt <j6t@kdbg.org> writes:

>> I really wonder why the previous ">file+ && mv -f file+ file" dance
>> needs to be replaced?
>
> The sed must be replaced because some versions on Solaris choke on the
> incomplete last line in the file.

Switching from sed to perl is not being questioned.

I think Dscho is asking about the use of "-i", when the original
idiom ">target+ && mv -f target+ target" worked perfectly fine.

I.e.

	perl -p -e '...' file >file+ &&
        mv file+ file
