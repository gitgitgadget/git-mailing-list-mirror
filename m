X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [RFC] Submodules in GIT
Date: Thu, 30 Nov 2006 14:49:53 +0000
Message-ID: <200611301449.55171.andyparkins@gmail.com>
References: <20061121223130.GA24909@nan92-1-81-57-214-146.fbx.proxad.net> <200611301255.41733.andyparkins@gmail.com> <456EE3F1.5070101@b-i-t.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 30 Nov 2006 14:50:16 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Nt6hvIYFyDIPoM8HlNokg8WKfjLIWsHlTGgFVUzMy2SanNaXNgn0caA+WclcSZM7vl3AYSOpIMLqOEc4ewY5lIfWAl2TJFbjky49w4+G4f67NwcBWPuwEMOkCzRoVJ6VWENiVGbHmPOFRonnshiW3exvQEtG2seijKjwhmKb7Ao=
User-Agent: KMail/1.9.5
In-Reply-To: <456EE3F1.5070101@b-i-t.de>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32749>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpnEo-00014c-Em for gcvg-git@gmane.org; Thu, 30 Nov
 2006 15:50:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S936432AbWK3OuF (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 30 Nov 2006
 09:50:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936434AbWK3OuF
 (ORCPT <rfc822;git-outgoing>); Thu, 30 Nov 2006 09:50:05 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:59026 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S936432AbWK3OuB
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 30 Nov 2006 09:50:01 -0500
Received: by ug-out-1314.google.com with SMTP id 44so2132878uga for
 <git@vger.kernel.org>; Thu, 30 Nov 2006 06:50:00 -0800 (PST)
Received: by 10.67.19.20 with SMTP id w20mr5487130ugi.1164898199111; Thu, 30
 Nov 2006 06:49:59 -0800 (PST)
Received: from dvr.360vision.com ( [194.70.53.227]) by mx.google.com with
 ESMTP id j34sm22591828ugc.2006.11.30.06.49.58; Thu, 30 Nov 2006 06:49:58
 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Thursday 2006 November 30 14:00, Stephan Feder wrote:

> Again I do not see the problem. Probably I have a much simpler picture
> of submodules: They are just commits in the supermodule's tree.
> Everything else follows naturally from how git currently behaves.

How are these commits any different from just having one big repository?  If 
some of the development of the submodule is contained in the supermodule then 
it's not a submodule anymore.

Why bother with all the effort to make a separation between submodule and 
supermodule and then store the submodule commits in the supermodule.  That's 
not supermodule/submodule git - that's just normal git.

Surely the whole point of having submodule's is so that you can take the 
submodule away.  Let me give you an example.  Let's say I have a project that 
uses the libxcb library (some random project out in the world that uses git).  
I've arranged it something like this:

myproject (git root)
 |----- src
 |----- doc
 `----- libxcb (git root)

This works fine; with one problem.  When I make a commit in myproject, there 
is no link into the particular snapshot of the libxcb that I used at that 
moment.  If libxcb moves on, and makes incompatible changes, then when I 
checkout an old version of myproject, it won't compile any more because I'll 
need to find out which commit of libxcb I used at the time.

Submodules will solve this problem.  In the future I'll be able to check out 
any commit of myproject and it will automatically checkout the right commit 
from the libxcb repository.  Now let's say I'm working away and find a bug in 
libxcb; I fix it, commit it.  That change had better be stored in the libxcb 
repository, and had better make no reference to the myproject repository.  If 
it doesn't, I'm going to have to pollute the libxcb upstream repository with 
myproject if I want to share those fixes.



Andy
-- 
Dr Andy Parkins, M Eng (hons), MIEE
