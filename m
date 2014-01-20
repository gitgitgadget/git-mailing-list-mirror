From: Hannes Mezger <hannes.mezger@gmail.com>
Subject: No local cloning for insteadOf URLs
Date: Mon, 20 Jan 2014 18:06:12 +0100
Message-ID: <52DD5784.1000601@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 20 18:06:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W5IIl-0008KV-26
	for gcvg-git-2@plane.gmane.org; Mon, 20 Jan 2014 18:06:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753745AbaATRGP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jan 2014 12:06:15 -0500
Received: from mail-ea0-f170.google.com ([209.85.215.170]:47903 "EHLO
	mail-ea0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752699AbaATRGO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jan 2014 12:06:14 -0500
Received: by mail-ea0-f170.google.com with SMTP id k10so3232860eaj.15
        for <git@vger.kernel.org>; Mon, 20 Jan 2014 09:06:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=3KR62cdBK7TET2i40dmhKmaj+Q69tfotzzr6SCmGM0M=;
        b=iz8ACz6nHgpnluhQ6vjIN1HSJwcF2W7bus2tNQzE1o4TOVGMqEB7ONo+RZF6BGS7qp
         DfZ09vP5M8urWSoZa4TKz8bfMtGtpPbiRkZEcey/6zDPBZC6ibiYFbJzleWogtTfgjpB
         q4HOGNEZNwcq/hE3pPLlYTVk/doeMjJAfm7wkH1LYW2hJcqeFheq2Hfi3FOlBX84wE7O
         IUpnM6jm7F+ufiO+83HTwt78ZVAUvcP84pgkTUBnlQJdwnNroocITSDsZbx3fDJhWR0A
         j9Hrp1S2Z/gktm6yMYhnnkUjbU5J/1Wko2lIiltvkyPvKeNzwc3lX3B/wm9NUzrQdTeb
         ruSw==
X-Received: by 10.14.215.68 with SMTP id d44mr2829394eep.90.1390237573359;
        Mon, 20 Jan 2014 09:06:13 -0800 (PST)
Received: from [192.168.0.30] ([213.95.4.186])
        by mx.google.com with ESMTPSA id j46sm5098722eew.18.2014.01.20.09.06.12
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 20 Jan 2014 09:06:12 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240718>

Hi there,

on Linux I'm using the config option url.[].insteadOf feature to clone
certain (very big) submodules from a local mirror instead of from remote.
The configuration is something like

[url "/home/sampleuser/mirrors/bigrepo.git"]
    insteadOf = git@remotehost:bigrepo.git

Cloning this repo with
    git clone git@remotehost:bigrepo.git
works fine, it is cloning from my local repo instead of from the remote one.

But: I was expecting the 'git clone' call to take into account that it
is cloning a local repository and create hard links to the packs of my
local mirror repository, but instead it copies the whole repo just as it
was a remote repository. This should get fixed, this 'git clone' call
should detect that it is cloning a local repository and create hard
links to the *.pack files.

When cloning the local mirror directly with
    git clone /home/sampleuser/mirrors/bigrepo.git
'git clone' automatically creates hard links to the local mirrors *.pack
files.


Cheers,

Hannes
