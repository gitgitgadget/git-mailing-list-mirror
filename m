X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Sam Vilain <sam@vilain.net>
Subject: Re: [RFC] Introduce "git stage" (along with some heresy)
Date: Sun, 03 Dec 2006 10:03:32 +1300
Message-ID: <4571EA24.4080907@vilain.net>
References: <87slfzfri7.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sat, 2 Dec 2006 21:03:52 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.4 (X11/20060615)
In-Reply-To: <87slfzfri7.wl%cworth@cworth.org>
X-Enigmail-Version: 0.94.0.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33050>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gqc1U-0004fv-0Z for gcvg-git@gmane.org; Sat, 02 Dec
 2006 22:03:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1162469AbWLBVDp (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 2 Dec 2006
 16:03:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162471AbWLBVDp
 (ORCPT <rfc822;git-outgoing>); Sat, 2 Dec 2006 16:03:45 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:65427 "EHLO
 magnus.utsl.gen.nz") by vger.kernel.org with ESMTP id S1162469AbWLBVDo (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 2 Dec 2006 16:03:44 -0500
Received: by magnus.utsl.gen.nz (Postfix, from userid 65534) id 8349E139B0D;
 Sun,  3 Dec 2006 10:03:42 +1300 (NZDT)
Received: from [127.0.0.1] (longdrop.magnus.utsl.gen.nz [192.168.253.12])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by magnus.utsl.gen.nz (Postfix) with ESMTP id
 8ECCF1380C2; Sun,  3 Dec 2006 10:03:36 +1300 (NZDT)
To: Carl Worth <cworth@cworth.org>
Sender: git-owner@vger.kernel.org

Carl Worth wrote:
> Change #2: Make a staged commit an explicit act
> ===============================================
> The "-a" stands out to me here as the only command-line option needed
> in the first list, and the only command in the second list that
> performs a staged operation by default. So change number to is to
> redefine "commit" to mean what "commit -a" meant before and to require
> a new command-line option for staged committing, (the best naming I
> have so far is "commit --staged" with a shortcut of "commit -i"---the
> mismatch of "'i' as short for --staged" is a bit unlovely I admit).

I wonder about backwards compatibility, but then another part of me says
that porcelain are probably using "git-commit-tree" anyway.

How about considering alternative words?  Like "git save" for this
higher level and more user friendly interface.

As another idea (brainstorming here), what about an "autocommit" approach?

  git rm       # removes files and asks for commit message
  git add      # ditto
  git commit   # updates and commits everything

  git stage    # starts a staged commit
  git add      # modifies staging area
  git rm       # ditto
  git stage filename # adds contents to staging area
  git commit   # saves staging area as commit

Then you could have "core.autocommit" as a repo-config option,
defaulting to off for "backwards compatibility".

> Change #3: Change "add" to not stage any content
> ================================================
> To finish off, I'd like to propose descriptions of the commands to
> allow the user to use the "without staging" commands as a complete set
> while being able to easily ignore any of the staging capabilities.
> This does trigger a need for a semantic change in the "add"
> command. Here are the proposed descriptions:

The "autocommit" concept may make this less of an issue.

