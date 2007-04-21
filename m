From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Why SHA are 40 bytes? (aka looking for flames)
Date: Sat, 21 Apr 2007 11:37:36 -0400
Message-ID: <9e4733910704210837y3ac3654ekb60654ef6fc397fc@mail.gmail.com>
References: <e5bfff550704210635r4008c3c6tf5f55f970bf85e44@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Nicolas Pitre" <nico@cam.org>
To: "Marco Costalba" <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 21 17:37:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HfHej-0005Vv-Uu
	for gcvg-git@gmane.org; Sat, 21 Apr 2007 17:37:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751122AbXDUPhn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Apr 2007 11:37:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750968AbXDUPhn
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Apr 2007 11:37:43 -0400
Received: from an-out-0708.google.com ([209.85.132.243]:23617 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750782AbXDUPhm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Apr 2007 11:37:42 -0400
Received: by an-out-0708.google.com with SMTP id b33so1292646ana
        for <git@vger.kernel.org>; Sat, 21 Apr 2007 08:37:41 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GNqHI0TknXO9N+fT+JPRBgUyYnt7Zf6zTWv4YjoCRsEVaj+b77rqlSw3HpDSuEl6JlXrthHDXUwKFG3n2exPLyYSopYA06YCKmpuKwmI9p5kS8kShbwPTnnpF+ps6xYJZ8HhCGKv14DE6h3bGYntOcCdqnla3hXELE/FOYz3FbE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XljJ8WmTe1NibdUeHbU1C4vV6FI7fXducVVqFTTsnp2tEU/sKtDZ2K9/kiERIuiEKI9JZR0dwOuABv4z6CsZH8D0nnT/kCl9Rw8OKB2ZOVQKgtLf5edYGPQaHSJZyQH/TmRJ6j7ZpQerpc22p+n8uBt4M+XMLWTKoUb0Ei+qpqk=
Received: by 10.114.198.1 with SMTP id v1mr1736879waf.1177169861529;
        Sat, 21 Apr 2007 08:37:41 -0700 (PDT)
Received: by 10.114.194.9 with HTTP; Sat, 21 Apr 2007 08:37:36 -0700 (PDT)
In-Reply-To: <e5bfff550704210635r4008c3c6tf5f55f970bf85e44@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45176>

On 4/21/07, Marco Costalba <mcostalba@gmail.com> wrote:
> Well, why to store always the full length SHA?

When Shawn gets done with full compression the SHAs would get stored
in the packfile once  and then be replaced with a token generated from
the compression algorithm. Compression tokens are designed to use the
minimal number of bits depending on frequency of occurrence.

This doesn't happen with the current compression code since it doesn't
have a global dictionary.

There are many other things that would benefit from a global
dictionary. For example when working on the Mozilla repository the
Mozilla license has gone through four major revisions. Each of these
licenses is in the repository thousands of times. Making a copy of
each license to a global dictionary and then replacing them with a
token would yield megabytes of savings in the pack.

I would think that it is better to wait for a general compression
solution rather than do a specific one for SHAs.

-- 
Jon Smirl
jonsmirl@gmail.com
