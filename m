X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Stephan Feder <sf@b-i-t.de>
Subject: Re: [RFC] Submodules in GIT
Date: Fri, 01 Dec 2006 15:23:07 +0100
Message-ID: <45703ACB.6050007@b-i-t.de>
References: <20061121223130.GA24909@nan92-1-81-57-214-146.fbx.proxad.net> <200611281335.38728.andyparkins@gmail.com> <20061129160355.GF18810@admingilde.org> <200611292000.23778.andyparkins@gmail.com> <20061130170625.GH18810@admingilde.org> <456F29A2.1050205@op5.se> <45701A24.5060500@b-i-t.de> <20061201121110.GP18810@admingilde.org> <45702C50.9050307@b-i-t.de> <20061201134311.GV18810@admingilde.org>
Reply-To: sf@b-i-t.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Fri, 1 Dec 2006 14:24:07 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.8 (X11/20061110)
In-Reply-To: <20061201134311.GV18810@admingilde.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32928>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gq9IO-00013E-Iw for gcvg-git@gmane.org; Fri, 01 Dec
 2006 15:23:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758996AbWLAOXR convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006 09:23:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759157AbWLAOXR
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 09:23:17 -0500
Received: from mail.medianet-world.de ([213.157.0.167]:9641 "HELO
 mail.medianet-world.de") by vger.kernel.org with SMTP id S1758996AbWLAOXQ
 convert rfc822-to-8bit (ORCPT <rfc822;git@vger.kernel.org>); Fri, 1 Dec 2006
 09:23:16 -0500
Received: (qmail 28969 invoked by uid 1011); 1 Dec 2006 14:23:14 -0000
Received: from sf@b-i-t.de by mail1 by uid 1003 with qmail-scanner-1.22 
 (ExcuBAtor: 1.0.2.  Clear:RC:1(213.157.15.184):SA:0(0.0/5.0):.  Processed in
 0.233476 secs); 01 Dec 2006 14:23:14 -0000
Received: from unknown (HELO IP-213157000067.dialin.heagmedianet.de)
 (213.157.15.184) by mail.medianet-world.de with SMTP; 1 Dec 2006 14:23:14
 -0000
Received: from [192.168.168.40] (groa.b-i-t.de [192.168.168.40]) by
 mail.b-i-t.de (Postfix) with ESMTP id E97C9256C0; Fri,  1 Dec 2006 15:23:08
 +0100 (CET)
To: Martin Waitz <tali@admingilde.org>
Sender: git-owner@vger.kernel.org

Martin Waitz wrote:
> hoi :)
>=20
> On Fri, Dec 01, 2006 at 02:21:20PM +0100, sf wrote:
>> I just had a short (really short) look at your work. My impression i=
s=20
>> that your repository setup is much too complicated.
>=20
> Well, I'm not really satisfied with the UI part.
> What exactly do you find complicated?

I am not talking about the UI. On the contrary, I am talking about the=20
repository, i.e. the directories and files on your disk and their=20
contents. You add a lot of additional information to the repository tha=
t=20
is not needed at all.

>> As I proposed elsewhere: For submodules to work you only need to all=
ow=20
>> commits in tree objects (that is what your implementation requires a=
s=20
>> well). Everything else is in the tools. Much simpler.
>=20
> I do not quite get your point.
> The core of my work allows to put commits into tree objects.

That is fine.

> Then there is some more (but not quite finished) work to make the too=
ls
> work together with submodules.  So no, not everything is there yet.

And what is already there is a lot of meta information (see above). You=
=20
do not need that.

=46or example, in the index, if it is a commit (i.e. a subproject), sto=
re=20
the commit id (not the commit's tree id ). Make the tools handle this=20
case (as yet, all code expects only trees and blobs when they parse=20
trees). Especially, extend update-index to be able to store a commit=20
instead of the tree.

Or else, do not change what is recorded in the index. Then, at commit=20
time, you not only commit the superproject but also all subprojects.

Or allow both.

Anyway, you can create commits in tree objects. See, you did not need t=
o=20
  store any additional information in the repository.

To push and pull you have to extend the tools as well. That is the next=
=20
step.

Regards

Stephan

--=20
b.i.t.
beratungsgesellschaft f=FCr informations-technologie mbh
Stephan Feder
elisabethenstr. 62   fon: +49(0)6151/827575
64283 darmstadt      fax: +49(0)6151/827576
mailto:sf@b-i-t.de   www: http://www.b-i-t.de
