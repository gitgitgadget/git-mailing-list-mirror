From: "Yaser Raja" <yrraja@gmail.com>
Subject: Setting Up a GIT Repository Mirror
Date: Thu, 6 Nov 2008 20:08:24 +0500
Message-ID: <e97d51700811060708y5deb9e9ek4a36c012726b3a63@mail.gmail.com>
References: <e97d51700811060706t40433bb9k7a3704429f244164@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 06 16:10:30 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ky6V6-0006Qt-Ec
	for gcvg-git-2@gmane.org; Thu, 06 Nov 2008 16:10:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750897AbYKFPI1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Nov 2008 10:08:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751444AbYKFPI1
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Nov 2008 10:08:27 -0500
Received: from hs-out-0708.google.com ([64.233.178.251]:19796 "EHLO
	hs-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751984AbYKFPIZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Nov 2008 10:08:25 -0500
Received: by hs-out-0708.google.com with SMTP id 4so262194hsl.5
        for <git@vger.kernel.org>; Thu, 06 Nov 2008 07:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=AAGJvAzMkYQzyPx9XpEsajYR+Y0dwt92MffKmQllSOY=;
        b=v0ILkxU1Y4CFHFy+ox011/NhrgzXCxEJxLuO0e1dSqKPpcAvL2kLTc/mmqRj5U4vT/
         FnaXhqM0fu9+g65HuPBG9M9yOwNgvfXUAahxxLsuvsHevTz5zqxz+3BiXNuF+5M9yYmk
         dXArxVrvPKDyzRpAPKk4LB2rqacL5HHAFYTlQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=cGyvZonbtnhOPcCuJUT06CM+L2gqs2Le1PN/G83K3cDtg3bp2auRsORZlKe6dQ93Th
         /AjV32++XabELxGs7IynOuiwjGGxX4CWDDYQpbNlGSQqIVfDtvhcoKu8maqQjQrR32M0
         Ml9Aslx7e+0JqwZ7lFGasWjjnvIFDKTJqele8=
Received: by 10.150.144.9 with SMTP id r9mr1552240ybd.170.1225984104383;
        Thu, 06 Nov 2008 07:08:24 -0800 (PST)
Received: by 10.150.190.12 with HTTP; Thu, 6 Nov 2008 07:08:24 -0800 (PST)
In-Reply-To: <e97d51700811060706t40433bb9k7a3704429f244164@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100239>

Hi

I have a main repository placed at a remote location and i want to
have a read-only mirror of this repository available locally. The
users/automated processes will use this local mirror to get the latest
code.

Can anyone guide me how to implement this? I did make a basic setup as
follows but it has some issues:

1. Create a clone (MirrorRep) of the remote git repository (MainRep)
on a local machine using "git-clone" command
         git-clone ssh://<user>@<remote machine addr> MyMirror

2. Use "git-pull" to keep this repository (MirrorRep) in sync with the
main repository. I added entry in /etc/crontab to invoke "git-pull"
after every 10 minutes to update this repository.

3. Launch "git-daemon" so that local users can access and clone from
this  Mirror Repository.
         git-daemon --export-all --verbose --base-path=<base path to
MyMirror directory>

After this the users can easily clone from the local repository and
work with it. The problem is that the branches that were present in
MainRep are not visible in the clones made using MirrorRep. When
MirrorRep was created all the branches of MainRep became remote
branches for MirrorRep. And when users make a clone from MirrorRep
none of the remote branches are transfered over.

I came to know about --mirror option of git-clone and used it to make
a bare repository replica of the MainRep. Now i am not sure how to
keep it in sync with the MainRep.

Thanks
Yaser
