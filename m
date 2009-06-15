From: Aaron Hicks <HicksA@landcareresearch.co.nz>
Subject: RE: egit and RSA keys for SSH
Date: Tue, 16 Jun 2009 10:49:53 +1200
Message-ID: <F2969C1B08CBEE42B78C04C280D578E72CAF41E46A@donkey.landcare.ad.landcareresearch.co.nz>
References: <F2969C1B08CBEE42B78C04C280D578E72CAF41E19B@donkey.landcare.ad.landcareresearch.co.nz>
 <20090615150341.GX16497@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 16 00:50:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGL0V-0004Lx-Jz
	for gcvg-git-2@gmane.org; Tue, 16 Jun 2009 00:50:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752436AbZFOWuR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jun 2009 18:50:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752385AbZFOWuQ
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jun 2009 18:50:16 -0400
Received: from smtp.landcareresearch.co.nz ([202.27.240.35]:49287 "EHLO
	smtp.landcareresearch.co.nz" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752108AbZFOWuP convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jun 2009 18:50:15 -0400
Received: from donkey.landcare.ad.landcareresearch.co.nz ([202.27.240.35]) by
 donkey.landcare.ad.landcareresearch.co.nz ([202.27.240.35]) with mapi; Tue,
 16 Jun 2009 10:50:15 +1200
Thread-Topic: egit and RSA keys for SSH
Thread-Index: AcntynognyN5/2a8TCauTPfPVnDFEgAQBPaQ
In-Reply-To: <20090615150341.GX16497@spearce.org>
Accept-Language: en-US, en-NZ
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US, en-NZ
x-tm-as-product-ver: SMEX-8.0.0.1181-5.600.1016-16706.002
x-tm-as-result: No--54.995200-8.000000-31
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121637>

Hi Shawn,

I've followed your instructions, and added the same RSA key that I use with Git and Git Extensions (using Windows here), but eGit still asks for a password for a the git user (which is password disabled, and requires RSA). I'm telling eGit to access via "git + SSH".

I'm assuming for windows the ~/.ssh should be in C:\path\to\profile\username\.ssh ?

I'm not 100% that eGit has installed correctly in Eclipse (3.4.2 Ganymede, Windows XP SP3, Java 1.6.0_13) either. I can't see many git-like commands in the context menus for files and projects.

Regards,

Aaron Hicks

> -----Original Message-----
> From: spearce@spearce.org [mailto:spearce@spearce.org]
> Sent: Tuesday, 16 June 2009 3:04 a.m.
> To: Aaron Hicks
> Cc: git@vger.kernel.org
> Subject: Re: egit and RSA keys for SSH
>
> Aaron Hicks <HicksA@landcareresearch.co.nz> wrote:
> > We have a git repository set up with gitosis and it requires RSA
> > keys to authenticate developers who have rights to push to this
> > repository. i.e. they are blessed with write privileges. Github
> > uses a similar method.
> >
> > We use Eclipse, so we would like Eclipse to integrate with Git. So
> > we grabbed egit from http://www.jgit.org/update-site and used the
> > Eclipse installer (Like we do all the other Eclipse plug-in, given
> > that the egit/jgit sites don't give instructions otherwise it seems
> > to be the thing to do).
> >
> > The problem is I can't see how to associate an RSA key in order
> > to authenticate the SSH login with our gitosis repository (or
> > GitHub). We have PuTTY installed and use Pageant to manage keys, and
> > the required key is already loaded.
>
> Unfortunately both PuTTY's Pageant and OpenSSH's ssh-agent are
> not supported from JSch, which is the SSH client used within JGit,
> which is what is underneath EGit.  Consequently, you can't use the
> agent to manage your keys.
>
> From within Eclipse, if you go to Window > Preferences > General >
> Network Connections > SSH2 you can configure your RSA keys.  But,
> these keys are configured globally for the workspace, i.e. its
> more like loading the key into the agent than it is about binding
> a particular key to a particular host.
>
> To force binding a key to a host, use ~/.ssh/config.  JGit knows
> how to read this file on startup and uses the Host blocks to do
> some configuration control over the connection.
>
> E.g. if you use a URL like "git@gitserver.example.com:foo.git"
> then you can put the following in your ~/.ssh/config to force using
> a specific SSH key:
>
>   Host gitserver.example.com
>     IdentityFile .ssh/id_gitkey
>
> Note that ~/.ssh/config is cached on startup of EGit, so you'll
> need to completely restart the Eclipse workspace after making any
> changes to it.
>
> --
> Shawn.

Please consider the environment before printing this email
Warning:  This electronic message together with any attachments is confidential. If you receive it in error: (i) you must not read, use, disclose, copy or retain it; (ii) please contact the sender immediately by reply email and then delete the emails.
The views expressed in this email may not be those of Landcare Research New Zealand Limited. http://www.landcareresearch.co.nz
