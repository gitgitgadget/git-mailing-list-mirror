From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 5/7] remote-helpers: add support for an export command
Date: Mon, 29 Mar 2010 11:28:10 -0600
Message-ID: <fabb9a1e1003291028x45f0c570v4c10eadf37fc6a77@mail.gmail.com>
References: <1269881309-19690-1-git-send-email-srabbelier@gmail.com> 
	<1269881309-19690-6-git-send-email-srabbelier@gmail.com> <alpine.LNX.2.00.1003291256020.14365@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Mar 29 19:28:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwIlT-0004bK-9Z
	for gcvg-git-2@lo.gmane.org; Mon, 29 Mar 2010 19:28:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753381Ab0C2R2e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Mar 2010 13:28:34 -0400
Received: from mail-bw0-f209.google.com ([209.85.218.209]:33483 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753049Ab0C2R2d (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Mar 2010 13:28:33 -0400
Received: by bwz1 with SMTP id 1so3754718bwz.21
        for <git@vger.kernel.org>; Mon, 29 Mar 2010 10:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type;
        bh=ycI9xqVwBnTEYLMswWbumCChV3+B1ao/FAiGAQsTimI=;
        b=BrOLEAwwNGWC7BCOGvZWAmz6pW30dYrquv4bulARYFjhACplKjHDJAx+hygG162tWb
         DgmNifxmJwGsel281djqI84QnIUsgHUXeuwL6QBTjOQw7CTEIxRbFMQvnfKMNH1mSQos
         DSCUlaucB4VSdVkfoR8uwJPZ6Ho82ghDaOVJY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=agLXSb8IfYULn7MH7eAnc1aSPI6Fx5ny7YXM1Eo9TGSm0pdzX7dSV2Xebzrv1bczhz
         sevu+3TnwKXDJB0CBKpC11aAcw/2oDTEC0e6l0J+AKdyMgl1CSuv1T9rhg4YTgX2RQ+s
         BR+NmJ4IAL0ykmMAFvU+8aDtLpAPw3l5hMRIo=
Received: by 10.204.142.7 with HTTP; Mon, 29 Mar 2010 10:28:10 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.1003291256020.14365@iabervon.org>
Received: by 10.204.18.76 with SMTP id v12mr7389705bka.106.1269883710156; Mon, 
	29 Mar 2010 10:28:30 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143503>

Heya,

On Mon, Mar 29, 2010 at 11:21, Daniel Barkalow <barkalow@iabervon.org> wrote:
> It would be good to have documentation on what the helper should do doing
> here; it's relatively difficult to tell from this code.

Yes, I plan to send a documentation patch as well but wanted to get
this out the door first (since Documentation patches don't have to
cook in next).

> I think that it's getting some options (import and export marks) back from
> the helper in a kind of ad-hoc and unclear fashion, and it should be doing
> something more appropriate.

It's not really that ad-hoc or unclear. When the helper receives the
export command it should write two lines, the first being the location
where it should write the marks to, the second being the location
where it should import marks from. Either line may be empty, meaning
marks should not be written or read respectively.

> (I'm not sure what the more appropriate thing
> is, or really what the requirements are here as far as getting information
> around, but I think it needs to be discussed.)

The import command solves this by printing 'feature import-marks' and
'feature export-marks' lines on the stream, but that doesn't work here
since fast-export doesn't read from stdin. I don't think this needs a
separate command.

-- 
Cheers,

Sverre Rabbelier
