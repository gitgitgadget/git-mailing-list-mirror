From: neubyr <neubyr@gmail.com>
Subject: git repository size / compression
Date: Thu, 8 Sep 2011 21:37:42 -0500
Message-ID: <CALFxCvzVjC+u=RDkDCQp0QqPETsv8ROE8tY=37tmMWxmQoJOEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 09 04:37:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1qyU-0008CC-4f
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 04:37:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932658Ab1IIChp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Sep 2011 22:37:45 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:41224 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757691Ab1IICho (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Sep 2011 22:37:44 -0400
Received: by wwf5 with SMTP id 5so604788wwf.1
        for <git@vger.kernel.org>; Thu, 08 Sep 2011 19:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=vJFVSAdrOZL0tPYHnIUVyStJ3bkhkG8OrTv0xcgBi4Y=;
        b=egNLAmUVcxZwiPhK/3AT3g91JizzfBNcv4iWx6Hwn0oeGGM6DnmXDWK2uWIF/j00Dz
         LztruaptGWhbYIvSSdfDKk7GJTAdWetcXBKPDr0OSR2cYetmE3qJthDLjd+oiFbrBoYJ
         limBRTtu2oQTJHr0lsiB/nhUnCHOyx7Wh9DlA=
Received: by 10.227.202.70 with SMTP id fd6mr1447458wbb.114.1315535862788;
 Thu, 08 Sep 2011 19:37:42 -0700 (PDT)
Received: by 10.227.145.210 with HTTP; Thu, 8 Sep 2011 19:37:42 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181025>

I have a test git repository with just two files in it. One of the
file in it has a set of two lines that is repeated n times.
e.g.:
{{{
$ for i in {1..5}; do cat ./lexico.txt >> lexico1.txt &&  cat
./lexico.txt >> lexico1.txt && mv ./lexico1.txt ./lexico.txt;  done
}}}

I ran above command few times and performed commit after each run. Now
disk usage of this repository directory is mentioned below. The 419M
is working directory size and 2.7M is git repository/database size.

{{{
$ du -h -d 1 .
2.7M    ./.git
419M    .

}}}

Is it because of the compression performed by git before storing data
(or before sending commit)??

Following were results with subversion:

Subversion client (redundant(?) copy exists in .svn/text-base/
directory, hence double size in client):
{{{
$ du -h -d 1
416M    ./.svn
832M    .
}}}

Subversion repo/server:
{{{
$ du -h -d 1
 12K    ./conf
1.2M    ./db
 36K    ./hooks
8.0K    ./locks
1.2M    .
}}}

--
neuby.r
