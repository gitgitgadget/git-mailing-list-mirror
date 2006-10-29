X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: master and origin
Date: Sun, 29 Oct 2006 22:19:21 +0100
Message-ID: <200610292219.21823.jnareb@gmail.com>
References: <4d8e3fd30610291253s2d8000dfx942e0fa20e0057f6@mail.gmail.com> <ei34qd$emn$1@sea.gmane.org> <4d8e3fd30610291307v24f5aab8l3f447a1bfdf86ab4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 29 Oct 2006 21:19:40 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=QQsKvznfKNSgMnFFEo1cNwg2ezbuVtO/3z9w+HhxLm64U8dr+Atkfjwb6fazRxZL/xBFM29PArJCPcdFtaF7R/uyXicMXnA2iIv+h34N7FG251N8y/dwsf9QHrlBa8fZYo+Lbww7vO8LDrkyPSKkoPB8kH9k0KfGwu+IAGPUG8Q=
User-Agent: KMail/1.9.3
In-Reply-To: <4d8e3fd30610291307v24f5aab8l3f447a1bfdf86ab4@mail.gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30462>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GeI44-0007xB-Ot for gcvg-git@gmane.org; Sun, 29 Oct
 2006 22:19:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030238AbWJ2VT3 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 29 Oct 2006
 16:19:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030322AbWJ2VT3
 (ORCPT <rfc822;git-outgoing>); Sun, 29 Oct 2006 16:19:29 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:52143 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1030238AbWJ2VT2
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 29 Oct 2006 16:19:28 -0500
Received: by ug-out-1314.google.com with SMTP id 32so1014186ugm for
 <git@vger.kernel.org>; Sun, 29 Oct 2006 13:19:27 -0800 (PST)
Received: by 10.67.121.15 with SMTP id y15mr3050880ugm; Sun, 29 Oct 2006
 13:19:27 -0800 (PST)
Received: from host-81-190-18-116.torun.mm.pl ( [81.190.18.116]) by
 mx.google.com with ESMTP id k2sm2094225ugf.2006.10.29.13.19.26; Sun, 29 Oct
 2006 13:19:26 -0800 (PST)
To: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
Sender: git-owner@vger.kernel.org

Paolo Ciarrocchi wrote:
> On 10/29/06, Jakub Narebski <jnareb@gmail.com> wrote:
>> Paolo Ciarrocchi wrote:
>>
>>> I went trough the docs I found on the web but I still don't fully
>>> understand why if I clone a remote repository my local copy has two
>>> branches, origin (that is always a exact copy of the remote
>>> repository) and master which is... what? The branch supposed to be
>>> used for local development?
>>>
>>> I'm used to just checkout to a new branch, do my own development and
>>> then diff against origin so I'm missing why I see the master branch.
[...]
>> If you don't do your development on 'master', but use other branches,
>> the 'master'/'origin' is unnecessary; you could fetch 'master' into
>> 'master'...
>>
>> By the way, if you clone with --use-separate-remote you would get
>> separate namespace for tracking branches; additionally they would
>> be treated read-only (can't commit to).
> 
> There is still one thing I don't understand, if I pull the git or
> kernel repository all the local branches are updated according to the
> remote branches, right? If I'm hacking on master what will happen to
> my local changes?

With the default setup (git clone without --use-separate-remote), then
all local branches are updated according to remote branches... with the
exception of remote 'master' branch which updates local 'origin' branch.
pull = fetch + merge, so if you pull when you are on your local 'master'
branch (and 'master' branch is first in the .git/remotes/origin file I think)
you would fetch remote 'master' into local 'origin' and merge what you
have in 'origin' into your 'master' (or merge remote 'master' into
your local 'master' if you want to think like that).

If you have uncommitted changes git would probably refuse the merge.
If you made changes to one of the tracking branches (e.g. 'next' or
'origin'), git would refuse to fetch into this branch (unless forced).

HTH
-- 
Jakub Narebski
