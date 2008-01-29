From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Added sub get_owner_file which checks if there's a file with project owner name
Date: Tue, 29 Jan 2008 19:27:00 +0100
Message-ID: <200801291927.01461.jnareb@gmail.com>
References: <1201577766-11601-1-git-send-email-ribas@c3sl.ufpr.br> <200801291628.21026.jnareb@gmail.com> <20080129172216.GA17875@c3sl.ufpr.br>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Bruno Cesar Ribas <ribas@c3sl.ufpr.br>
X-From: git-owner@vger.kernel.org Tue Jan 29 19:28:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJvBR-0005WM-Jd
	for gcvg-git-2@gmane.org; Tue, 29 Jan 2008 19:27:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755742AbYA2S1N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2008 13:27:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754793AbYA2S1M
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jan 2008 13:27:12 -0500
Received: from fg-out-1718.google.com ([72.14.220.153]:7427 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752948AbYA2S1K (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2008 13:27:10 -0500
Received: by fg-out-1718.google.com with SMTP id e21so2161841fga.17
        for <git@vger.kernel.org>; Tue, 29 Jan 2008 10:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=pwGRtQaSDC18UYOfGclThd/uJJIF/u33Xuufmb7wp/s=;
        b=ZQ7U0lgxk67KGubWY9lwDWJKyVsIaeYRlTUJqBpK3riHF9rbTCNmSKWcF2WZ1LPYewvNz4c4TrEXAJiDLblHx4j1cv7gKeu+RQeTYSlpYhcAfaZ/I/JrVrfLhq7ZaYMGn/WjWE5aoSkui0+Ctuut6WwpZ5TSu17LdRrNr0cSrzs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=phRDEAUxbjUNOgPg52FWILEzmxReeOzyFBypwnTfAu+NdUjNpn3gmd/YQ4HpTp3ZjEVVl6ZDABHjaFEti3NCkbHTnK3Qlv6ZkLQR3XYxJ2ctYd3M8Jms9G5tqHS+UazCoES6eGzP4a6PP5Nz9GaUAvF63LGgrEPgXDtcKtwjLG8=
Received: by 10.82.162.14 with SMTP id k14mr12734027bue.32.1201631228256;
        Tue, 29 Jan 2008 10:27:08 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.244.23])
        by mx.google.com with ESMTPS id u14sm1637344gvf.1.2008.01.29.10.27.05
        (version=SSLv3 cipher=OTHER);
        Tue, 29 Jan 2008 10:27:07 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20080129172216.GA17875@c3sl.ufpr.br>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71986>

On Tue, 29 Jan 2008, Bruno Cesar Ribas wrote:
> On Tue, Jan 29, 2008 at 04:28:19PM +0100, Jakub Narebski wrote:

[cut]

By the way, can I ask you to remove the parts of quoted email you
do not reply to? It means leave only those parts you answer. It makes
following the flow of discussion easier. TIA.
 
>> By the way, I have forgot to ask you to add description of new 'owner'
>> file to "Per-repository gitweb configuration" section in gitweb/README
> 
> I'm on the way to add description of 'owner' file, before commint should I
> implement gitweb.owner too? then that README comes with two way of seting
> owner. Or let only owner file for now?

If you add also implementation of gitweb.owner support (following
for example git_get_project_description), then mention it in
description of 'owner' file in gitweb/README. If you don't, just
explain about 'owner'.

Relevant fragment of gitweb/README you can follow:

 * description (or gitweb.description)
   Short (shortened by default to 25 characters in the projects list page)
   single line description of a project (of a repository). Plain text file;
   HTML will be escaped. By default set to
     Unnamed repository; edit this file to name it for gitweb.
   from the template during creating repository. You can use
   gitweb.description repo configuration variable, but the file takes
   precendence.

Describe format, fallback to gitweb.owner, then fallback to directory
owner (filesystem).

>>> I even made another patch about cloneURL, instead of looking for inside files
>>> and stuff, i made gitweb.conf a variable that says:
>>> - If i have a prefix path for HTTP,SSH,GIT[protocol]
>>> Then if this variable is set gitweb only mounts... like
>>> HTTPPREFIX="http://git.c3sl.ufpr.br/pub/scm"
>>> and gitweb sets it to $HTTPREFIX/$project
>>> 
>>> I made this because I don't want to set each project it's clone URL, so this 
>>> makes thing easier! What do you think?
>> 
>> I hope that this hack predates latest improvements to gitweb/README,
>> as you have just reimplemented GITWEB_BASE_URL build configuration
>> variable (only single base URL), and @git_base_url_list, which you
>> can set in gitweb config file (by default gitweb_config.perl).
> 
> Ok, I'll check recent version of gitweb and i'll send this commit
> if relevant =)

I think the change described above doesn't add any new functionality.

[cut]
-- 
Jakub Narebski
Poland
