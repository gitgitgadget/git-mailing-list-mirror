X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: Re: Cleaning up git user-interface warts
Date: Fri, 17 Nov 2006 01:27:53 +0100
Message-ID: <455D0209.7070608@xs4all.nl>
References: <87k61yt1x2.wl%cworth@cworth.org> <455A1137.8030301@shadowen.org>	<87hcx1u934.wl%cworth@cworth.org>	<Pine.LNX.4.64.0611141518590.2591@xanadu.home>	<87bqn9u43s.wl%cworth@cworth.org> <ejdcg5$4fl$1@sea.gmane.org>	<Pine.LNX.4.64.0611141633430.2591@xanadu.home>	<7vbqn9y6w6.fsf@assigned-by-dhcp.cox.net>	<Pine.LNX.4.64.0611142007010.2591@xanadu.home>	<7v3b8ltq7r.fsf@assigned-by-dhcp.cox.net>	<Pine.LNX.4.64.0611142306090.2591@xanadu.home>	<Pine.LNX.4.64.0611150950170.3349@woody.osdl.org>	<455BBCE9.4050503@xs4all.nl>	<Pine.LNX.4.64.0611151908130.3349@woody.osdl.org>	<Pine.LNX.4.63.0611162353250.13772@wbgn013.biozentrum.uni-wuerzburg.de>	<Pine.LNX.4.64.0611161508530.3349@woody.osdl.org>	<455CFCBD.8040901@xs4all.nl> <7vmz6r2amf.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 17 Nov 2006 00:28:30 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
In-Reply-To: <7vmz6r2amf.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by XS4ALL Virus Scanner
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31643>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkraW-0000Df-1G for gcvg-git@gmane.org; Fri, 17 Nov
 2006 01:28:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1424807AbWKQA14 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 16 Nov 2006
 19:27:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424808AbWKQA14
 (ORCPT <rfc822;git-outgoing>); Thu, 16 Nov 2006 19:27:56 -0500
Received: from smtp-vbr11.xs4all.nl ([194.109.24.31]:54021 "EHLO
 smtp-vbr11.xs4all.nl") by vger.kernel.org with ESMTP id S1424807AbWKQA1z
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 16 Nov 2006 19:27:55 -0500
Received: from [192.168.123.187] (muurbloem.xs4all.nl [213.84.26.127])
 (authenticated bits=0) by smtp-vbr11.xs4all.nl (8.13.8/8.13.8) with ESMTP id
 kAH0RnLf007838; Fri, 17 Nov 2006 01:27:49 +0100 (CET) (envelope-from
 hanwen@xs4all.nl)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano escreveu:
> Han-Wen Nienhuys <hanwen@xs4all.nl> writes:
> 
>>  - clone but not a put-clone,
> 
> What's put-clone?  Care to explain?

put clone would be the putative inverse of clone, ie. make a clone of
a local repository on a remote server.

>>  - pull = merge + fetch, but no command for merge + throw
> 
> What's merge+throw?  Care to explain?

throw is the hypothetical opposite of fetch. I agree that this is
academical, because it's logical to only allow fast-forwards for
sending revisions.

>>  - clone for getting all branches of a repo, but no command for
>>    updating all branches of a repo.  
> 
> This one I can understand, but how would you propose to "update
> all branches", in other words what's your design for mapping
> remote branch names to local branch namespaces?
> 
> It would be nice if the design does not straightjacket different
> repository layouts different people seem to like, but I think it
> would be Ok to limit ourselves only to support the straight
> one-to-one mapping and support only separate-remote layout.

I think the whole clone design is a bit broken, in that the "master"
branch gets renamed or copied to "origin", but all of the other
branches remain unchanged in their names.

It's more logical for clone to either

 * leave all names unchanged

 * put all remote branches into a subdirectory.  This would also make
   it easier to track branches from multiple servers.

   At present,  I have in my build-daemon the following branches,

	cvs-head-repo.or.cz-lilypond.git
	hanwen-repo.or.cz-lilypond.git
	hwn-jcn-repo.or.cz-lilypond.git
	lilypond_1_0-repo.or.cz-lilypond.git
	lilypond_1_2-repo.or.cz-lilypond.git
	lilypond_1_4-repo.or.cz-lilypond.git
	lilypond_1_6-repo.or.cz-lilypond.git
	lilypond_1_8-repo.or.cz-lilypond.git
	lilypond_2_0-repo.or.cz-lilypond.git
	lilypond_2_2-repo.or.cz-lilypond.git
	lilypond_2_3_2b-repo.or.cz-lilypond.git
	lilypond_2_3_5b-repo.or.cz-lilypond.git
	lilypond_2_4-repo.or.cz-lilypond.git
	lilypond_2_6-repo.or.cz-lilypond.git
	lilypond_2_8-repo.or.cz-lilypond.git
	master-git.sv.gnu.org-lilypond.git
	master-hanwen
	master-repo.or.cz-lilypond.git
	origin-repo.or.cz-lilypond.git
	stable
	stable-2.10
	stable--2.10-git.sv.gnu.org-lilypond.git

  It would solve lots of problems for me if cloning and fetching would
  put branches into a subdirectory, ie.

    git clone git://repo.or.cz/lilypond.git

  leads to branches

    repo.or.cz/lilypond_2_8
    repo.or.cz/lilypond_2_6
    repo.or.cz/lilypond_2_4
    repo.or.cz/master
     (etc..)

	
-- 
