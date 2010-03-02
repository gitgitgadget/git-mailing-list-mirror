From: Michael Witten <mfwitten@gmail.com>
Subject: Re: Better cooperation between checkouts and stashing
Date: Mon, 1 Mar 2010 19:41:50 -0600
Message-ID: <b4087cc51003011741w29023914wec78f9acd6efb516@mail.gmail.com>
References: <4B67227A.7030908@web.de> <7vhbq0wuy6.fsf@alter.siamese.dyndns.org> 
	<4B898F97.90706@web.de> <7vr5o6s5xf.fsf@alter.siamese.dyndns.org> 
	<4B8B9BF1.10408@web.de> <7v1vg4ufas.fsf@alter.siamese.dyndns.org> 
	<4b8c0420.5544f10a.2eb2.ffffb4c4@mx.google.com> <7vk4tvsu6x.fsf@alter.siamese.dyndns.org> 
	<4B8C2F90.8080104@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Markus Elfring <Markus.Elfring@web.de>
X-From: git-owner@vger.kernel.org Tue Mar 02 02:42:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NmH7p-0002J9-Tj
	for gcvg-git-2@lo.gmane.org; Tue, 02 Mar 2010 02:42:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752991Ab0CBBmM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Mar 2010 20:42:12 -0500
Received: from mail-ew0-f220.google.com ([209.85.219.220]:45568 "EHLO
	mail-ew0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752309Ab0CBBmL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Mar 2010 20:42:11 -0500
Received: by ewy20 with SMTP id 20so1683901ewy.21
        for <git@vger.kernel.org>; Mon, 01 Mar 2010 17:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=yy3yS/AaCec65av0qVt4i+obfW8rDzeYJLZVjVKOgho=;
        b=Ad8KHpbW2J6TP4cZCR/1iFwIpPgFkVyg8imDwBbk7ZV446SKANh7V7FP596iDvgiI9
         NyKThM7DwlCYEmBUJiykZmk8z0BQ7EYyzdbFNE1mu7/rC92YsdiGn1UKciRTe95dPQ9e
         wUhmrk+BiDQ5doBwVaN++rC7NPHVbnF2NIIN4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=ZuYccw5/tWaRjznC7ZGEUf2yCYbI7kSGzZrOlBnqAjQ1rrUahI7DtMcF3xAz//lYkX
         5ID734HU/aDfILrJnPmexXmwi/G4IIXObEVTK8HVuxBs4Cw/Mo/Prwskz+GZ1MDN1Y+5
         6yLByY+E/gbVbtGXE/3miVnSxyAvU1pjtBHx4=
Received: by 10.213.97.83 with SMTP id k19mr4079931ebn.22.1267494130165; Mon, 
	01 Mar 2010 17:42:10 -0800 (PST)
In-Reply-To: <4B8C2F90.8080104@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141372>

On Mon, Mar 1, 2010 at 15:20, Markus Elfring <Markus.Elfring@web.de> wrote:
>
> How is this use case different from the other?

The other use case is the one that git already assumes to be popular:
People want local modifications to remain in place across branch
checkouts.

> Which "problem" have you got in mind?

The "git checkout" command is designed to carry local modifications
across branches transparently; when it's not so clear that such
transparency is possible, "git checkout" refuses to continue unless
the "-m" flag is used to try a 3-way merge involving:

  * the local modifications.
  * the files in the branch being left.
  * the files in the branch being checked out.

This 3-way merge can get tricky if it ends in conflict, and so a smart
use of the stash in this process might help users untangle themselves.

That is what Junio has been thinking about in this thread.
