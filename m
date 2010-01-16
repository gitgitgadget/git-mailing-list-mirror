From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH v2 13/14] daemon: use select() instead of poll()
Date: Sat, 16 Jan 2010 10:14:23 +0100
Message-ID: <40aa078e1001160114k5ce0414et7cd645724973609b@mail.gmail.com>
References: <1263591033-4992-1-git-send-email-kusmabite@gmail.com>
	 <201001152349.06418.j6t@kdbg.org>
	 <40aa078e1001151508j208fa50boc5565a3be6bef893@mail.gmail.com>
	 <201001160908.33996.j6t@kdbg.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: msysgit@googlegroups.com, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sat Jan 16 10:14:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NW4jp-0001tj-EC
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jan 2010 10:14:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752077Ab0APJO0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Jan 2010 04:14:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752237Ab0APJO0
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Jan 2010 04:14:26 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:59312 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751587Ab0APJOZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jan 2010 04:14:25 -0500
Received: by ewy19 with SMTP id 19so1606256ewy.21
        for <git@vger.kernel.org>; Sat, 16 Jan 2010 01:14:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=zPdxDNpaYB28i7Ybz+DpXeMFDK/i1gXEP9U2iypQ3mY=;
        b=pPVsymSQ6rHo6a2JYsb6S9CFlxtb4ViuVEHXrA6NVaWNyIpQBP0/7FDci3C1DC8HZF
         moa/bpXtxiFukIiRxC7jeG/nalaOZGnE57H7SpIsuiZzV9HaoAkbRfJKrRiIMqNGrNvK
         TM4QD+oh91fUUVTdSJDseoGObZ55cXHe0cGbo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        b=BmxtQxzp+EttzSN4fFRUoC7bYu79UY92NEIBD+xUkjBDa0fGvACSVQclU+kjA617iO
         1y+aMPXW35Me6DHId9z9uLtllPMYcYSTSBi2+6esjuqJcOdzFlxbrBM8NpF4yW7l/zs0
         8nJ8WxAgrxKXXHFOzcdcJUN+iOdOhS9KS333Q=
Received: by 10.216.90.135 with SMTP id e7mr1287494wef.34.1263633264055; Sat, 
	16 Jan 2010 01:14:24 -0800 (PST)
In-Reply-To: <201001160908.33996.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137210>

On Sat, Jan 16, 2010 at 9:08 AM, Johannes Sixt <j6t@kdbg.org> wrote:
> On Samstag, 16. Januar 2010, Erik Faye-Lund wrote:
>> The problem with that is differentiating between pipes and sockets.
>> GetFileType() returns FILE_TYPE_PIPE for sockets (ugh). I did find
>> some code in gnulib that used WSAEnumNetworkEvents() to differentiate
>> between them, but I find this quite hacky.
>
> Wouldn't it be possible to call getsockopt(), and if it returns ENOTSOCK
> (WSAENOTSOCK), then it is a pipe?
>
> -- Hannes
>

I read reports that this didn't work in Wine. Not that I care that
much about Wine.

-- 
Erik "kusma" Faye-Lund
