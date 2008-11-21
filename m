From: "Bryan Donlan" <bdonlan@gmail.com>
Subject: Re: [PATCH] mmap implementation for mingw.
Date: Fri, 21 Nov 2008 15:25:58 -0500
Message-ID: <3e8340490811211225g6e479dcbyeeb793eb0f825441@mail.gmail.com>
References: <loom.20081121T024302-370@post.gmane.org>
	 <49266A59.4010404@viscovery.net> <gg5t5s$qc8$1@ger.gmane.org>
	 <alpine.DEB.1.00.0811211143550.30769@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Vasyl' Vavrychuk" <vvavrychuk@gmail.com>, git@vger.kernel.org,
	"Johannes Sixt" <j.sixt@viscovery.net>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Nov 21 21:27:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L3cay-0003XM-2W
	for gcvg-git-2@gmane.org; Fri, 21 Nov 2008 21:27:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754534AbYKUU0A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Nov 2008 15:26:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754532AbYKUU0A
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Nov 2008 15:26:00 -0500
Received: from qw-out-2122.google.com ([74.125.92.27]:38249 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752635AbYKUUZ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Nov 2008 15:25:59 -0500
Received: by qw-out-2122.google.com with SMTP id 3so214242qwe.37
        for <git@vger.kernel.org>; Fri, 21 Nov 2008 12:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=4C8NYYmO8xbO4y1CCS0FRpaicaMIxKmSFhdRffpuHBA=;
        b=xUQ0XQl/PlW+3pZNzbGypJBRuw5S7OPt/eil6juMpv9cMoSiMuzu+DGr0mD3VBlLy9
         3S7MHNzZ3GrsGXlj8YXbrWQimtPM7cUa/WNSSkCAvO9XDnMwEWZnrAni5zxkJvkgpzPE
         jizzLXUIciVWTV7xmlL/zlhn4DOs7x9JpTtbw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=nHH2Oo6oWc3YrW+UUHMXKJvQc8w7D28AzUZlwU2cTqmaIvjHzWCoSSEAwmNytVkC6C
         Y0tziIi/ha4A7M4daI12PbA9HfomWjHVKVUENu6ylQX9bbWttbdarVDx1BXz30sL1Pd0
         Tyq2PYzI2ZKNTfVgBLzwe9ehZ6KbjsINFItaQ=
Received: by 10.214.26.17 with SMTP id 17mr866378qaz.54.1227299158693;
        Fri, 21 Nov 2008 12:25:58 -0800 (PST)
Received: by 10.214.215.5 with HTTP; Fri, 21 Nov 2008 12:25:58 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0811211143550.30769@pacific.mpi-cbg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101540>

On Fri, Nov 21, 2008 at 5:48 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> [re-Cc:ed j6t]
>
> On Fri, 21 Nov 2008, Vasyl' Vavrychuk wrote:
>
>> [Dscho knows that j6t wrote this:]
>>
>> > It doesn't pass the test suite, for example t5301-sliding-window.sh
>> > fails.
>>
>> I will investigate.
>
> Note that I quickly discarded the idea of mmap() on MinGW because at least
> in the past, we used to rename files that were mmap()ed.  That is a no-go
> with CreateFile().

Hi,

I'm not overly familiar with the windows API, but wouldn't passing
FILE_SHARE_DELETE | FILE_SHARE_READ in the dwShareMode argument of
CreateFile() be enough to allow rename/deletion of the file in
question while it is mapped?

Thanks,

Bryan Donlan
