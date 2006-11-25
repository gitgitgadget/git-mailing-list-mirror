X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Steven Grimm <koreth@midwinter.com>
Subject: Re: [RFC] Submodules in GIT
Date: Sat, 25 Nov 2006 11:19:35 -0800
Message-ID: <45689747.3020403@midwinter.com>
References: <20061120215116.GA20736@admingilde.org> <ejt9dh$kfm$1@sea.gmane.org> <7v7ixp20za.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0611201501230.3338@woody.osdl.org> <20061121223130.GA24909@nan92-1-81-57-214-146.fbx.proxad.net> <Pine.LNX.4.64.0611211437430.3338@woody.osdl.org> <20061121235429.GH5443@nan92-1-81-57-214-146.fbx.proxad.net> <20061122034056.GB23856@spearce.org> <20061123232313.GB24909@nan92-1-81-57-214-146.fbx.proxad.net> <20061125065338.GC4528@spearce.org> <20061125111235.GO5443@nan92-1-81-57-214-146.fbx.proxad.net> <Pine.LNX.4.64.0611251037000.6991@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sat, 25 Nov 2006 19:21:24 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=Hk51TVrt6YcD3z/exjiuvHHucDric0UzN7Fez4pp2FVF0KHRoq0FlZuR+LETZFf3  ;
User-Agent: Mail/News 1.5.0.2 (Macintosh/20060324)
In-Reply-To: <Pine.LNX.4.64.0611251037000.6991@woody.osdl.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32301>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Go35N-0005eg-Jz for gcvg-git@gmane.org; Sat, 25 Nov
 2006 20:21:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967152AbWKYTTj (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 25 Nov 2006
 14:19:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967151AbWKYTTi
 (ORCPT <rfc822;git-outgoing>); Sat, 25 Nov 2006 14:19:38 -0500
Received: from tater.midwinter.com ([216.32.86.90]:26771 "HELO
 midwinter.com") by vger.kernel.org with SMTP id S967148AbWKYTTh (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 25 Nov 2006 14:19:37 -0500
Received: (qmail 25182 invoked from network); 25 Nov 2006 19:19:37 -0000
Received: from localhost (HELO ?127.0.0.1?) (koreth@127.0.0.1) by localhost
 with SMTP; 25 Nov 2006 19:19:37 -0000
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

Linus Torvalds wrote:
> So I actually think that submodules should at least start out as something 
> rather independent, where a "commit -a" in the supermodule will _only_ 
> commit the supermodule itself - and if you haven't committed the submodule 
> yet, you'll just get the current HEAD state of the submodule.

That would make it impossible to atomically commit a change that affects 
two submodules, yes? I think cross-submodule commit is highly desirable 
and will be a fairly common use case for submodules if it's supported. 
For example, if you have "client" and "server" submodules and someone 
makes a protocol change, you don't want some unwitting developer to pull 
just half of the change and end up with incompatible code in the two 
submodules.

I have no problem with making the "only commit the supermodule" behavior 
the default and requiring a command-line option for the "commit 
everything" case, but I think "commit everything" is useful. And 
honestly IMO it should be the default since it'll behave in a less 
surprising way; when I do a "commit -a" I expect all my changes to be 
committed, whether they're in submodules or not.

