From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: Teach git-update-index about gitlinks
Date: Fri, 13 Apr 2007 10:14:24 +0200
Message-ID: <81b0412b0704130114u2a7217cep6cd77b902e92bbd8@mail.gmail.com>
References: <Pine.LNX.4.64.0704121218130.4061@woody.linux-foundation.org>
	 <81b0412b0704130042k1f5be3bay30cbbb6b70259f6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Apr 13 10:14:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HcGvp-0003WL-ON
	for gcvg-git@gmane.org; Fri, 13 Apr 2007 10:14:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752875AbXDMIO2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Apr 2007 04:14:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752403AbXDMIO2
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Apr 2007 04:14:28 -0400
Received: from an-out-0708.google.com ([209.85.132.250]:57866 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752670AbXDMIO0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Apr 2007 04:14:26 -0400
Received: by an-out-0708.google.com with SMTP id b33so837567ana
        for <git@vger.kernel.org>; Fri, 13 Apr 2007 01:14:25 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QE493lgZAvAuF+d8fHU53yRexzSPY/kVxitVTPOscIZqGxN3SdNtyqyoSN8PEmeoSw5WhOo8wW0WJiEAzmzwroczOW8ebiWQ5oV9T8dS7sq8Du06PBaMyXdAnU4U98V1XKz1PGbS27KG9fwxqOBCiV3NhcMvykBdOSqJ6oAkEPQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MJXOnNPQj9ddOZyeQB4ade8XjrZfAevIPqf3/254CRZxtuA/SeiDUQIPM0rU1fZwt1xOseOT5GQjBXe/OMvMJP+C/4ggtgWF7tC1cUlazYPLzYL9mNQZeYOZb/FdAANtkW4lGDpF7JnE58M9U42xfBIIIwifMstV68EbHfAVXD4=
Received: by 10.100.133.9 with SMTP id g9mr2274933and.1176452065441;
        Fri, 13 Apr 2007 01:14:25 -0700 (PDT)
Received: by 10.100.86.14 with HTTP; Fri, 13 Apr 2007 01:14:24 -0700 (PDT)
In-Reply-To: <81b0412b0704130042k1f5be3bay30cbbb6b70259f6@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44394>

On 4/13/07, Alex Riesen <raa.lkml@gmail.com> wrote:
> > + *    (NOTE! This is old and arguably fairly strange behaviour.
> > + *    We might want to make this an error unconditionally, and
> > + *    use "--force-remove" if you actually want to force removal).
> ...
> > +               /* Should this be an unconditional error? */
> > +               return remove_one_path(path);
>
> Makes me uncomfortable too. Is it be possible anyone is depending
> on it? Maybe it still can be changed?
>

Maybe not. It actually makes sense: the old file (now a directory)
is actually removed, so a plain --remove in its old meaning still
_is_ correct: remove the file from index if it is removed from
working directory.
And it breaks t1001.
