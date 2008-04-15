From: Shawn Bohrer <shawn.bohrer@gmail.com>
Subject: Re: [PATCH] git clean: Don't automatically remove directories when
	run within subdirectory
Date: Mon, 14 Apr 2008 22:44:17 -0500
Message-ID: <20080415034417.GA2882@lintop>
References: <85fxtvj6y8.fsf_-_@lupus.strangled.net> <1208130578-24748-1-git-send-email-shawn.bohrer@gmail.com> <7v8wzgaoqy.fsf@gitster.siamese.dyndns.org> <20080414170643.GA10548@mediacenter> <48039FE5.5060309@broadpark.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Joachim Berdal Haga <cjbhaga@broadpark.no>
X-From: git-owner@vger.kernel.org Tue Apr 15 05:45:14 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jlc6Z-0001gZ-Kz
	for gcvg-git-2@gmane.org; Tue, 15 Apr 2008 05:45:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762409AbYDODo1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Apr 2008 23:44:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762337AbYDODo1
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Apr 2008 23:44:27 -0400
Received: from an-out-0708.google.com ([209.85.132.251]:3704 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762237AbYDODo0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Apr 2008 23:44:26 -0400
Received: by an-out-0708.google.com with SMTP id d31so490946and.103
        for <git@vger.kernel.org>; Mon, 14 Apr 2008 20:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        bh=YvI5XN7nI8GND9Ipu9bqobj3dYTdetn5wAsL93u2/eE=;
        b=A3UX0l03ZC/PqO8Evuf9/f3cYzj7uCaGUxEGf3PkvXmV0mhzsddruLCILipQ4LfLNb74L8JNpq+LVjCcNVWDnTHUKOnaLdWNGUT7ngMaeK405xBGSMgg1bMNWgbSFtq7Z7VRPWLuX7I4iiT5FTv4hR6iJ1uyxvNCU6kHO7g5U2k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=SG9NGRf1QZUzC20PHcwXwPbxSP0PB+Wz2jYzeczLSDJdYHhQQLcUqOUIMcgjoZnTdxUAesGxlkVbOL5jXEdyoSpaATXYjwPseIs/us+zkvKydFK50Dv7dVdg66//KQ7slHE7QpYqrx3N7Htq92VyS8GC3FVaEs0+62XOvvLss0U=
Received: by 10.100.252.17 with SMTP id z17mr13896301anh.6.1208231065317;
        Mon, 14 Apr 2008 20:44:25 -0700 (PDT)
Received: from @ ( [70.112.149.232])
        by mx.google.com with ESMTPS id a30sm629655rnb.12.2008.04.14.20.44.23
        (version=SSLv3 cipher=OTHER);
        Mon, 14 Apr 2008 20:44:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <48039FE5.5060309@broadpark.no>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79564>

On Mon, Apr 14, 2008 at 08:18:13PM +0200, Joachim Berdal Haga wrote:
> I think that the best option would be to never remove a directory, even if
> given explicitly, unless -d is given. Because my gut feeling is that when a
> directory name is specified, it is most often meant as "clean inside the
> given directory", ie. as a path delimiter. Indeed, if the directory has
> tracked files inside of it,
>   git clean dir
> and
>   git clean dir/
> have the same effect. If there are no tracked files inside, the current
> patch gives the path-delimiting effect on this form
>   git clean dir/
> but removes the whole directory irrespective of "-d" for this form
>   git clean dir
> I think that a "honor (lack of) -d even if pathspec matches" would reduce
> the consequences of this particular kind of user error (by deleting too
> little instead of too much).

If there are no tracked files the only difference between the dir/ and
dir case is that the former will leave behind an empty directory.  So
the difference between too much and too little is of little
importance.  However,

git clean dir
Would not remove dir/

is a little strange.

--
Shawn
