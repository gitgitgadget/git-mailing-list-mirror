From: Caleb Marchent <cmarchent@aminocom.com>
Subject: RE: git cloning paths
Date: Wed, 25 Jul 2012 15:22:07 +0000
Message-ID: <9C3609BEC91A814BB52DBF9C41F04D1E74D159A0@uk-swa-ex02>
References: <CANmEAK_jGdzR9R=0DexC+-_0U6mb_7o_v5zSKTuhgoaYCaSiFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: Douglas Garstang <doug.garstang@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 25 17:27:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Su3Uv-00018J-9q
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jul 2012 17:27:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030217Ab2GYP1c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jul 2012 11:27:32 -0400
Received: from mail.aminocom.com ([62.255.172.253]:39712 "EHLO
	uk-swa-cas01.aminocom.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1030192Ab2GYP1b convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2012 11:27:31 -0400
X-Greylist: delayed 316 seconds by postgrey-1.27 at vger.kernel.org; Wed, 25 Jul 2012 11:27:31 EDT
Received: from UK-SWA-EX02.aminocom.com ([10.171.3.10]) by
 uk-swa-cas01.aminocom.com ([::1]) with mapi id 14.02.0298.004; Wed, 25 Jul
 2012 16:22:08 +0100
Thread-Topic: git cloning paths
Thread-Index: AQHNYHw80clB15YRYU6Dr39oh3+Ez5c6LsUQ
In-Reply-To: <CANmEAK_jGdzR9R=0DexC+-_0U6mb_7o_v5zSKTuhgoaYCaSiFQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.172.2.32]
x-exclaimer-md-config: 97205c7e-1da7-49e0-88c8-ce11b093e3e5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202166>

Hi Doug,

The method I have been using to achieve this is to create a wrapper script that does the following:

git clone -n                                   # clone, but don't checkout
cd <repo name>                        
git config core.sparseCheckout true    # configure sparse-checkout on
# echo the list of bits you want into .git/info/sparse-checkout
git checkout

Do watch out though, the interpretation of the sparse-checkout file has changed since git 1.7, I would suggest you use the latest git and record the git version as a comment in top of the sparse checkout file, in case it changes again. 

I hope this helps,

Caleb

-----Original Message-----
From: git-owner@vger.kernel.org [mailto:git-owner@vger.kernel.org] On Behalf Of Douglas Garstang
Sent: 12 July 2012 23:17
To: git@vger.kernel.org
Subject: git cloning paths

All,

I'm a relative newcomer to git and I've just inherited a setup where all of the company's code is in a single git repository. Within this repository are multiple projects. It seems that git doesn't natively allow cloning/checking out of individual paths within the repo (ie projects), which would seem to make integrating git with a continuous build system rather difficult. That is, the build system has to clone the entire repo, and therefore a change to any project will result in the entire contents of the repo being built.

Correct....?

Doug.
--
To unsubscribe from this list: send the line "unsubscribe git" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
