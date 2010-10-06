From: Hocapito Cheteamo <hocapitocheteamo@yahoo.com>
Subject: Fw: Error on git clone
Date: Wed, 6 Oct 2010 13:03:01 -0700 (PDT)
Message-ID: <961094.44125.qm@web114619.mail.gq1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Oct 06 22:03:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3aCk-0005Fn-KZ
	for gcvg-git-2@lo.gmane.org; Wed, 06 Oct 2010 22:03:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759548Ab0JFUDE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Oct 2010 16:03:04 -0400
Received: from web114619.mail.gq1.yahoo.com ([98.136.183.100]:22682 "HELO
	web114619.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755902Ab0JFUDD (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Oct 2010 16:03:03 -0400
Received: (qmail 44541 invoked by uid 60001); 6 Oct 2010 20:03:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024; t=1286395381; bh=4Hh4+YEvSqH4Jm8vF5+KKRLyuHM8KKY+SUOvxhxVUXw=; h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:Cc:MIME-Version:Content-Type; b=EEeBiwW4CguOEUjPt0bZvojv37DhtM7guEXJCzCUullyekubqMFatLB6RF79xU3AF1lKcUgaaSo+h1OddI/IaZ5DB37QKqEAQevNwydKVX3PGhT0PBbpd+a2b7S3jujd0rxdpiUHP9LhU5sr+IsppSQQx3lCvecjv/COB25pi7Q=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:Cc:MIME-Version:Content-Type;
  b=E+KXY81Drq+VL0nJ+dD4zHwSrtZ4Lvvr3EvWPmoXnBj/quIjeBtIBIVjPxPpvVuHAtG2X9xUm9mSBwuj2tqkzVoCZhkBzHHIa0zuhkkynXFqbURhThKRc2kjg+HzLlvMMD4YpH0h4DHdsL+0zOrJqRmXOcNBJlwkDKZ7UYQibBA=;
X-YMail-OSG: 57DPC14VM1n4JUvdzWT5z9ccJ5RIk36DiSSOFSifQ1QIO_Z
 cLTYRH_G1yjfMXafgGTSH1FlskFI._LZWOXZxloDMEkFuNEEk6hrxC8md6F4
 zw0oCuZjz2qO4ZB4FkG_Je5h4cowewInSvdZyEAxujFhJ8zraN.9131lNCu1
 GweLb.BwT._7YzFckaY9qnAuQC8mjBHpu1HvGcw0zmWf.PvAi5ZNQQaX75xy
 0MG1lEbqbHKzKtC5Ed9dzBwJI84qQZI9fhbObEDoAV9cG3kZJ1kLNE5K8x3C
 Q88KA0NU-
Received: from [76.83.7.252] by web114619.mail.gq1.yahoo.com via HTTP; Wed, 06 Oct 2010 13:03:01 PDT
X-Mailer: YahooMailRC/497 YahooMailWebService/0.8.105.279950
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158302>

Hi Hannes,

I'd like to follow up on your recommendation of using sparse checkout to resolve 
that CR-in-directory-name problem.

According to my upstream, they can't change that directory name.  It works fine 
on all their Mac systems.  I'm the first one using the PC system.  So I have to 
resort to the sparse checkout.

This is what I did:
1. Created a file .git/info/sparse-checkout that contains these lines:
*
!title_add_tags_to.png
!title_tagging.png

The above two files are the only ones that are listed in that problematic 
directory name "public/images/tagging\rtagging/".

2. To enable sparsecheckout, modified file .git/config:
[core]
    repositoryformatversion = 0
    filemode = false
    bare = false
    logallrefupdates = true
    symlinks = false
    ignorecase = true
    hideDotFiles = dotGitOnly
    sparsecheckout = true  <------- added this line
[remote "origin"]
    url = git@github.com:XXX/YYY.git
    fetch = +refs/heads/*:refs/remotes/origin/*

Then I issued the command
$ git checkout -b master origin/master
Checking out files: 100% (937/937), done.
Branch master set up to track remote branch master from origin.
Already on 'master'

Voila, it works.  That "tagging\rtagging/" directory was not created in folder 
"public/images/".

Thanks.
Hoca


      
