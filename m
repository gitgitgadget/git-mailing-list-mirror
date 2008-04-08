From: "D. Stuart Freeman" <stuart.freeman@et.gatech.edu>
Subject: Re: Migrating svn to git with heavy use of externals
Date: Tue, 08 Apr 2008 16:49:59 -0400
Message-ID: <47FBDA77.2050402@et.gatech.edu>
References: <47F15094.5050808@et.gatech.edu> <47FBB448.3060900@et.gatech.edu> <32541b130804081306q6e06af20u794357eba9d434e@mail.gmail.com>
Reply-To: stuart.freeman@et.gatech.edu
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040206040705080104060407"
Cc: git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 08 22:50:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjKmA-00068H-N3
	for gcvg-git-2@gmane.org; Tue, 08 Apr 2008 22:50:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753071AbYDHUt4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Apr 2008 16:49:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753283AbYDHUt4
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Apr 2008 16:49:56 -0400
Received: from deliverator3.ecc.gatech.edu ([130.207.185.173]:52015 "EHLO
	deliverator3.ecc.gatech.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752870AbYDHUtz (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Apr 2008 16:49:55 -0400
Received: from deliverator3.ecc.gatech.edu (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP id E9EE139C0DB;
	Tue,  8 Apr 2008 16:49:54 -0400 (EDT)
Received: from mailprx5.gatech.edu (mailprx5.prism.gatech.edu [130.207.171.19])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "smtp.mail.gatech.edu", Issuer "Equifax" (verified OK))
	by deliverator3.ecc.gatech.edu (Postfix) with ESMTP id 7079739C0F4;
	Tue,  8 Apr 2008 16:49:53 -0400 (EDT)
Received: from [130.207.46.56] (cetel-004-xx6.admin.gatech.edu [130.207.46.56])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	(sasl: method=PLAIN, username=dfreeman31@mailprx5.gatech.edu, sender=n/a)
	by mailprx5.gatech.edu (Postfix) with ESMTP
	id 3C76C1F7F; Tue,  8 Apr 2008 16:49:53 -0400 (EDT)
	(envelope-from stuart.freeman@et.gatech.edu)
User-Agent: Mozilla-Thunderbird 2.0.0.9 (X11/20080110)
In-Reply-To: <32541b130804081306q6e06af20u794357eba9d434e@mail.gmail.com>
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79030>

This is a multi-part message in MIME format.
--------------040206040705080104060407
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Avery Pennarun wrote:
> On Tue, Apr 8, 2008 at 2:07 PM, D. Stuart Freeman
> <stuart.freeman@et.gatech.edu> wrote:
>> Maybe I should clarify.
>>  I've imported an svn managed project into a git repository
>>  with 71 submodules, what I don't understand though is if I
>>  have a branch called 2-5-x and another called 2-4-x in each of
>>  the submodules and the superproject, is there a way to
>>  associate those?
> 
> I don't think git-svn currently knows how to import svn:externals
> properly.  Basically you'd have to do it yourself, perhaps with the
> help of something like git-filter-branch and a shell script.
> 
> The equivalent of svn:externals in git is called git-submodule, and
> it's actually much more powerful than svn:externals, because you can
> link to a *specific revision* and not just a branch.  In other words,
> I can set up my application to point at r2956 of a library, so even if
> the library changes in the future, my application always gets exactly
> that version.  (To have the app use the later version, you have to
> 'git pull' in the submodule, then make a commit in the application
> module.)
> 
> See "man git-submodule" and "man git-filter-branch" for more information.
> 
> If I'm wrong and git-svn already supports svn:externals, I'm sure
> someone will correct me :)
> 
> Have fun,
> 
> Avery

It's possible to have svn:externals point at a specific revision, but
that's not the point.  I'm convinced that submodules are the answer, I'm
just not sure how to make them work. Assume "sakai" is the superproject
and "access" is a submodule, I've done:

cd sakai
git checkout work
git submodule add ../access access

And that's cool, but then I do:

cd ../access
git checkout -b 2-5-x sakai_2-5-x  # sakai_2-5-x is an svn import
cd ../sakai
git checkout -b 2-5-x sakai_2-5-x
git submodule add -b 2-5-x ../access access

Which gives me an error about access already existing.  I'm pretty sure
I'm just not thinking about this the way git does, I blame svn for
damaging my brain.

-- 
D. Stuart Freeman
Georgia Institute of Technology

--------------040206040705080104060407
Content-Type: text/x-vcard; charset=utf-8;
 name="stuart_freeman.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="stuart_freeman.vcf"

begin:vcard
fn:D. Stuart Freeman
n:Freeman;Douglas
email;internet:stuart.freeman@et.gatech.edu
tel;work:(404)385-1473
x-mozilla-html:FALSE
version:2.1
end:vcard


--------------040206040705080104060407--
