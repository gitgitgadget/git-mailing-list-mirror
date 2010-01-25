From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH] Handle UNC paths everywhere
Date: Mon, 25 Jan 2010 20:45:48 +0100
Message-ID: <40aa078e1001251145o13545328o7d46086ff09e6d33@mail.gmail.com>
References: <201001250155.47664.robin.rosenberg@dewire.com>
	 <alpine.DEB.1.00.1001251553150.8733@intel-tinevez-2-302>
	 <40aa078e1001250957h292f8b01me8f7dec4ba2b425b@mail.gmail.com>
	 <alpine.DEB.1.00.1001251916030.8733@intel-tinevez-2-302>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jan 25 20:48:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZUsk-0003fr-Q3
	for gcvg-git-2@lo.gmane.org; Mon, 25 Jan 2010 20:45:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752189Ab0AYTpw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Jan 2010 14:45:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752146Ab0AYTpv
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jan 2010 14:45:51 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:47045 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751908Ab0AYTpu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Jan 2010 14:45:50 -0500
Received: by ewy19 with SMTP id 19so122834ewy.21
        for <git@vger.kernel.org>; Mon, 25 Jan 2010 11:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Xa1v3yLrWSV2sRqNjfQvUecHBNuZ6Iwyu2hiX0z2doM=;
        b=WYEgQ0MG3QFh3eec8leCVizhebjuoPywfYh0VOVvQeUhUt6/A/chtoi3lZ64m9a/18
         wXZolUhJlCZC9Bp5vMZTfuP0frv+sxhCl4kNFJpFFH2hxaVor6znREKcqGvaptEH7i/K
         STbMj2PXa3yjMmiRLL2gcaJg6GTjyLJ4CzcOo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=Yok0Q8nlKeZ4M2PnxrCHzU2rJU3NiZU2boQfidWUfZchyQ8cYsR3s+SrHwk36aKseg
         J3/dMuIjzr6brsbLVJtHR37mY0IWcqBuj8cZ5HQ1YjglLxnXI3CiF4IriteQpsM5lEHw
         GIsD1jmD2hBpX+lmGVerKYEg29gHq1r3sy7qw=
Received: by 10.216.89.200 with SMTP id c50mr2533934wef.137.1264448748491; 
	Mon, 25 Jan 2010 11:45:48 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.1001251916030.8733@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137985>

On Mon, Jan 25, 2010 at 7:19 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Mon, 25 Jan 2010, Erik Faye-Lund wrote:
>
>> On Mon, Jan 25, 2010 at 6:34 PM, Johannes Schindelin
>> <Johannes.Schindelin@gmx.de> wrote:
>> > Hi,
>> >
>> > On Mon, 25 Jan 2010, Robin Rosenberg wrote:
>> >
>> >> >From 37a74ccd395d91e5662665ca49d7f4ec49811de0 Mon Sep 17 00:00:0=
0 2001
>> >> From: Robin Rosenberg <robin.rosenberg@dewire.com>
>> >> Date: Mon, 25 Jan 2010 01:41:03 +0100
>> >> Subject: [PATCH] Handle UNC paths everywhere
>> >>
>> >> In Windows paths beginning with // are knows as UNC paths. They a=
re
>> >> absolute paths, usually referring to a shared resource on a serve=
r.
>> >
>> > And even a simple "cd" with them does not work.
>> >
>>
>> But it does, at least for me - both in bash and cmd.exe. I just need
>> to log on to the server first, unless it's a public share.
>
> I love it when people say "it works for me, so let's do it".
>
> _My_ _only_ instance of Windows cmd says this:
>
> =A0 =A0 =A0 =A0C:\Blah> cd \\localhost
> =A0 =A0 =A0 =A0'\\localhost'
> =A0 =A0 =A0 =A0CMD does not support UNC paths as current directories.
>
> =A0 =A0 =A0 =A0C:\Blah>
>
> So.

Actually, you're right about cmd.exe - I somehow mixed that up.
However, it works fine in bash (and simply by doing chdir() from a
normal C-program), as long as I've logged on in advance.

This applies to my Vista 64 and XP installations.

>
> Besides, the patch was not in a form where I can say that it was obvi=
ously
> fixing the issue. It was rather in a form where I would have to have =
set
> aside a substantial amount of time to verify that nothing undesired w=
as
> introduced as a side effect.
>

This I can agree on. I just wanted to clear up the situation about
cd'ing. But I failed - hopefully that's corrected now.


--=20
Erik "kusma" Faye-Lund
