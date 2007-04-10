From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH 4/5] merge-recursive: handle D/F conflict case more carefully.
Date: Tue, 10 Apr 2007 10:40:51 +0200
Message-ID: <81b0412b0704100140g7684e128g75c986c213ac9d0f@mail.gmail.com>
References: <7v6488ckk0.fsf@assigned-by-dhcp.cox.net>
	 <20070409185809.GA13212@steel.home>
	 <7vk5wlz5mg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Daniel Barkalow" <barkalow@iabervon.org>,
	"Johannes Schindelin" <johannes.schindelin@gmx.de>
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Apr 10 13:09:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbBuN-00005f-4U
	for gcvg-git@gmane.org; Tue, 10 Apr 2007 10:40:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966109AbXDJIky (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Apr 2007 04:40:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966115AbXDJIkx
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Apr 2007 04:40:53 -0400
Received: from an-out-0708.google.com ([209.85.132.250]:36210 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966109AbXDJIkw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2007 04:40:52 -0400
Received: by an-out-0708.google.com with SMTP id b33so1870805ana
        for <git@vger.kernel.org>; Tue, 10 Apr 2007 01:40:52 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=eXsjkdFNmnhiT2rdgBRYq1YTf/zVW5EgQPjT4BiskB5W3CVJgUm50X/po6dzjnhZIYNNhmUxzLbs1GYCTDaiIE1yk1BtQ6GKmRHBr+oWliOM72CfKJXUOJksQnU42b1Wij9Hfk+iSGETDeetKLsgWSMBx4NYXn+o5j1Tcim5BTA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kjfSqU5wNIMduMKBXbzDVIIqj7IsDn0S6Elnind4Ng+LgezcMRoPj+OOTbQjNAxFaWMdsl/Q1ho0ifbzohkCmnr1st2g3H1NHuZjT6AR+EBVI9eupD5EQMqE2ZFaQzx3sykJFEIYrj2R23OX80jd+/SZmL4z0dQicdsvNRk4rCk=
Received: by 10.100.112.19 with SMTP id k19mr4682996anc.1176194451915;
        Tue, 10 Apr 2007 01:40:51 -0700 (PDT)
Received: by 10.100.86.14 with HTTP; Tue, 10 Apr 2007 01:40:51 -0700 (PDT)
In-Reply-To: <7vk5wlz5mg.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44119>

On 4/9/07, Junio C Hamano <junkio@cox.net> wrote:
> Alex Riesen <raa.lkml@gmail.com> writes:
>
> > Junio C Hamano, Sat, Apr 07, 2007 16:42:55 +0200:
> >> +                    if (unlink(path)) {
> >> +                            if (errno == EISDIR) {
> >> +                                    /* something else exists */
> >> +                                    error(msg, path, ": perhaps a D/F conflict?");
> >
> > isn't this one an F/D conflict?
>
> Yes, as I said in a separate message, the current D/F detector
> code in merge-recursive does not catch this case in t3030 test
> and comes to this codepath to write it out:
>

I mean, maybe the error could be spelled differently:
": perhaps an F/D conflict?"
Right now we have two exactly the same errors,
as seen on the output. The messages refer to different
conflicts, though. It is usually useful to know what is really
going on.
