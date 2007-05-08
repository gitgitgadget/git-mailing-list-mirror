From: Seth Falcon <sethfalcon@gmail.com>
Subject: Re: git-svn: importing branches later
Date: Tue, 08 May 2007 07:51:10 -0700
Message-ID: <m2odkv2wtd.fsf@ziti.local>
References: <20070507190702.GE342@ginosko.local>
	<20070508085149.GB24409@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 08 16:51:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlR28-00039e-Rx
	for gcvg-git@gmane.org; Tue, 08 May 2007 16:51:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967913AbXEHOvQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 8 May 2007 10:51:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968005AbXEHOvQ
	(ORCPT <rfc822;git-outgoing>); Tue, 8 May 2007 10:51:16 -0400
Received: from wx-out-0506.google.com ([66.249.82.233]:27825 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967913AbXEHOvP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 May 2007 10:51:15 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1748253wxd
        for <git@vger.kernel.org>; Tue, 08 May 2007 07:51:14 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:to:subject:references:from:date:in-reply-to:message-id:user-agent:mime-version:content-type:content-transfer-encoding;
        b=pN5Z+lUfMLWqS62M3BqIrtIIWbJvcfjH3YFhFKMj32M2Fb3LuHqIml3Rbf6S0fHNXNbEdzTvCMphMNvalfsbIDr+picaXbFtrmIcxvclBSE/kkT5wc9P3aczBQAGA+NWHiSilaqireOwKhLtlxciczNz3QGqYRblxqfL8xdZD3I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:to:subject:references:from:date:in-reply-to:message-id:user-agent:mime-version:content-type:content-transfer-encoding;
        b=tpXL1/yRjh91WyCHdYwGZ6GDNMRkbgsnCshZ+XnjlZIRImR1eKIOVs0ZrUsSs9tuDbXAQqYwJGhBCeVWr+lbRXE4+rUZUsG6rtrNTxyaf5lGfTqkkfP0DhR4Su1O06lqUs53Kyysy7F9R7B88b2vj3oZwu8EJ35GnG1+hWiX1/I=
Received: by 10.90.90.3 with SMTP id n3mr6287370agb.1178635873882;
        Tue, 08 May 2007 07:51:13 -0700 (PDT)
Received: from ziti.local ( [24.19.44.95])
        by mx.google.com with ESMTP id 3sm8033411wrh.2007.05.08.07.51.12;
        Tue, 08 May 2007 07:51:12 -0700 (PDT)
In-Reply-To: <20070508085149.GB24409@diana.vm.bytemark.co.uk> (Karl
 =?iso-8859-1?Q?Hasselstr=F6m's?= message of "Tue, 8 May 2007 10:51:49
 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (darwin)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46581>

Karl Hasselstr=F6m <kha@treskal.com> writes:

> On 2007-05-07 13:07:06 -0600, Michael Hendricks wrote:
>
>> Now I want to import the 'foo' branch from the same SVN repo without
>> grabbing all the branches. Any suggestions?
>
> I seem to recall that just adding another "fetch" line to the git-svn
> configuration in .git/config will do this for you.

Yes, this should work.  As long as you started out with a fairly
recent git (sorry, I don't know how recent is needed) you should have
in your repository a git/config file containing something like:

    [svn-remote "svn"]
    	url =3D http://main.svn.url.com/
    	fetch =3D trunk:refs/remotes/git-svn
    	fetch =3D branches/b1:refs/remotes/b1  <-- this line added by you

Then a 'git svn fetch' should pull it all down and you can checkout
the branch using 'git checkout -b myb1 remotes/b1'.  At this point,
'git svn rebase' is smart enough to know where the branch comes from.

What may not work when you add branches in this way is that the
history may not connect with the actual branch commit in svn.  I'm
fairly sure there is some way to fix that, but I haven't done it.

+ seth
