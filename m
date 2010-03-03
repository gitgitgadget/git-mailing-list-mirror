From: =?ISO-8859-15?Q?Felix_M=F6ller?= <mail@felixmoeller.de>
Subject: git svn fetch gives Index mismatch
Date: Wed, 03 Mar 2010 22:07:35 +0100
Message-ID: <4B8ECF97.4030006@felixmoeller.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 03 22:13:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nmvsa-0008MW-66
	for gcvg-git-2@lo.gmane.org; Wed, 03 Mar 2010 22:13:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753115Ab0CCVNM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Mar 2010 16:13:12 -0500
Received: from smtprelay03.ispgateway.de ([80.67.29.28]:47665 "EHLO
	smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751779Ab0CCVNJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Mar 2010 16:13:09 -0500
X-Greylist: delayed 379 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Mar 2010 16:13:09 EST
Received: from [93.196.25.5] (helo=[192.168.178.20])
	by smtprelay03.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <mail@felixmoeller.de>)
	id 1NmvmI-0007b9-IF
	for git@vger.kernel.org; Wed, 03 Mar 2010 22:06:46 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.8) Gecko/20100301 Fedora/3.0.3-1.fc12 Thunderbird/3.0.3
X-Df-Sender: mail@felixmoeller.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141480>

Hi,

I am new to git and tried to checkout the Subversion Repository of=20
ADempiere. https://adempiere.svn.sourceforge.net/svnroot/adempiere

I get the following doing it:
> [fm@thinkpad adempiere.git]$ git svn fetch
> Index mismatch: fac38f8fdc7d816e9dd26b469e08a98428f3f2a5 !=3D 0aea771=
bc7629d194ada8bb448e863ffe7868189
> rereading e662b48c06fb9a263f717546ffbb41a39f94d597
>         M       mvcForms/db/ddlutils/postgresql/functions/round.sql
>         M       mvcForms/db/ddlutils/oracle/functions/documentNo.sql
 > ...
>         M       mvcForms/client/src/org/compiere/grid/ed/VLookup.java
>         M       mvcForms/client/src/org/compiere/print/Viewer.java
>         M       mvcForms/client/src/org/adempiere/apps/graph/Graph.ja=
va
> Couldn't find revmap for https://adempiere.svn.sourceforge.net/svnroo=
t/adempiere/branches/stable/data/hu_HU
> Couldn't find revmap for https://adempiere.svn.sourceforge.net/svnroo=
t/adempiere/trunk/data/hu_HU
> Couldn't find revmap for https://adempiere.svn.sourceforge.net/svnroo=
t/adempiere/branches/adempiere341/zkwebui/WEB-INF/src
> Couldn't find revmap for https://adempiere.svn.sourceforge.net/svnroo=
t/adempiere/branches/stable/zkwebui/WEB-INF/src
> Couldn't find revmap for https://adempiere.svn.sourceforge.net/svnroo=
t/adempiere/trunk/extend/posterita/webui/WEB-INF/src
> Couldn't find revmap for https://adempiere.svn.sourceforge.net/svnroo=
t/adempiere/trunk/extension/posterita/webui/WEB-INF/src
> Couldn't find revmap for https://adempiere.svn.sourceforge.net/svnroo=
t/adempiere/trunk/zkwebui/WEB-INF/src
> Couldn't find revmap for https://adempiere.svn.sourceforge.net/svnroo=
t/adempiere/branches/adempiere341/base/src
> Couldn't find revmap for https://adempiere.svn.sourceforge.net/svnroo=
t/adempiere/trunk/base/src
> Couldn't find revmap for https://adempiere.svn.sourceforge.net/svnroo=
t/adempiere/trunk/migration/351a-352a
> Couldn't find revmap for https://adempiere.svn.sourceforge.net/svnroo=
t/adempiere/trunk/migration/352a-353a
> merge-base e662b48c06fb9a263f717546ffbb41a39f94d597 7ac062d801daf4653=
7377154daf39e5b21a8f447: command returned error: 1

charon on IRC helped me a lot trying to debug it. I provided the=20
following operations:
# git show fac38f8fdc7d816e9dd26b469e08a98428f3f2a5
tree fac38f8fdc7d816e9dd26b469e08a98428f3f2a5

mvcForms/
# git show 0aea771bc7629d194ada8bb448e863ffe7868189
tree 0aea771bc7629d194ada8bb448e863ffe7868189

mvcForms/
# git show e662b48c06fb9a263f717546ffbb41a39f94d597
commit e662b48c06fb9a263f717546ffbb41a39f94d597
Author: tobi42 <tobi42@f8025ce2-341d-0410-ac50-9b82273f5115>
Date:   Fri Oct 23 14:06:12 2009 +0000

     minor compile fix

     git-svn-id:=20
https://adempiere.svn.sourceforge.net/svnroot/adempiere/branches/metas@=
10762=20
f8025ce2-341d-0410-ac50-9b82273f5115

diff --git a/mvcForms/client/src/org/compiere/apps/form/VInOutGen.java=20
b/mvcForms/client/src/org/compiere/apps/form/VInOutGen.java
index 9f27863..896a340 100644
--- a/mvcForms/client/src/org/compiere/apps/form/VInOutGen.java
+++ b/mvcForms/client/src/org/compiere/apps/form/VInOutGen.java
  -218,7 +218,7 @@ public class VInOutGen extends InOutGen implements=20
=46ormPanel

# git show trunk gives
> # git show trunk
> commit 7ac062d801daf46537377154daf39e5b21a8f447
> Author: teo_sarca <teo_sarca@f8025ce2-341d-0410-ac50-9b82273f5115>
> Date:   Fri Oct 23 08:14:49 2009 +0000
>
>     FR [ 2884541 ] MRequestUpdate should detect automatically the fie=
lds
>     https://sourceforge.net/tracker/?func=3Ddetail&aid=3D2884541&grou=
p_id=3D176962&atid=3D879335
>
>     git-svn-id: https://adempiere.svn.sourceforge.net/svnroot/adempie=
re/trunk@10757 f8025ce2-341d-0410-ac50-9b82273f5115
>
> diff --git a/base/src/org/compiere/model/MRequestUpdate.java b/base/s=
rc/org/compiere/model/MRequestUpdate.java
> index 00bf881..728a6fa 100644
> --- a/base/src/org/compiere/model/MRequestUpdate.java
> +++ b/base/src/org/compiere/model/MRequestUpdate.java


I am using git-1.6.6.1-1.fc12.i686.

I'd appreciate help how to get it working. Keep in mind I am a git=20
beginner...

Thanks for your help
=46elix M=F6ller
