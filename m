From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: short log and email address
Date: Mon, 28 Jul 2008 14:57:39 -0400
Message-ID: <9e4733910807281157u44c08a59ld3bdc0416e8a1d03@mail.gmail.com>
References: <9e4733910807281106y56f8b67ao86f78822c4b4ad58@mail.gmail.com>
	 <alpine.DEB.1.00.0807281928400.8986@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jul 28 20:58:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNXve-00055B-KK
	for gcvg-git-2@gmane.org; Mon, 28 Jul 2008 20:58:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755600AbYG1S5m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 14:57:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755388AbYG1S5m
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 14:57:42 -0400
Received: from qw-out-2122.google.com ([74.125.92.26]:8704 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755226AbYG1S5l (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 14:57:41 -0400
Received: by qw-out-2122.google.com with SMTP id 3so281784qwe.37
        for <git@vger.kernel.org>; Mon, 28 Jul 2008 11:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=Y1xu376hIfvhu4i6UFgtLoQWxJikPILpBvrYeeKui5w=;
        b=YHq6jShmvoNKJCxdU6r/XTVaPu6NFIH/YmQXMoTX/CVegt93Oz2qYTBBGRQJOfs1ME
         pmvdfh/q3fVAaBppylukoPLbzJTcuqufGxqq/yRV+YRBeASrreM9lAeRdQbwtuBhjTDR
         4HQhwTcJMr2Sio2V5EsfrJJ/5EU8EL0Ck9RD0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=u2dT+ir3DhshkeffF53G1QYSupmfH/QGqJpCaWj5l/iDsBFCO9gLt5cO9KK/C2xQNh
         C+b/Y9yVC0SkLGiUmwpEkshvKrTmThJMv+Va/5TDsIJvJvixnPwRlq0krBEH04TIcbR6
         /187eCdh3GYklSzw6E1ZFXaAMWSZ1AR1VFiM4=
Received: by 10.214.11.19 with SMTP id 19mr225853qak.43.1217271459746;
        Mon, 28 Jul 2008 11:57:39 -0700 (PDT)
Received: by 10.150.205.1 with HTTP; Mon, 28 Jul 2008 11:57:39 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0807281928400.8986@racer>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90486>

On 7/28/08, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
>
>  On Mon, 28 Jul 2008, Jon Smirl wrote:
>
>  > Using the -e option in shortlog changes the results by spitting things
>  > out by email address instead of leaving them combined by name. That's
>  > probably not what you want. Instead you want everything combined by name
>  > and then display the most recent email address used.
>
>
> What is so wrong with _not_ using -e (since you do not want to see the
>  email address stored in the commit message, and -e would be asking for
>  that _exactly_)?

I wanted -e to give me the most recent email so that I would know how
to sort the mailmap alias list.

>
>  After the fact, you can annotate the names with all you like.  For
>  example, the most recent email address for that person.
>
>  But as Mark pointed out, the name might be a bad key.  Maybe you will have
>  to do something completely different, namely maintain a separate list of
>  (correct) names and emails, and then having line numbers in .mailmap,
>  like:
>
>  1 <davem@sunset>
>  1 <davem@sunrise>
>  1 <davem@moonshine>
>  2 <dave.miller@miller.com>
>  2 <dave.miller@highnoon.miller.com>
>
>  etc
>
>  However, I have to say that I see small value in that, and an inordinate
>  amount of work that nobody wants to do.

We could order the aliases until the correct alias is the last one. An
initial proxy would be to use the most recent email address on the
person's commits.

The trick is automating the maintenance.  Modify checkpatch,pl to look
up the person's name up in the mailmap file and retrieve all matching
aliases.

If the name isn't in mailmap, tell them to make a patch adding their
name or to change their name.

If the name is there but the email is not the last one in the list,
tell them to make a patch rearranging mailmap to reflect their current
name/email.

If name is there and email is last on list, don't complain.



>
>  Ciao,
>  Dscho
>
>


-- 
Jon Smirl
jonsmirl@gmail.com
