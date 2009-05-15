From: "J.H." <warthog19@eaglescrag.net>
Subject: Re: Removing the trailing "/.git" from gitweb display?
Date: Fri, 15 May 2009 14:14:54 -0700
Message-ID: <4A0DDB4E.8090905@eaglescrag.net>
References: <ed82fe3e0905151349k15f040aej30dbec82037e9d76@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Timur Tabi <timur@freescale.com>
X-From: git-owner@vger.kernel.org Fri May 15 23:17:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M54mG-0005Fh-Ax
	for gcvg-git-2@gmane.org; Fri, 15 May 2009 23:17:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754198AbZEOVRA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 May 2009 17:17:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754036AbZEOVRA
	(ORCPT <rfc822;git-outgoing>); Fri, 15 May 2009 17:17:00 -0400
Received: from shards.monkeyblade.net ([198.137.202.13]:47635 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753670AbZEOVQ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 May 2009 17:16:59 -0400
Received: from voot-cruiser.eaglescrag.net (173-29-17-5.client.mchsi.com [173.29.17.5])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.1/8.14.1) with ESMTP id n4FLEs5u025735
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 15 May 2009 14:14:58 -0700
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <ed82fe3e0905151349k15f040aej30dbec82037e9d76@mail.gmail.com>
X-Enigmail-Version: 0.95.6
X-Virus-Scanned: ClamAV 0.88.7/9360/Thu May 14 15:31:31 2009 on shards.monkeyblade.net
X-Virus-Status: Clean
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.1.1 (shards.monkeyblade.net [198.137.202.13]); Fri, 15 May 2009 14:15:00 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119297>

Your actually barking up two separate trees / issues here.

Timur Tabi wrote:
> I noticed that most gitweb pages show their repositories like this:
> 
> bluetooth/bluez-gnome.git 	Bluetooth applications for ... 	Marcel Holtmann
> bluetooth/bluez-hcidump.git 	Bluetooth packet analyzer 	Marcel Holtmann
> bluetooth/bluez.git 	Bluetooth protocol stack for ... 	Marcel Holtmann

I'm going to assume you pulled this off of kernel.org, but the basic 
reason here is that we use the <project>.git moniker as a standard to 
designate that the underlying directory is a bare git repo.  That's 
really it there.  We do have a script that wanders our directory 
structure and looks or directories based on the <project>.git so that's 
a bit required from our perspective.

> 
> However, mine looks like this:
> 
> alsa.1862/.git	8610 audio: fabric driver uses wrong DMA channels for... 	Timur
> alsa.2598/.git	8610 audio: migrate ASoC V2 drivers to mainline	Timur
> alsa.3313/.git	Introduce spin_event_timeout()	Timur

If your doing that, then your putting a full git tree into gitweb as 
opposed to a bare repo.  I would suggest only putting a bare repo.

> 
> Notice how my repositories have a trailing "/.git" to them?  How do I
> get rid of that?
> 
> My gitweb.conf is:
> 
> $projectroot = '/home/b04825/git/';
> $site_name = "Timur Tabi's git repositories";
> $home_link = $my_uri;
> @stylesheets = ("gitweb.css");
> $favicon = "git-favicon.png";
> $logo = "git-logo.png";
> $projects_list = '/home/b04825/git/projects_list';
> $projects_list_description_width = 50;
> 
> And /home/b04825/git/projects_list looks like:
> 
> alsa.1862/.git Timur
> alsa.2598/.git Timur
> alsa.3313/.git Timur
> 
> I presume the reason why gitweb shows the trailing "/.git" is because
> that's what my projects_list file contains.  However, if I remove the
> "/.git" from projects_list, gitweb can't find any repositories.
