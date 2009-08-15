From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: http-push sends MKCOL command to create remote directory MKCOL 
	http://user@server:80/url/.git/refs/ that already exists
Date: Sat, 15 Aug 2009 09:28:12 +0800
Message-ID: <be6fef0d0908141828u1e426dc5nbf94b9a5db015943@mail.gmail.com>
References: <1250264521299-3445796.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: willievu <willievu@dev.java.net>
X-From: git-owner@vger.kernel.org Sat Aug 15 03:28:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mc84F-0003qh-N7
	for gcvg-git-2@gmane.org; Sat, 15 Aug 2009 03:28:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755242AbZHOB2M convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Aug 2009 21:28:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754487AbZHOB2M
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Aug 2009 21:28:12 -0400
Received: from mail-yx0-f175.google.com ([209.85.210.175]:43031 "EHLO
	mail-yx0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754204AbZHOB2L convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Aug 2009 21:28:11 -0400
Received: by yxe5 with SMTP id 5so2373040yxe.33
        for <git@vger.kernel.org>; Fri, 14 Aug 2009 18:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Fcfk4XNCaxvN7QUPOc34gewgtlFofQLYxew28GXWz18=;
        b=ZWvlb5T4m/ScBP1v6+qeXWJqwPpMQJQ+KDcuC0k1HVihtFIlXTtpqvsy1bP35WBYYN
         aMg84vhjrH+pQDGaT6/2yd2mS2reb2pjXcgVk0oWgL1p591E8E3wmdC3Z+X6hr+ZUUC2
         UL0wSe/Ma8PyXq85RE258GpqkK9StG+0QySiU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=eT6xoiIbGSpW5sVODDQ7FAx9YIc0Vgk//tj9VJPO53GeGOpl6dodDq2u1FZNg5L6tf
         VWMSVYJi+Ekzjr9FTO66FaiV6rzfZAFh8EurgLYVIv2m5SGSHl0a7RnJ/2RX5GJf3Zqe
         Lxf3RBGUYhZUPEss1M+RFyZXRu4kTZJRvVhfQ=
Received: by 10.231.34.12 with SMTP id j12mr1655343ibd.0.1250299692363; Fri, 
	14 Aug 2009 18:28:12 -0700 (PDT)
In-Reply-To: <1250264521299-3445796.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125972>

Hi,

On Fri, Aug 14, 2009 at 11:42 PM, willievu<willievu@dev.java.net> wrote=
:
> Is MKCOL expected even for existing directory in the remote repositor=
y? =A0Is
> this a WebDAV server problem that 500 is returned?

Yes, you should expect MKCOLs to be done on directories that already
exist. On my Apache server with WebDAV, when a MKCOL is done on a
directory that already exists, it returns 405. Reading the WebDAV
specs (http://www.webdav.org/specs/rfc4918.html#rfc.section.9.3.1):

  405 (Method Not Allowed) - MKCOL can only be executed on an unmapped =
URL.

So this behaviour is accounted for in the spec itself, and git handles =
this too.

What I think is that your server isn't implementing WebDAV right, or
that you have some scripts/mods over the git repository you're serving
that are failing leading to the 500 error.

--=20
Cheers,
Ray Chuan
