From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Carrying over attributes when moving files
Date: Tue, 30 Mar 2010 16:30:49 -0500
Message-ID: <20100330213049.GB11192@progeny.tock>
References: <m3iq8jn3ar.fsf@winooski.ccs.neu.edu>
 <20100328014208.GA23015@progeny.tock>
 <19376.50971.397375.810974@winooski.ccs.neu.edu>
 <19376.53419.640007.930897@winooski.ccs.neu.edu>
 <20100329231501.GA28194@progeny.tock>
 <19377.33747.838003.360864@winooski.ccs.neu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Eli Barzilay <eli@barzilay.org>
X-From: git-owner@vger.kernel.org Tue Mar 30 23:30:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nwj1H-0007sg-0N
	for gcvg-git-2@lo.gmane.org; Tue, 30 Mar 2010 23:30:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752241Ab0C3Vah convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 30 Mar 2010 17:30:37 -0400
Received: from mail-pz0-f186.google.com ([209.85.222.186]:47508 "EHLO
	mail-pz0-f186.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751813Ab0C3Vah (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Mar 2010 17:30:37 -0400
Received: by pzk16 with SMTP id 16so26361pzk.22
        for <git@vger.kernel.org>; Tue, 30 Mar 2010 14:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=C8Asa3QeSviIy6tStI2VseyjKSD4b2PTtwPKxsTgwXo=;
        b=LaKVQt3xnKkxrPvfQX4YFTmVWfifAVugAZINMYnJ3e2j7Nqf2wC6VYOrPfdMXkFXNO
         5dEVmxcYBNte6zYKev7GSJhgdfbdc+gns+S0AaWsh145ucFfHowqXi3U8IksZ47+z73x
         YtLEixm+qhSGRAqcKWXyXVwv7cH1PpUKFlx7M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=KHGZfI++uhvb9lyBPuxY/rh85vYQRx8PMduOL8pSwczQLOgc/zVz+UkPUfdB321gWH
         jim2ffccEDvrY5FXgt2LPWipdEUREVsoVSW63xJo6lTt+JdTBd+XFk3PBZSf7qrVLSwS
         /7YP0MJ83nbscP53YLxQpguoXILxHaZ0t0HKc=
Received: by 10.142.119.1 with SMTP id r1mr3052041wfc.80.1269984634535;
        Tue, 30 Mar 2010 14:30:34 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id s21sm1213549wff.0.2010.03.30.14.30.32
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 30 Mar 2010 14:30:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <19377.33747.838003.360864@winooski.ccs.neu.edu>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143605>

Eli Barzilay wrote:

> There are a number of technicalities that make git attributes a poor
> substitute for svn properties -- mainly
[...]
> and
> the fact that they're not tracked with the files (as in svn, where
> moving a file somewhere will move its properties with it).

It would be great to improve this.

Consider the following directory hierarchy.

	old-files/
		.gitattributes
		some-file.html
		other-file.html
	new-files/
		unrelated-file.html

=2Egitattributes specifies that old HTML files use a CRLF line ending.

	*.html crlf

What would you expect the following commands to do?

	git mv old-files/some-file.html new-files/
	git commit

How about these?

	mv old-files/some-file.html new-files/
	git add new-files/some-file.html
	git commit -a

I don=E2=80=99t think there=E2=80=99s any fundamental reason this hasn=E2=
=80=99t been taken
care of; it=E2=80=99s just that nobody has done it yet.

Thoughts welcome.
Jonathan
