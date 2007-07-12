From: "Ryan Moszynski" <ryan.m.public@gmail.com>
Subject: git .pack expansion question
Date: Thu, 12 Jul 2007 15:03:01 -0400
Message-ID: <5ed683f50707121203q52084b72o106616f1c8710141@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 12 21:03:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I93wq-0002UF-QW
	for gcvg-git@gmane.org; Thu, 12 Jul 2007 21:03:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756140AbXGLTDF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jul 2007 15:03:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756080AbXGLTDE
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jul 2007 15:03:04 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:6873 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761422AbXGLTDD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2007 15:03:03 -0400
Received: by py-out-1112.google.com with SMTP id d32so466150pye
        for <git@vger.kernel.org>; Thu, 12 Jul 2007 12:03:01 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=jZ1m7mk9BaXi34bOOd0jJigzHumlJvOOe8H5ra2BZhGe5+F7qV9eJWLgUIht6JgIDCiSbqb52FBkx068vSK9l3hq3Hd/qRA9pjvMnk7Tps0KuOZFCeIz5SpR2hqzobf/Yw0hNUkjCb0J9jq2eIxUjpNthg4xNOOCZARDbQVlEY8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=ls6KZRQnT3UAssN+23HeHucZjUXaPTezlWZtf8OLu9UxWP2DMxvCgo1CuRDtzf9UvqfPInISRR64llUNGzom9I/8ib76zucsjVLm9oIr88XhGw/kEAcXHkFZn9o+vIQLrXShmUEP4W0ZjbG5YhfZ69JTW+rigBQs39QjiwPiiug=
Received: by 10.35.62.19 with SMTP id p19mr1600950pyk.1184266981743;
        Thu, 12 Jul 2007 12:03:01 -0700 (PDT)
Received: by 10.65.232.10 with HTTP; Thu, 12 Jul 2007 12:03:01 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52322>

hopefully this is the right list for this:

am i understanding this right?

if i run the command:
git-repack
this creates an .idx and a .pack file that together hold all the files
and other metadata for my git directory.  What i can't figure out
though, is how to send just these two files to another machine over
the network, and then using only these two files, have git create a
replica of the original git directory that the .pack file was made
from.  I've tried

mkdir git-test
cd git-test
cp pack-92fadfab20e56acbbf28ed45851d61dc0d35c6ab.idx && .pack ./
git-init-db
git add .
git-unpack-objects < pack-92fadfab20e56acbbf28ed45851d61dc0d35c6ab.pack


now, the objects that were created from my original files are in the
objects directory, but I need them expanded so my git directory is a
copy of the one i originally git-repack'ed.  Is there an easy way to
do this?  This is for back up and archival purposes.

here are three ways i know to do this already, none of which I like very much.

cloning a repository over a network,
drawback: git has to be installed on both machines
or
scp'ing my whole git directory over the network,
drawback: too many little files, scp is too slow
or
tar'ing up my git directory so i can send one file for everything,
drawback: since git already has a compression/expansion tool built in,
i shouldn't have to use another to be able to do what i need.

any comments appreciated,

ryan
