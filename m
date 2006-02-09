From: Alan Chandler <alan@chandlerfamily.org.uk>
Subject: Re: gitweb: View graphes & get tar
Date: Thu, 9 Feb 2006 00:03:35 +0000
Message-ID: <200602090003.35354.alan@chandlerfamily.org.uk>
References: <4fb292fa0602081534x7f6e74c1veb8c4ea7ad5a83cc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Feb 09 01:03:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F6zHe-00026q-Av
	for gcvg-git@gmane.org; Thu, 09 Feb 2006 01:03:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422677AbWBIADg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Feb 2006 19:03:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422678AbWBIADf
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Feb 2006 19:03:35 -0500
Received: from 82-44-22-127.cable.ubr06.croy.blueyonder.co.uk ([82.44.22.127]:56028
	"EHLO home.chandlerfamily.org.uk") by vger.kernel.org with ESMTP
	id S1422677AbWBIADf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Feb 2006 19:03:35 -0500
Received: from kanger.home ([192.168.0.21])
	by home.chandlerfamily.org.uk with esmtp (Exim 4.50)
	id 1F6zHa-0004Ko-Eo
	for git@vger.kernel.org; Thu, 09 Feb 2006 00:03:34 +0000
To: git@vger.kernel.org
User-Agent: KMail/1.9.1
In-Reply-To: <4fb292fa0602081534x7f6e74c1veb8c4ea7ad5a83cc@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15770>

On Wednesday 08 February 2006 23:34, Bertrand Jacquin wrote:
> Hi,
>
> Is gitweb maintainer planned to allow people to get from gitweb ? It
> could be something good for ungited/remote people to get a tar for a
> specific tree.
> gd provide to create graphs and is often use in "web project" to
> generate graphe. Could it here generated a graph of branches like in
> gitk ?
> It also could be cool to allow people to get binary files in an other
> mimetype that text/plain.
>
> Here are my wish :D it's worth what it's worth.

You can do some of that a different way.

I have it set up so that when I push a tag into my public git repositories, 
that a post-update hook creates a tarball of the site and puts it into the 
download directory.

The hook is of the following form

#!/bin/sh
#
# This script is used to create a tarball of the project and place it into the 
"files"
# directory of the web site whenever a release is tagged in the repository
#
PROJECT=akcmoney
# this should look at each positional parameter
for ref ; do
#if its a tag then create a tarball
        if [ "${ref:0:10}" == "refs/tags/" ] ; then
                git-tar-tree ${ref:10} $PROJECT | gzip -9 
> /var/www/chandlerfamily/files/$PROJECT/$PROJECT-${ref:10}.tar.gz
        fi
done


-- 
Alan Chandler
http://www.chandlerfamily.org.uk
Open Source. It's the difference between trust and antitrust.
