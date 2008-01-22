From: "Jonathan del Strother" <maillist@steelskies.com>
Subject: Re: [RFC] File system difference handling in git
Date: Tue, 22 Jan 2008 20:54:51 +0000
Message-ID: <57518fd10801221254u19888475s6192fedbbdd0b329@mail.gmail.com>
References: <3f4fd2640801220121w60cb9a69u8519a7ceb81d3414@mail.gmail.com>
	 <7vtzl6qhtk.fsf@gitster.siamese.dyndns.org>
	 <3f4fd2640801220252q6a6557cdma4ca0a2c41223593@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Reece Dunn" <msclrhd@googlemail.com>
X-From: git-owner@vger.kernel.org Tue Jan 22 21:55:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHQ9W-0005ft-AF
	for gcvg-git-2@gmane.org; Tue, 22 Jan 2008 21:55:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753860AbYAVUyz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2008 15:54:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753847AbYAVUyz
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jan 2008 15:54:55 -0500
Received: from rv-out-0910.google.com ([209.85.198.185]:43588 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752061AbYAVUyy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jan 2008 15:54:54 -0500
Received: by rv-out-0910.google.com with SMTP id k20so2240129rvb.1
        for <git@vger.kernel.org>; Tue, 22 Jan 2008 12:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=qnwOimPTF/35R1DNG1KhdhMzJ/bj95u2WII1kN2Bego=;
        b=NzvTefRYMh8RZ95W6RiK6ZYVvo54816/Oe5mDQrzU6/PAkoUxHOqsi893LhUYRmI/uzVUp+kqlh7o0StVkhYpxnqs8gnUULaecvhw5uQhaegTJAoVIdBXYh3kSU3r8eJe53wpR73CYzvIsLJXAXyUAolOvHnkNPK9BNgInTLzIY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=DxwchP1FwtXwheDO1zwp0SiFJpgB1Is6BXtu5V3PAjNHc0YdaXbJJmabn2wwCeipa7Xkvk0JpD5dRlzk4Wn/GuxSuJm8Nm4nx7S2uueE9eLY+B7eTajWP39eCaJQ3tpVBDduki2W9QKbURrVOS1PBYq2M0Jx/hh0zoe25wpXJXc=
Received: by 10.141.18.14 with SMTP id v14mr5714660rvi.252.1201035291770;
        Tue, 22 Jan 2008 12:54:51 -0800 (PST)
Received: by 10.141.5.2 with HTTP; Tue, 22 Jan 2008 12:54:51 -0800 (PST)
In-Reply-To: <3f4fd2640801220252q6a6557cdma4ca0a2c41223593@mail.gmail.com>
Content-Disposition: inline
X-Google-Sender-Auth: 3e1a311960326b3c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71468>

On Jan 22, 2008 10:52 AM, Reece Dunn <msclrhd@googlemail.com> wrote:
> This is what I am saying. For example, if you say:
>
>    git mv myfile.H myfile.h
>
> on a case sensitive filesystem (e.g. ext3), this will work, however on
> a case insensitive filesystem (e.g. ntfs) git would complain that the
> files are the same.
>
> The workaround is to say:
>
>    git mv myfile.H myfile.h.tmp
>    git mv myfile.h.tmp myfile.h
>
> but this is not ideal, especially if you are automating some move operations.
>

If I remember correctly, this fails when it comes to applying the
commit containing that move, at least on HFS+.  You could create 2
commits (one with the first mv, one with the second), and apply them
one at a time, but it's a pretty unpleasant workaround.
