From: "=?ISO-8859-1?Q?Erik_B=E5gfors?=" <zindar@gmail.com>
Subject: Re: VCS comparison table
Date: Sun, 22 Oct 2006 11:56:32 +0200
Message-ID: <845b6e870610220256u39d3d06wefd4f71851670812@mail.gmail.com>
References: <Pine.LNX.4.64.0610172014250.3962@g5.osdl.org>
	<453A7D7E.8060105@utoronto.ca>
	<20061022074513.GF29927@artax.karlin.mff.cuni.cz>
	<200610221105.26421.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Cc: bazaar-ng@lists.canonical.com, Linus Torvalds <torvalds@osdl.org>,
	Andreas Ericsson <ae@op5.se>, Carl Worth <cworth@cworth.org>,
	Jan Hudec <bulb@ucw.cz>, git@vger.kernel.org
X-From: bazaar-ng-bounces@lists.canonical.com Sun Oct 22 12:07:22 2006
Return-path: <bazaar-ng-bounces@lists.canonical.com>
Envelope-to: gcvbg-bazaar-ng@m.gmane.org
Received: from esperanza.ubuntu.com ([82.211.81.173])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbaEk-0001se-2O
	for gcvbg-bazaar-ng@m.gmane.org; Sun, 22 Oct 2006 12:07:22 +0200
Received: from localhost ([127.0.0.1] helo=esperanza.ubuntu.com)
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <bazaar-ng-bounces@lists.canonical.com>)
	id 1GbaE5-0004dr-Dv; Sun, 22 Oct 2006 11:06:42 +0100
Received: from py-out-1112.google.com ([64.233.166.181])
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <zindar@gmail.com>) id 1GbaDq-0004d0-GN
	for bazaar-ng@lists.canonical.com; Sun, 22 Oct 2006 11:06:26 +0100
Received: by py-out-1112.google.com with SMTP id f25so126114pyf
	for <bazaar-ng@lists.canonical.com>;
	Sun, 22 Oct 2006 03:06:25 -0700 (PDT)
Received: by 10.35.9.15 with SMTP id m15mr4370888pyi;
	Sun, 22 Oct 2006 02:56:32 -0700 (PDT)
Received: by 10.35.116.4 with HTTP; Sun, 22 Oct 2006 02:56:31 -0700 (PDT)
To: "Jakub Narebski" <jnareb@gmail.com>
In-Reply-To: <200610221105.26421.jnareb@gmail.com>
Content-Disposition: inline
X-BeenThere: bazaar-ng@lists.canonical.com
X-Mailman-Version: 2.1.8
Precedence: list
List-Id: bazaar-ng discussion <bazaar-ng.lists.canonical.com>
List-Unsubscribe: <https://lists.ubuntu.com/mailman/listinfo/bazaar-ng>,
	<mailto:bazaar-ng-request@lists.canonical.com?subject=unsubscribe>
List-Archive: <https://lists.ubuntu.com/archives/bazaar-ng>
List-Post: <mailto:bazaar-ng@lists.canonical.com>
List-Help: <mailto:bazaar-ng-request@lists.canonical.com?subject=help>
List-Subscribe: <https://lists.ubuntu.com/mailman/listinfo/bazaar-ng>,
	<mailto:bazaar-ng-request@lists.canonical.com?subject=subscribe>
Sender: bazaar-ng-bounces@lists.canonical.com
Errors-To: bazaar-ng-bounces@lists.canonical.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29715>

> For example git encourages using many short and longer-lived feature
> branches; I don't see bzr encouraging this workflow.

Why not? I think it really does.  And due to the fact that merges are
merges and will show up as such, I think it's very suitable for
feature branches.

In fact, in the bzr development of bzr itself.  All commits are done
in feature branches and then merged into bzr.dev (the main "trunk" of
bzr) when they are considered stable.

Consider the following
bzr branch mainline featureA
cd featureA
hack hack; bzr commit -m 'f1'; hack hack bzr commit -m f2; etc
No I want to merge in mainline again
bzr merge ../mainline; bzr commit -m merge
hack hack; bzr commit -m f3; hack hack bzr commit -m f4; etc

right now, I would have something line this in the branch log
-----------------------------------------------------------------
committer: Erik B=E5gfors <erik@bagfors.nu>
branch nick: featureA
message:
   f4
-----------------------------------------------------------------
committer: Erik B=E5gfors <erik@bagfors.nu>
branch nick: featureA
message:
   f3
----------------------------------------------------------------
committer: Erik B=E5gfors <erik@bagfors.nu>
branch nick: featureA
message:
   merge
      -----------------------------------------------------------------
      committer: Foo Bar <foo@bar.com>
      branch nick: mainline
      message:
         something done in mainline
      -----------------------------------------------------------------
      committer: Foo Bar <foo@bar.com>
      branch nick: mainline
      message:
         something else done in mainline
-----------------------------------------------------------------
committer: Erik B=E5gfors <erik@bagfors.nu>
branch nick: featureA
message:
   f2
-----------------------------------------------------------------
committer: Erik B=E5gfors <erik@bagfors.nu>
branch nick: featureA
message:
   f1

In this view,I can easily see what was part of this feature branch,
because the committs that belongs to the feature branch are not
indented, and they have a "branch nick" of "featureA".  I can also
easily see what comes from other branches.

I can also run bzr log with --line or --short which shows you only the
commits made in this branch and not the once that are merged in.  So
with --line I would get something line
Erik B=E5gfors 2006-10-19 f4
Erik B=E5gfors 2006-10-19 f3
Erik B=E5gfors 2006-10-19 merge
Erik B=E5gfors 2006-10-19 f2
Erik B=E5gfors 2006-10-19 f1

Which will give me a good view of what has been done in this feature
branch only.

If I understand it correctly, in git, you don't really know what has
been committed as part of this branch/repo, and what has been
committed in another branch/repo (this is my understanding from
reading this thread, I might be wrong, feel free to correct me again
:) )

/Erik
--=20
google talk/jabber. zindar@gmail.com
SIP-phones: sip:erik_bagfors@gizmoproject.com
sip:17476714687@proxy01.sipphone.com
