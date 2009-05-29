From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Git Confusion
Date: Fri, 29 May 2009 22:45:55 +0200
Message-ID: <200905292245.56702.jnareb@gmail.com>
References: <815c8c330905290043i4c99a753jd5ad9bdd4cf18bbc@mail.gmail.com> <20090529135242.GA30926@coredump.intra.peff.net> <815c8c330905291324w4e861602n8278df72fdbc28db@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org, yury239@gmail.com
To: Paul Tarjan <ptarjan@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 29 22:46:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MA8xq-0005yA-Ni
	for gcvg-git-2@gmane.org; Fri, 29 May 2009 22:46:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752066AbZE2Up5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 May 2009 16:45:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752013AbZE2Up4
	(ORCPT <rfc822;git-outgoing>); Fri, 29 May 2009 16:45:56 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:48790 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751585AbZE2Up4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 May 2009 16:45:56 -0400
Received: by fg-out-1718.google.com with SMTP id 16so2345797fgg.17
        for <git@vger.kernel.org>; Fri, 29 May 2009 13:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=6aWpQ3G8ScBOnJYNDQD0OmqS7fg4GWhrZ0bB6EZXEM4=;
        b=KVCxel1sWEV7odCImKHyOcF7s5MGMw9soXXMUXIcfalYlBYjjc0xlLLwLaL3QGJg2e
         ly1pcUzhVWqDj4u9WnqPlAa7PQERhsswLDQ0t6vEgT4F4/prC0N7l7Z1Gur65rd7MA2f
         /8NicVt8CBirIMTby6wi0zAuq6djHf19H/ZTM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=KtaA1mVsknKIWlbsiNdlOoNyxOmz3vqHnNWm73vfNbeCDAjnyuvuy7n0KNyHF4bDB8
         kG/Mj6eMbyrNu0p+Ohd0AzvLJ8bEPofgjpABdXAk/AFJapNLeo5cucY830H7yB42BtIK
         p5Uu0Rkr1kWAw5v1C6Mq9TM58vYrMaTPSOdr4=
Received: by 10.86.59.2 with SMTP id h2mr3356879fga.30.1243629956848;
        Fri, 29 May 2009 13:45:56 -0700 (PDT)
Received: from ?192.168.1.13? (abwe32.neoplus.adsl.tpnet.pl [83.8.228.32])
        by mx.google.com with ESMTPS id 4sm3662552fgg.28.2009.05.29.13.45.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 29 May 2009 13:45:56 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <815c8c330905291324w4e861602n8278df72fdbc28db@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120315>

On Fri, 29 May 2009, Paul Tarjan wrote:
> Thank you very much. For skimmers the solution is :
> 
> git update-server-info
> 
> every time I do something to the remote repo.
> 
> The reason I need http is slightly convoluted. The remote machine is
> shared hosting with 1 ssh login that I don't want to give to my
> partner AND I don't have root on that box. And as you correctly
> guessed, that box doesn't have the git demon. The local machine where
> he is doing his development. The only solution I saw without giving
> him my username + pass to SSH was to do http cloning. Any better
> solutions?

I see two possible solutions (and you can use both):

1. Have separate publishing repository, which would be bare, and updated
   only via push (so enabling 'update' / 'post-receive' hooks would be
   enough for HTTP). This is good idea also because it makes it possible
   to change commits (rewrite history), e.g. do "git commit --amend"...
   provided that you didn't push part of history you are changing to
   public repository. If you are worrying about disk space, you can
   always set up alternates.

2. Use Gitosis (or ssh_acl) to control access via SSH to repository
   without need to provide extra user accounts, or use git-shell as
   login shell for user accounts which are meant only to access
   repositories. I think you can use Gitosis without being a root...
   see link in BlogPosts page at Git Wiki.

-- 
Jakub Narebski
Poland
