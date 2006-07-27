From: "=?ISO-8859-1?Q?Andr=E9_Goddard_Rosa?=" <andre.goddard@gmail.com>
Subject: Git clone stalls at a read(3, ...) saw using strace
Date: Thu, 27 Jul 2006 08:16:58 -0400
Message-ID: <b8bf37780607270516i7fbd8844he03e107b15fd2ed7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: junkio@cox.net
X-From: git-owner@vger.kernel.org Thu Jul 27 14:17:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G64nY-0007Lr-0m
	for gcvg-git@gmane.org; Thu, 27 Jul 2006 14:17:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751169AbWG0MRA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 27 Jul 2006 08:17:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751242AbWG0MRA
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Jul 2006 08:17:00 -0400
Received: from py-out-1112.google.com ([64.233.166.176]:20717 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751169AbWG0MQ7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Jul 2006 08:16:59 -0400
Received: by py-out-1112.google.com with SMTP id s49so234209pyc
        for <git@vger.kernel.org>; Thu, 27 Jul 2006 05:16:58 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=ClI0/5mvYF5G2qdn+Npx7JGumF46vHKlii7NGXRRkC4akVb/FnSgU4+gdh032lwTnqiG/fHHyA/otUsxUdNLXJdLKO+7BjxVbin0HbWCLj94EztxOwClIRYEcLx/UI3IbJLYeEYRdPchBCAuvLFwtcSd8n3DJK1cHNHsRHaXM08=
Received: by 10.35.107.20 with SMTP id j20mr13049191pym;
        Thu, 27 Jul 2006 05:16:58 -0700 (PDT)
Received: by 10.35.128.2 with HTTP; Thu, 27 Jul 2006 05:16:58 -0700 (PDT)
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24282>

Hi, all!

    Please CC me as I'm not subscribed.

    Using  GIT 1.4.1, I tried to get this repository:

# git clone git://source.mvista.com/git/linux-davinci-2.6.git

    After some time the download stalled completely. I used ps and
saw two git processes.

    Using strace, I saw that the first one, "git clone", was waiting
with waitpid()
for its child termination.
    Its child, "git pack --all -k", was stalled at a "read(3, ...)"

    I went to /proc and saw that fd 3 was a pipe. Anyone know why this
is happening?

    I found an issue somewhat related in google (not sure that is the
same problem):

http://groups.google.com/group/fa.linux.kernel/browse_thread/thread/e64=
a92f28def32a7/93bd8bf5df1fcc66?lnk=3Dst&q=3D&rnum=3D1#93bd8bf5df1fcc66

    It stalled at the first 60 Mb transfered. After CTRL+C it deletes
and I have to start again from scratch.

Thank you for the great alternative to bitkeeper and CVS,
--=20
[]s,
Andr=E9 Goddard
