From: John Keeping <john@keeping.me.uk>
Subject: Re: Error:non-monotonic index after failed recursive "sed" command
Date: Mon, 14 Jan 2013 12:12:47 +0000
Message-ID: <20130114121247.GS4574@serenity.lan>
References: <CAMoGvRKkSZqcoGtiebu6tuPndzOjQ1=JgQHb+iusAHpUbA2HbA@mail.gmail.com>
 <vpq38y42clj.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: George Karpenkov <george@metaworld.ru>, git <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jan 14 13:13:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tuiuj-000205-Pq
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jan 2013 13:13:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756241Ab3ANMM6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2013 07:12:58 -0500
Received: from coyote.aluminati.org ([72.9.247.114]:38694 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755732Ab3ANMM4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2013 07:12:56 -0500
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id B425F19800B;
	Mon, 14 Jan 2013 12:12:55 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -11
X-Spam-Level: 
X-Spam-Status: No, score=-11 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UmEXEgpADeQy; Mon, 14 Jan 2013 12:12:55 +0000 (GMT)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by coyote.aluminati.org (Postfix) with ESMTP id 1B062198028;
	Mon, 14 Jan 2013 12:12:54 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id B7F46161E554;
	Mon, 14 Jan 2013 12:12:54 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KJWz41FAhiv2; Mon, 14 Jan 2013 12:12:54 +0000 (GMT)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id F27A7161E574;
	Mon, 14 Jan 2013 12:12:49 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <vpq38y42clj.fsf@grenoble-inp.fr>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213484>

On Mon, Jan 14, 2013 at 01:06:16PM +0100, Matthieu Moy wrote:
> George Karpenkov <george@metaworld.ru> writes:
>> I've managed to corrupt my very valuable repository with a recursive
>> sed which went wrong.
>> I wanted to convert all tabs to spaces with the following command:
>>
>> find ./ -name '*.*' -exec sed -i 's/\t/    /g' {} \;
> 
> Clearly, this is a dangerous command as it impacts .git/. However, Git
> partially protects you from this kind of error, since object files and
> pack files are read-only by default.
> 
> My obvious first advice is: make backups of your corrupted repository.
> Yes, I said backup_s_, better safe than sorry.

Having backed up the corrupt state, another option is to just try
running the reverse command:

find .git -name '*.*' -exec sed -i 's/    /\t/g' {} \;

I had a quick grep over some pack indices here and '    ' doesn't occur
in any of mine whereas '\t' is very common so you may find that the only
'    ' sequences are the ones you introduced.


John
