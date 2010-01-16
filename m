From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH v2 13/14] daemon: use select() instead of poll()
Date: Sat, 16 Jan 2010 11:59:51 +0100
Message-ID: <40aa078e1001160259h7f82b702u405a2bed515cfd81@mail.gmail.com>
References: <1263591033-4992-1-git-send-email-kusmabite@gmail.com>
	 <201001160908.33996.j6t@kdbg.org>
	 <40aa078e1001160114k5ce0414et7cd645724973609b@mail.gmail.com>
	 <201001161144.55263.j6t@kdbg.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: msysgit@googlegroups.com, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sat Jan 16 11:59:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NW6Nq-0007fT-SU
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jan 2010 11:59:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752579Ab0APK7y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Jan 2010 05:59:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752362Ab0APK7y
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Jan 2010 05:59:54 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:52889 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751462Ab0APK7x (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jan 2010 05:59:53 -0500
Received: by ewy19 with SMTP id 19so1655888ewy.21
        for <git@vger.kernel.org>; Sat, 16 Jan 2010 02:59:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=zlC+g07UueSSG2Zg6NvAknCTeqBxuNrsFTv/v5itX2w=;
        b=RnpsOd51ZG2fhhFCXPP9NHEehY3TAc3iW3oNUIGWxkaKeef3GPH38LX1CwM21oWRO6
         ODo5LInA15SYn8ZEMdNL3/0P05qmrRYxCRv+I1vaSAch5mNkXQqGXOGkJk5GMRk5oyIp
         JN6E3Oy1LtpT/gD24l2iAFMpu6ovE45ADtrAY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        b=EiT1Yfk+3xKxQ4o9Vmc3h8wNJ0WdISUybC0leEyCD/dhAd4EPB0+798pM7eEvM8E19
         roXC0CiCvlO4dgYA4oe+nBloV/ue/fkv3FiDKHk6JPtbF05qwYHEQCtsHFx9U7uPVFSK
         VmboA8Y4xDwnbcUcbJpqbKR3R4cfQ5rDjT/no=
Received: by 10.216.90.135 with SMTP id e7mr1321972wef.34.1263639591999; Sat, 
	16 Jan 2010 02:59:51 -0800 (PST)
In-Reply-To: <201001161144.55263.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137220>

On Sat, Jan 16, 2010 at 11:44 AM, Johannes Sixt <j6t@kdbg.org> wrote:
> On Samstag, 16. Januar 2010, Erik Faye-Lund wrote:
>> On Sat, Jan 16, 2010 at 9:08 AM, Johannes Sixt <j6t@kdbg.org> wrote:
>> > Wouldn't it be possible to call getsockopt(), and if it returns ENOTSOCK
>> > (WSAENOTSOCK), then it is a pipe?
>>
>> I read reports that this didn't work in Wine. Not that I care that
>> much about Wine.
>
> What does it mean that "it does not work"? Is it that it does not return
> ENOTSOCK, so that we mistake pipes as sockets?
>
> -- Hannes
>

Yes, according to the gnulib sources[1], getsockopt returns 0 for pipes.

[1]: http://git.savannah.gnu.org/gitweb/?p=gnulib.git;a=blob;f=lib/poll.c;h=90d99d92dca5d7ce2f31097e4b8fc06a83aae245;hb=HEAD#l80


-- 
Erik "kusma" Faye-Lund
