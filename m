From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Tracability in git commits
Date: Thu, 1 May 2008 13:26:09 +1200
Message-ID: <46a038f90804301826xaf5d73bl1d29a07bc930a716@mail.gmail.com>
References: <1209473739.5642.31.camel@dax.rpnet.com>
	 <m3lk2vodw4.fsf@localhost.localdomain>
	 <1209551520.5010.20.camel@dax.rpnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org
To: "Richard Purdie" <rpurdie@rpsys.net>
X-From: git-owner@vger.kernel.org Thu May 01 03:27:02 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JrNZd-0004ZH-9w
	for gcvg-git-2@gmane.org; Thu, 01 May 2008 03:27:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754231AbYEAB0M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2008 21:26:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754047AbYEAB0M
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Apr 2008 21:26:12 -0400
Received: from wf-out-1314.google.com ([209.85.200.172]:57900 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753495AbYEAB0K (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2008 21:26:10 -0400
Received: by wf-out-1314.google.com with SMTP id 28so633731wfc.4
        for <git@vger.kernel.org>; Wed, 30 Apr 2008 18:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=ganPiBoLxC/4etZNVgicidFullCPDIjnFGG8vn4j9oQ=;
        b=H14YJ2byUrJclG/k7vo6LCq9+/4x9SSpr/sQWHG3Rgn+ARgSJYE+fQ3447oKihm6LBBVGKPv1n5o9cA6wiBWRQqed2dsmQODolQTqFTCFK/1kzYEck4SXeRn9/6+X+p2K3cB8eqKZDN8M2ynMyr/TM9KBhFGiAKeckoKFipNqLY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dtSlui4ZmBF+QClbL8CqLFfOXa617Ye4z0ADEoXiLshq43YuYJzwSwt/7TRX9yH6HbEFHCrRmVvW1ZW+0hdKWJYoEziflcl8UQIisijYVAlRDA4PzdplLABbHdcPrhkeuqTWRSjiz/vJVQwaYY/w28WqgKN99ilZvqSVWMAOFh0=
Received: by 10.142.143.7 with SMTP id q7mr573012wfd.3.1209605169631;
        Wed, 30 Apr 2008 18:26:09 -0700 (PDT)
Received: by 10.142.212.21 with HTTP; Wed, 30 Apr 2008 18:26:09 -0700 (PDT)
In-Reply-To: <1209551520.5010.20.camel@dax.rpnet.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80886>

On Wed, Apr 30, 2008 at 10:32 PM, Richard Purdie <rpurdie@rpsys.net> wrote:
>  The project I'm thinking about is OpenEmbedded which used to use
>  bitkeeper and switched to monotone when bitkeeper went private only.

Richard,

you might be able to use a slightly tweaked workflow where you

 1 - Prepare a GPG-signed list of the commit hashes you are about to push
 2 - Push to an "incoming" repository that does weak or no validation
 3 - Push/publish your GPG-signed list of commit hashes
 4 - A script "pushes" commits from the "incoming" repo to a
"verified" repo after checking that they are backed by a GPG-signed
list. For ease of use, this can happen on the server ASAP, and it can
be validated independently by any party. Notably, it is probably a
good idea that it is validated shortly before a release is tagged.

This way, you keep the flexible/fast properties of git, but use the
SHA1 commit->tree>file relationship plus external wrapper scripts to
add auditing capabilities that are open and repeatable.

So all you need is

 - a trivial "push" wrapper that prepares the commits-to-push list and
automates the signing and publishing of the list
 - a trivial script to run the migration of verified commits

cheers,



m
-- 
 martin.langhoff@gmail.com
 martin@laptop.org -- School Server Architect
 - ask interesting questions
 - don't get distracted with shiny stuff - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff
