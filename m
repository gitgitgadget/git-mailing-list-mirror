From: Robert Clausecker <fuzxxl@gmail.com>
Subject: Re: Feature request: Allow extracting revisions into directories
Date: Sun, 10 Feb 2013 05:10:40 +0100
Message-ID: <1360469440.6610.8.camel@t520>
References: <1359901085.24730.11.camel@t520> <510E8F82.9050306@gmail.com>
	 <1359915086.24730.19.camel@t520> <510F03FC.6080501@gmail.com>
	 <CABURp0rMk-W8VMRhXoR9YYQSwjWTfPbXz5mhPX3-HKsBSu5_mw@mail.gmail.com>
	 <1360425499.3369.10.camel@t520> <7vehgpum7n.fsf@alter.siamese.dyndns.org>
	 <7vpq08u903.fsf@alter.siamese.dyndns.org> <1360468628.6610.5.camel@t520>
	 <20130210040621.GA8584@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 10 05:11:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4OFw-0002G6-BQ
	for gcvg-git-2@plane.gmane.org; Sun, 10 Feb 2013 05:11:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932558Ab3BJEKo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2013 23:10:44 -0500
Received: from mail-bk0-f47.google.com ([209.85.214.47]:52395 "EHLO
	mail-bk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761045Ab3BJEKn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2013 23:10:43 -0500
Received: by mail-bk0-f47.google.com with SMTP id jc3so2167066bkc.34
        for <git@vger.kernel.org>; Sat, 09 Feb 2013 20:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:subject:from:to:date:in-reply-to:references
         :content-type:x-mailer:mime-version:content-transfer-encoding;
        bh=CL7hpjWkF3pST1VhjwwqkHLs7IbGdBEoxwqxb0f+uWA=;
        b=0920RxkWHrxJRCNc6r/eNQUvb1/yUCtNEW0mAQMr5rmq7+rmOfbzBMCXHQV+Svctjk
         A3meK5nQR5eZiQ1N9Jj0r3muyecpvGOupu2XaoduWCLt8GGnmzuVl/3y+1D8WXCjJHjX
         sWSO5EJOASm8Au4c3moYb6xvFqAs5vpQ4scOns9kiMYU/FwqxRm5j6Cp5ypuRCh7S0Eh
         AdX76M2/RZt5DwLw3hYn+npWxrqQi2w5QwL9JBNmRYEuqeJ/Jhrfb6AMCrA/IynkwzXC
         bv1AhBKBrzDyqsjYqM3i0tHABWolUCu0TrAWh3ihNsL0wpQziU7Aj+HbSv4bJzum6HMC
         2zsQ==
X-Received: by 10.204.3.220 with SMTP id 28mr2812220bko.62.1360469442108;
        Sat, 09 Feb 2013 20:10:42 -0800 (PST)
Received: from ?IPv6:2001:bf0:c001:30:344f:f7d:d92a:db7e? ([2001:bf0:c001:30:344f:f7d:d92a:db7e])
        by mx.google.com with ESMTPS id o9sm11704420bko.15.2013.02.09.20.10.41
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 09 Feb 2013 20:10:41 -0800 (PST)
In-Reply-To: <20130210040621.GA8584@elie.Belkin>
X-Mailer: Evolution 3.6.2-0ubuntu0.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215895>

That is actually a pretty interesting approach. I can use a different
index file for different deployments. How does this cooperate with bare
repositories? Aren't they supposed to have no index file at all?

Am Samstag, den 09.02.2013, 20:06 -0800 schrieb Jonathan Nieder:
> My advice is to keep a separate index file for your exported files.
> Like this:
> 
> 	GIT_DIR=$(readlink -f $(git rev-parse --git-dir))
> 	GIT_INDEX_FILE=$GIT_DIR/index-for-deployment
> 	export GIT_DIR GIT_INDEX_FILE
> 
> 	cd $dest
> 	git read-tree -m -u <tree>
> 
> Hope that helps,
> Jonathan
