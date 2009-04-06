From: Reece Dunn <msclrhd@googlemail.com>
Subject: Re: Running 'git pull' from an unnamed branch
Date: Mon, 6 Apr 2009 08:42:16 +0100
Message-ID: <3f4fd2640904060042m438a3a8en2d2746a6216b2b95@mail.gmail.com>
References: <3f4fd2640904051433u199587c3wc9bf080d138944e7@mail.gmail.com>
	 <7v3acmoalw.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 06 09:43:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqjUn-0006su-5Z
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 09:43:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754421AbZDFHmV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Apr 2009 03:42:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754414AbZDFHmU
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 03:42:20 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:51903 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753662AbZDFHmU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Apr 2009 03:42:20 -0400
Received: by fxm2 with SMTP id 2so1742399fxm.37
        for <git@vger.kernel.org>; Mon, 06 Apr 2009 00:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=A5Kp7ETSGnwUTuhJSCc0TY1mByjQBfcIVEMYB89X094=;
        b=V6WHYsrw9vp3qvmrSUOtBdxdxbwxF492rm1gaEB7hOAESGgzsfu7TcbjWlSVkNPqSG
         QEc5J31xIuG5UICF2Ew17hsvvZ5JnIQ8XRera3FtAxl9gs/9B7mJGmOD8H7o3c3qoO3Z
         6W24jbaNuVb9JzEjj2c6B+w83sCobF6i1WFhI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=le4QOw+F7sUv/bqtclp+Q01c9W7sTM246U0Lhm+/S/rINYcri7p5QlCsQX1wGaarAr
         FD8fSnVglX18M5+WGMECAzmmMvMxSe7RgrXHEgsXF/wM9VEbhh8L606ZdDIUUpP6/qkE
         CoD5akscQWMVg52ElLyihQDS1wZhGtxEANr+A=
Received: by 10.239.136.134 with SMTP id h6mr89999hbh.71.1239003736607; Mon, 
	06 Apr 2009 00:42:16 -0700 (PDT)
In-Reply-To: <7v3acmoalw.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115773>

2009/4/6 Junio C Hamano <gitster@pobox.com>:
> Reece Dunn <msclrhd@googlemail.com> writes:
>
>> diff --git a/git-pull.sh b/git-pull.sh
>> index 8a26763..00a72dd 100755
>> --- a/git-pull.sh
>> +++ b/git-pull.sh
>> @@ -97,6 +97,10 @@ error_on_no_merge_candidates () {
>> =A0 =A0 =A0 echo "try again (e.g. 'git pull <repository> <refspec>')=
=2E"
>> =A0 =A0 =A0 echo "See git-pull(1) for details on the refspec."
>> =A0 =A0 =A0 echo
>> + =A0 =A0 echo "You may not be on a branch. In this case, you need t=
o move"
>> + =A0 =A0 echo "onto the branch you want to pull to (usually master)=
:"
>> + =A0 =A0 echo " =A0 =A0git checkout <branch>"
>> + =A0 =A0 echo
>
> I do not think that is necessarily what the user wanted to hear. =A0O=
ften I
> create trial merges on a detached HEAD when I hear a pull-request fro=
m
> others (I have a few work trees that share the repository with my pri=
mary
> working area, made with contrib/workdir/git-new-workdir script, and t=
heir
> HEAD are typically detached at the tip of the master), and in such a =
use
> case, the first line of the instruction in the context in your patch =
is
> the right thing to give. =A0I do not want to have the resulting trial=
 merge
> anywhere on my real branches, and do not want to be told to switch to=
 any
> of them.
>
> We really should teach people, especially the new ones early on, that=
 "git
> push" and "git pull" are meant to be told where-to/from and what, and=
 how
> to drive these commands with explicit arguments, before letting them =
rely
> on the default configuration blindly without understanding the underl=
ying
> concepts.

Ok, so how about something like:

"You may not be on a branch. Because of this, you need to specify
where you are pulling from and to. See git-pull(1) for how to do this.
Alternatively, you can move to a named branch using:
    git checkout <branch>"

> The automation given by the configuration variables is certainly nice=
, and
> the default created by "clone", "remote add" and "checkout -b" (with =
its
> implicit "track") may make them simpler to operate for every day life=
, but
> there is a limit. =A0Working on a detached HEAD is an ultimate free-f=
orm
> hacking, and you do not even necessarily _want_ to have a "while my H=
EAD
> is detached, please always do this" default configured.

How about the above wording? I have kept the moving to a named branch,
but have made it optional and secondary to using git pull with
arguments. This supports the workflow you and others have described,
while retaining the hint for when you don't want to work on a detached
HEAD - for example, after running bisect - without saying that the
latter is required.

- Reece
