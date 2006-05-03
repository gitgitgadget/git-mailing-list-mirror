From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Problem using GIT CVS-server
Date: Wed, 3 May 2006 22:11:58 +1200
Message-ID: <46a038f90605030311s4e05de2dr90277f97a3a5c223@mail.gmail.com>
References: <445865A5.5030700@lumumba.uhasselt.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 03 12:12:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FbEL1-0001mC-2l
	for gcvg-git@gmane.org; Wed, 03 May 2006 12:12:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965140AbWECKL7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 May 2006 06:11:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965141AbWECKL7
	(ORCPT <rfc822;git-outgoing>); Wed, 3 May 2006 06:11:59 -0400
Received: from wr-out-0506.google.com ([64.233.184.231]:31021 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S965140AbWECKL6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 May 2006 06:11:58 -0400
Received: by wr-out-0506.google.com with SMTP id 67so102289wri
        for <git@vger.kernel.org>; Wed, 03 May 2006 03:11:58 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Y54t3MhTWhrBb3nsMYW3TSxOdRi0031Dz+GT+rbF1NuNu4Oz8gN13/iACOLhKRZOfYpaUPduZPNGMI9XpAR5Rm9lY52MmeazGX8tkeFqkvioQ49+EbRTA3N1JW8xLAVbTlI8hBT6YxHet58WGR5ciKLIu59tAmUbRAj/Y0KK9mA=
Received: by 10.54.121.18 with SMTP id t18mr1729731wrc;
        Wed, 03 May 2006 03:11:58 -0700 (PDT)
Received: by 10.54.127.4 with HTTP; Wed, 3 May 2006 03:11:58 -0700 (PDT)
To: "Panagiotis Issaris" <takis@lumumba.uhasselt.be>
In-Reply-To: <445865A5.5030700@lumumba.uhasselt.be>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19467>

On 5/3/06, Panagiotis Issaris <takis@lumumba.uhasselt.be> wrote:

> I've tried using git-cvsserver, but keep running into problems:

Panagiotis,

thanks a lot for the feedback! cvsserver has mainly been
tried/debugged with a few repositories, mainly the moodle.git
repository that we host, which is an import from a CVS repo.

> When doing a checkout, it only checks out a small subset of
> the total amount of files in the repository and reports a warning/error.

Hmmm. 100% reproduceable -- looking at it now.

> When doing a subsequent update, it doesn't seem to do anything,
> but reports two error messages/warnings.
...

> closing dbh with active statement handles

I thought we had gotten rid of those. In any case, I don't see that
error, and it's just a silly warning from DBI, as we are using cached
statements. As it happens when cvsserver is shutting down, it doesn't
actually break the protocol.

> server doesn't support gzip-file-contents

That warning is harmless, and always there. I did look once at
implementing gzip compression, but in some cases it implies creating
extra temp files to calculate the size, so I've opted to leave it for
some other day.

OTOH, we could declare that we handle it, and never actually send a
gzipped file ;-) as long as we can handle gzipped content from the
client.

cheers,


martin
