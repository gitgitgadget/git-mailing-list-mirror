From: Andrew Sayers <andrew-git@pileofstuff.org>
Subject: Re: Approaches to SVN to Git conversion
Date: Wed, 07 Mar 2012 20:28:58 +0000
Message-ID: <4F57C50A.9010701@pileofstuff.org>
References: <4F536FE9.1050000@pileofstuff.org>	<3c2ab05e-b2af-4df4-bca6-ff5512b0c73e@mail> <CA+7g9Jwb=7wH7R3=ShhOGMdHXWmq4ZahocpaEuJdf+yBfCpA8A@mail.gmail.com> <4F5690FB.9060800@pileofstuff.org> <4F5780F0.5080901@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nathan Gray <n8gray@n8gray.org>, Stephen Bash <bash@genarts.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	David Barr <davidbarr@google.com>
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Wed Mar 07 21:29:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5NTy-0001FU-Vv
	for gcvg-git-2@plane.gmane.org; Wed, 07 Mar 2012 21:29:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759236Ab2CGU3G convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Mar 2012 15:29:06 -0500
Received: from mtaout02-winn.ispmail.ntl.com ([81.103.221.48]:56450 "EHLO
	mtaout02-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757021Ab2CGU3E (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Mar 2012 15:29:04 -0500
Received: from aamtaout02-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout02-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20120307202901.MTHR15590.mtaout02-winn.ispmail.ntl.com@aamtaout02-winn.ispmail.ntl.com>;
          Wed, 7 Mar 2012 20:29:01 +0000
Received: from [192.168.0.2] (really [94.170.150.126])
          by aamtaout02-winn.ispmail.ntl.com
          (InterMail vG.3.00.04.00 201-2196-133-20080908) with ESMTP
          id <20120307202901.YUIN5924.aamtaout02-winn.ispmail.ntl.com@[192.168.0.2]>;
          Wed, 7 Mar 2012 20:29:01 +0000
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.27) Gecko/20120216 Thunderbird/3.1.19
In-Reply-To: <4F5780F0.5080901@vilain.net>
X-Cloudmark-Analysis: v=1.1 cv=JvdXmxIgLJv2/GthKqHpGJEEHukvLcvELVXUanXFreg= c=1 sm=0 a=pFZ1vDXyzkQA:10 a=UeB0h7Mj1QQA:10 a=u4BGzq-dJbcA:10 a=N659UExz7-8A:10 a=NEAV23lmAAAA:8 a=lvtlyp7X3b1RfcloIewA:9 a=X7QdCYDF5kwUiJDcVxEA:7 a=pILNOxqGKmIA:10 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192479>

On 07/03/12 15:38, Sam Vilain wrote:
> On 3/6/12 2:34 PM, Andrew Sayers wrote:
>> I've now added a bit of documentation and uploaded my code to github=
:
>> https://github.com/andrew-sayers/Proof-of-concept-History-Converter
>>
>> I haven't attached it here because the code isn't at a stage where i=
t
>> would be useful to review line-by-line.  Comments are welcome if you
>> really want to though :)
>=20
> I just took a look at your readme=97did you consider writing the tool=
 to
> work against an svn-fe import, rather than using SVN::Dump? Do you th=
ink
> it could be adjusted to be like that?

I did consider writing svn-branch-export.pl against a branch created by
svn-fe, but right now it doesn't provide enough information to do a goo=
d
job (e.g. copyfrom properties).  I understand that support is in the
works, but this project is more about getting a scrappy end-to-end
solution so we can see what the issues are (is there any demand for
DVCS-neutral SVN history export?  What are the hard cases and how do yo=
u
represent them?).  I'm keen to make sure that documentation and tests
are done in such a way that a future git-based exporter could use them
without relying on any of the actual code.

I also considered writing git-branch-import.pl against the raw svn-fe
output.  As well as the technical issues with this approach, I felt lik=
e
these were better tackled as orthogonal problems.  Producing an accurat=
e
representation of the SVN history is a very different problem to
producing a user-friendly representation, and separating those concerns
seems like it will make life easier down the line.  For example, a
user-friendly representation might convert svn:ignore properties to
=2Egitignore files, but that would make bidirection hard to implement
without an accurate representation in the middle.

	- Andrew
