From: "=?ISO-8859-1?Q?=D8yvind_Harboe?=" <oyvind.harboe@zylin.com>
Subject: Problems with large compressed binaries when converting from svn
Date: Tue, 6 Jan 2009 13:55:12 +0100
Message-ID: <c09652430901060455l5179888ep3c51ff4e3dd5a6ef@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 06 13:56:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKBU7-0001CZ-R9
	for gcvg-git-2@gmane.org; Tue, 06 Jan 2009 13:56:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751632AbZAFMzR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Jan 2009 07:55:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751599AbZAFMzQ
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jan 2009 07:55:16 -0500
Received: from mail-bw0-f21.google.com ([209.85.218.21]:50465 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751617AbZAFMzP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Jan 2009 07:55:15 -0500
Received: by bwz14 with SMTP id 14so23957237bwz.13
        for <git@vger.kernel.org>; Tue, 06 Jan 2009 04:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:mime-version:content-type:content-transfer-encoding
         :content-disposition:x-google-sender-auth;
        bh=eiZ0NxC7nr3Qu/r3kWrXMgZj7SPOXMZ9kyJXlqcwvCE=;
        b=UqPlahr12w1kTY8DHg0QsZWMHsjo3sI0q4J7byW3PQgMUZyDO9iy2+t9iibYHARpkI
         nJ5r7HEs0LOIpVrW5Bmlg5p/ya/JvFCAUrWEZ4HVPSgrNuMr15Sid+O52SkvhelnY8Cj
         23Zv6VsDYZ0IaeSR+lo3M4/iXGBkuD/AXm1xA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=c+cDIXE5jtFndJZ+TqxdXHhY9RgPhs2e0UniuHaUqMYReigfVhMmBkFgjijHiQn7BL
         p8FX/CwnpleQBIFuEXgodbSlBtKwsq5ohbCh9ll7zuEH/mqqfRR4BsVMZRqURPGjtRX5
         O7Clv7V+JUkHbw+Md6nxkyKrfo63G7Ew9REJ4=
Received: by 10.223.108.211 with SMTP id g19mr15422322fap.39.1231246512682;
        Tue, 06 Jan 2009 04:55:12 -0800 (PST)
Received: by 10.223.121.142 with HTTP; Tue, 6 Jan 2009 04:55:12 -0800 (PST)
Content-Disposition: inline
X-Google-Sender-Auth: 5d536efe5b7b6d84
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104684>

I'm converting from svn and I've run into a
problem with tar.gz and tar.bz2 compressed files.

(This is a separate but only slightly related to previous post).

In subversion we committed large tar.bz2/gz files. These files would
change relatively rarely, but only very slightly.  The trouble with the=
 tar.bz2
format is that if the first byte changes, then the rest of the file wil=
l also
be different. .zip does not have this problem, but .zip isn't a very fr=
iendly
format for our purposes.

Later on the tar.bz2/gz files started to change fairly often, but hardd=
rives
get bigger much more quickly than the .svn repository grows so we just
kept doing things the same way rather than reeducate and reengineer
the procedures.

With .git we need to handle this differently somehow.

Does git have some capability to store diffs of compressed files effici=
ently?

The only other alternative I can think of is to commit uncompressed
=2Etar files which is a bit of a bump in the road, but I suppose could =
be
made to work.



--=20
=D8yvind Harboe
http://www.zylin.com/zy1000.html
ARM7 ARM9 XScale Cortex
JTAG debugger and flash programmer
