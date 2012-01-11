From: Steven Line <sline00@gmail.com>
Subject: Re: git svn clone terminating prematurely (I think)
Date: Wed, 11 Jan 2012 14:52:26 -0700
Message-ID: <CAJ1a7SoW0vNBR2gaBPCA5RqU7_LnQ5pMmgihZ_sKF09+Cj3Stg@mail.gmail.com>
References: <CAJ1a7SrkDOyNRv8Spo4xvoKjP4zaXteim4h3JGcWU-nYDugx9Q@mail.gmail.com>
	<CALkWK0nyc6NVE7Qpvbc0dXb1UHGM_=uYbCS+a53HZxiBRG9HvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 11 22:52:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rl65z-00011g-3q
	for gcvg-git-2@lo.gmane.org; Wed, 11 Jan 2012 22:52:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934074Ab2AKVw3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Jan 2012 16:52:29 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:34702 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933986Ab2AKVw2 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jan 2012 16:52:28 -0500
Received: by lago2 with SMTP id o2so548521lag.19
        for <git@vger.kernel.org>; Wed, 11 Jan 2012 13:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=tI/E1RWF+6rbLUZkNzvTo+KkmZ0Pb3u5ncp8amrzWTg=;
        b=Yxj4zbfoh1xcALcbFnmqvhvZ5NOq3/zTODtT6NiZpQxEKdpdx9mV4gu8o4+ZaJcmMj
         BIVqsv4zG8Bo/l7SRu85f34emgmMsylGJpB6hJiLQg4YBKh+5U6gE/6rJCaQkjHS2Cis
         yFV6itrEG1fjeTkAT8GraB83KC36TXDwZGF/4=
Received: by 10.152.136.39 with SMTP id px7mr595385lab.2.1326318746393; Wed,
 11 Jan 2012 13:52:26 -0800 (PST)
Received: by 10.152.128.132 with HTTP; Wed, 11 Jan 2012 13:52:26 -0800 (PST)
In-Reply-To: <CALkWK0nyc6NVE7Qpvbc0dXb1UHGM_=uYbCS+a53HZxiBRG9HvQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188396>

Hi Ram, thank you for the reply.  Se below . . .

>
>> I need some help getting my subversion repository cloned over to git=
=2E
>> Our svn repository has about 12,000 commits, when I run
>> git svn clone -s =A0-A authors.txt
>> svn+ssh://csvn <at> source.res.ourdomain.com/home/svn/sem sem
>> It runs for about 2h 15m then completes with no error messages. I ha=
ve
>> also cloned starting at revision 6300, about the middle of the svn
>> repository, and I get the same results as below.
>
>> $ git branch -a # shows only about half the branches that should hav=
e
>> been cloned
>
> Interesting. =A0From the git-svn-id of the most recent commit, can yo=
u
> tell if there's anything especially fishy about the revision where
> git-svn stops? =A0Your Subversion repository is probably broken in so=
me
> way, but git-svn should not use that as an excuse for appearing to
> finish successfully while failing in reality.

Well by your question it seems you expect this clone to fail at the
same svn revision number
each time.  I spent all day today trying to figure out what that
revision was. However it doesn't
seem to be failing at the same svn revision each time.

There are about 12813 revisions in our svn repository so I started
attempting clones from successively later
and later revisions both to figure which revision they repeatedly
failed on (it was never the same one) and to see
if I could coax a successful clone to occur.  Originally I started at
revision 1, then incremented to 6300, then 8000, then 10000, then
12,500, then finally 12,700.  Finally the attempt starting at svn
revision 12,700 succeeded and the resulting git repository
seems to work. All the attempts prior to 12,700 (starting at 1, 6300,
8000, 10000, and 12,500) failed while
importing different revisions, none of them showed error messages.

One thing that I am suspect of is that I'm not able to log directly
into the machine running git, it's on a remote server in
Atlanta while I'm in Colorado. I'm running the 'git svn clone' using
nohup, but in every case of a corrupt git repository
the connection between me and the server dies before the git completes
(the connection dies, but I log in again and run
ps -ef and I see the multiple git processes still running.  They run
for up to several hours longer, then terminate).  I should be
ok since I'm using nohup, but coincidentally the only clone that
succeeded was the one where the network connection
never disconnected during the clone

Not sure if this helps but here are some numbers:
Both the svn repository and git machine are Solaris 10
Svn revision 1.6.12 CollabNet
Git version 1.7.6.1

Thank you.


--=20
Steven Line
303-910-1212
sline00@gmail.com
