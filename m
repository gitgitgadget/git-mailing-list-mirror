From: Christopher Snapp <snappca@gmail.com>
Subject: Re: git svn project shuffle
Date: Wed, 13 Oct 2010 09:41:35 -0400
Message-ID: <AANLkTimxbmk2u=4d1b1LS+GMp9ry__4TtEx5UMJPk4-5@mail.gmail.com>
References: <AANLkTimL18WHOrLjA5iWNcsgd6H8Eeq19LfJNjkKu_b-@mail.gmail.com>
	<20101004185424.GA6343@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 13 15:41:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P61aT-0003d2-2y
	for gcvg-git-2@lo.gmane.org; Wed, 13 Oct 2010 15:41:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752291Ab0JMNli convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Oct 2010 09:41:38 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:41361 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751896Ab0JMNlh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Oct 2010 09:41:37 -0400
Received: by iwn41 with SMTP id 41so209597iwn.19
        for <git@vger.kernel.org>; Wed, 13 Oct 2010 06:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Ig2dOdbhBrt+EKQkrPTQ0Wi+WIxtzi5r9lZWs2OZUWc=;
        b=OgMBhtOVrcwQMkfoKDjBWuAQNrFpsa/ydUPrrXaFnT6btPrVjbMQ1AmT+zw/t/5sfj
         yZ8u0xieCB9BaUIggGtpqVQeUAGndAZNoqQ5TkTm68dl4o8k3clDnYt1bTCOdT2JB5uB
         Q47TdXRI2odGDAg0Mgu3gwR1GPKvH1BrEeMLc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=qhnl73FPypXrEyZo5Z10FyQNBNQG3ganFQIKYfND7rpzBIQA8o+I99hpiFFtjO//7t
         vRmfSF5y+N4Ok7WSnKqq2+mt6uCR3p/zG1YpWXD8yiEm5+WZKUqSeOTNo+NDVGZ0hYtM
         9Ud7VHjbVufN7TvubMG+eAmKc0wjnXkMVxOB8=
Received: by 10.231.31.6 with SMTP id w6mr4149934ibc.64.1286977296802; Wed, 13
 Oct 2010 06:41:36 -0700 (PDT)
Received: by 10.231.11.137 with HTTP; Wed, 13 Oct 2010 06:41:35 -0700 (PDT)
In-Reply-To: <20101004185424.GA6343@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158935>

Jonathan,

=46irst off, thanks very much for the quick and thorough response.

Sadly, this is outside the norm for me and I'm just not understanding
all the steps.  As a result I've successfully mangled my poor git
repo. Good thing I followed step 0. :)

I'll continue to read up on some of the steps you listed to try and
figure out where I went wrong, but I'm wondering if there might be an
easier way to get back to a stable repo.  The alternative I'd like to
try is to simply clone the new svn location.  What I'm not
understanding is why git will not traverse the svn history properly.
If you remember my old project's trunk has been copied to a
subdirectory of the new project's trunk.  So, oldproj/trunk is now
newproj/trunk/oldproj.  When I do a git svn clone of the newproj I
would expect it to follow the svn copy that created
newproj/trunk/oldproj but it doesn't.  I'm simply left with a couple
of commits and none of the original oldproj history.  If I view the
svn repo using some other tool (e.g. kdesvn) I can see all the history
as expected.  I'm not coming up with anything in my searches that
would give me a reason why git would stop searching history.

Thanks again for the help,




On Mon, Oct 4, 2010 at 2:54 PM, Jonathan Nieder <jrnieder@gmail.com> wr=
ote:
> Hi Chris,
>
> Christopher Snapp wrote:
>
>> # If I try to start from scratch by using git svn clone --stdlayout
>> the "newproj" location I lose all of the revision history associated
>> with "oldproj/trunk" that has been copied to newproj/trunk/oldproj.
>> How can I have git understand the history for the
>> newproj/trunk/oldproj location?
>
> If I were in your situation I would do the following:
>
> =A00. Make backups!
> =A01. git svn init -Rnew ...newproj info...
> =A02. Edit .git/config to put the new project in a separate
> =A0 =A0 refs/remotes/newproj/ hierarchy.
> =A03. git svn -Rnew fetch
> =A04. gitk --all. =A0Look around.
> =A05. For each "tip" of the old history:
> =A0 =A0 git replace <corresponding new commit> <old branch tip>
> =A06. gitk --all. =A0Make sure it looks right.
> =A07. git filter-branch -- --all
> =A08. rm -fr .git/svn. =A0This is destructive, but only of informatio=
n
> =A0 =A0you're probably not using. =A0(It forgets old properties, for
> =A0 =A0example.)
> =A09. Edit .git/config and use "git branch -r -d" to get rid of refer=
ences
> =A0 =A0to oldproj. =A0Rename the newproj svn-remote to "svn" again.
> 10. git svn fetch.
> 11. gitk --all. =A0Everything good? =A0Push.
>
>> # An alternative would be if I could somehow reconfigure my already
>> checked out oldproj git repo so I retain all of the version history
>> and my local branches and can move forward checking code into the
>> newproj/trunk/oldproj location?
>
> If your history in each branch is not published and is linear, you
> could also try just putting the old and new histories in one temporar=
y
> repo and rebasing your private branches.
>
> Or you can export your own work with "git format-patch" or "git
> fast-export" and reimport it with "git am" or "git fast-import".
>
> Hope that helps,
> Jonathan
>



--=20
Chris
