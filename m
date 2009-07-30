From: "John te Bokkel / Tempus" <tanj.tanj@gmail.com>
Subject: remote url format in config
Date: Wed, 29 Jul 2009 20:52:19 -0400
Message-ID: <47ade73f0907291752k62c66903lc2617a16ec0973bd@mail.gmail.com>
References: <47ade73f0907291750v281f3858qd3658c459dd950e8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 30 02:59:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWJzS-000181-8g
	for gcvg-git-2@gmane.org; Thu, 30 Jul 2009 02:59:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755982AbZG3A7S convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Jul 2009 20:59:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754901AbZG3A7S
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jul 2009 20:59:18 -0400
Received: from qw-out-2122.google.com ([74.125.92.24]:51166 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754875AbZG3A7S convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Jul 2009 20:59:18 -0400
Received: by qw-out-2122.google.com with SMTP id 8so651794qwh.37
        for <git@vger.kernel.org>; Wed, 29 Jul 2009 17:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=Xpefqvc9ItrPrWenLvNSLquKSIyFFcIm1+Mq2KV9is0=;
        b=L07cIQGcwRf4WPyo1JP31cAcLEiPKhlZMNxi6sKJ9hGsm8QWfDO5cBA0pIpQ7A0lF2
         rAyvsfLrIAWVr05pJXLdzkBX6FfBX3iMFmZgsLflqX37hFN6dDp/i/JjwQnP9H4MyPn2
         n54l+j3wDDWW24wZXDRzy6P0CailTWqZRqBhg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=cnd2fOfloE9HKtyQ8rAHqLCYGZ3Ui9QEMloBsTZPRkpWm8aehvGo91/n8oSYKAH3PM
         sQ39EVM7PI2HNlmbHVcwP+WMtDRJ+zNvSfeZHA6CIbLtsvOrDpsoaayEWWKfkMrPPnnW
         moAOCkujqHaWEfZgdhlIHsvzwKGafru0qQzuY=
Received: by 10.220.93.67 with SMTP id u3mr715328vcm.27.1248915139132; Wed, 29 
	Jul 2009 17:52:19 -0700 (PDT)
In-Reply-To: <47ade73f0907291750v281f3858qd3658c459dd950e8@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124429>

There is a bug in the way the url is stored for remote urls. It is
really a minor problem and easily worked around. However it may a good
idea for the future to url encode that string.

What happened:

added a remote with two consecutive spaces in the url.

git remote add local_remote /dir/folder with\ \ -\ \ two consecutive\
\ spaces/project.git

git push local_remote master

error: url with only single spaces is not a git repo

the .git/config url is written correctly however it gets munged when
it is read from the config.

=A0url =3D /dir/folder with =A0- =A0two consecutive =A0spaces/project.g=
it

to make it work correctly, just quote it.

=A0url =3D "/dir/folder with =A0- =A0two consecutive =A0spaces/project.=
git"

perhaps it would be a good idea to url encode the url when it is first
written to the config file.

=A0url =3D /dir/folder%20with%20%20-%20%20two%20consecutive%20%20spaces=
/project.git
