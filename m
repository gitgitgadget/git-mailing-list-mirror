From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Possible BUG in 'git log --parents'
Date: Sat, 7 Jul 2007 11:49:50 +0200
Message-ID: <e5bfff550707070249i6f3f7288uce1f922686f6e14d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 07 11:50:16 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I76vf-0000xg-IX
	for gcvg-git@gmane.org; Sat, 07 Jul 2007 11:50:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753397AbXGGJtx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Jul 2007 05:49:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752266AbXGGJtx
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jul 2007 05:49:53 -0400
Received: from wa-out-1112.google.com ([209.85.146.182]:58415 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752291AbXGGJtw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jul 2007 05:49:52 -0400
Received: by wa-out-1112.google.com with SMTP id v27so613625wah
        for <git@vger.kernel.org>; Sat, 07 Jul 2007 02:49:51 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=pF2D0gP8GezDS6jriqXHhTmJXzjU4ngW0t3FFyEfsrynUqZRjG/pXe4oemmsrn15UzFl9qaGje50sYEgCDs3uuRhlOw48YAHaRGDuvLNJjmTNnfstrCP6ATWIp2iNFXnpgB1L3mLB5zo9q61uR1M+7fYXqoHqdwvMzTFj8KsSXE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=jOwPNHGP94Dzzk5gzyfA+Mf9ZkLPsZpPWM58s+nUIMh9rPeKisnq0q0Zji8VJ3nVYVjk+xy4Qs7iNeWBuUgoVVmTPO+FJhDM4wBV77An/oeMIHr5x3cXY4IOPezUdukmA2GiNsWtjYE09ccTPCwtvi4FqCG+Yz5oPtLBpzWTQ6M=
Received: by 10.114.137.2 with SMTP id k2mr1410473wad.1183801790907;
        Sat, 07 Jul 2007 02:49:50 -0700 (PDT)
Received: by 10.114.61.9 with HTTP; Sat, 7 Jul 2007 02:49:50 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51807>

git-rev-list shows parents correctly, git-log no, in particulary there
is parent 913419f that is shown 3 times instead of 1. Testing on git
repository.

$ git --version
git version 1.5.3.rc0.11.ge2b1a

$ git-rev-list --parents --header addafaf92e -n1 -- diff.h
addafaf92eeb86033da91323d0d3ad7a496dae83
913419fcc648dd43d7f7afdd94fa25aee4f9798a
ea726d02e9677a66586d7ffebe97f112ab6dab33
46a6c2620ba421397eec627b8eb18eb530e694fc
tree e3be15f54f01e3aa1f8ec830ac87da5f85a23480
parent 6b94f1e404afc552e5139c4357331843f5be61ad
parent 93b74bca86f59b8df410b6fd4803b88ee0f304bf
parent ea726d02e9677a66586d7ffebe97f112ab6dab33
parent b33aba518456bee97bde1fef4fe17ab6bf401bbe
parent 6b1ddbdd6e02719ae2be55dc141a176187e5027e
author Junio C Hamano <junkio@cox.net> 1138436169 -0800
committer Junio C Hamano <junkio@cox.net> 1138436169 -0800

    Merge lt/revlist,jc/diff,jc/revparse,jc/abbrev


$ git-log --parents --pretty=raw addafaf92e -n1 -- diff.h
commit addafaf92eeb86033da91323d0d3ad7a496dae83
913419fcc648dd43d7f7afdd94fa25aee4f9798a 913419fcc648dd43d7f7a
fdd94fa25aee4f9798a ea726d02e9677a66586d7ffebe97f112ab6dab33
913419fcc648dd43d7f7afdd94fa25aee4f9798a 46a6c262
0ba421397eec627b8eb18eb530e694fc
tree e3be15f54f01e3aa1f8ec830ac87da5f85a23480
parent 6b94f1e404afc552e5139c4357331843f5be61ad
parent 93b74bca86f59b8df410b6fd4803b88ee0f304bf
parent ea726d02e9677a66586d7ffebe97f112ab6dab33
parent b33aba518456bee97bde1fef4fe17ab6bf401bbe
parent 6b1ddbdd6e02719ae2be55dc141a176187e5027e
author Junio C Hamano <junkio@cox.net> 1138436169 -0800
committer Junio C Hamano <junkio@cox.net> 1138436169 -0800

    Merge lt/revlist,jc/diff,jc/revparse,jc/abbrev
